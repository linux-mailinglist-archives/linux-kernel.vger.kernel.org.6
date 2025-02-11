Return-Path: <linux-kernel+bounces-510223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F6A319F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4913A7D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0E26A0C2;
	Tue, 11 Feb 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z8FK0e7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32126A09A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317818; cv=none; b=dJPnBi5VwPGLtQ1PqtG0uPyjjpq05IB5VEFdcUyCkENUTsJQNq32U+MrSxDzlXaiSXF8zpqmwKfX8CYwRTTevD4Ti2r60jUENq1ltWIQSCrkMvdyc++CsPtgfnMmqyxkUlVMnO314indN6M1ULaSIQn5fpSLk/VjUD4DmqwEucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317818; c=relaxed/simple;
	bh=YDgN+Q/gh8DLcuRPv33UKVodEDylfKU06YDKLKOnDLw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ar+tWwhwFxzqhVEJ+D/fteglbeGA9Tyz/MoiG/3lWGDbA5RnO4GmC1cdc/3PGqo5h0YcuQ2ipXXSvoofANXpPIOFEyJkdI9g7ePd50gp3O8Ek7KuH4LzlxkqU2FO3whRWrl7popv6UX5qtbZryTrk9mSMRI/xYXiZhyxKO9y50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z8FK0e7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D12C4CEDD;
	Tue, 11 Feb 2025 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739317817;
	bh=YDgN+Q/gh8DLcuRPv33UKVodEDylfKU06YDKLKOnDLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8FK0e7SPnAM3cMF0w014gX4GuKSlBh8apadUkxqyGsIzVHPTST9mgaXfhe27wQua
	 yZV5XioxuYwjTVaoB87wb9qtpYI5/IqlA2kFn5PAHJYjyxBNLPjv/iBBmlmPhHoPr+
	 HcoT7dnd5MR5IE12J2+9FDd4KgN49UXYJQ4s2T8U=
Date: Tue, 11 Feb 2025 15:50:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: zhengqi.arch@bytedance.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] mm: pgtable: Unlock pml without branches when
 !start_pte
Message-Id: <20250211155016.857387cd35e19a463d779cae@linux-foundation.org>
In-Reply-To: <Z6rzC5MGG8xrjnnF@vaxr-BM6660-BM6360>
References: <20250210100948.312130-1-richard120310@gmail.com>
	<20250210163736.ed1c93a44a47e39820fb8d85@linux-foundation.org>
	<Z6rzC5MGG8xrjnnF@vaxr-BM6660-BM6360>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 14:49:47 +0800 I Hsin Cheng <richard120310@gmail.com> wrote:

> >       if (ptl != pml)
> > +out_unlock:
> >               spin_unlock(pml);
> >  }
> > _
> >
> > but that's really ugly.
> 
> I agree. Would you be so nice to suggest some test method for me so I
> can try to test how much benefit we can get from this?
> 
> If the case happens frequently enough I think it might be worth it?

I expect this error patch is basically never taken - put a printk in
there and run some tests?


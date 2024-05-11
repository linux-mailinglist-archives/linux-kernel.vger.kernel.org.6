Return-Path: <linux-kernel+bounces-176732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D08C33D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565AF1F2194E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ABE225AF;
	Sat, 11 May 2024 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A62a2Amv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21431CAAD
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715463305; cv=none; b=u9PeXdKS7Yucs0yXXkybEaasPuxNBVMW6Aj9Dwx7SQRHXTdjwdwuvFliNzifzZJjUHDJYYimwz0Ye8G3olP5kHII/vKMWH0Wn+Xrr94VlPwMflFHrBJ0imBk8crpt0SfWF7ch2H+RxKlSKNyfPExWlXvTUSoBETZQ/ABBo8EkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715463305; c=relaxed/simple;
	bh=Iz0IsilQgAUTOh74JHraqA/FaEfyfAHJHaHVkWdmv6E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T1dRZ7h90YFJTRhW5x5tlSOzJDyHZrQfb9Ofhb8XilNi0skJAv3YebUZaIEc2WVAFx6RXGNU4CFoiNemGUMriUVifo5pd4YgS4NqM1CKpLnFsecVwficO8MF8UPSZ6DSjXBEcj0/WIS6U6XrzI+T52PWFZHzjtpBktQYPCFcCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A62a2Amv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AC5C2BBFC;
	Sat, 11 May 2024 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715463305;
	bh=Iz0IsilQgAUTOh74JHraqA/FaEfyfAHJHaHVkWdmv6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A62a2AmvYG15WDk2Lh//NQ4i+S40/qUftxIqT4CKnFH7psUMnM+GvhvZuwfWrvuDF
	 d/qWM59+WzB7P5hkG2oatBCKCudQ65xE4aGZYSjOULDlvZpC9+w27+m2wB8SPzhbdr
	 vF26xZJx0B0d48BRi78l6//CdGlpwxBznJshYEMA=
Date: Sat, 11 May 2024 14:35:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: xu.xin16@zte.com.cn, david@redhat.com, shy828301@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Muchun Song
 <muchun.song@linux.dev>
Subject: Re: =?ISO-8859-1?Q?=A0[PATCH?= linux-next] mm/huge_memory: remove
 redundant locking when =?ISO-8859-1?Q?parsing=A0THP?= sysfs input
Message-Id: <20240511143504.2d5dae49d4c76e6608b7cc93@linux-foundation.org>
In-Reply-To: <Zj-XOV08WBX33OJw@casper.infradead.org>
References: <20240511144048767fdB7EqYoMHEw6A5b6FrXM@zte.com.cn>
	<Zj-XOV08WBX33OJw@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


(cc Muchun)

On Sat, 11 May 2024 17:05:13 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, May 11, 2024 at 02:40:48PM +0800, xu.xin16@zte.com.cn wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > Since sysfs_streq() only performs a simple memory comparison operation
> > and will not introduce any sleepable operation, So there is no
> > need to drop the lock when parsing input. Remove redundant lock
> > and unlock operations to make code cleaner.
> 
> i disagree that it makes the code cleaner.

Oh.  Why is that?  The end result looks nice to me and saves a bit of
text.


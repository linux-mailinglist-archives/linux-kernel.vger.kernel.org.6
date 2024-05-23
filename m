Return-Path: <linux-kernel+bounces-187957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D338CDB38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB440286F74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1384D03;
	Thu, 23 May 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wlhqS0gX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7157CF30
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494883; cv=none; b=KLF8i9RetmWPJWluHXeyswe/xLE0zazR8rscTZ9d7GpSUjGTalKXyqyDcGngASrugznzjZKu/FllcHdCbaVai3h8k6hPHTmDNSiII5xxnxicPwH4LkYMPwl3502HVDtVCOzEJz1jWVRakgwTbs5tugzQL+8wacScmDwvRwGTBwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494883; c=relaxed/simple;
	bh=mE9GWyj51oGut1mjO8n80AtwQWmF6uIioAuY8hoSOPw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TQOsuo5HW3ajmA6kIefqXnqHyiAspdbWB+hTopfaUhnyeJjWqSVwj1To/iWvFai/v9GrNZqKpDeSig2RMjQt2/uZfskds0YMo2Yp9tIbPOUHE5xv6oKcB9iQphCNU77d0vePi3T0JYH3VT2RyDpWFZiskzfqOdFw6ImU3KgBvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wlhqS0gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB994C2BD10;
	Thu, 23 May 2024 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716494882;
	bh=mE9GWyj51oGut1mjO8n80AtwQWmF6uIioAuY8hoSOPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wlhqS0gXja1OKD10IEBjBj2ZQglXL0cw+BAMcoO5G9JKX/C4gT+KCWCkVPPc1NO7G
	 bOTDh3jR/ProFCwHsfh060UqUnDHdzqrEICZ9dvR65h120/SPICAFTIO7g7R9CPQrP
	 nkWOXxUWYHNMqrN0MOFriJZ9TOQoxJZ0RJPOMw1Q=
Date: Thu, 23 May 2024 13:08:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Liu Wei <liuwei09@cestc.cn>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when
 io with IOCB_NOWAIT
Message-Id: <20240523130802.730d2790b8e5f691871575c0@linux-foundation.org>
In-Reply-To: <20240513132339.26269-1-liuwei09@cestc.cn>
References: <20240513132339.26269-1-liuwei09@cestc.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 21:23:39 +0800 Liu Wei <liuwei09@cestc.cn> wrote:

> After commit (6be96d3ad3 fs: return if direct I/O will trigger writeback),
> when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
> process context will not be blocked.
> 
> However, if the device already has page cache in memory, EAGAIN will be
> returned. And even when trying to reissue the AIO with direct I/O and
> IOCB_NOWAIT again, we consistently receive EAGAIN.
> 
> Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
> with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
> the same time.

Can't userspace do this?  If EAGAIN, sync the fd and retry the IO?



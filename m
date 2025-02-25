Return-Path: <linux-kernel+bounces-532341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DE0A44BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683801896FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9132054F4;
	Tue, 25 Feb 2025 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="pGNnBYJD"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B653205AB6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513135; cv=none; b=VOdjiFJbREIfgNnERobA/UEx7J+VTFyRQylXztrCrmosIFnxbXTqfzC8oOhlbIaYEuXtmZWXNyU8A5tGGbAmF5RLldupI4glVr5f5rehJ4VlUkKA2E4gdgUAVDLwjzq4+DY03TvR56ozG7CmKQCmY0PNm3b1NrwrSsxrVZkMBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513135; c=relaxed/simple;
	bh=rM8oiFl0tAN1qW8GKcQQjmh71k2z9lEInC6HMGtbQFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTTd6gOP0IRmckTDP5qFQJ2q6ltBfUH1WrfnoDDhreSJq0b5P9tni6vuZUJczY30UyHlBtQodoW/wUaxlv9pL6e349mXu3NA8mrPqAOt5HanLjkE9y8v45XiTNOuN3ju6I1PiOqH+257O5DO0NHBR3MIj+u2aVYwaRa05dJshVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=pGNnBYJD; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5B08040B2278;
	Tue, 25 Feb 2025 19:52:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5B08040B2278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1740513124;
	bh=RnyRVlBxxF2Db7vHMzwHnkqqdRWAY2Xsx2UsXn//kvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGNnBYJDBWtH2SSTXYass+V0GFg2OQ2RDG9Lq5tCNjl2QfytPJ4zy+dLkuUOtLaem
	 DOg57L888w9yvJ0nZOrWDaGUmKjJ5FZzVIfrWpk/aOgDx54fRHYS54EbwasF6/uiDv
	 tATru1BKg9RRXUY9iCtn8P1n5HsFxr8ZHldrPNzg=
Date: Tue, 25 Feb 2025 22:52:04 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Dave Kleikamp <shaggy@kernel.org>, 
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	voskresenski.stanislav@confident.ru, deeb.rand@confident.ru, lvc-project@linuxtesting.org
Subject: Re: [PATCH] fs/jfs: prevent potential integer overflow in
 dbMapFileSizeToMapSize
Message-ID: <yogb3soaqqg5vnon6ogryhdmmatrvrc2xwlh2exwlhyf6gnfw7@7tybsy2s52qb>
References: <20250225114110.1775745-1-rand.sec96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225114110.1775745-1-rand.sec96@gmail.com>

On Tue, 25. Feb 14:41, Rand Deeb wrote:
> In dbMapFileSizeToMapSize(), the calculation involving 'complete' and
> 'LPERCTL' can result in a 32-bit integer overflow when handling large
> filesystems. Specifically, multiplying 'complete' by LPERCTL * LPERCTL
> (1,048,576) can exceed the 32-bit integer limit if 'complete' is greater
> than approximately 2,047.
> 
> While there is no evidence that 'complete' can exceed this threshold,
> theoretically, this is possible. To ensure robustness and maintainability,
> this patch casts only 'complete' to s64 (64-bit integer) before performing
> the multiplication. This guarantees that the arithmetic is conducted in
> 64-bit space, accommodating larger values without overflow.
> 
> This change enhances the reliability of the JFS filesystem when managing
> large volumes and preemptively addresses potential overflow issues.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
>  fs/jfs/jfs_dmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index edb22cf9521a..380e73c516ee 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -4059,7 +4059,7 @@ s64 dbMapFileSizeToMapSize(struct inode * ipbmap)
>  		factor =
>  		    (i == 2) ? MAXL1PAGES : ((i == 1) ? MAXL0PAGES : 1);
>  		complete = (u32) npages / factor;

Can it really overflow the 32bit arithmetic considering how 'factor' and
'complete' values are calculated above?

/*
 * maximum number of map pages at each level including control pages
 */
#define MAXL0PAGES	(1 + LPERCTL)
#define MAXL1PAGES	(1 + LPERCTL * MAXL0PAGES)

> -		ndmaps += complete * ((i == 2) ? LPERCTL * LPERCTL :
> +		ndmaps += (s64)complete * ((i == 2) ? LPERCTL * LPERCTL :
>  				      ((i == 1) ? LPERCTL : 1));
>  
>  		/* pages in last/incomplete child */
> -- 
> 2.34.1


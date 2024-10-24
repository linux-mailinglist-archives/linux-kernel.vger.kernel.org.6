Return-Path: <linux-kernel+bounces-379803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7C9AE401
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE141F244C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57EC1D0B82;
	Thu, 24 Oct 2024 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TJrbcQ8D"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD81C878A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769599; cv=none; b=CVvaFWNjltNOfPQMnTSLkiOwZt+2LS2rQVho5jPVUFxgInJaJ5NJQZJTCj1aO3ZOQQp6Ry+Q0DMwxAT5nCb6T79xHh8g/rBflXYHrdzMghKBAfOS+Qzsgisu+d+6RXyOgy1KZulHn0XBF/7WIbwgrVcmx6j6DeCWiqiquIHFnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769599; c=relaxed/simple;
	bh=uxxha5CoSlXs0lL1JktSCRQ2sdEvIF88JesL7nMzplg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCZk8ApP1uABPjnZXVceBk9HHsLfy7iDuEYFGgxFl8Q0EbXYNlRmzZlWC/Bz8A5ZYvUsXnMlO83wHwho0ERL7g2q0RAaX+pOm/vtD5RJD5/fvirIHScKpwxE/Juct2Lo8DroDrBHTwNlb2MO5KyiKy2D0vJqwzIFy5eIuqyCl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TJrbcQ8D; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 07:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729769594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NK3w/fF9wXIUILOnifbE5ISwxwg6DoLKLjlWnmFwHWc=;
	b=TJrbcQ8D505ClFdqAJ0276+gNflp29OWI7q7czuNH9xEQlw4KWr9I22FUj7Ex5Y1bA1Jo4
	18xAgql8BEJcZ5uR3zBl54UG9mLSQnjdk5U9LGpIDFDwpom7O81WV9JSsY5ujgLAgL/n8r
	Z9JUocg1enX00pcUv0Zg1OG6PJkx8iw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: manas18244@iiitd.ac.in
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anup Sharma <anupnewsmail@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: Add missing btree_bitmap_shift check in
 bch2_dev_btree_bitmap_marked_sectors
Message-ID: <k5znyayne747jcqd4ljxakpwky35az65ahareqhlppj73dvg2t@qypyy6ibaxdg>
References: <20241022-fix-missing-cond-bcachefs-v1-1-064a40e55610@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-fix-missing-cond-bcachefs-v1-1-064a40e55610@iiitd.ac.in>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 22, 2024 at 08:55:32PM +0530, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The syzkaller bug triggers BUG_ON assertions in
> __bch2_dev_btree_bitmap_mark. btree_bitmap_shift is checked in
> bch2_dev_btree_bitmap_marked_sectors prior to this. But only one out of
> two assertions is checked. This patch adds the other as conditional.
> 
> Reported-by: syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e8eff054face85d7ea41
> Signed-off-by: Manas <manas18244@iiitd.ac.in>
> ---
> The syzkaller bug[1] triggers BUG_ON assertions in
> __bch2_dev_btree_bitmap_mark.

The validation in validate_member() just needs to be fixed (and why 57?
that should be a constant, not a magic number).

> 
> btree_bitmap_shift is checked in bch2_dev_btree_bitmap_marked_sectors
> prior to this. But only one out of two assertions is checked. This patch
> adds the other as conditional.
> 
> A previous discussion about adding conditional in
> bch2_dev_btree_bitmap_marked_sectors is here[2].
> 
> [1] https://syzkaller.appspot.com/bug?extid=e8eff054face85d7ea41
> [2] https://lore.kernel.org/all/9ec25394-3d89-41b3-b62e-2d522cdc7319@huawei.com/
> ---
>  fs/bcachefs/sb-members.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/bcachefs/sb-members.h b/fs/bcachefs/sb-members.h
> index 762083b564ee5909071eb4235c3d5cd6e72ee519..3141791491928930a707a6a16579c6d2e11e3700 100644
> --- a/fs/bcachefs/sb-members.h
> +++ b/fs/bcachefs/sb-members.h
> @@ -347,12 +347,16 @@ void bch2_dev_errors_reset(struct bch_dev *);
>  static inline bool bch2_dev_btree_bitmap_marked_sectors(struct bch_dev *ca, u64 start, unsigned sectors)
>  {
>  	u64 end = start + sectors;
> +	u8 bitmap_shift = ca->mi.btree_bitmap_shift;
>  
> -	if (end > 64ULL << ca->mi.btree_bitmap_shift)
> +	if (bitmap_shift > 57)
> +		return true;
> +
> +	if (end > 64ULL << bitmap_shift)
>  		return false;
>  
> -	for (unsigned bit = start >> ca->mi.btree_bitmap_shift;
> -	     (u64) bit << ca->mi.btree_bitmap_shift < end;
> +	for (unsigned bit = start >> bitmap_shift;
> +	     (u64) bit << bitmap_shift < end;
>  	     bit++)
>  		if (!(ca->mi.btree_allocated_bitmap & BIT_ULL(bit)))
>  			return false;
> 
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241022-fix-missing-cond-bcachefs-a889f51e8aa2
> 
> Best regards,
> -- 
> Manas <manas18244@iiitd.ac.in>
> 
> 


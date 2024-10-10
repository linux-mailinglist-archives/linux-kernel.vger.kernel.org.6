Return-Path: <linux-kernel+bounces-358114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FA5997A58
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B474D1F23F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8003C1CFB9;
	Thu, 10 Oct 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bA2yEOS9"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D814293
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525841; cv=none; b=tW6P9Z/tuYJUqiI+IxH3vS/I33Q5MlLjSgFzukkaKIPC3BFp6pDPaLMkqNQaHYw3CMD/XdPHtqQPf7bUn6Zi8gy7lzn0ku2O9ECyDZXSixoHS2ebC9DsicX5O+kXaz8pbjKewBQ5nLP/StDf8Wnf7yusbuvr7KZWaUrjwOZJCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525841; c=relaxed/simple;
	bh=BDjxCKFfyLilIFJFYy6/pxzquUHxABEXXsUrxbro9vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz4XRbo+uNFU+1eplSz7OUK8L3EUQE6RrphDPui3HOqxDlCRn9T7s85sWr/51CT36sQqQ3RSzHXGQchoJs6BuOovJe69+E/+WI4H9xz4OMUv35BLkp3RPIhZEe+69C7qF//mZ88lXK5bRXkygJvgmRkkbylKBEKfFk3Cs+DeXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bA2yEOS9; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Oct 2024 22:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728525837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQLc8O+ab0p95H3jJhE8eF6aq82ovQFxvMQYryqmvSY=;
	b=bA2yEOS9bmkh2ml8BexztiznNDsCJd0kgGNykZsrxz7I9U2g2Y7dHb+D9G1CeMOWV0GXGL
	a+wSnToBW/fuTjcnVNhk8Ju8GYacMYFrbHQhn2Ofopio6evpqJPOUza+cO6eDCckbgA1NX
	QFffIlSnOPoYtZwW30EABR8+a8uYceU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: zhaomengmeng@kylinos.cn, lihongbo22@huawei.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bcachefs: Fix shift-out-of-bounds in
 bch2_stripe_to_text
Message-ID: <jvqgq5ekxbeims7qolka5xewgwwsdo5okkxvjfkbyenr6rk2r3@qbrg2klzzutp>
References: <20241009140755.725629-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009140755.725629-1-zhaomzhao@126.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 09, 2024 at 10:07:55PM GMT, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> syzbot report a shift-out-of-bounds issue:
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in fs/bcachefs/ec.c:147:2
> shift exponent 108 is too large for 32-bit type 'unsigned int'
> ----
> Here s.csum_granularity_bits = 108, so shift is impossible for unsigned
> int. To fix, add a check in bch2_stripe_validate() to bail out, it has
> same checking logic with ec_stripe_key_init().
> 
> Reported-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com
> Tested-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f8c98a50c323635be65d
> Suggested-by: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
>  fs/bcachefs/ec.c      | 6 ++++++
>  fs/bcachefs/errcode.h | 4 +++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/ec.c b/fs/bcachefs/ec.c
> index 564841e5a24b..f6a02123144d 100644
> --- a/fs/bcachefs/ec.c
> +++ b/fs/bcachefs/ec.c
> @@ -114,6 +114,12 @@ int bch2_stripe_validate(struct bch_fs *c, struct bkey_s_c k,
>  	const struct bch_stripe *s = bkey_s_c_to_stripe(k).v;
>  	int ret = 0;
>  
> +	if (s->csum_granularity_bits >= ilog2(le16_to_cpu(s->sectors))) {
> +		bch_err_ratelimited(c, "stripe csum gran bits %u too big",
> +				    s->csum_granularity_bits);
> +		return -BCH_ERR_stripe_csum_granularity_bits_too_big;
> +	}
> +

that should be a bkey_fsck_err_on(), and you'll add to the enum in
sb-errors_format.h

>  	bkey_fsck_err_on(bkey_eq(k.k->p, POS_MIN) ||
>  			 bpos_gt(k.k->p, POS(0, U32_MAX)),
>  			 c, stripe_pos_bad,
> diff --git a/fs/bcachefs/errcode.h b/fs/bcachefs/errcode.h
> index 26990ad584d5..83659cdb93c8 100644
> --- a/fs/bcachefs/errcode.h
> +++ b/fs/bcachefs/errcode.h
> @@ -270,7 +270,9 @@
>  	x(BCH_ERR_nopromote,		nopromote_enomem)			\
>  	x(0,				invalid_snapshot_node)			\
>  	x(0,				option_needs_open_fs)			\
> -	x(0,				remove_disk_accounting_entry)
> +	x(0,				remove_disk_accounting_entry)		\
> +	x(EINVAL,			stripe_csum_granularity_bits_too_big)
> +
>  
>  enum bch_errcode {
>  	BCH_ERR_START		= 2048,
> -- 
> 2.43.0
> 


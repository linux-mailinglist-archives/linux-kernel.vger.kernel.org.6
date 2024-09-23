Return-Path: <linux-kernel+bounces-335002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE33397DF8C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 01:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDFF28214C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135D1547ED;
	Sat, 21 Sep 2024 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u56iqoH/"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA517374F6
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726962099; cv=none; b=ggxrpRYUxOyQyQNFi0fLYKx+DEsFhM8DxoKzE1Ds4XGUadK3wA/mFLSRrbuaFQns6XpPaeHjmpglk0alnW7VVVOZG3IFXvCLqdOw99cY+xQdbPYyEqgnl272t2DMxyrr7QDD4HOqEBxNEPNkX1xlqbEqOujGM24k6q7vGx7DYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726962099; c=relaxed/simple;
	bh=fhwJbhxkY3T/MW8KSVYu2P10ATpUyzyXY1RdEZy9VYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtN5PP+PGzcJkIBSp+e3gleMQ8cYfeZyEqhP19cLGtla4zaw2yzWhR2zOCCmFv75WdEnt3DPndVebRrJwIur4XdiRri2AztO0Hy2i4CKGO5sOHMDMBUS3YVw8TdgAbwtUvSDw3zuyMMyJ1vX+BbZnO8hTF2zH06cLtquSZ2QYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u56iqoH/; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 21 Sep 2024 19:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726962094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5CZ7hdJ51qRUpd4X36zXx5RxIk6agBkno6+AyZQ47Yg=;
	b=u56iqoH/gYv0hKHrvCyXVmMWEyxjw5wNdknQ7SJaQ00zy7pfWlVxmaaxBzh0HvXygtiqDC
	wo9cqiNzoWaL5TOkvCPPNwJFYYiR44xG2BDlCHZFoPD5wGcHfqQfI5A/VMvHkHwV3ElFMU
	zhwQb4vvtNKuunoypFQgmUbqM9bukLc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] bcachefs: Fix NULL pointer dereference in
 bch2_opt_to_text
Message-ID: <kipwon7rswbzlyafdkbnhmv2qy2rvgdifrjjtokm7zz5pll4ur@wwkxb4c4scs5>
References: <20240921232454.42975-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921232454.42975-1-pvmohammedanees2003@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 21, 2024 at 11:24:54PM GMT, Mohammed Anees wrote:
> In this patch, I added a proper bounds check to avoid a potential NULL
> pointer dereference when opt->choices[v] is accessed in the
> bch2_opt_to_text function. This ensures that v is within the valid
> range of choices.
> 
> Reported-and-tested-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=37186860aa7812b331d5
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
> 
> v2:
> - Replaced pr_err with prt_printf as suggested.
> - Added the bounds check on opt->choices before accessing it.
> 
>  fs/bcachefs/opts.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
> index e10fc1da7..9bb15694d 100644
> --- a/fs/bcachefs/opts.c
> +++ b/fs/bcachefs/opts.c
> @@ -420,8 +420,12 @@ void bch2_opt_to_text(struct printbuf *out,
>  	case BCH_OPT_STR:
>  		if (flags & OPT_SHOW_FULL_LIST)
>  			prt_string_option(out, opt->choices, v);
> -		else
> -			prt_str(out, opt->choices[v]);
> +		else {
> +			if (v < opt->min || v >= opt->max - 1)
> +				prt_printf(out, "(invalid option %lli)", v);
> +			else
> +				prt_str(out, opt->choices[v]);
> +		}

For consistency, the bounds check should come first (applying in the
OPT_SHOW_FULL_LIST case as well) - also, kill the nested if clauses,
this all works with chained if else.

Sorry for dribbling out the review feedback, that should be
everything...


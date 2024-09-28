Return-Path: <linux-kernel+bounces-342701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4A9891E8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 00:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC27B23BDF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A6187859;
	Sat, 28 Sep 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KdUQgW6Q"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E42940F
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727562428; cv=none; b=MgQyGebsACV2LGQI+0ciNeIcu7m4w73U11OsJ62fQUyjBTHSIEcAP3ImgMnkJWhDjJ+nIyaVbDTDZRjVB0q/czl6MEYgBj99crJMzDCNEM2tyFQ3W0qFLQjqY+TaPLXQzTQIn3UYG4O3OOrY5UrAMVo2u603NXIE7rZapTqyClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727562428; c=relaxed/simple;
	bh=IpMVgl8OfeNzuCGL9dgyCm8C+LUoNDm4dPs5qPr0vs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6nP0HPx4J1vSBzoWenkskCeHLLcxB1dcTFPxuhIWawgBTg4khKQs6Zc/RzY/oyuEKG56CvWOtVaPMPX2Zgng3T1xwNYwl/ZlwWWpmAOblYIAzecbFUoPfmG1Fu+qSV/P4OTRqXdrcCIRYa19wki+VmaCrbdKwqa6tG8RIekVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KdUQgW6Q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Tpgb3eH2OqbcivhrhwLchq0LO1TD/5iLs0OHvgtW8U=; b=KdUQgW6QBPshS5+H5KBPwxEjg2
	T3Tzl4R7fbgrJzPT67AyCvVCkSVEb2V8FH1ljH8kqEdTWWeIgxewxOumZma5Yn/M4AMNTfkOis0Yo
	8v6vYqFGjwp8FYU1Yypk53P9zlJPgjeZ4mUUsFNSsCLfjhXMp+Gk9IFvvWwnxwjEAnUd+XuohV9vR
	O22tcEU1xt3+Ga+4aAyILCDTVTfICrGFNV4zqar+0D9lA3nB00iGdRpwF13AD9o4D8q9doX9mAxAp
	Z5OAPHk8IWL8QujdzfjWQsbzlnHnPiNirx6aJc9hTil0QKp5z/IbGC8EO/kDznEyDVHoEwb6Fn3aR
	V2BQt4UQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sufu2-0000000GI3d-3Bm5;
	Sat, 28 Sep 2024 22:27:02 +0000
Date: Sat, 28 Sep 2024 23:27:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [heads-up] Re: [PATCH] reset: Further simplify locking with guard()
Message-ID: <20240928222702.GX3550746@ZenIV>
References: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 27, 2024 at 04:02:32PM +0200, Philipp Zabel wrote:
> Use guard(mutex) to automatically unlock mutexes when going out of
> scope. Simplify error paths by removing a goto and manual mutex
> unlocking in multiple places.

And that, folks, is a live example of the reasons why guard() is an
attractive nuisance.  We really need a very loud warning on
cleanup.h stuff - otherwise such patches from well-meaning folks
will keep coming.

> @@ -1041,29 +1036,27 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
>  		}
>  	}
>  
> -	mutex_lock(&reset_list_mutex);
> +	guard(mutex)(&reset_list_mutex);
>  	rcdev = __reset_find_rcdev(&args, gpio_fallback);
>  	if (!rcdev) {
>  		rstc = ERR_PTR(-EPROBE_DEFER);
> -		goto out_unlock;
> +		goto out_put;
>  	}
>  
>  	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
>  		rstc = ERR_PTR(-EINVAL);
> -		goto out_unlock;
> +		goto out_put;
>  	}
>  
>  	rstc_id = rcdev->of_xlate(rcdev, &args);
>  	if (rstc_id < 0) {
>  		rstc = ERR_PTR(rstc_id);
> -		goto out_unlock;
> +		goto out_put;
>  	}
>  
>  	/* reset_list_mutex also protects the rcdev's reset_control list */
>  	rstc = __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
>  
> -out_unlock:
> -	mutex_unlock(&reset_list_mutex);
>  out_put:
>  	of_node_put(args.np);

Guess what happens if you take goto out_put prior to the entire thing,
in
                ret = __reset_add_reset_gpio_device(&args);
		if (ret) {
			rstc = ERR_PTR(ret);
			goto out_put;
		}
That patch adds implicit mutex_unlock() at the points where we leave
the scope.  Which extends to the end of function.  In other words, there is
one downstream of out_put, turning any goto out_put upstream of guard() into
a bug.

What's worse, that bug is not caught by gcc - it quietly generates bogus code
that will get unnoticed until we get an error from __reset_add_reset_gpio_device()
call.  At that point we'll look at the contents of uninitialized variable and,
if we are unlucky, call mutex_unlock() (with hell knows what pointer passed to it -
not that mutex_unlock(&reset_list_mutex) would do us any good at that point, since
we hadn't locked it in the first place).

Folks, that kind of cleanup patches is bloody dangerous; even something that
currently avoids that crap can easily grow that kind of quiet breakage later.


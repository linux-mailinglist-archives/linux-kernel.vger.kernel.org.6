Return-Path: <linux-kernel+bounces-255402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5C0934060
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FA02832DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5034181BBA;
	Wed, 17 Jul 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PWKGcvS4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271A5B05E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233547; cv=none; b=FXRo16KA9PmRIu+e9GXgboQca9S3y/3grWDo1eNPZLgpUJdEXxP4GnhdlclXdy4Xg/9epfy+4l7cM7kbByEuIJxYauG2OhksFAT/TYWqttbb1pHE28+EGLtIlZxq2HmaAvwnI2uTqlo4qYJoWxeDcnC++Qg1ZiBEB7xPHa8E154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233547; c=relaxed/simple;
	bh=sycsrk1qbMInFpBFCo/eo6DF97u2tJbXnRgyrP9bYAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8yt3wIQJNqGFQuQGEdQR3RgS6j8CgATowxIWfvbnyBeO5a0yzllaAxCOkqgCtFTuXq8c/M47OOqTbsvX5qxkDvRQ+8jePd+e5Y6bhH+gpYaSwipym5VlDhssU+20CHzF0bmEwbGb8cVvLj4MTSCH9FJtPf/x1G7t89TETR9uO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PWKGcvS4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Byyt/G4FG3dBwo6FphWn68cOZO3ZKBoSOM3VbH/6tpY=; b=PWKGcvS49m+WMKTbZJI5Ia86yB
	gkchnI3oTzqqnYqVsY7PH0pISabJa7YpcaKH8awbAPB6izyilci+ZFqlr2ckehK2ay/I18iNBBepy
	0jXNXfrSU9Nuoe1Y9bG4fMMqMt1x4TCMhldNcDXXv8X71QEXS/xhJAT03ezBe8TwgjCakRpFrXYRL
	nUpHhwK051T+3hBwK5ULNemOY45MDrBuUcyxysKx3uev/PXot1wxHWc5cDnWB0KgcHaHrZN7lEmyN
	7HX3wS1jiEmwUhKao2XA3FX/IMb89Qb1chAhi3G9nLTLFgFAXaYdam9Kll/CHfeQNg0TR/U45rYWM
	+aS2qGxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU7TG-00000002MPc-09oU;
	Wed, 17 Jul 2024 16:25:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1FC48300362; Wed, 17 Jul 2024 18:25:37 +0200 (CEST)
Date: Wed, 17 Jul 2024 18:25:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refcount: Report UAF for refcount_sub_and_test(0) when
 counter==0
Message-ID: <20240717162536.GH26750@noisy.programming.kicks-ass.net>
References: <20240717130023.5675-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717130023.5675-1-petr.pavlu@suse.com>

On Wed, Jul 17, 2024 at 03:00:23PM +0200, Petr Pavlu wrote:
> When a reference counter is at zero and refcount_sub_and_test() is invoked
> to subtract zero, the function accepts this request without any warning and
> returns true. This behavior does not seem ideal because the counter being
> already at zero indicates a use-after-free. Furthermore, returning true by
> refcount_sub_and_test() in this case potentially results in a double-free
> done by its caller.
> 
> Modify the underlying function __refcount_sub_and_test() to warn about this
> case as a use-after-free and have it return false to avoid the potential
> double-free.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> 
> Motivation for this patch is an earlier kretprobe problem described at:
> https://lore.kernel.org/linux-trace-kernel/92cff289-facb-4e42-b761-6fd2515d6018@suse.com/

Well that's good fun.... :/

The patch seems sane enough to me, I don't think add() has a similar
issue, adding 0 is still daft, but as is I don't think it will actually
misbehave. Notably add_not_zero(0) will fail when 0 and succeed (with
no effect) when !0.

Still, adding or subtracting 0 is pretty stupid, so perhaps we should
more explicitly warn on that?

Anyway, for this patch:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  drivers/misc/lkdtm/refcount.c | 16 ++++++++++++++++
>  include/linux/refcount.h      |  4 ++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
> index 5cd488f54cfa..8f744bee6fbd 100644
> --- a/drivers/misc/lkdtm/refcount.c
> +++ b/drivers/misc/lkdtm/refcount.c
> @@ -182,6 +182,21 @@ static void lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE(void)
>  	check_negative(&neg, 3);
>  }
>  
> +/*
> + * A refcount_sub_and_test() by zero when the counter is at zero should act like
> + * refcount_sub_and_test() above when going negative.
> + */
> +static void lkdtm_REFCOUNT_SUB_AND_TEST_ZERO(void)
> +{
> +	refcount_t neg = REFCOUNT_INIT(0);
> +
> +	pr_info("attempting bad refcount_sub_and_test() at zero\n");
> +	if (refcount_sub_and_test(0, &neg))
> +		pr_warn("Weird: refcount_sub_and_test() reported zero\n");
> +
> +	check_negative(&neg, 0);
> +}
> +
>  static void check_from_zero(refcount_t *ref)
>  {
>  	switch (refcount_read(ref)) {
> @@ -400,6 +415,7 @@ static struct crashtype crashtypes[] = {
>  	CRASHTYPE(REFCOUNT_DEC_NEGATIVE),
>  	CRASHTYPE(REFCOUNT_DEC_AND_TEST_NEGATIVE),
>  	CRASHTYPE(REFCOUNT_SUB_AND_TEST_NEGATIVE),
> +	CRASHTYPE(REFCOUNT_SUB_AND_TEST_ZERO),
>  	CRASHTYPE(REFCOUNT_INC_ZERO),
>  	CRASHTYPE(REFCOUNT_ADD_ZERO),
>  	CRASHTYPE(REFCOUNT_INC_SATURATED),
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index 59b3b752394d..35f039ecb272 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -266,12 +266,12 @@ bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
>  	if (oldp)
>  		*oldp = old;
>  
> -	if (old == i) {
> +	if (old > 0 && old == i) {
>  		smp_acquire__after_ctrl_dep();
>  		return true;
>  	}
>  
> -	if (unlikely(old < 0 || old - i < 0))
> +	if (unlikely(old <= 0 || old - i < 0))
>  		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
>  
>  	return false;
> 
> base-commit: 2df0193e62cf887f373995fb8a91068562784adc
> -- 
> 2.35.3
> 


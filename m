Return-Path: <linux-kernel+bounces-399834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F759C04F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C01D1C23A30
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E720C474;
	Thu,  7 Nov 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XeOwG6qy"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE71DFE2C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980474; cv=none; b=KASYiZGP7Uodb+FOTX3c0T1nQiNdJPWkVVFYT28FBl39zRn2lP6kSli3lCcrgZBwfqH/6rFzSALQY4eRSp/2SliCIyZA16DvN8QH7x88Z16uyS5fOoDm2plSgkdrQUiNqKOwjHitSe1E8lZFW+dCWyPaC71jCBdkZeEO0LZUrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980474; c=relaxed/simple;
	bh=yGU7iTAWaJabTpK9R+DM9rgnozn2ikReDIAPJ/RK+JU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GCDA/qUGL824yMmnhlaSmb5TgAN6G8tkyOlVRuLr7mu0UPLgE9MOeMKizK379GXMkmV+6o2lRNlVZ/YK4nZrPN1FSyX6alGnxhC5c0m6q2JojeKRuAYSbaoZ2dVWjNUi4/XJj95Y384fWFL7EifBGKJq98s36zptPq8VnQkhkKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=XeOwG6qy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730980467;
	bh=isnKO7lKL0QWK7slYWLO5kTqSbzMU+FYZ7MF91y2dP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XeOwG6qydOK8MXn0X2TY88FZnwKiqzb6yxFxekrL4L/7H+6NJjsn2FoQjqvMk7XXs
	 KKABadXuNh8Bc3tJqw+DTv9y1Y1jOITOz+YICbJ36kge/p0pY6Yds/7Mklk+M4yPrJ
	 bSDp7FcVQtmmsyVMnb/HAUXUNYqfwegM0m6q153Tn7uCfaU8wnghLajrIFxhv1895d
	 1zvTCymTBBaAkwdhOv6xjDld7Z/W+jtR44HYZOIv2QtT66b9LhR2f7lfpXjl5OY15Z
	 oUnrCmIWty9tD/98UPdFpXuq9kQ2JcXtTu4Cm24xMjjGcy1ThNCc1yjbDR/CJefIog
	 g+gOjDh/hsvQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XkgTv32Xkz4wc4;
	Thu,  7 Nov 2024 22:54:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc/pseries: Fix KVM guest detection for
 disabling hardlockup detector
In-Reply-To: <20241105132734.499506-1-gautam@linux.ibm.com>
References: <20241105132734.499506-1-gautam@linux.ibm.com>
Date: Thu, 07 Nov 2024 22:54:29 +1100
Message-ID: <87ed3ncl8q.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gautam Menghani <gautam@linux.ibm.com> writes:
> As per the kernel documentation[1], hardlockup detector should be
> disabled in KVM guests as it may give false positives. On PPC, hardlockup
> detector is broken inside KVM guests because disable_hardlockup_detector()
 
Isn't it the opposite? Inside KVM guests, the hardlockup detector should
be *disabled*, but it's not it's *enabled*, due to this bug.

ie. it's not broken, it's working, but that's the bug.

> is marked as early_initcall and it uses is_kvm_guest(), which is
> initialized by check_kvm_guest() later during boot as it is a
> core_initcall. check_kvm_guest() is also called in pSeries_smp_probe(),
> which is called before initcalls, but it is skipped if KVM guest does
> not have doorbell support or if the guest is launched with SMT=1.

I'm wondering how no one has noticed. Most KVM guests have SMT=1.

> Move the check_kvm_guest() call in pSeries_smp_probe() to the initial
> part of function before doorbell/SMT checks so that "kvm_guest" static
> key is initialized by the time disable_hardlockup_detector() runs.

check_kvm_guest() is safe to be called multiple times so
disable_hardlockup_detector() should just call it before it calls
is_kvm_guest(). That should avoid future breakage when the order of
calls changes, or someone refactors pSeries_smp_probe().

Can you identify the commit that broke this and include a Fixes: tag
please.

cheers

> [1]: Documentation/admin-guide/sysctl/kernel.rst
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/smp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index c597711ef20a..516c7bfec933 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -199,6 +199,13 @@ static __init void pSeries_smp_probe(void)
>  	else
>  		xics_smp_probe();
>  
> +	/*
> +	 * Make sure this is called regardless of doorbell/SMT status, as
> +	 * we disable hardlockup detector in an early_initcall where we need to
> +	 * know KVM status for disabling hardlockup detector in KVM guests.
> +	 */
> +	check_kvm_guest();
> +
>  	/* No doorbell facility, must use the interrupt controller for IPIs */
>  	if (!cpu_has_feature(CPU_FTR_DBELL))
>  		return;
> @@ -207,8 +214,6 @@ static __init void pSeries_smp_probe(void)
>  	if (!cpu_has_feature(CPU_FTR_SMT))
>  		return;
>  
> -	check_kvm_guest();
> -
>  	if (is_kvm_guest()) {
>  		/*
>  		 * KVM emulates doorbells by disabling FSCR[MSGP] so msgsndp
> -- 
> 2.47.0


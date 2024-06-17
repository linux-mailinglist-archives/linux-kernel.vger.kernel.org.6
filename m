Return-Path: <linux-kernel+bounces-218369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B141C90BD73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EF72822F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84EA1991DF;
	Mon, 17 Jun 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LFTH57Tj"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D5225AE;
	Mon, 17 Jun 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663027; cv=none; b=p8lcFz6i+EqDcdqEnMJXv1KXBqhG3rd0yvs7wzfc3+95yEaR9/UJv/gZ9IUQjaGYwhsMrQZZ0apnekoUHPh2/Y5vz/+l/nDsnVoe+EXg+kX4eG0Rrb3Irt1Jog5EEJe/XQuOkWu+34oVISpIGjq2+ALXilQrnLmRgzwiPqG/AnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663027; c=relaxed/simple;
	bh=+m1FI4YZWYTG5dHJwdsfDDQP9/BhQmKih3ks71du5w4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xu74FbkNmPdxJacuYEfF4x+IltXD2QuuLZ4ceMVcgXKX0cvbEiDVhBgeYlWYkdhI5TZjLb0Rl1cBhcOZb11YboTPAqBVR3xV0rBwqTV5a8wTA1NDbCOlUN9VXPxESSEAQXRrqqOmDeaPpVAJZ3r6YJY+9aMf6DmMll/Let3orKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LFTH57Tj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BB64645E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718663024; bh=6HZvwV8D7nXzfDf1P32daZRDFpvUQkxvphQYZ93xvVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LFTH57TjzW+PjfoGXJczqDrgZV5Z1pxzSXYaclWmTL3lNjz+TL1aUED6B6frxTLq7
	 k/FZwneGrmrmD5RIJN0Fk2Pcntl/ReEMXXknGQ/p7BSD2dP3oI3ikx307NWhcnhJ9z
	 PJRFve2fB6GvfAY1QNWAaerYHxve20y74dyjANLmiAX21zgJbXFsnrvX6YWaVOzEaX
	 nPoiV2DDqcSbe92zZ99xFk1u+xq6oHbwTVHCGRE7p7yaIRTQ2pVSTqdgrdfJjLKVIK
	 NvMg5mSyQncnqhdoR/8/GVPca2Gv1A04Rn5Z+56z74Xk1FqFxX0TRWdoLtI3gY31Sp
	 Er3NJTVSq1cCg==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BB64645E08;
	Mon, 17 Jun 2024 22:23:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: Remove "mfgpt_irq=" from the
 kernel-parameters.txt file
In-Reply-To: <20240614090306.561464-1-thuth@redhat.com>
References: <20240614090306.561464-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 16:23:43 -0600
Message-ID: <8734pbi4y8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> The kernel parameter mfgpt_irq has been removed in 2009 already in the
> commit c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code").
> Time to remove it from the documentation now, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a9b905bbc8ca..756ac1e22813 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3426,10 +3426,6 @@
>  			deep    - Suspend-To-RAM or equivalent (if supported)
>  			See Documentation/admin-guide/pm/sleep-states.rst.
>  
> -	mfgpt_irq=	[IA-32] Specify the IRQ to use for the
> -			Multi-Function General Purpose Timers on AMD Geode
> -			platforms.
> -
>  	mfgptfix	[X86-32] Fix MFGPT timers on AMD Geode platforms when
>  			the BIOS has incorrectly applied a workaround. TinyBIOS
>  			version 0.98 is known to be affected, 0.99 fixes the

So I am unable to get this one to apply; which kernel version did you
base it on?

Thanks,

jon


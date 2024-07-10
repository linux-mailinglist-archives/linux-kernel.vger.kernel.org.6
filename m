Return-Path: <linux-kernel+bounces-247777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C86192D468
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AC31F24534
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1D193477;
	Wed, 10 Jul 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Rd+fKm6U";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="jNpoVCfx";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="L/N4FYyz"
Received: from e2i411.smtp2go.com (e2i411.smtp2go.com [103.2.141.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D20193455
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622453; cv=none; b=JdvmQz0WDjaYQg4RWvOL0noKzQ6mJFFQniio2tkZ9Phd7cf6xyCN2zpVZ4p7hjHnw1Pjh0782ma+d8iA/aVu2sEbFJ1dwB9z+dJWm4uawLXBdc2xYJrT/W9mDy6rAZNDL9Qmyc+WZLTDEgMoDVQ8jXTS+AEEH/TCtWh3Gz+DrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622453; c=relaxed/simple;
	bh=cj4lxGGMEAnw4XEUD3CY1TRsj+/DeeAZQQsYN+clMFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR9jIk5PaOXsvAVavjRn0R+C49Rz/5bH1a/HFGGzWfxv20kENFZcXGPdf6js5Z2qgF9hs5kA1Yps5exNO6bGUavp1KCY3t+9tNjNd6EwQHPhnTKELbT+RTlYalH4D3Kbfz02bWUm79Hph+ECfCmOWjUY+/FaOUbSGVZL5gQ+f7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Rd+fKm6U reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=jNpoVCfx; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=L/N4FYyz; arc=none smtp.client-ip=103.2.141.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1720623346; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=ymPENd0Hkx89Fqve76Y+gFUwa1asNPWiYfEhrftdTnY=; b=Rd+fKm6UtHXbgg/FQ8B6/wiE+n
	pNwKQWN7EB/jusQJUXlYpnjwvjrstMfcskKboLifCsoDKFkyrjJjb3Zxyvs2zABbFhi/aoMcHeFkc
	ekLN+GpYarjGOKS62MRjTTA0+N3QhwdB4TZyUleA6c7Fo1mviVakt5AIqh/txmWYugSOmjoVf8YQq
	dtANeFmC7Ntc8nBtoiGMBaWbll/oyjRAUyLErnaIHGWlAUpkZbSoRxYTZAHhLA6KzmpUiie96AHte
	pCGmSqsrDM8D13wWPfvcFjHIEIMR+h0FDi4Y8+/iWl8oQmz00R4PQQnmg8SLEEgMKgn+4nP9PgQdC
	TracvgzA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1720622446; h=from : subject :
 to : message-id : date;
 bh=ymPENd0Hkx89Fqve76Y+gFUwa1asNPWiYfEhrftdTnY=;
 b=jNpoVCfx2uhnsdk4vzZkrTHqgDhX7PSdxFuP01fRFYuCtTO7EIrQjwMvOjIDM5CVozJNv
 OAaoAxQy9NWmfTay9aVCpsxBEGY3m7rGz8RQ9zbM2abAMVM4hMtRa3bagSpk0H+prYku+8C
 cHXHvT5YHGSftjjVVgjle+F1T51rzxy9dyu8Tuu9OC1rpp/NtfqgqA4KOeDP//jXV6qgMeW
 jwIM4ZgonCUQEgrCeOoe4fo4K17SlzHbp5qLtG+OmufNkuYcCH1CNIuCEiZvrptPBvV1whg
 ufk1a3h2sX9pFGXbdYsM++0saOUA2GVUoaBVd95Ky/bBqKaQM95HsjNX2kKA==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sRYUG-TRjwo6-8I; Wed, 10 Jul 2024 14:40:05 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sRYUE-4o5NDgrg3Tu-o6qn; Wed, 10 Jul 2024 14:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1720622401; bh=cj4lxGGMEAnw4XEUD3CY1TRsj+/DeeAZQQsYN+clMFY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L/N4FYyzCJnJi8w0aXxS+6lz68yGte6dm4b5VRdK6JJ5vDmA860LWK1WPm2qfs4hb
 UJK4Bq2TJFRNbLwdzNtzlLnGv2qKyfAKf4KjPbviquzcQxJftkwtu2KijcyAdViA1r
 IxNRABPh1XMoGrM+1jKufvD5qTTlbA13sdGYaSU8=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 394163E8DB; Wed, 10 Jul 2024 16:40:01 +0200 (CEST)
Date: Wed, 10 Jul 2024 16:40:01 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3] kbuild: add script and target to generate pacman
 package
Message-ID: <Zo6dQQIJmkauRmFM@fjasle.eu>
References: <20240708-kbuild-pacman-pkg-v3-1-885df3cbc740@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-kbuild-pacman-pkg-v3-1-885df3cbc740@weissschuh.net>
X-Smtpcorp-Track: 4hPYo7uFKfj4.CjypGBhIfCeI.BBU1FwULfYk
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286saasBVQzwC
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Mon, Jul 08, 2024 at 10:11:51PM +0200 Thomas Weiﬂschuh wrote:
> pacman is the package manager used by Arch Linux and its derivates.
> Creating native packages from the kernel tree has multiple advantages:
> 
> * The package triggers the correct hooks for initramfs generation and
>   bootloader configuration
> * Uninstallation is complete and also invokes the relevant hooks
> * New UAPI headers can be installed without any manual bookkeeping
> 
> The PKGBUILD file is a simplified version of the one used for the
> downstream Arch Linux "linux" package.
> Extra steps that should not be necessary for a development kernel have
> been removed and an UAPI header package has been added.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v3:
> - Enforce matching architectures for installation
> - Add Reviewed-by and Tested-by from Nathan
> - Link to v2: https://lore.kernel.org/r/20240706-kbuild-pacman-pkg-v2-1-613422a03a7a@weissschuh.net
> 
> Changes in v2:
> - Replace ${MAKE} with $MAKE for consistency with other variables
> - Use $MAKE for "-s image_name"
> - Avoid permission warnings from build directory
> - Clarify reason for /build symlink removal
> - Install System.map and config
> - Install dtbs where available
> - Allow cross-build through arch=any
> - Sort Contributor/Maintainer chronologically
> - Disable some unneeded makepkg options
> - Use DEPMOD=true for consistency with rpm-package
> - Link to v1: https://lore.kernel.org/r/20240704-kbuild-pacman-pkg-v1-1-ac2f63f5fa7b@weissschuh.net
> ---
>  .gitignore               |  6 ++++
>  scripts/Makefile.package | 16 ++++++++++
>  scripts/package/PKGBUILD | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index c59dc60ba62e..7902adf4f7f1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -92,6 +92,12 @@ modules.order
>  #
>  /tar-install/
>  
> +#
> +# pacman files (make pacman-pkg)
> +#
> +/PKGBUILD
> +/pacman/
> +
>  #
>  # We don't want to ignore the following even if they are dot-files
>  #
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index bf016af8bf8a..a5b5b899d90c 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -141,6 +141,21 @@ snap-pkg:
>  	cd $(objtree)/snap && \
>  	snapcraft --target-arch=$(UTS_MACHINE)
>  
> +# pacman-pkg
> +# ---------------------------------------------------------------------------
> +
> +PHONY += pacman-pkg
> +pacman-pkg:
> +	@ln -srf $(srctree)/scripts/package/PKGBUILD $(objtree)/PKGBUILD

Can you please also add PKGBUILD to MRPROPER_FILES in top-level Makefile?

Kind regards,
Nicolas


Return-Path: <linux-kernel+bounces-378368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C2B9ACF01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4B61F23C38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098C1C6F54;
	Wed, 23 Oct 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="OsFNGJV2";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="VKhMFu34";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="gEcH7T0T"
Received: from e2i55.smtp2go.com (e2i55.smtp2go.com [103.2.140.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E81CB325
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697958; cv=none; b=CHPh7cCi6EXYEnkzrDo6kdtU2SNc7kbCNCAowooyu5hhnUU0FvtebfyasEypIapWHtrmFamN4ivqbcWGHkkvcJSY3UnBad2N9Rkq4S4UM4J3qO5PMlFIirUGCfud0AkTr7qMPJt0diYzUgKCVbHLVqdRd/uz1T5A3WCxfqlN2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697958; c=relaxed/simple;
	bh=TArXztQb+MkM8RiEqijx7IT5RomzWnTWUWB7pS0l0KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9H+scUM1o6InPiYQRE2JDdBfB+WAoucJqVXvvmIy/MGvP8MjufZaNCTW+Hg5xFIck90ajvMTh6564Cd0Y7+HjhGb1Zpga7V+JIDrgym1d5SLVdZpFYHBirHdd3Wl74sTeKP4cPhbUqOcqYLc1u6TEydGbKSmCA+Jf0cy8O6ncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=OsFNGJV2 reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=VKhMFu34; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=gEcH7T0T; arc=none smtp.client-ip=103.2.140.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1729698851; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=PGordEIR45jrNlNrTNYlWgRJv5GwdV7ZsRzwl31sT1s=; b=OsFNGJV2j0v99K7wEyU8vJV4qb
	FUqrs4m6sbIdwC4RiiUq3u62i8z924THvx4gGy+jWBIvQUH1OP0M4JQYGAJzvxrjSrE/3ERHB2cHu
	zgSVWJTH80zyVDsK9bmo8SfZiILsekFKFlP9O1G5QMjQRTnQwXxW94t1hx5Cr98bddzn8dQ24IKNX
	6ZWR87suTxV8To8SV/gJhjQ9Xxeo+j88pCxZjQ6pvTVX3pq5sO3IdAO3p7aZuZL6riKs8YFp97bD7
	mRPe/D75sKISF52ghIoBISeM3eDaARtEvyl8WApxn7o7NpeSpupPJ0p2Ugkzq0WScwmU3ufUTjtkk
	b92pNpUA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1729697951; h=from : subject :
 to : message-id : date;
 bh=PGordEIR45jrNlNrTNYlWgRJv5GwdV7ZsRzwl31sT1s=;
 b=VKhMFu345DlUoewa3Tm6Fr+15ALo+v9FrwOCG/Hti9Oooi6sTAm83BG09WhblEzp/mXP+
 g7aRGFeFCR6Lhu0umJzSaWPRjgypdyUqZ9/QFl/9xBv1hmTQXs2lm2A8YvDSv33nnjqLAgx
 MloJE4gVIIqyma7hyl4NcvG7wPchheIz+bpmGVkbJSU20imogs3MI13fvOEL8CBpkDUl/3/
 yQTFpKS5iVC7yFW2JQrYVg1xdC/SlfTnwUj2LEPsIya53ArJNFhASaeQzZfhW4bKp+eTw/P
 sNfkkjahG5BebcozdSF2xfrkxSWEYkiq1dvvdaGQRoPppAe68iLqAdVNWKnw==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t3dR5-cp4XYB-N4; Wed, 23 Oct 2024 15:38:12 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t3dR4-4o5NDgrnm55-q8BV; Wed, 23 Oct 2024 15:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1729697888; bh=TArXztQb+MkM8RiEqijx7IT5RomzWnTWUWB7pS0l0KU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gEcH7T0TYi7Qysti88+ZUXIfIOMyb9BHFoq5nSXCUOKYI0uVGFhK2z48N8Pfy31W9
 QhIE/JrdSelmEz4hXq5mbBUvIziHeAzoKiXB8GqSEMdlKSW85YZnX17oZXxwHciQqY
 JCXEsIrtvGdCMGRG1Yq/uEn3ModBzfiSSV294JxQ=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 2EC8C3D2A2; Wed, 23 Oct 2024 17:38:08 +0200 (CEST)
Date: Wed, 23 Oct 2024 17:38:08 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <benh@debian.org>,
 Ron Economos <re@w6rz.net>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] kbuild: deb-pkg: add
 pkg.linux-upstream.nokernelheaders build profile
Message-ID: <ZxkYYLbiXZ3p59iu@fjasle.eu>
References: <20241022181703.1710116-1-masahiroy@kernel.org>
 <20241022181703.1710116-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022181703.1710116-2-masahiroy@kernel.org>
X-Smtpcorp-Track: KXe1C8ex4eYD.RIwB4eFfCcdF.NHhwiA8z5T7
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sX19qKHJLT
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Wed, Oct 23, 2024 at 03:16:58AM +0900 Masahiro Yamada wrote:
> Since commit f1d87664b82a ("kbuild: cross-compile linux-headers package
> when possible"), 'make bindeb-pkg' may attempt to cross-compile the
> linux-headers package, but it fails under certain circumstances.
> 
> For example, when CONFIG_MODULE_SIG_FORMAT is enabled on Debian, the
> following command fails:
> 
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bindeb-pkg
>       [ snip ]
>   Rebuilding host programs with aarch64-linux-gnu-gcc...
>     HOSTCC  debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/kallsyms
>     HOSTCC  debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/sorttable
>     HOSTCC  debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/asn1_compiler
>     HOSTCC  debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/sign-file
>   In file included from /usr/include/openssl/opensslv.h:109,
>                    from debian/linux-headers-6.12.0-rc4/usr/src/linux-headers-6.12.0-rc4/scripts/sign-file.c:25:
>   /usr/include/openssl/macros.h:14:10: fatal error: openssl/opensslconf.h: No such file or directory
>      14 | #include <openssl/opensslconf.h>
>         |          ^~~~~~~~~~~~~~~~~~~~~~~
>   compilation terminated.
> 
> This commit adds a new profile, pkg.linux-upstream.nokernelheaders, to
> guard the linux-headers package.
> 
> There are two options to fix the above issue.
> 
> [option 1] Set the pkg.linux-upstream.nokernelheaders build profile
> 
>   $ DEB_BUILD_PROFILES=pkg.linux-upstream.nokernelheaders \
>     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bindeb-pkg
> 
> This skips the building of the linux-headers package.
> 
> [option 2] Install the necessary build dependencies
> 
> If you want to cross-compile the linux-headers package, you need to
> install additional packages. This is a one-time installation step.
> 
> For example, on Debian, the packages necessary for cross-compiling it
> to arm64 can be installed with the following commands:
> 
>   # dpkg --add-architecture arm64
>   # apt update
>   # apt install gcc-aarch64-linux-gnu libssl-dev:arm64
> 
> Fixes: f1d87664b82a ("kbuild: cross-compile linux-headers package when possible")
> Reported-by: Ron Economos <re@w6rz.net>
> Closes: https://lore.kernel.org/all/b3d4f49e-7ddb-29ba-0967-689232329b53@w6rz.net/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/builddeb             | 2 +-
>  scripts/package/install-extmod-build | 6 ++----
>  scripts/package/mkdebian             | 9 ++++++++-
>  3 files changed, 11 insertions(+), 6 deletions(-)

Nice solution and thanks for also documenting option 2.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


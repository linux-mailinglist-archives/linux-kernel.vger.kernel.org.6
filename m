Return-Path: <linux-kernel+bounces-307224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4140964A56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F29B1C227D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263EB1B3734;
	Thu, 29 Aug 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GO4DrLuK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6291B29AB;
	Thu, 29 Aug 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946144; cv=none; b=Rcs8v7UAwYP05ms1b5h5MZZjGwTHIz9rcpZp187n5dQGzoGh+OZaVaKyFPgFoejDp+mKiHg9FQ/ZB7lYloF6+XsRTAPGYyjtBr45HPm2Vz0/ytl8SxCZlNpz1eZ4sRyFcAj9m2h4AoxPEUtgj/3UNSf8X+vUlt5I+tl7t4fngUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946144; c=relaxed/simple;
	bh=ONvF+LmCuub5k1ZGIP4FEw+ReFMsKNWWnjSIl5sAh/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS92HvUYa6PYMgKgtoxMpRf0j3iBPvHMn6XT3V76HWKkVviXoEE+BHSGVnYr2gDxXpx7kFPGUyei2GNYo8Rd9yoRS22I3fxzx5bWSQwHNi4GLzRdunfd2x9Zv4RwahvRxCMikjqAQVfTYKjbcqy+d0fTkkLV+S118uBWpgPc1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GO4DrLuK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0E11140E0275;
	Thu, 29 Aug 2024 15:42:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UonNGK_PhRKe; Thu, 29 Aug 2024 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724946136; bh=smxJaPEdNaSLKjp7Cb+BwXR7ilhmkyju1bn2/NncCII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GO4DrLuKaFjAgts3eHcPSJidY0IxLaS6ZSpMi6ZNk9Jye8KyLXiyxACyVfB7dbsmi
	 /XmG3nn6nlEykGKKK12EgYBWsAUQwTLO5OQH/Vnkhlk5LEciOHP6kg5x36pGDwlTwM
	 sIs1uH0ygK8S9iGmXRwjWstUXDz9711zmhQob//XtlK+W4whoYRz7/qzK4mDsc1hLm
	 bigxRcPnSK8ovTmDSW5PzmCXd6FrwHhvclcsP0B+v2Qx5q+Zm7XxHy2RZTIrg2qLod
	 m2YPVOXU3gszNbfl1OX9g2S+MgwxRnIAYNr66614QT0UpwnLdMqXtO6CSRaASIvLG8
	 B21PGQ2bDPXez6nSrpM/yV9TbCA0A9EhQ7vXAtpkp9+XGvQ+iIVg9PrYbSrM5vmI0Y
	 QI718FnkL8/qPhzIS8yWDOUnhI43ohdbBPIPOnlrvcUBPgwl7rlAC1mDNQOzs1exVv
	 6zW7Zep26Pd4Pkk47mTkPp+ygBUxlzZrSLJ65SkAkowlZCxu5d8XGlK7i2hf8fp7Jo
	 F3xf3G4egxchBESaS4dFzqQ2bCb7BhpqJQVFQw+jIRpnxm43m6EAFGFRkf+HCgKoDL
	 2EBsFpSjri7SSM3ckDQtZgQV3YN7Ny6M159MAeBt/bWue8XVBj14zZjJBNL2ytJCgQ
	 ZJa6IHC84dzwCVSR5SuOBIXI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BED4440E0169;
	Thu, 29 Aug 2024 15:42:02 +0000 (UTC)
Date: Thu, 29 Aug 2024 17:41:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Paluri, PavanKumar" <papaluri@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"VanTassell, Eric" <Eric.VanTassell@amd.com>,
	"Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"Kalra, Ashish" <Ashish.Kalra@amd.com>,
	"Roth, Michael" <Michael.Roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paluri, PavanKumar (Pavan Kumar)" <PavanKumar.Paluri@amd.com>
Subject: Re: [PATCH 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <20240829154156.GHZtCWxP7mkn7aVyWm@fat_crate.local>
References: <20240801205638.6603-1-papaluri@amd.com>
 <20240801205638.6603-2-papaluri@amd.com>
 <20240829132438.GCZtB2lqeYpleYk9c4@fat_crate.local>
 <385ef968-4b13-9124-1f13-e521992ac0c7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <385ef968-4b13-9124-1f13-e521992ac0c7@amd.com>

On Thu, Aug 29, 2024 at 10:29:16AM -0500, Paluri, PavanKumar wrote:
> So here's the updated diff (for patch #1) that is compile-tested:

Make sure you build

"allnoconfig" "defconfig" "allmodconfig" "allyesconfig"

builds, for both 32-bit and 64-bit on each patch before you resend.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


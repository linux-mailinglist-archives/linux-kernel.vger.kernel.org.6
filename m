Return-Path: <linux-kernel+bounces-557735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE795A5DD08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483B97ABE62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600BB242927;
	Wed, 12 Mar 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="As+MUjgd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A84C9D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783545; cv=none; b=lOLXrW+SQgOtCLe2EZGrxy/sSPTBvyd0PsUhbwH8PITRH/Iy1TyVIEfeTV6Uw3oaaHfO/6pk68NMciGmQiXAWHRS3VdKVsmylvBdq8zSntAgjJ2aTQvxxTxykEIZRllhrouQByp0fGlqVUWnGn51BIWZh8w+EKFl6SKM/ipWPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783545; c=relaxed/simple;
	bh=v4wj1VlIiooBRomZGi74kCwiC6WOsJSmj8dlr9agTwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTAQ6FsZKrdr010FFJxsvL6teiEtlIc3FMfCvGSE+MYhDhjC1yLSY0y0eaGVwwOxteCi3ut0gMp/wgxdaVPQiXF0SyeA1T6d1f2sNmPcDiFiHVMw6LfGP6o3sFHSY/z814AcAsm88MdyZvosN4uCmCCyC53BJosKfJ2+Cq5d12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=As+MUjgd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8B7D640E0202;
	Wed, 12 Mar 2025 12:45:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WryxJLMgiLpN; Wed, 12 Mar 2025 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741783538; bh=skzq4sHGhwpxzNxwfZitMvz8tkYl2s8yJrDC51yKX7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=As+MUjgdApgzwU6DvE8gQELGCTUWkdrhdgXbFlhXzyoZrk+QtipLidsmLlcMSenf0
	 zOlJdLe6LwwuioO/yVoukwkeGVj2LrKAiXMHwQIJfC+a0z5vglJYwFirc6Y5imuHIC
	 HlMk1fc97/Omk00R1cFXzumiSQni5pv66ov/vZp90+A6e01qYTE6UzrAM7Z9dATrAt
	 dK4f0IBrJBWUXvFDeYCcenQvhamLdlj0mw4g9LTECXTxJqAiKf6X4Itj/MiZXYoXRq
	 tTb1Hjd8q5IeAKcjrisfyp0vKnX4cjRHKa+PlYOqb1JF1gge2VGcCc2+mnQys3Z1Hs
	 EvWEjXlwLE4q2wp/Qiy7/xOW9A3PJmRrixvfHO82z11gl5vUbWjoNI4OjHg7isslIq
	 n0bKnlExiz6YAiqKvjBQwo1RIl83gv5bod0tJjCnq0OUIZbqzlCZYabsVo+bUDdoz7
	 I1XNCuZRW55tJjiYeTVb1WzpRUcPpDsH0Zj5yUeYV6xEYUNtDappWc/WwXNZ10I8+N
	 +Vma0uoBQfSiVZQetpn1i9n7vdPjumVlDfne9casljcpbepAkT5BCgPXjRdKJlKs9H
	 grMljmH7NZrv1YmIwzLg5l6Hqs5ie4UXyF1c7VCHN+Xmsu9LgTMXSIAW2wWE5lVJn0
	 Q1N3wzbKH5aOYPFB2n3audyc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D31DE40E0218;
	Wed, 12 Mar 2025 12:45:31 +0000 (UTC)
Date: Wed, 12 Mar 2025 13:45:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mikhail Paulyshka <me@mixaill.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/rdrand: hide RDRAND and RDSEED from CPUID in
 case of a malfunction
Message-ID: <20250312124530.GDZ9GB6vscPTpDv8Aq@fat_crate.local>
References: <20250312123130.8290-1-me@mixaill.net>
 <20250312123130.8290-3-me@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312123130.8290-3-me@mixaill.net>

On Wed, Mar 12, 2025 at 03:31:30PM +0300, Mikhail Paulyshka wrote:
> @@ -46,6 +47,8 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
>  
>  	if (failure) {
>  		clear_cpu_cap(c, X86_FEATURE_RDRAND);
> +		if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)

Hygon is family 0x18. Have you tested it there?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


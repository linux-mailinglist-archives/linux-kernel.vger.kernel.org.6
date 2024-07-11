Return-Path: <linux-kernel+bounces-248934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F092E40E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C5B21145
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E08D15884B;
	Thu, 11 Jul 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FEw1yYPo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801681586CF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692164; cv=none; b=luHx7qYq76nv2PzxFVMgzl7/6ym5rcCXdFErWt1FBUN0kGSk4o1Kt/GxuqVXYgKsz3qZWFqrmzSyO3Cw6iLtFDnkZ0owG6t00vcQUV5JGiRmCqb8b7jRsixpOHIR5FG6Xz2rT32dB7380Y1c8kI7V0hm34GTx7lLL29sk5rU4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692164; c=relaxed/simple;
	bh=bsU2iijmIfzXcAb0UJH5CmmLWoJM0VulJ8bNfPuKdGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArO+j+3LJD4xkf/JqeQmXKWzhfg+v1V7Yon1I4You5P7xx3R44QypIsToCkouV7g2c0CAPkgTAcyUpwB6x5ODGfO/CidJiBMxNtuwhA+WnSfM0Qh/bWTvAxEd9y5QG0e0CvgBKSzRmxzOXnW4pgaCK3FD6i7X1F6Ph+oQYW0mOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FEw1yYPo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1BF1D40E0194;
	Thu, 11 Jul 2024 10:02:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vhNxtV-ygpR2; Thu, 11 Jul 2024 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720692154; bh=X4HB46gsk46DsKrN4a1OWEk8Pw5ecckFzaAmidSdxAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEw1yYPo4MvzT9A9JkNvPpMNxvBuryqDsCGQ2mlHOg8C7RswRi1UgPEe4Q/BDKUNn
	 haK5Vk+I+hxXkiW3ISXl5+9XEGyxoELcY/UKlXb/ZYbry/pNDQkVlfPcEJL8zCgD+s
	 sfcr8YeUh0a4sjxnFTR8Q+nI0Rriq3jnIND1OKuDV/Riybnj7h4hGaSTPbU2XcJEOt
	 g2uyhUg54nmZIROJR169p/tb/3elAgyOqCsQ0JSSYhByMAneHBJ9PXP0T0TdEj+EtQ
	 t4ViP52H/Qw5G6+ozVbkmbHNJDFEBVeh52Yz10y8JQR2uP1qCCj2jqLvGxVK/ecPO/
	 o/Kd9aLnq6RAt0eyQss2hBamjTQvCOMxlP4WYXeXDfqLiwosOJWqJ/vlJ+qBWgKiAd
	 ET2VVoUhxerXFvnrApH9Ctnzh8NbsuUdZyrQQrnZPG0Aiy/Nq6ta3SVetMw/fzr2GU
	 wQHhnbBRGf1TNt0QzNfsdhwazxQrMwjVPLDhkluwBT0bJSAA3fG/AxjUHtHHDN9h62
	 vVt8pxuoYJgCaRwTAKK6x4AKdf9uDDNSXZTy12KYedY2VEZnsiM1cfGVBlRABVAmBC
	 El4R6H+886zqxZpAdhzGD69Y0WWpAbxOXCCHvo7h6Qc4QzcATygkzx13E/I9HsMQNG
	 JWT5FfJRHQ312T2fur5VBl7M=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 444A740E019D;
	Thu, 11 Jul 2024 10:02:27 +0000 (UTC)
Date: Thu, 11 Jul 2024 12:02:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Nikunj A Dadhania <nikunj@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [tip:x86/sev] [x86/sev]  06685975c2:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <20240711100220.GBZo-trBnuLqMIWlD_@fat_crate.local>
References: <202407091342.46d7dbb-oliver.sang@intel.com>
 <20240709090323.GAZoz822G64Mr9M9lV@fat_crate.local>
 <Zo3oOK6RH2OJO3rC@xsang-OptiPlex-9020>
 <20240710082838.GBZo5GNvuxJbTjG1TZ@fat_crate.local>
 <Zo83r9vQYpthWd4n@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zo83r9vQYpthWd4n@xsang-OptiPlex-9020>

On Thu, Jul 11, 2024 at 09:38:55AM +0800, Oliver Sang wrote:
> yes, your patch fixed the issue.
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thanks, I went and merged the other build issue reported by 0day into the
original patch so that there's no build failures during bisection.

We should be good to go now, knock on wood.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


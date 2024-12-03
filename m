Return-Path: <linux-kernel+bounces-430304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A29E2EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C283281030
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739AA20A5CA;
	Tue,  3 Dec 2024 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g780/tbD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3D20ADC4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264290; cv=none; b=ffQDrTORkD/RxkGkZheilcNIMhCicEcNYWaSKh/FRdp6Rf1OYgh3GLZYHP3piUATk0g9/UJJ2nCh3E5rYYhTqt2329SKVyDWu/uRMPqFafI7ymSIRxTfDguL1g4iktm8SRLmWOc2+VYSLWGKmlsK1tmw2n/XMU/NA36keldnRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264290; c=relaxed/simple;
	bh=7ZEXrym58pDO7lZ3/DNmYLVamN4Zz6AL31EusfBuSBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBbNgQWDjnNg5vJcxtjXqnp82DGr77jvscDMQaTDT982oBkxaASpRbEbp2rQODXHpaxShOsPRAV7HxD+4vzvyhledqSmlaZCcHjUjKdjc04hW4JXz0H8HLgPA0sgflzAZJUqkD9YBu3OJtXhFhBeH8cxZV4OQamZ2qrvWfWjtsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g780/tbD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4647640E015F;
	Tue,  3 Dec 2024 22:18:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id labHc4lhvDP7; Tue,  3 Dec 2024 22:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733264282; bh=Xdm4dwQaeQ9a6wfiwBG9wxmuN3UGLe1LCBvvp6v2BC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g780/tbDn13O4wL0179QWolrmCcUMLUoO/7uiNXJ9lvLrw+rb0w4qlm5TFj6JByE1
	 gxgDAgYrA9o1ktY2RlS5RrWUpTWPjfNt6SRfdPfubDk/j+nbIQ8VPU//5H7vdOadpO
	 0FnRkHHPrRqkyxgtvDbN9v5IREcYVDHI0oJheyKzOtPPeAFfM6/nXgZDtC3CQYxbft
	 DznSaHMp0uHYQelP2zFi+SUvEMVf7VHqiOvmuS9QCzJiwWbGURrN3Uh6TJS87iUY30
	 kv+e9oqpslRPS9p0fdCC3/XJHYJIqT14GcOcPY6djQCZfFgLcKQ3HOHqrdPUiNx2wT
	 QzBdQ7xoa3heu7jhWQCFIvrXE7mjIfKBt2Nyvx6Gjpsn/6FSMSg8i53kWx5ngBtkuh
	 hsQMXHiZJZVGaHFSgDAsJWc9dHLCaGwh9wZqXpuLVqS4RyEaBSS8ccZbrgw9ISVbO5
	 wcLUHL2neUS6OPD0oTqBVveqSCsxwFUe62CXr4MQR3qEU/TtS3ygr7fVN+fuWsGyh1
	 etbNM9kkufu2bN1gIa2wRyhLvkDmtoS+utrrP8oY00YHFB6xXYTgb1uK5McEIAH/4d
	 Dhl+Hk/76nS9ragEZXbHCSnuCHim9b85R6oEurBCYqSlXfbxrOhY3tuIWq7QSOFKrT
	 6bJfSfEBXaOAMWfpP7AaZYw4=
Received: from zn.tnic (p200300ea9736A14f329c23fffEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a14f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C918240E0277;
	Tue,  3 Dec 2024 22:17:52 +0000 (UTC)
Date: Tue, 3 Dec 2024 23:17:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v2] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on
 systems with AMD preferred cores
Message-ID: <20241203221746.GKZ0-Dii5rnZppkM_e@fat_crate.local>
References: <20241203201129.31957-1-mario.limonciello@amd.com>
 <20241203215454.GJZ09-LmEWPZ502B7R@fat_crate.local>
 <f71aff95-3aea-4681-9d35-9847b086cc8e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f71aff95-3aea-4681-9d35-9847b086cc8e@amd.com>

On Tue, Dec 03, 2024 at 04:02:29PM -0600, Mario Limonciello wrote:
> Preferred core classifications are available on "non-heterogenous" designs
> for a few generations.  There isn't an indication they're supported which is
> why amd_detect_prefcore() was made.

Not surprised.

> That's already called during the boot either way because that is used
> to identify the boost numerator.  The boolean value it finds is cached, and
> the next call will use the cached value.  So I don't expect this change
> affects boot speed.

So with this addition, amd_detect_prefcore() would get called *three* times
where you need to call it exactly and only once. And all it gives you a one
bit of information which states that the system has preferred cores.

So why don't you define a synthetic X86_FEATURE:

	X86_FEATURE_AMD_PREFERRED_CORES

run this code *once* and *early* enough so that every user can have the result
ready, if you have preferred cores, do

	setup_force_cpu_cap(X86_FEATURE_AMD_PREFERRED_CORES)

(it needs to run before alternatives) and then in each user, you do

	if (cpu_feature_enabled(X86_FEATURE_AMD_PREFERRED_CORES))
		/* do things */

instead of what you have now?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-519732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586DEA3A127
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4492188B9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACED26B976;
	Tue, 18 Feb 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f9zt7vlG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC126B967;
	Tue, 18 Feb 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892449; cv=none; b=damUfjjxJBU2nXm1fRlRYYyzIn5WaBZZTCe1AFhxl+vEAPLoGeyGqC0ZdOvPgqUHVUK3hCIH97MkOvEeeundDM3Dn+67TIlTfPDVYjwNW6KxVSuckReysu16BCKjiPa+cK0uAThqzJE2Ty46uJx9u8VL5GzVYHRInBkoInJWTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892449; c=relaxed/simple;
	bh=Mlj6yi6i3mddxrfT7LOeildPFYPG52EYG01ygdCLuYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyquWkVDNrBXlWVGCdk6yw9BYKb7J89cNIsQs6hzzULbS4dC+EWlbzmhwtdxRPxOClSMJ9FivRlpSY7keZyuvtr22pO2up3Nk9JcHgxgo5t4HbgsDT5wYzTjlbZIZlyqScWLYOqE4GQR8sx2gSECnz2H+T4e4pnxuJZUcdQ8mFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f9zt7vlG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B58F840E01A1;
	Tue, 18 Feb 2025 15:27:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DkIFrq9tPvVX; Tue, 18 Feb 2025 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739892438; bh=M9TRXx9dDpaZvblVv9r50m4TkLMeZIF+ZxY/f8xukbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9zt7vlG8S5vh9tlWRLu8VpGvMy7b4yNPqDqvdK6BNbBCPtrlqanROjEdpP2YC1eY
	 bMWsMkCbNjs5478AKxXQMzsTYBnWNIjEsNjjEBv7KSVGM8ElqtVVLekbD0m6XOO9i2
	 MgVjIhiJ2sntkuzIez1Yb72TrchaQeYUTXlJ2a5mtDmu/XP7elbizG22/g8DG6s6rn
	 WwKCP0HwNm0TPL99FO/298Zk0Az6swY2FCST6XtxU344pZU7inmbHOHbYQZmwaa6sl
	 RR/nt/Bi9Wuc372JoxPEap922q5/68ILxk6zOlyxW1hAt9HBYB72CgQsUK8rG7dDNI
	 fvSVsSlPgZsrMFPcQaRvImwhc+/UqjGnukgrcOuiOvPF7AHPaLZVm5vMzV0f5/JxDi
	 ImjLMtHeiYdxj46A7tnkgP/MN0nN+AMf/G2n5RoCH3e+5hluBcZAwz2IUktZ5Na2hE
	 wpVeDkaRAY1klbj8A7KOLuJH8ur9kcFeABhqSz7yYb1bE7mYdUPCUZjZ9nTLxtqRpI
	 4al8GjbIB+8wNCJoCot0x5RVq3ruYe3XfZWH8118xMmCu1KX66Kf06dDhouvKybi7y
	 DzIKr064dBVr10S5nJi30JdJC7hDOokknSVLrkfGpQUDLzZzIU8zkgnVeETq+4BM13
	 KNV8pnUAEB+Zvc7KCeLaFOdU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E28C40E0212;
	Tue, 18 Feb 2025 15:26:50 +0000 (UTC)
Date: Tue, 18 Feb 2025 16:26:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"open list:AMD NODE DRIVER" <linux-kernel@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>
Subject: Re: [PATCH 0/7] Adjust all AMD audio drivers to use AMD_NODE
Message-ID: <20250218152649.GKZ7SmubM_YWhDqaPo@fat_crate.local>
References: <20250217231747.1656228-1-superm1@kernel.org>
 <Z7SjI-NIZbMEgz2y@finisterre.sirena.org.uk>
 <b2876489-7bd5-4c38-b1f8-2d2fcb5a9aba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2876489-7bd5-4c38-b1f8-2d2fcb5a9aba@kernel.org>

On Tue, Feb 18, 2025 at 09:16:20AM -0600, Mario Limonciello wrote:
> My thought is maybe:
> 1) We can get an immutable branch from tip/tip.git with the conflicting
> changes.

I can very easisy do that. Just holler.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


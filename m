Return-Path: <linux-kernel+bounces-519977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E2CA3A448
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2740F166747
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBCA26FA61;
	Tue, 18 Feb 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MELFlR/1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E326B97A;
	Tue, 18 Feb 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899654; cv=none; b=n+6PIp3otnjaeH+iyMTVG7r06DIBxlFpHRVbiW37NtqR9FRAfNF+1NkmikbBQthm2KnuK0MubJLfriwlWTwmc9KLThq2ZZGNGp3tdR16ydXtmT09wFSJYuso4UKwnXzBx0M25QdS7OFHPKmZx1EmdvrMuK7IKkd6lZ+qvcR/+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899654; c=relaxed/simple;
	bh=y+ZJhN7cpCMY1NqHSQ85BW/kzeO13CqDDWrCmla8GbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB0+JUO3RYHPdO4jSI6+/myeuqGQsT9S8bLmZMkJNYGhaUkdS3QCNlCF2qGLqjyGgeuKDvsdAXYp/D3V8CsWxLrwzgT5pcvSjiwx+7iG6zEvXHvJtcuwXdDprOYGYxC+WrHGZaGREmyMBsd1wTbmQh3nA0BUOCliAaeHwKE/sqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MELFlR/1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D3A9140E01A1;
	Tue, 18 Feb 2025 17:27:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6AkQQoTT4_i9; Tue, 18 Feb 2025 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739899645; bh=Y6l26zakd0qr5x+UfVU6l/SEd51HbajlWRpTRHIZo0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MELFlR/1TPAb9F1YEuWm8zv5UBrwEbnoQN3iUpfknIf9hDXFJCiS1q7hLJrNsYJBW
	 Q1MFxA2Squ/FTDM1QpsOM3qOxg/P5S4psD6NHQcigFIyJFs6QMm51mYF2ITQmEJopZ
	 bH/vIrppCu2WnZNptZCcVw6tiwvwwpoevyGo1/OwXDx0Rc4uKELGZ6z1H6YoW5mnXD
	 SRcNa7f9nXtobH1bDReaUmKp4rC7QX4ZFYiO00qciv8TlWVFKI9V4j9eE2077PjCRQ
	 hQqRzMb5Any0KikitnOlF4sQZMc7sd/W09C38HONF5ddxqaXIhez0ZDn6Ca8ze0i4h
	 0O0XbWWEhJH1XEFNabHbfUIfvhQXQ8Tqujl8CtLgfbUsV7eSumOOLOS+zJAqVsPFaP
	 a+tfW08I7f8a/c1twuB3gu4YGsaQ7BzS6v7cf6S0EofztZ/hAdjn7lkhF6hTFiQD72
	 A2sAFRsE7Ds8VC+Q+eNkX2COso1uHGXm+wOj8d2JesZnsQ8kjAZ+vqbUvSXzLW52Z2
	 nUsbUZ3THA0eRCrFAdSQdmbEtS8457vlkIxO9Gae0J09CR6GPHbB2x8OXpraLEmfiR
	 3JyPccNGlT5SH7VUQIzueLxPfVVieWhM3AH+d9mHuAw2rEvOCz78K1USubvM18XFU9
	 Z/bD/NjdvTJsZnG0dXTHORyo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47B1E40E020E;
	Tue, 18 Feb 2025 17:26:57 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:26:50 +0100
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
Message-ID: <20250218172650.GOZ7TC2mHXJdO7_iAd@fat_crate.local>
References: <20250217231747.1656228-1-superm1@kernel.org>
 <Z7SjI-NIZbMEgz2y@finisterre.sirena.org.uk>
 <b2876489-7bd5-4c38-b1f8-2d2fcb5a9aba@kernel.org>
 <20250218152649.GKZ7SmubM_YWhDqaPo@fat_crate.local>
 <f037a5a9-7e5a-4582-9a35-90e8442c6ed6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f037a5a9-7e5a-4582-9a35-90e8442c6ed6@kernel.org>

On Tue, Feb 18, 2025 at 09:33:03AM -0600, Mario Limonciello wrote:
> Yeah; please get that ready and I'll rebase the series and send out a v2 on
> that branch.

There it is:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/misc

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


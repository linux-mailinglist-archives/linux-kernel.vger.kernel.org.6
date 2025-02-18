Return-Path: <linux-kernel+bounces-519980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14113A3A455
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA4B7A44DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731B26FD8B;
	Tue, 18 Feb 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+vFfbbw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D726FA66;
	Tue, 18 Feb 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899796; cv=none; b=ANrSIfzf3Uo/S1qzX3cqQqPKNDHeabbzPnPweMyOGHQgpYvNjGG4jMWkGbs3xCBRS0x9I484GEgyhOcFaMn3Nap/+fEUxSfSgCzy0NLJa5Oo/2ppAO13edYl/b7BbQgtbelaoWn11zR9+SYeavVlOs9zLEO+fdu63eg4x/qauIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899796; c=relaxed/simple;
	bh=emS3jjUdRxAkZX0/Wg/p0kV5/i72KFjYTYkDUpcXmW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3qGVMPYpYYqL83uyP6acavrNPtd/OImTH+4sDhUC9pcfj53cNcR45fosJv4Dc4Hn5j04DTqT8IYZiZ36oOLwFYjBRhEfB63l1gHLpoVd9NdoKi7qphN7Md6KQ0yfHkEf0qzA/Wdo4ATy3B4i1enPO9SbUnA6o985jfc4yV/GEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+vFfbbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26F7C4CEE2;
	Tue, 18 Feb 2025 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739899795;
	bh=emS3jjUdRxAkZX0/Wg/p0kV5/i72KFjYTYkDUpcXmW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s+vFfbbwo9m1fZgTAeijqNdnoXzw+R8VMVeiuUaxWN+leCTtyn20NI8cbpv2TtRaL
	 56SlzZZOYpHIo8Kef0J68Ejk1XHOcJYHmawd/KanOR6d8PqS7xdGyjiGUk42EaZXgA
	 YPucXca5ekgoXdG3JdiQOQAF7E2E2i4NDeys0y2oyGIhEdxA51AgfqQrnWZv+4y1Po
	 BsEJhrP8Mfrxek4ZTHb4Agze0O9pWvBlU4FXLiqUP9Vc7kt+XaTCyeVOwH4uoMA7w2
	 hjIhEyA0PYIdnzfkhC2oVIPYCvUNtYfIPz4jJWURFia7eVxHtZ9qxTqKel33W40QIL
	 V0GcIE9S993UQ==
Message-ID: <23b98c23-c408-40b8-bab2-cae0fe8455d4@kernel.org>
Date: Tue, 18 Feb 2025 11:29:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Adjust all AMD audio drivers to use AMD_NODE
To: Borislav Petkov <bp@alien8.de>, Mark Brown <broonie@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Liam Girdwood <lgirdwood@gmail.com>,
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
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "open list:AMD NODE DRIVER" <linux-kernel@vger.kernel.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>
References: <20250217231747.1656228-1-superm1@kernel.org>
 <Z7SjI-NIZbMEgz2y@finisterre.sirena.org.uk>
 <b2876489-7bd5-4c38-b1f8-2d2fcb5a9aba@kernel.org>
 <20250218152649.GKZ7SmubM_YWhDqaPo@fat_crate.local>
 <f037a5a9-7e5a-4582-9a35-90e8442c6ed6@kernel.org>
 <20250218172650.GOZ7TC2mHXJdO7_iAd@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250218172650.GOZ7TC2mHXJdO7_iAd@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/2025 11:26, Borislav Petkov wrote:
> On Tue, Feb 18, 2025 at 09:33:03AM -0600, Mario Limonciello wrote:
>> Yeah; please get that ready and I'll rebase the series and send out a v2 on
>> that branch.
> 
> There it is:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/misc
> 

Thanks.

Mark,

I confirmed that a test merge of tip/x86/misc into ASoC/for-next and 
then applying the remaining 6 patches worked properly, so you can pick 
up and do that.

Thanks,


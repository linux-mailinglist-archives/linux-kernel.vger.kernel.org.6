Return-Path: <linux-kernel+bounces-410681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E46B9CDF9C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5051F22DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4F1C07C5;
	Fri, 15 Nov 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="D3Hh6YsX"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3F1BE871;
	Fri, 15 Nov 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676231; cv=none; b=q7DjhB4WeQeuWjpFtfJwEKgaxxMeIELqm1jVDMeboT+5GeAaU1H5L9gCZw5oA/wbTiKG5MiATP1bkVAiMrdNE42//FSORsP9T73cnA1UNYDsZpi9Lhtx6bA+2Siu40W7NMVtGRPK9SoGAjFIJkl7ho0wf1BVet3rRaUp6jc41aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676231; c=relaxed/simple;
	bh=YWWv8XRqDyTMxPK9th3Gjlbl6D4b52dcqf1sIGOyhjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VaSU7mZ2GYY9VL+wG6gXKHsWsO1cOJgibXiOap0SA+XDi1JPYHg2ZQcVP6pwBtQiQCJgtfiwblj49z2PBTYSyTmHLTjzXf59oaz01dy6JSbn6P1XLCHZHfbFUAUoHcbBGMP7JkV08MYJB5DfTkyHOuG6SgWhbx34B/lx/kcvZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=D3Hh6YsX; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8E891A03F3;
	Fri, 15 Nov 2024 14:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=NLb7/7MPArmAXwhvn/nb
	ETdJKG+sBfotx0epRnf772U=; b=D3Hh6YsXVmldwd00F0xnlFbvCldf8nptR4ML
	VFfjs7I1othA8hMb7lgf16ZHQ8tNiocGolWZVWWaeNwIw1CDPp8gEWlx0T+c6gqE
	Z4Uh3wVA7GdXs39/VfUQ2pAot3ytdBL0rIKxIl4G0VPMZqUSeXXgHb/zNeav7rIL
	PNse3NGlSwhDS4ttXJSU0qGoo6niaaV1AWgmA3ZO2MI3FfCfxGv56Ut38J/BRH7r
	Vey14L90aLkODZ2SaUjrzkxs9/OC4nTre0yoEYHiIpfvQmD0GB++vTeaqmChWdns
	kvjpuO/ippfyAV6yq24Ct5qToOSkkgte8YCh7JF+UbW7RX4hFHzUa2FHgfoKtePf
	97UdNkHZEMMjvDpTrHfAsr4EQDEK8klGtF7CYrrVCp0ypyacKI3vXMN3Ep+rjKC1
	jFK+MOw2t952uD58CkcbtNT6MchfiQgq+ZeiA2sOdSWZSJ4gugnq5WCmRYAfHH9W
	xkHv/XttlUZVMYI0duL5cE93D3T2C/5d9ryJD6zWVbffEw53zGPvmEEZfxEy8Aea
	p0SlGg+8+gfPd4bojZw+xS0GxwWeaPQrnNhlVvs7SLoFQg/0by3DrVNbS5Ye3lf0
	C7LCEIYxogg4ZuYKgLFBVVrTaM+xC4FWpG+KQg6jwDZlAIt4Uh8ovnJSLTLKLwvs
	GBhSjH0=
Message-ID: <594b2929-f7ab-4d30-a97c-1b1b31258d25@prolan.hu>
Date: Fri, 15 Nov 2024 14:10:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for codec of F1C100s
To: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
References: <20241102125712.2647325-1-csokas.bence@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241102125712.2647325-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855617C6B

So, if there's no further remarks, can this be merged? The next window 
is coming up, and there's the DT addition still waiting in the pipe.
Bence

On 2024. 11. 02. 13:57, Csókás, Bence wrote:
> Support for Allwinner F1C100s/200s series audio was
> submitted in 2018 as an RFC series, but was not merged,
> despite having only minor errors. However, this is
> essential for having audio on these SoCs.
> This series was forward-ported/rebased to the best of
> my abilities, on top of Linus' tree as of now:
> commit c2ee9f594da8 ("KVM: selftests: Fix build on on non-x86 architectures")
> 
> Link: https://lore.kernel.org/all/cover.1543782328.git.mesihkilinc@gmail.com/
> 
> As requested by many, this series will now be split in 2, the DMA and the
> ALSA/ASoC codec driver. This is the codec part of the series.
> The first part (DMA) can be seen here. This series can be applied and
> built without the former, but for working audio you need them both,
> plus add it to Device Tree.
> Link: https://lore.kernel.org/linux-kernel/20241102093140.2625230-2-csokas.bence@prolan.hu/
> 
> Csókás, Bence (1):
>    dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec
> 
> Mesih Kilinc (2):
>    ASoC: sun4i-codec: Add DMA Max Burst field
>    ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
> 
>   .../sound/allwinner,sun4i-a10-codec.yaml      |  31 ++
>   sound/soc/sunxi/sun4i-codec.c                 | 365 +++++++++++++++++-
>   2 files changed, 394 insertions(+), 2 deletions(-)
> 



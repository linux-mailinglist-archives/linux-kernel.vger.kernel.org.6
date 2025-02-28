Return-Path: <linux-kernel+bounces-538567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EBCA49A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B4F1739AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E526B976;
	Fri, 28 Feb 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eNabF+ok"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0AB25E471;
	Fri, 28 Feb 2025 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748454; cv=none; b=i3E0J56CbME7Ji/8eEgs7GdR0957ntTpMQX7kXnX4NQ0ds8u9xWi4BytCrCwH11wVgNAQkYLDKq8/aGTgI0eQprVo5bN2nuvOlUCfrwuM/VZd2ekvHimues1oCMiVc09BTCYJXq1zEepCikGNx7xigjpkx34trKR+MnqCj5hB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748454; c=relaxed/simple;
	bh=21m3In4wCH+q/UoEDYx7ymPFrvABWf4Rd32gUSleQA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvWNjoDfF5WDPSD3P+eiS+4+D5tKzo1YGYjNnVFWozXRfDpF2pqReaj9DM0WeyXItvrk6hl/ItNPYOfbx0+QEIGOvfVHjN+jxSuhK0HzKhe0HN0tqJf/Vt7qOtauPZP88I51G/mjnIMDG3FZpUukwoUQM19nWyqfHqAdD8geHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eNabF+ok; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740748450;
	bh=21m3In4wCH+q/UoEDYx7ymPFrvABWf4Rd32gUSleQA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNabF+okts2wj5dvZqEBsxkC50bHNM+f5w4lqa7moXIz4uTrl2Dwht6hOqGiod1MK
	 yrrwclkFsnIodC7SDWabOXUO3KABtHYviBa3il6GwIrYgwLH1s/hT7ISUti/D3SMy2
	 I+fy4+hm4Sg/qB4K5PCskuRuHDn2TNybZUYToHnYwKxd/1QU0ldBXskBiTgmqL0Ipg
	 mKxcYEzHxnzBDfv+RguYfrrK7hCZU09YDF3GPxBBGxVMOJcXbQGd2bHXiFKEGKMWKH
	 bAhOirJHBRJ8C00gWbsqCRO83L4G0d4KGf2d7+IJgDWSEEMdUhkN/fV2iypTRhWoaJ
	 azj0xU0CSrUkw==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 733C217E087E;
	Fri, 28 Feb 2025 14:14:07 +0100 (CET)
Date: Fri, 28 Feb 2025 10:14:05 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, kernel@collabora.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt6359: Fix DT parse error due to wrong
 child node name
Message-ID: <59f79e0a-c99f-4b30-b0dd-81c4889c7807@notapiano>
References: <20250228-mt6359-fix-probe-failed-v1-1-64941d387b2c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228-mt6359-fix-probe-failed-v1-1-64941d387b2c@collabora.com>

On Fri, Feb 28, 2025 at 11:32:19AM +0100, Louis-Alexis Eyraud wrote:
> A recent dtbs_check error fix in mt6359.dtsi file changed a node name
> (from "mt6359codec" to "audio-codec") without modifying the mt6539
> codec code that uses it.
> It leads to a probe failure after devicetree parsing returns in error:
> ```
> [    1.354025] mt6359-sound mt6359-sound: mt6359_platform_driver_probe() failed to parse dts
> [    1.355066] mt6359-sound mt6359-sound: probe with driver mt6359-sound failed with error -22
> ```
> 
> So, add the child node retrieval with the new name and if not found,
> try with the older one for backward compatibility.
> 
> Fixes: 76b35f59bbe6 ("arm64: dts: mediatek: mt6359: fix dtbs_check error for audio-codec")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas


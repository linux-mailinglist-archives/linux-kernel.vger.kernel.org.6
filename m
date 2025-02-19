Return-Path: <linux-kernel+bounces-521618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1D7A3C003
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DF817673F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC901E5732;
	Wed, 19 Feb 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L+wa9Ip+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8C2AE74;
	Wed, 19 Feb 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971830; cv=none; b=s/iwDl2FRW5y2BxKXrrWXu5LX/+slJLyXkiuq/v1uuRtkCRV2iJdelg+zr+av/gR/OfXoBqtQPUQkimakBJLAH9gM4kX4Hnd9HzLbqaj9cQhbBrpN7ayk3GcuduYfnnDGTLKL0rokAKcaUwsTYLxta2O3FPfBqAfIWUqgmkxb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971830; c=relaxed/simple;
	bh=O6x7SNy89g82HPWJGUfqA0X9THHPpDCJB2dBOG1XwF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydqw05YG5sW0pdFf3UHOCgC0B+dpiCh381bpc2bURHCPu8MorLbrtc6O5GYtPmqbAhion4JzVHEBquOY7XW7TeTY8uP5FT3926fBwZrcrFsZvlN6YnlX9P3/yx3cwFzfOTuOmsD/fzklqiA9QmpbrNw7fx32jil3WQuqcFQ56eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L+wa9Ip+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739971826;
	bh=O6x7SNy89g82HPWJGUfqA0X9THHPpDCJB2dBOG1XwF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+wa9Ip+3fVnUNZolzRaAGSL2sX+SgtItJw7JvBgQDuSf8T+1JlHglR7p0r/ZkpmC
	 tJ6AfyICKKTVWd1I+tcnoDj1r7vGdpBq9C1Ho38SxrC21H4WYTHQJrOpoT0MDkJhqB
	 tGOukiQF4+w0Eop1Qdg4pbhIN8dlOXpyEGrdXtW6gXh6h8mQzH7uZt70ZC60eJV7aj
	 9q0wuWAPXe962QypjHmLp0Rfy06a5ZJRJtQu0hZBEgCt5WUDmazZhedy44TGutYHsZ
	 PjLg9xNBmjbKvKDaSTU2ZFCFqQJx/7vO5VQZ8rhi+isQMRdgIcERR4c3R1lUtlb4s5
	 yk1PE4ZQ29y5A==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3DEBE17E1566;
	Wed, 19 Feb 2025 14:30:22 +0100 (CET)
Date: Wed, 19 Feb 2025 10:30:19 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	parkeryang <Parker.Yang@mediatek.com>
Subject: Re: [PATCH 6/6] arm64: dts: mediatek: mt8390-genio-common: Add
 routes for DMIC
Message-ID: <5e7d7461-1af4-4e16-b808-072fe7c34e36@notapiano>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-6-6bc653da60f7@collabora.com>
 <CAGXv+5H1pfJMQPBTF_K72D3-JFsZDvZ277erZ449sc6FTkNFSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5H1pfJMQPBTF_K72D3-JFsZDvZ277erZ449sc6FTkNFSA@mail.gmail.com>

On Wed, Feb 19, 2025 at 12:29:15PM +0800, Chen-Yu Tsai wrote:
> On Wed, Feb 19, 2025 at 5:27 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Add necessary routes for the onboard dual DMIC present on the Genio
> > 700/510 EVK. The dmic is supplied by micbias0 and micbias2, and inputs
> > into the MT8188 DMIC DAI.
> >
> > Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
> > Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> > index a37cf102a6e928440cc88e7e8fe0225fc28ec962..efdeca88b8c4e58f0c17825156276babf19af145 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> > @@ -959,7 +959,11 @@ &sound {
> >         pinctrl-0 = <&audio_default_pins>;
> >         audio-routing =
> >                 "Headphone", "Headphone L",
> > -               "Headphone", "Headphone R";
> > +               "Headphone", "Headphone R",
> > +               "DMIC_INPUT", "AP DMIC",
> > +               "AP DMIC", "AUDGLB",
> > +               "AP DMIC", "MIC_BIAS_0",
> > +               "AP DMIC", "MIC_BIAS_2";
> >         mediatek,adsp = <&adsp>;
> >         status = "okay";
> 
> Shouldn't there also be one or two new dmic-codecs, and a dai-link here?

The DMIC codec is only needed to get a wakeup delay and avoid an initial "pop"
noise. Same as for the analog mic, for which I've recently sent a patch [1].

Depending on the order that things get picked up, I can either add the patch for
it to this series, or the series in [1]. (Well, looks like I'll be sending a v2
for this series anyway, so I can add that patch here).

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20250214-genio700-amic-wakeup-delay-200ms-v1-1-0094837c62b7@collabora.com


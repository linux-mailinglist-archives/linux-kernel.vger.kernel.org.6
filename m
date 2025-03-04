Return-Path: <linux-kernel+bounces-545528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86F7A4EE34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F893AAF01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD9265600;
	Tue,  4 Mar 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NNECqxIP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602E1FA262;
	Tue,  4 Mar 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119416; cv=none; b=PqFy4AnBgjmlMIR3ld8sDCq5w4f17kNFlQD8V1d7DAtbICU62q4F3amUrPV96kbpF0m/uuJca++92oZsrDB5ntXDW0gaHhOTDBohxZ97X3XC/fXQJDVG2VSL/vBoUMzkQeKlAqDCnThv5id0MBkFzZrhRHVtMQFesdOmhOz83x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119416; c=relaxed/simple;
	bh=+m3MSI+Wse2/nqsFrLOXWe0hhVL+hryAhIW9WJvUc8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkmRG3eTZPv1RsHZFOerB9XZVpovJ/x2IUlH8PGUxNFXEIOPVZP9jl3ZCiyMJIpNe+R0NjXQk8dhzFIj1J+9z0pneZKsIb+aHXqxmtqdC04ETg0w0ePJL7a/HB8PwbijSEVFCLpDy6CVChuZJWEdgA2OZfnHA/DFRX1qNu5eyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NNECqxIP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741119411;
	bh=+m3MSI+Wse2/nqsFrLOXWe0hhVL+hryAhIW9WJvUc8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNECqxIPqgDEtxC9WNQhyIy2/0BlsbnkQQQ7J3VmPwFXLmxwhcJ+X7zkHWp8SAX7B
	 80IHb7DobMVk8upoZzv8kZ7Ufys9Hv8cVcU53xTnQY9nprqmn2JHwMQ6VhhJ3NVW5i
	 0MuVOIz/bQq7nkZfbkrgbWHLZpEtFgKpeYIsMacQFP5CtPp9LtjWqlrdteyopxakxY
	 cSrHMsNJBsLul3xcQbe8hvEezMHOGJjnWaW18al4Et6xnkoxAIeB3wiAfVgWHkAIK7
	 SFH9XJHNAiatitTFKSLxGGbiHgdue62MXrDC8rFAOELpfqAHr+gPith0ORbN+P2A2d
	 418DLNuKI5Leg==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B51B417E0630;
	Tue,  4 Mar 2025 21:16:47 +0100 (CET)
Date: Tue, 4 Mar 2025 17:16:45 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	kernel@collabora.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zoran Zhan <zoran.zhan@mediatek.com>
Subject: Re: [PATCH 3/3] ASoC: mediatek: mt8188-mt6359: Add headset jack
 detect support
Message-ID: <fc9863ef-8781-46a0-ba8c-6dabd9fb6cdf@notapiano>
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
 <20250214-mt8188-accdet-v1-3-6bbd5483855b@collabora.com>
 <d976b28d-f44f-4d51-8b61-4c046c571412@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d976b28d-f44f-4d51-8b61-4c046c571412@collabora.com>

On Tue, Mar 04, 2025 at 04:39:33PM +0100, AngeloGioacchino Del Regno wrote:
> Il 14/02/25 16:14, Nícolas F. R. A. Prado ha scritto:
> > Enable headset jack detection for MT8188 platforms using the MT6359
> > ACCDET block for it.
> > 
> > Co-developed-by: Zoran Zhan <zoran.zhan@mediatek.com>
> > Signed-off-by: Zoran Zhan <zoran.zhan@mediatek.com>
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 43 +++++++++++++++++++++++++++++++
> >   1 file changed, 43 insertions(+)
> > 
> > diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> > index 2d0d04e0232da07ba43a030b14853322427d55e7..4e19e6cfad1e1f42863b2e2f27131f880c5883bf 100644
> > --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> > +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> > @@ -17,6 +17,7 @@
> >   #include "mt8188-afe-common.h"
> >   #include "../../codecs/nau8825.h"
> >   #include "../../codecs/mt6359.h"
> > +#include "../../codecs/mt6359-accdet.h"
> >   #include "../../codecs/rt5682.h"
> >   #include "../common/mtk-afe-platform-driver.h"
> >   #include "../common/mtk-soundcard-driver.h"
> > @@ -266,6 +267,17 @@ static struct snd_soc_jack_pin nau8825_jack_pins[] = {
> >   	},
> >   };
> > +static struct snd_soc_jack_pin mt8188_headset_jack_pins[] = {
> 
> This is the same as nau8825_jack_pins... perhaps we could reuse that?

The difference is the pin name: "Headphone Jack", which results in a difference
in the widget's name. I remember you wanted to not have the "Jack" in the
widget's name to standardize it among other MTK platforms, and we could do that
here by dropping it from the nau8825_jack_pins. But since that name is also used
on the audio routes in a few DTs, those would need updating as well:

arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts

The name is not used in upstream alsa-ucm-conf though, so it should be safe to
update.

In any case, I didn't want to expand the scope of this series to that unrelated
change, so that's why I introduced this separate struct, thinking we could
commonize as a later step.

> 
> > +	{
> > +		.pin    = "Headphone",
> > +		.mask   = SND_JACK_HEADPHONE,
> > +	},
> > +	{
> > +		.pin    = "Headset Mic",
> > +		.mask   = SND_JACK_MICROPHONE,
> > +	},
> > +};
> > +
> >   static const struct snd_kcontrol_new mt8188_dumb_spk_controls[] = {
> >   	SOC_DAPM_PIN_SWITCH("Ext Spk"),
> >   };
> > @@ -500,6 +512,35 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
> >   	return 0;
> >   }
> > +static int mt8188_mt6359_accdet_init(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
> > +	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8188_JACK_HEADSET];
> > +	int ret;
> > +
> > +	if (!soc_card_data->accdet)
> > +		return 0;
> 
> I'm not sure... if we have mediatek,accdet (so accdet is present here), but we also
> have a NAU8825, or RT5682S, or ES8326 codec, this function will create a headset
> jack for MT6359, but then mt8188_headset_codec_init() will do the same again!
> 
> I think we should find a way to avoid that situation, as I'm mostly sure that this
> will give issues in the long run.
> 
> Even if it wouldn't, having two headset jacks exposed, of which one doesn't work
> because it doesn't exist on the physical board... would be confusing for the user.

IMO that situation happening would mean the DT is wrong. If the board has the
headset jack pins wired to a headset codec, and that's responsible for jack
detection, then those pins won't be wired to the ACCDET block, and therefore the
board DT shouldn't have the mediatek,accdet property.

I think you're imagining having the mediatek,accdet property always present, and
the logic you propose would allow specifying a headset codec to essentially
override it (making the mediatek,accdet property useless in this case). But
there can also be boards with no jacks at all, and in those cases we don't want
jack widgets exposed to userspace, so the mediatek,accdet property should be
omitted for those boards, and only present on boards where the ACCDET is
actually wired to.

> 
> I guess that the best option here would be:
>  - Let the `for_each_card_prelinks()` loop finish
>  - Check if any of the external codecs are providing 3.5mm jack
>    - External codec providing jack means that the detection should be performed
>      by the external codec, as the jack should not be physically routed to the
>      MediaTek ACCDET related PMIC pins (right?)
>    - No external codec means that the accessory detection can only be performed
>      by the MediaTek ACCDET IP
>  - If external codec manages 3.5mm jack: do nothing
>  - If no external codec managing 3.5mm jack: check if accdet provided in DT and
>    initialize it
> 
> ....unless I'm wrong - and if I am, please explain why (and also add explanation
> to the commit description).

I can add to the commit message:

Only boards that have jack detection managed by the MT6359 ACCDET block will
have the mediatek,accdet property present.

Thanks,
Nícolas

> 
> Cheers,
> Angelo
> 
> > +
> > +	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
> > +				   SND_JACK_HEADSET | SND_JACK_BTN_0 |
> > +				   SND_JACK_BTN_1 | SND_JACK_BTN_2 |
> > +				   SND_JACK_BTN_3,
> > +				   jack, mt8188_headset_jack_pins,
> > +				   ARRAY_SIZE(mt8188_headset_jack_pins));
> > +	if (ret) {
> > +		dev_err(rtd->dev, "Headset Jack create failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = mt6359_accdet_enable_jack_detect(soc_card_data->accdet, jack);
> > +	if (ret) {
> > +		dev_err(rtd->dev, "Headset Jack enable failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   static int mt8188_mt6359_init(struct snd_soc_pcm_runtime *rtd)
> >   {
> >   	struct snd_soc_component *cmpnt_codec =
> > @@ -512,6 +553,8 @@ static int mt8188_mt6359_init(struct snd_soc_pcm_runtime *rtd)
> >   	/* mtkaif calibration */
> >   	mt8188_mt6359_mtkaif_calibration(rtd);
> > +	mt8188_mt6359_accdet_init(rtd);
> > +
> >   	return 0;
> >   }
> > 


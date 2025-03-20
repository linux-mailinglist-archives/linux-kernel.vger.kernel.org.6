Return-Path: <linux-kernel+bounces-569270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0FA6A0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A314189502D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7A205AA5;
	Thu, 20 Mar 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1EsmT+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339421E3769;
	Thu, 20 Mar 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457124; cv=none; b=CZLanidYPcINg77zZ2cHuKv13oeSTYP6D5xyXNis54wctNqil5CaLh4tc6s88g/4Rnz5bOOPenIXZWYQakDA2kscJN5D8P7JrDre8XdCDyQ5/JBbEG6DSB35nLXkkA2ZvQWo0tA2FwXUYe8ZlG1u7m++6X/jgP2+dDjDTZsynqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457124; c=relaxed/simple;
	bh=LpoG0RMzz7fNHCibF4J26zt4F7k2qKpDYABHIjcJWbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOcodI2PjuYWZZ0TsEbWH2IFgDCu87ocoEtXyhS/L0ue9HTJNuEs5+vrLc1hwNQoNjQ2RHO9DpZczCCq41vLqn4/CN8/gcwVVrBrmHvR/d4dYgOPg6PBGAz0qGRCMFvAV0ctoAe8JDBHzDulMFEE5J8SLe9D24C2ai96u4khF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1EsmT+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BF1C4CEDD;
	Thu, 20 Mar 2025 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742457123;
	bh=LpoG0RMzz7fNHCibF4J26zt4F7k2qKpDYABHIjcJWbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1EsmT+ZyuwER8PWWk+8VDDwn8MyxNR6/58Yh9KcqoPWHygFa/vTkGMHxde8NiRUb
	 UEgLZha98wOIWOlHM1c9b0JfY8TjZJxHZdVb/vcOtv4/lqWhFwtPJ4lW+E2C5YNFRz
	 WwrnZs00mOeqq3tzeFe8b/MbnKPCw2IjHvm75OB+AHk8YyCADbVzMRANLeZC0sTUOF
	 M7NElBp8F+z6n+H62jVYZ5bWrgl9cajxXzcFkjVEK+rdbM+NaL35GkbP4s8XbEjotz
	 GyTHa9bfjgoG7m+Oe46opYoDUPX1LuQ14MAxukVc7/urZ5SA+Dr55j/CYVpCjUhE6W
	 twqrKspucBoUQ==
Date: Thu, 20 Mar 2025 08:52:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "hailong.fan" <hailong.fan@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, Jjian.Zhou@mediatek.com, Xiangzhi.Tang@mediatek.com
Subject: Re: [PATCH 1/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
Message-ID: <20250320-cocky-adventurous-rooster-be2abd@krzk-bin>
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
 <20250320031753.13669-2-hailong.fan@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320031753.13669-2-hailong.fan@mediatek.com>

On Thu, Mar 20, 2025 at 11:17:24AM +0800, hailong.fan wrote:
> +
> +void mt8196_sof_hifixdsp_shutdown(struct snd_sof_dev *sdev)
> +{
> +	/* set RUNSTALL to stop core */
> +	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_HIFI_RUNSTALL,
> +				RUNSTALL, RUNSTALL);
> +
> +	/* assert core reset */
> +	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_CFGREG_SW_RSTN,
> +				SW_RSTN_C0 | SW_DBG_RSTN_C0,
> +				SW_RSTN_C0 | SW_DBG_RSTN_C0);
> +}
> +

Drop stray blank line.

> diff --git a/sound/soc/sof/mediatek/mt8196/mt8196.c b/sound/soc/sof/mediatek/mt8196/mt8196.c
> new file mode 100644
> index 000000000000..364069ce9954
> --- /dev/null
> +++ b/sound/soc/sof/mediatek/mt8196/mt8196.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0

Look here

> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Hailong Fan <hailong.fan@mediatek.com>
> + */

...

> +
> +static const struct of_device_id sof_of_mt8196_ids[] = {
> +	{ .compatible = "mediatek,mt8196-dsp", .data = &sof_of_mt8196_desc},

Bindings are before users.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sof_of_mt8196_ids);
> +
> +/* DT driver definition */
> +static struct platform_driver snd_sof_of_mt8196_driver = {
> +	.probe = sof_of_probe,
> +	.remove = sof_of_remove,
> +	.shutdown = sof_of_shutdown,
> +	.driver = {
> +	.name = "sof-audio-of-mt8196",
> +		.pm = &sof_of_pm,
> +		.of_match_table = sof_of_mt8196_ids,
> +	},
> +};
> +module_platform_driver(snd_sof_of_mt8196_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");

And here Hm? Don't fake the licensing.

> +MODULE_DESCRIPTION("SOF support for MT8196 platforms");
> +MODULE_IMPORT_NS("SND_SOC_SOF_XTENSA");

Is this correct?


Best regards,
Krzysztof



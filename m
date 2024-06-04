Return-Path: <linux-kernel+bounces-200451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9798FB038
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1CB1C232D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DAF145B21;
	Tue,  4 Jun 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFndo4/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903CB145333;
	Tue,  4 Jun 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497828; cv=none; b=R3YypN20uPiyAu+S6qtteXoRV6E0k2oCab6nxCW5HMJOQN43pXaT/75Dxbikmf40ajYxfB4NE6mHKyjYQPuADzU4WAa3u5YImn5L2DI7r82u4fa/Q88tpkUJcQi8+9ZFPk3VE4sXqQqgLcw1jb0ibsJF3z7xVEOlRRpTqZjyfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497828; c=relaxed/simple;
	bh=yGknayW3QQ0rwaJndYaKwkPne6V5zBr5l3Gf/k6pWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsW43EvU7J5KtGA1+xakBun5M1/CD1qROQtlaDt2p1JV+l5FW6IDgdMN+6N0VEpQZhXgaYbsrEYD5U/8dGtF5IorNohZDpChdr8PvDx8WFvD+9GDUjn99b/2oPDNeqSIjYBdu3aaWf4tO5+Gwfb4bggkyBbOxgHzreCCh0al3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFndo4/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18541C32782;
	Tue,  4 Jun 2024 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717497828;
	bh=yGknayW3QQ0rwaJndYaKwkPne6V5zBr5l3Gf/k6pWH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFndo4/bAX4UD1RYY7WGPu4LBwxL7SZEADNtg0GzaMhGV0lJiTDwKfdBS1E9kIinn
	 v3LUDzudl59ZMNzECxCkaKlVdBMjmpJD2UmYY9fMBxBZ+V44GeCF/x6bxVi8lfNwNN
	 lvzWoXSYIK2WYzb6gpf1q2KvDfhdS5fnAbYVkjTMCssTD306r9ggTC6YlVIl7t5D+G
	 FVkCrf1+xyKMBnWyfMp1eWLXMPwnmApXIrh4A0gmpPE8/J1Dga28KgU2f4TB6IFADM
	 lU1dua6PHtWUu2Ok4rU3wOqOB1r7LzhyzfY/ao7Z+URv2we1ke/y0TBq/qoI0OlkrJ
	 lHAGnLmUIzAzA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sERdq-000000002mT-3A19;
	Tue, 04 Jun 2024 12:43:46 +0200
Date: Tue, 4 Jun 2024 12:43:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: x1e80100: Add USB DisplayPort plug support
Message-ID: <Zl7v4hezEYcuCORC@hovoldconsulting.com>
References: <20240604094638.97780-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604094638.97780-1-krzysztof.kozlowski@linaro.org>

On Tue, Jun 04, 2024 at 11:46:38AM +0200, Krzysztof Kozlowski wrote:
> Add support for handling jack events of USB (DisplayPort).

> Depends on:
> https://lore.kernel.org/all/20240422134354.89291-1-srinivas.kandagatla@linaro.org/
> ---

> @@ -20,12 +20,32 @@ struct x1e80100_snd_data {
>  	struct snd_soc_card *card;
>  	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
>  	struct snd_soc_jack jack;
> +	struct snd_soc_jack hdmi_jack[8];

As I asked Srini, please rename this dp_jack.

>  	bool jack_setup;
>  };
>  
>  static int x1e80100_snd_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);

> +	struct snd_soc_jack *hdmi_jack = NULL;
> +	int hdmi_pcm_id = 0;

And use dp_ prefixes here too.

> +
> +	switch (cpu_dai->id) {
> +	case DISPLAY_PORT_RX_0:
> +		hdmi_pcm_id = 0;
> +		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
> +		break;
> +	case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
> +		hdmi_pcm_id = cpu_dai->id - DISPLAY_PORT_RX_1 + 1;
> +		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (hdmi_jack)
> +		return qcom_snd_dp_jack_setup(rtd, hdmi_jack, hdmi_pcm_id);
>  
>  	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
>  }

Johan


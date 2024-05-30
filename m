Return-Path: <linux-kernel+bounces-195149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2A8D4832
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB111C21BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEEF6F30E;
	Thu, 30 May 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkAHxZxm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799218396B;
	Thu, 30 May 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060572; cv=none; b=fMncMKzKnDxWi2kIWMhkYmINycqqgI6yXtlbXSUlqNfiGJj6b34x9RjnC53dkdMkqDPGQxOvSDbdU5KOcyNHq4AnNK055xaFSU5nxKJoW5wVAYTq3PeWOE3wmETvd8NZyuPVkSAGd93ckq9V20Y4ZzhvNXhqtGbeBvXVpyPkv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060572; c=relaxed/simple;
	bh=AQM2lahhdlmVdayxw+qgYQXGA18NxsTQtlliH668hJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ2kMdRIC4OGNiT3C3RkDaL6nsaBEliavJJvKUmMry9PQup2+6wI1RZgHPA9CmTNAQ3A/FkQfGWvaHktPT9Jyqrt2KllysOlU8eFZV7oyzzV/rVFSzOCfgaHRGneoOXCcL9PCESVb3vzMf/L19C+XVPsLjwERiumlq3CV7mA7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkAHxZxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276A1C2BBFC;
	Thu, 30 May 2024 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717060571;
	bh=AQM2lahhdlmVdayxw+qgYQXGA18NxsTQtlliH668hJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkAHxZxmhRTGUGj2f/G9QVsM8D2wrN7oOowdxnoP7N6WJwEfDiuZX8/9nzcmH/biA
	 oBavLoTbTAPZm7vcTo0+Afpr6JDTGaDkjq33No4kNo0P5PSjJEfziInY0Bu0qhx6iA
	 1ABi1ogr2oJvJmQoweDbBHHupRbvVs+nZN5xc9jgupqQub/JdgI4shrW2rZEesTIO1
	 PjzlAOR0q6NmiJSaPtPWarr9DQGeimOHgRqr3MPMUzHSSMX7jEr62fyq3CeGj926gH
	 tAmo8NYb7e8+Whde8PIkKZeyAWzWXrfO281beyIXR3bsnC/QdO+MMPV0A6prb+fzdI
	 /L2K1HqhXt3+Q==
Date: Thu, 30 May 2024 11:16:08 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] drm/msm/hdmi: make use of the drm_connector_hdmi
 framework
Message-ID: <20240530-poised-burgundy-petrel-7affed@houat>
References: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
 <20240530-bridge-hdmi-connector-v3-5-a1d184d68fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="5forzva7txjtgmqb"
Content-Disposition: inline
In-Reply-To: <20240530-bridge-hdmi-connector-v3-5-a1d184d68fe3@linaro.org>


--5forzva7txjtgmqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 30, 2024 at 02:12:28AM GMT, Dmitry Baryshkov wrote:
> Setup the HDMI connector on the MSM HDMI outputs. Make use of
> atomic_check hook and of the provided Infoframe infrastructure.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

As a general comment: I really like it, it looks super tidy. Thanks!

There's a couple of minor issues below

> -int msm_hdmi_audio_update(struct hdmi *hdmi)
> +static int msm_hdmi_audio_update(struct hdmi *hdmi)
>  {
>  	struct hdmi_audio *audio =3D &hdmi->audio;
> -	struct hdmi_audio_infoframe *info =3D &audio->infoframe;
>  	const struct hdmi_msm_audio_arcs *arcs =3D NULL;
>  	bool enabled =3D audio->enabled;
>  	uint32_t acr_pkt_ctrl, vbi_pkt_ctrl, aud_pkt_ctrl;
> -	uint32_t infofrm_ctrl, audio_config;
> +	uint32_t audio_config;
> +
> +	if (!hdmi->hdmi_mode)
> +		return -EINVAL;
> +
> +	DBG("audio: enabled=3D%d, channels=3D%d, rate=3D%d",
> +	    audio->enabled, audio->channels, audio->rate);
> =20
> -	DBG("audio: enabled=3D%d, channels=3D%d, channel_allocation=3D0x%x, "
> -		"level_shift_value=3D%d, downmix_inhibit=3D%d, rate=3D%d",
> -		audio->enabled, info->channels,  info->channel_allocation,
> -		info->level_shift_value, info->downmix_inhibit, audio->rate);
>  	DBG("video: power_on=3D%d, pixclock=3D%lu", hdmi->power_on, hdmi->pixcl=
ock);

pixclock should come from the connector state too. It's still calculated
by the driver in msm_hdmi_bridge_mode_set

> @@ -341,8 +425,11 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi)
>  	bridge->funcs =3D &msm_hdmi_bridge_funcs;
>  	bridge->ddc =3D hdmi->i2c;
>  	bridge->type =3D DRM_MODE_CONNECTOR_HDMIA;
> +	bridge->vendor =3D "Qualcomm";
> +	bridge->product =3D "Snapdragon";
>  	bridge->ops =3D DRM_BRIDGE_OP_HPD |
>  		DRM_BRIDGE_OP_DETECT |
> +		DRM_BRIDGE_OP_HDMI |
>  		DRM_BRIDGE_OP_EDID;
> =20
>  	ret =3D devm_drm_bridge_add(hdmi->dev->dev, bridge);

It looks like you're not setting either the supported formats or bpc?

Maxime

--5forzva7txjtgmqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZlhD2AAKCRAnX84Zoj2+
dvdkAYCryHF7SD2wn1N8TdrGd15DJPIga+r9drDaxTr0rBTOxzbQF7x7YiyX2hH0
CTeY9AsBgKWaEKe7Dbe67TtNLnv9K8XLecp8Gdd4Q7qOdun/xGlo9UWqcOTNeHVb
uIQEISEO9A==
=tPbA
-----END PGP SIGNATURE-----

--5forzva7txjtgmqb--


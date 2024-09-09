Return-Path: <linux-kernel+bounces-321657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D84971DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8490B21965
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73372233A;
	Mon,  9 Sep 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVWS7fJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2FD1CFBE;
	Mon,  9 Sep 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894812; cv=none; b=DsOVXBEG/cgvOq+5nNvwXrhwEdRtO5J2R8A9/az2qan0wnsvcKAONIkZezhRkstKc/xMo5gq/3aKYy5oIRMvgT6YbI3Tjq6oVm2JcVE+t4jadmqUUAKViNYKOq0L3fHVyyev263ZRsujtdiBlFjnToRSdDJE21nTF+mLKjb/cX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894812; c=relaxed/simple;
	bh=yV2uXKxMqi7mz1WN5z5wldbH9IOzkDhnMu2iCjQncXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBi/hniS5MksEQNH9YgCVGAE2hOq55b62kPF0PO20bPGs9TUYiz7qnQsWnqL2G3193n4wdBgRq9TWR632LjA2qPNv/emWS8YNZdt8ZuefkqFJe9Qe4s9HdoUaGSU06eKetrWSdBdyZZQ31vrTPqVg6MYLtFwkZHin5b5G3HZt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVWS7fJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4081CC4CEC5;
	Mon,  9 Sep 2024 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725894811;
	bh=yV2uXKxMqi7mz1WN5z5wldbH9IOzkDhnMu2iCjQncXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVWS7fJjWHCb2XkF55GdXZwdBa+k3fkK+cw4UAr3EqvXyTfI5HLn3r58KlFT/WDsV
	 PbYkTrZ4q73wlMOAtln4UfzZhSNyw09TeVtwWa9cZstso/O6rFXy/25dKOep/Z+Lqg
	 2/ryq9Rmmkg/IT5inkt7UJmyMX4C4VjXEEqEufpvMSldUx7grYFUZC95ESgJAwIzqp
	 Lfbvi7+DUpG3/H1Hdd1NyUrzTIdwyD9Taohfem49TD5DdHFTf1Sos/GP3wif/E8ULa
	 6UG4dRuiD7mru0RBVt1NTuKA9fFOwcen268rsBW+UcX49ttd79K4myATTYwdclAO0M
	 hTWfZ2LATQ6Ow==
Date: Mon, 9 Sep 2024 17:13:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v6 1/3] drm/bridge: synopsys: Add DW HDMI QP TX
 Controller support library
Message-ID: <20240909-horned-congenial-curassow-ebc5fa@houat>
References: <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
 <20240906-b4-rk3588-bridge-upstream-v6-1-a3128fb103eb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="a6pjesfz3btllyif"
Content-Disposition: inline
In-Reply-To: <20240906-b4-rk3588-bridge-upstream-v6-1-a3128fb103eb@collabora.com>


--a6pjesfz3btllyif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Sep 06, 2024 at 04:17:40AM GMT, Cristian Ciocaltea wrote:
> +static enum drm_connector_status
> +dw_hdmi_qp_bridge_detect(struct drm_bridge *bridge)
> +{
> +	struct dw_hdmi_qp *hdmi = bridge->driver_private;
> +	enum drm_connector_status status;
> +
> +	status = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> +
> +	dev_dbg(hdmi->dev, "%s conn=%d scramb=%d\n", __func__,
> +		status == connector_status_connected, hdmi->scramb_enabled);
> +
> +	if (hdmi->scramb_enabled) {
> +		cancel_delayed_work_sync(&hdmi->scramb_work);
> +
> +		if (status == connector_status_connected)
> +			dw_hdmi_qp_check_and_set_scramb(hdmi);
> +	}
> +
> +	return status;
> +}

Unfortunately, that won't work. The HDMI Spec has (HDMI 2.0, Section
6.1.3.1 - Scrambling Control):

The minimum time period between the write to the Scrambling_Enable bit,
and the transmission of a scrambled video signal is not specified;
however the Source shall not begin transmission of a scrambled video
signal before writing a 1 to the Scrambling_Enable bit. The maximum time
period between the write to the Scrambling_Enable bit and the
transmission of a scrambled video signal shall be 100 ms.

So you need to disable the output and enable it again.

vc4 does just that, you can have a look here:
https://elixir.bootlin.com/linux/v6.10.9/source/drivers/gpu/drm/vc4/vc4_hdmi.c#L410

Maxime

--a6pjesfz3btllyif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZt8QmAAKCRAnX84Zoj2+
djUdAYDRdEgSW7Wj/UA+T/XsaiAocjWHwnktCrXecrwrTQQLmwTpGoDKU6nmsxBR
eU74UeEBfiF7DgCZ3hfYdjQvzGKKyzvQQQitqxvSxT4+rBQyGtUKC89mLd+1wOlo
uzb+gTqbBA==
=hgwR
-----END PGP SIGNATURE-----

--a6pjesfz3btllyif--


Return-Path: <linux-kernel+bounces-302918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED227960503
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57474B21B94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB509199392;
	Tue, 27 Aug 2024 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkFzgDgD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15799158DD0;
	Tue, 27 Aug 2024 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749140; cv=none; b=YthRMQob5GuOfnY8zEn6OEvjahB0PRddcqqjA+4rvZiC19mgs7xucWn5HaYq5anFLVy7ig+SHP2r/RC3/s3zsIfX+4NCU/AdjAVldT9K5KIP9h1Ex1XUvjGCVgUJGPu1131BgGxxSaCV2Ui24R8V62GKAkALJbZxLbJMrDVlFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749140; c=relaxed/simple;
	bh=brMwUnoxrTvNJcSO2RG6nxbRHtnEcIrTU0qQDmJE/7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMko8M2iIAsICHqgESsihoexYWO/QtqIKXH+jr5G1x50ReBf0E9PYI52ffZkpM2xit82BDJmaYkpUY6VYWyNUxlNsoZqnsaKQuo1Bmp6UOaeGebzsXzdIp7XPZuTOI/6gFF94MyoTVSoW1uNLB1rHPekJ6M4ehSB4rIXIJrvhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkFzgDgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D68EC8B7A5;
	Tue, 27 Aug 2024 08:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724749138;
	bh=brMwUnoxrTvNJcSO2RG6nxbRHtnEcIrTU0qQDmJE/7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkFzgDgDObrJZ62sKyhzDaQWPSu69zfgIIlt6JriR+Pd+4k0BmqKPB5RbGnecjA+g
	 qrGPlLmMaEkmKURMJdZtNLM/xOqwwECLm25Is6vmmxu4L3+ZRXd+ZdvABVItbUmZ4S
	 /T1q9GAaxJgA06eVBchBKVVsoeQfjkYnrsjNIrwOPhYwTTF/XtFvX5ZDqw94r0x0MC
	 HDe8z9qhw+nsOizgwq0aPnslhBS2LAXKi/fU7D1LcyI1BQQP9y+MwNcCDlNTRf3Ohd
	 MH0JYXGNSbadD7+cswhubahggRqDZMbRHcFYw0ZvTvIm7gvhwoBy07crol/e58A2A+
	 ZH5UQRyzp3JFg==
Date: Tue, 27 Aug 2024 10:58:55 +0200
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
Subject: Re: [PATCH v4 2/4] drm/bridge: synopsys: Add DW HDMI QP TX
 Controller support library
Message-ID: <20240827-armored-magnificent-badger-ffb025@houat>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <20240819-b4-rk3588-bridge-upstream-v4-2-6417c72a2749@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7d6czoxivc6cezpy"
Content-Disposition: inline
In-Reply-To: <20240819-b4-rk3588-bridge-upstream-v4-2-6417c72a2749@collabora.com>


--7d6czoxivc6cezpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 01:29:29AM GMT, Cristian Ciocaltea wrote:
> +static irqreturn_t dw_hdmi_qp_main_hardirq(int irq, void *dev_id)
> +{
> +	struct dw_hdmi_qp *hdmi = dev_id;
> +	struct dw_hdmi_qp_i2c *i2c = hdmi->i2c;
> +	u32 stat;
> +
> +	stat = dw_hdmi_qp_read(hdmi, MAINUNIT_1_INT_STATUS);
> +
> +	i2c->stat = stat & (I2CM_OP_DONE_IRQ | I2CM_READ_REQUEST_IRQ |
> +			    I2CM_NACK_RCVD_IRQ);
> +
> +	if (i2c->stat) {
> +		dw_hdmi_qp_write(hdmi, i2c->stat, MAINUNIT_1_INT_CLEAR);
> +		complete(&i2c->cmp);
> +	}
> +
> +	if (stat)
> +		return IRQ_HANDLED;
> +
> +	return IRQ_NONE;
> +}

If the scrambler is enabled, you need to deal with hotplug. On hotplug,
the monitor will drop its TMDS ratio and scrambling status, but the
driver will keep assuming it's been programmed.

If you don't have a way to deal with hotplug yet, then I'd suggest to
just drop the scrambler setup for now.

Maxime

--7d6czoxivc6cezpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZs2VRgAKCRAnX84Zoj2+
doR9AX9jVRhemySX3ezsY45XTCyYbffOw0vhn1iAZ9FcKrlkjaZ1jF3VuvQVlqV+
CgkFKFwBfRfYZWXSy78SdiB2VLCDGrHhrKCyjwCWW4R2Le9bIP4lzSh1HDBv4FFA
JXPD9gbLhA==
=OVt5
-----END PGP SIGNATURE-----

--7d6czoxivc6cezpy--


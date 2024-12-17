Return-Path: <linux-kernel+bounces-448801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B489F45AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A70188D074
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C69B1DA0ED;
	Tue, 17 Dec 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+vowBXn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3318126BF7;
	Tue, 17 Dec 2024 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422800; cv=none; b=ef+G1RdbK1zshx/VbeF3TsmQLvS9ouzoJsDfxENembbWu2Jcf7zOsEDK/pDlff1K3NtZhN0bmH60z5ECeA39FdNa8yyCxfwIFvvWL/Gdh8A1l/VmsNYIybidD1YYRmK698hZhzEHcVLtho9JWAny/e8ctatql90O3/1VgPMJy4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422800; c=relaxed/simple;
	bh=lezp6EOr1sTrbOd8jVW8DSk++wf4bf36AnptRA4PyH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5yGG43Y8oxqeyhKpnQMGXEPzo9Lxjd/Ft70yjTvBDD2VwFusawyeI9wrgfv66JmHqKSUxD3Q2SReE6pUkeKoBBISf+rn9OHo13udSaGnx5Jod9jHNeWk552MoS1/t2EepEQ49xJzW5qdl2B4WdhWDE9gUsoZJRmLtdzzS1DjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+vowBXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0607FC4CED3;
	Tue, 17 Dec 2024 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734422800;
	bh=lezp6EOr1sTrbOd8jVW8DSk++wf4bf36AnptRA4PyH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+vowBXnjBaLUcuH3ZNTlxuYXFlQoFs+HB+3snpwxM1GcMu32ovTLikNU/IGawtnc
	 r3cwON5Peqm4GfLiMitiu+BtPNNxdYI8go7HgZO2CYqt9dw1OWu9tKL71pWVzzY++4
	 vZB2IcRIxWiznIJeOfvJzgWru5L9OGuWaUBz711FfpLvLU7lx3S95Jfwz57W8GzpM+
	 28k3ygSVqpUKOCM03xWFzm7svkTDrNjht5c0paP7Y5FDr0ng6aTkQiUpTA3uN2vL2a
	 swxqAfXJIO6wbed7cknFYAUCK3x/CJxvG2mIu2B1jqCZ4tLzKzFUY2JSUaoWL/DohT
	 OvNixEsVkwTJg==
Date: Tue, 17 Dec 2024 09:06:37 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	vkoul@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v20 5/9] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Message-ID: <20241217-judicious-stereotyped-centipede-5ddb27@houat>
References: <cover.1734340233.git.Sandor.yu@nxp.com>
 <fbd12029fab1f60e2ba4fad75ef650298a59cb15.1734340233.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="f3jzfinrd3s3htcj"
Content-Disposition: inline
In-Reply-To: <fbd12029fab1f60e2ba4fad75ef650298a59cb15.1734340233.git.Sandor.yu@nxp.com>


--f3jzfinrd3s3htcj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v20 5/9] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
MIME-Version: 1.0

Hi,

On Tue, Dec 17, 2024 at 02:51:47PM +0800, Sandor Yu wrote:
> +static ssize_t firmware_version_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf);
> +static struct device_attribute firmware_version = __ATTR_RO(firmware_version);
> +
> +ssize_t firmware_version_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct cdns_mhdp8501_device *mhdp = dev_get_drvdata(dev);
> +
> +	u32 version = readl(mhdp->base.regs + VER_L) | readl(mhdp->base.regs + VER_H) << 8;
> +	u32 lib_version = readl(mhdp->base.regs + VER_LIB_L_ADDR) |
> +			  readl(mhdp->base.regs + VER_LIB_H_ADDR) << 8;
> +
> +	return sprintf(buf, "FW version %d, Lib version %d\n", version, lib_version);
> +}
> +
> +static void cdns_mhdp8501_create_device_files(struct cdns_mhdp8501_device *mhdp)
> +{
> +	if (device_create_file(mhdp->dev, &firmware_version)) {
> +		DRM_ERROR("Unable to create firmware_version sysfs\n");
> +		device_remove_file(mhdp->dev, &firmware_version);
> +	}
> +}

sysfs files are part of the uABI, and need to be stable and documented.

For these kind of things, you should use debugfs.

Maxime

--f3jzfinrd3s3htcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2ExDQAKCRAnX84Zoj2+
dnc4AYCqAZF9d60JM6qP2gOgYAn6lAKF42a7J9At1vpspnjLkxWeo82wwxsVUN3q
dX1sPvsBf0FnUgCipeCjavvQGCADOKKD3bokWMMWhfpqBINEp3TxubYkPBBuPx7Q
x5ViCYwzhw==
=BgFt
-----END PGP SIGNATURE-----

--f3jzfinrd3s3htcj--


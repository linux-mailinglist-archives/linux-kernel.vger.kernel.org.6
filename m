Return-Path: <linux-kernel+bounces-229146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA4D916BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657601F281A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFFA16FF36;
	Tue, 25 Jun 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNubxXsR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379116F29C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327725; cv=none; b=dVyz9ItvhgMhRhZE3xNtmD5xb9yWTjM826qxeAY6Svv9HqMZN4oCpu/b2n4VwnSMIx5P+MF2lU8PZbVq4qPJrfLGgLikxA3P7ZTArBTVol+isrMDLQlN4NKKkP7gEoIbJMoHkd31pIotRTF2J7AWGGi05CbDhhz4J9cdPyPMcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327725; c=relaxed/simple;
	bh=INcxNrZ3BKjPhQAlptK0WjFeAG+V7+PP8PzXSvOmrp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNIa0hyvvc7TmMddtuYpMehEttwMsNzQRufx01IjurGawrJyayCloq1MZwz+iCtbas8Gi9x9gn+82RBmhyD8NcBPRYc1sjG5FPqt7F96i7RuI38X33ygdgvQhBGncqKcaqqZb9YJDOMQ1M/5wiaLMi2iMEltn2r0ckaslsZiIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNubxXsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B1EC32782;
	Tue, 25 Jun 2024 15:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327725;
	bh=INcxNrZ3BKjPhQAlptK0WjFeAG+V7+PP8PzXSvOmrp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNubxXsR8135P9Ti0UdT/F7+tHikXwxB3dgj8F7oClalIBZxZyLnO11IlQ1PwQNOR
	 Z0eV03pVqnEhU14faRurBffY8m9Kqcmhn6JOc5A+d8n8BNVWDEgu4iEtciTh82YOxZ
	 X1xVIuqr//E4wTzFGd2LMBmTzp0UEs/bduOaSEt/CdYCvu324Qiq+gr6/HsshRvSHy
	 wpJsfK4zNHHMXVPR9i5qTgJQ8911iRmmYbfT1vHzwYbJvYhvEjUHt9QU2RmtYou8MS
	 8LsrtOK70CTxUaVoI3Z9PmHQcv9wKWB9tbP/QfoZPDtzNRaVm5kFUpxKoKKnQylYe9
	 WCHbD46uaz83g==
Date: Tue, 25 Jun 2024 17:02:02 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/bridge-connector: reset the HDMI connector
 state
Message-ID: <20240625-feathered-loon-of-health-ec7e6d@houat>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eciqjr2zrynuoq6o"
Content-Disposition: inline
In-Reply-To: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org>


--eciqjr2zrynuoq6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 23, 2024 at 08:40:12AM GMT, Dmitry Baryshkov wrote:
> On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
> IGT chokes on the max_bpc property in several kms_properties tests due
> to the the drm_bridge_connector failing to reset HDMI-related
> properties.
>=20
> Call __drm_atomic_helper_connector_hdmi_reset() if there is a
> the drm_bridge_connector has bridge_hdmi.
>=20
> Note, the __drm_atomic_helper_connector_hdmi_reset() is moved to
> drm_atomic_state_helper.c because drm_bridge_connector.c can not depend
> on DRM_DISPLAY_HDMI_STATE_HELPER. At the same time it is impossible to
> call this function from HDMI bridges, there is is no function that
> corresponds to the drm_connector_funcs::reset().

Why can't it depend on DRM_DISPLAY_HDMI_STATE_HELPER?

Maxime

--eciqjr2zrynuoq6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnrb6QAKCRDj7w1vZxhR
xaDaAQDbirOcRJFXYMvi3AKNZOjDVfThaLfVJff4sukVoq4dDwD/VNP5qyY7y2ZR
HY41NMoYCoKnWRZsHLDLNdlbLAKdwgk=
=/z+8
-----END PGP SIGNATURE-----

--eciqjr2zrynuoq6o--


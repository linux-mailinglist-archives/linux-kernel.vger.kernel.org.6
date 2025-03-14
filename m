Return-Path: <linux-kernel+bounces-561956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BEAA6193A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94163A244A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE562046A0;
	Fri, 14 Mar 2025 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+M9C0wO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD8202F96;
	Fri, 14 Mar 2025 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976298; cv=none; b=bYVR7TixCCD2EOB2iI94VTN/cAvnSfTCxzj9B7e6OGx301m0DWp6Fy6uM97qwqlP3PV1L2fdWFekUV6cnc7iBYDHBcd4wjfjAbeLl6sdL0tsxmd75TzhIwCpwFtHZaeJXc0icxCnQTQ/K8dGbnG/idpwGELnIfTXcTRCpOG5C7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976298; c=relaxed/simple;
	bh=ZZepI8LPNaIPgCHzOcgRGZobZ670sZugs/z/7viGW38=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=eBmtGGHhjl40LgXmJ4Oraeg4R3AGCnReD3AqgIgEQj1WEskOKPdo6kUrah3zWh2A0OzHArAY8ype6dxkqjfcHXY7j8FjavvAvOXGTeQQK+hOcxuy6mTjrv/Hotivs9GGSuaOnVWLb8AmupjViQY4NHVKa0NPjq0/mDU6JJgLS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+M9C0wO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A648FC4CEE3;
	Fri, 14 Mar 2025 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741976298;
	bh=ZZepI8LPNaIPgCHzOcgRGZobZ670sZugs/z/7viGW38=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=T+M9C0wOPRULtny0dMIpwd1MQh6HhJIspUv2IWXZUEb/eyNziep/h+bAMFF0ciyrc
	 gqQnmpoPsiqBcTf9jmWtvBDJU7fUQsOuDoei/DxS89x/Bwh8rYWBAfH/yQZH5w/RE3
	 W2V5+iejNtwvnHVNGudeKC5J4AzgreZEu203VbUD72MZ9wXrb89KsGDVBExc2oFjB2
	 81pXQSWHH733fLwNZdbTI7Pp7CXveyo1XKwL5XlOzroTaBIn2JWUpegy2ecmLN26iy
	 Fc6yhY31xoJydnY8CoC/HzADCoH1EiH6riWuqnhnvlpxECDLki9uN3FyWI+k7LlLe/
	 kYGiYv4VtgmSA==
Message-ID: <6d7ef2d51bc98436fcfc7fa9076514ec@kernel.org>
Date: Fri, 14 Mar 2025 18:18:15 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 11/11] drm/bridge: samsung-dsim: use dynamic lifetime
 management
In-Reply-To: <20250314-drm-bridge-refcount-v7-11-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-11-152571f8c694@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Anusha Srivatsa" <asrivats@redhat.com>, "David
 Airlie" <airlied@gmail.com>, "Dmitry Baryshkov" <lumag@kernel.org>, "Fabio
 Estevam" <festevam@gmail.com>, =?utf-8?b?SGVydsOpIENvZGluYQ==?= <herve.codina@bootlin.com>, "Hui
 Pu" <Hui.Pu@gehealthcare.com>, "Inki Dae" <inki.dae@samsung.com>, "Jagan
 Teki" <jagan@amarulasolutions.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek Szyprowski" <m.szyprowski@samsung.com>, "Marek
 Vasut" <marex@denx.de>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Paul Kocialkowski" <paulk@sys-base.io>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Robert Foss" <rfoss@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Stefan Agner" <stefan@agner.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 14 Mar 2025 11:31:24 +0100, Luca Ceresoli wrote:
> Allow this bridge to be removable without dangling pointers and
> use-after-free, together with proper use of drm_bridge_get() and _put() by
> consumers.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


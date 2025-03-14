Return-Path: <linux-kernel+bounces-561954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C466FA61936
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E538E3A92ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE89204081;
	Fri, 14 Mar 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUZr8M+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640E14A0A3;
	Fri, 14 Mar 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976240; cv=none; b=YgTDwBF7YdaNdmgi8Z7YHSff+3s+vX0smQa/FrBqc6fGxR9C4Xb8f4iTpZm9iRIu/eby/CiNor2rcw2X4RYDbmQw5jTBtrCiM2tyI4JXRtVzsiVFO/nu04mNCoxQzwFCnMICMORxoVgJ9JJC8WLlr0z5Gyxdj42N4I6+Tz+f5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976240; c=relaxed/simple;
	bh=1BOoTpa7j7kOWDgvxrb0tXDEr/wUI29Rp0UJrHYohJA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=sRymJ2SqesJXtUJ4KhSpqs3hiL8xjbdFUYoVdV+HtPyLzL6m5Z7ybWQfNnYVgto83jTrR/Q2vsRVDjO6X52q9UQaqZbmzZt02PktmlGYvNo9vNFJ63CdxPT1oPkOfzZ6qCJKx5ub/TOl5hP7bqMluxXkif7a+HBZL1EJ1HhoTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUZr8M+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E9C4CEE3;
	Fri, 14 Mar 2025 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741976240;
	bh=1BOoTpa7j7kOWDgvxrb0tXDEr/wUI29Rp0UJrHYohJA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=pUZr8M+5YqTB0gwHjL2uSg75N4jc4CDIxlCHb7r1mXjx3YKJCmr8XK4iL2+emxFei
	 lX2P5axT3LQE0vqeQiA9N6V6JNTGttlyHixDMwDJbeY7sE6LXdmX62UZ/mLGzaF1PU
	 sjWxU+hkq4nT+hHhYo/NY/ggRFfO5MJ+KMinzqjzhJW+1fjnTsQZst58KpmkzNFSkw
	 Ncw+wZWsjOUl3j7zOLzEFpzV1gSUqyozZTFKyb/8rC28QAuuhb7M8Tn5DSPCt1Vub3
	 H6hpRu+O4ZAO2S36uWVrdlryZxxok2R3VVfiu1ZRaOl4IvEra9sYRV9cEhTxpTGVu6
	 2Q/eSha1g30iw==
Message-ID: <028ca14a547f52456a10529508cb0207@kernel.org>
Date: Fri, 14 Mar 2025 18:17:17 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 10/11] drm/bridge: ti-sn65dsi83: use dynamic lifetime
 management
In-Reply-To: <20250314-drm-bridge-refcount-v7-10-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-10-152571f8c694@bootlin.com>
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

On Fri, 14 Mar 2025 11:31:23 +0100, Luca Ceresoli wrote:
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


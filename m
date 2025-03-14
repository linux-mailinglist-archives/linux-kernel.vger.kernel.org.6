Return-Path: <linux-kernel+bounces-561952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F36A61921
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF7A176B99
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A7204598;
	Fri, 14 Mar 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9hk6SIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A461FAC34;
	Fri, 14 Mar 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975979; cv=none; b=I91J9QwadzrIGCFeYAwX7caD7nGEqZusY/JgyLxQt1kuuvbvMVPtKpHJyLn2uwMw1yUcl4jYUCelSi3J0Dcm+zF8of0ZU3TIJsGzKfCcKqPrDoBTU7pvbOMdyAECRjg96VmBlmlvZSG6J408EGHXS/PGu4xhknRL+Z6gd0gqewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975979; c=relaxed/simple;
	bh=j5F5voyqMDf/Acb+Qij3yNPtv2PhlZR0mqxo0ZOIE8g=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=WMB8GMmM/mEklcY9MNlI1T5ARlkTcSnoqmW2ImzJ+mmYkP2iLs5ZVgqxs26kgP0IEtH50feDqKQK5MS3HGwdGbC0dnbasDCt8ok2U/X6fnd7N+VFGVck4kEEa8/UgbwlJeeJY945yGTozoDBJDZL9tCvufCyxxxO6JRY1dzxS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9hk6SIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A112C4CEE3;
	Fri, 14 Mar 2025 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975979;
	bh=j5F5voyqMDf/Acb+Qij3yNPtv2PhlZR0mqxo0ZOIE8g=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=p9hk6SIOYoS2epV0wJxk40iVLBI/2s1h2Vw9v3hso51YWQnMQOVnWh8snIwvEOLeN
	 QMrxmUvXFWSNXOt4+QtFsOjAp7w6B9qrI/IA+TGqPobkBPN/+YI8K2Y3aMLudmUXpz
	 nKHB7WvV48iMPitNP6aq0BYneYwVkShT8WQmTcLAaAU37wtzDO9nwwpS/LXn44D4GY
	 bZpUNiMp/oTrZH5H7O2RMa12mZUFRKuZyNGerFmtAsQiYxx+rotnCqNSmW5G7capiI
	 GRixaeMfk64vPGV9H8O+K8WJ6abRCVb2zrXqqUO93oQEV1Or3i6EgK6CnlaUGU6khC
	 AsgBYYTQzGxWw==
Message-ID: <0cea0c073dfc52c20f583d64b51d7951@kernel.org>
Date: Fri, 14 Mar 2025 18:12:56 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 09/11] drm/probe-helper: put the bridge returned by
 drm_bridge_chain_get_first_bridge()
In-Reply-To: <20250314-drm-bridge-refcount-v7-9-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-9-152571f8c694@bootlin.com>
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
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 14 Mar 2025 11:31:22 +0100, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_chain_get_first_bridge() is
> refcounted. Put it when done.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


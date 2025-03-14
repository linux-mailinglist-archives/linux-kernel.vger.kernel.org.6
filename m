Return-Path: <linux-kernel+bounces-561946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C13A61903
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2997416B586
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE48204098;
	Fri, 14 Mar 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzeTk1PC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA91FDA76;
	Fri, 14 Mar 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975533; cv=none; b=cvDyiKVU7OWYRhPaXOYg45FkNs7NiQ23fuHA6XxLyemli2jSQnAk8OwAzkkXyCE/7IdEvctCFcT9bJWBF1Kn5zJwSgx0xGCcce+p/icRMULy95HgeSxPJbpgyrgyoiTF8ealXbhPeoeqpdFrKS/alv9IScHrHf4fvdGdpnufCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975533; c=relaxed/simple;
	bh=lhEsW5DulyDSp0JArffKcqrIScwbmbvbf0ZjrL1HpS8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=RYrlm+SdugSGWHPUg8eOpRRetGvEFYzst9X/QuFuZL49YCriSffeXCoerDeI/HSU5EUmaPA7BLchXwrJZRH8NPUGfsk7wsV9MctlZDYmZG6aNOTT7WMZIUFeIuP1yJat3gB/yJsMqPPU0esF1d0b0WkOiPpCNY6dYQt8Tfgumqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzeTk1PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BDFC4CEE3;
	Fri, 14 Mar 2025 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975532;
	bh=lhEsW5DulyDSp0JArffKcqrIScwbmbvbf0ZjrL1HpS8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=gzeTk1PCeOr6rPGhDbklSh+BDQerfNde0ttF/29dB0QzvQXCnn998ZRW02qHJTf5C
	 2Dp5kPrBi+P7sNsz1LWOzMKJNWEBvTt1JGAnqdFqujlhDf1a4C1VUDWCK7y8UZuh5g
	 V2CCeB04bQlWY69deQ1X+2heBphAGne3remu2rcmLCfDuoGvqy+4uUvkj5DYqNuGw6
	 oUqnDOTKy6xlvV1VM8WTTJpZP0I+uOsEbzK343Y0y0j6+4JJiTxFazz1fWIwjQA93b
	 /yBSGrPOXHFnIuESpBNdwRDh9o7Ds3tyG5Ofc7yXqHzWHtNqmGSfP6S0H6Ez3mAgcd
	 SYJyZ0Bdw7npQ==
Message-ID: <50d94c0223e60881c014bddd55382692@kernel.org>
Date: Fri, 14 Mar 2025 18:05:30 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 04/11] drm/bridge: get/put the bridge reference in
 drm_bridge_attach/detach()
In-Reply-To: <20250314-drm-bridge-refcount-v7-4-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-4-152571f8c694@bootlin.com>
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

On Fri, 14 Mar 2025 11:31:17 +0100, Luca Ceresoli wrote:
> drm_bridge_attach() adds the bridge to the encoder chain, so take a
> reference for that. Vice versa in drm_bridge_detach().
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


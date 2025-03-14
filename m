Return-Path: <linux-kernel+bounces-561951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD0A6191F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE993AEA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C13204C0D;
	Fri, 14 Mar 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6JAwhgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57920487F;
	Fri, 14 Mar 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975935; cv=none; b=UQ2EApuKi4XcCjVd/LJaRrGk7OsMdLvpb6/W9DbpxS6Qc8ePpnEDoGTRUvRaAFNjPE8q0qItPeSEpCYuE5/TPHsikLTD+l+KRrzkPTaeg1sKdAGu3JI6aFUY9VNjSTttCnbonyNN2f6c0AXxv3VC9shzrx4E48NUoa9MsDei4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975935; c=relaxed/simple;
	bh=BctqkYo2GOjqZQkTh09D8VX3tCtmfb7LPK3ctO2t+vU=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=uts7YmeEzDDiAXwKAi3h7+6Sud/hBc7aduT3j0Qn+ZaEQ8Qg7TUNC5Go+NSu0/jcJhwOvQnXyVTl7jUffp1gs9MM4RrJzloqZP0jtrf/OFMOHsENw/g3sdaLPCQNXtao9Wj6vLpFDX8JNdHLwJmAFe0huJouO6prpQ59WL3Tdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6JAwhgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978FEC4CEE3;
	Fri, 14 Mar 2025 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975935;
	bh=BctqkYo2GOjqZQkTh09D8VX3tCtmfb7LPK3ctO2t+vU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=U6JAwhgVTRgbNxmvvPxxXMYTyVP24msU5iabUCxVLo9/OF/ZFSoOHaj6KV6EiF02E
	 BWVK5OWUq408QJ1AjLxi+TdJWPQ+JoDQtaHsmQ1k77Jf8Yl91QLzUIBTzqnBvh9RXU
	 BTIlavnBHmiYpXu/DHZm6/0ok/6mQ6JqN5C52MePVuf4AQpoWl0kGA1a+NipR/RRHn
	 4i4vSSmAHYDjYscRv3I1Ek6mH8O+AM70+eswkGbGABh7x+nKGY3pGiu5WuxLo32HIY
	 macBE23mghrdHgYo46GBrW0LslYO0WoPJosqrevcgxPKdUJ9mhNdO6/kkpM8+OPCnw
	 YZ8bauKXnyHFg==
Message-ID: <1da3c1ee7b8c39e200437ac622238221@kernel.org>
Date: Fri, 14 Mar 2025 18:12:12 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 08/11] drm/atomic-helper: put the bridge returned by
 drm_bridge_chain_get_first_bridge()
In-Reply-To: <20250314-drm-bridge-refcount-v7-8-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-8-152571f8c694@bootlin.com>
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

On Fri, 14 Mar 2025 11:31:21 +0100, Luca Ceresoli wrote:
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


Return-Path: <linux-kernel+bounces-561944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352BBA61900
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2741A1B6434D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725C2E3389;
	Fri, 14 Mar 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYPb+g6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70D1FF615;
	Fri, 14 Mar 2025 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975498; cv=none; b=AhVHShX1i+tvR/QkhYhKEC7NttLrdSXfAXdpDICMMlwdAxEHulqnsCP/xdOkfeE6esMBt9D9CaOML/EPp8lqVCTLgXEwDW9o4M745XA+Bs51msDbCnbqTGEUqXmsOMjOCip/fNuqmdlNuz3ecuUP6D4jT2PJl+BN5riuAOdYH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975498; c=relaxed/simple;
	bh=LHJM4OU3kl+/G82P3FTZUg4E77KcnwgPswr6Flbh2rM=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=OWC0h1VUGlRX7M2C5o/C+Arkb8owquuWioPh5CnQT0HDG4jOCdJ6z07ZaceJFPLPSil49YyWahSIhNvlHikMs3zYyazFywQ8+LhS4HORBkfDKVI6cmrBNR05mHeUsIMGoB7QLE84GT0PPAzun8MuuAFe4CXvUT5MnLm+UGel0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYPb+g6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D258BC4CEE5;
	Fri, 14 Mar 2025 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975497;
	bh=LHJM4OU3kl+/G82P3FTZUg4E77KcnwgPswr6Flbh2rM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=nYPb+g6H7LYrbum7aeROxiYnk8fie4nu5F72GWC6DsqJdMDyU3nPz9+7gWsXus3ee
	 MeQy+KYrAW4fvRe6QGQZwzQivZeF4GHmXZD7xliFgBFa97c18NhkYGfWvfqCvogNrY
	 iD+m2/Yb8ki4IbQWPiMKW1GqFp5YRXdlUWbUwsOwmfUs5VL7uKutAJsCEvuFjSMpB/
	 evvxcBfpCZrvdviy1gsOn/h0ldaiEtEl5qUYIM59+RbhL8E1RUtdub+IP8mQ+Id58r
	 4MRlBQb6/tmg8O8NMwrAtg1yM1d6mSNKRB8ljvt2dJqhLd4YMAwk5EB1kjNLdjq2Sr
	 0bRogUFvyBX1w==
Message-ID: <4199151804db21307707fc7e023d10d7@kernel.org>
Date: Fri, 14 Mar 2025 18:04:54 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 03/11] drm/bridge: get/put the bridge reference in
 drm_bridge_add/remove()
In-Reply-To: <20250314-drm-bridge-refcount-v7-3-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-3-152571f8c694@bootlin.com>
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

On Fri, 14 Mar 2025 11:31:16 +0100, Luca Ceresoli wrote:
> drm_bridge_add() adds the bridge to the global bridge_list, so take a
> reference for that. Vice versa in drm_bridge_remove().
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


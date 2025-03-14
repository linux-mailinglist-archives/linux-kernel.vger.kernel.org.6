Return-Path: <linux-kernel+bounces-561949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 142BDA6191A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4019119C4B38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489E2040A4;
	Fri, 14 Mar 2025 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg4rrMcA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC52B9B4;
	Fri, 14 Mar 2025 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975914; cv=none; b=uPAiCYXKlMQdH98R8n+2Cofj7jCVjDXjQvVzOOCjYqN7o6WPfVXNzoAmEA1XBNlBPnJ0UHVtCICe7WkPQ63Da7xxLX5eqSIkA4//Knijodzl/8oRz3A74PtcPbaRS1B6c+5rj7NQuW0j6as3yAnmTNNbahgG+386nmG1DPRGhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975914; c=relaxed/simple;
	bh=ngZOWsfXuCD39NLjndi5h6K1uhUdOH7LeujeO4Dg3GI=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Dd0Cr9XIc9kEdynhy4Dcr5eUab8sbTrHuFREWzc/3VO9PABhcMevlGaNHYgymit9lQgULEl2xrjvt8XUlaaD0q9sLaEp+6USVDM33+0tNv1ZYHl217TjMOOiBKcuVp2EZqUWVMfkP/WwbNelZ8FP0gGITQQCiR57wMtEY5h1ekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg4rrMcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE89C4CEE3;
	Fri, 14 Mar 2025 18:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975913;
	bh=ngZOWsfXuCD39NLjndi5h6K1uhUdOH7LeujeO4Dg3GI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Mg4rrMcAry4vXwrRGRMZaODYR7HScvj0eqWPlp8rPomU+3SzPYILi9Z5o6PLq2I3n
	 bDh51/9S1vJP+Wi3fJROLpEnMJw9KxIHdcqfK9Z4/0Jb+RyXwPwayqdbdns3x1gRuF
	 LG8EuYiWD0cW0fjhbRb6EY3bJqzp3qojob5pkIkxdBbxSo3wkji4g5OyKULTG6m3wT
	 kTu7WGyoqOy1MbLGQLTLA7q7jW0i1NiJKAjhgtuIjIFZ8XUC3NLN7lo4c9iTM0Mbgc
	 ls7OuQ8SXtpy0fowNpKsOsz2NBG43Xb0m1Bf78/8orKP/BdPaztl5RERtuNxs/KQ81
	 isHcd+RUuaB9w==
Message-ID: <0cc45a0aae50ab25262691c7145082e1@kernel.org>
Date: Fri, 14 Mar 2025 18:11:51 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 07/11] drm/mxsfb: put the bridge returned by
 drm_bridge_chain_get_first_bridge()
In-Reply-To: <20250314-drm-bridge-refcount-v7-7-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-7-152571f8c694@bootlin.com>
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

On Fri, 14 Mar 2025 11:31:20 +0100, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_chain_get_first_bridge() is
> refcounted. Put it when done. Use a scope-based free action to catch all
> the code paths.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


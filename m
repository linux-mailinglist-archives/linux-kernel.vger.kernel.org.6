Return-Path: <linux-kernel+bounces-561931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B2A618C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7801418924F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD84204582;
	Fri, 14 Mar 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw1jHUi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7D20297B;
	Fri, 14 Mar 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975132; cv=none; b=S6UIngGfrjY4lWBAXBmBeS2hY5qFvIABnlq4+pTpg6KcDQp1JreaRUG6xDyz4ygnS8qecDE1tZSHwRAgoZ4jS36AuIHF1xIs6xevQ0Rhis0qpS6TcFvC0F/PnLCLHinDpNmsJXS38Vijm+N1qNUPY91itM/jGzyuhGN+6SR7fKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975132; c=relaxed/simple;
	bh=z6B4P6li35NYfvylmnEIJbA99kfnu8jlKpUXmSAMqD8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=pomUIJYJ9IIeVyBEAoxRdRcyKZINR1sYC+wj8SO/O0nji0trxQQxi3WjvxufT0Y9bymhRwwLvB56fbvvVCHFtMLQy6+vLbwgOXJe+t5OPX+Hj1IL90PiD9x1dyawVM3vU3VMJ0rYIE1C8O2dsHdLL2LucHtjY6ro0z2QUoRkbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw1jHUi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66A8C4CEE3;
	Fri, 14 Mar 2025 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975131;
	bh=z6B4P6li35NYfvylmnEIJbA99kfnu8jlKpUXmSAMqD8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Bw1jHUi3Ya3L6oLYeiERZiA1MI/e5bpo7F/Y15CRB6uQ5cBl6rauUOJ6hB9NRKdoC
	 v5IPQSKHkxpJgDLxYKOh4+Bmzb1eLA1/Lzaqq6EJ9uPIBDuV1WnuA7KdRk262rbtKa
	 Y5hCo9VHoLGAMPl9zE7emTWBoFJGyhkMoQDsk7v/b6Uc5qwZksQWU2oXe02jORkneO
	 MjxyIozdSoT3xoTkTo4QdCTZU4QNUNpCQB0K0Qr5bGCYNfovRHKVWvZa63MEUwRMw7
	 l2AmNkiIOZCpeB2dCmZqmNryEGuGxVp9yx3fpSy8BaO9/bZuZuf4aOgUd33QAZewtV
	 HxBIi6NEi7m/Q==
Message-ID: <ab48cc194d9fc1f5d3fc7846abbf4cce@kernel.org>
Date: Fri, 14 Mar 2025 17:58:48 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 01/11] drm/bridge: add devm_drm_bridge_alloc()
In-Reply-To: <20250314-drm-bridge-refcount-v7-1-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-1-152571f8c694@bootlin.com>
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

On Fri, 14 Mar 2025 11:31:14 +0100, Luca Ceresoli wrote:
> Add a macro to allocate and initialize a DRM bridge embedded within a
> private driver struct.
>=20
> Compared to current practice, which is based on [devm_]kzalloc() allocati=
on
> followed by open-coded initialization of fields, this allows to have a
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


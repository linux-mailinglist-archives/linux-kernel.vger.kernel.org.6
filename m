Return-Path: <linux-kernel+bounces-571037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DDA6B823
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACA316449D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A701F1319;
	Fri, 21 Mar 2025 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G92hIB2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F233F6;
	Fri, 21 Mar 2025 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550898; cv=none; b=jjifCToDEl8sVJ4TJ0W02rKai4eaHRRw5jjZ5dDELHyN0yrQngGzz8hY6LVTZ87fx6FMrXJrrkrBlYlxvRb5Nf1Zx2dvH9pYRNJLzzDnDqeRzepgs2EVrxEPS1SNNhVhQdLd4SXAbrW2wO7uuR6XGDb4V8we4C2yMqZSlR+xKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550898; c=relaxed/simple;
	bh=TC3r2kF6h1DguPsHjjEeqn2dDugjdFWL1T8eZNZFK7U=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Z62wdgkPQadIk5tTffVYRkvcbvC9AJMwfW1P+GfcrbOtawymYeWAHViiv0Gb04p0LQF/rka3iCJ9WRWP4ERik0OQx/tRK1Tswjo7v1Z85Is1Lmy9w9TE+BRFYEyc+ER1viVUzXfjO2ZnCPVnk32MQUWR0bFyuTO88OF2gFz7AH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G92hIB2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F7FC4CEE3;
	Fri, 21 Mar 2025 09:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742550898;
	bh=TC3r2kF6h1DguPsHjjEeqn2dDugjdFWL1T8eZNZFK7U=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=G92hIB2X8Wwiys82uVSEu8Uj+jPevWW5gsMb3/Ub2Aj+nRnnmXcl2CCx9MQi6BPJj
	 mVImTQqhYbsPkD8BIiI647oQtRIjVeHMufD3xer3lpfyCgJvyOyvoA/LP1Z8Gc/730
	 abkxD1wnAEeW/wtqcCXh6SBggwAU2VRmsIZnWlbDrR3IeIyg6H887iljJ0ETRiHCpq
	 0b7ce4aBeogQ+Qu1l+s9eel6AM6qEmh+MiJdXqDZEkYNfBhHZXy+ePNgEogfq8WGUQ
	 SAAXeQIazO4EvxYj7Ac0E9uVNt8MSooPVFDswe5s8iP+dyQ3zVCYVUAUfxqscGyowc
	 1HawfIyP4nC1Q==
Message-ID: <400466cd3c229ea6c6cb25e2a58cee27@kernel.org>
Date: Fri, 21 Mar 2025 09:54:55 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v8 2/5] drm/bridge: add support for refcounting
In-Reply-To: <20250320-drm-bridge-refcount-v8-2-b3ddaa9f1368@bootlin.com>
References: <20250320-drm-bridge-refcount-v8-2-b3ddaa9f1368@bootlin.com>
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

On Thu, 20 Mar 2025 16:42:11 +0100, Luca Ceresoli wrote:
> DRM bridges are currently considered as a fixed element of a DRM card, and
> thus their lifetime is assumed to extend for as long as the card
> exists. New use cases, such as hot-pluggable hardware with video bridges,
> require DRM bridges to be added to and removed from a DRM card without
> tearing the card down. This is possible for connectors already (used by DP
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


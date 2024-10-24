Return-Path: <linux-kernel+bounces-379652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D779AE19B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3ACC1C228E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094AF1B85E3;
	Thu, 24 Oct 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GcgtHokA"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10541AB6FC;
	Thu, 24 Oct 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763748; cv=none; b=kNaeQkIUIiToKkWhZOCaLPhZg4eXPz4DzY0cnw4d1wKsBFoUg2q4IVkeMtgVva8VqOATW+nEbiI+SPGlKfXln8V9hD6/lYqGPfmEnT92SqOFJbE8Aq2VEtHvABn2fDDdsbdaFIoe2WBQO1TEzflFaNeXW7znQSlOVLPQEMIDWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763748; c=relaxed/simple;
	bh=lvPQMUVwmXus/dT8QmCS/EjP2eq6Xpzlq0s8K/ihjTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=caAkLy1GJbO9dY0ulBC1IBNrgkiJjRsMtJSdujTIzOATpIDe/5FSEroCEptodzNeFTqafSeF899i2JGn7fZFZ4L+v1MGmF3SLbkCuDeuVxaTYHjboF9Kw2U1/Ynj0Col3yLoOswr+PY70xCc/cnMXoT2w+0qItgbkeS1e74tkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GcgtHokA; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E18204000D;
	Thu, 24 Oct 2024 09:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729763743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kVh3RAUGV0AsPGkHBiPjmnI9pe+etqepuArNr0UCyaw=;
	b=GcgtHokAsUhrOypgaGvd6A+DDaygYsC2sqExlIkcNunOmR+VhSIGdGEU9YYy4LXziros/z
	noBJ8bGnh9oj5EHoL1uYDB1+7yhSJRvIgEzkZn/D/7T4tg5HhM2PZwlbTUNQs30KMAA5cn
	D1pmVLlSSYhw/U7YRb6uDlMQo99Q1TYCSAd6owpPRJFCr9kjZitDp/R5jF96XeD3a5Fe/x
	CyIe727NiIg8QPUU881t2L1+5o+44WAxOb7bAx0snNsjCoq4SYZ0mdZhwyWysx6P9fhxa2
	lcAYChZHg2lJE5ZJbm9iW+34r4VuCq1axVNvcxaNUP8VR0HDKR1O3ztA0oh0ZA==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/2] Add support for errors recovery in the TI SN65DSI83 bridge driver
Date: Thu, 24 Oct 2024 11:55:36 +0200
Message-ID: <20241024095539.1637280-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

Usually the TI SN65DSI83 recovers from error by itself but during ESD
tests, we have some cases where the TI SN65DSI83 didn't recover.

In order to handle those cases, this series adds support for a recovery
mechanism.

Best regards,
Hervé Codina

Herve Codina (2):
  dt-bindings: display: bridge: sn65dsi83: Add interrupt
  drm: bridge: ti-sn65dsi83: Add error recovery mechanism

 .../bindings/display/bridge/ti,sn65dsi83.yaml |   3 +
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 128 ++++++++++++++++++
 2 files changed, 131 insertions(+)

-- 
2.46.2



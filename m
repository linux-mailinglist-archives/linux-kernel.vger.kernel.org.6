Return-Path: <linux-kernel+bounces-215159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F4908EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD41C2117D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511616C696;
	Fri, 14 Jun 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gtCN9fMK"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2F16C437
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379382; cv=none; b=CjGEJDtFrnEWxaITLaoOKIAmSfpzl073DaY8xO03sh4ET3rkWFV7z8UUvXNLkU40gZJphepQ28r4g3FUoPocYPK+Mo9xF+zqw6i5GsJQD6ot4MA7d1P38EXax+CrVs1LeLpBfXRHpHm5702oU0XrP5eZl0uRfFZ6y4Z23cKtI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379382; c=relaxed/simple;
	bh=+qPg+EvTFwBcl83CBLiEMXmzbCXzJn6KtSH/bEamsUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aD3vnNNFWQRU6IjxYYRVAnHjpRX9knWShxOEOXM5rX/6SDVSeJeGLScDqO7qn/6NSHI99OIJdpIFJiM08osUnFygZZ/YCeKoLKeKOisbOLBMp09CS5dc121dBOlVhs/ciBGoGYZ7x0LLSEHID/geSv9uyAjU3TG7Ms/odvUGqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gtCN9fMK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BAKaAobYFUntrejEJZZwpK2PmNSiy7/4l9aRDDrVOhI=; b=gtCN9fMKRnOmGRz3sWltUWir12
	OQWrlw1tdqxYq7cGWZAPF/OyYugN6y9DJ6Be+avuIpiQAx/BME0kxqnXkBrt1Xyc1SlBgATI8BZQx
	bef/kQ26YVQA/U+D9+/oyeC366w4pLz3Hh03eS6Tl+NMrYYFZwyB6WD/bxfTK7rWilPSLB7WNkFXT
	Cz2XRf4Eyva+f6JnPsqSJo7DzoHLv5Ti0tVprTXd+F2eYk0/ghIQKfjtKoZUVq66Pj8kjOTaCYyJF
	a1jCuGz2PM30L7I7KMxG4tEucrWOV8DdqNZTw6QXY0+4zN5Y5uSG1kpIEpqcSZrQoa8BTptX1R32O
	FuQ4jkyA==;
Received: from [179.118.191.115] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sI8yP-003B8v-TK; Fri, 14 Jun 2024 17:36:18 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Melissa Wen <mwen@igalia.com>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 4/8] drm: atmel-hlcdc: Enable async flips on the primary plane
Date: Fri, 14 Jun 2024 12:35:31 -0300
Message-ID: <20240614153535.351689-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614153535.351689-1-andrealmeid@igalia.com>
References: <20240614153535.351689-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver can perfom async flips on primary planes, so enable it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4a7ba0918eca..22b8a5c888ef 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1227,6 +1227,9 @@ static int atmel_hlcdc_plane_create(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	if (type == DRM_PLANE_TYPE_PRIMARY)
+		plane->base.async_flip = true;
+
 	drm_plane_helper_add(&plane->base,
 			     &atmel_hlcdc_layer_plane_helper_funcs);
 
-- 
2.45.2



Return-Path: <linux-kernel+bounces-569984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F3DA6AA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7EC189AF18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9A1F8BB0;
	Thu, 20 Mar 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Jo6hJDzx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D961922C0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486441; cv=none; b=kjUnIELGhkNLVD1s7i8EnCj6JXJDsqg3lUQv8PYB3JJq/BoX0lAtnbBnWeuB8fEVRN+CGRce+uo9fWntz/XRDTzZvrlGPgHKC7h0uGbvgy+plyZZZmMqQmGsrmdqRuMYSxRry01Q/wGeWh+lleY55ppFX2yV2Mj9dNDQCc+Y6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486441; c=relaxed/simple;
	bh=tWpzu7ba133Zdaj4dIf8mfTY5P/FzEw3AwQGlLkB6nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOM/DNNoaI3g8WTQYV8QPvA2IbBZDVHLQ4ZG3SufXRiKO9THfJKEU1mQB7z44J9iKn7nL1BwZBNJMtLUe5iNSVfqzl9nTSrHPbYTjsiAFYA2+A3P16NzIlEEu6QlfMyJcve1LA2fA0+B+IPdug7OqDUvhyoXuRtl37U1cnfI5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Jo6hJDzx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 333C6836;
	Thu, 20 Mar 2025 16:58:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486328;
	bh=tWpzu7ba133Zdaj4dIf8mfTY5P/FzEw3AwQGlLkB6nY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jo6hJDzx4MMVutviFoW6uze0v/t/ZUm3X99o4o+jspdo0aHxYvjZr5GZqfyHXe72l
	 cVOWAeLOIYol7UZjpp2ic1QNh6dyw0QY5HSFa/V1rBRn+Dmt0oLVbMTdU9nPjjWvRp
	 f5azgycs2yk3KZQDl9kPW2S6tLE5LGaoHomhfRJc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 17:59:56 +0200
Subject: [PATCH 01/18] drm/tidss: Fix missing includes and struct decls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-1-725277c5f43b@ideasonboard.com>
References: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
In-Reply-To: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=tWpzu7ba133Zdaj4dIf8mfTY5P/FzEw3AwQGlLkB6nY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3DuW0VeV/16xby0waSsVTa5y/p9LuoqqSPndU
 5qCby6XyN6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7lgAKCRD6PaqMvJYe
 9dQ0D/9sDS7OWljZibT3MD38u4WdeOEtCPLTN1jQCfDoLLOLHAfQUc+o+a4qSO7UTE/cwMA6PPL
 /vB4NvQh55DDELk66YfnQh7/FtRB5yDEIrP1RLuZWYY5Cz6TAmoB76WsjRqP+9axnYTYy5GFiP6
 5gDJKn3Vmdh+xCqc21B65a6f23OGqzwDvkedeFjBuMp5H2pKJFoU+33s0t7SLbeT6XiumAqkQzu
 8k4W82fykMZZnoZQDWCNDVOX6hkJCWUJucgV3ImF3UmPqy6uDo0XVs6TXDaDGjC3yvYMrBtWl5Q
 /pnXmA93cICYvkxW0jRsP7DXw/VpWddrvuF9OSioi1cfNxvucKp6brh75Ox1d0Uma52+aVOCYsk
 Fws048xy7UkFtnDRuMTH0172iX5a3uwxVSxT0Jq3nZjPsO2jsTNLUsnlKo5TaObi0KLTlwjP13H
 ggG04o92RTjt93ztMubmHVmpjVmm/3QoEOypvKycMyLQ9H3+r+idMSZrmGaAZZNqm0oEIO4CLzb
 YAlRi70GtFcrO9uN3dZGgTL8vjJkKppyAnmxX9V4ChjuqZYnoYKaiMSsUYGNUt+P7mk1Oq9Zj7P
 GQvFstwP99RXtjk0naJTT9N3/3vhbCo34aBtQ2IDx+I8StOcRzUTzfe1+I9cYd/w6YeoJWsAXRl
 6MXwh1eLPU6BTpA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Fix missing includes and struct declarations. Even if these don't cause
any compile issues at the moment, it's good to have them correct.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.h       | 3 +++
 drivers/gpu/drm/tidss/tidss_drv.h         | 2 ++
 drivers/gpu/drm/tidss/tidss_plane.h       | 2 ++
 drivers/gpu/drm/tidss/tidss_scale_coefs.h | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 086327d51a90..c31b477a18b0 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -7,11 +7,14 @@
 #ifndef __TIDSS_DISPC_H__
 #define __TIDSS_DISPC_H__
 
+#include <drm/drm_color_mgmt.h>
+
 #include "tidss_drv.h"
 
 struct dispc_device;
 
 struct drm_crtc_state;
+struct drm_plane_state;
 
 enum tidss_gamma_type { TIDSS_GAMMA_8BIT, TIDSS_GAMMA_10BIT };
 
diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
index 7f4f4282bc04..56a2020e20d0 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.h
+++ b/drivers/gpu/drm/tidss/tidss_drv.h
@@ -9,6 +9,8 @@
 
 #include <linux/spinlock.h>
 
+#include <drm/drm_device.h>
+
 #define TIDSS_MAX_PORTS 4
 #define TIDSS_MAX_PLANES 4
 
diff --git a/drivers/gpu/drm/tidss/tidss_plane.h b/drivers/gpu/drm/tidss/tidss_plane.h
index aecaf2728406..92c560c3a621 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.h
+++ b/drivers/gpu/drm/tidss/tidss_plane.h
@@ -7,6 +7,8 @@
 #ifndef __TIDSS_PLANE_H__
 #define __TIDSS_PLANE_H__
 
+#include <drm/drm_plane.h>
+
 #define to_tidss_plane(p) container_of((p), struct tidss_plane, plane)
 
 struct tidss_device;
diff --git a/drivers/gpu/drm/tidss/tidss_scale_coefs.h b/drivers/gpu/drm/tidss/tidss_scale_coefs.h
index 9c560d0fdac0..9824d02d9d1f 100644
--- a/drivers/gpu/drm/tidss/tidss_scale_coefs.h
+++ b/drivers/gpu/drm/tidss/tidss_scale_coefs.h
@@ -9,6 +9,8 @@
 
 #include <linux/types.h>
 
+struct device;
+
 struct tidss_scale_coefs {
 	s16 c2[16];
 	s16 c1[16];

-- 
2.43.0



Return-Path: <linux-kernel+bounces-203825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 446EC8FE0F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ACB1F272FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310F813C676;
	Thu,  6 Jun 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="a1wc5lvj"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C5199A2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662536; cv=none; b=GprQ+SsK7JAJTwJkAYkS+0QF7s+mnZX0WNU2Tl22OHJpFVRlCRoAojBEdNXKNhpHCskHxd4SybngLh8nGr9Pg/urCaCklVXu6GLB0TEkK+i+bZF3j2hhG3l73q4ET+atjnFTcOezpyOI10rif0F0uIi9krvL8GZYUAUDbAlGR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662536; c=relaxed/simple;
	bh=5Ys8iQVTydCi1EldwvCjBJXP9wRpAX7anX9XZCbGrW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qZn1kFDV2MUByV3K7hd1VXXf9dTWm3lFF2i2m4/oTYVv+hcJKhraG31KqFDucc+EzjUrcgB3UkC+wNyqLALuKWlTv7sAAkYE4O+pgbPohcg/uhHeEEatukaBhYoaG1hiDWwEICRSZ4qDKTENLgY7L8Rjo9uiWt943X3hTWjGsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=a1wc5lvj; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x2+y0ipvw9/Vy2jDpbW19iXnZKhk5ENbIrkj5TxdUAo=; b=a1wc5lvj/qqWeL1mcBgtu/fUX8
	9dfM5CxAFBm7zIHLyMs/dNaUjhFFEuE6VC7cze0+rFogayNd44qpV8REmAsMa2VHCIS3N6RTRW48Z
	3c3WE1gnaVe8I/yMNJTFnooerwgpC4f2YT2z2j8Jaq0uj19GDwrs2AU1Kn7NOAjveOezgVdaulXgi
	Zu50CX9ZiM2B/2tdGMwEpbo1fByyczgEddfAo5FProzQl78feIk4ET2UG3srCEXkWdtTeyJP7gSds
	FeqccFMlFvPx4rXm9f+zHNMeC+f25Zm2vmvv6MQ5rDKPxz7Hys9jB2pj9ieZH9iulJ3Q9oKEEDQwX
	Oov2ifQQ==;
Received: from [89.212.21.243] (port=59706 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF8UP-00BbFF-2Y;
	Thu, 06 Jun 2024 10:28:53 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Primoz Fiser <primoz.fiser@norik.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH] drm/omap: dss: Support all VOUT ports
Date: Thu,  6 Jun 2024 10:28:50 +0200
Message-Id: <20240606082850.3746052-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Allow function dss_dpi_select_source_dra7xx() to set the channel in the
dra7xx DSS_CONTROL register for any VOUT port, not just VOUT1 (port 0).

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/gpu/drm/omapdrm/dss/dss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 988888e164d7..f5a484ef0f48 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -796,7 +796,9 @@ static int dss_dpi_select_source_dra7xx(struct dss_device *dss, int port,
 {
 	switch (port) {
 	case 0:
-		return dss_dpi_select_source_omap5(dss, port, channel);
+		if (channel != OMAP_DSS_CHANNEL_LCD)
+			return -EINVAL;
+		break;
 	case 1:
 		if (channel != OMAP_DSS_CHANNEL_LCD2)
 			return -EINVAL;
@@ -809,7 +811,7 @@ static int dss_dpi_select_source_dra7xx(struct dss_device *dss, int port,
 		return -EINVAL;
 	}
 
-	return 0;
+	return dss_dpi_select_source_omap5(dss, port, channel);
 }
 
 int dss_dpi_select_source(struct dss_device *dss, int port,
-- 
2.25.1



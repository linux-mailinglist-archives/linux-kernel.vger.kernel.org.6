Return-Path: <linux-kernel+bounces-276294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A2794921A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB181B26A77
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5FC1D417F;
	Tue,  6 Aug 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="xLsRlk6Q"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12919F464;
	Tue,  6 Aug 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951717; cv=none; b=VKhW9geeYHD+JBEN1Q26BPr2fXcb8gSpZZiwxKzM+ap6VrwPrElf/xZ+Rh76QukLpc173UB73WYANTSFbk9kIXSLqCItlvdtE7SQO6D1W73WJDWgsYv2xzuj9jTJ1vp64NdtMF/djiSTvk/SACuPZn868ho5QTIzLYAECPgdo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951717; c=relaxed/simple;
	bh=WufKVeYRMMMtkl0SBVr4NH+Xi3UN9YXrxS6beFaxZJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tON1kSvek9kT1RvysEjgeVXy1V2VEkyzjwAibKNQGYMV4xABPAH/mzXQzLHAntcsDHUBo6l5uB4M/VA00jqdytRlkjPjfLXFK22mf7+UVlpmsIcpROH56lmDwXvSCUhNISwBpu+dLvLwEu1vQnPP7e+VtUvisAY13c8+VMfZR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=xLsRlk6Q; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3354DBFBC7;
	Tue,  6 Aug 2024 15:34:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1722951289; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QYOyecr8YSpIqQFw0AXKerk+WzH6pvykimx2Jj7ntNA=;
	b=xLsRlk6Q/yPSMG8KP4VRrhg8f1hOhln+EEP7Og4CdgiTTCgBpH9IefxGaIolEDkOM6QI6+
	0Wuoa0s3gjfGNifBXeEPpcA/l3h5qBIZpVBxFUyDlSys9g6SAJrblIO05TNvFfPigtseOY
	vkevrW/0NXsXS+Osb8Itu7ShNDmkXHXAEBLzv1e/DeUcp4r0ZrDQMjWBOOLyah7W45NWym
	fEkITiRG+lJAcvpA5BKieZ9SvRmt1eBiX6I46C7iRO6BCYQeKTLbU2i0l/fuHBdJRqj2hr
	ZW5PPCiIzcZpduOG15HEhMArHAINIIuzG8Hg3W9SoUl53uu+5fqKI3zvlhTong==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH 2/4] dt-bindings: display: panel-lvds: Add compatible for Jenson BL-JT60050-01A
Date: Tue,  6 Aug 2024 15:33:00 +0200
Message-ID: <20240806133352.440922-3-frieder@fris.de>
In-Reply-To: <20240806133352.440922-1-frieder@fris.de>
References: <20240806133352.440922-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Jenson BL-JT60050-01A is a 7" 1024x600 LVDS display.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index 155d8ffa8f6ef..5af2d69300751 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -50,6 +50,8 @@ properties:
           - hannstar,hsd101pww2
           # Hydis Technologies 7" WXGA (800x1280) TFT LCD LVDS panel
           - hydis,hv070wx2-1e0
+          # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
+          - jenson,bl-jt60050-01a
           - tbs,a711-panel
 
       - const: panel-lvds
-- 
2.45.2



Return-Path: <linux-kernel+bounces-304550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F919621B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246AC1C225BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AB15B122;
	Wed, 28 Aug 2024 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="jrMhYmkK"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F214D43D;
	Wed, 28 Aug 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831323; cv=none; b=CP2omaG0WPJ6JiJXY++07mZNRpLHrpTM3ps4S/4OyI2z/1uA9nGUfh3RHgR4H8jjXMVvs7T8xfqjJvmgmJHVbKMy8HZKDhQGNhemdUj6EJHPLWf1k/j95EQnYol33NlVZjw1mdIefnhvU6DaMQb2asMx3AHe2wrvlUJ0EV0UXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831323; c=relaxed/simple;
	bh=Z9LH3t3RjsWLXiuxytofno9BiBxTDoNfcOSSSsExXp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8V1eWshoDxQFlrsLdwQhMu3r7EH2mdm/mu/wo0S268ix5e2mwLXtf3ob8b3++WUb1HCKDGjtegJbQUPfyEhwy4LBDeuHcE0fjz0Jjt6u0HmIUYakM/OOza9Mnn2EUnM0ZKirxbT7Ub9BfGnkaeHvwBBdlmRNiPbdqGaha3nP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=jrMhYmkK; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97F67BFC3C;
	Wed, 28 Aug 2024 09:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1724831316; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CnbbSWEoCzwCVh93a30I9Q/oZV6uP0OjcIVTF+ZRfY4=;
	b=jrMhYmkKmC5tX4Ntl9mTe50mR0QoX66OHWKwX/m2Awwo8LmyWJdVR3xOZVwkGN+z4YuzFU
	02CDYdW8SCMXhVhLgmY/SP8Nz2ik8nooPnV4ilfPe0ltkumd3gszMuQ3iZox2rPQvubwnW
	lBG9fheHRzpRKlcEq4ySLUaZTZsnBH+Fm1usZ9abGrU44oggXcQjdw+flxTk+nsB1fEyCJ
	pNKmEMEnRB3trkt1DKQWqxGyjbhte8PDOwjg1WJbKG1i9FyhAdPqxOpV1Kh14nhtuL2skG
	WcDL4sh/S9LTmM/jlU27mmYbpNy7l/bEzafBoFhq5Fvw78acyJ8+ZU1nedhSkQ==
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
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH v2 2/4] dt-bindings: display: panel-lvds: Add compatible for Jenson BL-JT60050-01A
Date: Wed, 28 Aug 2024 09:46:54 +0200
Message-ID: <20240828074753.25401-3-frieder@fris.de>
In-Reply-To: <20240828074753.25401-1-frieder@fris.de>
References: <20240828074753.25401-1-frieder@fris.de>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes for v2:
* Add tag from Conor (thanks!)
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
2.46.0



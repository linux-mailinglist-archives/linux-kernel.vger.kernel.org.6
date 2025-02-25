Return-Path: <linux-kernel+bounces-531505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F3A44152
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CD77A7772
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C3B26989E;
	Tue, 25 Feb 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="I3kHyhGP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WJCuAfYc"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885B233714
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491490; cv=none; b=eZUUFDR4qtmWvtmbW3MaTr+IIA3qjYVqNso8tORXsK9lx+fXSro9+Bh6v8tHIyp63WRahX0Q5aL/9xG0cYI+qqZ3AFTIzG31WXiDnILTbv4jfy02DPOLUUVxqk4VfuyUM2yvhEYZEuy2rIwZFTmqmpHF2DwQ4OmHnSdwLve/wWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491490; c=relaxed/simple;
	bh=cZtEK8yN68UszDlpP7LtMSpPpS9Eb28oEMa+xbzAJBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5i9pUxhijJ4gg0eJISdqIOcyxzpMqVUeiXO/l4yLKaiXEwhMyYgB5FRb7znZ51E0oFNx8ZhSP8IuaGCmgx5YMq0scnOckc4NRUURPeAigYj92EF5XdorXlf8CCTf/T5ENAZxu8s0Bop3xi6McPQwK87LSyZatixYHPJI2GJ86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=I3kHyhGP; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=WJCuAfYc reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740491486; x=1772027486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dYiX75xSJOJS1ua83r/Eunzv7hMG47qKMH5+L5RwUPs=;
  b=I3kHyhGPOdrslsZ9B2zocRl+C84GoRCj1bvGc/o1orREY99reabKWirX
   okIZ4ZsaG8uuatvyeL+66WpBA8UvB9Uw9etB+CCi53o2ECrH87fBhMURd
   m4SmH8g0Mdo36wmqaxDaVnYs4Slrpv81TFh7UK9Jgx295jGFzZF2e6VEW
   x5IY983ACnRYRqM+MdkCjlGwjVaN7nwdSQdcbPfTmfaSix4dHSXq5I18q
   +PomNSxS2CtI93O5FPHg/VRp3sT3dp+zaNZAwsc2BfR/pYfQ7sOUwGJpU
   Gi5Lb2xifK39oNED5af7xbgjdY1/nuuwhfr0/Ett1lZfYkAsvSa13M/Dk
   Q==;
X-CSE-ConnectionGUID: +6NoEAKjQ7u22+UvhNDcCA==
X-CSE-MsgGUID: Y+HKcAbzTaCdTyxBF5x+Zw==
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="42073734"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Feb 2025 14:51:23 +0100
X-CheckPoint: {67BDCADB-5-F75C4246-F0BD6D90}
X-MAIL-CPID: 2E5FFFBDA898A28E5261FB1E4C0C4DEB_3
X-Control-Analysis: str=0001.0A00211D.67BDCADA.007D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26BB0160F35;
	Tue, 25 Feb 2025 14:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740491478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dYiX75xSJOJS1ua83r/Eunzv7hMG47qKMH5+L5RwUPs=;
	b=WJCuAfYcPLdL14NIyuCFon/qmh/JkNCa+pAJM7DiRtmaO+2VICIajOFUBSQLxYroxa0bHv
	gu+jU+VTG1Thc2cbxsy0TDgw7UnOPp56xH+UZWhaKMx1DbMv2kW0O2yDxJr++5Trg/1oHJ
	QMxa9DLiqAP1l9cJSx5lZ5y3S4ZfB959wjO0lkGyvLzMLDgaE3lfsS0yWQyaks+1zpA4/2
	CLcXioMh5fsk1V04+2NeHDKpiiWVALA1CC//MAjCwBHd68C7Io1ph3pUhrkcL7yUKfR2sC
	+9r6xpyLW5P38BmYjReVaSpDDBovCSZK42lRvWH3ryKmuYMtHETljSOtlRkXpQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/1] drm/bridge: ti-sn65dsi83: Support negative DE polarity
Date: Tue, 25 Feb 2025 14:51:13 +0100
Message-ID: <20250225135114.801884-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Polarity for DE is stored in bridge state. Use this flag for setting
the DE polarity in the bridge.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 54ad462d17ef7..95563aa1b450d 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -561,6 +561,8 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	       REG_LVDS_FMT_HS_NEG_POLARITY : 0) |
 	      (mode->flags & DRM_MODE_FLAG_NVSYNC ?
 	       REG_LVDS_FMT_VS_NEG_POLARITY : 0);
+	val |= bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_DE_LOW ?
+	       REG_LVDS_FMT_DE_NEG_POLARITY : 0;
 
 	/* Set up bits-per-pixel, 18bpp or 24bpp. */
 	if (lvds_format_24bpp) {
-- 
2.43.0



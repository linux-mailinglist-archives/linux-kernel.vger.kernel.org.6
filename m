Return-Path: <linux-kernel+bounces-258566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912589389D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F942B229C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56214199C2;
	Mon, 22 Jul 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="I5kef9uA"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93D1A28C;
	Mon, 22 Jul 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632370; cv=none; b=IZg8XHNRuASyyqvwV12UwI4JwhOkwX2vbSd8g9A9PTEwWXTdMJBD8jFCDiz/zlfl1tEt1PsxU3fmEluEJ4hUFPBru4yJnQNTFBLb1uDhqAW29CkRwV9k7k3v9T4i+2BOZANPWmP2teqp/7grXJtGjSiAELfP4HT+id2FG4Ss6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632370; c=relaxed/simple;
	bh=xsoO8528D0avOH03gvCuFMU5tujeueLH3Z0pXQqFoiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t2GSUlkjTuOSU/XELtljI7i7HoBy5bCPGcdQAv/rMAokOzCb+ob19egS8RmpWwdd/pD9RNaDVlXht4zDBIb2UJaSJSO1QP9WXbseRZTuGVi09KxSJY81HYfJko8U1MHRopoTmUDxpJ4ur4CAvdbFyZt+s+aMV/AJ0jVnDuXKsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=I5kef9uA; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4WSBDc0rS3zDqFC;
	Mon, 22 Jul 2024 07:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1721632048; bh=xsoO8528D0avOH03gvCuFMU5tujeueLH3Z0pXQqFoiQ=;
	h=From:Date:Subject:To:Cc:From;
	b=I5kef9uADPhXVnq+OxBJxphORoBX3m8Le5aOpXz4F+Mk3aIRERcB5QhTYGNenclUe
	 JsAfgZQP6kM+Q8IYEGOh4EFOj8Xp/oRcm/e9douQxD8K9PMT95+tZPjfFlQGa/2ppQ
	 a2LMkvP3W5uBPrBjBoXk46YMHQMPj0mjR9kSohKY=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4WSBDT4kdTz9sqv;
	Mon, 22 Jul 2024 07:07:21 +0000 (UTC)
X-Riseup-User-ID: D470CD1E37C4D29186DA6EFD9BA40A74E66F303C20FB3AC69D2064775CBDA922
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4WSBDP4tnDzJrbR;
	Mon, 22 Jul 2024 07:07:17 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Mon, 22 Jul 2024 14:07:15 +0700
Subject: [PATCH] drm: panel: boe-bf060y8m-aj0: Enable prepare_prev_first
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-bf060y8m-aj0-prepare-prev-v1-1-0e51c0f59d22@riseup.net>
X-B4-Tracking: v=1; b=H4sIACIFnmYC/x2M3QpAQBBGX0VzbWpMsngVuVh2MMpPuyWSd7dcn
 c6p77shiFcJUCc3eDk06LZGydIE+smuo6C66MDEORlm7AYq6CoXtDPh7mW3Xj4eyK4rjRjnqqq
 AuI9x0PP/btrneQHbyj71awAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Dang Huynh <danct12@riseup.net>

Enable prepare_prev_first flag for BF060Y8M-AJ0 panel so that the
previous controller should be prepared first before the prepare for
the panel is called.

This makes sure that the previous controller, likely to be a DSI host
controller should be initialized to LP-11 before the panel is powered up.

Suggested-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
This fixes display initialization on some platform/devices such as the
Fxtec Pro1X.
---
 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index e77db8597eb7..7e66db4a88bb 100644
--- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
+++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
@@ -377,6 +377,8 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
 	drm_panel_init(&boe->panel, dev, &boe_bf060y8m_aj0_panel_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
 
+	boe->panel.prepare_prev_first = true;
+
 	boe->panel.backlight = boe_bf060y8m_aj0_create_backlight(dsi);
 	if (IS_ERR(boe->panel.backlight))
 		return dev_err_probe(dev, PTR_ERR(boe->panel.backlight),

---
base-commit: 41c196e567fb1ea97f68a2ffb7faab451cd90854
change-id: 20240722-bf060y8m-aj0-prepare-prev-2db87e7dd996

Best regards,
-- 
Dang Huynh <danct12@riseup.net>



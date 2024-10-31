Return-Path: <linux-kernel+bounces-390375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65629B790E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062B31C208BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84661199FDC;
	Thu, 31 Oct 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EPBb3l53"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB537199FCD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371948; cv=none; b=jPYcN02zjr/UjEafmLVa8Mflxxvcj+4R8gbtw2A9eq9CsdeBD/OrFncUWYsahuSYveZHJCcPgNAeC/dccsrrCQ6O7b0vAJdKKKNkMAs1GcOceN9i0pOg8iCdsrigNnAELQX06dJ+5ITaLZM3yxQAqVwrkr7y1CEO/jVza6X9ec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371948; c=relaxed/simple;
	bh=mz0U8fWEwG8t9/KBhmN5QBqc8ChbFI/bIF+28QBnp+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLXMai9pNJaZ/gjEPUC5hh34FO7AuP7y/jFtGw21c9KaTV7dm11FgPE9C/KtR12QyxJWjh8qM7n7BzLDHQ45RGM2VrWaP+LuFEAn9vMbQy+Q5AugNhKiA9hV7Wk/3nLpehmt3iilg2w4b7r7efw3lCzRnNunilHEHnguL61lEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EPBb3l53; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc0dbc566so445256eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730371946; x=1730976746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0RijCjWMMCWK6RFX8dTzbGJL7F/gEsY8vJbxOz9FOk=;
        b=EPBb3l53LvGzqTI7aJ3fxrCnAzJ0s8i3nnqze/dJp+Hi6BE1mJHKP0o6RiLgIZCsdb
         oeINVoRsRNmwNOPk4Q5fC8QYLYnOvhDY1HnaNM8M5O3dsG8xcmzc+fSM/wdf9p0YMa3v
         9bMtqEI+R4Nya0agG9/Axb41ddJOr16KlOFHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371946; x=1730976746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0RijCjWMMCWK6RFX8dTzbGJL7F/gEsY8vJbxOz9FOk=;
        b=tTgGmNeYShXRF2JjUBZleK7IA8tPQrdXLjofpkjuuPh+D3h6NUqbNS1WaPRlA1kDFy
         Qwf56Uud0GksLTLoIK+Rigb18yqkypWGzgKlha02q8tH8HjhJWMF+G7CQJTz4SATGoiw
         fCIo3HwVGMkhAR+3ao4y3SDbd1UYsJX9kxPoJPnnF3fMRLTdO1ELXrfVCI3PaCAcPmif
         3VbbC7+ID9IP6HX4AIG6nCo/xo29lGJ2lk9DrEogWsB+m81EQaeDX/qePS4qJrHL2GM+
         QZhypK+OY3G880dgw8wuG5Tl30A3uWreZ7vSWtBq+dJ2mdBfvWa/kTkneh1QzGQYI1wz
         vipg==
X-Forwarded-Encrypted: i=1; AJvYcCXv/IAIxfh41qWv3AXE9HOos12ErJgPVobkou/uNhm+NVb8ZQxM5I5egTFZemYNz7LWIJvoM0roodmzvjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHP0Cpq4GCfOKLEDfMOk7mWFjsBuiRL8bhV1+fUuQGEHe7RFI
	ztHRTdIMvaYY605yI/l3Aekpeg5KvA0VlJeZVUcjDafdxjCVfFJ7T73tCoiQ5A==
X-Google-Smtp-Source: AGHT+IGhROHzfCHv2jjUciB3ZIms9hOcT9wSKCkXAuoxuowe5h9El6rdUQbUiLuPYvDr7Eadop4lVA==
X-Received: by 2002:a05:6870:9112:b0:277:fe14:e68c with SMTP id 586e51a60fabf-29051d75b27mr16139023fac.33.1730371945863;
        Thu, 31 Oct 2024 03:52:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4470:8fa8:957a:6c05])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f8fb9sm839099a12.61.2024.10.31.03.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 03:52:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH] drm: i915: do not NULL deref hdmi attached_connector
Date: Thu, 31 Oct 2024 19:51:35 +0900
Message-ID: <20241031105145.2140590-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	*** RFC ***

intel_ddi_init() may skip connector initialization, for instance,
both intel_ddi_init_dp_connector() and intel_ddi_init_hdmi_connector()
are optional.  This leads to situation that ->attached_connector may
be NULL for some connectors.  For instance, on my setup 'DDI A/PHY A'
and 'DDI TC1/PHY TC1' are not initialized.

However, functions like intel_dp_dual_mode_set_tmds_output() and
friends don't take this into consideration.  This leads to NULL
ptr-derefs:

KASAN: null-ptr-deref in range [0x0000000000000848-0x000000000000084f]
RIP: 0010:intel_hdmi_encoder_shutdown+0x105/0x230
Call Trace:
<TASK>
i915_driver_shutdown+0x2d8/0x490
pci_device_shutdown+0x83/0x150
device_shutdown+0x4ad/0x660
__se_sys_reboot+0x29c/0x4d0
do_syscall_64+0x60/0x90

Add a new helper to avoid NULL ->attached_connector derefs and
switch some intel_hdmi function to it.  I'm not sure if we need
to switch all or just intel_dp_dual_mode_set_tmds_output() (I
have only seen this one doing NULL derefs so far).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 27 ++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index e1a1351bc94f..c089dd20972b 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1256,12 +1256,19 @@ static void hsw_set_infoframes(struct intel_encoder *encoder,
 			      &crtc_state->infoframes.drm);
 }
 
+static struct i2c_adapter *to_ddc(struct intel_hdmi *hdmi)
+{
+	if (hdmi->attached_connector)
+		return hdmi->attached_connector->base.ddc;
+	return NULL;
+}
+
 void intel_dp_dual_mode_set_tmds_output(struct intel_hdmi *hdmi, bool enable)
 {
 	struct intel_display *display = to_intel_display(hdmi);
-	struct i2c_adapter *ddc = hdmi->attached_connector->base.ddc;
+	struct i2c_adapter *ddc = to_ddc(hdmi);
 
-	if (hdmi->dp_dual_mode.type < DRM_DP_DUAL_MODE_TYPE2_DVI)
+	if (!ddc || hdmi->dp_dual_mode.type < DRM_DP_DUAL_MODE_TYPE2_DVI)
 		return;
 
 	drm_dbg_kms(display->drm, "%s DP dual mode adaptor TMDS output\n",
@@ -1275,7 +1282,7 @@ static int intel_hdmi_hdcp_read(struct intel_digital_port *dig_port,
 				unsigned int offset, void *buffer, size_t size)
 {
 	struct intel_hdmi *hdmi = &dig_port->hdmi;
-	struct i2c_adapter *ddc = hdmi->attached_connector->base.ddc;
+	struct i2c_adapter *ddc = to_ddc(hdmi);
 	int ret;
 	u8 start = offset & 0xff;
 	struct i2c_msg msgs[] = {
@@ -1292,6 +1299,10 @@ static int intel_hdmi_hdcp_read(struct intel_digital_port *dig_port,
 			.buf = buffer
 		}
 	};
+
+	if (!ddc)
+		return -EINVAL;
+
 	ret = i2c_transfer(ddc, msgs, ARRAY_SIZE(msgs));
 	if (ret == ARRAY_SIZE(msgs))
 		return 0;
@@ -1302,11 +1313,14 @@ static int intel_hdmi_hdcp_write(struct intel_digital_port *dig_port,
 				 unsigned int offset, void *buffer, size_t size)
 {
 	struct intel_hdmi *hdmi = &dig_port->hdmi;
-	struct i2c_adapter *ddc = hdmi->attached_connector->base.ddc;
+	struct i2c_adapter *ddc = to_ddc(hdmi);
 	int ret;
 	u8 *write_buf;
 	struct i2c_msg msg;
 
+	if (!ddc)
+		return -EINVAL;
+
 	write_buf = kzalloc(size + 1, GFP_KERNEL);
 	if (!write_buf)
 		return -ENOMEM;
@@ -1335,9 +1349,12 @@ int intel_hdmi_hdcp_write_an_aksv(struct intel_digital_port *dig_port,
 {
 	struct intel_display *display = to_intel_display(dig_port);
 	struct intel_hdmi *hdmi = &dig_port->hdmi;
-	struct i2c_adapter *ddc = hdmi->attached_connector->base.ddc;
+	struct i2c_adapter *ddc = to_ddc(hdmi);
 	int ret;
 
+	if (!ddc)
+		return -EINVAL;
+
 	ret = intel_hdmi_hdcp_write(dig_port, DRM_HDCP_DDC_AN, an,
 				    DRM_HDCP_AN_LEN);
 	if (ret) {
-- 
2.47.0.163.g1226f6d8fa-goog



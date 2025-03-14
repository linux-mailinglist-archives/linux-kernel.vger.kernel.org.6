Return-Path: <linux-kernel+bounces-560681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4FCA60813
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB1117FCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3E24B29;
	Fri, 14 Mar 2025 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0U6Z41M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2F2E336B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741927660; cv=none; b=Rla82t6S1i+1BiIkYCtU5Z6NwqJdirKXrhp/9+MfqOjLfnBVm3GJ9uFTAWJ3ALRa4ijRl5yPrmSnlxEc2kOsxYuHG+T9fGzs1XbPk7KoItl6MThmEmM6hWV+Zqn/YJJiNvyqTuHujxE/Fpif1KKnzHIUy/jN4bd789XgcJfQHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741927660; c=relaxed/simple;
	bh=qBcjxqrKDX/FFETejgVDiOVbJMCbdZawpuZVcVlypIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f6LRuvQpMF81/IfGJgBMAvZu3VjDnG/esPVLDPMEeBjz1ETh1IiljOnt8NTzcuswRl9HPpJcsCx6vdvdJTkBb3SxlHYafuDj+KYgnCKGGvxKp9hZFbdU7hKtqjKWYZ6vUqonSRQtmmVcfhurg4E+z0jysi8dv8bBy/su98gRXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0U6Z41M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741927657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G/FbMRDxyT7XX2IXY5Gn61zcTsi+VBfQKQteDrv1acc=;
	b=f0U6Z41MkTOz+UOrV9mKLAzZYk6BQkYoYdE0RylFcSU94VxLY6Wp9Wo5mKvSE8ac2UYdCq
	g2KJUOg7u7l8VQCmVDM3sE+29Wg003uoVPZ+ayTjhBe6Vv3+7x1By66BdWa/5jYdFkLAla
	NBWWy6AaonFN0GbtmBC7kJ9kNVQPkag=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-cEJJq6bYNS641KV_t0jSTQ-1; Fri,
 14 Mar 2025 00:47:33 -0400
X-MC-Unique: cEJJq6bYNS641KV_t0jSTQ-1
X-Mimecast-MFC-AGG-ID: cEJJq6bYNS641KV_t0jSTQ_1741927652
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5298D19560AF;
	Fri, 14 Mar 2025 04:47:31 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.186])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB20F1800945;
	Fri, 14 Mar 2025 04:47:28 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Fri, 14 Mar 2025 00:47:16 -0400
Subject: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-b4-mipi-synaptic-v1-1-a64ccb5e5c66@redhat.com>
X-B4-Tracking: v=1; b=H4sIANO002cC/x3MMQ6AIAxA0auYzjYpqINexTggFu0gEjBGQ7y7x
 PEN/2dIHIUTDFWGyJckOXyBqiuwm/EroyzFoEl31KgW5xZ3CYLp8SacYtHN2vRkyXWOoGQhspP
 7X47T+34oYPIuYgAAAA==
X-Change-ID: 20250314-b4-mipi-synaptic-fb2a90c0f5f0
To: Michael Trimarchi <michael@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Tejas Vipin <tejasvipin76@gmail.com>, Doug Anderson <dianders@chromium.org>, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741927648; l=7945;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=qBcjxqrKDX/FFETejgVDiOVbJMCbdZawpuZVcVlypIs=;
 b=9jaaZKNGfMN7bf8ew9MG9LFrt7DOltwRe0Avvnmvn2dvnSnuFBc5GdgjebILPduuIvU5Kp0ou
 D4PCz7qxPM3CD4V6pPuImDS2ZRO88zRyaf+ezCpaA7wlLo3JrDkONsc
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move away from using deprecated API and use _multi
variants if available. Use mipi_dsi_msleep()
and mipi_dsi_usleep_range() instead of msleep()
and usleep_range() respectively.

Used Coccinelle to find the _multi variant APIs,
replacing mpi_dsi_msleep() where necessary and for returning
dsi_ctx.accum_err in these functions. Manually handled the
reset step before returning from r63353_panel_activate()

v2: Do not skip the reset in case of error during
panel activate (Dmitry)
- Convert all usleep_range()

v3: mipi_dsi_usleep_range() is to be used only when in
between _multi commands(Doug)
- Check for error once in the end while using _multi
variants (Doug)

@rule_1@
identifier dsi_var;
identifier r;
identifier func;
type t;
position p;
expression dsi_device;
expression list es;
@@
t func(...) {
...
struct mipi_dsi_device *dsi_var = dsi_device;
+struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
<+...
(
-r = mipi_dsi_dcs_nop(dsi_var)@p;
+mipi_dsi_dcs_nop_multi(&dsi_ctx);
|
-r = mipi_dsi_dcs_exit_sleep_mode(dsi_var)@p;
+mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
|
-r = mipi_dsi_dcs_enter_sleep_mode(dsi_var)@p;
+mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
|
-r = mipi_dsi_dcs_write_buffer(dsi_var,es)@p;
+mipi_dsi_dcs_write_buffer_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_set_display_off(dsi_var,es)@p;
+mipi_dsi_dcs_set_display_off_multi(&dsi_ctx,es);
|
-r = mipi_dsi_compression_mode_ext(dsi_var,es)@p;
+mipi_dsi_compression_mode_ext_multi(&dsi_ctx,es);
|
-r = mipi_dsi_compression_mode(dsi_var,es)@p;
+mipi_dsi_compression_mode_multi(&dsi_ctx,es);
|
-r = mipi_dsi_picture_parameter_set(dsi_var,es)@p;
+mipi_dsi_picture_parameter_set_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_set_display_on(dsi_var,es)@p;
+mipi_dsi_dcs_set_display_on_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_set_tear_on(dsi_var)@p;
+mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx);
|
-r = mipi_dsi_turn_on_peripheral(dsi_var)@p;
+mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
|
-r = mipi_dsi_dcs_soft_reset(dsi_var)@p;
+mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
|
-r = mipi_dsi_dcs_set_display_brightness(dsi_var,es)@p;
+mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_set_pixel_format(dsi_var,es)@p;
+mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_set_column_address(dsi_var,es)@p;
+mipi_dsi_dcs_set_column_address_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_set_page_address(dsi_var,es)@p;
+mipi_dsi_dcs_set_page_address_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_set_tear_scanline(dsi_var,es)@p;
+mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx,es);
)
-if(r < 0) {
-...
-}
...+>
}

@rule_2@
identifier dsi_var;
identifier r;
identifier func;
type t;
position p;
expression dsi_device;
expression list es;
@@
t func(...) {
...
struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
<+...
(
-r = msleep(es)@p;
+r = mipi_dsi_msleep(&dsi_ctx,es);
|
-msleep(es)@p;
+mipi_dsi_msleep(&dsi_ctx,es);
|
-r = usleep_range(es)@p;
+r = mipi_dsi_usleep_range(&dsi_ctx,es);
|
-usleep_range(es)@p;
+mipi_dsi_usleep_range(&dsi_ctx,es);
)
...+>
}

@rule_3@
identifier dsi_var;
identifier func;
type t;
position p;
expression list es;
@@
t func(...) {
...
struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
...
-return 0;
+return dsi_ctx.accum_err;
}

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Previous attempt for this change was addressed in:[1]
The series did not handle returns properly and still
used msleep() and usleep_range() API.
It also collided with an Tejas's similar efforts.

Will be sending the patches per driver instead of
major haul of changes.

Following [2] for reference.

[1] -> https://patchwork.freedesktop.org/series/144824/
[2] -> https://lore.kernel.org/dri-devel/20250220045721.145905-1-tejasvipin76@gmail.com/#iZ31drivers:gpu:drm:panel:panel-sony-td4353-jdi.c
---
Changes in v3:
- Modify the script to handle returns and msleeps ()
- handle reset in case of error properly

- Link to v2: https://lore.kernel.org/all/20250310-mipi-synaptic-1-v2-1-20ee4397c670@redhat.com/
__
Changes in v2:
- Handle the reset case properly 
- Handle msleep() and  usleep_range()

- Link to v1: https://lore.kernel.org/r/20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com
---
 drivers/gpu/drm/panel/panel-synaptics-r63353.c | 66 ++++++++------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
index 17349825543fe6a117bbfd9cb92a564ce433d13a..e792d6124183d881d07cbafdd0e2dd1a0d034a6f 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -106,53 +106,34 @@ static int r63353_panel_power_off(struct r63353_panel *rpanel)
 static int r63353_panel_activate(struct r63353_panel *rpanel)
 {
 	struct mipi_dsi_device *dsi = rpanel->dsi;
-	struct device *dev = &dsi->dev;
-	int i, ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+	int i;
 
-	ret = mipi_dsi_dcs_soft_reset(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
-		goto fail;
-	}
+	mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
 
-	usleep_range(15000, 17000);
+	mipi_dsi_usleep_range(&dsi_ctx, 15000, 17000);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
-		goto fail;
-	}
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	for (i = 0; i < rpanel->pdata->init_length; i++) {
 		const struct r63353_instr *instr = &rpanel->pdata->init[i];
 
-		ret = mipi_dsi_dcs_write_buffer(dsi, instr->data, instr->len);
-		if (ret < 0)
-			goto fail;
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data,
+						instr->len);
 	}
 
-	msleep(120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
-		goto fail;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
-	usleep_range(5000, 10000);
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display ON (%d)\n", ret);
-		goto fail;
-	}
-
-	return 0;
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-fail:
-	gpiod_set_value(rpanel->reset_gpio, 0);
+	if (dsi_ctx.accum_err)
+		gpiod_set_value(rpanel->reset_gpio, 0);
 
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
 static int r63353_panel_prepare(struct drm_panel *panel)
@@ -181,24 +162,15 @@ static int r63353_panel_prepare(struct drm_panel *panel)
 static int r63353_panel_deactivate(struct r63353_panel *rpanel)
 {
 	struct mipi_dsi_device *dsi = rpanel->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display OFF (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	usleep_range(5000, 10000);
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int r63353_panel_unprepare(struct drm_panel *panel)

---
base-commit: dbe74119ff71c00f2d863a32f72aab2d15e61c39
change-id: 20250314-b4-mipi-synaptic-fb2a90c0f5f0

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>



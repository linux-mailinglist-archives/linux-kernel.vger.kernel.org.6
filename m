Return-Path: <linux-kernel+bounces-260339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4893A787
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C07F1F230A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C4313DDB8;
	Tue, 23 Jul 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aCk1HZWv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7DE13D898
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761199; cv=none; b=JsNH7wf8IZoU3hVXx/EHzZdT6br/fBz57FGnBzw1izg/27Vt4MYrvDYDrpuluESwp/fhSzwjGUBaS8n9yRPLq9ZAvHaXKmJLda7w8GbSL/M+hfa6r7HSBvVOnbncS+yjl/kWtXtBwnldf85aMLMdfNfpx6bJj+4qg7lX/shLPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761199; c=relaxed/simple;
	bh=RwYPrvi222xRji9SWo1Xwclxue1KfidT5TaV9UbvpG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhOyI7ZJQsdfpY+K+a+eM9SWi/ZhmewbpaYBjTnJcvrRiWtGIKVbrGRZaWaCSsh7OosXhizk9NX4bQGXne/0pd/5vjfdfmAEoojbQZjtZgGBSb/ob14NV3NteQy2RXK/qXYbFrR9l/YHPihFgOLnGHUIbyrxcRq4QbgYdejHWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aCk1HZWv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721761190;
	bh=RwYPrvi222xRji9SWo1Xwclxue1KfidT5TaV9UbvpG0=;
	h=From:To:Cc:Subject:Date:From;
	b=aCk1HZWvbCJrTOjL/PW+OmK2/DRjFq5CT99Uy4KweM23nXDw/wMfJB8/oz7Dn3aDC
	 31GftawLc/a3gmi4HEmdlvO31SV6C+o0XO/VPZZU5ahbl7kWF1QP+t5oztqSiip8ye
	 +eRzVZCO3EY64c+nrlcITTl1UqAxo7SqzKC7FNeiNlYyM5my8SYtX0MrHbC0PcKUfj
	 cwb6T5wT9UjfgZSRF86+FxSFw7TvSBGHeywtS9IOol8GC4maYuzbk8RjSwH4hKX8OW
	 yK6uXauFU3u3h+9IIW2Ok9GxCKSdLTbzPUC/JtdjBABaOE2LiXkUJ+mr9ioQfXLFtV
	 dCcwqva61dFiA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rmader)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 07490378206B;
	Tue, 23 Jul 2024 18:59:49 +0000 (UTC)
From: Robert Mader <robert.mader@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: jacopo@jmondi.org,
	sakari.ailus@linux.intel.com,
	javierm@redhat.com,
	Robert Mader <robert.mader@collabora.com>
Subject: [PATCH] media: i2c: imx355: Parse and register properties
Date: Tue, 23 Jul 2024 20:58:56 +0200
Message-ID: <20240723185856.92814-1-robert.mader@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Analogous to e.g. the imx219. This enables propagating
V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
can detect the correct rotation from the device tree
and propagate it further to e.g. Pipewire.

Signed-off-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/media/i2c/imx355.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index 7e9c2f65fa08..0dd25eeea60b 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1520,6 +1520,7 @@ static const struct v4l2_subdev_internal_ops imx355_internal_ops = {
 static int imx355_init_controls(struct imx355 *imx355)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
+	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	s64 exposure_max;
 	s64 vblank_def;
@@ -1531,7 +1532,7 @@ static int imx355_init_controls(struct imx355 *imx355)
 	int ret;
 
 	ctrl_hdlr = &imx355->ctrl_handler;
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 12);
 	if (ret)
 		return ret;
 
@@ -1603,6 +1604,15 @@ static int imx355_init_controls(struct imx355 *imx355)
 		goto error;
 	}
 
+	ret = v4l2_fwnode_device_parse(&client->dev, &props);
+	if (ret)
+		goto error;
+
+	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx355_ctrl_ops,
+					      &props);
+	if (ret)
+		goto error;
+
 	imx355->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
-- 
2.45.2



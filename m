Return-Path: <linux-kernel+bounces-209040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A93902C42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE6A1F22E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4681527B3;
	Mon, 10 Jun 2024 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mc7Npuc6"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF7152178
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060998; cv=none; b=GIlrlbiPQiQGENnTqgN2D+AJ212qkVR1qwKKPy8RdZKdA5t+Z6Dos3G6OeXphpNraO/jewNSfhopQGZgldPa2U0xgBaZxa0enGU55M23oYmfE9uV/xf52yJRrCAJv3+fMSN8WDJDGPfTQIyEkmHsIJ4fb0tBgf2A9uCCCmE/7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060998; c=relaxed/simple;
	bh=5KtcvntcMUZkACMFk5rU2ybB+ZMYW6Y9YCbSQeSS2kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFX12nXgugvAPqMw3OZztAb1ii1KUjTWaRNtWU35ebtxrL78Cub7QbMJQcibBR6USA9lgn7wo8mHSCYF/bHekq/SATCBFFVkNq5bbvqZACYo0f37dFxVPMTKAznh3SntiMQzjAXM/bVPgUqe1l7SB4Abl0QjCLrCNNrKiK6hHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mc7Npuc6; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b064841f81so30285256d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718060996; x=1718665796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbM4kNTJNPzmGxmhqRn7T4MAUpw44gO0YyJKcWOn6hw=;
        b=Mc7Npuc6hM3Sm4YInJw6f/eWbK+ZllD/PKntLxkuLKT2k307yJQTF5fqSOLSVWr8hR
         BdiCpk5OevTGPDiXrKZfjPOytON3ZrCbC/J6xvBd58HbZhT3Cr0gbYJkvrzuy1ZIBhqZ
         tttuvZiuDttG2r8Sn8/SwPRPUXxarZ2V1u5y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060996; x=1718665796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbM4kNTJNPzmGxmhqRn7T4MAUpw44gO0YyJKcWOn6hw=;
        b=NGGwKEJp/dueh48C27UNRy3STNyGy3aUlhU3R1ec6fCDL650mn6ezFaFS2GRDBwqOd
         qHTcQ+0Qwi9Dt56Dom4ogS+K1U65/J+AYKNOTEwmcK2CN55f7kcHPfgMUTkE7Xu21orT
         5a7Se13A8fmzoPegXf1Ol2u0A6XcSkq3j2e/vpg+QTDO+bDIMQLDSN8aILIi6okPl/Wy
         7zEzYFqexLVvJjRbm4hLVzuPRkXUHt8rQiymQe93M89RWhZrjzplWvzEw/oeqAPPwq0T
         gsF9Ot675tdeEKQ4Dz96tNTdJ0IESs/2/85W4VWK9R/arzHktHMtcTWJsYqA7lKht93y
         U9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0SOZWj+FTG7PlnIL6Dv5al/c3f2Ij3qaPjtVM7yAvasjeMnrKha5wLeYICrI9UEH04OCIo5j5TEsSGTOsFJP29yo5HD+grFUUPiA7
X-Gm-Message-State: AOJu0YyyCLj8h9FbrulKXZcrmeKftVfHDwRSVGRh2ZMapeOQonvVHni7
	aj0gs7cboqaKgO6xqL8ZIh9jfEu95Km4DjTYwfCpxjAelmcGP2MnpS0DbaGa4A==
X-Google-Smtp-Source: AGHT+IH2h0TqAZAmA0RqqwWg+HjA1/ZYxta7QDd7AU9qer6HLjPF9Oj/kvRaWHlK8xVe5Q9cgLSkww==
X-Received: by 2002:a05:6214:524a:b0:6b0:6b57:4c57 with SMTP id 6a1803df08f44-6b06b574fbbmr88218606d6.1.1718060995938;
        Mon, 10 Jun 2024 16:09:55 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06519d521sm35256946d6.65.2024.06.10.16.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 16:09:55 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 10 Jun 2024 23:09:53 +0000
Subject: [PATCH v2 2/7] media: uvcvideo: Refactor Power Line Frequency
 limit selection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-billion-v2-2-38e861475f85@chromium.org>
References: <20240610-billion-v2-0-38e861475f85@chromium.org>
In-Reply-To: <20240610-billion-v2-0-38e861475f85@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Move the PLF mapping logic to its own function. This patch does not
introduce any new functionality to the logic, it is just a preparation
patch.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 93 ++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 38 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 44ec185a8c8b..d82cfc56dfd5 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -459,6 +459,56 @@ static void uvc_ctrl_set_rel_speed(struct uvc_control_mapping *mapping,
 	data[first+1] = min_t(int, abs(value), 0xff);
 }
 
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
+};
+
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
+};
+
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
+				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
+};
+
+static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
+	struct uvc_control *ctrl, const struct uvc_control_mapping *mapping);
+
+static int uvc_ctrl_add_plf_mapping(struct uvc_video_chain *chain,
+	struct uvc_control *ctrl, const struct uvc_control_mapping *mapping)
+{
+	if (chain->dev->uvc_version < 0x150)
+		return __uvc_ctrl_add_mapping(chain, ctrl,
+					      &uvc_ctrl_power_line_mapping_uvc11);
+
+	return __uvc_ctrl_add_mapping(chain, ctrl,
+				      &uvc_ctrl_power_line_mapping_uvc15);
+}
+
 static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	{
 		.id		= V4L2_CID_BRIGHTNESS,
@@ -748,51 +798,18 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
 		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
 	},
-};
-
-const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
-				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
-};
-
-const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
-				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
+	{
+		.entity		= UVC_GUID_UVC_PROCESSING,
+		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+		.add_mapping	= uvc_ctrl_add_plf_mapping,
+	},
 };
 
 static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc11[] = {
-	&uvc_ctrl_power_line_mapping_uvc11,
 	NULL, /* Sentinel */
 };
 
-static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
-				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
-};
-
 static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc15[] = {
-	&uvc_ctrl_power_line_mapping_uvc15,
 	NULL, /* Sentinel */
 };
 

-- 
2.45.2.505.gda0bf45e8d-goog



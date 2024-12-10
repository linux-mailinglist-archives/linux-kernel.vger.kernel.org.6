Return-Path: <linux-kernel+bounces-439251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027AA9EACC4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031B318894A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD91212D82;
	Tue, 10 Dec 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODvp8bFM"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2E210F65
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823768; cv=none; b=pNibFCGHaiXjGHLmVnEViPLkGiizcbQyapXGhL7d491uoqyk691TWOqe146i/dOPYhLcUVhpBAFdECEoMVc+pGmTXC17xCgvFoqtelmlqJ/QMsTDVNIgeBSkVlr/W701lIZPZOPeyjnq6NN+BVP8ev1ITF8b369O5hAEeNEbneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823768; c=relaxed/simple;
	bh=K0DZI4UBFz6Q1LavHWAO5fp1PzEV7p8YAKo5Gp+ADQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLtAfyxCPSmaHfTM9r9U4gCwNLQEHi9QhI/Xc7rA7H0rk6Bq3Jv/qz2Hx4uK6cyiVo2bQNjvJ1NOTiL1p3SkrYEK1CdwYtXGQ6R9aPABUu1ORt6yHVBvfIz9Mc+hcSzNodhVGfZunj1tNKxIMyhKshwO7yHhM6H6pmmaHQC175I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ODvp8bFM; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d91653e9d7so12286926d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823766; x=1734428566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mf5LuVEPO74SAkZYBzrIXfOzplKA9uICYltmS7j18Lk=;
        b=ODvp8bFMPzJS7ZzEPtMgocFmFvOqb1zUnnsB2AiH7hD71egqUt7xXD/HwGUR3Fi6V2
         xFomojbgsFPEHVhB8PQnoqpNwcWZhyeNl1xxCVjZLgORVxV7PHia+dJXP1IfsJvslTgh
         f42AaaoW03IubAZKLrZMs6qHMqE4ygKvXhqZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823766; x=1734428566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf5LuVEPO74SAkZYBzrIXfOzplKA9uICYltmS7j18Lk=;
        b=jUZdgsEAXmDmTX9v421P465k889QH3Z9yl0t1Zz7z+3uMYh9cJdeheJBZxxb7Qd4Mo
         EtI58aQp/RjUBD+vv9868I2l90xqy/eHsxTlv272NrTxYE8PgQKhSNSAPXGpXJpZFcsd
         bccKGJcxROYunFqy9gpd/lZAw6OFrlbkU63PBGvCZcVLRCTK29LAukQFZgYVArNNxurz
         t5+JM/4nsFSwE0jKaukDhL+Fz8YwPT+oKFPm11GansxyMUMbVvizV4YaHHJjaN2G17k4
         t5JU58n/B8KFfLcvCH2pqi+pcv4bjXsy7XNVnMI3pBCJxIfH0OARvK5KEbu3VnNzQsfe
         IAGw==
X-Forwarded-Encrypted: i=1; AJvYcCXqoCuSR0Iw6sldHsbIM4IoFBBzYWzXGWGvckPBPHtpAnMHf/L5b1U4lAD7Rq48Z0wf7YK+WjR43BqsZmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxch8wAfnwSrw63BhLudsG7dbM33nvya8EIdDdTJNiZDfmpN9WS
	K3yP8NHeflDJZWsuhytGWoWEO4GktM2zNQn1SSR/m7BhHs68gD6Qbikkx+/oqg==
X-Gm-Gg: ASbGncv10+NV6nAJeQk7iHRBP3D9+JRfchz2mQwGmR9VpXvXFobPd2RYxwoIwenNGGC
	6FImBmnLU0nGdTafQsDot8gTMkD8Nk2SzFot20ZQuk4VYakYkKT1jWnmC476uOqD2CmLVJyDy7A
	vgneclkFtGlji8dpYHkbtepYb4d02P1/DMMgIHqjFAzoblPxWLTw9JWB/RTeG76PM5zzGH3Zlrg
	1YzaNMyUnlsttlHPiEF2RsBX3sSN1D8KrbIeYA8pM6D9Ijp8KfYHLkVhV9EVvQgMn5IcMdEwhBS
	LfKqo51e+kEDon9D8SGObq5/ewTY
X-Google-Smtp-Source: AGHT+IGT4gzfITvLDwHStH5Rg/t89JsU98DuOgF0s+ypUy2x7EUDyd1LNn2KVDFdffsHdPjaiYA0UA==
X-Received: by 2002:a05:6214:76b:b0:6d8:8165:ef21 with SMTP id 6a1803df08f44-6d8e727e5f5mr249233116d6.49.1733823766038;
        Tue, 10 Dec 2024 01:42:46 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:42:45 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:40 +0000
Subject: [PATCH v16 04/18] media: vivid: Add a rectangle control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-4-e8201f7e8e57@chromium.org>
References: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
In-Reply-To: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Yunke Cao <yunkec@google.com>, Hans Verkuil <hverkuil@xs4all.nl>
X-Mailer: b4 0.13.0

From: Yunke Cao <yunkec@google.com>

This control represents a generic read/write rectangle.
It supports V4L2_CTRL_WHICH_MIN/MAX_VAL.

Signed-off-by: Yunke Cao <yunkec@google.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Tested-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/test-drivers/vivid/vivid-ctrls.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-ctrls.c b/drivers/media/test-drivers/vivid/vivid-ctrls.c
index 2b5c8fbcd0a2..57346b714534 100644
--- a/drivers/media/test-drivers/vivid/vivid-ctrls.c
+++ b/drivers/media/test-drivers/vivid/vivid-ctrls.c
@@ -37,6 +37,7 @@
 #define VIVID_CID_U8_PIXEL_ARRAY	(VIVID_CID_CUSTOM_BASE + 14)
 #define VIVID_CID_S32_ARRAY		(VIVID_CID_CUSTOM_BASE + 15)
 #define VIVID_CID_S64_ARRAY		(VIVID_CID_CUSTOM_BASE + 16)
+#define VIVID_CID_RECT			(VIVID_CID_CUSTOM_BASE + 17)
 
 #define VIVID_CID_VIVID_BASE		(0x00f00000 | 0xf000)
 #define VIVID_CID_VIVID_CLASS		(0x00f00000 | 1)
@@ -360,6 +361,38 @@ static const struct v4l2_ctrl_config vivid_ctrl_ro_int32 = {
 	.step = 1,
 };
 
+static const struct v4l2_rect rect_def = {
+	.top = 100,
+	.left = 200,
+	.width = 300,
+	.height = 400,
+};
+
+static const struct v4l2_rect rect_min = {
+	.top = 0,
+	.left = 0,
+	.width = 1,
+	.height = 1,
+};
+
+static const struct v4l2_rect rect_max = {
+	.top = 0,
+	.left = 0,
+	.width = 1000,
+	.height = 2000,
+};
+
+static const struct v4l2_ctrl_config vivid_ctrl_rect = {
+	.ops = &vivid_user_gen_ctrl_ops,
+	.id = VIVID_CID_RECT,
+	.name = "Rect",
+	.type = V4L2_CTRL_TYPE_RECT,
+	.flags = V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX,
+	.p_def.p_const = &rect_def,
+	.p_min.p_const = &rect_min,
+	.p_max.p_const = &rect_max,
+};
+
 /* Framebuffer Controls */
 
 static int vivid_fb_s_ctrl(struct v4l2_ctrl *ctrl)
@@ -1685,6 +1718,7 @@ int vivid_create_controls(struct vivid_dev *dev, bool show_ccs_cap,
 	dev->int_menu = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_int_menu, NULL);
 	dev->ro_int32 = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_ro_int32, NULL);
 	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_area, NULL);
+	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_rect, NULL);
 	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u32_array, NULL);
 	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u32_dyn_array, NULL);
 	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u16_matrix, NULL);

-- 
2.47.0.338.g60cca15819-goog



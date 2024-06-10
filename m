Return-Path: <linux-kernel+bounces-209041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1119902C44
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C3B1C219A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA0153804;
	Mon, 10 Jun 2024 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lm6+NkQk"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF10152516
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061000; cv=none; b=Z2dy2Y2SvL9i3+Hhu7mRWxLL7ObhG+16Ex5jxrwKDJ++BUfA9spT+8JP+qExWKEvf+66Dv8tmTF/NCkp15dMa4oukq1PjDfCz2eoeBtNKaLn6vDMrfggckq2i0D1ZWbPbbpEMZxUpIGlOHODmD1/Leg9TTEJ6RyfDqdEFI0zCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061000; c=relaxed/simple;
	bh=j8MR+0Zdp3uWVc1WjRQyCRAas8P1RT3ZjAZLRfXEnB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+hv4bAlIVh0PCPdMzhcVxz+QiWXz+TUQmUHT0VGwVPi6XpW1GSt1fAEIAuUAu6TsI/KdATWTbi3LHssB2ST38V1sm7QD3mtVb64bFg/88ZBQ2mwaMzPJ6lTaDDXCnDmGg4i+N2Z0m9XlRT/a5/4ifejWhTchAs9wHiAE6xzSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lm6+NkQk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-627f3265898so52609327b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718060997; x=1718665797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggXYPXXJz9pqRmEYjjKEnuceXrydB78eIdBvang4V2c=;
        b=Lm6+NkQkQqOkqRcP/pR4gBk95xatY6QxI3pmTLlh3/4DviH4OU3zkEtOjcHyt01cos
         PtVCs1GQcMiiKNJFwbUw1MYGg0YVWi4+ImyQ095Et+fIpkEFeEUAGbbtDGOK9/3vsN+J
         f6bIZ0yEioVCLYKnblLSNCR/DTJ/w3MlHlRpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060997; x=1718665797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggXYPXXJz9pqRmEYjjKEnuceXrydB78eIdBvang4V2c=;
        b=jMnt9W/9dIf62YvP62Lfn1kKwznk3HAD4FX3p23wLdqMxvT2kkwTJTckqD/Q8p5YqS
         9wqSnmINMaKkNmlzW6xD7sf3gNEzjvSPz7xRREk/DNiXUPLQV1NXAAmpIKPGSvHGeFz5
         9R/vY/meTH3I4pE8+4gFSDZvoonBqxVg2nbV3odhCrOCP9FBRApT5YgE7dBYEl9Fb+z1
         NWsqxzxoANdw2pU94qFkX7GOHqoFZwo3LuUU/AXnSopojnPcedRLP9QoMby95KJx8zjH
         Jc/67Qai2LBMSNUQGFF/oJ7q/U7263W2su+bsk+xcyPzqQ9JdF0P/hdqTrRCdd2QXKAM
         /ViA==
X-Forwarded-Encrypted: i=1; AJvYcCV2AW9b508l+JrmSVS/odrKWfN/zQWPo4/D3ii4tLtiMNQwpKoOAaQiUUB94OCfJrfDsQVN83vf0+inPBqlw/i3qXJlLb5NnuYgUM/V
X-Gm-Message-State: AOJu0YxSc3o145edV6PJNCaBUU0xahroY9prYmhSd4vQ8HYQ8YH3sLUR
	dWzA5Ih7pi+0nb6qRo1Qro2oxFRNo9lF0SgtM7cGJ+fSziw9x2j/U/S9WIBPKg==
X-Google-Smtp-Source: AGHT+IFkwiQpPmkIhbjE6EIVr7NDSN5urKP15cf7bAX2HFwkUmXks8NU9qkevmNJ0yGvGrwYb+4/Ww==
X-Received: by 2002:a0d:d851:0:b0:618:95a3:70b9 with SMTP id 00721157ae682-62cd565129cmr109244957b3.36.1718060997387;
        Mon, 10 Jun 2024 16:09:57 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06519d521sm35256946d6.65.2024.06.10.16.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 16:09:56 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 10 Jun 2024 23:09:54 +0000
Subject: [PATCH v2 3/7] media: uvcvideo: Probe the PLF characteristics
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-billion-v2-3-38e861475f85@chromium.org>
References: <20240610-billion-v2-0-38e861475f85@chromium.org>
In-Reply-To: <20240610-billion-v2-0-38e861475f85@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The UVC 1.5 standard defines 4 values for the PLF control: Off, 50Hz,
60Hz and Auto. But it does not clearly define if all the values must be
implemented or not.

Instead of just using the UVC version to determine what the PLF control
can do, probe it.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 52 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index d82cfc56dfd5..5b77ac308c84 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -495,18 +495,60 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
 				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
 };
 
-static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
+static int __uvc_ctrl_add_mapping_to_list(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl, const struct uvc_control_mapping *mapping);
 
 static int uvc_ctrl_add_plf_mapping(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl, const struct uvc_control_mapping *mapping)
 {
+	const struct uvc_control_mapping *out_mapping =
+					&uvc_ctrl_power_line_mapping_uvc11;
+	u8 *buf __free(kfree) = NULL;
+	u8 init_val;
+	int ret;
+
+	buf = kmalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Save the default PLF value, so we can restore it. */
+	ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
+			     chain->dev->intfnum, ctrl->info.selector,
+			     buf, sizeof(*buf));
+	/* If we cannot read the control skip it. */
+	if (ret)
+		return ret;
+	init_val = *buf;
+
+	/* If PLF value cannot be set to off, it is limited. */
+	*buf = V4L2_CID_POWER_LINE_FREQUENCY_DISABLED;
+	ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
+			     chain->dev->intfnum, ctrl->info.selector,
+			     buf, sizeof(*buf));
+	if (ret)
+		return __uvc_ctrl_add_mapping_to_list(chain, ctrl,
+					&uvc_ctrl_power_line_mapping_limited);
+
+	/* UVC 1.1 does not define auto, we can exit. */
 	if (chain->dev->uvc_version < 0x150)
-		return __uvc_ctrl_add_mapping(chain, ctrl,
-					      &uvc_ctrl_power_line_mapping_uvc11);
+		goto end;
+
+	/* Check if the device supports auto. */
+	*buf = V4L2_CID_POWER_LINE_FREQUENCY_AUTO;
+	ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
+			     chain->dev->intfnum, ctrl->info.selector,
+			     buf, sizeof(*buf));
+	if (!ret)
+		out_mapping = &uvc_ctrl_power_line_mapping_uvc15;
+
+end:
+	/* Restore initial value and add mapping. */
+	*buf = init_val;
+	uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
+		       chain->dev->intfnum, ctrl->info.selector,
+		       buf, sizeof(*buf));
 
-	return __uvc_ctrl_add_mapping(chain, ctrl,
-				      &uvc_ctrl_power_line_mapping_uvc15);
+	return __uvc_ctrl_add_mapping_to_list(chain, ctrl, out_mapping);
 }
 
 static const struct uvc_control_mapping uvc_ctrl_mappings[] = {

-- 
2.45.2.505.gda0bf45e8d-goog



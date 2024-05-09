Return-Path: <linux-kernel+bounces-175045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FA88C1981
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578DF281BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27166134733;
	Thu,  9 May 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1sn1Npg"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FE12D210
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294264; cv=none; b=UJJ/JNW87zO+CIeAysbNiNTs5wf7FQiIs4e+mBbz/nznBuyP80k5K6U2XbfHFB3cNtQfqJcQwUWoWbHkatGk3e9opQJw8bvv/L2npSdV6vWc9lU5gCCCwDMwATJVWiplHaMeRa8YL8CSsrAg3Lz/i9JqZ768TYGMF+HRAWBtjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294264; c=relaxed/simple;
	bh=19zx/qwcigAhIYqmKy1s852n2d4kEuylkHN2kcUSurk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kl45tj1zVIKGS+NV61jFm+0x5fNjPrT3vsj2xrJzczZ66GwVuf04yPe1WBDSm55rutmaC3SQRhb/VLi6lhGhWbcHFjYY8UFcwkd0En21KfX1UD8OL7SIkMkz74e7cU0F0qyyKL4EC8ZqN432eRzh09mVUwiaz6eBJvyn4nmNJc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B1sn1Npg; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52192578b95so1554976e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715294259; x=1715899059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSx2hn/xWCc6eWMHzVDFgGFEONW2CZf8+nMGEDqucms=;
        b=B1sn1Npgbi3pOfaMLJUzlh43id31UM2u8r1+9i8Rp3Yytiatna5/1yhLQIGFpf/ET9
         b+XMUxpat7cG/MzMfO9A6/S2yo1uCI9ax+d7V4JvPgrTOFwI3cYjIrlG/DIBx/WHEyEy
         4/u1opowdRD6GsJQyb8JG/8S2joGRRqKAC/L4NWX4VDEj3QWj6tEIwkmw1sNAN+Vnhai
         HHwFXJV6CdQhwbBbmTO4bTU+LNNsnXiA7Mxjsm1/hXzdkcIlQYuLxUFEcwa1rZ9qa/b2
         KGQQlMSypPjkcTliG1nq+YHttSE4zGZ/hEbvoZIBulRrSjtFsjD3K08+MQjhtKS9l+0R
         71Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294259; x=1715899059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSx2hn/xWCc6eWMHzVDFgGFEONW2CZf8+nMGEDqucms=;
        b=gy9Wr2Ovy7bd0V3byQQDyJbyT1/oKsXyYjG5o814yGxhCTDBhMyjgdRXdSF0lugNAj
         pUYROjCF4paHJeyKUPh85KE0gGxWGUgzVc0ACnKeod/xwrBMJ4kE3wBXrJRq0hcGAFVQ
         IsL478Nv3VvHK9PvoEF2hWdl7ggZ8X1EvUa8zrPBZYPs/hVc7ZWoJf3T8f2urDTvvI7N
         3Jcn2xhdqlFdqMgSPUpXq0rfvkEh5BCShAs5Fq0Mye0lAmUC2JP0lJznim3QECdETp3L
         plX5w1GAK7Zki9qP0wmf/HefBH/wbp5DE7bmosv90rjij7u28BoMBSMFatBEMnC9LTGl
         qYGA==
X-Forwarded-Encrypted: i=1; AJvYcCWte9mY43U0mzE+WLbSSuYFO+SD60cMPJqbDJbofX0L6kpEKzYW83DLu8JNtx9ReAxTrEfhegRNTCqGG8D08WyxeVWKmnPRNoQg0oTZ
X-Gm-Message-State: AOJu0YyPLHlSid3mFuQF3fV1KYHvUEwqCA6+W9gEYl4VATLgVC/Q8BGq
	Gga15MBsVrULu8YjzXSnmFUjC2PPOb7qfRhGDvpKKmnIP9P8Dr1H78aPMdRPdIE=
X-Google-Smtp-Source: AGHT+IHaFY07NKwTgoPNxr7uZPPo4Jm7OXbCMiTW3QKXsq4m5RT/eEUmbcE9lEC+pIqoQCbkEwXBHw==
X-Received: by 2002:ac2:424d:0:b0:521:b2b5:60ea with SMTP id 2adb3069b0e04-5220fb6b131mr444931e87.23.1715294259550;
        Thu, 09 May 2024 15:37:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32f1sm457974e87.181.2024.05.09.15.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:37:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 01:37:38 +0300
Subject: [PATCH RFC 5/7] drm/panel: novatek-nt36672e: use wrapped MIPI DCS
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-dsi-panels-upd-api-v1-5-317c78a0dcc8@linaro.org>
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=33067;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=19zx/qwcigAhIYqmKy1s852n2d4kEuylkHN2kcUSurk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ptgL7mqZat2fFcvY+9xVM9HZbd6z6xN1grf9eOCtPLX
 H9/5eV0MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAidXns/xO+GSRcF19TGadV
 n7To6YUFZ1d6/F/+a+7bR+n6nQ6N9/iWfvnNEZuz9flPF2UN2+vVPbs/87danpiY9rieqbAkaHf
 6v+IbxwKUPlsKdjevWdbQ97qDbUv8vifs1mIW81m+SqR5n56jqi67ue+2s4fw2/SwRyv9pWR2xm
 r6RctGPp0UKf5SYKP7Yre0mrM5D0tkucsZawJ4fsYqNdTNtFse9+KtNtOi2DyFek6eqHPt8h2mG
 WJfXzlcLfmw6J7o3TbWbS2LAjcoiUzj7r+cmMv1NDnG8WJ+5+bMdP0ohW47P9Zb06cyWhn7r2Tb
 fFCtL/Fiw9Mg/tXX9l3crM8z49r6GTJ7Qg3MtRe+uzkDAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/exit code. This also includes passing context to
the init_sequence() function instead of passing the DSI device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 587 ++++++++++++-------------
 1 file changed, 281 insertions(+), 306 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index 9ce8df455232..f190285d75a1 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -33,7 +33,7 @@ struct panel_desc {
 	enum mipi_dsi_pixel_format format;
 	unsigned int lanes;
 	const char *panel_name;
-	int (*init_sequence)(struct mipi_dsi_device *dsi);
+	void (*init_sequence)(struct mipi_dsi_multi_context *ctx);
 };
 
 struct nt36672e_panel {
@@ -49,297 +49,293 @@ static inline struct nt36672e_panel *to_nt36672e_panel(struct drm_panel *panel)
 	return container_of(panel, struct nt36672e_panel, panel);
 }
 
-static int nt36672e_1080x2408_60hz_init(struct mipi_dsi_device *dsi)
+static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 {
-	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
-
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc1, 0x89, 0x28, 0x00, 0x08, 0x00, 0xaa, 0x02,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x89, 0x28, 0x00, 0x08, 0x00, 0xaa, 0x02,
 				     0x0e, 0x00, 0x2b, 0x00, 0x07, 0x0d, 0xb7, 0x0c, 0xb7);
 
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc2, 0x1b, 0xa0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x20);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x66);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x06, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x38);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2f, 0x83);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x69, 0x91);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x95, 0xd1);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x96, 0xd1);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x64);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf3, 0x54);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf4, 0x64);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf5, 0x54);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf6, 0x64);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf7, 0x54);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf8, 0x64);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf9, 0x54);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x24);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x03, 0x0c);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x05, 0x1d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x08, 0x2f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x09, 0x2e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0a, 0x2d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0b, 0x2c);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11, 0x17);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0x13);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x13, 0x15);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x15, 0x14);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x16, 0x16);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x17, 0x18);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1d, 0x1d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x2f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x2e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x22, 0x2d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x23, 0x2c);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29, 0x17);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2a, 0x13);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2b, 0x15);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2f, 0x14);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x16);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x31, 0x18);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x32, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x34, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x1f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x36, 0x1f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4d, 0x14);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4e, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4f, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x71, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x79, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7a, 0x82);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7b, 0x8f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7d, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x80, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x81, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x13);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0x31);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x86, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x90, 0x13);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x92, 0x31);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x93, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x94, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x95, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9c, 0xf4);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9d, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa0, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa2, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa3, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa4, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa5, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc6, 0xc0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc9, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd9, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x25);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x18, 0x22);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x19, 0xe4);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x66, 0xd8);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x68, 0x50);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x69, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6b, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6d, 0x0d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6e, 0x48);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x72, 0x41);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x73, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x74, 0xd0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x77, 0x62);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x79, 0x7e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7d, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7e, 0x15);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7f, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0x4d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcf, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd6, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd7, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xef, 0x20);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf0, 0x84);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x26);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x81, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x83, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x86, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x88, 0x05);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8a, 0x1a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8b, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8c, 0x24);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8e, 0x42);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8f, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x90, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x91, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9a, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9b, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9c, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9d, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x9e, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x27);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x68);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x81);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x6a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x25, 0x81);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x26, 0x94);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6e, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6f, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x70, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x71, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x72, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x75, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x76, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x77, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7d, 0x09);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7e, 0x67);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x80, 0x23);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x09);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x83, 0x67);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x88, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x89, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa5, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa6, 0x23);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xa7, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe5, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe6, 0xd3);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xeb, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xec, 0x28);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x2a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x00, 0x91);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x03, 0x20);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x50);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0a, 0x70);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0c, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0d, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0f, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11, 0xe0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x15, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x16, 0xa4);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x19, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1a, 0x78);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x23);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1d, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1e, 0x3e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1f, 0x3e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x3e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x28, 0xfd);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29, 0x12);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2a, 0xe1);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2d, 0x0a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x49);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x33, 0x96);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x34, 0xff);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x36, 0xde);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x37, 0xf9);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x38, 0x45);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x39, 0xd9);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3a, 0x49);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4a, 0xf0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7a, 0x09);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7b, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7f, 0xf0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x83, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0xa4);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x88, 0x78);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x89, 0x23);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8b, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8c, 0x7d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8d, 0x7d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x8e, 0x7d);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x20);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2, 0x1b, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x66);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x06, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x07, 0x38);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2f, 0x83);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x69, 0x91);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x95, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x96, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf2, 0x64);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf3, 0x54);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf4, 0x64);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf5, 0x54);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf6, 0x64);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf7, 0x54);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x64);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf9, 0x54);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x24);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x03, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x05, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x08, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x09, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0a, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0b, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x11, 0x17);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x12, 0x13);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x13, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x15, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x16, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x17, 0x18);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1b, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1d, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x22, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x23, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x29, 0x17);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2a, 0x13);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2b, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2f, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x30, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x31, 0x18);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x32, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x34, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x35, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x36, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4d, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4e, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4f, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x71, 0x30);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x79, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7a, 0x82);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7b, 0x8f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x80, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x81, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x82, 0x13);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0x31);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x85, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x86, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x87, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x90, 0x13);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x92, 0x31);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x93, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x94, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x95, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9c, 0xf4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9d, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa0, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa2, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa3, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa4, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa5, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc6, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc9, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd9, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe9, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x25);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x18, 0x22);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x19, 0xe4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x66, 0xd8);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x68, 0x50);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x69, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6b, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6d, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x72, 0x41);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x73, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x74, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x77, 0x62);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x79, 0x7e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7d, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7e, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0x4d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xcf, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd6, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd7, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xef, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x84);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x26);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x81, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x83, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x85, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x86, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x87, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x88, 0x05);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8a, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8b, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8c, 0x24);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8e, 0x42);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8f, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x90, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x91, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9a, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9b, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x27);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x68);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20, 0x81);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x25, 0x81);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x26, 0x94);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x70, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x71, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x72, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x75, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x77, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7d, 0x09);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7e, 0x67);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x80, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x82, 0x09);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x83, 0x67);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x88, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x89, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa5, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa6, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa7, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe5, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe6, 0xd3);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xeb, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xec, 0x28);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x00, 0x91);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x03, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x07, 0x50);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0a, 0x70);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0c, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x11, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x15, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x16, 0xa4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x19, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1a, 0x78);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1b, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1d, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1e, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1f, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x28, 0xfd);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x29, 0x12);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2a, 0xe1);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2d, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x30, 0x49);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x33, 0x96);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x34, 0xff);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x35, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x36, 0xde);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x37, 0xf9);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x38, 0x45);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x39, 0xd9);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x3a, 0x49);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4a, 0xf0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7a, 0x09);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7b, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7f, 0xf0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x83, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0xa4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x87, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x88, 0x78);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x89, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8b, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8c, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8d, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8e, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
 				     0x6a, 0x00, 0x89, 0x00, 0x9f, 0x00, 0xb6, 0x00, 0xc8);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
 				     0x7a, 0x01, 0xa9, 0x01, 0xf2, 0x02, 0x2d, 0x02, 0x2e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb2, 0x02, 0x64, 0x02, 0xa3, 0x02, 0xca, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb2, 0x02, 0x64, 0x02, 0xa3, 0x02, 0xca, 0x03,
 				     0x00, 0x03, 0x1e, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb3, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb3, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
 				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb4, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
 				     0x71, 0x00, 0x90, 0x00, 0xa7, 0x00, 0xbf, 0x00, 0xd1);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5, 0x00, 0xe2, 0x01, 0x1a, 0x01, 0x43, 0x01,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb5, 0x00, 0xe2, 0x01, 0x1a, 0x01, 0x43, 0x01,
 				     0x83, 0x01, 0xb2, 0x01, 0xfa, 0x02, 0x34, 0x02, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x02, 0x6b, 0x02, 0xa8, 0x02, 0xd0, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6, 0x02, 0x6b, 0x02, 0xa8, 0x02, 0xd0, 0x03,
 				     0x03, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5b, 0x03, 0x6b);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb7, 0x03, 0x7e, 0x03, 0x94, 0x03, 0xac, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb7, 0x03, 0x7e, 0x03, 0x94, 0x03, 0xac, 0x03,
 				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb8, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb8, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
 				     0x72, 0x00, 0x92, 0x00, 0xa8, 0x00, 0xbf, 0x00, 0xd1);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9, 0x00, 0xe2, 0x01, 0x18, 0x01, 0x42, 0x01,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb9, 0x00, 0xe2, 0x01, 0x18, 0x01, 0x42, 0x01,
 				     0x81, 0x01, 0xaf, 0x01, 0xf5, 0x02, 0x2f, 0x02, 0x31);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xcd, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xba, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xcd, 0x03,
 				     0x01, 0x03, 0x1f, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
 				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x21);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x21);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
 				     0x6a, 0x00, 0x89, 0x00, 0x9f, 0x00, 0xb6, 0x00, 0xc8);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
 				     0x7a, 0x01, 0xa9, 0x01, 0xf2, 0x02, 0x2d, 0x02, 0x2e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb2, 0x02, 0x64, 0x02, 0xa3, 0x02, 0xca, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb2, 0x02, 0x64, 0x02, 0xa3, 0x02, 0xca, 0x03,
 				     0x00, 0x03, 0x1e, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb3, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb3, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
 				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb4, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
 				     0x71, 0x00, 0x90, 0x00, 0xa7, 0x00, 0xbf, 0x00, 0xd1);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5, 0x00, 0xe2, 0x01, 0x1a, 0x01, 0x43, 0x01,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb5, 0x00, 0xe2, 0x01, 0x1a, 0x01, 0x43, 0x01,
 				     0x83, 0x01, 0xb2, 0x01, 0xfa, 0x02, 0x34, 0x02, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x02, 0x6b, 0x02, 0xa8, 0x02, 0xd0, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6, 0x02, 0x6b, 0x02, 0xa8, 0x02, 0xd0, 0x03,
 				     0x03, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5b, 0x03, 0x6b);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb7, 0x03, 0x7e, 0x03, 0x94, 0x03, 0xac, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb7, 0x03, 0x7e, 0x03, 0x94, 0x03, 0xac, 0x03,
 				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb8, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb8, 0x00, 0x00, 0x00, 0x1b, 0x00, 0x51, 0x00,
 				     0x72, 0x00, 0x92, 0x00, 0xa8, 0x00, 0xbf, 0x00, 0xd1);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9, 0x00, 0xe2, 0x01, 0x18, 0x01, 0x42, 0x01,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb9, 0x00, 0xe2, 0x01, 0x18, 0x01, 0x42, 0x01,
 				     0x81, 0x01, 0xaf, 0x01, 0xf5, 0x02, 0x2f, 0x02, 0x31);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xcd, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xba, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xcd, 0x03,
 				     0x01, 0x03, 0x1f, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
 				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x2c);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x61, 0x1f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x62, 0x1f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7e, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6a, 0x14);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6b, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6c, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6d, 0x36);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x54, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x56, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x58, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x59, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0xf0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5a, 0x00);
-
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x51, 0xff);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x24);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x01);
-
-	return ctx.accum_err;
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x61, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x62, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7e, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6a, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6b, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6c, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6d, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x54, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x56, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x58, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x59, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0xf0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x5a, 0x00);
+
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x51, 0xff);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x24);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x01);
 }
 
 static int nt36672e_power_on(struct nt36672e_panel *ctx)
@@ -381,61 +377,40 @@ static int nt36672e_power_off(struct nt36672e_panel *ctx)
 	return ret;
 }
 
-static int nt36672e_on(struct nt36672e_panel *ctx)
+static int nt36672e_on(struct nt36672e_panel *panel)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	const struct panel_desc *desc = ctx->desc;
-	int ret = 0;
+	struct mipi_dsi_multi_context ctx = { .dsi = panel->dsi };
+	struct mipi_dsi_device *dsi = panel->dsi;
+	const struct panel_desc *desc = panel->desc;
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	if (desc->init_sequence) {
-		ret = desc->init_sequence(dsi);
-		if (ret < 0) {
-			dev_err(&dsi->dev, "panel init sequence failed: %d\n", ret);
-			return ret;
-		}
-	}
+	if (desc->init_sequence)
+		desc->init_sequence(&ctx);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(&dsi->dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 120);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(&dsi->dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-	msleep(100);
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
 
-	return 0;
+	mipi_dsi_msleep(&ctx, 100);
+
+	return ctx.accum_err;
 }
 
-static int nt36672e_off(struct nt36672e_panel *ctx)
+static int nt36672e_off(struct nt36672e_panel *panel)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	int ret = 0;
+	struct mipi_dsi_multi_context ctx = { .dsi = panel->dsi };
 
-	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	panel->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(&dsi->dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 20);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(&dsi->dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(60);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 60);
 
-	return 0;
+	return ctx.accum_err;
 }
 
 static int nt36672e_panel_prepare(struct drm_panel *panel)

-- 
2.39.2



Return-Path: <linux-kernel+bounces-301488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00195F195
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2211C203DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FCE17BEB9;
	Mon, 26 Aug 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCvoQgwP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9A1917E6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675937; cv=none; b=a871Xnsy87i7Auk2cg6Kiw/r7eErvMW0DubR7GwSpFXvrxqIxh1RnmUChnX7t9mgMd/iK4Q6/ERYBMnMFRVMV5DXlY4O1v2429oHF7BMSfDab3EYyYgUpxFuacei2H2bS3wnnmBdO7a6hd2iGfr10S7WonmtdQb8tKeeUunQaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675937; c=relaxed/simple;
	bh=+e10XPuiMARtA5K0eNcePXnpWtDd9Uk/clN3e+gYM28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B25LXSlFvi+1ySahGmjVYX0EV1TymksSeKYcok2yt3H6Al4FYGK2aaoo4zE7zQuLlfXPvEp2ztvuzDwVAu08+6l5zxeSSrDqM1ZWyuhQSyMQn5utYl5sfxq5s7B47o5zWO7Zqp05kyZ9NWgKuJeosPAZaRhfbtQkxiLJkqvDS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCvoQgwP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86b64ebd8aso102094866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724675934; x=1725280734; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bKw6ncLyi+fm5o3G3Satq2KEYMjjZZXHTYXpkPSF7g=;
        b=vCvoQgwPcX9Q8FusoXF6N13yHtNhb+X0r7lfOxuTHHL9J8yb21wnMslzjUcKMqAXqA
         aNjsXJFvRqOVKif8XsZDokv/n375d0zR7OCJ5P2htBNWLoSwRT4Gw9vh4rX1d/QP5V+G
         FxJR0ysqmSXVViOjeZbZXZJEuxodX6IgmdS3PjWSfzIKPQRJsNYkWioOIODs2n3L2aEQ
         Vx8guJ5l1eaHbInZEZpKHJYa5B1mTz8+mU2FzdvoTnsQRS4VrTUdGE4l4RpKdiw1SgBO
         29GMqGUOmL/qE8flnfH641aFt0FbWDwte4BpGMJo9hhzjFTAtGrud+2PApjeJO661dPi
         Nfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675934; x=1725280734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bKw6ncLyi+fm5o3G3Satq2KEYMjjZZXHTYXpkPSF7g=;
        b=wY7+gAgx58pFhK2caI996EHHKPhMR5rzpwXOXzw6CQdKSA9nJ6rMVNH12hzMxLWHkt
         AjWQ7hUBiC3VoP7cDBdkaO2ye9jhopinspTOfIbIQQExhQUX7pK6G4lm30AJ0gLMVRGD
         +3gVcelJQ+e5Go2M09db/sWdZ+2NZ/RckACYc86ufWS0wR3El8/uRkEiYvBZzFmDqs5F
         XW42K6pG1inw+PJ69DbXJR2igzFHAqIRGLFunTvDaqiY7f3Y2MYOKkNx1PFN3npsDOu+
         14KVEMdqfqQVz9q9ycZ+dke3lLKEuzxIUr+vGwDR3nvzH/CDPnU8vE0VR0j01nz09uP4
         71sg==
X-Forwarded-Encrypted: i=1; AJvYcCU7ELCOL04nKIDs1FRGM69z7nBnTxi6HBAKZgLG8t7KyxoTXY0KJm0xyOjAv/m9aYeI8ZXcjc6H7czF5lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxv9MhzY6KBhKDzd0ixE9PXnJuyQZVVDiemBwwvplSe1mW7f45
	BQcY6ReHiYI+khsJHtzCJpBkfpjNZE6EayIZXKHYWZW7bemDC2zN34E9ghLmviE=
X-Google-Smtp-Source: AGHT+IEBiaR65UU0z1BHj73azi65/R2fj1moYsCYZxrHobqHOKYOiVkDl8d1vGon3RAihTXLKfLT0g==
X-Received: by 2002:a05:6402:42cf:b0:5be:fc2e:b7ce with SMTP id 4fb4d7f45d1cf-5c0891756cemr9202177a12.19.1724675933498;
        Mon, 26 Aug 2024 05:38:53 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca499sm5570303a12.34.2024.08.26.05.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:38:53 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 26 Aug 2024 15:38:46 +0300
Subject: [PATCH v2] drm/panel-edp: add BOE NE140WUM-N6G panel entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-drm-panel-edp-add-boe-ne140wum-n6g-v2-1-2758e8574842@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFV3zGYC/5WNQQ6CMBAAv0J6dk1bCiIn/2E4FHaBJtCSraKG8
 HcrP/A4c5jZRCR2FEWdbYJpddEFn0CfMtGN1g8EDhMLLbWRlc4BeYbFepqAcAGLCG0g8KSMfD1
 n8OUAVPR9aYrKXtGKFFqYevc+Jvcm8ejiI/DneK7qZ//KrwoUXFrEvJMyL5S5Tc5bDufAg2j2f
 f8C8TI8z9UAAAA=
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=+e10XPuiMARtA5K0eNcePXnpWtDd9Uk/clN3e+gYM28=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmzHdYh4YAWlD4N0kK5iLViuZUR+oCvuLo/s7MM
 GCQdjlsXkeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZsx3WAAKCRAbX0TJAJUV
 VmLcD/4gypKM5C1JYdc14QZe0uLHbSTUjGzO9mE2vNqryh2TmtOoJpNFrDpIXk4ZprdBOC1EcSx
 amg41MF+/CGrVucipzlsYtdej3+2NL32LUse9TFbfzQbFizbBD697DaB4ceqCEJ+c6EDnElIQ9L
 HGD1z2PIrzkT/+JZz9mM9qFei07TVk4Hgk8DZoDF4vtWA92H6lZyTjz8Nb16YNm3Hju3bZQEXqy
 o4BHJhwSgCJ6WEcr+XoVF7fy+QEtodZnUmvhf5i2Mfq0nU3zwdL7MsYRZrn+gOEekVHD8048FKb
 oAAHwJFd3zCA1nm/1FJ6WYEvmkkxCp5yi4ORLR9N/LeHM7644A+30laT4DYs0A3ZqPZNmxByekj
 zvsIVAhI60j0pdfAAUOC8wJx0xR6/8BtOXOOeap1KTWeOTqSvc/GR+WWrn3Z9UQT9DWa3VLhADt
 3tXz0c4rMnJpHlPaB3cXCwIrNPoTAKFcfiCTiJeHTCnj5MMfGiv6IB/ppVr07NIbAhR5aLnTubb
 LyhU4nZYzdzhgLFfaRUxn312W5Oc11JCMrcQtov6DUyYE0Mb/apZLSG41XGcCbViUd9nIKi7U4q
 yQZWuYP9UcuQ2MYT2s1x3C+Il90OZLu6dnc2i6T/9qr5bQYMWzLynupUS6aeIq4gSDUEe3AScIR
 nUhV58TNj/ex0BQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add an eDP panel entry for BOE NE140WUM-N6G.

Due to lack of documentation, use the delay_200_500_e80 timings like
some other BOE entries for now.

The raw edid of the panel is:

00 ff ff ff ff ff ff 00 09 e5 66 0b 00 00 00 00
1a 20 01 04 a5 1e 13 78 07 01 5f a7 54 4c 9b 24
11 51 56 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 9c 3e 80 c8 70 b0 3c 40 30 20
36 00 2e bc 10 00 00 1a 16 32 80 c8 70 b0 3c 40
30 20 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 1e
3c 4c 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 45 31 34 30 57 55 4d 2d 4e 36 47 0a 00 dc

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Added raw EDID to commit message, as per Doug's reguest
- Picked up Doug's R-b tag
- Link to v1: https://lore.kernel.org/r/20240823-drm-panel-edp-add-boe-ne140wum-n6g-v1-1-7bdd3c003514@linaro.org
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 7183df267777..f6102ceaf0a7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1911,6 +1911,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80, "NV122WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140WUM-N6G"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),

---
base-commit: 6a7917c89f219f09b1d88d09f376000914a52763
change-id: 20240823-drm-panel-edp-add-boe-ne140wum-n6g-e5ff6458a9da

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



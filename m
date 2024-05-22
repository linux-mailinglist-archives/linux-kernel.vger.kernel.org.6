Return-Path: <linux-kernel+bounces-186764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9438CC8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5402D1F23B18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236828120C;
	Wed, 22 May 2024 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9+HAIlw"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AB23CB
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415626; cv=none; b=u7elO1Njfd/yDT6Nm+udXXAzKdc3Vk6wZ1R2wXub+NpxeWROQRUXdiy3fod71mEblA+MkcR2apJAlHIV3ZrrhgO/GT9ptp4V/Q3S6paEAjXzruo8mkW+4S6d/kw8H2tOsjJM9+Kl3gnfi9vrvZpLxe3/oHMadA/y/JJXhNxet9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415626; c=relaxed/simple;
	bh=P3nfzAeDzHWCF/hR3Be4Vs0HK32RB+1TM1u0f2LLKPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R8bEazU/27BtIaNkeV4ez0tLa4/M3731AwAj8UuqCPxi2VlQZXUQJnwZMc5haqgbVsEyGs5oKTRIus9sjEV45UYUsZKwlAx3VrBtl8u4vBvMtoEkoHZX+UXvq20X57vQ7zU980/3jOi1DCRltM1FS0o+FenIEnqjXgkR5LMlVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9+HAIlw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e45c0a8360so60965441fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716415622; x=1717020422; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvx6yeinoVDUi5Zfkw33aV+5YjT78WJ1rv7O0iicX/w=;
        b=I9+HAIlw9pEnXo5t4kRROo3E1BJMnvrCDNps9bOMlBXmp/GRPgBToOEpGYt7n0aCKT
         znSHysLcJoDif5uCbJ3UaF1VwD1gO7DgJtvlMkULEHfjC1vclQS5GcukHaq5CEw3GQin
         h3C4FBsTfDFZFR0WOzhsbNn5QhlMoB5wJDrK7q+D8O3hy9BXUR5TquYDV8Hmni4bJiw4
         hrKZq95fGoOdOh27Yio5Ju/2uXe+vfG2f6ynUm8U+Nh6+5tjdsNebdEHcA2ggPq1/eeF
         Da8AyG4dmA5ZsaPzFKFUMjEKBuZ92Zjlep3yFyUzZURe/lsVbUP4feBbp86WPHWESO4G
         6dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716415622; x=1717020422;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kvx6yeinoVDUi5Zfkw33aV+5YjT78WJ1rv7O0iicX/w=;
        b=Ggqo7PycRyTvvyzU3vEZk8174hOg4rQ/mfjGLZ7plQUhPF9/L5xQcgaHl1aOmmFwkn
         DkGSo+94wolexwR7gscLn5d5oBhBjsTY+KFMM2EDakTfIeWlNOotLV7aKLnbS26gCyAU
         cOspeSMOweSkbnq5q17XO+CTSgQrIH8S1wz9AFBcAcTcCMeIqwljMilKSULSzeT17r4t
         SxzuutPx/cprdB+noOP40MfZT8bVfAZpht4+e7mAnjwdKssaBNkx3xEn3qQQZ/qwON8p
         vozpUvjPQXhDVACyPPoBnFgWRIP5yLo0BuP6zN3v4ZcpLaRgoCMwBg3Inj7VnzkUODLY
         I3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJEJZlfAFPFMu4PE/otkciObgwWx/FtDHKor4LtcMyGy7xwI6SaI5OekVhF3pBF1o5YP7re/YEgvGdn/FmhW6mNJ/imSwOr0UpmCvB
X-Gm-Message-State: AOJu0Ywn+fEkeSXJJN/YMXpEIxhkj45ROQ/KITx/76IZlwsV41V6cjmW
	5UkapyXjAvyoH/FdblQOjeFoov0m2m3fXHI4bk/xWmDmEaXu2kD4/PJoHQ3WUdU=
X-Google-Smtp-Source: AGHT+IHvvy96Pg+GUU/MU5q+kBLk9kzzZb38y4KNjSyfaRuJK/MxIVMkE4HTw90jn1n1wg6XsU8azw==
X-Received: by 2002:a2e:a444:0:b0:2e5:2c7e:257 with SMTP id 38308e7fff4ca-2e94949dfa2mr20306221fa.30.1716415622393;
        Wed, 22 May 2024 15:07:02 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95289b4fdsm295021fa.29.2024.05.22.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 15:07:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 23 May 2024 01:07:00 +0300
Subject: [PATCH RFC] drm/panel-edp: add fat warning against adding new
 panel compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-edp-panel-drop-v1-1-045d62511d09@linaro.org>
X-B4-Tracking: v=1; b=H4sIAINsTmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNj3dSUAt2CxLzUHN2UovwCXQODxEQjY8sk42SzJCWgpoKi1LTMCrC
 B0UpBbs5KsbW1AGgtl7RlAAAA
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=P3nfzAeDzHWCF/hR3Be4Vs0HK32RB+1TM1u0f2LLKPY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5pfTouUqvqtluq5hwJiZh++eFaho04xvyOfc84Jx5Liz
 DrGidadjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZhI8g8Ohn6dWValqa4re1j8
 LjjfWDWP95XCSolzv3rCNb2XLhP/56J7UfVNnMTMD0xrHJIEGveo/6xsyosOm16eZOvUr+krm5P
 sHlNjUOZj48JUIXxtwatvCiGHNe6c+H1xVvvVWYYv/1xeoDfXxS9V7FeEq07ipUrfj1PjTghl6e
 Q8Z+bQq7e0PXVYdvXrqPslUryPJWfY8Qr09iRXWomxc/HE7GLb/bPnex/jU73oiTVb2i+4a/ueE
 RY0/D5frPFFnbjI/0cBVUvyTBRUo3+bLI90qHp+49uKM2d/5y1Sm5ArOPF+tZjx2y2O7513bTZ5
 41Pt+mSDzAS5jLS1Sz/r+lSFaO58VrjoVuz942qBPTIA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add a fat warning against adding new panel compatibles to the panel-edp
driver. All new users of the eDP panels are supposed to use the generic
"edp-panel" compatible device on the AUX bus. The remaining compatibles
are either used by the existing DT or were used previously and are
retained for backwards compatibility.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
The following compatibles were never used by the devices supported by
the upstream kernel and are a subject to possible removal:

- auo,b133han05
- auo,b140han06
- ivo,m133nwf4-r0
- lg,lp097qx1-spa1
- lg,lp129qe
- samsung,lsn122dl01-c01
- samsung,ltn140at29-301
- sharp,ld-d5116z01b
- sharp,lq140m1jw46
- starry,kr122ea0sra

I'm considering dropping them, unless there is a good reason not to do
so.
---
 drivers/gpu/drm/panel/panel-edp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 6db277efcbb7..95b25ec67168 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1776,7 +1776,23 @@ static const struct of_device_id platform_of_match[] = {
 	{
 		/* Must be first */
 		.compatible = "edp-panel",
-	}, {
+	},
+	/*
+	 * Do not add panels to the list below unless they cannot be handled by
+	 * the generic edp-panel compatible.
+	 *
+	 * The only two valid reasons are:
+	 * - because of the panel issues (e.g. broken EDID or broken
+	 *   identification),
+	 * - because the platform which uses the panel didn't wire up the AUX
+	 *   bus properly.
+	 *
+	 * In all other cases the platform should use the aux-bus and declare
+	 * the panel using the 'edp-panel' compatible as a device on the AUX
+	 * bus. The lack of the aux-bus support is not a valid case. Platforms
+	 * are urged to be converted to declaring panels in a proper way.
+	 */
+	{
 		.compatible = "auo,b101ean01",
 		.data = &auo_b101ean01,
 	}, {

---
base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
change-id: 20240523-edp-panel-drop-00aa239b3c6b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



Return-Path: <linux-kernel+bounces-198441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC418D7839
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C651F212C7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 21:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8667604F;
	Sun,  2 Jun 2024 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qyss32Nr"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3277F30
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717362583; cv=none; b=XUZ9MOsx0OUo2CFr+3hx7zu5SWdQTwFCW92pzkNlefPUPhcLlFZbitlLIEi4A3Vn1hIaohcCWzTx98PJFo7MwA8BKbP4YpkjiVnNFCL2OZsH56pMQHwOAI2/gAnBBwvOHEGyFuVeUlm5EZ0w5XfU+W6wD1Fh1KLTXvzn0MG0Hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717362583; c=relaxed/simple;
	bh=7DAxBHQdvUhwzcu/mlB9yDJLwTKgV4MNhifYDFhAiuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t9Dq5U9E0r2fHCLwYTn9JRfx/fYzf7mTBO4+ZnETzpvR926GfIySA1ye1Zhf9x0oAuWE0cSBNEEeX77FxUdf2G0sbiqdePjA3P1A8qVSyTKeyKLAfQBFRLf1SXJ7A2ByOZWXNwgwE7loxvXnBHePyARwCO1yMtFdJZYltc1A3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qyss32Nr; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so49390671fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717362580; x=1717967380; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbcsMNuzsZu0fPGAgo4y6/M6CDGgS6RMAJuTJO+Uaio=;
        b=Qyss32NrfA0QcjuiVn2DJD9dZJhcqG6k9HtC6W/2vxA+N+ulI+eipHEVVBaOMS5G3G
         ONa4qJ7mNYPADHyTpZGbGM1zMZCm4i909vULuTaExpNYtZlgkEXjPGxteMYOIO8hZDAM
         PWO7q/9imgX29ej5iHNl3ryhEr6KTgvaKZ5CRsiJY1xm8Yn5jkBzF6YjMUps9YXZush+
         SRhfIRQtDW0FdceoTr/o+uF/t3mPxl0hFTxTsbVth3mnZPa4bAQZd22zqGWyWD2qQxDw
         89g4OoHOgCV7dYG4N/OXC3Cm5Vw36QG/W1SCT4cJ8RLZqMel9lyvf2iPmh5XZbxapRb1
         HHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717362580; x=1717967380;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbcsMNuzsZu0fPGAgo4y6/M6CDGgS6RMAJuTJO+Uaio=;
        b=uRZ8OU5RnsO2F70jABzZX/N4d1pa4TItxI5Piqhqo2it0fIT0pVLT3pIEtLAEPPUkY
         MAJNoLa4c19mWW9mqELB0oIao/m/HeMIWqXoWJvkVdqjnJoIUXQOaZIcGWtf0WVeAqLO
         GvUFkiESa7Eieaqpr9smdRPA4XUsTWR6whYpDATKRSNZsylw8AqNZHt2BWNAOw55gGbb
         3IJhwOZ0NIsdb7mIex+oqmsYmYafPg5zEGb85YxfSk8d4LaPY0c09rA6zr1AcExIpYA5
         hs0t1Bnr9o/OmZiQpMTmKLJtK56NVahuDfNJ147N//UbNE5UNYapfKJxIO85e5kWlKHy
         rZtA==
X-Forwarded-Encrypted: i=1; AJvYcCVGI9zpNGeudCN0UlFveg0AH6QB1bd2oVX/FC6jE0oQ3d52EDnVzmoFmitAJBDfTVnrR7G5R1xIonlCHhPZ1SGB5ubbjeS93d+0OC83
X-Gm-Message-State: AOJu0YxpxWycbo5XOPoBhXrCHI2pz4RMZhg1pwhk0uX4vh+ogkHVq2J+
	7xSIolDOCSg/jZdVC53fG00vq+giIy3OeVCY9YSjUV93OKMz5SVs90QoJZuNOChum5z+69TKJfN
	C
X-Google-Smtp-Source: AGHT+IE7EQWW3EbvWFcRw7XHd5Cm+5yE3LtKuGpz1Kp62Y+IoawOLHJwq/uJffevkdQ3duYJV8SH3g==
X-Received: by 2002:a2e:9ccb:0:b0:2e7:174b:8c1c with SMTP id 38308e7fff4ca-2ea951e4be1mr54776971fa.38.1717362579997;
        Sun, 02 Jun 2024 14:09:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc9a92sm10211861fa.89.2024.06.02.14.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 14:09:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 03 Jun 2024 00:09:39 +0300
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: enable DRM_SII902X and
 DRM_DISPLAY_CONNECTOR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-imx-sii902x-defconfig-v2-1-a39e442011ae@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJLfXGYC/4WNQQqDMBBFryKz7pRklKhd9R7FhcZEB9pEkiIpk
 rs39QJdvgf//QOiCWwi3KoDgtk5sncF6FKBXke3GOS5MJCgRihByK+EkbkXlHA2VntnecFWida
 qqatFr6Bst2Asp7P7GAqvHN8+fM6bXf7sv+IuUWIrR6XrjqaG6P5kNwZ/9WGBIef8BSoQ50q7A
 AAA
To: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7DAxBHQdvUhwzcu/mlB9yDJLwTKgV4MNhifYDFhAiuc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXN+T7+/5uOCIlx4I4xNfUXd86lC7UbPUd3BzZ
 LcBJsrY7QuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlzfkwAKCRCLPIo+Aiko
 1W0AB/sGxY+aD/nOe/ndbSVvdwFNIL8vsdvYRA9sPn+zkU/6rkxFZ18VdQe/ffCwKgWvKv8RyH/
 4hflSjuIk/fwHe02xQTXZ451EyHGrzNOWiFiI1UWdU3Isbyey10Mamuvw9JV8asA/f55ftbgpSH
 VXwgs+WrAtFn/Qh3y21JuBqETWLQ40EMo1ZDmskVbRWPMxYnFYLvCi5W3LkmHYsrXjUBEDbIVr0
 KIlofvZK2dQ0OXLvbYpGUVOxIxPphcjB7t+Yc8OaTKL9smkRjmiSksIf96v8TpErJ3ogGwRedhW
 R8B5layHsTCZSyrlvpTs53WPJvW0IQTLqnyC8N2E8dLgnDUr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable the LVDS-to-HDMI bridge and the HDMI display connector drivers
used on the iMX53 QSB and QSRB boards with the HDMI mezzanine.

Cc: Chris Healy <cphealy@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Fix subject and commit message (Fabio)
- Link to v1: https://lore.kernel.org/r/20240602-imx-sii902x-defconfig-v1-1-71a6c382b422@linaro.org
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cf2480dce285..b6a2d0689cb6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -282,6 +282,8 @@ CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
+CONFIG_DRM_DISPLAY_CONNECTOR=y
+CONFIG_DRM_SII902X=y
 CONFIG_DRM_TI_TFP410=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y

---
base-commit: 0e1980c40b6edfa68b6acf926bab22448a6e40c9
change-id: 20240602-imx-sii902x-defconfig-7607f6b83096

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



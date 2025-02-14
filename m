Return-Path: <linux-kernel+bounces-515149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D346AA360D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBAF3AB4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0CF266B66;
	Fri, 14 Feb 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P00/juKX"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F2265CA9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545036; cv=none; b=hroo3JWeduvHs3GuQmTg+ZhcXUigpeDufcPiNZUaMWl6jbkrljSXnD1T6ot5AAt/oxXmCB/eRazcGfvsfJRS5CNOexjOk5o1FbhksFyRNftMThaeqzIwBwcn5WYo4E74ny0pN7OE5sJ7YkPRhfMx/7NlYS0TSMYzdrl3iD4Q4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545036; c=relaxed/simple;
	bh=z2Q0IRBbFBY5UO2dBzF27h1+kSCMj9v5w1Ed/8luhF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h+LnN+v9TPREvCnVTg+4u53k215AgAPzC0tgaf23IuikZtOFBrAAO94dc4xRWJsQWc/W0IkMd3nV+ITMuMURG+FiBr0bKaKyeYIab6SIo36wOMxPcxtrERltHxrLfAcqyeqqxEimhvj35K0kRtofsz1rRuIEDDnyNDG+yxPLFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P00/juKX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307c13298eeso21021441fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739545032; x=1740149832; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQae58/7ZgRGmpkImz3Fvmxvfg6932EKFfHBFpHyTDE=;
        b=P00/juKXd8ZkVsoozXGeBlnuUTlSzhS114FHHQMLRTYltvnUTz5K0rM3GJoe1OSquj
         1zhj1kEgwnoEmqhE9IV8yVCFTf/i/uNL3wgP9LsFzAvVDN2OXBbUUby8vcvkUYmfsVMK
         SOKMnPCvqPd0PNgz+NW+VTQr0RzwgMlX6DpBFc1/KKoLY8yfZKICioNCV7OZfCuqLKzk
         hVcqPuGF8QBw/I3aSX1VNS+XHYEVY46k60arf4NkQp7fFm2Svq5Sn0JbGquAKdIvG4fY
         SElPYHkCQae2MoodE7KkjsrN/kEM1hXfyOonAgf7xtyIouh4C//vXrQTE6X97A9mA36f
         Vypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545032; x=1740149832;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQae58/7ZgRGmpkImz3Fvmxvfg6932EKFfHBFpHyTDE=;
        b=DQVj4EqOn4DSL8R7ECLrofRAgN+28qchPofpzTcy5UHu/kFFnzQzbuRnbHFl0Re2vW
         WOPHvE5kD08c9jXvXQ64JXxUZJY2Ss2LV/lRsKuHHguDpDCxF9UjpBuUNpGUGwtmB49q
         VZR+od7eQv9XwDzVrYuEe/61SnIiaCgQrNJuzU5PJZKE5EOtCsROtKP80K7+785BFGGi
         dRZe5c9xQ3QbeJV9ybFP57WZPjQqY3iiLsXWG4MAhwgAmipiPM3CJjnYhNPDQCaAzhzw
         qYRQYfx0tYfABeKzkM0PyTfDAsJUKdfTbutKt/K58+13PMUHYTBYPwMmSc7r1pCM+dB8
         kamQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5+XWXpkHClL5i4WiqIsryHvOEYCZh16FKqP7Q8BB4B1hqNB9nTlBvpSEfTTi1Efe6gIchqCWxIag6Nl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnayMgPkpgAT7KmmI9EZL8ryIG25Jd5k5HL0LOiUWp1M8WAKs
	WXpiLs8u4qlV4n0pcycb/0CwdmlVCyZ0zNcgsfdn+AZHJZnqqHJPJBeJ4tzk66aYs8ntE+WagNQ
	tMhY=
X-Gm-Gg: ASbGnctOMsRkNEZV50tKwfAFEoE2YBCmhW/j/Gg9Z6wpuHb8aR+i7muxVemincIDmW0
	MxSxeraQteHbbqnU7RIxPzPCxbJ2HKn8JLMaN4sjAnLXx2yiocmSI/HdmdUEOkmAC6SAYsj9Hdr
	z5iWz4esgXItbRkzvZv92U4Lxq0d5FXjFkJ3nsmmKul9H+FxxisOqoTgxgimR296GaKMMNzIRYm
	NQVkzdiZaoPVsz4coHMg6zTIQK+7oNiHlO+26/0wpnXXJlsaaNWogwyisJK99XYGHqQ5+xijx7n
	BeeCw3q9bk1qaYD05SfrzoU=
X-Google-Smtp-Source: AGHT+IEGXwyfxyoObKs7o/lt7dV9tEhqiBuBL0KpjS6e5z7omskUER6BZ1nOd81V/L7kuC4TLU7acA==
X-Received: by 2002:a2e:a907:0:b0:308:e54d:61aa with SMTP id 38308e7fff4ca-3090f353cd9mr34630161fa.2.1739545032292;
        Fri, 14 Feb 2025 06:57:12 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30921447bdcsm2129911fa.35.2025.02.14.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:57:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 14 Feb 2025 16:57:11 +0200
Subject: [PATCH] arm64: defconfig: enable DRM_DISPLAY_CONNECTOR as a module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-arm64-display-connector-v1-1-306bca76316e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMZZr2cC/x3MSwqFMAxA0a1Ixi9gix/qVuQNSowa0FZSEUXcu
 8XhGdx7Q2IVTtAVNygfkiSGDPMrgGYfJkYZssGWti6tqdDr2lQ4SNoWfyHFEJj2qEiGTN240bX
 OQa435VHO79z/n+cFzY/Bc2kAAAA=
X-Change-ID: 20250214-arm64-display-connector-c1c1569f9799
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=z2Q0IRBbFBY5UO2dBzF27h1+kSCMj9v5w1Ed/8luhF0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnr1nHdqBlbiOcs9Fq6bYoQ+iyjmFYH6QKSuxfO
 /WMhlNqTjWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ69ZxwAKCRCLPIo+Aiko
 1dUzB/91jaiBLtA2Q8zCpQ3QjdZ+QQiJ+ot6o6nCYuWdrktym6dcD4EKzYZwUmJ3Vh2WGNTsGMV
 h6BwL6PgWizo3efy5boVtu7ecr80HjH/1Ug+saZSI/7ZkA3hzOUEooQUsUtg7sdhN18RXhzykXh
 c6rgBzQhOnB4cq3zCf7rxGkwZCDwEn/6C2hI/luw86qLkxCNCrzcxGqO5R8oQV89DnUglP8akpK
 BSxLXt7esBRbJAR2NhjPmslaZK9COmB7nGaw/L2Z/5XD8U8NKU6uQtX4+hLHIGWvloM/9TdDO8/
 3GuXHoOg15yu3UUAupDJYCQxzSPgQoadi6B/nWgl+EGv7EQ3
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The display connector family of bridges is used on a plenty of ARM64
platforms (including, but not being limited to several Qualcomm Robotics
and Dragonboard platforms). It doesn't make sense for the DRM drivers to
select the driver, so select it via the defconfig.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb7da44155999b59aff95966f4cdc9107f2af46a..dfcc754962f7a40377d1f8e0f16983af5ace28f4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -911,6 +911,7 @@ CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
+CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_FSL_LDB=m
 CONFIG_DRM_ITE_IT6263=m
 CONFIG_DRM_LONTIUM_LT8912B=m

---
base-commit: ed58d103e6da15a442ff87567898768dc3a66987
change-id: 20250214-arm64-display-connector-c1c1569f9799

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



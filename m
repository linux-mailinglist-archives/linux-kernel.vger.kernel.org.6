Return-Path: <linux-kernel+bounces-283496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E3B94F5A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0FE2832DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7433187FE9;
	Mon, 12 Aug 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvWnbvwJ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFC18756D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482695; cv=none; b=XxdHwRK7YK2HLINcj9yY2QUkwNoSSioReJ97F1GoSEF3HbmijpoVUspgkv+4KpTMyqc92DpxqQtPigy2ceBM66YI7eP9V2sZnnPQGlq/wY14fsAWypNKOhVE+yNXVFiGJeqxycyT5MmvWhxInwbfmrfJPD4kD3yv5GEcuoKmPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482695; c=relaxed/simple;
	bh=P1zWlqma/MYjqN1eJ3463pbdO62vV2dvVfq2ZsWRxOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EI5Dwf5ieNFDXDiwh5sstdwIGgnG3hIjVWyEnCSL6LtKb8xezLRZl1xPApeZ4pEaYizU1JtPdrHZ+5h9E76+xgaiz2WpuYn4rso4JASaaKJEFm1DYYt2Wk8wNEOn1Qg4f1Stko6CLSOOGExqbdlSUJIpauUtf74cn9irL2SmLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvWnbvwJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc5296e214so43694985ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723482693; x=1724087493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JLVMznJSLt/JlEkp0OXnrYKaDgBuNrpLyNsFl4Y6DAA=;
        b=CvWnbvwJpYUD2x461V3NPgEKUfPOVjNZ41I/JvhWvA6n9bJaMcbyUhC0AbysH4ho3k
         hikJK3R4YpRO1vgxs5dcgnwUnQDyqNbHp3Z9tF1TfQVZxJ4WJPzkDsBBTtauoP/GhwBO
         c5IJL2xHKpivNrIJj5V2rBmBoBFnayv/+HOuvB5laf/iatuzH+ijmlyXLffETEL8mnZV
         9xa/H+o/4clrqeHepCW6qIg+ZN6gmgUdyj7gAiD9Zn5hzirFeJN2Ux7Xlx7qdFd2MuSw
         idvA4kMxaf41L0/b4hdSEPKmIE4wu4SUF7fyIIVxt6Jm0Bg0VMM+zDKu1CijQFFmhHbq
         U9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482693; x=1724087493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLVMznJSLt/JlEkp0OXnrYKaDgBuNrpLyNsFl4Y6DAA=;
        b=ArfnfF790v9p22oODOkjmMPWUwI43cKrYOM00VFs6jXYZ3SQECEtR+czBEumH9GMYv
         i6j2OrMTpWv4SgJc4eM3A3ogxLTKcjPF3sEW+EbcCbSS/urK4wk49E5yfcgA3Vf/DoDN
         mJsRQI+VHHIxFApMJ86W6+McbO5771RoJfWUQ0zskOXTKMzCsn4POwjLw69TGrCKOOGt
         4ksmz0sX4wCRTdFgrTJXGlHmBSg18YMRxupFl1M0B4aWSlbHn87O9wVXP/KSupT3PCy2
         Ly3EW+q+0dICVG4N+IqBp4mZQM/VSeBSKKgTKl1PP+y4nDDyqQvI0xMLhPfI6xdK2jxh
         meOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU6nsvPtm5CxgFhjTkhdoeOn0TSOi2AsvkY+7xxNhoqm/437XoMxCviqR6HICURVZ8JeUw7FKd9heu6Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWXUuKhEBdDeCLFu/HIvobCMITgwUv0m8azr2q6ctYKtO6RMC
	DJrTbi3APYyJJOXEA8GX32HcXX40+jwOmBKRzN7wQN3QZ0Zb8IShTII3e35G
X-Google-Smtp-Source: AGHT+IELEK6p5g611Ie65ft5OPx5Mcq5RXC0yVwYjMfCBbR99xO2ydlSWcoM5PsEkzp0Bznrw0ZmbQ==
X-Received: by 2002:a17:902:ec86:b0:1fb:779e:4fd0 with SMTP id d9443c01a7336-201ca1a246dmr9679275ad.24.1723482692871;
        Mon, 12 Aug 2024 10:11:32 -0700 (PDT)
Received: from embed-PC.. ([122.177.118.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb3a270sm40264765ad.279.2024.08.12.10.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:11:32 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	dri-devel@lists.freedesktop.org,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: ili9341: Add comments for ILI9341 register
Date: Mon, 12 Aug 2024 22:40:19 +0530
Message-Id: <20240812171019.561321-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TODO : Add missing comments for ILI9341 register definition.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 775d5d5e828c..cba6a6952568 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -121,19 +121,19 @@ struct ili9341_config {
 	const struct drm_display_mode mode;
 	/* ca: TODO: need comments for this register */
 	u8 ca[ILI9341_CA_LEN];
-	/* power_b: TODO: need comments for this register */
+	/* power_b: Power control B (CFh) */
 	u8 power_b[ILI9341_POWER_B_LEN];
-	/* power_seq: TODO: need comments for this register */
+	/* pdtcaower_seq: Power on sequence control (EDh) */
 	u8 power_seq[ILI9341_POWER_SEQ_LEN];
-	/* dtca: TODO: need comments for this register */
+	/* dtca: Driver timing control A (E8h) */
 	u8 dtca[ILI9341_DTCA_LEN];
-	/* dtcb: TODO: need comments for this register */
+	/* dtcb: Driver timing control B (EAh) */
 	u8 dtcb[ILI9341_DTCB_LEN];
-	/* power_a: TODO: need comments for this register */
+	/* power_a: Power control A (CBh) */
 	u8 power_a[ILI9341_POWER_A_LEN];
 	/* frc: Frame Rate Control (In Normal Mode/Full Colors) (B1h) */
 	u8 frc[ILI9341_FRC_LEN];
-	/* prc: TODO: need comments for this register */
+	/* prc: Pump ratio control (F7h) */
 	u8 prc;
 	/* dfc_1: B6h DISCTRL (Display Function Control) */
 	u8 dfc_1[ILI9341_DFC_1_LEN];
@@ -147,7 +147,7 @@ struct ili9341_config {
 	u8 vcom_2;
 	/* address_mode: Memory Access Control (36h) */
 	u8 address_mode;
-	/* g3amma_en: TODO: need comments for this register */
+	/* g3amma_en: Enable 3G (F2h) */
 	u8 g3amma_en;
 	/* rgb_interface: RGB Interface Signal Control (B0h) */
 	u8 rgb_interface;
--
2.34.1



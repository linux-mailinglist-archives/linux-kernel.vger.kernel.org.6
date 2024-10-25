Return-Path: <linux-kernel+bounces-382219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3579B0B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211AB1F2104B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3932321441B;
	Fri, 25 Oct 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="C7l/kThH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5C20F3EC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876567; cv=none; b=IqJlLAcJe2LaNCLwolVTMShTVoynSyEc7AbG4la7dhJXTEFTg63Bq/m5XDzqdqErAtSZ4I/BrHWISS1/5WCJ1fJ5gz1F9vj5csfyUlyoL5e6FhGWbIeKRVMWs6Z9lk3e8r8dVHiqqgPxHa4NOu7JDVPw43JOT/b3pUhoZrTZCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876567; c=relaxed/simple;
	bh=MuA1+gA2LA+0RarF591IDfJ3YMiX2FefV1latoO+A60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ox5YBB/72N2gRN7UD1e8SVKmh/zMHyJZJ+Iw7+m0tIkJ+qiiTQuYwnFD4UL0THF2602u4UKcyvyxQVlf9LTMUYd8UkeR3FSVv01tFOBil2Mg4ZA6og9sJt+WkbeYXUmN5BfE2Q23R2o6zEkEZQGZlva0VYnB/GgUPcyZHop0QmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=C7l/kThH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so29131795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876563; x=1730481363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2GjkUl3p/O3LyFYgokUMRNrG9yDODmMulXK3H2wmqc=;
        b=C7l/kThHiq5oCkdSq6sFBcBb/2dTOnmqxnqv0jUNWcces94sjUeY43oRGZn8D7iybt
         r24KGkqiAJseIsi747612l9rLGoOM1E7TXYUMSb36+7MsmO5U1JiSfwLERruBr8VW6yy
         TDPtsJ3eSb2U+6M1CroJgWNSA5CS9VLUB2l0nabiWdf/Kudh/nkJm7EX6ZJ18mcNmARU
         UyOCpx5Uvf6zhmjNSkT5ViQ4iuP4xOEIAqoYpvEdGNpUf2vTc/gHX8cyuWPuqGSWKkRI
         NSS0yEGENiZHu6G71eZ/UMyLf3iQN7VwrY0Vb0Wc0acKcWx98K3N0PXQeDuRusH/nK8A
         wG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876563; x=1730481363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2GjkUl3p/O3LyFYgokUMRNrG9yDODmMulXK3H2wmqc=;
        b=fNbk00ZrjUD/fpnMdi75gOIPZw6CUMHBytgteAnN9xgH3sj/UwfjGC0yjWf/8tgrLb
         efZEoPCqn5llA8O6OTGQGiwDuqX/SxKSCbHC3XX4YRPufImSdGZMA2+ZvNSXociGmN/s
         OuMUDxiwN9uYkLay5zd0ZuBczDGYoZ+d+oIQYrbPvjvrcAw7kEyx0X54VemWidPSQrXH
         bg1PUYFFIZfRAuFLplpfndMnsIdtsYZyoDNQ8ybnL6rTsAYd6JLHKyt++JOmRBreWJcB
         kUrAEyWC93VmyD+krogPxtmqzlekk1wprWXRcytACoaA+Sl2DZVR41Psb0cBuKxMLlzd
         lVZg==
X-Forwarded-Encrypted: i=1; AJvYcCUHipDCrZgTXrdg1FO8wJwG+t+gppsX3Jea2fBePqwoRPzY2XWpK0oqiItwDaAXCZDWIYnG4PZsHljQ1dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPHVx0v3nx5YPueWlTlaOmfVlKY2dWhFUVz7sIq4HV7Lzd77s
	nMuucr53+lZaaqIoECN7RVS/1nEdrS0tmVl+09Fn44MOACSxgRgwi3pgDPR84wU=
X-Google-Smtp-Source: AGHT+IHS33FJ99QvsSnwlHEO0RVmS3g3mQFRGvOhUZla0C49szl9I45Vo/iib3shrh2XvYSiEjJZJQ==
X-Received: by 2002:a05:600c:314a:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-431841eb704mr109059015e9.7.1729876562817;
        Fri, 25 Oct 2024 10:16:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:02 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:33 +0100
Subject: [PATCH v2 02/36] drm/vc4: Fix reading of frame count on GEN5 / Pi4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-2-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
In-Reply-To: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

The frame count values moved within registers DISPSTAT1 and
DISPSTAT2 with GEN5, so update the accessor function to
accommodate that.

Fixes: b51cd7ad143d ("drm/vc4: hvs: Fix frame count register readout")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hvs.c  | 45 +++++++++++++++++++++++++++++++-----------
 drivers/gpu/drm/vc4/vc4_regs.h |  6 ++++++
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 1edf6e3fa7e6..f8edb0791091 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -272,19 +272,42 @@ u8 vc4_hvs_get_fifo_frame_count(struct vc4_hvs *hvs, unsigned int fifo)
 	if (!drm_dev_enter(drm, &idx))
 		return 0;
 
-	switch (fifo) {
-	case 0:
-		field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT1),
-				      SCALER_DISPSTAT1_FRCNT0);
-		break;
-	case 1:
-		field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT1),
-				      SCALER_DISPSTAT1_FRCNT1);
+	switch (vc4->gen) {
+	case VC4_GEN_5:
+		switch (fifo) {
+		case 0:
+			field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT1),
+					      SCALER5_DISPSTAT1_FRCNT0);
+			break;
+		case 1:
+			field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT1),
+					      SCALER5_DISPSTAT1_FRCNT1);
+			break;
+		case 2:
+			field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT2),
+					      SCALER5_DISPSTAT2_FRCNT2);
+			break;
+		}
 		break;
-	case 2:
-		field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT2),
-				      SCALER_DISPSTAT2_FRCNT2);
+	case VC4_GEN_4:
+		switch (fifo) {
+		case 0:
+			field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT1),
+					      SCALER_DISPSTAT1_FRCNT0);
+			break;
+		case 1:
+			field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT1),
+					      SCALER_DISPSTAT1_FRCNT1);
+			break;
+		case 2:
+			field = VC4_GET_FIELD(HVS_READ(SCALER_DISPSTAT2),
+					      SCALER_DISPSTAT2_FRCNT2);
+			break;
+		}
 		break;
+	default:
+		drm_err(drm, "Unknown VC4 generation: %d", vc4->gen);
+		return 0;
 	}
 
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index c55dec383929..341a75cf92e5 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -418,6 +418,10 @@
 # define SCALER_DISPSTAT1_FRCNT0_SHIFT		18
 # define SCALER_DISPSTAT1_FRCNT1_MASK		VC4_MASK(17, 12)
 # define SCALER_DISPSTAT1_FRCNT1_SHIFT		12
+# define SCALER5_DISPSTAT1_FRCNT0_MASK		VC4_MASK(25, 20)
+# define SCALER5_DISPSTAT1_FRCNT0_SHIFT		20
+# define SCALER5_DISPSTAT1_FRCNT1_MASK		VC4_MASK(19, 14)
+# define SCALER5_DISPSTAT1_FRCNT1_SHIFT		14
 
 #define SCALER_DISPSTATX(x)			(SCALER_DISPSTAT0 +        \
 						 (x) * (SCALER_DISPSTAT1 - \
@@ -436,6 +440,8 @@
 #define SCALER_DISPSTAT2                        0x00000068
 # define SCALER_DISPSTAT2_FRCNT2_MASK		VC4_MASK(17, 12)
 # define SCALER_DISPSTAT2_FRCNT2_SHIFT		12
+# define SCALER5_DISPSTAT2_FRCNT2_MASK		VC4_MASK(19, 14)
+# define SCALER5_DISPSTAT2_FRCNT2_SHIFT		14
 
 #define SCALER_DISPBASE2                        0x0000006c
 #define SCALER_DISPALPHA2                       0x00000070

-- 
2.34.1



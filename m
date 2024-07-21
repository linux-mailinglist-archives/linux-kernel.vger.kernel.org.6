Return-Path: <linux-kernel+bounces-258138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB9938444
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEFB1C20A92
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C067BDDBE;
	Sun, 21 Jul 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="iJeGCl6o"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10479D515
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721556298; cv=none; b=DCMQOBVvrnVRT3eHB+pqMPELnfNKFWhjmUjDALXDRld7k8NsgHd4+ZBru8poCRTxbLvyy8xTWmrc2PZJUnzjnSjz1s/5gug48r5YHwCwJRNciBVc8sPQuR88ZJkniQ7dO3Uc78XUnwhfjtyRkfH9PLihWrjdBv225OM2TBfQdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721556298; c=relaxed/simple;
	bh=AoCsoD8DUym+nMAlOnigc2m4bVBXtaJv+XJoWyZQYWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cLh+kp6BHpJ7aWBsuT2leVMWyNpITNuVeUM6nJobhjQNLhh+EKX/Mat49GYQ7hYrtO2su0yv/b0dV+MxQsKtTJAaiOg0vUNSDRWdLDCVCJXT3EoVSHW/MDQXDZAwc+10vxiPnWFx5I3IEug/AS8UIhrHhfonUpKWgTEoodbDLiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=iJeGCl6o; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd69e44596so11657065ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 03:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721556296; x=1722161096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4KDhT5gq5T8T7VRjwwTI9Oh7Vqbyn6hUU8M3Hurzss=;
        b=iJeGCl6oWwJ8e/LwR7bsBBrNcFPNM3oABon+NibD01VCelf8keuAU6jWtBljnOJDwA
         wlK5Dr3EnD8DJqIYcGZMUlC5kPO8wtCK1Xj6dMOBCWhsTK1YAfNGTVhdlYJ7u+drJjBU
         he4TVM/aFGXp8jnqUeopTOGVJzh2iPUnuf+9n25QKTR4zFv17HaeKF3HZYiaovnhYSIQ
         cJ2cHieaD/juSi8c/j+m+XZ+g1BzSmyVCGMrLJga/NP24nW8hduhyQKyBP22WXZwZmzC
         oWRdsfMHBJae4MycuS8PkRX25bqjWPHFuZbyE8agB0wblXcGV9mSzDWlM+xcoI7QXh2w
         cBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721556296; x=1722161096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4KDhT5gq5T8T7VRjwwTI9Oh7Vqbyn6hUU8M3Hurzss=;
        b=J0yAaNc38ty7xLp2hspEduErtv6EHVTFahhyZ1bFFnHSYl9djmJdc4o4NbpVOqaNpy
         EFMCWkLNpTONvH7Q0uGiflosGKso9mmO9P04boeRM4sIDExAAdjGjAkaS4Bpis4jsYYH
         8A7q4XDV9Wp8pVktnH7zjiIaVcf8qpAwIZL3VzeoEsnvWZICahiA0b8LGJa6wPI0Xgzf
         mtElvP/HCxFPJOba5IifnJ27Jln39PPFBGnRjR/76by1Z0Q8ZO8RBavdipzRN3G2DTkW
         KXrkjLj5iwd8ZWhAG8t04zmHXParyIfvkUcZv91UoVaWGTvj/vN3s0R//qEejuz6eoya
         22fQ==
X-Gm-Message-State: AOJu0YwIrGBn4n9Z0Dv0X4DfqH8xqlCk6XXTUkaQQbIPMXqeQPE7w/qq
	zinQ2iwl6FvJhG6tNvZOJTPVaNoGiPXS+49zgpy1CpaSeFpD8M2lJJI2AVtV1yjXSnEm86sc9Wc
	xFLXgEg==
X-Google-Smtp-Source: AGHT+IFVSboySOiEcC1bu7V7Yiv5SI5UwSYP3NV3Bf6wk2PDijqWXIEuJnfYp9OyRHsQd8nY0JpqEw==
X-Received: by 2002:a17:903:40c7:b0:1fa:97ec:3a4 with SMTP id d9443c01a7336-1fd74d16afbmr75953575ad.8.1721556295852;
        Sun, 21 Jul 2024 03:04:55 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. ([150.117.130.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31c5a6sm33911155ad.180.2024.07.21.03.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 03:04:55 -0700 (PDT)
From: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Subject: [PATCH v2] drm/panel-edp: Add 6 panels used by MT8186 Chromebooks
Date: Sun, 21 Jul 2024 18:04:49 +0800
Message-Id: <20240721100449.8280-1-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw EDIDs for each panel:

AUO
- B116XTN02.3
00 ff ff ff ff ff ff 00 06 af aa 73 00 00 00 00
00 21 01 04 95 1a 0e 78 02 6b f5 91 55 54 91 27
22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ce 1d 56 e2 50 00 1e 30 26 16
36 00 00 90 10 00 00 18 df 13 56 e2 50 00 1e 30
26 16 36 00 00 90 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 50 05 18 7d 20 20 20 00 67
- B116XAN06.1
00 ff ff ff ff ff ff 00 06 af 99 a1 00 00 00 00
00 1f 01 04 95 1a 0e 78 02 9e a5 96 59 58 96 28
1b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ce 1d 56 ea 50 00 1a 30 30 20
46 00 00 90 10 00 00 18 df 13 56 ea 50 00 1a 30
30 20 46 00 00 90 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 0c 0a 2a 7d 20 20 20 00 3a
- B116XAT04.1
00 ff ff ff ff ff ff 00 06 af b4 c4 00 00 00 00
12 22 01 04 95 1a 0e 78 02 9e a5 96 59 58 96 28
1b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ce 1d 56 ea 50 00 1a 30 30 20
46 00 00 90 10 00 00 18 df 13 56 ea 50 00 1a 30
30 20 46 00 00 90 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 0c 0a 2a 7d 20 20 20 00 e7

BOE
- NV116WHM-A4D
00 ff ff ff ff ff ff 00 09 e5 fa 0c 00 00 00 00
12 22 01 04 95 1a 0e 78 03 0b 55 9a 5f 58 95 28
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 96 1d 56 c8 50 00 26 30 30 20
36 00 00 90 10 00 00 1a b9 13 56 c8 50 00 26 30
30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 40 ff 0a 3c 7d 0f 0c 17 7d 00 00 00 00 1a

CMN
- N116BCA-EA2
00 ff ff ff ff ff ff 00 0d ae 5d 11 00 00 00 00
0f 21 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 3d ff 0d 3c 7d 0d 0a 15 7d 00 00 00 00 0f
- N116BCP-EA2
00 ff ff ff ff ff ff 00 0d ae 61 11 00 00 00 00
0f 21 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 3d ff 0d 3c 7d 0d 0a 15 7d 00 00 00 00 0b

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 Change from v1 to v2
 * Modify the description of subject
 * Add the raw EDIDs
 * Sorted according to the order
 drivers/gpu/drm/panel/panel-edp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f85a6404ba58..18a2ba2953b3 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1845,7 +1845,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa199, &delay_200_500_e50, "B116XAN06.1"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc4b4, &delay_200_500_e50, "B116XAT04.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
 
@@ -1901,6 +1904,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
@@ -1916,8 +1920,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1156, &delay_200_500_e80_d50, "Unknown"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1157, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115b, &delay_200_500_e80_d50, "N116BCN-EB1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115d, &delay_200_500_e80_d50, "N116BCA-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115e, &delay_200_500_e80_d50, "N116BCA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1160, &delay_200_500_e80_d50, "N116BCJ-EAK"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1161, &delay_200_500_e80, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142b, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142e, &delay_200_500_e80_d50, "N140BGA-EA4"),
-- 
2.34.1



Return-Path: <linux-kernel+bounces-407269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C1F9C6B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CBE1F2560A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD118BC39;
	Wed, 13 Nov 2024 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="I93hoedt"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF718BC1C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488433; cv=none; b=nlmYVEDlkMQsIfW63YigpAfZEkJabrsl+0+0gHW2XSUIXdJdd5rvVpASuqCoMY0Z7BQqzBIvbpdCzhRaIaOi9WXaiiIgIiW5Y6QBtYz/iBNQ6gRZuo3J1KhPcReRXQWbkUUv/Sxbm/cLRNMsMz42rcjKJ/dWoOAKDAiv9S8b4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488433; c=relaxed/simple;
	bh=t5UMP0YHCFAexA1KH4bG0lUWIVeAq0o91n2L9ovdl8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PheKFhhKynEx34OgiLfzayqVQa1EyHEcdZZqR8zgTyFpjooLW9kY4PT2n32TBgI8bT1HQNzoTrZJzQ/W0t1lCcPBhEgIDQKLVXksJPqu9u6c7tF2Dl5OHjFh0nMNqZTn+uThBtzEnsmmMJcg9LGru8H4dODJeq/LaghdM/S1DP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=I93hoedt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso4940082b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1731488431; x=1732093231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fvap02PjhZeDB/6aMVoZItVlwplGYl4WKDWPSr0Pzg=;
        b=I93hoedtGsyJbSQ7s4j9haZPvY6AT7KopX2FhmLOZz3ve5eB/SiCSlbTiqR7kdV5eB
         A7VhEhJ3vXpBXHy24tObgYHN1k1EzaGGbE5v81Tt1PGhpuRE2z1SdpFov6SwPxFnd3Fa
         BWO1gwSGCv6z/AVN1u9goByT1271IMk03m8LUqV7VIs5gR2c9FyzixQ/SDE3EyP9/if5
         PIYJBgmuc3m9tqh1Mx86TERvsbngjlCqkm/pEGBzM3/QkXGQnU/0FCUlUzXGS3ijNqjd
         rhva3xX68qRemHWayiVbn7ptGemktuNwwDwkmanV7MNoHKJD39Hij6GnkMku3wta37Jo
         aAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731488431; x=1732093231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Fvap02PjhZeDB/6aMVoZItVlwplGYl4WKDWPSr0Pzg=;
        b=vc521bBt7QkWFPSIHB3Ml1qDRBRZKM1AW/iKymZydO61udqjI1AsNTL25IeVsdfaoG
         QBTsx9QMZYPe+Xr24ChrAi8FrBZI14L+SJiZ4Uf8vTLndPiaNjafFCJP9eSpF7Q+02vz
         NTt7/KfkKmgm7LmJL1CaiXQ8U4+/hasTEm1OwGx3qHxsHUw6Ob3N9APgy8YA3M92MoMu
         43R9lk8BEF76EZCbQz0Y/cKKR4CXrSaZ/UKJ+7iQxr/oQnqM8foZTlcaRS5M2vpnPy3f
         V3GhFZNoUcl9/3u15YWdPbvfjsfDYzgWBHTpCwFjja2qzhzUM0W27dguvxwaWaOmp7tG
         HGjg==
X-Forwarded-Encrypted: i=1; AJvYcCV7whZ5YjJEh7IIGl5GihBmLcvw6OiryYLvxpCgIre7atA3u9yg9MRVGiWYcoe4PqHGo01Xz8TeCzgj5lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWFDAXkxDP4GwyPEts4UT6Gg8Hcr1wyzBYsyBj911RnmxCUiF
	5HP/A+oIpGibHW1joOfM07BF2hGP3Tem00V+18sk4UyVutL6ypT/JAn7bod26Xc=
X-Google-Smtp-Source: AGHT+IEKq5+fRsVy6UZozj3I1QwgDyM+oocitFdcrf6q6LPoOuN017PUnrLbnwFeBeH1HJrMRxUKvQ==
X-Received: by 2002:a05:6a00:3988:b0:71e:ed6:1cab with SMTP id d2e1a72fcca58-724133b25e5mr23901143b3a.26.1731488431163;
        Wed, 13 Nov 2024 01:00:31 -0800 (PST)
Received: from DGP100339560-10.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407991bc8sm12787200b3a.96.2024.11.13.01.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:00:30 -0800 (PST)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	thierry.reding@gmail.com,
	sam@ravnborg.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: dianders@google.com,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add KDB KD116N2130B12
Date: Wed, 13 Nov 2024 17:00:22 +0800
Message-Id: <20241113090022.332586-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the KDB KD116N2130B12, pleace the EDID here for
subsequent reference.
00 ff ff ff ff ff ff 00 2c 82 07 17 00 00 00 00
1c 21 01 04 95 1a 0e 78 0a 63 25 99 5b 5d 96 26
18 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 87 1b 56 88 50 00 0e 30 28 20
55 00 00 90 10 00 00 18 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
00 4b 44 31 31 36 4e 32 31 33 30 42 31 32 00 17

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 012dfbcb9475..5355acd52f0b 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1978,6 +1978,12 @@ static const struct panel_delay delay_200_500_e50_po2e200 = {
 	.powered_on_to_enable = 200,
 };
 
+static const struct panel_delay delay_200_150_e50 = {
+	.hpd_absent = 200,
+	.unprepare = 150,
+	.enable = 50,
+};
+
 #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
 { \
 	.ident = { \
@@ -2134,6 +2140,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1118, &delay_200_500_e50, "KD116N29-30NK-A005"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
+	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1707, &delay_200_150_e50, "KD116N2130B12"),
 
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x044f, &delay_200_500_e50, "KD116N9-30NH-F3"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "KD116N5-30NV-G7"),
-- 
2.25.1



Return-Path: <linux-kernel+bounces-254986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81336933A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF60B21A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA55481DA;
	Wed, 17 Jul 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="lx5pXg9O"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48846426
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209173; cv=none; b=mfo0vF2u2aahlhnTrKWI/Q7TppIZXyUrgV5F2lfeDVl7VHWdJT4yVApxxUtfFedQj0odCD8ZeCe4Pyz0Lt34fs7oVoe62dFc+pfXCXrCRM2w4+bLz1eUZCJwfuDflk9mZeMlTNNMAUquD/dZcdKnUSTZf7v5gz/VBC77gkx0rpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209173; c=relaxed/simple;
	bh=H1a9X7y4tEyr3CCDjfTfefdfSI+vNKa1x5oSvp/L04w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uADbTI4gPGyPDZLchigPUbDxH548o+WgX+9g0yf5GcBUyisD+XBUaYMaHnF9L3pVeZDQS2KaWrPnGfLpbJLzbTWhQ7vEWm23o+PFGX3RZXKd1O5RceFk3qy8w4MSznxtNpRDIau7/l2SF+79KunadW/N7OLca6b0yprqSA3P5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=lx5pXg9O; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso35294135ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721209170; x=1721813970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udi6vuEL8EfSoejC7wROBHfbEhYrKfbRvcH4IT6/Cfo=;
        b=lx5pXg9OJ2zr6+7mIYvJFpODilouBog6nePZJi6gU208PuW6yBZtQazuUeyQ4xh2qm
         sHXVM42byV5V0HzZP/MEXtmt0HlhoQ4j1nBtOtiagB1bEy7CN3N0vwyBKazsiwRYcXdk
         OMfAVQzrNMGL0/QUDYdiCK+X86uizVVTS1NKOoxE4eQkwM1asWG40CoeW8+kLRVJpUcs
         4yFi+bb+sKalSO3K1vC/yWk8j0A4pe2EkLIJsEIiFlPGhIwHkaQOUyw9BVUBYTpabASK
         NLVMnthcrVe6dBjnuZOoU2+bfWejRk0fvrUx4G7Ce65aFotMv9D9Fo8c9rdw72bmbLdl
         Uwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721209170; x=1721813970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udi6vuEL8EfSoejC7wROBHfbEhYrKfbRvcH4IT6/Cfo=;
        b=bcJ2nB05eyc69IdpKuBD3ERUUUk30yQimjHidSuBGHDVxJTAvJWhMesR1A5oXHbB78
         oCkoBKJiUtXAI3acc7pwfNxuLn+X5nXwfpuAMN4bt4N4bNocA9kHnKwCIOsqxuJ3BSyq
         iGeCojappZ/gtdPwshgjime3gGzo7FMG36BK0j6AGqIeqrV4pgT1WfM1+EM+UdzWcyHN
         HIGfPMawR48qBGOoqpVpgzQexoxuzCi7dlVwvs+nYuuzn490W/wPLoCK6AYQUiDNVWAG
         +cmb4L3wfB3ciMQmFIWKfdJA548Cj7DEqy+6gmkcJMqe8Mxfpu8Q+nlt4+0Dw5Tx6KVd
         20xQ==
X-Gm-Message-State: AOJu0Ywf0rPeL0XAdMfdi2JW/Mx1OKOrmrULEfZcut2YkGTNYrP34KlS
	D7d+MNooRnbqQESVmodsx7Rvp9HSWlRvVEsoNiMTZOdSmiew/CprEOVVrnoWVEDKjPhtPquWo47
	Ml5gPYw==
X-Google-Smtp-Source: AGHT+IEAwPTOPdboUqTGUd/gpnnVP+Cf23wdFQDk+oEjHsSJVsdqw+rn5rtdH92Al63psF5p75j6Wg==
X-Received: by 2002:a17:902:f684:b0:1fb:358a:2f65 with SMTP id d9443c01a7336-1fc4e1500c1mr8894425ad.37.1721209170382;
        Wed, 17 Jul 2024 02:39:30 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. (2001-b011-2016-5634-6781-be1d-335b-1af9.dynamic-ip6.hinet.net. [2001:b011:2016:5634:6781:be1d:335b:1af9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb702fbsm71628145ad.28.2024.07.17.02.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 02:39:30 -0700 (PDT)
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
Subject: [PATCH v1] drm/panel-edp: Add panels with conservative timings
Date: Wed, 17 Jul 2024 17:39:25 +0800
Message-Id: <20240717093925.3017-1-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6 panels are used on Mediatek MT8186 Chromebooks
- B116XAT04.1  (06AF/B4C4)
- NV116WHM-A4D (09E5/FA0C)
- N116BCP-EA2  (0DAE/6111)
- B116XTN02.3  (06AF/AA73)
- B116XAN06.1  (06AF/99A1)
- N116BCA-EA2  (0DAE/5D11)

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f85a6404ba58..ac280607998f 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1845,8 +1845,11 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa199, &delay_200_500_e50, "B116XAN06.1"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc4b4, &delay_200_500_e50, "B116XAT04.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
 
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unknown"),
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



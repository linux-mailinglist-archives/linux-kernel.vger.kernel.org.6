Return-Path: <linux-kernel+bounces-354123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133B99380A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9631F21B07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294211DE4C9;
	Mon,  7 Oct 2024 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFcARYu0"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93191DE4F8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332045; cv=none; b=Z9r1Nv54VadryGlObf+YvEKF+mBVY+yw9saEt18EOmwCHYDUPctqh07LZ2dR/nuJ5fPleKDtbSCRy39ODFHTBqhxY3B7otDDBkTjfRD55UanJw3ZURkElyZxcM6n7YfQw6Ixp7CxbGLNA4a3SKyfL6JcR3zQ9R9AbQWseASQY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332045; c=relaxed/simple;
	bh=xWJwBUbal0xJNymbxKRDt9c/KoTKqADLBCsR0NNhNsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSTNBXjNlOjEh8Ho2KMz7W2rZYhgH64ZBb75oGhCv/89KWmjs19OPEwsWNI9mqrbco9OeyZztymLBt3+c6BdH8ocO6ntFzr9Tn+DPijm0FMYSwyig3mpolUQc/S3ZyLi2XGfTTucUYP050+h/RH2DBIco0scnazlVWxoVAZN7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFcARYu0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ce14ab7eeso4208655f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728332042; x=1728936842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yp2+CwKDNz0bGqR2gk7cxk+8EAcTD9zgHXQlXp3C56s=;
        b=CFcARYu0tWClTEsVYnul36wcDTMINlTo8vaovz6bto39ngt5dLpNahPEj4xLjkmlyI
         /i2Szd0bi6hyCxybIEJUuIcSKFEvcMnd2/okUmpOa8x/E+NFnYdzQ5FiSFaI0mIuwscf
         Ms1isweY3kmRZAWI8vbxcM3CFe7Hw841ZenjVuk4A7jM1b20DH2y4rt/644Vx2mTKFXo
         jnPGSkunNbUcXGl/uMcglpRNrFZ4GBvk6ywcNOeUfKXL1XBT/nJRts8u636nYITFH/5Y
         wZArM9p9g2RtfxySm0yvuOsGIcATW4QoijX0fwCVSu/liIf0BlFZi/u1DCTE8GJ3gSyG
         pZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332042; x=1728936842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp2+CwKDNz0bGqR2gk7cxk+8EAcTD9zgHXQlXp3C56s=;
        b=qnWqdL58EarigmXkGiwvNX+khpaby8JBotMa+OBxW1H6Y9ky5lqdEuC2drbjVhnG/T
         1Q41a4MQEGKJPEz9VS6bI1DaTFVS5+0m2vMnOivBKrM8kS21mB1BfyDYhEZSXzJL1dLS
         3eVmUWRF4LMLIVqsmFZFOQ3SmkK+taGgFPz+ZOmS9kniOFzM1A/07HWv89NdPNpCiQ79
         5D4tqxnMOHKhEbXHZqa9nydfXUoSrXU3OZDNHAL5RbTEJmi0rBTCwj/MKmmbVjkPcI/a
         DE6kTJMwGMmPscWbgh2/QZedpAHpFj1sAVkgDA6VcdE52Z24qhPC7eewDjWdkSjhE8m9
         cUoA==
X-Forwarded-Encrypted: i=1; AJvYcCWSI6u8pn2eku97wn2qm11F7Tzfc3nGzQaA1CRxLL/CQ8vNYdenZTcHa10dfaCGbOHC0a4GKA1QXB34Km0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7E+KOLnxLYCtBhEdQSH2rQYbd4tSN8vnkdM2xW0f5Qg0kGiMA
	boeice2AcgWsh4YyMdi4uhTsZN6yE4LLwM5sl4DoOimAEDi55Ik=
X-Google-Smtp-Source: AGHT+IG0x4+zvg7mLQVkS7BFE01UEpbCC5w0E/+O9612eREReOU+v+c9Nrej6W3d7I3jOCM4IuOxAQ==
X-Received: by 2002:adf:a39d:0:b0:374:bde8:66af with SMTP id ffacd0b85a97d-37d0eaea911mr10615499f8f.57.1728332041866;
        Mon, 07 Oct 2024 13:14:01 -0700 (PDT)
Received: from localhost.lan (adsl-178-39-53-103.adslplus.ch. [178.39.53.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995ab0a99esm128665866b.89.2024.10.07.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:14:01 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bryan.Kemp@dell.com,
	tudor.laurentiu.oss@gmail.com,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	Peter de Kraker <peterdekraker@umito.nl>
Subject: [PATCH v1 1/1] drm/edp-panel: Add panels used by Dell XPS 13 9345
Date: Mon,  7 Oct 2024 22:13:56 +0200
Message-ID: <20241007201356.10430-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce low-res IPS and OLED panels for mentioned device.

SHP panel's timings were picked experimentally, without this patch or with
`delay_200_500_e50` panel sometimes fails to boot/stays black on startup.

LGD panel's timings were copied from other LGD panels and tested to be
working.

Particular laptop also comes in high-res IPS variant, which unfortunately
I do not have access to verify.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Tested-by: Peter de Kraker <peterdekraker@umito.nl>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 767e47a2b0c1..8566e9cf2f82 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1977,11 +1977,13 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0567, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
+	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ134N1"),
 
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
 
-- 
2.45.2



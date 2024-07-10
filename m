Return-Path: <linux-kernel+bounces-248132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A805192D8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85831C21E52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE0197A8F;
	Wed, 10 Jul 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wv1Qqe/i"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607D197559
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638163; cv=none; b=tNpvwTvVjoy66NU9DwDQ2Usbwc93vz6A9dtQwW+HIIf38JqddOcnHxCVon/K7QfnbF9drxRhjEFxaCzMyLD2TIRPB7ahrJSH8R5vs72I0uTgh8u8lfDoYf8cfbXipGuQKRdSUff+XOnNq+fI6r43X+0XLO2v6Vm86ijtoIiVxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638163; c=relaxed/simple;
	bh=xIYV3Fj6qdDwEkkVVSBucNvkmmcSy+3j9t1HSenvQqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMOhJEcPYwphhdUriodu13Qb3Y/5ay9+r1HtDoY48eMBwRle1oN/YVDWLv16nGHpbC0WN7NT2zso42DGK648vVoP08Mfr2x7wJeYW1GIFkfQ8PEXi/Av6uuVpT3SD9vKQu+oo5dr9hNPW6gKGjo5P/1gaozRDCpwYd94quV1R+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wv1Qqe/i; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-781f5007950so55256a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720638161; x=1721242961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJeijJfEPOXYsmpptZE2kjhEsCyE10v7ErxULEeU9Eg=;
        b=Wv1Qqe/iiNS/xynTG906dJccSu8gqWF+zTvDu05qDtfuG5rv7uRxBkqv4JBRm8bJEg
         hXkNaibR7TCFuDcKIHX/cNO2MmwimkzdX4IWcYe70XOxZszwK3aTt/pao+W0/RUBmHVt
         ngTxuUmz1Ke+JxnenuJk7uQ78b/5L5lO0uJgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638161; x=1721242961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJeijJfEPOXYsmpptZE2kjhEsCyE10v7ErxULEeU9Eg=;
        b=jxL7USj0zjuQjZvAPkyxDKB+0zMexfUdLAmo9DhbVQqGWwP/cuO6U4gCLM+JKaCTZW
         aMdQLNckWT4v2iy77yygGJopDWaHOimcIzjh8fZjlfLtd85ve+goXjjCUAjXB89sApkY
         xHzB5vbRCf6ZLc1bbR+Y0LwvsWCpZx1nphLKLotwxG3BMFt2ClVKAfGhU1M9lU8hllbO
         EzCITtKc3qyUKArsxX2cygThHpz04FJBJV8u2b/+zKXNtQHOvWufgSpk1pWcsHjPVtM6
         +FlF2QK9SikuGPah9/5EaknR/UWW3CYXd22t0zAFTlk7qfte8OTSj6cjI4+MVH0S2zoE
         vVSg==
X-Forwarded-Encrypted: i=1; AJvYcCXKWysgDeBMU+sSEp6SdKvZ2aYeegb7vYzFmbfu7vo7vQogKIJcxR/OKyBqh98fRHKbWyk0WdD4kA4POPtR50wvSU+qqqTu7jPdOcSG
X-Gm-Message-State: AOJu0Yw7A9/vFGlRA6ejgJLDAkzvrGAlbNQxZvt1Y+yfSjyNeldKJMlk
	pCL5VMpu1r499DDb4sfsc39HQkjrxadTEjyKGY63WNSyeuNbXCaj2TFZP+Janw==
X-Google-Smtp-Source: AGHT+IEgVRmEn2piggzG+hwvFk1I2yMgFuficmdy/JT00IcXmj5hSQr3zkuMnizZlMJCY4YCQpZxxw==
X-Received: by 2002:a05:6a20:7fa9:b0:1c0:f1c9:6846 with SMTP id adf61e73a8af0-1c2984c8526mr7639552637.42.1720638161127;
        Wed, 10 Jul 2024 12:02:41 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:b77:3eaa:6a48:5e05])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d603fa567sm3270940a12.35.2024.07.10.12.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 12:02:40 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Add BOE NV140WUM-N41
Date: Wed, 10 Jul 2024 12:02:19 -0700
Message-ID: <20240710190235.1095156-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw edid of the panel is:
00 ff ff ff ff ff ff 00 09 e5 e8 0a 00 00 00 00
2a 1f 01 04 a5 1e 13 78 03 fb f5 96 5d 5a 91 29
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 9c 3e 80 c8 70 b0 3c 40 30 20
36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 56 31 34 30 57 55 4d 2d 4e 34 31 0a 00 26

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3a574a9b46e7..f85a6404ba58 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1895,6 +1895,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80, "NV116WHM-N49"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80, "NV140WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80, "NV122WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
-- 
2.45.2.803.g4e1b14247a-goog



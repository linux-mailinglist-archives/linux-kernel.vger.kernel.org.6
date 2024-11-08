Return-Path: <linux-kernel+bounces-401158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2E9C1690
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7197A1F228B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52F1CFEB0;
	Fri,  8 Nov 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="farAJhMU"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019E1BD9D8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048420; cv=none; b=lP/bo5aWg5APqYsPeDoQy0+L4JtzfMxHhDf8XujxmtswBVZm64j58PdbcYD8vNFrgVkJLuq0JYoKDv5OF+V3TgOLzqsTe8F9O4HqGfGm0HKJ/EpPA+UThsrZDH47Zor3t5H4m6nNRqmMhKGIOtCXBsPkqQ5Ch566aY8IOXEB/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048420; c=relaxed/simple;
	bh=dSgsEjsmNO/exUK9WWjC1NUxgYpA74/464brJVj2on8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=elDXq58hmimcjmNdW7FGFcSmOpG0fkwXvFWgRimiYala6s1aDITbXZDA+5bgK7MU+9aJ5R2THWfkSyylvrYU8jgXoR//9x7FOyvBxxWyXZIOwqZMWjPiGI7kIDai2mbmiZ2QqrijO4QEQF5L595U/rtXEPHwdL9YDSkApAtopX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=farAJhMU; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2890f273296so902328fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 22:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731048418; x=1731653218; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cn/Nc5RaHVF/e/nAEApB7fYMyWr4MBPCDZJyTNa0js8=;
        b=farAJhMUylHVY1fvJ897FjhO1hfQqBiDUzkDKFd81jw6vqY1hBSlxOY9+PQwNtzQbJ
         yqmbBMdtSfo642NYeH2wkxTfU0N13ucPc1Auw5ZxYUFuy24yVQ3A41EnQOINZoRMbc60
         r19dPSDekVSfVb6yOvdC99GBnlS7eWoRP13U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731048418; x=1731653218;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cn/Nc5RaHVF/e/nAEApB7fYMyWr4MBPCDZJyTNa0js8=;
        b=aOlhpWAhQWqWzEXrxRzq+okqgAw4SmgQhqqViqbelhzIV7wJeIpI5C3MkpWtHALbyy
         I6L8BYgzVmz/NBYT9ilL/p+Ro2Ks7fr5YPicJCjsQSi1/gnZUiZt2msZCAoEWdx+G7qn
         ttPJ90Z2Jxqpw4WP0j9ZzfOaVkyhlViiVNC6pgU3q1Vm5+hHpAZ20X0kUkVL8fN50Sbu
         PGRoftlBVXfBSIqfMMaP3ceJ02s2AZRc4H9CxKEkKN1gjIgCT2ma2eyq48rKMpDQ8NRd
         ofsO9MHlXZ7hgsqskzzrDngs/XKiw7WU4BJG5cxPWV8NcnLt7225aKaXc3CimsSmn+3s
         vtUA==
X-Forwarded-Encrypted: i=1; AJvYcCWw4T1i4W4sEKkkFfyx0xk/VQqhZ7CxwjdbBkS5YUH5ix1N82zdL8TfhybnZG1YqgYAB6UPDKtL7Ie+BWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbljCePNLqkXeaCJj5/626GhlSSz8igbAjVAVV2BGtEAqf1qO
	D1KtFRKUQuC9C6ougmntexo9Y5KgjCFEjjGbcuuXU3/4jSb7x0mBUlhb/JPHyw==
X-Google-Smtp-Source: AGHT+IGIj8ppTDiKoQ1Ac0ZjCZ1batJcTJQ8Mib+/ozEVFfkH5rl/YxpGzi3ZzRXz5pAIQ9//uSnvQ==
X-Received: by 2002:a05:6870:344c:b0:261:211:9d0d with SMTP id 586e51a60fabf-295603b7595mr1814461fac.40.1731048417707;
        Thu, 07 Nov 2024 22:46:57 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa8fasm2863065b3a.97.2024.11.07.22.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 22:46:57 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 08 Nov 2024 06:46:53 +0000
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Switch to
 IMMEDIATE_MODE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
X-B4-Tracking: v=1; b=H4sIANyzLWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwML3ZyykmLdNPOk1CRjs9S0ZFNLJaDSgqLUtMwKsDHRsbW1AICiAJZ
 WAAAA
X-Change-ID: 20241108-lvts-f7beb36efc59
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

Currently, MT8192 cannot suspend with FILTERED_MODE. Switch to
IMMEDIATE_MODE will fix this.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1997e91bb3be94a3059db619238aa5787edc7675..daad52f14fc03d0c4131f2ffdf3eb6b49a4a43d0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1541,7 +1541,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x0,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1552,7 +1551,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1567,7 +1565,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x200,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	}
 };
 

---
base-commit: 906bd684e4b1e517dd424a354744c5b0aebef8af
change-id: 20241108-lvts-f7beb36efc59

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>



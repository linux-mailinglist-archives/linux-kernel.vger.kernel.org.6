Return-Path: <linux-kernel+bounces-180038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C68C692E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A111C222DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D6015622F;
	Wed, 15 May 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NtVzwfqS"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5C155752
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785412; cv=none; b=S9Q8A1shZ4xn5msr+VaH04n+FyZs2jBHcNKVkk3DYbqSZA6D7821+AF3mA/EPuwAw3YNDN1FMYuO6CUhLsHHpi+3T3KwCCbOyQOZRVwe0fraqzedsSjusehguzskNs0O+Atw1KpIWJiB4S2EDSPRrM4C01wsMg1NLw9znBTCB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785412; c=relaxed/simple;
	bh=srhSqcE057PYT8XZgoL4eiPLut1PLIps2HRV2s02uPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fmuRxTDths3TGDsvzR7estLhjSrTi7rcSyz9s6d8KWiY0FlRdWlbTdSdUK0/gBaSQFrRn61RQrcgUoMGjI/ALWqX241eRoTtLi6U2tDZNo6dfT/QJfmNQ8MAQ9xVc+2ahi6L0+mnUmPWExj0NO9MK8h79Ck513rFJiaeUWXzgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NtVzwfqS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34db9a38755so6607745f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715785407; x=1716390207; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Lm+V4MOHLjpwTvmluMGIdUeu5zSQz92EjZA+xk1shE=;
        b=NtVzwfqSpRjebbKqZyF3sqgi6zzhjarjxufiUlFoXVVPMaJz7tpwYsYDDYpkV9nuOf
         iowp4+QdqgX/aYY+TLVLfIbEJwMIDXWmM2AmhkUGcF+mo6KwfomnxEO3uP/ru2H0wC/s
         5uCn5SQHJ47LmnLbYfgKEVq6qADvqhTgw1oFqQaq9v5Vgo39vsvQMpVDlECHkWbnPjF/
         IZcQYgsFDSrF+LSLSpxcF5BQjxy17BqVNoOULE9uz/gjmNi8aWJS4fF9iS9LQtOtrnus
         QoqziGXuSk6yOPVIMw/cPQP7cS55cjbg9AWbIqCOLOtU3r3wnFJUSvYohCnhB1XCdS1s
         ObmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785407; x=1716390207;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Lm+V4MOHLjpwTvmluMGIdUeu5zSQz92EjZA+xk1shE=;
        b=injS2vznlOwGlH/2xf64QZCA+ee19SRJTar3aB4WzlVtO3ekI6kBEomOiwiippxzTn
         g25mmQbXBQuWmZV4xUR/HuwD2zRhFdtVwzYNHzbAbDFSpCyEyb7ujgP89lTYtfI8WJ+L
         scfUPluum4yUcoKaNN2k2tawiB9aAfvQl1hD4qYeYwtjg9BIFCNb8ill5Ilb7+VtEDar
         dhKHeoJvP+lZqbYqgkhiA5OPjWUyXzBFTPOFxkzRWXt+8diZgdaaaa+Dwxjf6cN2wpDz
         Y5G8VbndNgGOsKKyImip8G97LxtAvN4gD1texFTfdPOl3Z9MS7sXqzMuwqjN5SoraQaq
         eeNg==
X-Forwarded-Encrypted: i=1; AJvYcCUYR1sKvFdsLTB06nW8IYnEz53nutqB53KBjkErQJqAYOsApMRSVCQbQhj9pwjFkr7c0IoMcd49Qna40A5FDU4R2/3U7dlz1lYZEeRE
X-Gm-Message-State: AOJu0YxmTsfslRzSIuwQvxXmbOXp31zCffxil9DenRU8zy1QSOR0A3+J
	TEY6bALRqLuj8yh120JDC63eax5C15D/wU5YbnPyycBdinRFKnDuxvZsG7lTnsM=
X-Google-Smtp-Source: AGHT+IHFvV/YKUp2ASUsyofDT+uyThnhNn6z7AHT8eX7ShpKC+KLWTMhMTmjH/vu1Il4PLMLegu1Zg==
X-Received: by 2002:adf:e788:0:b0:34c:fd73:55d with SMTP id ffacd0b85a97d-3504aa63499mr14009742f8f.70.1715785407436;
        Wed, 15 May 2024 08:03:27 -0700 (PDT)
Received: from [127.0.1.1] (abordeaux-651-1-78-161.w90-5.abo.wanadoo.fr. [90.5.97.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d21c8106sm368310f8f.60.2024.05.15.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:03:26 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Wed, 15 May 2024 17:03:25 +0200
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Remove filtered
 mode for mt8188
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-mtk-thermal-mt8188-mode-fix-v1-1-e656b310b67f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALzORGYC/x2M0QpAQBAAf0X7bMvi6vgVebjcYuPQnaTk323eZ
 uZhHkgchRO02QORL0mybyqUZzDMbpsYxatDWZR1YchgOBc8Z47BrcqWrMWwe8ZRbmRjK9+4irw
 j0MMRWfN/7/r3/QA8wb3LbQAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715785405; l=2130;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=srhSqcE057PYT8XZgoL4eiPLut1PLIps2HRV2s02uPs=;
 b=P6zbORiYNVpAHtTEViYts3RXJ33FKGxDpNyirArfqnQ9wqgAzgfM/pAZmaR+Kyl+pwyiMRTwW
 7+RPG0iDXfsDZfJk/djBA5pcqzd3ftimEDK5ts4vW1hDgpPUDiqOnCi
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Filtered mode is not supported on mt8188 SoC and is the source of bad
results. Move to immediate mode which provides good temperatures.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Filtered mode was set by mistake and difficulties with the test setup
prevented from catching this earlier. Use default mode (immediate mode)
instead.
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0bb3a495b56e..82c355c466cf 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1458,7 +1458,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x0,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1469,7 +1468,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	}
 };
 
@@ -1483,7 +1481,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(0, 1, 0, 0),
 		.offset = 0x0,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1496,7 +1493,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset = 0x100,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1507,7 +1503,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x200,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1518,7 +1513,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x300,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	}
 };
 

---
base-commit: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
change-id: 20240515-mtk-thermal-mt8188-mode-fix-e583d9a31da1

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>



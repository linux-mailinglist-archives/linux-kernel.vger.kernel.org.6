Return-Path: <linux-kernel+bounces-443878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33279EFD17
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B5E1889787
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5A18732A;
	Thu, 12 Dec 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rlg26fio"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222D189F2F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034414; cv=none; b=Nxj7ijb6U0AtQJymJU3ruCGvYzZE5yd/KzhSXJry6kc1+mIttm1AVgjTKhmOrG7D42yAltjGlh18YavL5DCX5Ybdp8EJXEqZgHLzXAtImyWazEcb1codhLpehy2cdwmLbquQ0BhzhoxEp6Lcoo4os7gLkTQIfHtxITx0ciJNqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034414; c=relaxed/simple;
	bh=jh8JIzPDcDvaxnMiTYtccygjmk3pmlrbS8sl6s1c7Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHGoDpLx0s6+wFHF+v8CnnR5LM5pxfFmVPhMIDJW88aCbchEke1/uGSRwcaCI/UatJh2Oje47LLSNAn4dbObxgleJXsgLOIpVL1aiVaAD102WAqxOGdMEapooLgxRpxbzQf9nogPzNVq5JPJpJCEg0o/tRRdA83d2ZG7lvnR18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rlg26fio; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so9697895e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734034410; x=1734639210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HPyEvm17GBvzoW45zFO/cFfcaMLUtMaXTixIZs2i7U=;
        b=Rlg26fio5M/UJkrm4oUFek0AkK7FXP0mZxskbev2Pf0b/C3k6hY+KcSl0sIi3vrOt6
         geAVwvwGuHM92B6O5PFL0mYwXivojq60RXLPsMW9cl+rFBH9dgauuKFjTrC6bJ5/g3SZ
         X22b1r7KNtNDx+S4G7sRrP8AFk7p3JPRnKRT1M9vsqO5lwRo5CHffoWgPy4/jjqyvMhk
         ppbX4XTj+dCWeUYSJ+XWpjbnoPCsJfpunyExI2z+4gF1MTAe8IsI6R/4Z/H9OVptYBzz
         w4ZvhlktDMtNPbChVFY1eLVP3K7iYy1ZReUJopcUb4RcksGpAzm87Ugm64rlznF0VTEh
         pyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034410; x=1734639210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HPyEvm17GBvzoW45zFO/cFfcaMLUtMaXTixIZs2i7U=;
        b=j4Gj2TutZpAxg7PcT9aFtv9ghvVQUukaoMulEOcx86iAjq6EMekM7wJaw0nSw3KEmR
         DpwTgO9FyxAbxUfOAB0FIBn+YDqqoEBP19vleVaUInyX848hZsK3OLwIsrc5wsmIzoWu
         1PnZBjzmXTMD/vpotaGvPJGxZZI80MJomdJoFxRh8DhllfUAYRkqrBwl5S/iXRVblipA
         kQRDwnzqOWlEfQGaPOaue9mFKdSa6lp8fi6RDz7QiObozCRwBCtUaeDBld7RFQ3TUhGW
         SsXnMmIiUUSkwPz4IYEi9riL0mdVGJjXCKP1m/acr6SMsjWbvkGl5p5z8wGkhFfJwKc+
         PirQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF6Kith0CNDj25Hinm5wxex8nEIUWwpxPJ9hgSs6PvG/qOyCl13jD2PuzlqvY6bGU4R5ElJh2KiH8d7Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqM0KRoSCMA61WUhlA+cmyuTiAu8Iu5RQQKwAzgisk4kia5rOE
	Fw2tfqvmyMsNblG0UAzX+VD83lX737AsoIHFT5DfLXIh0jMBB8U0vBQg2cBJREQ=
X-Gm-Gg: ASbGnctaxFH6cs4hNaTQRZUF92HdsJMuZ0/zhRCxNbZsaAZtIgZ5iaSWnYLXklINWhH
	bwmM/Wvo8vBLjrXKQkXfTCD2g7sXr5aDGoUu8TPPA60oujIBJbAznhff5tkIBcZOfSp4GMM/DrY
	lSjFUGixDrAum261ULLqUtlid+q7YYnZ9lv/TTXE3dBa9WpWiMOFyGhJeJEhe9zx79vbBmKREuO
	8w6mb4hOJjVXNWAx6Dev1cnC9MwtZp3I3ODQqExLUp/qCcmgID1JJjzr1fUEv+JLhO9ve1y6QaL
	J1fSWuo=
X-Google-Smtp-Source: AGHT+IFXQspiqBdmbRT6aNUguvteUfRABjK20wuypAXO3Cy9E2/nEt8aUJ7Kt3q0K7+56mw4GAzNNg==
X-Received: by 2002:a5d:47a8:0:b0:385:ddd2:6ab7 with SMTP id ffacd0b85a97d-387877b9729mr3711969f8f.52.1734034410444;
        Thu, 12 Dec 2024 12:13:30 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e600sm5039931f8f.7.2024.12.12.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:13:29 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/thresholds: Fix uapi header macros leading to a compilation error
Date: Thu, 12 Dec 2024 21:13:10 +0100
Message-ID: <20241212201311.4143196-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros giving the direction of the crossing thresholds use the BIT
macro which is not exported to the userspace. Consequently when an
userspace program includes the header, it fails to compile.

Replace the macros by their litteral to allow the compilation of
userspace program using this header.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/uapi/linux/thermal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index ba8604bdf206..349718c271eb 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -3,8 +3,8 @@
 #define _UAPI_LINUX_THERMAL_H
 
 #define THERMAL_NAME_LENGTH	20
-#define THERMAL_THRESHOLD_WAY_UP	BIT(0)
-#define THERMAL_THRESHOLD_WAY_DOWN	BIT(1)
+#define THERMAL_THRESHOLD_WAY_UP	0x1
+#define THERMAL_THRESHOLD_WAY_DOWN	0x2
 
 enum thermal_device_mode {
 	THERMAL_DEVICE_DISABLED = 0,
-- 
2.43.0



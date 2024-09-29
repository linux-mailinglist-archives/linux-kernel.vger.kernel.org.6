Return-Path: <linux-kernel+bounces-342767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4BD9892C9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF662839CE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 02:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5F1C68C;
	Sun, 29 Sep 2024 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="rfWA35D8"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B6EAD0
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727578515; cv=none; b=XkwXaFOZJ8oOTfNLQ16OI3q2uGdUcz5DiFCZEA59KgdHj03LdtS0xcYWgxmAoPPCzFLiYTENqvdk9+8O6HI1vIi5fKqhfj+8L7NKaDsW+wPYZC4eJ+5tdTxuaHVjSs0FYcgyeqdLpZSjdkiLA8MzXEpnLqm4X4o2kdWJrAy/hzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727578515; c=relaxed/simple;
	bh=4B+kpENM2KamWunn1VtNumHTJypu13muex8nBDOgblQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHSZYgGWrgAFEzUsVNk0gG7rfTJFAYT+dZu6tOmzOsLD/Q0GtUyn0ZhwBKtoFo0HqTJ8e7f+E/SBPQ5EaEcHlniWT6biATc/amdIwozU7eDKHdPIW8TyfLwtZhK7favrwiGBvJi0Yhstj4wBFJv3cMppGPu8jvtIM1DaE5dAsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=rfWA35D8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e06fade5eeso2588302a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1727578513; x=1728183313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnPgRh7QFS/ZB4mm9ibjD9Mb0Rxz3mufuNvInEFJ1j0=;
        b=rfWA35D8qsKDEwgHed2mwyOmjrD3zD+xzHmDGfKePc2C2jMs4/vvSWeiK0vS0nH1yh
         vMYmsmaeONreaDgZxRDSoD1zovtxK8fe3UYAVlFyC+6kgULm0XLaYeS8eOZOnxTACiLW
         qpBXw5BSYneyrxQolSvxFE+1MWO2/bJuSBEVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727578513; x=1728183313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnPgRh7QFS/ZB4mm9ibjD9Mb0Rxz3mufuNvInEFJ1j0=;
        b=Y5xi1vDryhzH1Yg/6jC1MrUOioyt8V8ITssWAaExwl128lho7b5e4Kcx20SLZKhZpa
         ftiBAKmuw08X0AbezYwTXfJOTAFXTb97os3gfHUrbfs4QkG5PNb2YMRMcVVxRMXsJRUA
         v15dvpOLGOsUVcQYYQjuB4FeX5SoR+pYegGQUAG8YmTXCzB8kal8EcB3aBfffvNubj18
         yk53/ufvuae/TMFBcAFdaCBD3qBx0t1s3WHy9JDTGqVBS/Hb69hBKUDuR6HluO8lOi3w
         BLBfFSVHg1/HXWgMVnkWH4KDQfbiJJqKpppervFUrYSCPIEvZ3X1zGtFHacsDrPhlKJK
         gpCg==
X-Forwarded-Encrypted: i=1; AJvYcCWSWsy7PdK82w34ns+t+Wk/c6Fdb1beBe1n+7hcugAT/ZcVMCVyBMYJFKqBAjSyyKTh2gPT2CyN9EdCmwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOt1Ggx6/JHoCq8iiqASRzeWT8y9JxLxX+J4QIQyq2KuZQTr+
	ZUT54o08ptXOoUH7+BRVDgq6z2ocnBAoAGCOAijb8EwwcYAYa8Bd/JKrwKJ4drI=
X-Google-Smtp-Source: AGHT+IGMBewkv5Tr2rkT9P0ANjIRY4VbuoQf93g8wX6wDvbVycvUQkG3zPgRoumtVZxN7/2BlPKkvg==
X-Received: by 2002:a17:90a:fc85:b0:2e0:8dbc:3ead with SMTP id 98e67ed59e1d1-2e0b8ed3968mr9574605a91.33.1727578512948;
        Sat, 28 Sep 2024 19:55:12 -0700 (PDT)
Received: from shiro.work.home.arpa ([2400:4162:2428:2ffe:355d:54b6:cddd:c153])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e1479esm4876326a91.45.2024.09.28.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 19:55:12 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: geert@linux-m68k.org
Cc: gerg@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	fthain@linux-m68k.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] m68k: mvme147: Make mvme147_sched_init() __init
Date: Sun, 29 Sep 2024 11:55:06 +0900
Message-ID: <20240929025506.1212237-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvme147_sched_init() is only used once at init time
so it can be made __init and save a few bytes of memory.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/m68k/mvme147/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 8b5dc07f0811..4279069fbb6e 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -34,7 +34,7 @@
 
 
 static void mvme147_get_model(char *model);
-extern void mvme147_sched_init(void);
+static void __init mvme147_sched_init(void);
 extern int mvme147_hwclk (int, struct rtc_time *);
 extern void mvme147_reset (void);
 
@@ -123,7 +123,7 @@ static irqreturn_t mvme147_timer_int (int irq, void *dev_id)
 }
 
 
-void mvme147_sched_init (void)
+static void __init mvme147_sched_init(void)
 {
 	if (request_irq(PCC_IRQ_TIMER1, mvme147_timer_int, IRQF_TIMER,
 			"timer 1", NULL))
-- 
2.43.0



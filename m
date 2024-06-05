Return-Path: <linux-kernel+bounces-202745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F48FD049
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C751C222BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F8EDF43;
	Wed,  5 Jun 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="IrsW0K7U"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44668BA37
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595955; cv=none; b=KHDtOx+lVaLUyfKN9YMkl1j3oDIP5deS4AeUpqlvbYdafJWHgMZbmeiUgDUaoYOMpXdzIh1dq4iWv6fR3ljKyr/zq5QiCXcN1Kk/YnrftbDwW6VvpkD4iazOapp1BAlLxIDvth82jt2mf+bkMgNd9/lAOSJQOEKLBfJyAxOYJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595955; c=relaxed/simple;
	bh=WgVMfOwr+lb81KNfDZXODRkHqQvGZmUuRLDuLFM+IW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=daxceWN0TQceKb1wDVPL6ofTPz97foAbK2+Nqe6mYw3WRrvMUQP51HmCQDdViCZK1ie+2IWKBXOXNm0dryVb7R5rlCHKSgqcOvM4uyLHgICSf6EJLcnTa6sv2a5uMGwKBFReJCm5NGAhYvsAXDdpKJwxXlZpoEHSJh1dh/zh+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=IrsW0K7U; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6c70fdfa43so32778666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717595951; x=1718200751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3b6sb+dUnnbQYXNCjvucpa2vf6o7PmjgOhfbEICrVU=;
        b=IrsW0K7UbEy5aPUUh6EYZDv4n/ECGLo8l7ALYkJyei4zRZbMTif/oKssfOIOhIails
         cl++eyTqq/wZDJbwB4UMw0OPpGcM0ubwK4XP0bouEH2xQBrLdhrpfhbQmj4IIV8RkeRw
         KMsc/bDLLCaLCw+yGwV2WDJe4C+FFfc+Y4ahRp3tmO64/fW/Ch9NRwnILItl6C+NUj7F
         BGfEq4HJvKqMWs/NECNrGxrRYOSLy1oVmddU5UkJ3RCXoQ/6YdayBca6qpni+IzRcU4y
         lyitMikxCgT+uMvBS27uqWP5WBiYvGKnl/4tv7SaV2MtE2zVgta2Ve/bXE3nZiokspDI
         TbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717595951; x=1718200751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3b6sb+dUnnbQYXNCjvucpa2vf6o7PmjgOhfbEICrVU=;
        b=SrjJRL5Q5Az662r36DR3Rkx9GlASuihbUFuMFlf03MVIducp7sJu8keonPbuGlKphv
         o3rwzuSuc63WQiZkzUpoCGtZ1pw4DLr+pFi7YJwAUmhWVOQnmmhw74K/jfKWrwEhDBDW
         PA5aKjh8efMktfDxU59188aeBya96FWr+tEmwmiuTMp61q/MGpAP0OSLlzHPnenohkLT
         7jhxnQMo04T09NZb5kCHEOKevxFjNzj1mH2bHRvGktn7fPgWvodSAuDxHHO3D+uicH3Z
         3epU6l/7Seoq2wumxSt0pHKoT7XAk+47SMG28nsMD0SkWkS9goi88LZmCBdM3YMx1ZMT
         ZsTg==
X-Forwarded-Encrypted: i=1; AJvYcCXJzujA92NqkUjMOFARoupZa50ok9HzzUZP0G7BHoGtfqbWqkqAL03sCLL1MC88vnSVZq9wvlmGb1M5SozgxHqgD2yVVv36V32qoFPZ
X-Gm-Message-State: AOJu0YwG9/Ano2f6QPdax6dPfpHFhXzzGvuRyXhY/wYIcEMpZBSLsqoU
	avUPNp0HFpIAuh0iUqe+A1wmVTQjMTjmyZFLWxx23KWDdgIpQ2TV6X70DhXqXbU=
X-Google-Smtp-Source: AGHT+IHmH5RsPYE1cbZ38d8c9INCJwl1umxTvg+kJxY6yNyYlnXMqCwnXzVeMObamPFKig8E4mdpvA==
X-Received: by 2002:a17:906:b852:b0:a68:b49e:4745 with SMTP id a640c23a62f3a-a69a0266a6bmr173120666b.70.1717595951458;
        Wed, 05 Jun 2024 06:59:11 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-164.dynamic.mnet-online.de. [82.135.80.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73f9a81sm774163466b.71.2024.06.05.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:59:11 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] powercap: idle_inject: Simplify if condition
Date: Wed,  5 Jun 2024 15:58:42 +0200
Message-Id: <20240605135841.97446-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The if condition !A || A && B can be simplified to !A || B.

Fixes the following Coccinelle/coccicheck warning reported by
excluded_middle.cocci:

	WARNING !A || A && B is equivalent to !A || B

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/powercap/idle_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index e18a2cc4e46a..bafc59904ed3 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -127,7 +127,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	struct idle_inject_device *ii_dev =
 		container_of(timer, struct idle_inject_device, timer);
 
-	if (!ii_dev->update || (ii_dev->update && ii_dev->update()))
+	if (!ii_dev->update || ii_dev->update())
 		idle_inject_wakeup(ii_dev);
 
 	duration_us = READ_ONCE(ii_dev->run_duration_us);
-- 
2.39.2



Return-Path: <linux-kernel+bounces-323914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971F974526
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4491F26D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E91AB539;
	Tue, 10 Sep 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UF1D18Hh"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75F1A7AF0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005536; cv=none; b=fv6tBFdZ/tcEIkNMblJPcY5x+m3xrcMCIrG0haunsjQ9SNwVYG2StjFDv2rU4n9EUAXdcx6uYIZkNEKiscaB9criymIip5tDHIzvq6F8uUrhYZK5V53DbJBaknts52nG5hhp3JItTbX284OrETVkO2LWIT/SSisQfgiDbEFcsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005536; c=relaxed/simple;
	bh=2wDslfw24GSPG0EMYcKfh1mwx17kKgkL32mKlCkYvIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZfYfyUzDAdS6wLIhaul/R8t4ZleF1HeIffRnMPJYfY2G1vwrlJPdxZckB+2+2S1RaiiXBovGE3NEo/Wvh1mDXu90MHoZkNfiiNJQTDX65BNYgg+AsMdWqXDuYDVuV2bxwBHcxjtWCOaMQkT3HKCLxfiAbHxInBxbuyN/BbBnlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UF1D18Hh; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e033e66a31so2402463b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726005531; x=1726610331; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/sv5il8mfJbCyj8JT+aqiunnzSEOi+g9TF0iDV5AFt4=;
        b=UF1D18HhKTud/w8MqCnb/C21x53MGt04ZXc/bpGC7gMZTnPaxEVelanZjHvA3fyZDa
         zO+f3Oqb1QEsbEIkE6hyOypmXoc1H9vIWZcVj1yh2QdLqu5a/9LMcARuLeoiWJvc3MGH
         lC6Iy4JFvO0j50BP4bUDFbgWnF93x0FWg2iUdgTIK5fR6JefGNlhKOBEuv6jh1ZVz1Qu
         C5LpAi3qvbvunMIf3ogrBGrRZ5XmvYsJbf3FEt5Xk/K2m2O3mkm06frN2KSoJEpPgRUI
         M9k2+3uUL9IUuqCf3Od4/q+AmzCyO3UDHIhGp5Tv8V3yjRBhfF1a/hTHO2uR0dkt59II
         /jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726005531; x=1726610331;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sv5il8mfJbCyj8JT+aqiunnzSEOi+g9TF0iDV5AFt4=;
        b=K2hGiYqd4eUCKHD273a3cilbqBcsvamtuD1ZbaxEHMrQOajryCrDYn0RqnHfapIn1r
         EGH1lRXM+clYLPqI1skshuMhWmhB582LiFRQpxKFoK/U6r982X9eqwwiBdB+Z+7BQS4W
         G2P51U/3dQ+nPP3Y9SOmdhms0IHoHNuGabteMl484yokxQakQJgjjaSBj+kIK6OrAzJI
         Lr1GpuZRDiroUBGYF5+M9uixEjoXmluv8O+/z8wH6m33bmC/vCRbX3YoE5xaeLcGpJO2
         0sxAs8AqTG7eL3zBJ+2yoPu87ID+i7U9TSGzYnE89gkd9gy/djHbT+NcOkvqBFaoBpRG
         ogPA==
X-Forwarded-Encrypted: i=1; AJvYcCUTGuqJcpSEtnEZE3QWlFW0lrqZTVuXm/xrrYqn6VLLmr+QOTrJQGNtayR/cqmxrz4k84+5EysI8cOhoeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ppP/LjH03yZ+yojL7DoHMg1klwzcGS7NrkDwBcZmnlbmJplq
	HcIu9sYwglcvYf6mxZHFIcYJJ4E8yT5niybh2lKngKJth6dgRvEK9v5yG8PiMZE=
X-Google-Smtp-Source: AGHT+IGJ5kc7+uhI2aHOq0Bnrhd4m2D91bIKbMlbjCpoIsOfX88bV2ca30yPTSXgMP34rWLP2PM9JA==
X-Received: by 2002:a05:6808:124a:b0:3dc:2878:c2d with SMTP id 5614622812f47-3e02a02d94cmr11088331b6e.47.1726005531386;
        Tue, 10 Sep 2024 14:58:51 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e039b7c4bbsm1760150b6e.27.2024.09.10.14.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 14:58:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Sep 2024 16:58:47 -0500
Subject: [PATCH] Input: ims-pcu - fix calling interruptible mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-input-misc-ims-pcu-fix-mutex-intr-v1-1-bdd983685c43@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABbB4GYC/x2NSwrDMAwFrxK0rsAxoSG5SunCH7XRwq6x7BAIu
 XtEl8Mb3pwgVJkE1uGESjsL/7LC+BggbC5/CTkqgzV2MstokHPpDRNLQE6CJXT88IGpNzp0bBU
 X72c/u2eMzoL+lEpq/Buv93XdTd90EnMAAAA=
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Fix calling scoped_cond_guard() with mutex instead of mutex_intr.

scoped_cond_guard(mutex, ...) will call mutex_lock() instead of
mutex_lock_interruptible().

Fixes: 703f12672e1f ("Input: ims-pcu - switch to using cleanup functions")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index c086dadb45e3..058f3470b7ae 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1067,7 +1067,7 @@ static ssize_t ims_pcu_attribute_store(struct device *dev,
 	if (data_len > attr->field_length)
 		return -EINVAL;
 
-	scoped_cond_guard(mutex, return -EINTR, &pcu->cmd_mutex) {
+	scoped_cond_guard(mutex_intr, return -EINTR, &pcu->cmd_mutex) {
 		memset(field, 0, attr->field_length);
 		memcpy(field, buf, data_len);
 

---
base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
change-id: 20240910-input-misc-ims-pcu-fix-mutex-intr-9bb7b7a6dda2

Best regards,
-- 
David Lechner <dlechner@baylibre.com>



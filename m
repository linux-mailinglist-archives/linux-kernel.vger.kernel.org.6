Return-Path: <linux-kernel+bounces-343508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA6989BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C37281718
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C916A92E;
	Mon, 30 Sep 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ikwdea5a"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2C15D5D9;
	Mon, 30 Sep 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682462; cv=none; b=Bzx+j7DLWfyvmbt8BlS3W+4FT4WvHUbE03TDN3M+1Q17ttpq3ul8Xzm/nmJ2V/kMN6vSmGnARi9+oZLvDwHZoxcsY7CxWGwScZW/aN7vs9MzmS6n+sfmoPjGO/9oIH6AozhRFDAgc9rUmOiAgDJP5RCABLFHoue9ObUkANGKPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682462; c=relaxed/simple;
	bh=7+9y/YEvw4UDGlVzBtxyqJLKBBBLQZUqxCTaLtPG7hw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LyORu7IyqEeKjshBTiWFEI/zUy2hSUttvO7d1rzFPkI3V/FfNHfOZiBfvhpoOnQvi4knxwKefzqFR6xEvTX3MP8ZJGzFe5BgvOE2fOTHxLVPEZo1Zx53PCko343izfOd1kxV6S3BYSpOEu02VgNoCWrbZKGwQtW5uZQ/Uuh7tkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ikwdea5a; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso625553866b.3;
        Mon, 30 Sep 2024 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727682459; x=1728287259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wBOsog2pNLFaAr2Ohs9pRufolHG0ydUCAFQ0oauNMA=;
        b=Ikwdea5aa3H+xdeZjBWMB+LQMN/YlR60FmKoNvsnZi01ofcoOxMG5Xto0FEfQT0mN5
         8hyecdPpA4dpv9Oz3UJx1IeHogl/rpTsYFgYv48UTsA14CYGZlNLVaXj6nK7t5wyCd1G
         a6/eR1K47G7De3SftF9/l/lZyuNNMNsNhxV8kyri7y8LRvv1SSX0PJo832WbbbkJzcwm
         hs2JXpE2X8sZ5pC1V30yFiKgGhw55YBisQAC6/UsgzW6JybObWr8ynY0wkrOkL//nOWQ
         1sG4birPRxzoXVlH7OOQah7tjQ9fkzzNdRNW2NUCpvY04K9/1v1tH18FfJByq07nTwrD
         zCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727682459; x=1728287259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wBOsog2pNLFaAr2Ohs9pRufolHG0ydUCAFQ0oauNMA=;
        b=SsQI9qg9wq9i0WRRgXi/ptz1B5IJY8EEjspsp4wK7vrlr43vJKO5i7Sti6TCxJqS0K
         9T3oQJo+qJ75b9PneYg4iJC3CtZbLxrhs4HSqZKJSI1n5Ms0taPIQEC7cQZTSdK+Pyr1
         EthoIa1EIwrp2EvM5RFHueKHeTabsAP1eIVphkRg005sKc2u4fg6P6MCy+nvCdE6JPSX
         PG750gbQeYcY6h0+7cI1xAJd+ll3825VR9umsDUoFsJFEO1aNOd4jf2g1E6n9zdcQB7n
         PDogt1He1Ok5KU/+ODJryGaGhYfjitHbv3jMdeBJmaualEsimE/uNzBbQvacizbff97x
         XSlA==
X-Forwarded-Encrypted: i=1; AJvYcCWiWQFk+4AIC5aMNms4Xn967xdqr3QQcRXtvah0rkFxjTW0YMUDx9Rx/GGFHx8poFfuQxqP/OdUrENXZ50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgkgO0iZ1CnGtKNN5Pj2uOzm4PEVvYLD+Sx7oFaIlJkCf9dNWw
	peV4oTTSjg3v6kq9nsIaTLitH445fNEHljtG2uQzchfZNW/D8AjV
X-Google-Smtp-Source: AGHT+IHvYQbigb/QRK6V+ONj5aAjIvinXBGALvI67jbRItfRisdRVhwtw867ztfqn9QsHI5wEDri4g==
X-Received: by 2002:a17:906:4fcb:b0:a8d:5d28:8e0d with SMTP id a640c23a62f3a-a93c4a84fe1mr1171992666b.45.1727682458400;
        Mon, 30 Sep 2024 00:47:38 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998cb2sm484428766b.197.2024.09.30.00.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:47:37 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] lib/math: Fix spelling mistake "bsae" -> "base"
Date: Mon, 30 Sep 2024 08:47:36 +0100
Message-Id: <20240930074736.48878-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 lib/math/tests/int_log_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/math/tests/int_log_kunit.c b/lib/math/tests/int_log_kunit.c
index 737d2c00615a..d750a1df37c1 100644
--- a/lib/math/tests/int_log_kunit.c
+++ b/lib/math/tests/int_log_kunit.c
@@ -24,7 +24,7 @@ static const struct test_case_params intlog2_params[] = {
 
 static const struct test_case_params intlog10_params[] = {
 	{0, 0, "Log base 10 of 0"},
-	{1, 0, "Log bsae 10 of 1"},
+	{1, 0, "Log base 10 of 1"},
 	{6, 13055203, "Log base 10 of 6"},
 	{10, 16777225, "Log base 10 of 10"},
 	{100, 33554450, "Log base 10 of 100"},
-- 
2.39.5



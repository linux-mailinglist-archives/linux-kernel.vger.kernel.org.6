Return-Path: <linux-kernel+bounces-242920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC5928ED6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4961F21E9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC139176ADB;
	Fri,  5 Jul 2024 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMdrkkXH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD6176254;
	Fri,  5 Jul 2024 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215362; cv=none; b=gtY1DYR7BpHFS3HcQfF9oALPP14YQaMRAgRSPHf7sM75MVRjrUNMBjckhzMtHJrdyJ0DvAmhZcuGJmA0sNvssCJuz5dno8A0L06YWxZoFgXZgKsWNzM9NQ8MRQ10nrAGUlt+CwcAFeE8EZP7KUUVAmYXjxZf3mDBx4enSq6FeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215362; c=relaxed/simple;
	bh=8xZevcRfWfOhaVSPFF0LPj45zk2o6PqpDs+w6+vI9W8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3A+mmDt+4j8LSGyJdr6odmHoaDUNXu1kthsTgvYezdkQQgzYqUACqawSV56ds2vtTpv1tzJXzkVjYTlcclXEb/jF5DCCtfS9c8HGZQn0YAckYS0V2peCrN14S7rzczqMd1tqCQ0tK9LQOneQRx9UxfOkOnyGb9wy1vjrowwwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMdrkkXH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6a837e9a3so11705265ad.1;
        Fri, 05 Jul 2024 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215359; x=1720820159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0fo2mbVysNZqEGzhpGQlODkAVJfrMLputegprKrxuk=;
        b=NMdrkkXHtCrSSSe911CDboO+1LE//nqsKMEXswXYGK9IP5CHFi+OQ6H0V/9RFqDRTc
         XYtt6OJumnqJfOnPJg6ziQgtggak2TaUe00SIPfkVIfPsR7ZRWABLuH2NtooE7Jytz64
         xktWGKks/Dz3yFR/VeL57+mvv9kUb6in8A4FSrx4WnC43FSUcan1+eL97Z8l5Wm3eMzq
         xOY3tLvzhkPkLWbRecteUhMpsRTUIBzsMW0R1V8OsPBwiOm+g9n2d3jhcZo17LyciQAa
         upUWgrdDtUk4auqyM+qtsf+heGsMXbAlFmLHpeSjgG8x9L4OD5NVIMXOCrQGBE6UCceY
         OxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215359; x=1720820159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0fo2mbVysNZqEGzhpGQlODkAVJfrMLputegprKrxuk=;
        b=cz07Mn6tu7NYIWsoxDY59e9qyfsVqVrFOGumyWDxUza7J3orIJIhsW0aZWswxZ/Zrb
         X2zQccDZLnDzUQzpN40TXjEVx9ssj+alpPBf8hxSfTcE1fsQ/cVIJQBQxAyhzmfOPQvJ
         T0WucQTBa5isVAVp2Lj8LcfesPMtA29A0PTzcPRNqlTzJsWET8ucl8kma9hX70o29IbH
         YYh3RAumWD63BZzbTVnDYs+gC7LGyyKUCJONpJsVrathpe90rW98mJAMS9971IL5aLir
         Jma8NlHGHhyERmPdIX51IghGal8P9KNNDbB5KZQRi2GjgK8lPwC1S4oCysmVP5otCG8h
         iHoA==
X-Gm-Message-State: AOJu0YwvSu1as4SuNC2pWWxkHkSSbSfUSj+kFT0z3vh+2kZCbHilCclR
	pTN3QNFgkQOl2fqktDznbzD0X3kMyVUrU/7cWalUOBQ3GiF6yTbz6PgqaA==
X-Google-Smtp-Source: AGHT+IE34JQzvGL3WR43+Si513H1VuP+A2U01zqr9EDROzGDJnAl4AtIMCak86oMHEBJssqda2/EHQ==
X-Received: by 2002:a17:902:c14d:b0:1fb:3037:f3a0 with SMTP id d9443c01a7336-1fb33ea3f50mr35304795ad.32.1720215359474;
        Fri, 05 Jul 2024 14:35:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8b03sm145049025ad.4.2024.07.05.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:35:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 05/11] hwmon: (amc6821) Reorder include files, drop unnecessary ones
Date: Fri,  5 Jul 2024 14:35:41 -0700
Message-Id: <20240705213547.1155690-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705213547.1155690-1-linux@roeck-us.net>
References: <20240705213547.1155690-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder include files to alphabetic order to simplify maintenance,
and drop the unnecessary kernel.h include.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Fix subject (amc6821, not amc2821)

v3: No change

v2: Add Quentin's Reviewed-by: tag

 drivers/hwmon/amc6821.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 9e9a70afbfd4..8869dbe5a733 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -8,16 +8,15 @@
  * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
  */
 
-#include <linux/kernel.h>	/* Needed for KERN_INFO */
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/jiffies.h>
-#include <linux/i2c.h>
+#include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
-#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
 
 /*
  * Addresses to scan.
-- 
2.39.2



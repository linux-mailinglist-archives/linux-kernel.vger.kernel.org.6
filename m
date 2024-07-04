Return-Path: <linux-kernel+bounces-241564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A956927C96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D9B1F210E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CE136E28;
	Thu,  4 Jul 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcRvyo6f"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF40757E7;
	Thu,  4 Jul 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115542; cv=none; b=gFBIlrRABFwEVQyEbPTjCTF0NJdcX8Z88kz0YqkCg6RHMDFn5c65pRG0hJaTsNmeJKiHUIfwfOUS6DwREXre3Pms3WOJjS3t6rI4xLR+SPPVYyhDV1PLP2A7NUjrOhOmPZBQSkxp3JGUNNu/ChsJ3uYe+w4ib5hN++D2JDEIK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115542; c=relaxed/simple;
	bh=OJkG/9iW9Ma2QBYRmu7LSJdcEu4FUD9/NNTHqojLvEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=svhXUUb853O1fyjCn7X+ptJko/JREh4Tgc6giwi3iuDPo6wPUHVqHZLE1WsSzKq96U56F4wTxs/1crsK4EbD2HAFmwgbWSXdsaqU9trUyM7OHQrpoPWl+xjSlDIhcyMNi1TOPYjIaeOVNAhnfC6NLZScutlYt6C+sf0cijBaTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcRvyo6f; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so3585065ad.1;
        Thu, 04 Jul 2024 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115540; x=1720720340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CntnzdWNU+2tnNWnC1Q0uOq7kNzydQHoZ1vqFGKlbf0=;
        b=OcRvyo6fTsQoi817EUx9Ph+2PsjOpedFi0A+AE9GGGne3Cp8foHfAnQaE8isGTX/xl
         xv9EQuAwk/WBcHfpJmGVCsmLikX3kcGYRGpJQ8/cKfNUvQ8qoXnk6AE0gcN9wSJvdaN4
         NsKfCgnt3OLqGKNfdEoa8IZknRMFOJQ+SPe/rwPwtXlXS8oy/HbhFQPzfpIUiZ4Uctn3
         Q/tBwvVnVOliFJOSjY5hdQLyEO6COWsfcmCPReL0KVIix2lrLW3y2zRZSs6GLd8hlsvi
         3PVAIeH8Vqcumv4KisI1Fud0YKP0IBYLJAxT2fffnwdGB19RF8R1RC8IMSVlUnTVSvXy
         lgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115540; x=1720720340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CntnzdWNU+2tnNWnC1Q0uOq7kNzydQHoZ1vqFGKlbf0=;
        b=vj8f5wN4SYjt5FghedVPhwlzM5+5PLA9izdcGZHFnqDbI61bBoElZioiL1UqUKot6P
         2NJlyM3oV6nAgD85AsSb3fsG0jYqqagTyTQOLFyBdAhsigNvPpTtneY99szhu7LdvtTr
         ij/a4yX8K6Lh7f3PHJ/egm8gLEIvFz5Ot4zBveCehXZ/1yNW3AVlKYxymCA1DN1KkfFU
         r7Ny+mX22fT2I635CgB1/MM/lSAkOZtJrNAxmEK/mA1rXTQLSuhHeHcsVe+4SByy2WWt
         w8THf95neZ2UUicy1ZvqTHJmL5NiyGxayls/8jKRXRIqm2iWCHzqln4g1pmhDRFE2/FJ
         iNXQ==
X-Gm-Message-State: AOJu0YwN8nqFhw6sKQGk1jETxOcXmL4kYbxam+xEdKYf4qU7rA21XAoO
	uW8vtxgmevWCS6wIsXQxYPzfoz7iEcLsk6bPFGKBKE9oyF2X09H9L3s4pw==
X-Google-Smtp-Source: AGHT+IHQ24c8+7dED17rC/esHP8/NpUj2P1iQpDtKRNsusIFy+apgrc0T/25HoP4+iDO+AvwuHeqMg==
X-Received: by 2002:a17:902:e80d:b0:1f7:37f:728d with SMTP id d9443c01a7336-1fb33e05423mr20086145ad.10.1720115539857;
        Thu, 04 Jul 2024 10:52:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2859sm125324045ad.75.2024.07.04.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 05/11] hwmon: (amc2821) Reorder include files, drop unnecessary ones
Date: Thu,  4 Jul 2024 10:52:01 -0700
Message-Id: <20240704175207.2684012-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704175207.2684012-1-linux@roeck-us.net>
References: <20240704175207.2684012-1-linux@roeck-us.net>
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



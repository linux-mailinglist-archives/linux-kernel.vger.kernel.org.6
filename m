Return-Path: <linux-kernel+bounces-237042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E891EA38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2201B21B28
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA7171671;
	Mon,  1 Jul 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhwUkcsL"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F96171650;
	Mon,  1 Jul 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869041; cv=none; b=tFCPzvlFQ1zbyrOX5Yrfm1wUsibfy60t0qg8jmZY4uLxAgkbL+XZjMIe0l5YeCrJfuUOePNyGpbkueFS0ZjIwzcTYU+9//gOe0v6cwfXTs0Ie+K2hZu3VctMacu3WT/FK1bSK5L5/hM3CLOWJA9mFGfGtTEt8XeVCAh9e/UWsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869041; c=relaxed/simple;
	bh=HFhKz1+bEinxN3liv5VLA6r0a8T/KM1FqNlY0sb0voQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeDE09LcubeAYR0y0M/kit7gVVLcOUpwi3D5EfKAoNTMKZgfWEkY7FvhPquPP1v4BIGcLAMxV38SG5hKuBBEdq6CLHYVnwyUmCE0+UvCKGOx4REe3gPiEZ73WBFeqNOjUXoyQo1ak3yUGBt8aw41NqV3QwvP0WjSm3yP+hPhrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhwUkcsL; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375e0e258b7so14235045ab.1;
        Mon, 01 Jul 2024 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869039; x=1720473839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMBsNqatyB0OB7H5r1hWkgSSTu9pZYQoHiRxXoc6VP4=;
        b=KhwUkcsL7PXH5IiydsRKcdOJYUFPmfIkIeOEXNM+YXHFkyatGqdv5xtgUcydCDXyIr
         xwc6OsqL+3WqXU2SpyD5Ggzoc4BrAriGeoA+BKJusPgyqsdJ+kKAYdT9Y5TO7GrFphb1
         Ja4wG0NS5Ni/qQMaQruHxYlwwYf0TtIW990D/OPp4l0IiR/gKxCiaZnQANbds5Nt2FNt
         LWBE1VcnU38Mgjz/2E52rfZRPuQ2pQov2zJPMbUECy2v2ggDnVt7YOhRPUxiwvzDP9rk
         dK2/xa9xyCxvb6I6zQJ8b7AXLFNHEB0rnnWkrw/gFk4kiC5UDwp80KFvGxrs2dNA2//S
         RJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869039; x=1720473839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hMBsNqatyB0OB7H5r1hWkgSSTu9pZYQoHiRxXoc6VP4=;
        b=DI3N30HqPFfKL2KF8dTK0rie4qF4wyU8Evz5HFzDyx+aydwQ2/hC3YLIXtf8OCuf0q
         NR8ux0yah8Uapx3N7UXOW5fShGyQNIYMU4yASKfTwXOdg/vn++y254jJxtKmhDCMsnod
         m61ek8BYHWT2i4pUM7sqml9U87e50wnEAWsjpMzzvowiH8VwE+zITQ3cITpaBzpxxIwS
         8qoVp++r5v1iEa6OLP+GWw6xQYJToVK5LrQjKL9VSeUeFHEwotScuq0qnRgrRH5HYTwl
         J4Ln+ne2e5vqB0KlsTuN0Dio3iTJw8wwDRXLfamwxAwaQGqbjQTMgHKsdPKgpHEnk/64
         PoZQ==
X-Gm-Message-State: AOJu0YzMO2lq0mVxRVOlNlegy6Qa6GKFIYkBEZp/zgT0X6OTpHmt08lk
	NYX4JaA9iqjYWNT7NgYYcF8EKkR27RJ53eegpEdDFZ3ztK5mWypI5tgSEA==
X-Google-Smtp-Source: AGHT+IFt+2TcuUbDsvhvyd6nBvXxv9QqONc0ng8FtkQhA8mI02Z9FsB7YvCI4a7OqW2C7k4wHyrbeg==
X-Received: by 2002:a05:6e02:1a0b:b0:376:115e:bc4a with SMTP id e9e14a558f8ab-37cd13b19bemr81219555ab.10.1719869038773;
        Mon, 01 Jul 2024 14:23:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d41655fsm5492698a12.92.2024.07.01.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:23:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 05/11] hwmon: (amc2821) Reorder include files, drop unnecessary ones
Date: Mon,  1 Jul 2024 14:23:42 -0700
Message-Id: <20240701212348.1670617-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701212348.1670617-1-linux@roeck-us.net>
References: <20240701212348.1670617-1-linux@roeck-us.net>
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
v2: Add Quentin's Reviewed-by: tag

 drivers/hwmon/amc6821.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index caf720ff674c..e9d345c8064e 100644
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



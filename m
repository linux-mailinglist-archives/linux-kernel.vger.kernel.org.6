Return-Path: <linux-kernel+bounces-227235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24CF914C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891EF283B92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C013D612;
	Mon, 24 Jun 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vCZSCu0W"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A213D538
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233496; cv=none; b=jcwvKmxrX45PhRFeaae5uwjkW2g3J76x+EupqRcXb9G8tvid750Sk+/mRnEhqIMQwGZji/DfLeWYEp06AUNtMrLsAshgHSbXRtcxlJHmYydVCCWJohoMf09dwTCNcbpqhQb/veNgFYWc8vJ7SAtHN0Z6zO9l0mCJfgPq7YLwa9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233496; c=relaxed/simple;
	bh=JYxzwQ1SHdpTe+QItKb+6Ov1rZYCU36SdMrIdhMFVEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q2izJU9kC7j2UUvVfaAIe2IhnOkX1vz0ImVW3pp1mvfgSJdZR+Bs4SU5VkB4n1oPE/XspsiyxSVhSkpuReSObTdErIgt8kDKIpW+I3nJW564rG7fYSvsV2WRbX9N2Hzk3Wk85WXTxFbwebFLebP9PdLNHMEHpKjhtIo6jpsDPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vCZSCu0W; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso4959005a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719233491; x=1719838291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=py4gwKY38tNgEQQ3JTdNOuLQbfUzC1cLR9I+UUhhoaY=;
        b=vCZSCu0WR4vJuZMVb/x/P9C5ZO5YNz6gBWqqz/JaoFKoqox+ljocWzTqwCh7X2buXG
         JFinUesWuPM2Q/rYxEVm7NYMAm6I+m6lmjTihDrsOMeipHOj5Ui2zus677aCQScn3G7y
         HU3iSWQo9BCCI72wZzip7i6GMCyUKHOPbBST6fu5Ql6It4BIwV9TaHUjaEbmaI9QA2it
         VMzKbbhx8c4k5J2Vj4HOr9FnBYHh0o4x8Am1zQ4VErgZYRcd93Ybhxu1BJLcRSoDmZXC
         Hm+oy5n5nrdXN3w2vFgAFMg3iPUttE1w3BfVaN6dNhgREmaYdTYfpsfUJ+o9gyvlCi+I
         JbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233491; x=1719838291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=py4gwKY38tNgEQQ3JTdNOuLQbfUzC1cLR9I+UUhhoaY=;
        b=Hd2Cr0RaAmZ+EfLF6ViBYfTCxjL9jjDSvKrdD35Nq/QF04ysDP+YHGyZehzNFEoqws
         N8eV/1/vSOeAE6zCm0ha1qqypmmM34+4IrXqLxBJd/LqBUQt8Unw6VCfwH9X3lric5in
         9UN8HLFKRBk+4Z/j+DQGSLYkeDWAW8I+z7os3prSRYUawiXddN5HOH/VBIuLofWQep6W
         4fby+diTk5aQqf7tz4hO/xLU77vs1IuPfLCX9GxfBHWvABIY/z+lw3qccpgmzBpUfhoB
         /73NxdLnDF6k47adZGqL0c+63ftFzse4X/rAlPL24PXvtM0q9PQh+bLpBm9Nmk5MjpMu
         8Gxg==
X-Gm-Message-State: AOJu0YxTOwdTp3iaUkeDo4FRn2Bh1hXWFUAjSN6vluchu4shhQO4tc3S
	LBAsmmIaw6CW/L0jRCqoZEz3IciQnsu4y6BF+qpDhJDylrxibbXbGoWkM/hdyZI=
X-Google-Smtp-Source: AGHT+IHF7JvvTOWix9I36GuRhIXL4N8yq34xKCgyc+OBjYOrEUiN+eF6Ui/TDqUUAnRYDE6K77x37Q==
X-Received: by 2002:a17:906:7c2:b0:a71:94ce:9b03 with SMTP id a640c23a62f3a-a7245b6251amr271376966b.20.1719233491088;
        Mon, 24 Jun 2024 05:51:31 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:5d40:c7b4:b6ef:a1b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725047c407sm142704466b.2.2024.06.24.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:51:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] misc: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon, 24 Jun 2024 14:51:01 +0200
Message-ID: <20240624125101.1242750-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4496; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=JYxzwQ1SHdpTe+QItKb+6Ov1rZYCU36SdMrIdhMFVEo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmeWu2136asA8YjFIG1ZAOtA5UppqtYZlcJlVHR gKTl35pb6uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnlrtgAKCRCPgPtYfRL+ TqJmCACk8+TuoxbE+aNcKy7E+6jwkTsoX8mKpwV3BX6VHaHWNeN1W3sAIfHPQEwcK9V+eLaVp6f ax60TOYrCytSbOTaoVRlTt7p5MtHB239vU0iINDo12jmtiZoieC+myDljcoWFU6NoCJmS25SWfW P5gFbbdGHdf0ibH57CV76e5DtNHdfMG/FxRPwURLmk9bjJ97I6YS56zmxBlLSrmTrVYa4jv/aSG SeXmyJOqOvTEVOoiK1CKRdLzrx7PtVuJ2fWOpSc1MwO1fqECtwpBQXnbKidcXu1mzXXKwi86ny9 l7/zwYZkOFgL2wSBkz9nrzCXdQMhUamZInciyyDKVxi8TFjN
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

While add it, also remove commas after the sentinel entries.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/misc/apds9802als.c | 2 +-
 drivers/misc/apds990x.c    | 2 +-
 drivers/misc/bh1770glc.c   | 4 ++--
 drivers/misc/ds1682.c      | 2 +-
 drivers/misc/hmc6352.c     | 2 +-
 drivers/misc/ics932s401.c  | 2 +-
 drivers/misc/isl29003.c    | 2 +-
 drivers/misc/isl29020.c    | 2 +-
 drivers/misc/tsl2550.c     | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/apds9802als.c b/drivers/misc/apds9802als.c
index 693f0e539f37..6db4db975b9a 100644
--- a/drivers/misc/apds9802als.c
+++ b/drivers/misc/apds9802als.c
@@ -285,7 +285,7 @@ static UNIVERSAL_DEV_PM_OPS(apds9802als_pm_ops, apds9802als_suspend,
 #endif	/* CONFIG_PM */
 
 static const struct i2c_device_id apds9802als_id[] = {
-	{ DRIVER_NAME, 0 },
+	{ DRIVER_NAME },
 	{ }
 };
 
diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 92b92be91d60..9f9e9620455f 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1253,7 +1253,7 @@ static int apds990x_runtime_resume(struct device *dev)
 #endif
 
 static const struct i2c_device_id apds990x_id[] = {
-	{"apds990x", 0 },
+	{ "apds990x" },
 	{}
 };
 
diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index 1629b62fd052..0055f500b658 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -1361,8 +1361,8 @@ static int bh1770_runtime_resume(struct device *dev)
 #endif
 
 static const struct i2c_device_id bh1770_id[] = {
-	{"bh1770glc", 0 },
-	{"sfh7770", 0 },
+	{ "bh1770glc" },
+	{ "sfh7770" },
 	{}
 };
 
diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
index 5f8dcd0e3848..4175df7ef011 100644
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -271,7 +271,7 @@ static void ds1682_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ds1682_id[] = {
-	{ "ds1682", 0 },
+	{ "ds1682" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1682_id);
diff --git a/drivers/misc/hmc6352.c b/drivers/misc/hmc6352.c
index 759eaeb64307..ff92c6edff6b 100644
--- a/drivers/misc/hmc6352.c
+++ b/drivers/misc/hmc6352.c
@@ -121,7 +121,7 @@ static void hmc6352_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id hmc6352_id[] = {
-	{ "hmc6352", 0 },
+	{ "hmc6352" },
 	{ }
 };
 
diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
index ee6296b98078..4cdb1087838f 100644
--- a/drivers/misc/ics932s401.c
+++ b/drivers/misc/ics932s401.c
@@ -95,7 +95,7 @@ static int ics932s401_detect(struct i2c_client *client,
 static void ics932s401_remove(struct i2c_client *client);
 
 static const struct i2c_device_id ics932s401_id[] = {
-	{ "ics932s401", 0 },
+	{ "ics932s401" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ics932s401_id);
diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index ebf0635aee64..9f26db467a81 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -449,7 +449,7 @@ static SIMPLE_DEV_PM_OPS(isl29003_pm_ops, isl29003_suspend, isl29003_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct i2c_device_id isl29003_id[] = {
-	{ "isl29003", 0 },
+	{ "isl29003" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, isl29003_id);
diff --git a/drivers/misc/isl29020.c b/drivers/misc/isl29020.c
index c5976fa8c825..1643ba2ff964 100644
--- a/drivers/misc/isl29020.c
+++ b/drivers/misc/isl29020.c
@@ -177,7 +177,7 @@ static void isl29020_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id isl29020_id[] = {
-	{ "isl29020", 0 },
+	{ "isl29020" },
 	{ }
 };
 
diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index a3bc2823143e..2ad4387c9837 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -420,7 +420,7 @@ static SIMPLE_DEV_PM_OPS(tsl2550_pm_ops, tsl2550_suspend, tsl2550_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct i2c_device_id tsl2550_id[] = {
-	{ "tsl2550", 0 },
+	{ "tsl2550" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl2550_id);

base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
-- 
2.43.0



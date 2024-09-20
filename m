Return-Path: <linux-kernel+bounces-334541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3597D889
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00142848E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E13183CA6;
	Fri, 20 Sep 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QHV+AA2j"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD617E47A
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850853; cv=none; b=NR2s02nD3oc5wtdddT1HzeT9hHGOK/4NXVB7f0hZFojglw3i8Zsu9tgqa7V+lO4oZuHoWUD0ZX+TgeSJ8CGLGu0wG/+BZkistYNZvmDJmNG0X5UkG9AVLcx3qr742lH7B1D0ey//Z2/VpWEtHHiWizBikWQlITH1/EzMkei3I5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850853; c=relaxed/simple;
	bh=7Gd97J5FZJ8x51YDJ0TveVRB+r/ZL3dVmW0gShb0mFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tmj69fFJ4cJpW/6XHyWGntCVjUHhSaJ/ta60/1qSNfwQUbD4g3kClefkSRMqgQMCX79i+8igyVrMw7bLuFTZSLCe0bbls7SpnKfyxFm8VnogcmCSOHIY80pRSbEnDHXwHwK2W1Zx2C4/L/wmZoj1/2eN/b7nui/7/QZPAzmRh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QHV+AA2j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-378f90ad32dso1476545f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726850850; x=1727455650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Grd6/QarEoX1VDGP2KnV3P4yoP18b6h6fWLKjReB7pQ=;
        b=QHV+AA2jqm2Xt3VklSL6soiUStVJlv6sJlzGVldo4Y+B6eEvgAb10Dnf1ux737oNLc
         +hzTlOEvUwJxIvcoyuiaWk2JqMg6CK6BzFoI57wyngJxnuARrawixzNfzga8dKqXjLH1
         x58suh/P+IvcEpycKAqxQyZCpofFO3UD4H77k+mPUQWJUbd8EUWByEHWkVWG/RAGuMt9
         c2Ljvx5lraQbW3OTohLVHroEoXGPSiXVpTw1yWgoyyQdXWW3gZibPhf3xO4deULJpFKf
         LthzEsy8sWkvJvPxyqe0V3I4jvV/Ct8eTilaP06cxfkGxMB7HhejXKvfmLell7iIEdD3
         VOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850850; x=1727455650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Grd6/QarEoX1VDGP2KnV3P4yoP18b6h6fWLKjReB7pQ=;
        b=jkR1gZIPFsOiKTgupnCDanqKQhioe8twhgQ1QH1SnHflZzbJIYwo09i/P22oylogNJ
         r/Xc3Mrw+vixVqIoif6WOmGAGv58tpqg7Us48NViDC/4lJslJCVDK72WLGGchzsVl2uw
         Ub8DF28cUGNl7g5k0q41ZczXUzVtI+AxiJG4TlCDxxjxvlmGAenM8A36lNhY+hwk7mL2
         QgKYUXBotLhxvLGoc8AawUjd+u66V3DTPy94b8bV71Yw1SUwNphfwJcMMuDGs+/abZYV
         IVK/Anwl1P5fgFpO1+Yki1mtwpAkhrvfstYf430hYkSGRQkKOuAyX3vpjdaNxGWTl2ei
         1iEg==
X-Gm-Message-State: AOJu0YwKhOuW1svyGmgJShfYwEs2BhlqrpxYDdwwJk4EzgboY98hgB7b
	08YaKZNe/sGcPfTNwsvEb/YKCBi9GnrucXNcTB1uRaFTLjUZeS9XdRj8TxwfqpI=
X-Google-Smtp-Source: AGHT+IG8T/Uxxp3O3XxMqRJvOjGpV7ESRsDjpxKRPa7+9h85Ch4V4TUG0cezV+sC11zAQjuSit0j4w==
X-Received: by 2002:a05:6000:186c:b0:368:5bb4:169b with SMTP id ffacd0b85a97d-37a43128c93mr2271652f8f.4.1726850849724;
        Fri, 20 Sep 2024 09:47:29 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8e69:83a7:a29a:ba83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e7804476sm18172250f8f.90.2024.09.20.09.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:47:29 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 20 Sep 2024 18:47:04 +0200
Subject: [PATCH 3/5] hwmon: (pmbus/core) allow drivers to override
 WRITE_PROTECT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-pmbus-wp-v1-3-d679ef31c483@baylibre.com>
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
In-Reply-To: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=7Gd97J5FZJ8x51YDJ0TveVRB+r/ZL3dVmW0gShb0mFQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm7acaXTvdJKP2FMN9pQ4umDAkwEokdT5Fn2ljm
 LQ7DUrb6xaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZu2nGgAKCRDm/A8cN/La
 haMxD/9QfNw3IwRMsafMz8ch2EJPLc14eq+igVnicuHhSAD2mgJovVwOh6Gk4aOLqCpyMmEBh64
 uoCpwQFDtcKN30sKNarIugge8PvQUQDgXrXQs2Do5QaZx4pYRpviK60KyiTY/yWQOd7iUESYGVo
 xgC3Nl7g+n4PUVlMyjlrrxQTWMky97X2AufoH4/3SdL85E60vOcmbaxb/1CNQnhtTe00Aw8Jxhg
 PC1X832P8pBeHzg6OfoT8poveY6i+fGd8p1dFCXK1gsfHHjRfOSN/mkI02zYNUZRw4ZnLzO1A6l
 AOENu885QxuDVFluRzVFdKsJ7Qph/eyvoiwezXrU3DdFc0WU8YEabOap269ObbADlg/lhQX8F7D
 t9Dgjaj6Ns5tEPaQfXXX8IH/VKy8su5qeYqrU5DGTy6TaFGK3QLCG9u8xZpY1gO1HBPCGjLSGkr
 o1PnicrBJdEwQ2ricOIiyLPGCS0Gbsppq7Of/MGLvvjBLHHiC5sntuSXsvVkm3G3ZoPAps6FhxH
 buhBG2LeT248LMNAUh44JMRcCXKJN8NDTfjNoKqLiQacewAlim/nqmj2RbSWx8ZNL2/US9IKCzT
 uqIsgcDcS5Y1Bzr/8gA9dguykUNuah9qs5PHt3z7l6zhQWZBFVcSr45gOSO25VaZyddRc3JEit+
 3cD2ojqjflq/7yw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Use _pmbus_read_byte_data() rather than calling smbus directly to check
the write protection status. This give a chance to device implementing
write protection differently to report back on the actual write protection
status.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 0ea6fe7eb17c..82522fc9090a 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2712,9 +2712,7 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	 * limit registers need to be disabled.
 	 */
 	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
-		pmbus_wait(client);
-		ret = i2c_smbus_read_byte_data(client, PMBUS_WRITE_PROTECT);
-		pmbus_update_ts(client, false);
+		ret = _pmbus_read_byte_data(client, 0xff, PMBUS_WRITE_PROTECT);
 
 		if (ret > 0 && (ret & PB_WP_ANY))
 			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;

-- 
2.45.2



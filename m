Return-Path: <linux-kernel+bounces-242915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E419928ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB937283A83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224314534C;
	Fri,  5 Jul 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzOvqLMl"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F213A26F;
	Fri,  5 Jul 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215354; cv=none; b=oNg2bw0WjM62FJF1fj5WezpmdysrDZnFQYsLxz00Y8m0GFEM4rHY4d4xe4SySoGEFenVTvJ8CaaG6WlAN6fPZt8holhizw3JGiwU9HKwtpIIM/3YnfEI80lZSEoDITKET6W59skxFCNNUSIOTEVNWCSYPmZi5mLsxZsLv3fSUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215354; c=relaxed/simple;
	bh=Um1h6EoS/sb6kyAPI51bGstSuv9tRS/e4iekDFg154Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V9Y5QUEHuPw+fhFMUk1NipOfPu/rpqy9ShGg92PdhuwUIgNIgXTWrk6CoRAVeIAbKd8pC//Jdzu2fquTns5JvRfvMK9NPhR8gGJz3qMgcx9zQRlfb9Fa2c5CZweC5gpnWYmEbAuiQadmfQekKOXCXLuMUK/84yDh2QTIeHC1bwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzOvqLMl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b05260c39so1259074b3a.0;
        Fri, 05 Jul 2024 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215352; x=1720820152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=huiDgYX7n2q2oAeLwVpk0wvSvb2Dq0R+9xq4JPm30eM=;
        b=QzOvqLMlqybGFIP8Id5uU1BL0NLA8tuWrSPs2n1G+tZNOE3aWQnDR8stM0HjKCFseo
         2A+Eo6IPoYlVNmHtLZQ4uxUL2Q6YAo5gpHWIW62wSIqF6MvUezW6hOGwYUCgo2rQ9A5I
         SRyDuzV9rGi2SxI+3a1nJuLKAw/43877xdpFgu7OC53F/jxWn97pzLA/fHdtmDMCPyeE
         cNYc/CLitxh3vaZn4lWr6NNS514Bkg3/7DV3ERFAHP0pfLBWEa412xX9CfWZ6EiTTTuD
         g/aBX0L2nCTI1sttG/59MSaNc+d81FTpvhuZ72Fw7vcZafJIKQZcmobuzCPz0cAfmECC
         ut6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215352; x=1720820152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huiDgYX7n2q2oAeLwVpk0wvSvb2Dq0R+9xq4JPm30eM=;
        b=HlhKpDpnLDZ10mm1cgXPaa7PytjnSguxI06IAhLUcGxJfrQBi547yWkQxbs+L2PXYq
         hbhvOSb1qTTf4ZN4FAWZsLF3gGfJpqGqVachO8E2Pjl9qMPLTdLKzSTuKXHOPsG4ZAkZ
         Uvbn+QNnOOYjGFrxmi/D3WMPUPIVc4XjN3tXsW61T/Q2YqWiK2IhTshS6xO2jlLhkeUt
         8zmtvR17WaLvGdQyfSV7RbJxDMp6DmfuvgORDQ/MMylM484/oosjzZmELAK4ARIXc9s5
         c93a5CDJ6UHF4n/KXYLSnr0xYaU0Bb2mba4H7OsrjZ99/9azij0A2oSEx6F/xGNkdVQN
         IqtA==
X-Gm-Message-State: AOJu0Yy2DPxhDTX6lAYu/HURVRaOMPqYlATJmFIkpb4vy+7fPjLC4MoS
	a0YnjaQ5mAl+irDzpq+s7/hwAko84w8hJgMnMp3Lv0V9cZfOpi+t8uidJQ==
X-Google-Smtp-Source: AGHT+IEtGgaGA7N904KiAd92aiM9pBCk9d0DknOSi5axFLxbIBKucA4YYAJwKTu4qbEoh725fH9pRw==
X-Received: by 2002:aa7:88d3:0:b0:702:6dc7:2368 with SMTP id d2e1a72fcca58-70b009569fdmr4583337b3a.12.1720215351709;
        Fri, 05 Jul 2024 14:35:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802667c59sm14482253b3a.86.2024.07.05.14.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:35:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 00/11] hwmon: (amc6821) Various improvements
Date: Fri,  5 Jul 2024 14:35:36 -0700
Message-Id: <20240705213547.1155690-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup and modernize the amc2821 driver.

Summary of changes:

- Stop accepting invalid pwm values.
- Improve consistency of reading vs. writing fan speed limits
- Rename fan1_div to fan1_pulses
- Add support for fan1_target and pwm1_enable mode 4
- Reorder include files, drop unnecessary ones
- Use tabs for column alignment in defines
- Use BIT() and GENMASK()
- Drop unnecessary enum chips
- Convert to use regmap
- Convert to with_info API
- Add support for pwm1_mode attribute

v4:
- Added Quentin's Reviewed-by: tag to patch 11/11
- Various improvements in regmap conversion see patch 9/11 for details
- Fixed subject of two patches

v3:
- Added Quentin's Reviewed-by: tag to several patches
- Change valid range of pwm1_auto_point2_pwm from [0..254] to
  [0, 255]
- Various improvements of regmap conversion
- Fix register when writing pwm1_mode

v2:
- Use kstrtou8() instead of kstrtol() where possible
- Limit range of pwm1_auto_point_pwm to 0..254 in patch 1
  instead of limiting it later, and do not accept invalid
  values for the attribute
- Do not accept negative fan speed values
- Display fan speed and speed limit as 0 if register value is 0
  (instead of 6000000), as in original code
- Only permit writing 0 (unlimited) for the maximum fan speed
- Add Reviewed-by: tags where given
- Fix definition of AMC6821_CONF1_FDRC1 in patch 7/10
- Use sign_extend32() instead of odd type cast
- Drop remaining spurious debug message in patch 9 instead of patch 10
- Add missing "select REGMAP_I2C" to Kconfig
- Change misleading variable name from 'mask' to 'mode'
- Use sysfs_emit instead of sprintf everywhere
- Add support for pwm1_mode attribute

----------------------------------------------------------------
Guenter Roeck (11):
      hwmon: (amc6821) Stop accepting invalid pwm values
      hwmon: (amc6821) Make reading and writing fan speed limits consistent
      hwmon: (amc6821) Rename fan1_div to fan1_pulses
      hwmon: (amc6821) Add support for fan1_target and pwm1_enable mode 4
      hwmon: (amc6821) Reorder include files, drop unnecessary ones
      hwmon: (amc6821) Use tabs for column alignment in defines
      hwmon: (amc6821) Use BIT() and GENMASK()
      hwmon: (amc6821) Drop unnecessary enum chips
      hwmon: (amc6821) Convert to use regmap
      hwmon: (amc6821) Convert to with_info API
      hwmon: (amc6821) Add support for pwm1_mode attribute

 Documentation/hwmon/amc6821.rst |    7 +-
 drivers/hwmon/Kconfig           |    1 +
 drivers/hwmon/amc6821.c         | 1401 ++++++++++++++++++++-------------------
 3 files changed, 708 insertions(+), 701 deletions(-)


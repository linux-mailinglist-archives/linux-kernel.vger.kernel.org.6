Return-Path: <linux-kernel+bounces-241559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D43927C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B3E1F23E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FB012FB2A;
	Thu,  4 Jul 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cURdBc4R"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294191CA84;
	Thu,  4 Jul 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115534; cv=none; b=G5jSPCyL5luMQ/uVlq8Zeor53Zlgbytxeb+t2XUodc9D0KZREzaEbTFC8HTuKovotUiB+iEqdo+kv8uGJWCtE8sjqlYyN0UclcBVJDMHKGNp1tzU7YlGKLCYQaWlaeDoC44YiXJIVSXZdgvCo6PaOKtFOe3O+WmqxtiymE7Ms8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115534; c=relaxed/simple;
	bh=MPlzKn8LQaloIqKH0vOZYNgzw+y6z5h96pfHKApLed4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8TOOc+YSNjgQ1PDfEiqnOuYTMX2r+kmquI/FZEqOM0fKjHHzYzC7qVWV69dyxGR+FaYUqA43rNavKrDiSzQ8Nmxf4dzBzc+gdnBkSkqODa1vyYtB6YWp9Gk1VdwUL4ZCdZVV1P5iIIZRQ76DG4oHE4yu6mCL4V8ixB7AQ1+43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cURdBc4R; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso604108b3a.1;
        Thu, 04 Jul 2024 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115532; x=1720720332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NtrrSZypYs1CyqM4iNs9UXbujPTrvmx18xlWUh5nx/M=;
        b=cURdBc4RRoL8QTOp0rTMSyyoOqXwF21Vv561LlsLEZvtHDvQsmxQ41NQqkMJlCIuNu
         kUe9o3PfYBPve+oeJ/YLLDp0S0tMOd/rXF/s3PT1mB6Ske4h1Bwc7qm1U7R783gqR9zN
         LU1dd7+/tdfNY87qxTQQ0haycxi2ZUGcPNPVi1zFrkaeTpnhVsWtf+0RQxZa9l4QnHCa
         dzh+REpZZRHWAbbSrirgC1M+7JGNzyiRQb+giPrBZ0VvGHyCtkqoYQwXMWrAJfVma2w/
         uFOLSbF1j/BrJ0s/oCe5vmfeA9TkTCqC+2SnXAuOv4VFaM4lJg+xbUR//Ufr4l47/5wZ
         c5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115532; x=1720720332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtrrSZypYs1CyqM4iNs9UXbujPTrvmx18xlWUh5nx/M=;
        b=nDQp86XNJYzPbUNYN67kQZRqgFTkZNIw5BacNTtH8JI5PApuha/8JmvhMMf7zxXqW1
         cwGhdDVVgcLnMeT5jfrqHoWv53U8dXlsnCWAIBKn0bULvGrbvZERJjoDN/n81O/GUjH7
         thgfIvqerCb4DKblw2oZ81Z5IQmHFgpL5kt+tOwoOAWXa10s+/BQF3SXtkCwSQGAPYPR
         TG76u703AncSz39o5o/xONkxrGnkVOBBzRIROYr1Qi+5XzQDPOLf5NGH9li2TSfvdTK1
         1E1+h4imYYMgPL1vkdbbW/sYD2u8RvLX9nvv4YuzrQdX7qfARWlxYw3sMgMyAWwcryN2
         /prA==
X-Gm-Message-State: AOJu0YzROkuAzuo3xSRx+/zckr6S/07gSykigLzU6J19OqnwWhmuV0oZ
	2asCCA3dBAnkZq7LcQCZV6N2IFeJGEQif10mM52okSG04TI7uc20S9KZfQ==
X-Google-Smtp-Source: AGHT+IF4TQxUwLONbC9aX/TBBuxtDqKWbXCIABRUQpIx7AerstdNrQL7V8a72o7FUBO5Vim6L8lDlw==
X-Received: by 2002:a05:6a00:4211:b0:70a:ffc2:ab with SMTP id d2e1a72fcca58-70b00ac9bafmr2885977b3a.26.1720115531887;
        Thu, 04 Jul 2024 10:52:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53b47sm12530683b3a.37.2024.07.04.10.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 00/11] hwmon: (amc6821) Various improvements
Date: Thu,  4 Jul 2024 10:51:56 -0700
Message-Id: <20240704175207.2684012-1-linux@roeck-us.net>
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
      hwmon: (amc2821) Reorder include files, drop unnecessary ones
      hwmon: (amc6821) Use tabs for column alignment in defines
      hwmon: (amc2821) Use BIT() and GENMASK()
      hwmon: (amc6821) Drop unnecessary enum chips
      hwmon: (amc6821) Convert to use regmap
      hwmon: (amc6821) Convert to with_info API
      hwmon: (amc6821) Add support for pwm1_mode attribute

 Documentation/hwmon/amc6821.rst |    7 +-
 drivers/hwmon/Kconfig           |    1 +
 drivers/hwmon/amc6821.c         | 1393 +++++++++++++++++++--------------------
 3 files changed, 701 insertions(+), 700 deletions(-)


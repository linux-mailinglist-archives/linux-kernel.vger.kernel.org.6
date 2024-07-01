Return-Path: <linux-kernel+bounces-237037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA06F91EA2D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDCC1F21E08
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28884171650;
	Mon,  1 Jul 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlsNkGzA"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFCE2BB05;
	Mon,  1 Jul 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869033; cv=none; b=LtDh7MeZH6zlvveBBNssl6/CGiDa6lgclUmzQ08cTZT3alBM7z73RnSHmVrwaj+kgVPXBxo/0qI8C85HiQ57OZDbivR8VAAcZ+y1E71vom0SzSPSHgVA1zHb+Yu9abFpN1YU28Ppqvvvd6lGAvkWSvNY6RrApoFUiJ/feF2Mn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869033; c=relaxed/simple;
	bh=H+rUQIsO4Lgspk1496Ri56p+Z9yKmCOr7BIqn5dCCYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=afn2Kcku0Arnjvv6fU7AQDSRK0mkTcFM/PTAarBqZ2ijUu/pit0lE3+o4HPT/Muc6I+4ESnQsOweolbUBEhVLkbx5FiFxh/XFavb0bF0u6EtYuj8mXGl6CVRZCWW1V5SkZOUzEmtKoL21PzU70CK0L6XP61ZuiUKik/Vc2lZDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlsNkGzA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7276dff62b6so3361390a12.1;
        Mon, 01 Jul 2024 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869031; x=1720473831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/v6jMs5gyZcdGAsHJZe9WLKjW5PwFGb2qUIwpOLFMzQ=;
        b=dlsNkGzAykd3wxKxE9C8zn6wlmkgZVzenU0KIkYpprSWfLJfvw3+l2aO9Or1sIZ+mC
         zg0KKfD0YELo1Ub/WnQVbs48DAiKlUlxST67zwRbhzca8Zm32JfaBWtLqY0XHzvv65Cn
         Nur2I9tN0dgUcXEwr6aNx9VCJ7xGYKCeBaVZe6GHzQUv260Fa5v3nacBdrZx6ByeECO5
         foqJQ6OyQqIm4LGxCh//hpqqGobUbn9JjDLyG/p544UcCd0nEKOYYtYYMHYa1+NfCUxt
         tbiryEFpzGQS1MYVAtZ8ke1DVbazJOJ+NirOOjXFWXU6BlpOeaMSUf8IB71Fzgd3JNk7
         CSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869031; x=1720473831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v6jMs5gyZcdGAsHJZe9WLKjW5PwFGb2qUIwpOLFMzQ=;
        b=h6Lipk1w4w423V89FSjMCGuu0LudT3CIjebx5q9mQ3YT/6fJG59Kme3HkBiCTLd7Qh
         zbbK0wjUenrpnNL8BqbsEipdPi3BRG+fSyxpiHAX/zd+0dPALPmkaBYdPeL0ly65ufTW
         6on/KjJQW4UssiQP0lLwIJtZIx0kdvVPNsW1xt1jZGeXQjXubg6Ibd5fw1e/fZCsF7z/
         tnpcrGQM46YAXXJRbdO9hlemgztAugsAMC0lCVFNeLTlIVgx+9YaYsGO78QEusmOi/Yf
         iCmx0CU49Kv+izHGa27/cijWJzb56tSNbGk7bY2rXecVJbxdqWElsy4RY0wpuRfduDsh
         gFxQ==
X-Gm-Message-State: AOJu0YxLWSwDdLCG3CA4+69bYLl9UI6lEVPtm621n0x33rGUqv3SFC4V
	Rh2XTWFsBnA2+0cy5iWKcuWSdsChJNE+VWQHpOTw6vof6GTBWdZrTnR76Q==
X-Google-Smtp-Source: AGHT+IFEwl41GJhgfrrfopeh7ozSCnbNt9tAUIgJHxHFzK9oYIXhaA6hUQAxL5tWuoNnMy41MQIMrg==
X-Received: by 2002:a17:90a:885:b0:2c8:4250:66a7 with SMTP id 98e67ed59e1d1-2c93d1874b6mr10313989a91.1.1719869030668;
        Mon, 01 Jul 2024 14:23:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc718sm7295286a91.35.2024.07.01.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:23:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 00/11] hwmon: (amc6821) Various improvements
Date: Mon,  1 Jul 2024 14:23:37 -0700
Message-Id: <20240701212348.1670617-1-linux@roeck-us.net>
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
 drivers/hwmon/amc6821.c         | 1299 ++++++++++++++++++++-------------------
 3 files changed, 660 insertions(+), 647 deletions(-)


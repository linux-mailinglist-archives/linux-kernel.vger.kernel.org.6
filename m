Return-Path: <linux-kernel+bounces-234097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20391C235
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE652843D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D041C2325;
	Fri, 28 Jun 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9d8NgwA"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8D1BF336;
	Fri, 28 Jun 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587635; cv=none; b=IHT/aM3U8QlwzMh2FbNtT6EBrnbYHRr2+HGmetHHq3cxzU1tGnrAQdmsRxZqbdwGPgm1dlNoFS2W7RqoLJSigfR+8qiRmUxJ68c6uXXntiO2Otjhl+V1a6RQQCnuefjgSG/Cflho+5HlFDXaTntSXJ5H85CguN4j3O1pU8KA78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587635; c=relaxed/simple;
	bh=Bn9wFoY+K4SBlEW9VptaYwq5I8Npgeu6aAM0p3k9DEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/l4G7e5UqCZoobx0rDmD0Rjshf8/p308LRP4BLi44kLr5fR0xQNl9MV+COdrG+4HF18yqD8F/a0ol/rOZa2juut+APyqcYZ9FUAe9ria0aySLrx86Wy7Kr0rQnn5Xefru+xen3eHimQZZZ0X+71tTpio8cyxM3x5CXhsAjVFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9d8NgwA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f65a3abd01so4908335ad.3;
        Fri, 28 Jun 2024 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587632; x=1720192432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2UKkEfndHw0cju57r4QhAv4dcQ6vK95nAyDEP/ss9lE=;
        b=M9d8NgwA5Lbea8vdQSG8HJtRMgmCTjLgVNgRK6DE24vKlencfeKNqAZZPKHsnjYRZZ
         ab+VkPSPtXnovqtTxkCytOZ3Rypohb9H/i2pYczVyhJ7A4JNSRDcA8ETTSjh988cNlcJ
         E6bwGFtfsdAbk8S1i21zu41iq4sGl31BRX8eqIHrti9Sz1ZqG5s+8lBuRMgk9zvNwxze
         dt2r1DjC2KsNr4T/t7diWtfHJRFpjAq6kWb+bhqBxjh7Fyzdu+BXOwvafYFyrh/9egBt
         TJq8a5XW6HmXSNaGYN31uvlXL1GURRPVY2gDT3BZu9HHjsD1k8ROsOnWbr8lpOkjk3AC
         TplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587632; x=1720192432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UKkEfndHw0cju57r4QhAv4dcQ6vK95nAyDEP/ss9lE=;
        b=LaN6ZKqHPcZ5PTlNmeTTs0ObwtP0c73mOHqSAn4BTEef1mhaajyTfT5rzrN2bBWZDw
         fJnfT6IEgfsGz0Oz3O3wSumIeKWa61imnjHXPuQ+lZSaY37A2MIE6ApX6nHSIftrUvV7
         q35VOcVTga9/QwyyvFJrXTgx+7qu0OBUfWGLn29NkUxnXcJ6RFLhwHWATRGvo9ZEllKc
         NmtnkRqYc0U1KbOjOq6te7gJosoQ+ADdny/0NSA6S0OY64ilOrUMAjuAUJO4fA13+gmz
         9jOhAJiEtjmzr2FpLHZ+dv2W6p0Roi0wlJHg/hnibasgSew7dkliC0LZGCnJ9nGeiNtz
         TiGA==
X-Gm-Message-State: AOJu0YyUjRSBqGNN86ovI/lrLjuf3Zr6H2oBIGwlAkKZK1qWvCRqBU80
	OAQpaQrj0Yz96q64RrP/Wlb+DrTlLqvuDpBz4Za4XfJCETnMwqzQ/mv1rQ==
X-Google-Smtp-Source: AGHT+IHa3h13sFfxa7kCPB5lVSym9S/2b9mtOdAuYRn2R5SPZj9xkqtZdG3JGHIBVmuSEc/hSz0Dtg==
X-Received: by 2002:a17:903:18d:b0:1fa:1d37:700b with SMTP id d9443c01a7336-1fa23f155damr213775005ad.45.1719587632593;
        Fri, 28 Jun 2024 08:13:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15698cbsm16422095ad.232.2024.06.28.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:13:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/10] hwmon: (amc6821) Various improvements
Date: Fri, 28 Jun 2024 08:13:36 -0700
Message-Id: <20240628151346.1152838-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup and modernize the amc2821 driver.

Changes introducing or modifying functionality:
- Stop accepting invalid pwm values.
- Improve consistency of reading vs. writing fan speed limits
- Rename fan1_div to fan1_pulses
- Add support for fan1_target and a new pwm1_enable mode 4

Non-functional changes:
- Reorder include files, drop unnecessary ones
- Use tabs for column alignment in defines
- Use BIT() and GENMASK()
- Drop unnecessary enum chips
- Convert to use regmap
- Convert to with_info API

The series was tested with module test scripts at
git@github.com:groeck/module-tests.git.

----------------------------------------------------------------
Guenter Roeck (10):
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

 Documentation/hwmon/amc6821.rst |    6 +-
 drivers/hwmon/Kconfig           |    1 +
 drivers/hwmon/amc6821.c         | 1274 +++++++++++++++++++--------------------
 3 files changed, 637 insertions(+), 644 deletions(-)


Return-Path: <linux-kernel+bounces-259222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765309392DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFACFB21D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698A16F0C3;
	Mon, 22 Jul 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="vNC9pcRZ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856016DEC2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667531; cv=none; b=mLBAONDDmPEFtaugFxYt7Jdv51C6KZFt+OWNoVHKJ96vsvzhS3ygxtQnDqbHQY0B8z3s1nQqxq8eMouVFasz8OJu3ulbUnvD3LZqPzrPMfifwFMGpdNTJyfBX6+50iPFEBpoZV1GmDVdRdMlGBVRXRF+UjMo4hfWyfUaX3Mfguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667531; c=relaxed/simple;
	bh=Pldh2YdPCKMdFnEm7uPWxH/lJC04PWUmObLzIB+oSSk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n9VA0j17PXGd1ARhN3Hbc/6tKi2iZadCN0iPY0jRdLWa+tlCO46FI3lbEvSLKTN5D3/zTb7AX13ap3QK4Bh+EPnFDbQHQ16yuYKAEYH535k/KIAXSGokZrjjAketDYvFIBRyqVudB9RRppzoxmj1Av3rgsiNE8etARnwHfDesMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=vNC9pcRZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3685a564bafso2127398f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1721667527; x=1722272327; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O589wWZR55n5iDgMuaErQulUGRAF2YuirgEGQVRDm0Q=;
        b=vNC9pcRZLNJ2ImD/coAYya3LdgKYiVRQFdSw17pwnn12s/po7JQwywc2IGkdhu3+0V
         4mmmZjpUfux/uCDWHqnwWI3mpwq01qWXNl3idtZy/d0lOVw6BOjgAMVg58jTq5GcuAkC
         Qflr5AMMSocTy7J0r4RgTUdwYo7PtZwV8epB7/1aqG24L3WPRP98pkvL32QbmWrnbhTw
         l2t/6leZg+XSyq/u8vAoVYMvHSy2iwkEI3/stYb6HDZRmwcPpXEDm5SUfEbEIt995o7I
         WM2J63wU3Xzc8p2O1xIFSmGR3LyjYyTK9VAehmaLtEV8iPJBIsFLamdQnY2gsVX1y12+
         /bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721667527; x=1722272327;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O589wWZR55n5iDgMuaErQulUGRAF2YuirgEGQVRDm0Q=;
        b=pIZLG4YHXPKN3bK7CtE6P7Q8vxABISZ3dP1rSxkhLaruZ0M5o4BVZ6TibQT57dFJe6
         edgPbiheqf2w7zCtykVbnS+uksmu9af+93LXfILIu/P4l0XkxCH1ZzkD5hmJFQvqcOOA
         1hVRiFFIzBJbgW7NukRlGOFmLYWjrwFvL+RwRL0+3EYn8A4UpXgCp3vuK6l6+tiYiExQ
         me/tYYxU2dnNr3ThVb9xKguRQ3n3ir6XgzBKPppGcJ4Bm0LJR2sgnhklDZPuKMaUns2I
         2JBwT+SPOC6pAPV+2Ve0R89FGttQky7r/zqYTYnj0g2TDH/VRZSbPMOlaPIaRuXlkzzP
         L5SA==
X-Forwarded-Encrypted: i=1; AJvYcCWukJGngfwFBhvgzkeEbKuL9CoQ7OmMKw2xkwXgGdt1O1rTQYqDgWqtYuvyuc4ajK66uH0KfLZZPhajAWibkCexlXvjlwI1XL1A0Yro
X-Gm-Message-State: AOJu0YzeotEqgeInDZNc9VWxMMrk+DOc23fGk0iuU4M3slarhDsfWA8j
	EvjT+8awz5VIaJ+jDDA+J0X1EW4iLnqAkol43PCaPa0D33NQBfA3Rk01FIysRiU=
X-Google-Smtp-Source: AGHT+IHvTR6/vP+CYDv+pp0DtVn86BFTMZTdXQj9wfd4sR3FPkhSCyMZLrvX/pjME3Fn+++eT/MxkQ==
X-Received: by 2002:a5d:64ea:0:b0:368:4634:c419 with SMTP id ffacd0b85a97d-369bb2df0acmr5769512f8f.58.1721667527448;
        Mon, 22 Jul 2024 09:58:47 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm161660055e9.33.2024.07.22.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 09:58:47 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Subject: [PATCH v5 0/2] iio: humidity: Add support for ENS210 sensor family
Date: Mon, 22 Jul 2024 17:58:41 +0100
Message-Id: <20240722-ens21x-v5-0-cda88dce100e@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMGPnmYC/33PQW7DIBAF0KtYrEs0HojtZNV7VFlgMmBUBRLAK
 FHku5faatVF2xX66OvNzJMlio4SOzZPFqm45IKvYf/SMD0pb4m7c80MASX0cODkE7Z3PhjcCzh
 09SVWy9dIxt1X6O205Ui3uXp5+2SjSsR1uFxcPjY52EiWfTYnl3KIj3WDgmt1G9bC17CCHLgSv
 UaEdhhBv+aJbAjnK3k7O7/TYTe/r1oRvwuiCpKEGbVB1ZvxH0H+FL4PLrIKHUhJcqirdOoPYVm
 WD8TFwHtVAQAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721667526; l=3875;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=Pldh2YdPCKMdFnEm7uPWxH/lJC04PWUmObLzIB+oSSk=;
 b=CaJKDR7ykV+WSp8EcHlob8zKsaDEyhNuMSX5ZLjc8cmp0uo4Y55ZYg/JGlfVne7gsWOxA5Vdo
 C7Taf10Ex3MC027k1WpSUywy8Qqg1vaaHmuODnaBjKQeinyDNPI4vFe
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

This patch series adds support for the
ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215 temperature and humidity
sensors.

Patch 1 adds the required device tree bindings.

Patch 2 adds the driver, providing the probe and read functions.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
changelog v4->v5:
- ens210.c: Updated ens210_data description to reflect values
- ens210.c: Updated dev_err to always use i2c device
- ens210.c: Check T_VALID before returning data
- ens210.c: Fix short linewrap on certain lines
- ens210.c: Added unreachable instead of unreachable return
- ens210.c: Fix sparse warnings
- ens210.c: Remove unneeded i2c_device_id
- ens210.c: Remove unneeded i2c_setclientdata()
- ens210.c: Simply return 'dev_err_probe()' instead of raw error code
- ens210.c: Fix dev_info print type

- Link to v4: https://lore.kernel.org/r/20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk
---
changelog v3->v4:
- rename ens21x.c -> ens210.c
- rename sciosense,ens21x.yaml -> sciosense,ens210.yaml
- General: Changed wildcard ens21x to ens210 to avoid wildcards
- Kconfig: added crc7 as a dependency
- Kconfig: remove extra blank lines
- ens210.c: Moved constants to inline
- ens210.c: Created ens210 chip info to handle chip specific conversion
- ens210.c: Added documentation for mutex
- ens210.c: Fixed sparse complaints from kernel bot
- ens210.c: Changed htonl to cpu_to_be32
- ens210.c: Renamed dev_data -> ens210_data
- ens210.c: changed of_match to i2c
- ens210.c: Added return check for i2c write
- ens210.c: Removed switch for conversion check, use chip_info instead
- ens210.c: Removed unnecessary retry loop
- ens210.c: Convert read to u8[3] type
- ens210.c: Ensure 'correct' path is inline, use early returns to break
    for errors
- ens210.c: Changed mutex to scoped_guard
- ens210.c: Changed part id mismatch to dev_info from dev_err and removed
    return
- ens210.c: Moved name from id->name to chip_info
- ens210.c: Changed data field to be chip_info rather than enum
- ens210.c: Formatting fixes (consistent spacing, extra line break at end
    removed)

- Link to v3: https://lore.kernel.org/r/20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk
---
changelog v2->v3:
sciosense,ens21x.yaml: Update yaml to match dt_binding_check

- Link to V1: https://lore.kernel.org/all/20240709-ens21x-v1-2-678521433cdd@thegoodpenguin.co.uk/
- Link to v2: https://lore.kernel.org/r/20240710-ens21x-v2-0-a37c22018b0c@thegoodpenguin.co.uk

Many thanks for the feedback on the driver.
---
changelog v1->v2:
sciosense,ens21x.yaml: Add supply to documentation
sciosense,ens21x.yaml: Add fallback to compatible strings
ens21x.c: Move i2c_device_id next to of_device_id
ens21x.c: Use i2c_of_match_device() instead of of_match_device()

Many thanks for taking the time to review my patch.

Thanks,
Josh

To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

---
Joshua Felmeden (2):
      dt-bindings: iio: humidity: add ENS210 sensor family
      iio: humidity: Add support for ENS210

 .../bindings/iio/humidity/sciosense,ens210.yaml    |  55 ++++
 drivers/iio/humidity/Kconfig                       |  11 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/ens210.c                      | 344 +++++++++++++++++++++
 4 files changed, 411 insertions(+)
---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240709-ens21x-8f2530968f2e

Best regards,
-- 
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>



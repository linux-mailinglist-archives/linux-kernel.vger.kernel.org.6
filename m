Return-Path: <linux-kernel+bounces-440219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371149EBA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB331888EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D4226876;
	Tue, 10 Dec 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M0kdRPgf"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74552214221
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860570; cv=none; b=tYqkfSXWL6QVB1xbWqd1uMDGOH0AziCRVyNzEMwpV39izqtOuxahfNJYhLX4qmZJErSGgo9/VPft/twLEPtOgIcJVzrWFZ6BFX5ou/o3EEixZ75tmCXoSlNfjVL/wsl7ceSIrHDXeYz2RlB3keuFeKHcA6C+0PhI4lsWod0eD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860570; c=relaxed/simple;
	bh=dSTADKTNJvbmRBy+1jUqiB+cNshFUI2ErxE8CtN1esU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b5XGPGu41Mnm29JOsEMEXbr9U5vJe5dBOEQviiGTzwXTHvec1fDYav/awlx6zVlDUW0K3BmeLsKT5+edHZiXNoQthH7/vAKHiEfjfxaCnhb5pg98p1hlPtX53/V2MdcEt9yzY+8paelBgl3gdaDSVvXK1y/2BeYm4m3pA5X6tkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M0kdRPgf; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afde39e360so1143806137.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860567; x=1734465367; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENZnTNWODqxq5GjFCzfA3SG8RDnI3+d9xSrfoOvAAA4=;
        b=M0kdRPgfoTOsR4WkkmfDH3dWadGOprnW6pYIG4n7RCGQ/DA72rSMwpYqOqDh0JN340
         eor8A6pXAPUKSMDGf+V3m9PVjbPvqjYR668Cz7V+gdZgJONQ38RFWv5kF6GGRxU3w6jn
         ybWiH0tg+2G1n1JYEX2mXsaH1FxcNAl4ATzSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860567; x=1734465367;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENZnTNWODqxq5GjFCzfA3SG8RDnI3+d9xSrfoOvAAA4=;
        b=JhisG9LKiTuN16PXiQKB0ua4+ZHRcbckAZKOKS4ebuJm3oXCI3ZT8qnCSnzNvVaJp5
         Nwol3Qk3Unzqkdx2yo5MCOZzwyCsOekIr5htE8MFRto+baxpW2CpEjuo6P1cPoXeyYTA
         xwVlZhbQHId6CtN9HZDB6lfRqaSCCyucrWeOfS6mR+XO51J9SnTe1KZOPWYY8UVxNciY
         kXnqlyl+IOgVwNJu9AHDFE5K+rrdoqxc0ALg/lUfDllLICVWtW4QJ/GfozmVphYuGqiq
         8VogPtSwzf6ya3Rk7IU9ALBGOFBUeVXUJbkzvs4S/V3wAhy2Vi9460kH9dx14L2xpLqb
         jBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrAkHUfP7HDUq0vsP9o7cHWPkQhfmNdlCIoMnVSX9qW8mewJZe7co2FGdptkInhq3Bzl6UPW7tK+tUtaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVmZqxZRZcXSbAj8yjHEsmS46Cby8Jk9GvgnM8zaD2df9dskF
	SCxSUq9g/pnJb2wgaTs1dv093GcvfgN5mb86EgMCsHOM/GK4hJrUOLvmGC6wUA==
X-Gm-Gg: ASbGncuud98jyYCOgFID43VQYYsca2eQGuCZI01iBALJHvajtOWYbpqnvvNhX/Pl6aA
	JeLCFjcasGYqsT52YpL/8tRCfnjUPKk2tG2E03Rz6a0tfmge25mshXxK06WBfwf5qHGhllZ48hV
	2imuqZpXkEqENZP003wKkU9IqxSG73uDZkDzdOt+WVVUwiBuL9Tkatk5OHdZMerT3iQ3Z2jokNJ
	8RVHkXzWS9JcNhFEgs80//CUIlCHExvSHBjTtymj05dDb0zcd2u2rmElquwdDDSsmxKJe5ntw4o
	NHlDkHYA8vvVMFEIbwn1+QknR1rB
X-Google-Smtp-Source: AGHT+IHsmCtT0BD6IrraDycago+v0DRU/6EPtntyLjiexxdvbBR0cbJtcpyVIcAxjR5YjW2IFBWOQw==
X-Received: by 2002:a05:6102:3747:b0:4af:c31d:b4e9 with SMTP id ada2fe7eead31-4b128fedb4cmr851826137.13.1733860567449;
        Tue, 10 Dec 2024 11:56:07 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/7] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Tue, 10 Dec 2024 19:55:57 +0000
Message-Id: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2cWGcC/3WMyw6CMBBFf4V07Rg6lvJY+R/GBdQpzAJKWmk0h
 H+3sNS4PPdxVhHIMwXRZKvwFDmwmxJcTpkwQzv1BPxILDBHJSUiWH4Bzwu0aAmrOq9qrURaz55
 SdZhu98QDh6fz70Mc5Z7+OqIECag0YaFMV5bmagbvRl7Gs/O92DUR/1wRcui6VhdVoam29uu6b
 dsH7g2kedwAAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0

We want to be able to compile_test the ipu6 driver in situations with
!ACPI.

In order to do this we had to add some conditional #ifs, which lead to
false positives on the static analysers.

Let's implement some helpers when !ACPI in the acpi headers to make the
code more easier to maintain.

We can land the first patch of this series ASAP to fix the current
smatch warning.

To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Robert Moore <robert.moore@intel.com>
To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Changes in v3:
- Prefer static inlines to macros (Thanks Rafael).
- Link to v2: https://lore.kernel.org/r/20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org

Changes in v2:
- Add helpers in acpi to avoid conditional compilation
- Link to v1: https://lore.kernel.org/r/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org

---
Ricardo Ribalda (7):
      media: ipu-bridge: Fix warning when !ACPI
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

 drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
 include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
 include/linux/acpi.h                 |  6 ++++++
 3 files changed, 31 insertions(+), 26 deletions(-)
---
base-commit: 6c10d1adae82e1c8da16e7ebd2320e69f20b9d6f
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



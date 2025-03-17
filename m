Return-Path: <linux-kernel+bounces-564392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0399DA65408
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F7618974DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F072459FE;
	Mon, 17 Mar 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1rD8Tiq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8092459DB;
	Mon, 17 Mar 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222613; cv=none; b=FE8m4bTFIZtTPd0zA919AQqtkC4AzQiNOmBf/lTv1FMosndDq+9pzkPF0WbX8xF1fDItNVI+iHM1dUOpESgRkQYr1U0x+izU6HzDlGHAXxr7yeozbxvEqOVggwHWWkXYPPQFqpml8O7QTN7PhylPx0qnqYScYNbLeCBjiOVXgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222613; c=relaxed/simple;
	bh=U/X0J1536P3kLZ5Mre5he1Y2PoLkgKWb2013ybVYwFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKDZIKiPopS4Lu0SIFx1bU0Y4+qObmkyuj3MtOtNeYmGToO1KPfh8ZDcSLsjFxLjhx/ejA889DnXGqLxF/8SIWGQKM8rWR0oa9ADSN6ecWeJz0OucX1sUPszR68nFTBJBq4jid0xh+NmuLFtt6F+8BWVc5EYawgKslZcVbdRyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1rD8Tiq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225477548e1so75688005ad.0;
        Mon, 17 Mar 2025 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222611; x=1742827411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBTZ3P6VJ5gdNk4d//KGnUmMWLLJGp2Otj36JKM4btA=;
        b=h1rD8TiqvgjB6lC3iKqr9EqNClVIr9D4VEKhqabh9tD7iqxXQDhPyl0QSlQNaU9LF2
         0yZARhIql9WKAqLx10gZRlljlhEtZgzO9kKSqcR9W+aRYyHMQ1arxcXAfE7IcH1Q4Npo
         mrQfG2QC6VA17dxeJDLbEvzbUfAyGQvFu9wZKe4lt6knbRurTEsguBGjv/NnXmitXXkV
         qLkN/OX9JgLNCj5XZoz+6UZdeqkFM9xNdvqwyKoYLemJqGVYz8f36BAFGI5fZq3dUY1Z
         4shRj4JOlm+CajegMz92vnxtWT4jhrFo+pQj7lFPGKSZRYeOIp9otBwSgTo0eCes1zMj
         5KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222611; x=1742827411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBTZ3P6VJ5gdNk4d//KGnUmMWLLJGp2Otj36JKM4btA=;
        b=DLsphZKA/F0XESACq8Pup1JBFbWf0TpmB/JfyJZuSutbdFDuLNYcRmUXlFXksXoawq
         xtRFSwpVrlNS+f1ZClU63OPbtlrInQhgRZUxOJaA+1ZLvlKsoSA6hzhNau4d0+ehLIxJ
         uIWzgBOA7MLwbgdGxUgPiFM4sIH1D+zuz3gaWT4Xu06CDyVFSE2U5CwjLDuwOZLHZCns
         KJ9iyT3q32WUC3tZNy3JWOloxyGdHq0QG0beWsh9OFSUXOVlXnx52MuhoMPfS6mbxHyx
         RmFOXMSmjV+HqX9B/6eWrP7+mqfENIAjyork+qosG8R9p1/v4qcUHBC+evKqsn32f/Nk
         BsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWaq1m8XxUPJWWGSvLLFUEGWY1a6vh09oqR0fP1YtWyX4VHVThQwVV2G6moMgpIgaLYedhs6I2vEM=@vger.kernel.org, AJvYcCVqf3eKye4JfdKWdOvlCxBWV0OQgbcZ5QLD4Bpwi8xfL/qh5Gg4Ih9hCYjsFgXfkFQAGWxFipB/L0DIjuEApYtk5ISvDQ==@vger.kernel.org, AJvYcCXapwfk1X4xlV3Y4q2HH7aFCA92gNRQ8LAXQcI3ZYIwVg37a25PPPXEhH2Esy0hbFq6Ny/Y6/Pqaa890b+l@vger.kernel.org
X-Gm-Message-State: AOJu0YzLc0r52vKAOtU5qtZElvAB9y3S16f/m5x1vC1DkoUu8dqm2UzK
	eEUHXr57eeMkVN5INAZRBOM3uVdP6eRbPuxD5h8DxAIHkomT2KAK
X-Gm-Gg: ASbGncvb5Qdp4/L1F8T6VBKlnSw8PFZOBnDapZ84Ic3Ksh3fJDo+l6fecpBclYgufHw
	zZAgHEA6Q/LFpgaPmYNtdg5M61VTEoBEMWe2smkXhDxG6gOlg/sp9rAgMEbFgYTZnWl7hP9iqHQ
	95byrSXjImbTBFm8PqJhXF3M1cyr1esmiHrhyxaim0R1FPJM+6EPUKpWwxCmKduR0ymgKMh40qc
	pFhVL9hZe4RisouyjN/LXlNZs5ApNuT598Ve/XEnL9QUF1oPXQwhRPiGlZ8Mz5vT5gPKBqo5bbU
	toJKDI/pkpasdi+L3hua/trOT0DWcu0wloFBVLI=
X-Google-Smtp-Source: AGHT+IFnSHhw+a+QAV1Ss451PkZuwhG2PMN3QqQFKxxK2F/FeLoLil1nV1kUqyAk00B0nZtB8kxyNA==
X-Received: by 2002:a05:6a00:2e1e:b0:736:362a:6fc8 with SMTP id d2e1a72fcca58-7372240bf61mr11270012b3a.15.1742222611316;
        Mon, 17 Mar 2025 07:43:31 -0700 (PDT)
Received: from terminus.lan1 ([2605:59c8:3484:ea20::914])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e34sm7906797b3a.140.2025.03.17.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:43:30 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>,
	Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Cody T . -H . Chiu" <codyit@gmail.com>,
	John Martens <johnfanv2@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6 RESEND] platform/x86: Add Lenovo Gaming Series WMI Drivers
Date: Mon, 17 Mar 2025 07:43:20 -0700
Message-ID: <20250317144326.5850-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for the Lenovo "Gaming Series" of laptop hardware that use
WMI interfaces that control various power settings. There are multiple WMI
interfaces that work in concert to provide getting and setting values as
well as validation of input. Currently only the "Gamezone", "Other
Mode", and "LENOVO_CAPABILITY_DATA_01" interfaces are implemented, but
I attempted to structure the driver so that adding the "Custom Mode",
"Lighting", and other data block interfaces would be trivial in a later
patches.

This driver is distinct from, but should be considered a replacement for
this patch:
https://lore.kernel.org/all/20241118100503.14228-1-jonmail@163.com/

This driver attempts to standardize the exposed sysfs by mirroring the
asus-armoury driver currently under review. As such, a lot of
inspiration has been drawn from that driver.
https://lore.kernel.org/platform-driver-x86/20250316230724.100165-1-luke@ljones.dev/

The drivers have been tested by me on the Lenovo Legion Go and Legion Go
S.

Suggested-by: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
--- 
v4:
 - Added lenovo-wmi-events driver
 - Added headers for every driver
 - Fixes requested from v3 review
v3:
https://lore.kernel.org/platform-driver-x86/20250225220037.16073-1-derekjohn.clark@gmail.com/
v2:
https://lore.kernel.org/platform-driver-x86/20250102004854.14874-1-derekjohn.clark@gmail.com/
v1:
https://lore.kernel.org/platform-driver-x86/20241217230645.15027-1-derekjohn.clark@gmail.com/

Derek J. Clark (6):
  platform/x86: Add lenovo-wmi-* driver Documentation
  platform/x86: Add lenovo-wmi-helpers
  platform/x86: Add Lenovo WMI Events Driver
  platform/x86: Add Lenovo Capability Data 01 WMI Driver
  platform/x86: Add Lenovo Other Mode WMI Driver
  platform/x86: Add Lenovo Gamezone WMI Driver

 .../wmi/devices/lenovo-wmi-gamezone.rst       | 203 ++++++
 .../wmi/devices/lenovo-wmi-other-method.rst   | 108 +++
 MAINTAINERS                                   |  17 +
 drivers/platform/x86/Kconfig                  |  40 ++
 drivers/platform/x86/Makefile                 |   5 +
 drivers/platform/x86/lenovo-wmi-capdata01.c   | 136 ++++
 drivers/platform/x86/lenovo-wmi-capdata01.h   |  29 +
 drivers/platform/x86/lenovo-wmi-events.c      | 132 ++++
 drivers/platform/x86/lenovo-wmi-events.h      |  21 +
 drivers/platform/x86/lenovo-wmi-gamezone.c    | 380 +++++++++++
 drivers/platform/x86/lenovo-wmi-gamezone.h    |  18 +
 drivers/platform/x86/lenovo-wmi-helpers.c     |  64 ++
 drivers/platform/x86/lenovo-wmi-helpers.h     |  24 +
 drivers/platform/x86/lenovo-wmi-other.c       | 626 ++++++++++++++++++
 drivers/platform/x86/lenovo-wmi-other.h       |  19 +
 15 files changed, 1822 insertions(+)
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.rst
 create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.h
 create mode 100644 drivers/platform/x86/lenovo-wmi-events.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-events.h
 create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.h
 create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.h
 create mode 100644 drivers/platform/x86/lenovo-wmi-other.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-other.h

-- 
2.49.0



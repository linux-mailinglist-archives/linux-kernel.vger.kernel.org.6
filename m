Return-Path: <linux-kernel+bounces-552781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9396A57E0B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1A188BA85
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2578202C44;
	Sat,  8 Mar 2025 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKzelMbM"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A91F94A;
	Sat,  8 Mar 2025 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465428; cv=none; b=BbSqyaT+3Pt9tHBm/dsogmIAccwmRBROU9huA0phcSvwhUqaHaRM+Y7GpdzFN9VzoXnggMwXq2t7j5P08G+bC76caYEXUb1ekcxPnhN8cJuAZktpnbUva/FQXc1vFfcxVDng6f2nu2vUfDzGZZyogN6/M+Vx2REG/Xyw5YdOxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465428; c=relaxed/simple;
	bh=Q6nV3nKrSCi9BXAz+2u8J5JAul6UeQw2Mc95FgxICWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iQ0G5o2EiZ1X1KB7c75CsIYAp3Z3ATt2I41e8IVjYmkwBKvfqHFW/XOhGpkpn+OvjeZHoIh/flg/+u1JsZyN8Nj0caim7dlAv6S9QV25f00cWVUSI0aHzqT9hLt2n8sxLVcskM8Dlk/q5h61luBPQZ4k6HhAe6Nd061fEy1s9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKzelMbM; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86714f41f5bso1244919241.3;
        Sat, 08 Mar 2025 12:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465425; x=1742070225; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDQFGNKi7NrYGCpzczTIm99TkghXnnRgAC/HEvbOf98=;
        b=SKzelMbM3OriaDSf0opl+ZCPHMN5q8Wn5Xe9re8N5IQ9L8eMq/gzSqFawzc3XtnfM7
         3TOF+G1ywvo4sU1hI9Jy4YPUfGXYBKPRBJCNYxxP7q8l0iYjWc3kwzucHCLP3J0ZErLs
         j+2WjNdczUIDl4zQtZoyLzmGNe7qQGbYvX+KNVzQgBAsir4s9YORIknCUagxFOogat2q
         YQClkudDgUVofpiEGwzS+c8+H9R5QflftWJ69kHxIviLiFB2ghvRcCnlHzWERPTHJ52u
         xX9LYfZcRNdLcRFzVKjff2zYGBQU5fk/8TycqlRZrOP5T1KRLoBi9dOKTcnuYqVspSGE
         HMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465425; x=1742070225;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDQFGNKi7NrYGCpzczTIm99TkghXnnRgAC/HEvbOf98=;
        b=Xtx7sN2zDS6xjguOGjT+kyDjRGo5GiaAIiDkfOsI2TIk7ngItCMpnNVlhXP7+Pt/4i
         6Jo60vI6qbu85FvCU/MhLyh++dcJ0Vlx2daT4hsk+jrm1a2mpY9xEg0YdcBy/rmGOoDz
         SqZq1qiYH4hQ45+geXpshWpuBa1jZ43HKqybK4NDibRugUonYO8WjSLZthwHtU8hpIUq
         DDJlrftt/UN3LMrrEFYMSMNSHIirf9+UamVD+QOrkbqI69/iCSZsINwp+sQnNGe2UDZJ
         z6OquuNFWyL67i+o/g/bY10nDOcVygw3pJDSrAnOLmF/dmTBJCT4gRUllJI41xDW5qbV
         wvBA==
X-Forwarded-Encrypted: i=1; AJvYcCVbRbM24OT7H7kNcVcrV8vd8GPuCAxDZvjYcdirJ5oaaOxp2LM84uiACHXkIDNSdNDXO/2x0KSKSGwzHQ==@vger.kernel.org, AJvYcCWFeImLUZW+ZoXgtfnfJ5jza5AaoiD1oTBXm9MeVJ5GCZ1pGTxKB7QC4E7NS3NQSKNTJ4ekUffqi+qj/6igF3sL05pz6A==@vger.kernel.org, AJvYcCWssRIiKvx2OxPWJ1ZTU+ynix/zh7T93lE5qPDKe94MMSU/6itu7mbVX2a+zorM/Plbp8VGPY2Bv8qTWOZB@vger.kernel.org
X-Gm-Message-State: AOJu0YyiojbKOW8D9sWmJZiksD9v8/xC/soPbo6/6SWqZvu+u7+FAk2I
	OTjv5E7BVWMFPwRwm0RBQFSXt/eibbfXl3cdCT8+jPuKaVUAxcBq
X-Gm-Gg: ASbGnctsDVSeP/hTgsWusmAS7LmGxvfjVAE5J4LJWA9IvF6ICkEhAVNHbyLqS6OIl3P
	nfbhqPmv9pzMQTtvPs/3n5tv3DWySTMSK4pUixSXTViF3nTGHmQfwYvitCuNodx9jaaOmRAN6mY
	oLfuwL3lCNqTlqESwfpGDvyTxnRcmJqsJJiSp58RoKpH3erJPn9PtTJVxaEWRGtxulxCisiSFys
	C1W7J0hh8MiaNO1aTktbFhddxSQUIZ1KtY9WiDvivnd0MnzC6rAGx2t7jbAsi6KHOVajDLFq0v1
	7lGBpvgFbF7jBGdh40Q0/vUVc6u93vMV+LXJhv/zal1raQ==
X-Google-Smtp-Source: AGHT+IHSOMQVHgz4mDmX4zUz+H9UhEPWeA+l17Ai1uROYsCtqmkvHcpK0j2VgmZc5nkc4j/CIC47xw==
X-Received: by 2002:a05:6102:15a0:b0:4af:fca2:1b7 with SMTP id ada2fe7eead31-4c30a6038camr5354717137.14.1741465425039;
        Sat, 08 Mar 2025 12:23:45 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:23:44 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v4 00/12] platform/x86: alienware-wmi-wmax: HWMON support +
 DebugFS + Improvements
Date: Sat, 08 Mar 2025 15:23:12 -0500
Message-Id: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCnzGcC/1WOQQ6CMBBFr0K6dkiZ0jS48h6GRYGBNlpqWkAN4
 e4WNupiFi/5//1ZWaRgKbJztrJAi43WjwnKU8Zao8eBwHaJGXKUXHAJ5umgV01XFRXHRiqWko9
 AvX0dlmuduA/ewWQC6W8XUWI6znMUUkgo4DbPYWoug9P2nrfe7SZj4+TD+3hnEbvvf3kRwEFUk
 pQuSq4If+r1tm0fMofM09AAAAA=
X-Change-ID: 20250305-hwm-f7bd91902b57
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
 Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: b4 0.14.2

Hi all,

This set mainly adds hwmon and manual fan control support (patches 7-8)
to the alienware-wmi driver, after some improvements.

I have a question for anyone that may know how to solve it. In version 2
of these series the kernel test robot found a build error

	https://lore.kernel.org/platform-driver-x86/202503051819.bQ9P70Og-lkp@intel.com/

I think this happened because

	CONFIG_ALIENWARE_WMI=y

while

	CONFIG_ACPI_PLATFORM_PROFILE=m
	CONFIG_HWMON=m

How should I Kconfig to avoid this?

Thank you for your feedback :)

---
Changes in v4:

[03/12]
  - Dropped awcc_profile_id_to_pprof because it's no longer used for
    pwm*_enable attributes

[07/12]
  - Dropped pwm*_enable visibility
  - Dropped fan_data->related_temps
  - Allocate fan_data->auto_channels_temp statically
  - Allocate priv->temp_sensors statically
  - Determine and allocate fan label while probing

[08/12]
  - Dropped pwm*_enable attributes because it's incompatible with
    current ABI
  - Renamed pwm*_boost attributes to fan*_boost
  - Added dev_err logs to awcc_hwmon_suspend/resume

[11/12]
  - Introduced laptop documentation

[12/12]
  - Introduced ABI documentation

Link to v3: https://lore.kernel.org/r/20250305-hwm-v3-0-395e7a1407e2@gmail.com

---
Kurt Borja (12):
      platform/x86: alienware-wmi-wmax: Rename thermal related symbols
      platform/x86: alienware-wmi-wmax: Refactor is_awcc_thermal_mode()
      platform/x86: alienware-wmi-wmax: Improve internal AWCC API
      platform/x86: alienware-wmi-wmax: Modify supported_thermal_profiles[]
      platform/x86: alienware-wmi-wmax: Improve platform profile probe
      platform/x86: alienware-wmi-wmax: Add support for the "custom" thermal profile
      platform/x86: alienware-wmi-wmax: Add HWMON support
      platform/x86: alienware-wmi-wmax: Add support for manual fan control
      platform/x86: alienware-wmi-wmax: Add a DebugFS interface
      Documentation: wmi: Improve and update alienware-wmi documentation
      Documentation: admin-guide: laptops: Add documentation for alienware-wmi
      Documentation: ABI: Add sysfs platform and debugfs ABI documentation for alienware-wmi

 Documentation/ABI/testing/debugfs-alienware-wmi    |   44 +
 .../ABI/testing/sysfs-platform-alienware-wmi       |   14 +
 .../admin-guide/laptops/alienware-wmi.rst          |  128 +++
 Documentation/admin-guide/laptops/index.rst        |    1 +
 Documentation/wmi/devices/alienware-wmi.rst        |  383 +++-----
 MAINTAINERS                                        |    3 +
 drivers/platform/x86/dell/Kconfig                  |    1 +
 drivers/platform/x86/dell/alienware-wmi-wmax.c     | 1023 +++++++++++++++++---
 8 files changed, 1187 insertions(+), 410 deletions(-)
---
base-commit: e57eabe2fb044950e6ffdfe01803895043dec0b7
change-id: 20250305-hwm-f7bd91902b57

Best regards,
-- 
 ~ Kurt



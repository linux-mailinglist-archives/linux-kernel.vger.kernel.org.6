Return-Path: <linux-kernel+bounces-548064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E6A53F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB373A8B39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BB73CF58;
	Thu,  6 Mar 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY5qiGSF"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F8B661;
	Thu,  6 Mar 2025 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222684; cv=none; b=IDqNzuQy5kXSHOgcmd5oajrGQBWrIFvMiCZctX9H/mmImXhL02yHTphVb5xK3RM0HgT9YmKSGw31RG+DA39rSEUpVWQaYQYhhZKrZzxuZVtFP9cNoR/DHfF11TpawTmHNRLJmj4CyU7FL+0/VWzoZu/ybIdlJYwgL1nHD7/SOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222684; c=relaxed/simple;
	bh=eB8eSG1TbocKy0JQiONaFVGhHcWbVddkrfDnCPIjZzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u73GPjIf2mZS7MJNEcHOEa4sd/usfaqxp17fKfmxNXR4yi7raw+2+0esKTaHuO/MbiKIw8jjv6tjx19CAmfaSWufN+ILfvcpimv/fauic7ei8feJt9cE+rT9lvEpG6auhs8lP8mk1/vTxY1PLkFgWeII/qv4IosnzNCUWsNwYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY5qiGSF; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86911fd168dso25023241.1;
        Wed, 05 Mar 2025 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222681; x=1741827481; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt9zVJmrd0zt83NyNArDXBsWvSs/QAJzrHKpJ6L5Dqg=;
        b=VY5qiGSF3499M3x9QKIxgpeAOgsh2aF0MiKM/Y2wj5s1vYCEaiNZ1igDF1n7BFeasc
         HNxKs+tfX5CxA6hPerG3zQseWYsOIdNk/cSeVmT5chv0rFoDmim91HrVnKg3zrJtErWv
         bgSwyM9jsxcO69vAA8AdDrRB/OoDUDAIDHMUouIdQ0wvM7SITIL6UIWlfEsF0+EM45Yn
         EQAAr6jwJnaCnPk91JMY9XadMmvNg1oxZuyhmuq6PKo9vTcM9vHKPMHm/jROyfkG8F1M
         ma32/jPEFo3yHBxwHF7gdIHIvt0SAzXDopg84Yx+bbN+ffPEZrlLIhz7WTiLpEm7+I9O
         waqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222681; x=1741827481;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rt9zVJmrd0zt83NyNArDXBsWvSs/QAJzrHKpJ6L5Dqg=;
        b=WN2UquGdvD3es1Ei0dSXfXXIDJBmo/u4ceFbXyezeGYWdNMJ5ps42I8iGWOvFLPU0Q
         WqUmqPfyeKosjMxMc1WVd3/S31ut41GsS4w+EGlHD1caR/AyRQXiko/UWpn1/UOhPny2
         iPWQ6vTZlQem4EqUCioUlll4PeWxmXCalbNO1df7Kv0XpimOGr/8+O9xoBKx5/zEPuk8
         3fY+i/GRU19gZpfa/EAdRPEhc7p5sSiYOfaUC2pA6Fc89CFEdrLGlvUpOOi2CjW+Z7bG
         UMRoHQO4fn92b9LjxXPCE40x4+DyQpV2Ar7Oik59pOGjhc5ODTNOGRZBGdTEUR/5Q2Ce
         9oiw==
X-Forwarded-Encrypted: i=1; AJvYcCU6L4+qro5t4zgjZ4g1pYSgkDh8YkWPnAKvd9Kt1e9hv9JaJLHMSWO8xSMo1MABCRKVkFRR5WAXDQ1kqT180kLOgZMrew==@vger.kernel.org, AJvYcCWAkDrsssdiirZu5wKJMXVQONFEdepijgN5y0d8yF4Rnisrz5OIaIC8GVQJGA8tsG2yTAWeSjBo0UmpmA==@vger.kernel.org, AJvYcCWT/SKkeUjuLTPnaix3Fon5SXE/C3d81wmD7a2g8KWe9wMwke58FMd0elOILGAaDMpBAccHVqMGi0lOh+yw@vger.kernel.org
X-Gm-Message-State: AOJu0YyZA98HPdAK2xH2rUgfhanweyI8lR4T1G4HK1OZ4Ghr68lIsD3a
	sr0sNt99BmD4YBCJj11q2rSnKJQYxOckmWIV8i8e7BbaW+DOcYVOjNUV3HP71BQ=
X-Gm-Gg: ASbGncun8Tnt4uufiSurjBM/kN/4WN6/E2O4hmxrnttBFWjDlK8DEQDVoWUbzneBvSV
	GuIollFplap6V3ZAHYcSUzI10VEY4eeK7xvChcd6i+L/66tnVQ37smt7bUHJm2TlES+JqnlrsJw
	NWXW4bvKC4iwOo8dC57D8IvTo/2vpA5WxcNwU2lSkoh3kPQEJrKAre8g6Kf+P9GNat9q5vW4AwB
	DZ1wNTqJKfnMk0m7NSZfh0Suv0qevQE/t7woTwpu4svs6tbXAEik5W2pGKsFi8Hx+ZtidiEVXrX
	PI2eZjvifQ15kHFMdp84FMMextb07lr6VKBTzacANnEGtg==
X-Google-Smtp-Source: AGHT+IHytYv8KIBRewTELNDa88RTVdiOq5/z/rHHy7vmPg6TTIIRDId6zX8icmmtZFr1++JV800zmA==
X-Received: by 2002:a05:6102:c46:b0:4c1:935a:2446 with SMTP id ada2fe7eead31-4c2e295204cmr3632016137.19.1741222681129;
        Wed, 05 Mar 2025 16:58:01 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:00 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v3 00/10] platform/x86: alienware-wmi-wmax: HWMON support +
 DebugFS + Improvements
Date: Wed, 05 Mar 2025 19:56:51 -0500
Message-Id: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANTyyGcC/0XMwQrCMBAE0F8pezYl3bCUevI/xEPSbpqgaWTTq
 lD67wYvHubwYGZ2KCyRC5ybHYRfscS8VJhTA2Owy8wqTtWAGkkbTSq8k/K9m4Zu0Oioh9p8Cvv
 4+b1cb9VeclJrELb/LSJhjdYtGjKkOnXfNlndZU42PtoxJziOL4NqQpqPAAAA
X-Change-ID: 20250305-hwm-f7bd91902b57
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
X-Mailer: b4 0.14.2

Hi all,

This set mainly adds hwmon and manual fan control support (patches 7-8)
to the alienware-wmi driver, after some improvements.

Aside from some minor changes Ilpo commented on, I added inline helpers
for most awcc operations to make those calls more compact.

Thank you for your feedback :)

---
Changes since v2:

[02/10]
  - Move BIT(8) flag comment to AWCC_RESOURCE_ID_MASK definition

[03/10]
  - Add awcc_profile_id_to_pprof()
  - Add awcc_op_activate_profile()
  - Dropped Armin's rev-by because the patch changed a bit

[05/10]
  - Dropped __packed attribute from system_description

[07/10]
  - Add awcc_op_get_fan_rpm()
  - Add awcc_op_get_temperature()
  - Use ternary conditional operator on awcc_hwmon_is_visible()
  - Check priv->temp_sensors weight to determine hwmon_temp visibility
  - Replace U8_MAX with priv->temp_sensors_size in find_nth_bit() calls
  - Drop find_nth_bit() failure check due to the visibility change
  - Cc+ Jean Delvare <jdelvare@suse.com>
  - Cc+ linux-hwmon@vger.kernel.org

[08/10]
  - Add a pwm1_enable attribute
  - Add awcc_op_get_fan_boost()
  - Add awcc_op_set_fan_boost()
  - Cc+ Jean Delvare <jdelvare@suse.com>
  - Cc+ linux-hwmon@vger.kernel.org

[10/10]
  - Reword commit title to reflect path

v2: https://lore.kernel.org/r/20250225222500.23535-1-kuurtb@gmail.com

---
Kurt Borja (10):
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

 Documentation/wmi/devices/alienware-wmi.rst    |  383 +++-----
 drivers/platform/x86/dell/Kconfig              |    1 +
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 1132 ++++++++++++++++++++----
 3 files changed, 1098 insertions(+), 418 deletions(-)
---
base-commit: 5ad6d62c9b183314ec1c64a95a26636e973e736a
change-id: 20250305-hwm-f7bd91902b57

Best regards,
-- 
  ~ Kurt



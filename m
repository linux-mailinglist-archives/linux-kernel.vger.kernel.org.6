Return-Path: <linux-kernel+bounces-557221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF389A5D54D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DED03B3AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033A1DE3C0;
	Wed, 12 Mar 2025 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeuAe7Z6"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDEE13D539;
	Wed, 12 Mar 2025 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756323; cv=none; b=ZkEsEUSiGiakAqeonRqR6b8vOTliaTgdYoreDlcYA/kxCxNeXrbhRd17rbPZHvsdFFcrcvQTn9V/8+UmbIdecPr1byjHdlhk/MxY5HW9mWZWLCbhZq8LKy1Ko1VzDI8sA+UOqmsxfCTTKC1eC2rZqNRzgO0WUNq5gtu8O0PrlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756323; c=relaxed/simple;
	bh=TKxJVXvEcQ20Zf/l/OzyCNh4G25O67n3Uq5caMMaqS4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iBM6PoUFtHSjj15RP+RMhcu0FHvd0RN2TVc5+jhDQs7hEFlrbI0Gi0nc1DJ5O2Zx2+3nUe9K+ZbF7d8Tih6ua9SU/ogy/SgypQZp6cynivkb8OF6Yb1wX27lHaxPF2RXIal4VjRYWIaQAwpv3FaYZrSoDGydsyydKKLxmnOcHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeuAe7Z6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f768e9be1aso5303607b3.0;
        Tue, 11 Mar 2025 22:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756320; x=1742361120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQXoxy9I8AFuMMeT3LSJZk5RzVXef6n8sY2f893bHPQ=;
        b=DeuAe7Z6/Ups4zVKovaocvJUF6o86Zqh8F/BqrMAVgoV8CvciHHRWkKRNizpHvTVk1
         XGuzRY/Px0ksJhdmg3fe8W7766I26pKqv5L0aZFkjur9GkRwda+c2DYh5OgDKjIJVo3e
         51/iiWHQ5MffKqN7KfK7BCAoU9xbVNYSvLHlmmu4yK/LVbmQ6I7lNs11oLFVk3HRCOc4
         QuRD5xsL8aDjaUD+a0mHEUH/NM14x+z7LeFpYhp9H8T9t0XQjxW7rXcGtDbOxADkf7q8
         XrX+8fOm65LlL3wzZD5i/wdx1UuzOnEMTaFzVmtXPq052b2lCfS2E45w1+jHhovuVovt
         e2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756320; x=1742361120;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQXoxy9I8AFuMMeT3LSJZk5RzVXef6n8sY2f893bHPQ=;
        b=OCDI3zcxmnuYqsXY50jc1SHvXBDfTmiCvvJUzupz0ztAxfwEKpdTBPGF1CkcoGk/EW
         g+qOFNW0rFh4npONtq5ul84kj8liCX9mTZF+un91XlKT4XPDpUZKrnf1xUaUfw0K9W1X
         SrhHG4FrvUJjOsbltKsUyh2QQJIPjG6B23WDrqvRATeVb/nQQySIFEmr/zz1uXA/idmX
         9rRyzCzvcESbyBtIUDPXGnu5S3HaeRPMjc8W2MnPIDpco9/JN0BCPtb6sJ+umQvQOMcI
         P/Fr+z+2bCS/aZOUjNJduIxAlglYw52UVJV5tzL/7ZaVK+LbdfAUjRS1S3oP8d2F/Y9N
         ubSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbrvOfHviXlitQsFzSZuPOpwuBBXsLWpvXgfw3a2+HR7KgT9wQ5q3FfYr68+w3jccspNYW0HG+UiKazg==@vger.kernel.org, AJvYcCXr1bn3eEp2YPcD+Uxgj4aw+mibvSbWOftnDAVBmELfxVdVGNVLsDXAfLWUNZ9wraVsfeEoljv8MOOGtgiI6gxmza5YzQ==@vger.kernel.org, AJvYcCXraPlEEhHxGT6KxfGecX0Z05xgcdtdDTcrJ7YAXquWryYuursIY6AhPIuUPfKuQz7LjAX1I9BqJNdeAr6J@vger.kernel.org
X-Gm-Message-State: AOJu0YyZulqa+O/lEtlJIWob7EYqdP6gnWG8izXN05RK+A31Ca0DucGN
	wElMvd+FeTs0jTYvfSaBLwbKIxcQu0/ptYM//+6jZUOP+eH5AAd/p6C3eyfq
X-Gm-Gg: ASbGncvBL/WPL7Rqpys6l0G8VW+BChY7nRspnHhItVL7aO1JBKPEqna+FxewWCIo3U7
	zSCKYrpK0Fnb3Kbf+7efxo/H4unxWP3s8YO/T0z5i78uHJroPYrPza+67aPqWWaxh9iLb7Mvw9Y
	JwuIs+ArvG94lPXKF1SAWBXX6H/9m0YIqAzLT0JwA5hooyqM6TcX4qlNyESGRykaCnj7+aXJ8aN
	wUtSNwUXlvg8WBEyFxQHPhiAHpB7GuvzeRKVhE+Nq4syVXP4wwo1QhBrS59+wCSQLqrzu96EAbZ
	o0nrIDk+miDdPNWlzmQdbVgmaoRAzexYNjyShwjW6LQSNg==
X-Google-Smtp-Source: AGHT+IEfFdjlark+x+S9dn+EEpCjtvpLg8SRNQFdUcZ+rLf0vG3OFqGDCoq/W3VCArrGuEvMAxQJUw==
X-Received: by 2002:a05:690c:7449:b0:6fd:3153:2010 with SMTP id 00721157ae682-6ff0a2d859dmr77023437b3.7.1741756320560;
        Tue, 11 Mar 2025 22:12:00 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:00 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v5 00/12] platform/x86: alienware-wmi-wmax: HWMON support +
 DebugFS + Improvements
Date: Wed, 12 Mar 2025 00:11:13 -0500
Message-Id: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEX0WcC/1WOyw6CMBBFf4V0bUmZMim48j+MiwJTaLTWlIcaw
 r9bcCEuZnGSe+6dmfUULPXsmMws0GR76+8R8JCwutP3lrhtIjMQgEIK5N3TcaOqpsxKARUqFpO
 PQMa+tpbzJbIJ3vGhC6R/LgBCPCFSkCiRZ/w6jmGoTq3T9pbW3q1Nne0HH97bO5Nc+/6XJ8kFl
 yWS0lkuFMFOX5enfO8UXyePjjY6kzkUUBjcO8uyfABbcVv9BAEAAA==
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

Thank you for your feedback :)

---
Changes in v5:

[08/12]
  - Move HWMON dependency from ALIENWARE_WMI_WMAX to ALIENWARE_WMI. See
    [1] for more info.
  - Rename awcc_alloc_fan_label() to awcc_get_fan_label() and return the
    static string literals directly
  - Use BITS_PER_LONG in priv->auto_channels_temp bitmap_copy()

[11/12]
  - Fix typos

[1] https://lore.kernel.org/platform-driver-x86/20250309-dell-kconfig-fix-v1-1-38a2308d0ac6@gmail.com/

Link to v4: https://lore.kernel.org/r/20250308-hwm-v4-0-afa1342828f5@gmail.com

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
base-commit: f895f2493098b862f1ada0568aba278e49bf05b4
change-id: 20250305-hwm-f7bd91902b57

Best regards,
-- 
 ~ Kurt



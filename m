Return-Path: <linux-kernel+bounces-559693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C693FA5F82C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5E519C4822
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E50268683;
	Thu, 13 Mar 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6JSPvbw"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C926869F;
	Thu, 13 Mar 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876214; cv=none; b=o/emMVDlQ4F16xA33wxN+a3VfUgjTpAGLXiAuD8oNgJWQMeksyqXKmEoBmmegoFsoUryaRvMs46wIEouKCpx1/pFtbmNv189lqh+djaIN9a21Td/F9oT/77spf1CRrA9Xsfe7rsCdJQOPBrEBNy12w9cQknBer3PU1DtUbRWYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876214; c=relaxed/simple;
	bh=1dgoXmXLa76a9uPiZQSwML6oDwDqVRI23Fi875IYGAU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PgC+oYKsQZAPCXIRWE2LYZKs0rQRpU/wlloD+42g0wzblnwWeWQZSvzvYWsHD49gvdbXROEW9Vwt8b5CKrT3LvEscs1PcrRY9E9pXJdyJXFgoxiImhcU4QbVEMNJkmoj8hBRq0hrHFvU+7eLTLTIlIUUxsfFVzIzN9BPqWdjQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6JSPvbw; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso851006276.3;
        Thu, 13 Mar 2025 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876212; x=1742481012; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7S2TQU9dU7E07H/gw4pgOsJhMu0o2qp8wyz0mnc1RTA=;
        b=e6JSPvbwORZJMuf9NC3Y440QC39yi+DhCXwS4P7pUyVU26K+uQnVcKA9h1soiCa6aG
         qQaLa2Dop31qy/CPJ4RNJ39Pia15Da1QPYqUcBFIYH4oaXzK9GvS0QO2nuxvXgfhe+vA
         TffUPgSJnnmbTZnyNpCSKHD+Vh+j9NGgIE10JnImcWYGy+SvtrcQxuthp8qvVJ5wfR9d
         W93cPlyoutglMvrFVKKFRam1ze3Um8A3H4jDx14YoNHYCROFlEqrghOIf9cjbcjYMKan
         WBnzQBpWS5Issjo8MNymsnVALalmUlRfgWXtJBdIi6Fkyvq51i4Z3f0EWg1hYzF1vwcv
         OSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876212; x=1742481012;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7S2TQU9dU7E07H/gw4pgOsJhMu0o2qp8wyz0mnc1RTA=;
        b=C4s17rU1AAzf9oeGrO239LSI3DSt3k/kWf7Yr4BpXw4ax3xjHZy0FBHToBNxrWJXHZ
         NncOLY1IuH/rYVImL3vZSqVk3ZzvU6WiONLqQfT59gO6rEP56FHZfae5VAAMzHH79snk
         yGBW7kdMwa9yAsC2e+BuLF2kJdMV2MMw9n2LLeirxefcr6D5hi+qK4mkTkcmGdV94QOi
         +QODjv859VNg6TZf4gagD4pF2TSOLXpr7XsnGX3a5B1yc7Y4mBakW/eXIbJBkVXwjCaK
         /tm8omc4RVoxdJul1eYhqKUkJaHzDCR3rsjBf64+f5uID3PET4hZFB0OInGed/htwDub
         KHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfFxvXmVFCQC1ydKwJjMGMPQIXIPI1Pk10xwlWBAFjwb1Ojokf7tRwQLQBn5UBv6ncSe8Vxsv6FR9O4MoYn0vQRl5HNg==@vger.kernel.org, AJvYcCWKdEQ66IuDtkKX/g7EvGfx2Wzc8A8RxsFXbl0ltJPE7k+xBv1LRX6iB2CapVlcvrw83JY/hVZJ8Yy8tA==@vger.kernel.org, AJvYcCXzRhpc06pQKyfCzasWWHTLz0b0QDySX3D0n8BELU1m8dTZMfklI4XKxasJoP1ipFY10ftlsyprzee3GF9X@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFvMGQpmxEbRa40mR+E5D9NiCkdbzwC7ifSm52G5/4EThLJXN
	zOLlGEulKC5fL44cfqv5ApXvBpEeiXA7yEdtTaEJaCoHNN9AAkSZ
X-Gm-Gg: ASbGncvTIqOzlcem2kCLu1m1MYVS0GRfzsTIM+UnwdFhWJTkrc45hBw6fsZBzcqUT95
	ZzCU0Xw8bM4qMHtWSPHxrqcPb3sw2uiw9zwQ0/+Ey1yWpD4XkVlqEt8ojD0ZjywwNe0gWZhikqX
	3+AhKNdvTfx6ND3T9zEBp+5B5BatsYurwVuF++k7z1FKimeT1PVe74NXw7/KYldkzN8ud/OjxeU
	kq9lSraoF8X6W0OrJJw8PmfKGy7+1tp2q0+C+bf+bygacT/ffFaMfD2gu9DQ4QGqjagBk4neCjh
	vwhoxUlx3FmdAEl8/oSdePUvHS0WeSYt/7SfvLF5GzmjesNjFhh3TDbL
X-Google-Smtp-Source: AGHT+IHNM1fABknfu5+oQWdRORYyBLb3/SRvGKPRseAqtu72FULiEsidDPgexoQAvEevB2qLCB+4QA==
X-Received: by 2002:a05:6902:2890:b0:e5d:d340:b043 with SMTP id 3f1490d57ef6-e635c1d97damr27139506276.30.1741876211803;
        Thu, 13 Mar 2025 07:30:11 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:11 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v6 00/12] platform/x86: alienware-wmi-wmax: HWMON support +
 DebugFS + Improvements
Date: Thu, 13 Mar 2025 09:29:55 -0500
Message-Id: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPr0mcC/13Oyw6CMBAF0F8xXVvSThkervwP46LAFBoFTHmoI
 fy7BRaii1ncZM6dmVhHzlLHToeJORptZ9vGh+h4YHmlm5K4LXxmIACFEsirZ81NnBWpTAVkGDO
 /+XBk7GttuVx9Nq6teV850l8LgOBHiAAUKuSS34bB9dm5rLW9B3lbL02V7frWvdd3RrX0/V4eF
 RdcpUixlqGICXZ8uTyGe5NsJvRGGy1VCAkkBv8N7oyEzaA3BWUSjUmMyqO9mef5A5GBqek4AQA
 A
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
Changes in v6:

[08/12]
  - Define dev_pm_ops statically (kernel test robot)

Link to v5: https://lore.kernel.org/r/20250312-hwm-v5-0-deb15ff8f3c6@gmail.com

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



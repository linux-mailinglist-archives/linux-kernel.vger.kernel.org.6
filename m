Return-Path: <linux-kernel+bounces-552791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34F1A57E21
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6953B29BC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C0215783;
	Sat,  8 Mar 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JidbcH/h"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25621519C;
	Sat,  8 Mar 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465449; cv=none; b=XrdMYKzk0Jhp9lnRkEazB+DWW54zmqOyHUY5vQK8xh+iyhOXvUzW4RIcz8S52tMhpEs3OAl1JdE17lnK3+c7RxMZHozhU+5BB8LWb86CUaPOzAV6U4iiVlebM75MAGbe8QX3fQdetrH4dP0ExKNhmI0vf1JjaVMF9oWfdJwK2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465449; c=relaxed/simple;
	bh=7xu59QVIatBVpYJa1Dkam5LKCr4ecNWmwMnn1XOpgxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VuX7di3jjBXRJI6VnLaWBVcixzBO+XkRDzPP15dmGiT4bjcngu1ljH2PDJAk1UyGowU3yWrtv6YTfh76BAX0xF/LCu79ktnFDOxj0ALf86ovLZCf9OMrFYLivKQGHzbPgTdug0Iu7tWJKLz+gRc3u4OHGol7055qfd4NM9AcWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JidbcH/h; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5239e7d4f0aso2914108e0c.2;
        Sat, 08 Mar 2025 12:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465446; x=1742070246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yxTxBzVJ1jb8Memke4DOGdfoivqF5ZiHtqL+IiDifo=;
        b=JidbcH/hTMHIK379ALpn7oybwjhugSFeIpaEbpGyMupJ7aGRHQ4LgI2Fw91f8GR2T5
         NGNyUc4cuTGASCnBn62mFIWj08VaCpUZi4AOJ8LnCOo0EumP3KpYLsHyI0qSUILVzqiH
         yDZ6CxbOp2mUdZXRLDhPfsuMrlcfWHS9UCgeJwJc1TPKKwEgkjIEbMXMpE675yuFo4NJ
         PLn6rcTmjP+tqzf8TQexEBsxUgeo1CYJ4Zp3uxWW6L2dHXr9bJMU2JDUrgigI2Vok3AY
         f0z9kPsOdI1ptaHGOlb7gsgu8s8+ddo6PZNKIiI41OffbdVJ5O7xe6bfy8ZcVliGv9il
         VfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465446; x=1742070246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yxTxBzVJ1jb8Memke4DOGdfoivqF5ZiHtqL+IiDifo=;
        b=hx27S40S5zxBKt3ST7jvqN6EpmUTgVOIhSDk9Ui4cY8/0B4CcdyNkaqMQN/YYgmKjP
         RNoGWdRGU5mG0mq+yOmJI0KXbIAXF5bGWl048E19dbi0czc8ygp6SdoyHRvD+yCaQtIP
         kJsecJxlK2KNVqbUpK6aqNxj0RVCMfJ/ta3wLZYew2jR68Z4PWstJlGz9Xq61ULNBMWa
         OCADKxmI3r1dwF4D/nMrqn3KkOYYLJ6XuBwd59qZIB4tAdgJzZXE0NIl2Jmtkl7UaiTM
         +fL6LwyyfNezd9gWd4ifX10Z8noJ8x7SC88S8L3J7+N5zsUvqs7CbvORAJdXmhTzk5Yp
         +DTg==
X-Forwarded-Encrypted: i=1; AJvYcCWQnGYuLUuUoSInE5/RYphVy8b09Boy30xWt7yki9axaZbDLBkTZ4rlOtIYzLh2whFlp43kTQAFFwz2EzI=@vger.kernel.org, AJvYcCX92p0G/SUolChDYAukgiFCpyYQ/7+M+daKYHH8vnp15QXvBK4k7zSgHe7/EC3LBb7ap81EECyNrmtAsCgZgAafh4DUVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuwKJ/v+SyjtGCt3+tIiT1hp6sNIshJWgRg5vyf1f5tcCfQoh
	m0XfoPr0plZmmTmRBZhUpGv7ke4iBdj9fbrJCQhG4u0E2aXWxXGH
X-Gm-Gg: ASbGncvDhXNieM89gPqYqtDRonLWZC1iiJ3sZWN9NxA0APoAsYSwgS+Mv4AhVKu1F0G
	3W4A8wuj/+pQoeJvKQNFu/7PWWeM8v0HyI9G+ZC74Vh9hbFe4VFPkkME5PZAcaYf7V8ZEux6C3S
	tz3d4M8x7Pqxi2CjVfm0e+WmYbks9rahqBL4Ux3DVeWbSIL+trAhQYcQJ1nC7WQe+BhwepjhFtl
	KlCERtMfUgUmOsYbQUScDObYm/JkwJ3+rnybzu+RM+XB+3ltA0EKsH2bpGdF9U17hQe9OfeL+lQ
	8ZMyUrCjBeHiz0Vl2fmCXZd/la/Yf6/VC9u8XIAcO53gSNcZDDnk7eMm
X-Google-Smtp-Source: AGHT+IG1AjTfYKQW3sIVfJ770EWyrdjjUlxsp6oTNHF1791xiHDYHpJRv+86i3n+/BIUsakXEplM9Q==
X-Received: by 2002:a05:6102:a49:b0:4bb:cbbc:38 with SMTP id ada2fe7eead31-4c30a538838mr4889494137.5.1741465446138;
        Sat, 08 Mar 2025 12:24:06 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:24:05 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:22 -0500
Subject: [PATCH v4 10/12] Documentation: wmi: Improve and update
 alienware-wmi documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-10-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: b4 0.14.2

Use tables to describe method operations instead of using pseudo-code.
Drop unknown method descriptions to avoid redundancy. Drop GPIO section
as it is currently irrelevant to this driver. Update Thermal_Information
method documentation. Add one more helpful developer to the kudos section.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/wmi/devices/alienware-wmi.rst | 383 +++++++++-------------------
 1 file changed, 117 insertions(+), 266 deletions(-)

diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation/wmi/devices/alienware-wmi.rst
index ddc5e561960e05fc7cffe700d7d278e32ff2e7b2..79238051b18bc5de9b502325017cd5c5fcf41748 100644
--- a/Documentation/wmi/devices/alienware-wmi.rst
+++ b/Documentation/wmi/devices/alienware-wmi.rst
@@ -11,7 +11,7 @@ The WMI device WMAX has been implemented for many Alienware and Dell's G-Series
 models. Throughout these models, two implementations have been identified. The
 first one, used by older systems, deals with HDMI, brightness, RGB, amplifier
 and deep sleep control. The second one used by newer systems deals primarily
-with thermal, overclocking, and GPIO control.
+with thermal control and overclocking.
 
 It is suspected that the latter is used by Alienware Command Center (AWCC) to
 manage manufacturer predefined thermal profiles. The alienware-wmi driver
@@ -69,9 +69,6 @@ data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
    [WmiMethodId(164), Implemented, read, write, Description("Tobii Camera Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
  };
 
-Some of these methods get quite intricate so we will describe them using
-pseudo-code that vaguely resembles the original ASL code.
-
 Methods not described in the following document have unknown behavior.
 
 Argument Structure
@@ -87,175 +84,133 @@ ID 0xA0, the argument you would pass to the method is 0xA001.
 Thermal Methods
 ===============
 
+WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
+-------------------------------------------------------------
+
++--------------------+------------------------------------+--------------------+
+| Operation (Byte 0) | Description                        | Arguments          |
++====================+====================================+====================+
+| 0x01               | Get the number of temperature      | - Byte 1: Fan ID   |
+|                    | sensors related with a fan ID      |                    |
++--------------------+------------------------------------+--------------------+
+| 0x02               | Get the temperature sensor IDs     | - Byte 1: Fan ID   |
+|                    | related to a fan sensor ID         | - Byte 2: Index    |
++--------------------+------------------------------------+--------------------+
+
 WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
 -------------------------------------------------------------------
 
-::
-
- if BYTE_0(arg2) == 0x01:
-         argr = 1
-
- if BYTE_0(arg2) == 0x02:
-         argr = SYSTEM_DESCRIPTION
-
- if BYTE_0(arg2) == 0x03:
-         if BYTE_1(arg2) == 0x00:
-                 argr = FAN_ID_0
-
-         if BYTE_1(arg2) == 0x01:
-                 argr = FAN_ID_1
-
-         if BYTE_1(arg2) == 0x02:
-                 argr = FAN_ID_2
-
-         if BYTE_1(arg2) == 0x03:
-                 argr = FAN_ID_3
-
-         if BYTE_1(arg2) == 0x04:
-                 argr = SENSOR_ID_CPU | 0x0100
-
-         if BYTE_1(arg2) == 0x05:
-                 argr = SENSOR_ID_GPU | 0x0100
-
-         if BYTE_1(arg2) == 0x06:
-                 argr = THERMAL_MODE_QUIET_ID
-
-         if BYTE_1(arg2) == 0x07:
-                 argr = THERMAL_MODE_BALANCED_ID
-
-         if BYTE_1(arg2) == 0x08:
-                 argr = THERMAL_MODE_BALANCED_PERFORMANCE_ID
-
-         if BYTE_1(arg2) == 0x09:
-                 argr = THERMAL_MODE_PERFORMANCE_ID
-
-         if BYTE_1(arg2) == 0x0A:
-                 argr = THERMAL_MODE_LOW_POWER_ID
-
-         if BYTE_1(arg2) == 0x0B:
-                 argr = THERMAL_MODE_GMODE_ID
-
-         else:
-                 argr = 0xFFFFFFFF
-
- if BYTE_0(arg2) == 0x04:
-         if is_valid_sensor(BYTE_1(arg2)):
-                 argr = SENSOR_TEMP_C
-         else:
-                 argr = 0xFFFFFFFF
-
- if BYTE_0(arg2) == 0x05:
-         if is_valid_fan(BYTE_1(arg2)):
-                 argr = FAN_RPM()
-
- if BYTE_0(arg2) == 0x06:
-         skip
-
- if BYTE_0(arg2) == 0x07:
-         argr = 0
-
- If BYTE_0(arg2) == 0x08:
-         if is_valid_fan(BYTE_1(arg2)):
-                 argr = 0
-         else:
-                 argr = 0xFFFFFFFF
-
- if BYTE_0(arg2) == 0x09:
-         if is_valid_fan(BYTE_1(arg2)):
-                 argr = FAN_UNKNOWN_STAT_0()
-
-         else:
-                 argr = 0xFFFFFFFF
-
- if BYTE_0(arg2) == 0x0A:
-         argr = THERMAL_MODE_BALANCED_ID
-
- if BYTE_0(arg2) == 0x0B:
-         argr = CURRENT_THERMAL_MODE()
-
- if BYTE_0(arg2) == 0x0C:
-         if is_valid_fan(BYTE_1(arg2)):
-                 argr = FAN_UNKNOWN_STAT_1()
-         else:
-                 argr = 0xFFFFFFFF
-
-Operation 0x02 returns a *system description* buffer with the following
-structure:
-
-::
-
- out[0] -> Number of fans
- out[1] -> Number of sensors
- out[2] -> 0x00
- out[3] -> Number of thermal modes
-
-Operation 0x03 list all available fan IDs, sensor IDs and thermal profile
-codes in order, but different models may have different number of fans and
-thermal profiles. These are the known ranges:
-
-* Fan IDs: from 2 up to 4
-* Sensor IDs: 2
-* Thermal profile codes: from 1 up to 7
-
-In total BYTE_1(ARG2) may range from 0x5 up to 0xD depending on the model.
++--------------------+------------------------------------+--------------------+
+| Operation (Byte 0) | Description                        | Arguments          |
++====================+====================================+====================+
+| 0x01               | Unknown.                           | - None             |
++--------------------+------------------------------------+--------------------+
+| 0x02               | Get system description number with | - None             |
+|                    | the following structure:           |                    |
+|                    |                                    |                    |
+|                    | - Byte 0: Number of fans           |                    |
+|                    | - Byte 1: Number of temperature    |                    |
+|                    |   sensors                          |                    |
+|                    | - Byte 2: Unknown                  |                    |
+|                    | - Byte 3: Number of thermal        |                    |
+|                    |   profiles                         |                    |
++--------------------+------------------------------------+--------------------+
+| 0x03               | List an ID or resource at a given  | - Byte 1: Index    |
+|                    | index. Fan IDs, temperature IDs,   |                    |
+|                    | unknown IDs and thermal profile    |                    |
+|                    | IDs are listed in that exact       |                    |
+|                    | order.                             |                    |
+|                    |                                    |                    |
+|                    | Operation 0x02 is used to know     |                    |
+|                    | which indexes map to which         |                    |
+|                    | resources.                         |                    |
+|                    |                                    |                    |
+|                    | **Returns:** ID at a given index   |                    |
++--------------------+------------------------------------+--------------------+
+| 0x04               | Get the current temperature for a  | - Byte 1: Sensor   |
+|                    | given temperature sensor.          |   ID               |
++--------------------+------------------------------------+--------------------+
+| 0x05               | Get the current RPM for a given    | - Byte 1: Fan ID   |
+|                    | fan.                               |                    |
++--------------------+------------------------------------+--------------------+
+| 0x06               | Get fan speed percentage. (not     | - Byte 1: Fan ID   |
+|                    | implemented in every model)        |                    |
++--------------------+------------------------------------+--------------------+
+| 0x07               | Unknown.                           | - Unknown          |
++--------------------+------------------------------------+--------------------+
+| 0x08               | Get minimum RPM for a given FAN    | - Byte 1: Fan ID   |
+|                    | ID.                                |                    |
++--------------------+------------------------------------+--------------------+
+| 0x09               | Get maximum RPM for a given FAN    | - Byte 1: Fan ID   |
+|                    | ID.                                |                    |
++--------------------+------------------------------------+--------------------+
+| 0x0A               | Get balanced thermal profile ID.   | - None             |
++--------------------+------------------------------------+--------------------+
+| 0x0B               | Get current thermal profile ID.    | - None             |
++--------------------+------------------------------------+--------------------+
+| 0x0C               | Get current `boost` value for a    | - Byte 1: Fan ID   |
+|                    | given fan ID.                      |                    |
++--------------------+------------------------------------+--------------------+
 
 WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
 ---------------------------------------------------------------
 
-::
-
- if BYTE_0(arg2) == 0x01:
-         if is_valid_thermal_profile(BYTE_1(arg2)):
-                 SET_THERMAL_PROFILE(BYTE_1(arg2))
-                 argr = 0
-
- if BYTE_0(arg2) == 0x02:
-         if is_valid_fan(BYTE_1(arg2)):
-                 SET_FAN_SPEED_MULTIPLIER(BYTE_2(arg2))
-                 argr = 0
-         else:
-                 argr = 0xFFFFFFFF
-
-.. note::
-   While you can manually change the fan speed multiplier with this method,
-   Dell's BIOS tends to overwrite this changes anyway.
++--------------------+------------------------------------+--------------------+
+| Operation (Byte 0) | Description                        | Arguments          |
++====================+====================================+====================+
+| 0x01               | Activate a given thermal profile.  | - Byte 1: Thermal  |
+|                    |                                    |   profile ID       |
++--------------------+------------------------------------+--------------------+
+| 0x02               | Set a `boost` value for a given    | - Byte 1: Fan ID   |
+|                    | fan ID.                            | - Byte 2: Boost    |
++--------------------+------------------------------------+--------------------+
 
 These are the known thermal profile codes:
 
-::
++------------------------------+----------+------+
+| Thermal Profile              | Type     | ID   |
++==============================+==========+======+
+| Custom                       | Special  | 0x00 |
++------------------------------+----------+------+
+| G-Mode                       | Special  | 0xAB |
++------------------------------+----------+------+
+| Quiet                        | Legacy   | 0x96 |
++------------------------------+----------+------+
+| Balanced                     | Legacy   | 0x97 |
++------------------------------+----------+------+
+| Balanced Performance         | Legacy   | 0x98 |
++------------------------------+----------+------+
+| Performance                  | Legacy   | 0x99 |
++------------------------------+----------+------+
+| Balanced                     | USTT     | 0xA0 |
++------------------------------+----------+------+
+| Balanced Performance         | USTT     | 0xA1 |
++------------------------------+----------+------+
+| Cool                         | USTT     | 0xA2 |
++------------------------------+----------+------+
+| Quiet                        | USTT     | 0xA3 |
++------------------------------+----------+------+
+| Performance                  | USTT     | 0xA4 |
++------------------------------+----------+------+
+| Low Power                    | USTT     | 0xA5 |
++------------------------------+----------+------+
 
- CUSTOM                         0x00
+If a model supports the User Selectable Thermal Tables (USTT) profiles, it will
+not support the Legacy profiles and vice-versa.
 
- BALANCED_USTT                  0xA0
- BALANCED_PERFORMANCE_USTT      0xA1
- COOL_USTT                      0xA2
- QUIET_USTT                     0xA3
- PERFORMANCE_USTT               0xA4
- LOW_POWER_USTT                 0xA5
-
- QUIET                          0x96
- BALANCED                       0x97
- BALANCED_PERFORMANCE           0x98
- PERFORMANCE                    0x99
-
- GMODE                          0xAB
-
-Usually if a model doesn't support the first four profiles they will support
-the User Selectable Thermal Tables (USTT) profiles and vice-versa.
-
-GMODE replaces PERFORMANCE in G-Series laptops.
+Every model supports the CUSTOM (0x00) thermal profile. GMODE replaces
+PERFORMANCE in G-Series laptops.
 
 WMI method GameShiftStatus([in] uint32 arg2, [out] uint32 argr)
 ---------------------------------------------------------------
 
-::
-
- if BYTE_0(arg2) == 0x1:
-         TOGGLE_GAME_SHIFT()
-         argr = GET_GAME_SHIFT_STATUS()
-
- if BYTE_0(arg2) == 0x2:
-         argr = GET_GAME_SHIFT_STATUS()
++--------------------+------------------------------------+--------------------+
+| Operation (Byte 0) | Description                        | Arguments          |
++====================+====================================+====================+
+| 0x01               | Toggle *Game Shift*.               | - None             |
++--------------------+------------------------------------+--------------------+
+| 0x02               | Get *Game Shift* status.           | - None             |
++--------------------+------------------------------------+--------------------+
 
 Game Shift Status does not change the fan speed profile but it could be some
 sort of CPU/GPU power profile. Benchmarks have not been done.
@@ -267,131 +222,27 @@ Thermal_Information does not list it.
 G-key on Dell's G-Series laptops also changes Game Shift status, so both are
 directly related.
 
-WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
--------------------------------------------------------------
-
-::
-
- if BYTE_0(arg2) == 0x1:
-        if is_valid_fan(BYTE_1(arg2)):
-                argr = 1
-        else:
-                argr = 0
-
- if BYTE_0(arg2) == 0x2:
-        if is_valid_fan(BYTE_1(arg2)):
-                if BYTE_2(arg2) == 0:
-                        argr == SENSOR_ID
-                else
-                        argr == 0xFFFFFFFF
-        else:
-                argr = 0
-
 Overclocking Methods
 ====================
 
-.. warning::
-   These methods have not been tested and are only partially reverse
-   engineered.
-
-WMI method Return_OverclockingReport([out] uint32 argr)
--------------------------------------------------------
-
-::
-
- CSMI (0xE3, 0x99)
- argr = 0
-
-CSMI is an unknown operation.
-
-WMI method Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr)
--------------------------------------------------------------------
-
-::
-
- CSMI (0xE3, 0x99)
- argr = 0
-
-CSMI is an unknown operation.
-
-WMI method Clear_OCFailSafeFlag([out] uint32 argr)
---------------------------------------------------
-
-::
-
- CSMI (0xE3, 0x99)
- argr = 0
-
-CSMI is an unknown operation.
-
-
 WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
 ---------------------------------------------------------------
 
 AWCC supports memory overclocking, but this method is very intricate and has
 not been deciphered yet.
 
-GPIO methods
-============
-
-These methods are probably related to some kind of firmware update system,
-through a GPIO device.
-
-.. warning::
-   These methods have not been tested and are only partially reverse
-   engineered.
-
-WMI method FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr)
-------------------------------------------------------------------
-
-::
-
- if BYTE_0(arg2) == 0:
-         if BYTE_1(arg2) == 1:
-                 SET_PIN_A_HIGH()
-         else:
-                 SET_PIN_A_LOW()
-
- if BYTE_0(arg2) == 1:
-         if BYTE_1(arg2) == 1:
-                 SET_PIN_B_HIGH()
-
-         else:
-                 SET_PIN_B_LOW()
-
- else:
-         argr = 1
-
-WMI method ReadTotalofGPIOs([out] uint32 argr)
-----------------------------------------------
-
-::
-
- argr = 0x02
-
-WMI method ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)
-------------------------------------------------------------------
-
-::
-
- if BYTE_0(arg2) == 0:
-         argr = PIN_A_STATUS
-
- if BYTE_0(arg2) == 1:
-         argr = PIN_B_STATUS
-
 Other information Methods
 =========================
 
 WMI method ReadChassisColor([out] uint32 argr)
 ----------------------------------------------
 
-::
-
- argr = CHASSIS_COLOR_ID
+Returns the chassis color internal ID.
 
 Acknowledgements
 ================
 
-Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for documenting
-and testing available thermal profile codes.
+Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ and
+`T-Troll <https://github.com/T-Troll/alienfx-tools/>`_ for documenting and
+testing some of this device's functionality, making it possible to generalize
+this driver.

-- 
2.48.1



Return-Path: <linux-kernel+bounces-532631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A25A45026
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604CD16D3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678221D3DA;
	Tue, 25 Feb 2025 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plv6BEU1"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D82206AF;
	Tue, 25 Feb 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522330; cv=none; b=IwrG6RQBWo0e2C3iVxUdeTMX0H0Q5JVU1EqcnikN3RvxAYttYsvsz2x4evmWOGEZIdFkpFofk/5K46mN7yUEWxea7nY3x0WbOB22FvPmKEwgKJt0cXoNPwjFhbro7j3PrgvYoOHrlGG/4msIProZCPDlhncudz+gkyPsPmlBYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522330; c=relaxed/simple;
	bh=TvzFl75+8BEMuef5Tw/MAjlxEEcCgYatcfbDHZ9OmEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bquQaCWWi0dzVmvu0kKPjtssIoSAaR7qd8Q+TJybU0y7p6sj8WHfAt+NeWob7H5WRv5Azoxy9MXSbCHK0fUG5ltqUpBHZnom6qOUCSkX5moowYivgoQB9AgEzrbFiCeZhbLZtA6TYacA2gLH5/Y6eDu96xd7rtjzKLk2lUUt/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plv6BEU1; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso4780187276.3;
        Tue, 25 Feb 2025 14:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522327; x=1741127127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psyzF+U+3D2SNT0cjQITo0ybM831P3VGS52BhOq58Xg=;
        b=Plv6BEU1f/OsN88l3/olAsjIqXsqno+/MXFh0NmETgb2Bj5yyKVx09Dn2hppBOazpa
         OqrZQLeAzsv2ERBCiNfo2prM2qXgPGHcNwxVSGujruS36ZvKEcfYMDkElcM1VmGk2pEE
         muXAW5TonQ0uHx/YEvTpNLeDycGNkJ+7Yl40F1TW0h08ctGXikAKv6H2LtIxiPng99Wu
         7E15TyQe3s5fKi0tpqL9V4jkxvnNRGR+88cHTaWuJnA8dY4Ibmci8v3OIBKNG0u2QYqt
         exA8GIj1PpJ/S6jzGakIFYaZ829TAPWyrEMJ61aDLdNTDOCs0+289tZ151vrR14K64bu
         a+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522327; x=1741127127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psyzF+U+3D2SNT0cjQITo0ybM831P3VGS52BhOq58Xg=;
        b=ufB8MsTL4nxhyenZMzjkVnsuFmXMbFL3WRUCGApNgItU5pz+bF+VWHsiq16OFAcai0
         PNZd7TQKumykqEysq5jZV5URGlVRnb3CI24tx+2eySSmoVQiQonV2zXth+dvqMd9AZ4V
         5/vVbPS0cVDDtk4DR9RRQJttF4JmbRR6+ZrFA+9VZFx+jeYgpuqO+9xizfiunQ5x+xHo
         3ut7cWtfR4vvb7iN2eSklwV65rwbzYoCea/ZtZmGh7yu1boE13MOVqAFNK5Y30LRTQI6
         P47iWBRHLkpZc+qQGsY/HkJbKu5xqV8itDgRagqREuNHQzgb6/R3WsYjVnEiR7yo/LoD
         A2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH4tJeTvH0WwAD2J2y23+CW8deeAP7tenHkDPtwbXgKE+Oj9XGGdbsWlK0KWsp51KUytCJsen027ZggZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhBcZ410UH+q1Jft5Cu/tFpjB7cesqQ0qlWHHH5+mRmWBxqBGI
	3p9kI2kT5hx14jSod4e0gdWfcMjTxTsoZrqhp3MlQw8+GUhEZO9EQmJwfYWF
X-Gm-Gg: ASbGncvOHdXj6u5kJyYUqAinVNQd+iP+TSjMesZo1JkewSzwcjpLbDHQrOjySiO3xMT
	mqFZyzoeZ+mTV0jRqV8nFswtyL3dysSkD80RdQqJ9deyZg1wwjyTzSk91neLVqjsIfRajYA0CQM
	1tCPThsRrcCmJNyQQ5YqR7lXVrZQGxnCWtkpY6OpL3XObmc6VW6Qc1wNXTPVX3UWaz12Ao6IdbD
	h9PNIOqfNTjaUOJE6QrXvUAF0pEc1lc33DvwlBat4lan1ru4QnQ3Q1NmtM5697YYD4ZOAE8wkoo
	nCWFF0c9SbFdHzFcipIOj8GQyKFZWfeAJQ==
X-Google-Smtp-Source: AGHT+IE99nqVmY6BZoywuoBNDELfYbzBwSrDsUdOl2WhdsSV2M6xGo/mo0B7haSfnzXRGHog8dJvtg==
X-Received: by 2002:a05:6902:2085:b0:e5d:d765:38ca with SMTP id 3f1490d57ef6-e607a56b546mr3692287276.41.1740522327433;
        Tue, 25 Feb 2025 14:25:27 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:27 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 10/10] platform/x86: alienware-wmi: Improve and update documentation
Date: Tue, 25 Feb 2025 17:25:00 -0500
Message-ID: <20250225222500.23535-11-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225222500.23535-1-kuurtb@gmail.com>
References: <20250225222500.23535-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use tables to describe method operations instead of using pseudo-code.
Drop unknown method descriptions to avoid redundancy. Drop GPIO section
as it is currently irrelevant to this driver. Update Thermal_Information
method documentation. Add one more helpful developer to the kudos section.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/wmi/devices/alienware-wmi.rst | 387 ++++++--------------
 1 file changed, 119 insertions(+), 268 deletions(-)

diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation/wmi/devices/alienware-wmi.rst
index ddc5e561960e..79238051b18b 100644
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
 
-WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
--------------------------------------------------------------------
-
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
+WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
+-------------------------------------------------------------
 
-Operation 0x03 list all available fan IDs, sensor IDs and thermal profile
-codes in order, but different models may have different number of fans and
-thermal profiles. These are the known ranges:
++--------------------+------------------------------------+--------------------+
+| Operation (Byte 0) | Description                        | Arguments          |
++====================+====================================+====================+
+| 0x01               | Get the number of temperature      | - Byte 1: Fan ID   |
+|                    | sensors related with a fan ID      |                    |
++--------------------+------------------------------------+--------------------+
+| 0x02               | Get the temperature sensor IDs     | - Byte 1: Fan ID   |
+|                    | related to a fan sensor ID         | - Byte 2: Index    |
++--------------------+------------------------------------+--------------------+
 
-* Fan IDs: from 2 up to 4
-* Sensor IDs: 2
-* Thermal profile codes: from 1 up to 7
+WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
+-------------------------------------------------------------------
 
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
-
- CUSTOM                         0x00
-
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
+
+If a model supports the User Selectable Thermal Tables (USTT) profiles, it will
+not support the Legacy profiles and vice-versa.
+
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



Return-Path: <linux-kernel+bounces-557231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC48A5D565
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB217A52BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A63F1EC01F;
	Wed, 12 Mar 2025 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/3RMF9w"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9A1EB192;
	Wed, 12 Mar 2025 05:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756344; cv=none; b=DsyE/5kS98+A9rjIN38lxm7Y/xWo/lWwUTGWWyFLFXBgmoQSW2YCxYWzeQPbMW0U+bFf6W3fbErTbUOISIyN2FtBu303bVMgSxkfN3Ymm67o61EfibbqQr/lgvBEKhrLSYr7C/ztajVH6QJzvH3aEZO/GJS/OTlWC8U6JvZk/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756344; c=relaxed/simple;
	bh=7xu59QVIatBVpYJa1Dkam5LKCr4ecNWmwMnn1XOpgxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mq4OYsnNgORU0yTfaOt6YArR9xZZs4XnlT9DjI0RMvCCx8UpriHPClNYoecQaR4QQGZsJ9nXAXQF8iFsehw8HS13ZY34yHVmmrxYVo0cz7kipltwWTZbrLBruYdqeiYGiH6RVPoljZAooEBFzzI7Lk7nqaNVnxZ5K0zwyecpePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/3RMF9w; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ff0c9d1761so14754907b3.1;
        Tue, 11 Mar 2025 22:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756341; x=1742361141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yxTxBzVJ1jb8Memke4DOGdfoivqF5ZiHtqL+IiDifo=;
        b=A/3RMF9wuVq5bnb5Z1Rxt8EzI3kzoxum/N0DTeQterLBzeMKjwoBd6U9SjgjFUhMyv
         2zMyPOVufI+z828WI9V089tlyS/9xFdV74zIuYylBQVlN4xhCYHFlY4VOtYjclMuMeE4
         jf2udBNJe2dwjzrgpqKYG1FJu2CrX3Vn+ykDPC0MRkG7KYjsBs3svshKPhgBp2qF/J9O
         aDfSY6hT+ZdBUJoxG8omCfBP4D6jVVpcnmiREuM4OsumwA4u/4DP80aG1SlfEsQVdeza
         NJ6ShBct7Le5/jiZK2p1NRWyR0ecSyhcKXv7jpS25Q4Q0BuRqVsApP6m8duEctVaQA0c
         T5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756341; x=1742361141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yxTxBzVJ1jb8Memke4DOGdfoivqF5ZiHtqL+IiDifo=;
        b=FP2tmNY6DKZdP51XWRPlSycPIZXuYqYOXOkLZX588WznXFAZjG8P9db/LCG2Uq1G+X
         ssnDq1cuZOkFC0bp0fWy7mBA2FJOzcN0K2ZN+Nh/pHoxz7aCDSYAWMIq2XjCUQ/bR3e0
         kaOYMChByLQI8Fty1vY1xuIPJjhernoclTYdxGYhm3jF+CCHu0o6rwbJcJiL1XcmcDRf
         oheriJVmTJhkwkZmfQEudmuMnagl5CwNl8mKrJ9JNhU3JzUFOKF9RnYFdTsR37hWmdiU
         3Jx+HBXWCWpa2tMX0O2EHAdO3+v15SyVi3u1QbAdaQdGOK6BE+DKYr+pp2Q7jf5bw3AY
         nIWw==
X-Forwarded-Encrypted: i=1; AJvYcCVVFmgHj2NkYFdf8NyH+xDB03xvSQMD1OtwZ26EtAPYOv0xJ3VnkBukngtPzBAdp0AQDf8qqYi8K5yK8D0oxr0PcMx8IA==@vger.kernel.org, AJvYcCXU92BSTeAyv3CsaZdb3q3JcBlAB2UKUGhkBRkji9RzTOGuYoFBYcu1zUn8lfhskcy70Jr0FyGVnPnkUlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Q6QZ3W3vRXw7GZ3I8sk61DO/qP36XvDxBTQnqPCMmUDCnR+G
	uSgXJx1K4/GeJOHiDIR70STjRl4h7gl4TAPsU1osybx6OqivgAdGNNglzdPM
X-Gm-Gg: ASbGncvREIyEMzS1tc0hHzJpWcsxmcYNHypba1dad5fDExD2ZvsrQPwL1RqsfDK0MTh
	W1AzOAvp9qU69u70kzvktoNxWCBYWI2blVPcrhLvqTEAJwb003lPFFhM9ylXeb98gHGtX+XnL9C
	PiVWE3E7kpLclDXlbReZ8Rz1M9w+3XNicQz1fisC3hAfUYaZWU/rSgxnqXvqPG9ewVWBB6JqX2l
	xn9pdBbzeHBN1o/UUCVtQgKIMGuGUFe0062BMD+c61I02Yqg/VWdQvvaBneT8PKAVAGvUwG6BFK
	Z0CqCyrc4e36hEx3ABjSPNcevqNDhDUQqs83fYfwtjsTQA==
X-Google-Smtp-Source: AGHT+IEqoBvmM4rtyDTKLfPpo/n2yAeR5K7oRtFtSOWu9UXDemUQxHBWDKopigZ6d22xB+y3Vu6y6A==
X-Received: by 2002:a05:690c:6c02:b0:6f9:50aa:8605 with SMTP id 00721157ae682-6febf3e1a06mr270428087b3.34.1741756340969;
        Tue, 11 Mar 2025 22:12:20 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:20 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:23 -0500
Subject: [PATCH v5 10/12] Documentation: wmi: Improve and update
 alienware-wmi documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-10-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
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



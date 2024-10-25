Return-Path: <linux-kernel+bounces-382020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53D59B07DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B99C1F257A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB3184522;
	Fri, 25 Oct 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLJcbW2L"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195A1494B1;
	Fri, 25 Oct 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869413; cv=none; b=PGaXQTifBMPqctHHRmKOPkFuttHY1gcPPzHru2KCbpepyLLZLoI4bjFhKTcGsoKidEAFwstnL5MLt6sdO8Uau3RSxLwxtfFA+5tNAdzWAKLASm80g1iqaVtJSr+YUQRk5OV4dkZ7lZOM1LASTuZhjMajlLT3QhZ7259epRdd6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869413; c=relaxed/simple;
	bh=epUrZzLQq1L8dJncmk5fSK8U2oO8+1oaqc6x6R9n7qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iv9XIIiju9y6v32cJsfV9Y7xdc7pneiP/5qAD0N9C+dsH0O69YWvRv1BrF04qoBmLfukIVUhSTqA8Qa2AfpSA2y90CM4nSTLD+WYne0q22/xZedm8yLfkJyLtg7T3I8Yl1duJxczIv+VRuCjxAt2wN/yLZOviuyWzqEGLYfyM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLJcbW2L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso1433694b3a.3;
        Fri, 25 Oct 2024 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729869409; x=1730474209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbHYy8aLqSzLkqZfjoqAwqC7vp09k9Z+3n1aqR5Q51I=;
        b=YLJcbW2LTXD5MrvzMnbXrBnBcDkG/nFb4VveA0zeorx0q5HYL6xaf44JDxaoG/YNwG
         OcBPEAREZra5ndEfqGsR0a8ZBkd726/gxbzRFlqqL4eAGsP1MMvXGwqZeghoa+sQcDSq
         UgPSvbCgoAyTclzF79iTz3dlqh+sQMhECGfgwtfuYmQ9P+kE5RVZKHTvyARVOtJDa/3S
         CnKaHTxkzJCWrAx3HpyKL73gr8vThvzEsuXp7GobMnqqcqMthDmBzXRenrq5JSNM+l7i
         q2Z3n6f8dpuD66Nj41N8CbWDYeyPKPjHp4HdQGvaqOh70gxsTKyKCwC3ZpZuWZt91uR/
         TtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729869409; x=1730474209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbHYy8aLqSzLkqZfjoqAwqC7vp09k9Z+3n1aqR5Q51I=;
        b=kcYMjytAUb/O0QIDgGQxTPZBUT/o/Zl4m2BdusCfai8d2651KpSb5THOd4avloQ3Up
         HBbZ+yhNcTpHAPJoLBOAfYxjRt++A18pA/cNo4YOZWNIgdJ8hl10SvUo+8iTggyOvCGL
         iSbomFV9Jf8Py+FWiAgaxmfWC97WqFHYAQ9GxxGm4FvTQUGPOgE1R5vAGeRzauY8/cIJ
         Ra0jC4f7NvwsSBEO4dAQz7fkouLRftp0T9fsWiihH/55WgmdDoNcIbpa36xlx7+A/418
         ms9EhrLczSTjUZEPWxZHtfzN5QRZFM+5tTSGotDxyPXZ+R8MlPGVWzBQ1pGccq2DqdGr
         oCFA==
X-Forwarded-Encrypted: i=1; AJvYcCVYPS72jSxzLewpXgWhExQMeRwFCCn+RU83+5uDBHJRGRxJ/EbTUyeuDapKsU3aomYRq2FBgc5NwhYOhsE=@vger.kernel.org, AJvYcCWAPhqeG4ToGdE/b984JN2+ZXEd0q3sAUfCUxQJp6aHWTvGuN9Ovuk9uQc5ZbNjtIuiaAtDU8cMpYQU6QgBXW+S48dSMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNiivkbS1Oj8VFmwjTYp0Jpro8HKXQTv+v5QBdDvJxgoIKAEZ
	2DZU5aVDNuBwk/vNC7IWB/umKZR/2D9przvkpBavKw8qR/wmZqBf
X-Google-Smtp-Source: AGHT+IF0hu3A2kCx8rIDt8VPvMG/yuIOElpb26IzI0d+O+IKp0QvRRd6ceLbfgHb/R7IRju1zlh4pw==
X-Received: by 2002:a05:6a00:1491:b0:71e:14c:8d31 with SMTP id d2e1a72fcca58-72030c0d886mr12025886b3a.16.1729869409333;
        Fri, 25 Oct 2024 08:16:49 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1eac3sm1167706b3a.150.2024.10.25.08.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:16:49 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v9 4/4] alienware-wmi: WMAX interface documentation
Date: Fri, 25 Oct 2024 12:16:40 -0300
Message-ID: <20241025151641.4655-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025150916.3618-2-kuurtb@gmail.com>
References: <20241025150916.3618-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Added documentation for new WMAX interface, present on some Alienware
X-Series, Alienware M-Series and Dell's G-Series laptops.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v9:
 - Unchanged
v8:
 - Unchanged
v7:
 - Added GameShiftStatus method to documentation
 - Added remark about operation 0x03 of Thermal_Information method
 - Removed undocumented methods
v6:
 - Fixed typos
 - Included new file in MAINTAINERS
---
 Documentation/wmi/devices/alienware-wmi.rst | 388 ++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 389 insertions(+)
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation/wmi/devices/alienware-wmi.rst
new file mode 100644
index 000000000..36a67ff9a
--- /dev/null
+++ b/Documentation/wmi/devices/alienware-wmi.rst
@@ -0,0 +1,388 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==============================================
+Dell AWCC WMI interface driver (alienware-wmi)
+==============================================
+
+Introduction
+============
+
+The WMI device WMAX has been implemented for many Alienware and Dell's G-Series
+models. Throughout these models, two implementations have been identified. The
+first one, used by older systems, deals with HDMI, brightness, RGB, amplifier
+and deep sleep control. The second one used by newer systems deals primarily
+with thermal, overclocking, and GPIO control.
+
+It is suspected that the latter is used by Alienware Command Center (AWCC) to
+manage manufacturer predefined thermal profiles. The alienware-wmi driver
+exposes Thermal_Information and Thermal_Control methods through the Platform
+Profile API to mimic AWCC's behavior.
+
+This newer interface, named AWCCMethodFunction has been reverse engineered, as
+Dell has not provided any official documentation. We will try to describe to the
+best of our ability its discovered inner workings.
+
+.. note::
+   The following method description may be incomplete and some operations have
+   different implementations between devices.
+
+WMI interface description
+-------------------------
+
+The WMI interface description can be decoded from the embedded binary MOF (bmof)
+data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
+
+::
+
+ [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("WMI Function"), guid("{A70591CE-A997-11DA-B012-B622A1EF5492}")]
+ class AWCCWmiMethodFunction {
+   [key, read] string InstanceName;
+   [read] boolean Active;
+
+   [WmiMethodId(13), Implemented, read, write, Description("Return Overclocking Report.")] void Return_OverclockingReport([out] uint32 argr);
+   [WmiMethodId(14), Implemented, read, write, Description("Set OCUIBIOS Control.")] void Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(15), Implemented, read, write, Description("Clear OC FailSafe Flag.")] void Clear_OCFailSafeFlag([out] uint32 argr);
+   [WmiMethodId(19), Implemented, read, write, Description("Get Fan Sensors.")] void GetFanSensors([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(20), Implemented, read, write, Description("Thermal Information.")] void Thermal_Information([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(21), Implemented, read, write, Description("Thermal Control.")] void Thermal_Control([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(23), Implemented, read, write, Description("MemoryOCControl.")] void MemoryOCControl([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(26), Implemented, read, write, Description("System Information.")] void SystemInformation([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(28), Implemented, read, write, Description("Power Information.")] void PowerInformation([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(32), Implemented, read, write, Description("FW Update GPIO toggle.")] void FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(33), Implemented, read, write, Description("Read Total of GPIOs.")] void ReadTotalofGPIOs([out] uint32 argr);
+   [WmiMethodId(34), Implemented, read, write, Description("Read GPIO pin Status.")] void ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(35), Implemented, read, write, Description("Read Chassis Color.")] void ReadChassisColor([out] uint32 argr);
+   [WmiMethodId(36), Implemented, read, write, Description("Read Platform Properties.")] void ReadPlatformProperties([out] uint32 argr);
+   [WmiMethodId(37), Implemented, read, write, Description("Game Shift Status.")] void GameShiftStatus([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(128), Implemented, read, write, Description("Caldera SW installation.")] void CalderaSWInstallation([out] uint32 argr);
+   [WmiMethodId(129), Implemented, read, write, Description("Caldera SW is released.")] void CalderaSWReleased([out] uint32 argr);
+   [WmiMethodId(130), Implemented, read, write, Description("Caldera Connection Status.")] void CalderaConnectionStatus([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(131), Implemented, read, write, Description("Surprise Unplugged Flag Status.")] void SurpriseUnpluggedFlagStatus([out] uint32 argr);
+   [WmiMethodId(132), Implemented, read, write, Description("Clear Surprise Unplugged Flag.")] void ClearSurpriseUnpluggedFlag([out] uint32 argr);
+   [WmiMethodId(133), Implemented, read, write, Description("Cancel Undock Request.")] void CancelUndockRequest([out] uint32 argr);
+   [WmiMethodId(135), Implemented, read, write, Description("Devices in Caldera.")] void DevicesInCaldera([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(136), Implemented, read, write, Description("Notify BIOS for SW ready to disconnect Caldera.")] void NotifyBIOSForSWReadyToDisconnectCaldera([out] uint32 argr);
+   [WmiMethodId(160), Implemented, read, write, Description("Tobii SW installation.")] void TobiiSWinstallation([out] uint32 argr);
+   [WmiMethodId(161), Implemented, read, write, Description("Tobii SW Released.")] void TobiiSWReleased([out] uint32 argr);
+   [WmiMethodId(162), Implemented, read, write, Description("Tobii Camera Power Reset.")] void TobiiCameraPowerReset([out] uint32 argr);
+   [WmiMethodId(163), Implemented, read, write, Description("Tobii Camera Power On.")] void TobiiCameraPowerOn([out] uint32 argr);
+   [WmiMethodId(164), Implemented, read, write, Description("Tobii Camera Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
+ };
+
+Some of these methods get quite intricate so we will describe them using
+pseudo-code that vaguely resembles the original ASL code.
+
+Methods not described in the following document have unknown behavior.
+
+Argument Structure
+------------------
+
+All input arguments have type **uint32** and their structure is very similar
+between methods. Usually, the first byte corresponds to a specific *operation*
+the method performs, and the subsequent bytes correspond to *arguments* passed
+to this *operation*. For example, if an operation has code 0x01 and requires an
+ID 0xA0, the argument you would pass to the method is 0xA001.
+
+
+Thermal Methods
+===============
+
+WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
+-------------------------------------------------------------------
+
+::
+
+ if BYTE_0(arg2) == 0x01:
+         argr = 1
+
+ if BYTE_0(arg2) == 0x02:
+         argr = UNKNOWN_CONSTANT
+
+ if BYTE_0(arg2) == 0x03:
+         if BYTE_1(arg2) == 0x00:
+                 argr = FAN_ID_0
+
+         if BYTE_1(arg2) == 0x01:
+                 argr = FAN_ID_1
+
+         if BYTE_1(arg2) == 0x02:
+                 argr = FAN_ID_2
+
+         if BYTE_1(arg2) == 0x03:
+                 argr = FAN_ID_3
+
+         if BYTE_1(arg2) == 0x04:
+                 argr = SENSOR_ID_CPU | 0x0100
+
+         if BYTE_1(arg2) == 0x05:
+                 argr = SENSOR_ID_GPU | 0x0100
+
+         if BYTE_1(arg2) == 0x06:
+                 argr = THERMAL_MODE_QUIET_ID
+
+         if BYTE_1(arg2) == 0x07:
+                 argr = THERMAL_MODE_BALANCED_ID
+
+         if BYTE_1(arg2) == 0x08:
+                 argr = THERMAL_MODE_BALANCED_PERFORMANCE_ID
+
+         if BYTE_1(arg2) == 0x09:
+                 argr = THERMAL_MODE_PERFORMANCE_ID
+
+         if BYTE_1(arg2) == 0x0A:
+                 argr = THERMAL_MODE_LOW_POWER_ID
+
+         if BYTE_1(arg2) == 0x0B:
+                 argr = THERMAL_MODE_GMODE_ID
+
+         else:
+                 argr = 0xFFFFFFFF
+
+ if BYTE_0(arg2) == 0x04:
+         if is_valid_sensor(BYTE_1(arg2)):
+                 argr = SENSOR_TEMP_C
+         else:
+                 argr = 0xFFFFFFFF
+
+ if BYTE_0(arg2) == 0x05:
+         if is_valid_fan(BYTE_1(arg2)):
+                 argr = FAN_RPM()
+
+ if BYTE_0(arg2) == 0x06:
+         skip
+
+ if BYTE_0(arg2) == 0x07:
+         argr = 0
+
+ If BYTE_0(arg2) == 0x08:
+         if is_valid_fan(BYTE_1(arg2)):
+                 argr = 0
+         else:
+                 argr = 0xFFFFFFFF
+
+ if BYTE_0(arg2) == 0x09:
+         if is_valid_fan(BYTE_1(arg2)):
+                 argr = FAN_UNKNOWN_STAT_0()
+
+         else:
+                 argr = 0xFFFFFFFF
+
+ if BYTE_0(arg2) == 0x0A:
+         argr = THERMAL_MODE_BALANCED_ID
+
+ if BYTE_0(arg2) == 0x0B:
+         argr = CURRENT_THERMAL_MODE()
+
+ if BYTE_0(arg2) == 0x0C:
+         if is_valid_fan(BYTE_1(arg2)):
+                 argr = FAN_UNKNOWN_STAT_1()
+         else:
+                 argr = 0xFFFFFFFF
+
+Operation 0x03 list all available fan IDs, sensor IDs and thermal profile
+codes in order, but different models may have different number of fans and
+thermal profiles. These are the known ranges:
+
+* Fan IDs: from 2 up to 4
+* Sensor IDs: 2
+* Thermal profile codes: from 1 up to 7
+
+In total BYTE_1(ARG2) may range from 0x5 up to 0xD depending on the model.
+
+WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
+---------------------------------------------------------------
+
+::
+
+ if BYTE_0(arg2) == 0x01:
+         if is_valid_thermal_profile(BYTE_1(arg2)):
+                 SET_THERMAL_PROFILE(BYTE_1(arg2))
+                 argr = 0
+
+ if BYTE_0(arg2) == 0x02:
+         if is_valid_fan(BYTE_1(arg2)):
+                 SET_FAN_SPEED_MULTIPLIER(BYTE_2(arg2))
+                 argr = 0
+         else:
+                 argr = 0xFFFFFFFF
+
+.. note::
+   While you can manually change the fan speed multiplier with this method,
+   Dell's BIOS tends to overwrite this changes anyway.
+
+These are the known thermal profile codes:
+
+::
+
+ CUSTOM                         0x00
+
+ BALANCED_USTT                  0xA0
+ BALANCED_PERFORMANCE_USTT      0xA1
+ COOL_USTT                      0xA2
+ QUIET_USTT                     0xA3
+ PERFORMANCE_USTT               0xA4
+ LOW_POWER_USTT                 0xA5
+
+ QUIET                          0x96
+ BALANCED                       0x97
+ BALANCED_PERFORMANCE           0x98
+ PERFORMANCE                    0x99
+
+ GMODE                          0xAB
+
+Usually if a model doesn't support the first four profiles they will support
+the User Selectable Thermal Tables (USTT) profiles and vice-versa.
+
+GMODE replaces PERFORMANCE in G-Series laptops.
+
+WMI method GameShiftStatus([in] uint32 arg2, [out] uint32 argr)
+---------------------------------------------------------------
+
+::
+
+ if BYTE_0(arg2) == 0x1:
+         TOGGLE_GAME_SHIFT()
+         argr = GET_GAME_SHIFT_STATUS()
+
+ if BYTE_0(arg2) == 0x2:
+         argr = GET_GAME_SHIFT_STATUS()
+
+Game Shift Status does not change the fan speed profile but it could be some
+sort of CPU/GPU power profile. Benchmarks have not been done.
+
+This method is only present on Dell's G-Series laptops and it's implementation
+implies GMODE thermal profile is available, even if operation 0x03 of
+Thermal_Information does not list it.
+
+G-key on Dell's G-Series laptops also changes Game Shift status, so both are
+directly related.
+
+WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
+-------------------------------------------------------------
+
+::
+
+ if BYTE_0(arg2) == 0x1:
+        if is_valid_fan(BYTE_1(arg2)):
+                argr = 1
+        else:
+                argr = 0
+
+ if BYTE_0(arg2) == 0x2:
+        if is_valid_fan(BYTE_1(arg2)):
+                if BYTE_2(arg2) == 0:
+                        argr == SENSOR_ID
+                else
+                        argr == 0xFFFFFFFF
+        else:
+                argr = 0
+
+Overclocking Methods
+====================
+
+.. warning::
+   These methods have not been tested and are only partially reverse
+   engineered.
+
+WMI method Return_OverclockingReport([out] uint32 argr)
+-------------------------------------------------------
+
+::
+
+ CSMI (0xE3, 0x99)
+ argr = 0
+
+CSMI is an unknown operation.
+
+WMI method Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr)
+-------------------------------------------------------------------
+
+::
+
+ CSMI (0xE3, 0x99)
+ argr = 0
+
+CSMI is an unknown operation.
+
+WMI method Clear_OCFailSafeFlag([out] uint32 argr)
+--------------------------------------------------
+
+::
+
+ CSMI (0xE3, 0x99)
+ argr = 0
+
+CSMI is an unknown operation.
+
+
+WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
+---------------------------------------------------------------
+
+AWCC supports memory overclocking, but this method is very intricate and has
+not been deciphered yet.
+
+GPIO methods
+============
+
+These methods are probably related to some kind of firmware update system,
+through a GPIO device.
+
+.. warning::
+   These methods have not been tested and are only partially reverse
+   engineered.
+
+WMI method FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr)
+------------------------------------------------------------------
+
+::
+
+ if BYTE_0(arg2) == 0:
+         if BYTE_1(arg2) == 1:
+                 SET_PIN_A_HIGH()
+         else:
+                 SET_PIN_A_LOW()
+
+ if BYTE_0(arg2) == 1:
+         if BYTE_1(arg2) == 1:
+                 SET_PIN_B_HIGH()
+
+         else:
+                 SET_PIN_B_LOW()
+
+ else:
+         argr = 1
+
+WMI method ReadTotalofGPIOs([out] uint32 argr)
+----------------------------------------------
+
+::
+
+ argr = 0x02
+
+WMI method ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)
+------------------------------------------------------------------
+
+::
+
+ if BYTE_0(arg2) == 0:
+         argr = PIN_A_STATUS
+
+ if BYTE_0(arg2) == 1:
+         argr = PIN_B_STATUS
+
+Other information Methods
+=========================
+
+WMI method ReadChassisColor([out] uint32 argr)
+----------------------------------------------
+
+::
+
+ argr = CHASSIS_COLOR_ID
+
+Acknowledgements
+================
+
+Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for documenting
+and testing available thermal profile codes.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index c27f31907..25f6de4c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -792,6 +792,7 @@ F:	drivers/perf/alibaba_uncore_drw_pmu.c
 ALIENWARE WMI DRIVER
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
+F:	Documentation/wmi/devices/alienware-wmi.rst
 F:	drivers/platform/x86/dell/alienware-wmi.c
 
 ALLEGRO DVT VIDEO IP CORE DRIVER
-- 
2.47.0



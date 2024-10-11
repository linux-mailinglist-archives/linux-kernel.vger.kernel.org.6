Return-Path: <linux-kernel+bounces-360597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25876999D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31A42829CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BB209F39;
	Fri, 11 Oct 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwjkqSyq"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326B209F4B;
	Fri, 11 Oct 2024 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629334; cv=none; b=UczyC2tTKfl/tH6UTlrevtCCzKtJVcJRNaGS429a/iAprTSnM99Mje5McyVK/kEmJRt3VtLxkzOGaeXHl+4axdqSL9bb34RFN6hhCceVI13PRic6WulAjcylI2qi+lmAhvX4BkdmUf5BYZPKgmizBybHuNVWjRGnGB0vvwwKmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629334; c=relaxed/simple;
	bh=T6kufcUz90PY22ZUdYq7DB9r+c6jj+c/dWVKLga8iTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7oQiLk11Yka/3t95xoQt5AT0jhYV74MGUvYpQQ5GLeiJNERxk0/YlLKVewPdp3lrLcPHyYyO83TgwYh5V3VWtpoa+QfIZmVZ1bKrtXibt1WfKCi9CIJpa/J+IF/K9+ezW2CKQfHKflMQWjqICfwlHwVNe9KUl2J9uk+b0buvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwjkqSyq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db908c9c83so1049636a12.2;
        Thu, 10 Oct 2024 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728629331; x=1729234131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5ermRXamu1j2z0NI4N0QaXWQDdS+RjUY4K3H9GJZsY=;
        b=NwjkqSyqx7bq2ILlrOnc6zLQtryKtDP+bnEtVumHykhTnIpzL9UsHlA5JRwbtiPAFG
         xD54dXSN1XzXUpXV3Px9xeP7Bq8qatNbruWyIZUtMIeEnyQ7Owq0vee5AMNq30FBkIm4
         zl+Vl7GFkgPjsFqNMK23s806B+Fg39IKZIPF7z45aPoyT9D9F8xGcn9NPNWax45FMOm+
         9RMw3jz9ROp1KtD4b7c9Tj3E9uo5+J2NAY26Fy32l+a4By+6oZaGthy7pkGGwVRmWXbH
         beGrDHhRCDItJEgvL6ZkUQ6gRkbdTeiZDPmLIA5PHWu2VtnQgfzNXMclAfvRkR7N2Y5Q
         xz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629331; x=1729234131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5ermRXamu1j2z0NI4N0QaXWQDdS+RjUY4K3H9GJZsY=;
        b=Z5frBTp90XgCgnViw7BJLM+933u3YPAn6deAJtmKsJNxVqlKfdASosn0uodtIEGKCQ
         QSUndZDJ/SLQrD/8fmjMhVfGlbYzuYwZl+Suyk0b4+leGKJ9xAknvCsCAxBIROn5XxtK
         ZxmBwvODAc4pDs8xHeBn9uZQzgZQG244vJC4MNdzYPLM297lC9kxNYezGV6J7zI1dV3I
         b7idNBBQ/Wd3Q/jag/cSFbPicJA2ufvXPWovTpBCLtoQJKfDP4cPumqi2EqEBGm6Xmn3
         YM7+mfcv4K222bS/LrZpxLrYsXu6IhxfHuYVN5bKDtC1LzrVxPkPhPUVAAs2WmgRSCeu
         g0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLL5sQH1RztSKOU6756LI7vOkl0j4U0Ysszzpv9X0X2tymIxbf5Eq85ChONEMSUw/Xc49AHzEes+gplVA=@vger.kernel.org, AJvYcCVakoy38N/NEfQiX0QXcTQnAcLNV0k9lxU76UTMD+H/YOjaxJ89JpyCuBUUBuVlJBvmD2OwxG9T31mv5AhMaPxvj+ETmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qjJ2XpkI5lQWaI/cd0CRQfJ455BhkOnKJOfyguvRUJF2epyJ
	j82h7KUnoJYuJRMcJgfXKw8FwY+GT2mzf4Gr7HmKAVdgdG5tWF/n
X-Google-Smtp-Source: AGHT+IFs6oLVBBW4jsvaJW7yhPRzCDKAc81uAXiwkuJDz8ifhJtZVaS6z2Nq7L6bhcnpUNuSUiwKKA==
X-Received: by 2002:a05:6a20:b418:b0:1d2:e94d:45a6 with SMTP id adf61e73a8af0-1d8bcf181d8mr2736362637.14.1728629331328;
        Thu, 10 Oct 2024 23:48:51 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e95f9sm2031810b3a.39.2024.10.10.23.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:48:50 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	W_Armin@gmx.de,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 4/4] alienware-wmi: WMAX interface documentation
Date: Fri, 11 Oct 2024 03:48:38 -0300
Message-ID: <20241011064837.307053-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011064336.305795-2-kuurtb@gmail.com>
References: <20241011064336.305795-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/wmi/devices/alienware-wmi.rst | 364 ++++++++++++++++++++
 1 file changed, 364 insertions(+)
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation/wmi/devices/alienware-wmi.rst
new file mode 100644
index 000000000..cf5d6259f
--- /dev/null
+++ b/Documentation/wmi/devices/alienware-wmi.rst
@@ -0,0 +1,364 @@
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
+   The following method description may vary between models.
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
+ QUIET                          0x96
+ BALANCED                       0x97
+ BALANCED_PERFORMANCE           0x98
+ PERFORMANCE                    0x99
+
+ QUIET_USTT                     0xA3
+ BALANCED_USTT                  0xA0
+ BALANCED_PERFORMANCE_USTT      0xA1
+ PERFORMANCE_USTT               0xA4
+ LOW_POWER_USTT                 0xA5
+
+ GMODE                          0xAB
+
+Usually if a model doesn't support the first four profiles they will support
+the User Selectable Thermal Tables (USTT) profiles and vice-versa.
+
+GMODE replaces PERFORMANCE in G-Series laptops.
+
+Very grateful to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for discovering
+some of the codes compatible with G-Series laptops.
+
+WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
+-------------------------------------------------------------
+
+::
+
+ if BYTE_0(arg2) == 1:
+        if is_valid_fan(BYTE_1(arg2)):
+                argr = 1
+        else:
+                argr = 0
+
+ if BYTE_0(arg2) == 2:
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
+CSMI is an unknown operation
+
+WMI method Clear_OCFailSafeFlag([out] uint32 argr)
+--------------------------------------------------
+
+::
+
+ CSMI (0xE3, 0x99)
+ argr = 0
+
+CSMI is an unknown operation
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
+
+Other information Methods
+=========================
+
+WMI method SystemInformation([in] uint32 arg2, [out] uint32 argr)
+-----------------------------------------------------------------
+
+Returns unknown information.
+
+WMI method PowerInformation([in] uint32 arg2, [out] uint32 argr)
+----------------------------------------------------------------
+
+Returns unknown information.
+
+WMI method ReadChassisColor([out] uint32 argr)
+----------------------------------------------
+
+::
+
+ argr = CHASSIS_COLOR_ID
+
+WMI method ReadPlatformProperties([out] uint32 argr)
+----------------------------------------------------
+
+Returns unknown information.
+
-- 
2.47.0



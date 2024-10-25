Return-Path: <linux-kernel+bounces-380865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE29AF714
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E54B22CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BA138490;
	Fri, 25 Oct 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8w/SsKX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCA4C83;
	Fri, 25 Oct 2024 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820564; cv=none; b=sWiyj/MHHQUNjCBuTyQ9iJ26+HOiJ19olW+3KzK2zpNAGAcdum92qeQxOi7vZvynqHkAY8qCK2cxD7E1cg2H9Qn/k2f1xTkYYYlrCpLxPRA1LJgj81KimnPJOp4vNyeXS7lk8tizlBvVE8UZXHEU8WIU0HAq/cecIuY5MONAZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820564; c=relaxed/simple;
	bh=ng1k2OWLtCzhAdG8vj0Q4cdh05MizT2X6Xzpxzv3MbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ8eHQ138B1fYjJzGOhLoi/RXqTR5M0+eWQPlcRCr8QmikSikzwNHcCMGvj9rqp1Le1Gn2cg1T1lnhuUAsfc5zI3kYRSGS8CwTczeRStr8qCbPPtbxkqsEsDs20p0JpWtQxiIM667wd2gazpE3UF/EgY3EOz0uc7UzaLJIuVTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8w/SsKX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c7edf2872so19262505ad.1;
        Thu, 24 Oct 2024 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729820561; x=1730425361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzEzxjES2gKKPe+KQD5bfIFirqS9kpBr4kJvWxKY5Eo=;
        b=g8w/SsKXp7kautAcSWd1dvn4CaiOTX7oL/nPGjpWJZwnxSfWrH+ZLR+nWjXCETficg
         aBq6ECSb9x6S9vz+3UDz/NF37LaMyY9umBqpch6Wp2YtKJtRxw3ZQm0JqFqRQXjgdfrR
         G3NXTa1Yb1Ie4z2iTdPvArT9o9XVD1bqgiDTvbhn2CAnrW6LUOyZ9PUcgqMXZTiO0BmS
         RmCwKgxt3Me20O7VK9DesX5Y1OF3v2WLT9kOu2hBPvFVxM86KWgd6ao+GTq1MVlDeYin
         u4QNVqzDNUGi8eO/ELM3t52v7gmx7sn/NUGniB+YC1ovsnXFSFlLsbjFD+GVts3LThz9
         HDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729820561; x=1730425361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzEzxjES2gKKPe+KQD5bfIFirqS9kpBr4kJvWxKY5Eo=;
        b=rr29QQKCxVv7FbOVJy0LfGJSJeCX5T97jRrtOxdHoS6NhN+gpScCDdyIWdFyjJyuQh
         yTWmvX34voMAeHltT7PTLyJp50cSqZgtmkEBGgToKJibUCl173h237Vo8onE6pS0CmTH
         ES9atUaORzyrKEQW7d65e6Nl9Jxc2tllTjeDPeNz3tH5lfCYKZDqgdOUfILkIIYofqyS
         PRc1SNxn6tJ9C8vwzwBq/A73xygSdTLNDejoSUI+c6pl1flhQeR36H8gztowXW7SEoXR
         70MsD0e9nlxczkVJoGwFhplUJfrcXJOlGr1dXBSebFhAFNYGuwK6fJ0GZjvio10yoz0M
         iDuw==
X-Forwarded-Encrypted: i=1; AJvYcCUSDc2bO/Du4qBpgJ3XmFi2rBe7vyavmZIP3T4MewHDtTJVxtgj/sd9oFLr13+Bns1fSXBRMsWD+XhpZv4daMb8hBJ0Gw==@vger.kernel.org, AJvYcCUxOwf8CAROIimjz24Hfmp5zUt2YyT799tS8G2Jl6kWU6cS/6rB4XDSZRsXsaE/Nd7XCqbFBhMkmg8Ddp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzj/oWfZLDMwotEXZ6vjKRNJx03z5WuDkL3q+u00sXzp484K/o
	4adg0zrocq1ITO5JlI6os1erRXvrrv3AEXrIEcwlMI3yhAWKGk0n
X-Google-Smtp-Source: AGHT+IGq9HzuKlThRoCcaJquIoAEbVesZn2dOFiylAHYAp9K75/5FeXllpRDtibL1571Nktlon9hMQ==
X-Received: by 2002:a17:903:244c:b0:20b:5ef8:10a6 with SMTP id d9443c01a7336-20fb88aa47bmr58608285ad.8.1729820560750;
        Thu, 24 Oct 2024 18:42:40 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d3cfsm828355ad.82.2024.10.24.18.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:42:40 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 4/4] alienware-wmi: WMAX interface documentation
Date: Thu, 24 Oct 2024 22:42:30 -0300
Message-ID: <20241025014229.5716-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025013856.4729-2-kuurtb@gmail.com>
References: <20241025013856.4729-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added documentation for new WMAX interface, present on some Alienware
X-Series, Alienware M-Series and Dell's G-Series laptops.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
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



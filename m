Return-Path: <linux-kernel+bounces-361022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598E99A27D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC461F28534
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33392141C6;
	Fri, 11 Oct 2024 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwyqLkNo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA81CF291;
	Fri, 11 Oct 2024 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645090; cv=none; b=TeRAA6d/iTTfzIJQOM4LuHxvVJgRb8bSzK+rf2Z9a1KkI8yIjfXDU63iNmONgQ3Clr9NvFGwd1rU2e2b8PLOCzUfPW2RTJbhmOQRM3T/8OdrHGP7qXkVHrzi2y/Fv02a4iEdsMpJs+3eYCamRkYFuuUjtpsLRwokL3pLeDAYgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645090; c=relaxed/simple;
	bh=Fphm0rYuWXv3WiIqcAVFB6jMIH5f6niYJjofjwtsWKI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LwpdzdxF76wsedxH/OqR3bObG5YiFcJWi/NoWcVJZj+kBb9Y47pP40onRNNU9IEH3aIzrzv6JvKOn51a5NGD7yqdwJjgNEs6gT8nvf4V87NYJkXQCpd36Q9cM6jtZJ1BUTPAuzq35p3WfD7diwiukRY+J6o8e2aGv6mW7eVB414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwyqLkNo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728645090; x=1760181090;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fphm0rYuWXv3WiIqcAVFB6jMIH5f6niYJjofjwtsWKI=;
  b=kwyqLkNoLqmddK6WFuR+oXjep75uavZuRZt19j457LU8duwwxrimVdfX
   ZM8EJOpZmyCYl1hC/DzdkVkJBqNdlxFpSmLJntm5QOitJYGO8bzlKOwAK
   70xQFhw01ZA/i6kLeGMdO9/RBf4zJiaJXnPShTCkijplbnE89COoIFwM9
   yRox+lu6hzGiDPl5s8/8fyS2Z0sSm7w1fNZx1fE/y8OUAhW7NezRkdqZv
   vIJ6DAudeSIN8mi++51DQ4OZXG0BmwU67BueIS2j0zZPwM7rhgbvlsRK6
   w1WXOphESTPNaCBNXcIX5IpMTKqp4eJ4AejHggNujFTsJ+3tQ05AGtPPs
   w==;
X-CSE-ConnectionGUID: yoxIkf8TQW2rfu1ADXcrNw==
X-CSE-MsgGUID: VojftRmFRi6lm6qNA+VEJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28130198"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28130198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:11:28 -0700
X-CSE-ConnectionGUID: 3ZbenYbTTgu4nZJ/NrT1AQ==
X-CSE-MsgGUID: koM6dhO/Sy2lgBLXoNrE5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77186701"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:11:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Oct 2024 14:11:21 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, W_Armin@gmx.de, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 4/4] alienware-wmi: WMAX interface documentation
In-Reply-To: <20241011064837.307053-2-kuurtb@gmail.com>
Message-ID: <75de8c01-e9d4-faef-692e-f9fa57c4b98c@linux.intel.com>
References: <20241011064336.305795-2-kuurtb@gmail.com> <20241011064837.307053-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Oct 2024, Kurt Borja wrote:

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  Documentation/wmi/devices/alienware-wmi.rst | 364 ++++++++++++++++++++
>  1 file changed, 364 insertions(+)
>  create mode 100644 Documentation/wmi/devices/alienware-wmi.rst
> 
> diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation/wmi/devices/alienware-wmi.rst
> new file mode 100644
> index 000000000..cf5d6259f
> --- /dev/null
> +++ b/Documentation/wmi/devices/alienware-wmi.rst
> @@ -0,0 +1,364 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +==============================================
> +Dell AWCC WMI interface driver (alienware-wmi)
> +==============================================
> +
> +Introduction
> +============
> +
> +The WMI device WMAX has been implemented for many Alienware and Dell's G-Series
> +models. Throughout these models, two implementations have been identified. The
> +first one, used by older systems, deals with HDMI, brightness, RGB, amplifier
> +and deep sleep control. The second one used by newer systems deals primarily
> +with thermal, overclocking, and GPIO control.
> +
> +It is suspected that the latter is used by Alienware Command Center (AWCC) to
> +manage manufacturer predefined thermal profiles. The alienware-wmi driver
> +exposes Thermal_Information and Thermal_Control methods through the Platform
> +Profile API to mimic AWCC's behavior.
> +
> +This newer interface, named AWCCMethodFunction has been reverse engineered, as
> +Dell has not provided any official documentation. We will try to describe to the
> +best of our ability its discovered inner workings.
> +
> +.. note::
> +   The following method description may vary between models.
> +
> +WMI interface description
> +-------------------------
> +
> +The WMI interface description can be decoded from the embedded binary MOF (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> + [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("WMI Function"), guid("{A70591CE-A997-11DA-B012-B622A1EF5492}")]
> + class AWCCWmiMethodFunction {
> +   [key, read] string InstanceName;
> +   [read] boolean Active;
> +
> +   [WmiMethodId(13), Implemented, read, write, Description("Return Overclocking Report.")] void Return_OverclockingReport([out] uint32 argr);
> +   [WmiMethodId(14), Implemented, read, write, Description("Set OCUIBIOS Control.")] void Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(15), Implemented, read, write, Description("Clear OC FailSafe Flag.")] void Clear_OCFailSafeFlag([out] uint32 argr);
> +   [WmiMethodId(19), Implemented, read, write, Description("Get Fan Sensors.")] void GetFanSensors([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(20), Implemented, read, write, Description("Thermal Information.")] void Thermal_Information([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(21), Implemented, read, write, Description("Thermal Control.")] void Thermal_Control([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(23), Implemented, read, write, Description("MemoryOCControl.")] void MemoryOCControl([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(26), Implemented, read, write, Description("System Information.")] void SystemInformation([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(28), Implemented, read, write, Description("Power Information.")] void PowerInformation([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(32), Implemented, read, write, Description("FW Update GPIO toggle.")] void FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(33), Implemented, read, write, Description("Read Total of GPIOs.")] void ReadTotalofGPIOs([out] uint32 argr);
> +   [WmiMethodId(34), Implemented, read, write, Description("Read GPIO pin Status.")] void ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(35), Implemented, read, write, Description("Read Chassis Color.")] void ReadChassisColor([out] uint32 argr);
> +   [WmiMethodId(36), Implemented, read, write, Description("Read Platform Properties.")] void ReadPlatformProperties([out] uint32 argr);
> +   [WmiMethodId(128), Implemented, read, write, Description("Caldera SW installation.")] void CalderaSWInstallation([out] uint32 argr);
> +   [WmiMethodId(129), Implemented, read, write, Description("Caldera SW is released.")] void CalderaSWReleased([out] uint32 argr);
> +   [WmiMethodId(130), Implemented, read, write, Description("Caldera Connection Status.")] void CalderaConnectionStatus([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(131), Implemented, read, write, Description("Surprise Unplugged Flag Status.")] void SurpriseUnpluggedFlagStatus([out] uint32 argr);
> +   [WmiMethodId(132), Implemented, read, write, Description("Clear Surprise Unplugged Flag.")] void ClearSurpriseUnpluggedFlag([out] uint32 argr);
> +   [WmiMethodId(133), Implemented, read, write, Description("Cancel Undock Request.")] void CancelUndockRequest([out] uint32 argr);
> +   [WmiMethodId(135), Implemented, read, write, Description("Devices in Caldera.")] void DevicesInCaldera([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(136), Implemented, read, write, Description("Notify BIOS for SW ready to disconnect Caldera.")] void NotifyBIOSForSWReadyToDisconnectCaldera([out] uint32 argr);
> +   [WmiMethodId(160), Implemented, read, write, Description("Tobii SW installation.")] void TobiiSWinstallation([out] uint32 argr);
> +   [WmiMethodId(161), Implemented, read, write, Description("Tobii SW Released.")] void TobiiSWReleased([out] uint32 argr);
> +   [WmiMethodId(162), Implemented, read, write, Description("Tobii Camera Power Reset.")] void TobiiCameraPowerReset([out] uint32 argr);
> +   [WmiMethodId(163), Implemented, read, write, Description("Tobii Camera Power On.")] void TobiiCameraPowerOn([out] uint32 argr);
> +   [WmiMethodId(164), Implemented, read, write, Description("Tobii Camera Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
> + };
> +
> +Some of these methods get quite intricate so we will describe them using
> +pseudo-code that vaguely resembles the original ASL code.
> +
> +Argument Structure
> +------------------
> +
> +All input arguments have type **uint32** and their structure is very similar
> +between methods. Usually, the first byte corresponds to a specific *operation*
> +the method performs, and the subsequent bytes correspond to *arguments* passed
> +to this *operation*. For example, if an operation has code 0x01 and requires an
> +ID 0xA0, the argument you would pass to the method is 0xA001.
> +
> +
> +Thermal Methods
> +===============
> +
> +WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 0x01:
> +         argr = 1
> +
> + if BYTE_0(arg2) == 0x02:
> +         argr = UNKNOWN_CONSTANT
> +
> + if BYTE_0(arg2) == 0x03:
> +         if BYTE_1(arg2) == 0x00:
> +                 argr = FAN_ID_0
> +
> +         if BYTE_1(arg2) == 0x01:
> +                 argr = FAN_ID_1
> +
> +         if BYTE_1(arg2) == 0x02:
> +                 argr = FAN_ID_2
> +
> +         if BYTE_1(arg2) == 0x03:
> +                 argr = FAN_ID_3
> +
> +         if BYTE_1(arg2) == 0x04:
> +                 argr = SENSOR_ID_CPU | 0x0100
> +
> +         if BYTE_1(arg2) == 0x05:
> +                 argr = SENSOR_ID_GPU | 0x0100
> +
> +         if BYTE_1(arg2) == 0x06:
> +                 argr = THERMAL_MODE_QUIET_ID
> +
> +         if BYTE_1(arg2) == 0x07:
> +                 argr = THERMAL_MODE_BALANCED_ID
> +
> +         if BYTE_1(arg2) == 0x08:
> +                 argr = THERMAL_MODE_BALANCED_PERFORMANCE_ID
> +
> +         if BYTE_1(arg2) == 0x09:
> +                 argr = THERMAL_MODE_PERFORMANCE_ID
> +
> +         if BYTE_1(arg2) == 0x0A:
> +                 argr = THERMAL_MODE_LOW_POWER_ID
> +
> +         if BYTE_1(arg2) == 0x0B:
> +                 argr = THERMAL_MODE_GMODE_ID
> +
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> + if BYTE_0(arg2) == 0x04:
> +         if is_valid_sensor(BYTE_1(arg2)):
> +                 argr = SENSOR_TEMP_C
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> + if BYTE_0(arg2) == 0x05:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr = FAN_RPM()
> +
> + if BYTE_0(arg2) == 0x06:
> +         skip
> +
> + if BYTE_0(arg2) == 0x07:
> +         argr = 0
> +
> + If BYTE_0(arg2) == 0x08:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr = 0
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> + if BYTE_0(arg2) == 0x09:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr = FAN_UNKNOWN_STAT_0()
> +
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> + if BYTE_0(arg2) == 0x0A:
> +         argr = THERMAL_MODE_BALANCED_ID
> +
> + if BYTE_0(arg2) == 0x0B:
> +         argr = CURRENT_THERMAL_MODE()
> +
> + if BYTE_0(arg2) == 0x0C:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr = FAN_UNKNOWN_STAT_1()
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> +WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 0x01:
> +         if is_valid_thermal_profile(BYTE_1(arg2)):
> +                 SET_THERMAL_PROFILE(BYTE_1(arg2))
> +                 argr = 0
> +
> + if BYTE_0(arg2) == 0x02:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 SET_FAN_SPEED_MULTIPLIER(BYTE_2(arg2))
> +                 argr = 0
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> +.. note::
> +   While you can manually change the fan speed multiplier with this method,
> +   Dell's BIOS tends to overwrite this changes anyway.
> +
> +These are the known thermal profile codes:
> +
> +::
> +
> + CUSTOM                         0x00
> +
> + QUIET                          0x96
> + BALANCED                       0x97
> + BALANCED_PERFORMANCE           0x98
> + PERFORMANCE                    0x99
> +
> + QUIET_USTT                     0xA3
> + BALANCED_USTT                  0xA0
> + BALANCED_PERFORMANCE_USTT      0xA1
> + PERFORMANCE_USTT               0xA4
> + LOW_POWER_USTT                 0xA5
> +
> + GMODE                          0xAB
> +
> +Usually if a model doesn't support the first four profiles they will support
> +the User Selectable Thermal Tables (USTT) profiles and vice-versa.
> +
> +GMODE replaces PERFORMANCE in G-Series laptops.
> +
> +Very grateful to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for discovering
> +some of the codes compatible with G-Series laptops.

Maybe use some less personal wording to give kudos and perhaps put it into 
the end of the doc.

-- 
 i.


> +WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 1:
> +        if is_valid_fan(BYTE_1(arg2)):
> +                argr = 1
> +        else:
> +                argr = 0
> +
> + if BYTE_0(arg2) == 2:
> +        if is_valid_fan(BYTE_1(arg2)):
> +                if BYTE_2(arg2) == 0:
> +                        argr == SENSOR_ID
> +                else
> +                        argr == 0xFFFFFFFF
> +        else:
> +                argr = 0
> +
> +Overclocking Methods
> +====================
> +
> +.. warning::
> +   These methods have not been tested and are only partially reverse
> +   engineered.
> +
> +WMI method Return_OverclockingReport([out] uint32 argr)
> +-------------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr = 0
> +
> +CSMI is an unknown operation.
> +
> +WMI method Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr = 0
> +
> +CSMI is an unknown operation
> +
> +WMI method Clear_OCFailSafeFlag([out] uint32 argr)
> +--------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr = 0
> +
> +CSMI is an unknown operation
> +
> +
> +WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +AWCC supports memory overclocking, but this method is very intricate and has
> +not been deciphered yet.
> +
> +GPIO methods
> +============
> +
> +These methods are probably related to some kind of firmware update system,
> +through a GPIO device.
> +
> +.. warning::
> +   These methods have not been tested and are only partially reverse
> +   engineered.
> +
> +WMI method FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr)
> +------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 0:
> +         if BYTE_1(arg2) == 1:
> +                 SET_PIN_A_HIGH()
> +         else:
> +                 SET_PIN_A_LOW()
> +
> + if BYTE_0(arg2) == 1:
> +         if BYTE_1(arg2) == 1:
> +                 SET_PIN_B_HIGH()
> +
> +         else:
> +                 SET_PIN_B_LOW()
> +
> + else:
> +         argr = 1
> +
> +WMI method ReadTotalofGPIOs([out] uint32 argr)
> +----------------------------------------------
> +
> +::
> +
> + argr = 0x02
> +
> +WMI method ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)
> +------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 0:
> +         argr = PIN_A_STATUS
> +
> + if BYTE_0(arg2) == 1:
> +         argr = PIN_B_STATUS
> +
> +
> +Other information Methods
> +=========================
> +
> +WMI method SystemInformation([in] uint32 arg2, [out] uint32 argr)
> +-----------------------------------------------------------------
> +
> +Returns unknown information.
> +
> +WMI method PowerInformation([in] uint32 arg2, [out] uint32 argr)
> +----------------------------------------------------------------
> +
> +Returns unknown information.
> +
> +WMI method ReadChassisColor([out] uint32 argr)
> +----------------------------------------------
> +
> +::
> +
> + argr = CHASSIS_COLOR_ID
> +
> +WMI method ReadPlatformProperties([out] uint32 argr)
> +----------------------------------------------------
> +
> +Returns unknown information.
> +
> 


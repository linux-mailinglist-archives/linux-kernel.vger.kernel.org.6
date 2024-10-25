Return-Path: <linux-kernel+bounces-381847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A99B053E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71341C21118
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922A11EF958;
	Fri, 25 Oct 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPr8Y26Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFC212182;
	Fri, 25 Oct 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865609; cv=none; b=VLt9Zo/aDQSe5FNFcjp+W6380gf9LovVULg0pgjcBPFTIONiHRTx1lhP0YoBP0p/UprnG9o8Z1Qn4XU3LF647lJsva0/s02XzPDio4nYi1cwvsk+lSLps1z109TbciKqYsz5pi3VaD45e7SY4FDelS6GXi+bMYQmkkSjuAdc7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865609; c=relaxed/simple;
	bh=tmxafC4sAtIOobQ05Wlyq5XT0T0lPCRKYjFwTupyqB4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kIZYru588pbjwzAHT1DJrmT18ITY+xqdV59r7n23Vlvn11yw1bV2VZ6hpeVQAJMIbpVAouRS6t3HsMjkyX0n1O8lbbicBCdmukfBeKOGwS7+sGk6slsdKWpemCC0EPOgXdkyGMQB4AY/nlEcKhja/t1Ds1LMGgRSJWIqZDNZlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPr8Y26Y; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729865607; x=1761401607;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tmxafC4sAtIOobQ05Wlyq5XT0T0lPCRKYjFwTupyqB4=;
  b=dPr8Y26Yb00GZps6kVVI3Zr8ab5d03Dt5Tz06tA9C5Y0yFXXA5Nlggof
   xppjOWe3R+r9HfHVmuyhRFnRy417Mm++oOT6Bt0F6FWB5gZo/E9im/e9i
   /3JmoInvTM5UoOyDWer748E2A+fSi5nXwCOpPMsM0/ts6bCf4p/KCtoyM
   0pGhPuC4poBwic1fn3Lw8CNTyQ5KGXXyyYGu+aoDED7VPFtyC8dhZVzcW
   MI5hm7DfH6CJpTV/5jLYvqYdc8EKvnAlH1za83abnW/iPwANRtH1gsalk
   ZGzA7XEoFpFzSAJd+9uYSXw/VAq2A9TTdizOoKqQm2EkZ9luj+PiX7XQr
   A==;
X-CSE-ConnectionGUID: K14T20xCRzOdPq+XwHCLCg==
X-CSE-MsgGUID: YDACbm+7TrOCTr/bLQ7kQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29480322"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29480322"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:13:27 -0700
X-CSE-ConnectionGUID: A8cgGIrqSS2e+50GNM58NA==
X-CSE-MsgGUID: lpnmDMGTTA6FTS9UVXP4Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80855219"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:13:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 17:13:21 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v8 4/4] alienware-wmi: WMAX interface documentation
In-Reply-To: <20241025014229.5716-2-kuurtb@gmail.com>
Message-ID: <46954fcd-01fb-ff36-dfc8-33f240706098@linux.intel.com>
References: <20241025013856.4729-2-kuurtb@gmail.com> <20241025014229.5716-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1737758138-1729865601=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1737758138-1729865601=:946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2024, Kurt Borja wrote:

> Added documentation for new WMAX interface, present on some Alienware
> X-Series, Alienware M-Series and Dell's G-Series laptops.
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
> v8:
>  - Unchanged
> v7:
>  - Added GameShiftStatus method to documentation
>  - Added remark about operation 0x03 of Thermal_Information method
>  - Removed undocumented methods
> v6:
>  - Fixed typos
>  - Included new file in MAINTAINERS
> ---
>  Documentation/wmi/devices/alienware-wmi.rst | 388 ++++++++++++++++++++
>  MAINTAINERS                                 |   1 +
>  2 files changed, 389 insertions(+)
>  create mode 100644 Documentation/wmi/devices/alienware-wmi.rst
>=20
> diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation/=
wmi/devices/alienware-wmi.rst
> new file mode 100644
> index 000000000..36a67ff9a
> --- /dev/null
> +++ b/Documentation/wmi/devices/alienware-wmi.rst
> @@ -0,0 +1,388 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Dell AWCC WMI interface driver (alienware-wmi)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The WMI device WMAX has been implemented for many Alienware and Dell's G=
-Series
> +models. Throughout these models, two implementations have been identifie=
d. The
> +first one, used by older systems, deals with HDMI, brightness, RGB, ampl=
ifier
> +and deep sleep control. The second one used by newer systems deals prima=
rily
> +with thermal, overclocking, and GPIO control.
> +
> +It is suspected that the latter is used by Alienware Command Center (AWC=
C) to
> +manage manufacturer predefined thermal profiles. The alienware-wmi drive=
r
> +exposes Thermal_Information and Thermal_Control methods through the Plat=
form
> +Profile API to mimic AWCC's behavior.
> +
> +This newer interface, named AWCCMethodFunction has been reverse engineer=
ed, as
> +Dell has not provided any official documentation. We will try to describ=
e to the
> +best of our ability its discovered inner workings.
> +
> +.. note::
> +   The following method description may be incomplete and some operation=
s have
> +   different implementations between devices.
> +
> +WMI interface description
> +-------------------------
> +
> +The WMI interface description can be decoded from the embedded binary MO=
F (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> + [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("W=
MI Function"), guid("{A70591CE-A997-11DA-B012-B622A1EF5492}")]
> + class AWCCWmiMethodFunction {
> +   [key, read] string InstanceName;
> +   [read] boolean Active;
> +
> +   [WmiMethodId(13), Implemented, read, write, Description("Return Overc=
locking Report.")] void Return_OverclockingReport([out] uint32 argr);
> +   [WmiMethodId(14), Implemented, read, write, Description("Set OCUIBIOS=
 Control.")] void Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(15), Implemented, read, write, Description("Clear OC Fai=
lSafe Flag.")] void Clear_OCFailSafeFlag([out] uint32 argr);
> +   [WmiMethodId(19), Implemented, read, write, Description("Get Fan Sens=
ors.")] void GetFanSensors([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(20), Implemented, read, write, Description("Thermal Info=
rmation.")] void Thermal_Information([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(21), Implemented, read, write, Description("Thermal Cont=
rol.")] void Thermal_Control([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(23), Implemented, read, write, Description("MemoryOCCont=
rol.")] void MemoryOCControl([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(26), Implemented, read, write, Description("System Infor=
mation.")] void SystemInformation([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(28), Implemented, read, write, Description("Power Inform=
ation.")] void PowerInformation([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(32), Implemented, read, write, Description("FW Update GP=
IO toggle.")] void FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(33), Implemented, read, write, Description("Read Total o=
f GPIOs.")] void ReadTotalofGPIOs([out] uint32 argr);
> +   [WmiMethodId(34), Implemented, read, write, Description("Read GPIO pi=
n Status.")] void ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(35), Implemented, read, write, Description("Read Chassis=
 Color.")] void ReadChassisColor([out] uint32 argr);
> +   [WmiMethodId(36), Implemented, read, write, Description("Read Platfor=
m Properties.")] void ReadPlatformProperties([out] uint32 argr);
> +   [WmiMethodId(37), Implemented, read, write, Description("Game Shift S=
tatus.")] void GameShiftStatus([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(128), Implemented, read, write, Description("Caldera SW =
installation.")] void CalderaSWInstallation([out] uint32 argr);
> +   [WmiMethodId(129), Implemented, read, write, Description("Caldera SW =
is released.")] void CalderaSWReleased([out] uint32 argr);
> +   [WmiMethodId(130), Implemented, read, write, Description("Caldera Con=
nection Status.")] void CalderaConnectionStatus([in] uint32 arg2, [out] uin=
t32 argr);
> +   [WmiMethodId(131), Implemented, read, write, Description("Surprise Un=
plugged Flag Status.")] void SurpriseUnpluggedFlagStatus([out] uint32 argr)=
;
> +   [WmiMethodId(132), Implemented, read, write, Description("Clear Surpr=
ise Unplugged Flag.")] void ClearSurpriseUnpluggedFlag([out] uint32 argr);
> +   [WmiMethodId(133), Implemented, read, write, Description("Cancel Undo=
ck Request.")] void CancelUndockRequest([out] uint32 argr);
> +   [WmiMethodId(135), Implemented, read, write, Description("Devices in =
Caldera.")] void DevicesInCaldera([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(136), Implemented, read, write, Description("Notify BIOS=
 for SW ready to disconnect Caldera.")] void NotifyBIOSForSWReadyToDisconne=
ctCaldera([out] uint32 argr);
> +   [WmiMethodId(160), Implemented, read, write, Description("Tobii SW in=
stallation.")] void TobiiSWinstallation([out] uint32 argr);
> +   [WmiMethodId(161), Implemented, read, write, Description("Tobii SW Re=
leased.")] void TobiiSWReleased([out] uint32 argr);
> +   [WmiMethodId(162), Implemented, read, write, Description("Tobii Camer=
a Power Reset.")] void TobiiCameraPowerReset([out] uint32 argr);
> +   [WmiMethodId(163), Implemented, read, write, Description("Tobii Camer=
a Power On.")] void TobiiCameraPowerOn([out] uint32 argr);
> +   [WmiMethodId(164), Implemented, read, write, Description("Tobii Camer=
a Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
> + };
> +
> +Some of these methods get quite intricate so we will describe them using
> +pseudo-code that vaguely resembles the original ASL code.
> +
> +Methods not described in the following document have unknown behavior.
> +
> +Argument Structure
> +------------------
> +
> +All input arguments have type **uint32** and their structure is very sim=
ilar
> +between methods. Usually, the first byte corresponds to a specific *oper=
ation*
> +the method performs, and the subsequent bytes correspond to *arguments* =
passed
> +to this *operation*. For example, if an operation has code 0x01 and requ=
ires an
> +ID 0xA0, the argument you would pass to the method is 0xA001.
> +
> +
> +Thermal Methods
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0x01:
> +         argr =3D 1
> +
> + if BYTE_0(arg2) =3D=3D 0x02:
> +         argr =3D UNKNOWN_CONSTANT
> +
> + if BYTE_0(arg2) =3D=3D 0x03:
> +         if BYTE_1(arg2) =3D=3D 0x00:
> +                 argr =3D FAN_ID_0
> +
> +         if BYTE_1(arg2) =3D=3D 0x01:
> +                 argr =3D FAN_ID_1
> +
> +         if BYTE_1(arg2) =3D=3D 0x02:
> +                 argr =3D FAN_ID_2
> +
> +         if BYTE_1(arg2) =3D=3D 0x03:
> +                 argr =3D FAN_ID_3
> +
> +         if BYTE_1(arg2) =3D=3D 0x04:
> +                 argr =3D SENSOR_ID_CPU | 0x0100
> +
> +         if BYTE_1(arg2) =3D=3D 0x05:
> +                 argr =3D SENSOR_ID_GPU | 0x0100
> +
> +         if BYTE_1(arg2) =3D=3D 0x06:
> +                 argr =3D THERMAL_MODE_QUIET_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x07:
> +                 argr =3D THERMAL_MODE_BALANCED_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x08:
> +                 argr =3D THERMAL_MODE_BALANCED_PERFORMANCE_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x09:
> +                 argr =3D THERMAL_MODE_PERFORMANCE_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x0A:
> +                 argr =3D THERMAL_MODE_LOW_POWER_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x0B:
> +                 argr =3D THERMAL_MODE_GMODE_ID
> +
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> + if BYTE_0(arg2) =3D=3D 0x04:
> +         if is_valid_sensor(BYTE_1(arg2)):
> +                 argr =3D SENSOR_TEMP_C
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> + if BYTE_0(arg2) =3D=3D 0x05:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr =3D FAN_RPM()
> +
> + if BYTE_0(arg2) =3D=3D 0x06:
> +         skip
> +
> + if BYTE_0(arg2) =3D=3D 0x07:
> +         argr =3D 0
> +
> + If BYTE_0(arg2) =3D=3D 0x08:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr =3D 0
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> + if BYTE_0(arg2) =3D=3D 0x09:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr =3D FAN_UNKNOWN_STAT_0()
> +
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> + if BYTE_0(arg2) =3D=3D 0x0A:
> +         argr =3D THERMAL_MODE_BALANCED_ID
> +
> + if BYTE_0(arg2) =3D=3D 0x0B:
> +         argr =3D CURRENT_THERMAL_MODE()
> +
> + if BYTE_0(arg2) =3D=3D 0x0C:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr =3D FAN_UNKNOWN_STAT_1()
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> +Operation 0x03 list all available fan IDs, sensor IDs and thermal profil=
e
> +codes in order, but different models may have different number of fans a=
nd
> +thermal profiles. These are the known ranges:
> +
> +* Fan IDs: from 2 up to 4
> +* Sensor IDs: 2
> +* Thermal profile codes: from 1 up to 7
> +
> +In total BYTE_1(ARG2) may range from 0x5 up to 0xD depending on the mode=
l.
> +
> +WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0x01:
> +         if is_valid_thermal_profile(BYTE_1(arg2)):
> +                 SET_THERMAL_PROFILE(BYTE_1(arg2))
> +                 argr =3D 0
> +
> + if BYTE_0(arg2) =3D=3D 0x02:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 SET_FAN_SPEED_MULTIPLIER(BYTE_2(arg2))
> +                 argr =3D 0
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> +.. note::
> +   While you can manually change the fan speed multiplier with this meth=
od,
> +   Dell's BIOS tends to overwrite this changes anyway.
> +
> +These are the known thermal profile codes:
> +
> +::
> +
> + CUSTOM                         0x00
> +
> + BALANCED_USTT                  0xA0
> + BALANCED_PERFORMANCE_USTT      0xA1
> + COOL_USTT                      0xA2
> + QUIET_USTT                     0xA3
> + PERFORMANCE_USTT               0xA4
> + LOW_POWER_USTT                 0xA5
> +
> + QUIET                          0x96
> + BALANCED                       0x97
> + BALANCED_PERFORMANCE           0x98
> + PERFORMANCE                    0x99
> +
> + GMODE                          0xAB
> +
> +Usually if a model doesn't support the first four profiles they will sup=
port
> +the User Selectable Thermal Tables (USTT) profiles and vice-versa.
> +
> +GMODE replaces PERFORMANCE in G-Series laptops.
> +
> +WMI method GameShiftStatus([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0x1:
> +         TOGGLE_GAME_SHIFT()
> +         argr =3D GET_GAME_SHIFT_STATUS()
> +
> + if BYTE_0(arg2) =3D=3D 0x2:
> +         argr =3D GET_GAME_SHIFT_STATUS()
> +
> +Game Shift Status does not change the fan speed profile but it could be =
some
> +sort of CPU/GPU power profile. Benchmarks have not been done.
> +
> +This method is only present on Dell's G-Series laptops and it's implemen=
tation
> +implies GMODE thermal profile is available, even if operation 0x03 of
> +Thermal_Information does not list it.
> +
> +G-key on Dell's G-Series laptops also changes Game Shift status, so both=
 are
> +directly related.
> +
> +WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0x1:
> +        if is_valid_fan(BYTE_1(arg2)):
> +                argr =3D 1
> +        else:
> +                argr =3D 0
> +
> + if BYTE_0(arg2) =3D=3D 0x2:
> +        if is_valid_fan(BYTE_1(arg2)):
> +                if BYTE_2(arg2) =3D=3D 0:
> +                        argr =3D=3D SENSOR_ID
> +                else
> +                        argr =3D=3D 0xFFFFFFFF
> +        else:
> +                argr =3D 0
> +
> +Overclocking Methods
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> + argr =3D 0
> +
> +CSMI is an unknown operation.
> +
> +WMI method Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr =3D 0
> +
> +CSMI is an unknown operation.
> +
> +WMI method Clear_OCFailSafeFlag([out] uint32 argr)
> +--------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr =3D 0
> +
> +CSMI is an unknown operation.
> +
> +
> +WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +AWCC supports memory overclocking, but this method is very intricate and=
 has
> +not been deciphered yet.
> +
> +GPIO methods
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These methods are probably related to some kind of firmware update syste=
m,
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
> + if BYTE_0(arg2) =3D=3D 0:
> +         if BYTE_1(arg2) =3D=3D 1:
> +                 SET_PIN_A_HIGH()
> +         else:
> +                 SET_PIN_A_LOW()
> +
> + if BYTE_0(arg2) =3D=3D 1:
> +         if BYTE_1(arg2) =3D=3D 1:
> +                 SET_PIN_B_HIGH()
> +
> +         else:
> +                 SET_PIN_B_LOW()
> +
> + else:
> +         argr =3D 1
> +
> +WMI method ReadTotalofGPIOs([out] uint32 argr)
> +----------------------------------------------
> +
> +::
> +
> + argr =3D 0x02
> +
> +WMI method ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)
> +------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0:
> +         argr =3D PIN_A_STATUS
> +
> + if BYTE_0(arg2) =3D=3D 1:
> +         argr =3D PIN_B_STATUS
> +
> +Other information Methods
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +WMI method ReadChassisColor([out] uint32 argr)
> +----------------------------------------------
> +
> +::
> +
> + argr =3D CHASSIS_COLOR_ID
> +
> +Acknowledgements
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for documenting
> +and testing available thermal profile codes.
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f31907..25f6de4c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -792,6 +792,7 @@ F:=09drivers/perf/alibaba_uncore_drw_pmu.c
>  ALIENWARE WMI DRIVER
>  L:=09Dell.Client.Kernel@dell.com
>  S:=09Maintained
> +F:=09Documentation/wmi/devices/alienware-wmi.rst
>  F:=09drivers/platform/x86/dell/alienware-wmi.c
> =20
>  ALLEGRO DVT VIDEO IP CORE DRIVER
>=20
--8323328-1737758138-1729865601=:946--


Return-Path: <linux-kernel+bounces-227333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D404914F91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0E1B2116F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3E142645;
	Mon, 24 Jun 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SufMm8kh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171920330;
	Mon, 24 Jun 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238077; cv=none; b=bTyld8luMg37L48KCIrjUe2TDX/gHh446Q4aBLhPF15VoWsBqQQV+RA07Ooqwr8BIJAyY2s2J9PMT2WASHYdxUjqWDVeltMbdNGZUCk3hOO9xKNIyrfLoonkJNx8FW5inCYkkLvxFNLZ89saInP3HYziLUId6cG+1BAj22+5UdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238077; c=relaxed/simple;
	bh=gG6A1sfT6art2Hnx0MB8cHTUZZh1UehVmPWJo5twswg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CS30GcYz13AR0A9+WThNHGzD92a7z9VlceVsSr8RcXXyPsAqHdzBeeDZcgauCfKDaeV7qiikg8kC2ShRTipuPhSlSWPmljQfqbN4vaRn472K4ip/rk3G5zvsjg1AOempRrCWZDRnPB9tDhPByDNcmtBtqOeBy8bsDs2Tf2ft23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SufMm8kh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719238076; x=1750774076;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gG6A1sfT6art2Hnx0MB8cHTUZZh1UehVmPWJo5twswg=;
  b=SufMm8kh8ixddZgoNN3uWUNsvyfTiAfew4/0Jr+FC81v6z6ocNiq8RT9
   052WnZ3tdMdwNpzgjZP/MzQ2CPeKtH6RrXrOyLQ/H2XL02PK72GB4WiSZ
   GGgiaErfNlmrnTM4QUMqGywAzWouW3uAJh0Owj/yU37Fy2gU9nFTY7SpG
   et9uvWMjPFY73cd1sshHXNlt1KkJ5UWrSo9UXhltCnaRSK8z37QJeVVbc
   bTObyFiVt4yOFHU0Fxh2RLI8jwYgnNN4sACNJmO4rsJjx+WsZehHBNfRU
   HSfcLws7UdewjfwIbItwgI0nv8aKJyxn6z46A1sH4qzOa3WiU2c+0mtQS
   A==;
X-CSE-ConnectionGUID: TcmNHOk5SLi1HAhGTGJGKw==
X-CSE-MsgGUID: EuGBpKxJRMuE9ZtvOF5OJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="38724790"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="38724790"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 07:07:55 -0700
X-CSE-ConnectionGUID: s2LuhTOPRs+wiVIv9ABnQA==
X-CSE-MsgGUID: GVEMa+qEQJyh14YItXcL7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43120700"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.61])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 07:07:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Jun 2024 17:07:48 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, corbet@lwn.net, 
    platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: wmi: Add bus ABI documentation
In-Reply-To: <20240620194214.3071-3-W_Armin@gmx.de>
Message-ID: <ed5edb04-a69e-771b-102c-5cdceef4e5c0@linux.intel.com>
References: <20240620194214.3071-1-W_Armin@gmx.de> <20240620194214.3071-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1396269108-1719238068=:1031"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1396269108-1719238068=:1031
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 20 Jun 2024, Armin Wolf wrote:

> Add documentation for the WMI bus sysfs interface so userspace
> applications can use it to access additional data about WMI devices.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/ABI/testing/sysfs-bus-wmi | 79 +++++++++++++++++++++++++
>  MAINTAINERS                             |  1 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-wmi
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-wmi b/Documentation/ABI/=
testing/sysfs-bus-wmi
> new file mode 100644
> index 000000000000..496d602b67c6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-wmi
> @@ -0,0 +1,79 @@
> +What:=09=09/sys/bus/wmi/devices/.../driver_override
> +Date:=09=09February 2024
> +Contact:=09Armin Wolf <W_Armin@gmx.de>
> +Description:
> +=09=09This file allows the driver for a device to be specified which
> +=09=09will override standard ID table matching.
> +=09=09When specified, only a driver with a name matching the value
> +=09=09written to driver_override will have an opportunity to bind
> +=09=09to the device. The override is specified by writing a string
> +=09=09to the driver_override file (echo wmi-event-dummy > \
> +=09=09driver_override) and may be cleared with an empty string

I suggest replacing:

"and" -> ". The override"

> +=09=09(echo > driver_override). This returns the device to standard

". This" -> which

to make the internal referencing crystal clear.

> +=09=09matching rules binding. Writing to driver_override does not
> +=09=09automatically unbind the device from its current driver or make
> +=09=09any attempt to automatically load the specified driver. If no
> +=09=09driver with a matching name is currently loaded in the kernel,
> +=09=09the device will not bind to any driver. This also allows
> +=09=09devices to opt-out of driver binding using a driver_override
> +=09=09name such as "none". Only a single driver may be specified in
> +=09=09the override, there is no support for parsing delimiters.
> +
> +What:=09=09/sys/bus/wmi/devices/.../modalias
> +Date:=09=09November 2015
> +Contact:=09Andy Lutomirski <luto@kernel.org>
> +Description:
> +=09=09This file contains the MODALIAS value emitted by uevent for a
> +=09=09given WMI device.
> +
> +=09=09Format: wmi:XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX.
> +
> +What:=09=09/sys/bus/wmi/devices/.../guid
> +Date:=09=09November 2015
> +Contact:=09Andy Lutomirski <luto@kernel.org>
> +Description:
> +=09=09This file contains the GUID used to match WMI devices to
> +=09=09compatible WMI drivers. This GUID is not necessarily unique
> +=09=09inside a given machine, it is solely used to identify the
> +=09=09interface exposed by a given WMI device.
> +
> +What:=09=09/sys/bus/wmi/devices/.../object_id
> +Date:=09=09November 2015
> +Contact:=09Andy Lutomirski <luto@kernel.org>
> +Description:
> +=09=09This file contains the WMI object ID used internally to construct
> +=09=09the ACPI method names used by non-event WMI devices. It contains
> +=09=09two ASCII letters.
> +
> +What:=09=09/sys/bus/wmi/devices/.../notify_id
> +Date:=09=09November 2015
> +Contact:=09Andy Lutomirski <luto@kernel.org>
> +Description:
> +=09=09This file contains the WMI notify ID used internally to map ACPI
> +=09=09events to WMI event devices. It contains two ASCII letters.
> +
> +What:=09=09/sys/bus/wmi/devices/.../instance_count
> +Date:=09=09November 2015
> +Contact:=09Andy Lutomirski <luto@kernel.org>
> +Description:
> +=09=09This file contains the number of WMI object instances being
> +=09=09present on a given WMI device. It contains a non-negative
> +=09=09number.
> +
> +What:=09=09/sys/bus/wmi/devices/.../expensive
> +Date:=09=09November 2015
> +Contact:=09Andy Lutomirski <luto@kernel.org>
> +Description:
> +=09=09This file contains a boolean flag signaling if interacting with
> +=09=09the given WMI device will consume significant CPU resources.
> +=09=09The WMI driver core will take care of enabling/disabling such
> +=09=09WMI devices.
> +
> +What:=09=09/sys/bus/wmi/devices/.../setable
> +Date:=09=09May 2017
> +Contact:=09Darren Hart (VMware) <dvhart@infradead.org>
> +Description:
> +=09=09This file contains a boolean flags signaling the data block
> +=09=09aassociated with the given WMI device is writable. If the
> +=09=09given WMI device is not associated with a data block, then
> +=09=09this file will not exist.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09ff0dfd65cb..4f76d6a5d348 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -392,6 +392,7 @@ ACPI WMI DRIVER
>  M:=09Armin Wolf <W_Armin@gmx.de>
>  L:=09platform-driver-x86@vger.kernel.org
>  S:=09Maintained
> +F:=09Documentation/ABI/testing/sysfs-bus-wmi
>  F:=09Documentation/driver-api/wmi.rst
>  F:=09Documentation/wmi/
>  F:=09drivers/platform/x86/wmi.c

Other than the this issue above, this looked fine,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1396269108-1719238068=:1031--


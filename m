Return-Path: <linux-kernel+bounces-282593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5A94E639
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5391C21513
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85B133987;
	Mon, 12 Aug 2024 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bzt6Q3Ft"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C763C0B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441442; cv=none; b=KRGGQw3T2UFqWf5bPCA5U8Z6NcQMBJBtJc6/Eh/dw6GA0XtvUYVFDVQyIzOqujDovSRbDuUTjggDvgaYbqPBv6kQ3+kj/0V5yw9MW1q3tP+QMF3qzZS/yxNJOteJJ60fpG9YP8aqr2bdhavrbCovJGvKFoklIHe8qlp5odVfiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441442; c=relaxed/simple;
	bh=y9IK7rto1xK3oSG50BunGzE/rwqSWxpVKZCoYgVQJ5w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3bFFiG+ad30cm6MzytPeqNBSKOiCBVH26rNakUEiVhzcMq3nJxaJ73upeTggYQiiuDuKAgKJwp5tnemf9Vjj5b2zGJ4h0hEg03EXoNMsgZFqzi93txU4i8jrKzx3decj5HBDuN0HCH8O/SWd7KznQqbXuXGPPCfIA7G1TPh4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bzt6Q3Ft; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47C5hcwa040969;
	Mon, 12 Aug 2024 00:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723441418;
	bh=14BB/GnX764UF0lLsGKNlUlwXAwTjTCuAxhCG1KLL/I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Bzt6Q3Ft2/Lim85dfYADl8SjsBWh86NzFzuRhx10ISC6DM/qdjX9t3M4Of/d5PiUQ
	 RyRH6XS0X9eyNnrey3Rek+2WgkN7vrjVQWD3DckbvcBZLUw/bz+ioMP3z+MIjNNqFG
	 +2EE5fffL3uLisc1pxLeu3b2TNXVUhEOcOMJyQrY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47C5hbcC007558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 00:43:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 00:43:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 00:43:37 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47C5ha38089430;
	Mon, 12 Aug 2024 00:43:37 -0500
Date: Mon, 12 Aug 2024 11:13:36 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin
 Hilman <khilman@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 0/4] firmware: ti_sci: Introduce system suspend support
Message-ID: <20240812054336.db36hcp7faz23fdl@lcpd911>
References: <20240809135347.2112634-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809135347.2112634-1-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 09, 2024 at 15:53:43 +0200, Markus Schneider-Pargmann wrote:
> Abstract
> ********
> 
> This series introduces necessary ti_sci driver functionality to support
> various Suspend-to-RAM modes on TI AM62 family of devices. These Low
> Power Modes include Deep Sleep and MCU Only as described in section
> "6.2.4 Power Modes" of the AM62x Technical Reference Manual [0].

Since this code is common across AM62x, AM62A, AM62P, I think a more
suitable TRM link to give would be the AM62P TRM:

https://www.ti.com/lit/pdf/SPRUJ83

Reason: It covers more modes than the AM62x

> 
> Summary
> *******
> 
> This series is a restructuring and rebase of the patch series by
> Dave Gerlach [1] and Dhruva Gole [2]. It applies on top of Linux
> 6.11-rc1.
> 
> The kernel triggers entry to Low Power Mode through the mem suspend
> transition with the following:
> 
> * At the bootloader stage, one is expected to package the TIFS stub
>   which then gets pulled into the Tightly coupled memory of the Device Mgr
>   (DM) R5 when it starts up. If using U-Boot, then it requires tispl.bin
>   to contain the TIFS stub. Refer to ti-u-boot patch [3] for further

Everything is now in upstream U-Boot, hence I prefer to share upstream
ie. non-vendor tree links at this point.

Documentation: https://source.denx.de/u-boot/u-boot/-/commit/962f60abca82bb11501bc0c627abacda15bed076
Sample TIFS Stub packaging patch:
https://source.denx.de/u-boot/u-boot/-/commit/93458ba599f753dcc5b6fea661cf71a50e8c5bd2

Patches that introduced the base support:
https://source.denx.de/u-boot/u-boot/-/commit/4a0067c8575c7c3b98f3fc0a689f53dc80700393
https://source.denx.de/u-boot/u-boot/-/commit/128f81290b7d4f20a11c7754798b1896575b7a29

>   details. The supported firmware version is from TI Processor SDK
>   >= 10.00 ie. tag 10.00.04 from ti-linux-firmware [4].
> 
> * Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call. This causes
>   system to use PSCI system suspend as last step of mem sleep.
> 
> * We add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
>   the firmware capabilities of the currently running system firmware [6].
>   Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability, where
>   Device Mgr firmware now manages which low power mode is chosen. Going
>   forward, this is the default configuration supported for TI AM62 family
>   of devices. The state chosen by the DM can be influenced by sending
>   constraints using the new LPM constraint APIs. (Patch 1)
> 
> * The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
>   message in order to provide details about suspend. The ti_sci driver
>   must send this message to firmware with the above information
>   included, which it does during the driver suspend handler when
>   PM_MEM_SUSPEND is the determined state being entered. The mode being
>   sent depends on whether firmware capabilities have support for
>   LPM_DM_MANAGED feature. Legacy firmware or those supporting other
>   modes can extend the mode selection logic as needed. (Patch 2)
> 
> * We also add the remaining TISCI Low Power Mode messages required for
>   inquiring wake reason and managing LPM constraints as part of a new PM
>   ops. These messages are part of the TISCI PM Low Power Mode API [5].
>   (Patch 3)
> 
> * Finally if any CPUs have PM QoS resume latency constraints set, we
>   aggregate these and set the TISCI system-wide latency constraint.
>   (Patch 4)
> 
> Testing
> *******
> 
> This series can for example be tested with a am62a-lp-sk board.
> 
> For am62a-lp-sk all usb nodes have to be disabled at the moment (usbss0,
> usb0, usbss1 and usb1). There is currently an issue with USB Link Power
> Management and turning off the USB device which is being worked on.
> 
> Once booted suspend/resume can be tested with rtcwake:
>   $ rtcwake -m mem -s 10 -d /dev/rtc0
> 
> Make sure /dev/rtc0 corresponds to rtc-ti-k3:
>   $ dmesg | grep rtc-ti-k3
>   rtc-ti-k3 2b1f0000.rtc: registered as rtc0
> 
[...]

Do we need to add an alias here for this?
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/heads/master/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts#19

> 
> References:
> ***********
> 
> [0] https://www.ti.com/lit/pdf/spruiv7
> [1] https://lore.kernel.org/lkml/20220421203659.27853-1-d-gerlach@ti.com
> [2] https://lore.kernel.org/lkml/20230804115037.754994-1-d-gole@ti.com
> [3] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04&id=91886b68025c7ad121e62d1fc1fa4601eeb736cd
> [4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/?h=10.00.06&id=193f7d7570583a41ddc50a221e37c32be6be583e
> [5] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
> [6] https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps
> 
> Dave Gerlach (1):
>   firmware: ti_sci: Introduce Power Management Ops
> 
> Georgi Vlaev (1):
>   firmware: ti_sci: Add support for querying the firmware caps
> 
> Kevin Hilman (1):
>   firmware: ti_sci: add CPU latency constraint management
> 
> Vibhore Vardhan (1):
>   firmware: ti_sci: Add system suspend and resume call
> 
>  drivers/firmware/ti_sci.c              | 452 ++++++++++++++++++++++++-
>  drivers/firmware/ti_sci.h              | 137 +++++++-
>  include/linux/soc/ti/ti_sci_protocol.h |  46 +++
>  3 files changed, 633 insertions(+), 2 deletions(-)

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>


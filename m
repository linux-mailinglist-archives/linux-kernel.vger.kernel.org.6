Return-Path: <linux-kernel+bounces-293491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A48D958073
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD4C1C23C82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1310189912;
	Tue, 20 Aug 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o/R2xQ/g"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759A18E345
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141048; cv=none; b=ihe8OrTlq1v34/+0IyKuA6Etl7JRrNoFppBnw0GruzeVucLuAmFQ/ks51FXQD5UwEOYmHAFZGmo9UC0lbrie4mRtztUvQmoX5lXzPQ+scA8xi+xHz0cP/fwzBxXxDitjxBr3m3zSw9JxbNiEPnARBFJHLpnrcZhegSM/rXIIMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141048; c=relaxed/simple;
	bh=SW70CxfJatKW+Hd9KQfMdFXYwIZxaxrlkwZ7L3ZVsKg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1N2RyylGvK3C40Z7LIIKAKkfqDdGKdc2iQLWMi8s3VSiqNPzkJpXH1BnoniQSaIxCaYHsRmNGtp/VGuaIBxRKyo5TsqmkXcrWIP6KnLeEjaZDenl8EBvtpKZu85/oxLlfiCbYV4Sb1WFrEZvK5fliOspZB3pgdndHqZcj9W9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o/R2xQ/g; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47K83oBY057579;
	Tue, 20 Aug 2024 03:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724141031;
	bh=ov+WmYWO+uxNpV5X+OyFxw4pjxu2ZERVvOuhe8hgi/M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=o/R2xQ/gaU1JVAbD8oNNu0SqBz8fFK+d/0sNRFqknrVBVoUhh3SmeNpB08tUIu09o
	 I2E4i7UQFBSEPzb8OP6ifhFCUoHxv2XnpufyG1o9az532LBsyM+hl4hjoxqz/dIwKy
	 tTfJCbPClTND9qk5RCVtkEyeaakc9G00IHrHkJG8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47K83oDA046854
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 03:03:50 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 03:03:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 03:03:50 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47K83nmk077667;
	Tue, 20 Aug 2024 03:03:49 -0500
Date: Tue, 20 Aug 2024 13:33:49 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Akashdeep
 Kaur <a-kaur@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v10 0/4] firmware: ti_sci: Introduce system suspend
 support
Message-ID: <20240820080349.ypxrzvyy2bwettfu@lcpd911>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

On Aug 14, 2024 at 08:39:27 -0700, Kevin Hilman wrote:
> Abstract
> ********
> 
> This series introduces necessary ti_sci driver functionality to support
> various Suspend-to-RAM modes on TI AM62 family of devices. These Low
> Power Modes include Deep Sleep and MCU Only as described in section
> "6.2.4 Power Modes" of the AM62P Technical Reference Manual [0].
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
> * At the  bootloader stage, one is  expected to package the  TIFS stub
>   which then gets  pulled into the Tightly coupled memory  of the Device
>   Mgr  (DM) R5  when it  starts up.  If using  U-Boot, then  it requires
>   tispl.bin to contain the TIFS stub. Refer to documentation in upstream
>   u-boot[3] for further details. The  supported firmware version is from
>   TI Processor SDK >= 10.00 ie. tag 10.00.04 from ti-linux-firmware [4].
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

Additionally, one can refer to this guide for more details:
https://software-dl.ti.com/processor-sdk-linux/esd/AM62X/latest/exports/docs/linux/Foundational_Components/Power_Management/pm_low_power_modes.html

For the series,
Tested-by: Dhruva Gole <d-gole@ti.com>

Logs: https://gist.github.com/DhruvaG2000/658d0d4683b13ab41025df19a8eafc2f

Tree with all the patches applied:
https://github.com/DhruvaG2000/v-linux/tree/lpm-k3-next


-- 
Best regards,
Dhruva


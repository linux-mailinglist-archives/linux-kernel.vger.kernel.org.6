Return-Path: <linux-kernel+bounces-293522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C985E9580D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E12285D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E218A920;
	Tue, 20 Aug 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qTSiMalW"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267F12FB34
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142077; cv=none; b=j0hSjlxPIh1QfbNi41wDtkhvrO3fSGdfOBFiHg6X/EsWQxcKKHs9wULjtUCrpq29FOp9qCvBAbYVJ3sC+Bh+6catiZRJC3Oc8VWxqiHCFBhZAFOpFbSVeHoWuiepctzpdorTCRNnY/7OEAJZDZ8f+dD0cSiRXn10gkL+yusd+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142077; c=relaxed/simple;
	bh=xcpY/uiy4l6GpTctbyXeeM7AYfjwYqjpPxciHS5CS84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EPIKKbNRjCwVQBQdSYSinjYbcL2GVeK+13s8hBCHDyPsbLZoCOgHeWyqHkVYl19LuWc3pKgxpH4UKvJGiYsJxd8ho0l0T2mq0Oe5YKlmJgwVbc7vb3oUoygGANYy1ar3cYDwwH+WNzYVGUkTwvxqf2ZdoU0az1dv/oOTeu9S3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qTSiMalW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47K8Krgo069727;
	Tue, 20 Aug 2024 03:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724142053;
	bh=u2z2eg6vf6HwqPTVUlaZOK6+0jw2RLgUcS9SUFRXL2Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qTSiMalWE4Syj0SfoCVUQdGsxyq4zzZYxDbxuTNwBknL4Ggs6gMwcjR0xS7LAh0jL
	 D89hAbk1lOPUIuPKQMPr+nFHqq+yYatI5+rllMk7aVvMJxUlx+x+Wk0bLX06I2Gea2
	 KJL4YjpnLJSABwbVhBPqc02kj8iF7VEitY2bC4fc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47K8Kr5v066990
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 03:20:53 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 03:20:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 03:20:52 -0500
Received: from [172.24.227.249] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47K8KnoE097409;
	Tue, 20 Aug 2024 03:20:50 -0500
Message-ID: <6cde0930-5296-4707-a4b3-3ef060206625@ti.com>
Date: Tue, 20 Aug 2024 13:50:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/4] firmware: ti_sci: Introduce Power Management Ops
To: Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Markus
 Schneider-Pargmann <msp@baylibre.com>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
 <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14/08/24 21:09, Kevin Hilman wrote:
> From: Dave Gerlach <d-gerlach@ ti. com> Introduce power management ops 
> supported by the TISCI Low Power Mode API [1]. 1) 
> TISCI_MSG_LPM_WAKE_REASON Get which wake up source woke the SoC from Low 
> Power Mode. The wake up source IDs will be
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!tFdqXRfP9mwbCoXPtNggdrCuJ3bSsNDHabWG8s9g6Hh_v3tSab2OpTcpCeIxxvksAU_Fa5Zl41XmoQoqJiZdQtEck4kHNZot31hxXq-ZtaRCwdotcPeN9ST2tD8$>
> ZjQcmQRYFpfptBannerEnd
> 
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Introduce power management ops supported by the TISCI
> Low Power Mode API [1].
> 
> 1) TISCI_MSG_LPM_WAKE_REASON
> Get which wake up source woke the SoC from Low Power Mode.
> The wake up source IDs will be common for all K3 platforms.
> 
> 2) TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT
> Set LPM constraint on behalf of a device. By setting a constraint, the
> device ensures that it will not be powered off or reset in the selected
> mode.
> 
> 3) TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT
> Set LPM resume latency constraint. By setting a constraint, the host
> ensures that the resume time from selected mode will be less than the
> constraint value.
> 
> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [g-vlaev@ti.com: LPM_WAKE_REASON and IO_ISOLATION support]
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> [a-kaur@ti.com: SET_DEVICE_CONSTRAINT support]
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> [vibhore@ti.com: SET_LATENCY_CONSTRAINT support]
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
[...]

My concerns are now addressed.

Reviewed-by: Akashdeep Kaur <a-kaur@ti.com>


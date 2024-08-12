Return-Path: <linux-kernel+bounces-282599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0874A94E647
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9ED4282802
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C214D6FC;
	Mon, 12 Aug 2024 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ViWUIOqO"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB214D6F6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441660; cv=none; b=nGpbqoz2m6CTnbqqLOA5+GfYm2pQPDx2mEe8LP9eLajaaX6SkXRmFNo+7cYwB1vS+bi+UdzcHqdEsKKwkOY+ceB/u67dl5DP+jATfKiYTFdI3ErVgunWysKhZJ4OneLHSau8JGeFtgbKFsUxkfgV5LLixceI0gFgpydQuarBiBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441660; c=relaxed/simple;
	bh=rI2ibhMGbCBvPtXfvtacUFN5kOZzQRLEQMIpo6kwY5A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPX0aNqcYl2LpXQ6990c0dAnv4TMd0LOXSCpACVlndUI51Bl1idR1x7ax0NKHrb3r1FbVOf4qLI672Biz138gcfkSRAwMWXPR0KJiZyRcidY3paZXdPQgJRgzrGwt4CZ0C3P8zbBgcxovTdTd7LEPXBguzo0BhdoUvYnpZdCEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ViWUIOqO; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47C5lJV1121931;
	Mon, 12 Aug 2024 00:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723441639;
	bh=MXG0Q5niIRaWBY4zSjlw5KB2OrPvGy0f9cdXZcuHvxA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ViWUIOqODkCX9mNXqrbh/E0yU9M+nwVjQbtOZ6qXNvx55KCMAH/ntClRcPXFNSdL1
	 MflnrNfLZb+mQBv46GoogVnp6F6Re24oQluSg6lOAecRlBIn9BR+wKtUhSjVHeWB9x
	 UJY6m1sfZle7GOH0mpDz4T4TRg5/eUw83sTh1kLs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47C5lIPY026053
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 00:47:19 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 00:47:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 00:47:18 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47C5lHsm032796;
	Mon, 12 Aug 2024 00:47:18 -0500
Date: Mon, 12 Aug 2024 11:17:17 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh
 Shilimkar" <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        "Kevin
 Hilman" <khilman@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Georgi Vlaev
	<g-vlaev@ti.com>,
        Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v9 3/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <20240812054717.6lzkt3lxclzec3zy@lcpd911>
References: <20240809135347.2112634-1-msp@baylibre.com>
 <20240809135347.2112634-4-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809135347.2112634-4-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 09, 2024 at 15:53:46 +0200, Markus Schneider-Pargmann wrote:
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
> ---
[...]
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index 8efe4d0e61fb..9dd40b6711d4 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -38,7 +38,10 @@
>  
>  /* Low Power Mode Requests */
>  #define TI_SCI_MSG_PREPARE_SLEEP	0x0300
> +#define TI_SCI_MSG_LPM_WAKE_REASON	0x0306
>  #define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
> +#define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT	0x0309
> +#define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT	0x030A
>  
>  /* Resource Management Requests */
>  #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
> @@ -610,6 +613,73 @@ struct ti_sci_msg_req_set_io_isolation {
>  	u8 state;
>  } __packed;
>  
> +/**
> + * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
> + *
> + * @hdr:		Generic header.
> + * @wake_source:	The wake up source that woke soc from LPM.
> + * @wake_timestamp:	Timestamp at which soc woke.
> + *
> + * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
> + * used to query the wake up source from low power mode.
> + */
> +struct ti_sci_msg_resp_lpm_wake_reason {
> +	struct ti_sci_msg_hdr hdr;
> +	u32 wake_source;
> +	u64 wake_timestamp;
> +} __packed;
> +

It looks like we forgot to update the parameters in this API.
See [1]:

struct tisci_msg_lpm_wake_reason_req

We're missing here the wake_pin, mode and 2 rsvd fields as well.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-lpm-wake-reason

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>


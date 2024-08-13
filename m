Return-Path: <linux-kernel+bounces-284050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96F94FC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFF91F22B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F31CD0C;
	Tue, 13 Aug 2024 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hWUYn4em"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064491CA9E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520993; cv=none; b=HAXgKT8rbrk1fdBpxiCsXbWb2eByptMPpSudl/rGo1oC2gKFYW0k7rdm7K2jmf6jvmCnhNm3O9ot5s7HtLiSJnq7A1sm7U1mAfuvvI79VvQt0Vnnbk9U1zakrB0Rs4K7THjWmZjXg5bgwC9o+K0QvvIWe+5M5c90lseVg/ye6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520993; c=relaxed/simple;
	bh=26VgXcf8kQ3bRWKodd74sfD6CzEu0ZcOzApdKMZ3xqY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8H+lifT5N81Y0i8n3qRlXRs/pOV74BA5ieWQb3dFT7xd0rAqdfnFw2wl2DTKeSGJbDy8kqpqtStfJWxogqKGmAgUVAEKv1STkK9d3cXRky+NvL+7oKoRhryJtUBZjR4wLQsFQXEevvgwfD+cs95QJSe4D+pLNFd2KECUZcXCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hWUYn4em; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D3na2m090629;
	Mon, 12 Aug 2024 22:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723520977;
	bh=+e5MjfWpudv39Gxx6zPYNJy6Yw6AmGclY2+tnee5S0s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hWUYn4emwKwjJGOGREiFoSrb3mPML4PhE1KlYLCFxH3Begc9Q9sSILbMHsW/yuwrO
	 l6i33IJiCMv425yaOIxOeTqf4jDeQx3TsrgTiULWMgatezuY+Te6DiikQd0Roirxvc
	 /qOFRnBudKm9UHCejOrVUOk70E9m8EYISV2hGkUg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D3nahn016324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 22:49:36 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 22:49:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 22:49:36 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D3nZHT035512;
	Mon, 12 Aug 2024 22:49:36 -0500
Date: Tue, 13 Aug 2024 09:19:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Georgi Vlaev
	<g-vlaev@ti.com>,
        Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v9 3/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <20240813034935.wqehblov3e5gur3r@lcpd911>
References: <20240809135347.2112634-1-msp@baylibre.com>
 <20240809135347.2112634-4-msp@baylibre.com>
 <20240812054717.6lzkt3lxclzec3zy@lcpd911>
 <7hcymdphky.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7hcymdphky.fsf@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 12, 2024 at 14:16:45 -0700, Kevin Hilman wrote:
[...]
> >> +/**
> >> + * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
> >> + *
> >> + * @hdr:		Generic header.
> >> + * @wake_source:	The wake up source that woke soc from LPM.
> >> + * @wake_timestamp:	Timestamp at which soc woke.
> >> + *
> >> + * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
> >> + * used to query the wake up source from low power mode.
> >> + */
> >> +struct ti_sci_msg_resp_lpm_wake_reason {
> >> +	struct ti_sci_msg_hdr hdr;
> >> +	u32 wake_source;
> >> +	u64 wake_timestamp;
> >> +} __packed;
> >> +
> >
> > It looks like we forgot to update the parameters in this API.
> > See [1]:
> >
> > struct tisci_msg_lpm_wake_reason_req
> >
> > We're missing here the wake_pin, mode and 2 rsvd fields as well.
> >
> > [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-lpm-wake-reason
> >
> 
> The docs mention how to interpret the pin, but not the mode.  This
> driver should translate this mode number to some human-readable state
> for better debug messages.
> 
> Kevin

Agreed, we would all benefit from a logic that prints the human-readable
state. The way to interpret the mode would be just as:
https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#supported-low-power-modes

So for eg. 0x0 = TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>


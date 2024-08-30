Return-Path: <linux-kernel+bounces-308030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F26B96564C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877ECB2295E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199EF14A60D;
	Fri, 30 Aug 2024 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sxqj3D2j"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAA1411C8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992212; cv=none; b=aG5U+bPzkISmFUwjeWiPAlj3HrkBu9KFfBHU0eAZ0Q6d4rE4x2h+0h/kcHoxGlkjNuD8XD/vI7V8hB6mg2dDj6T7Yg92ONXCGpSvEWp602KRcu5smP79f8LWIfQxwruGlDGw1di53N4cn0FZr1g074048PqAf9VlPgwXwtqbYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992212; c=relaxed/simple;
	bh=hP05dZxv1Bp5ZvKMrsPf0Sc8A2Qb3cVl0NshbhgtxPg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbiJk4E3nFBrPj6OV0YtJKhY+VHkVlG9Tz7xhlH85c/7SzWup97V6JjsPvVEFQ8gMs4OwgqXvbVyaamfnLhW9sub4bz6FnZnSAp2wODJW7IhQBsgWfpJthvFsUdvmowv5Jo7tivq11hBX27AKIXN+lTmKDLV5ElRfxsE9kkrjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sxqj3D2j; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47U4Txq0082333;
	Thu, 29 Aug 2024 23:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724992199;
	bh=41xMG3qhDMXgrisGkZ7YqvIT0lqH6fleXZV4RA17Ubc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Sxqj3D2j92rN5Yt5cbNG+ecBQh8/DZpp4GKsAYtgkQClelwFoamLtDkf5oR/amE84
	 I3jznRt0vgcOzM1wMWX30L4XJXB0TCROdK4O1SxbP0MGcwcFY/u+lpMxmDzu+lj0dn
	 e/pN4ADkSAApHQVwkIZeGUjIxUbDBjgEeYke7y9M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47U4TxlW121167
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 23:29:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 23:29:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 23:29:59 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47U4Twu6107767;
	Thu, 29 Aug 2024 23:29:58 -0500
Date: Fri, 30 Aug 2024 09:59:58 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh
 Shilimkar" <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        "Kevin
 Hilman" <khilman@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH v11 1/4] firmware: ti_sci: Add support for querying the
 firmware caps
Message-ID: <20240830042958.33d35pfos7uv4wqb@lcpd911>
References: <20240829201606.1407773-1-msp@baylibre.com>
 <20240829201606.1407773-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829201606.1407773-2-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 29, 2024 at 22:16:02 +0200, Markus Schneider-Pargmann wrote:
> From: Georgi Vlaev <g-vlaev@ti.com>
> 
> Add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
> the firmware capabilities of the currently running system firmware. The
> message belongs to the TISCI general core message API [1] and is
> available in SysFW version 08.04.03 and above. Currently, the message is
> supported on devices with split architecture of the system firmware (DM
> + TIFS) like AM62x. Old revisions or not yet supported platforms will
> NACK this request.
> 
> We're using this message locally in ti_sci.c to get the low power
> features of the FW/SoC. As there's no other kernel consumers yet, this
> is not added to struct ti_sci_core_ops.
> 
> Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability [2], where
> Device Mgr firmware now manages which low power mode is chosen. Going
> forward, this is the default configuration supported for TI AM62 family
> of devices. The state chosen by the DM can be influenced by sending
> constraints using the new LPM constraint APIs.
> 
> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html
> [2] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps
> 
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> [vibhore@ti.com: Support for LPM_DM_MANAGED mode]
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c | 74 ++++++++++++++++++++++++++++++++++++++-
>  drivers/firmware/ti_sci.h | 22 ++++++++++++
>  2 files changed, 95 insertions(+), 1 deletion(-)
> 

[..snip..]

No remaining concerns,
Acked-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


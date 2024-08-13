Return-Path: <linux-kernel+bounces-284647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B9950383
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C37B25B11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5B198E71;
	Tue, 13 Aug 2024 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p9X78Ok6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D37190470;
	Tue, 13 Aug 2024 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548168; cv=none; b=ffGOKbtSu1P4XZO1tB+EuYvGVNWCtvTG9Ji3JOq6evru+King2ld9tTsqnAkfdTmt9rww1oAqp8TyKLnTvYEL67YFH5SX4iwAvlJ3CiU5rxS4tvQRG7jxObSxp44vjI2LxnVJxHbZlH7t+9vzTUfpr/TQ0WUjr5OzXZfkLYAwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548168; c=relaxed/simple;
	bh=08sVmN2q74fZvVb/UoRo9r+Qqcv2rG9U5RdMSvF0Ae8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUIIMrcROm2OTxGOQbvnbTG855Ny8yrrU0+n+A26aJodArFuk+kquRJ2LQ9483yV6nZJfSVMxsoa+ZepeOvS7POO1wfWFwc1gj19ybJPNxZ56NDE8hkc+4n931zSpxyl/G1o4nSuOxG3nVYlK5dOHtzIs7oWA5GQPTffoRH+Mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p9X78Ok6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DBMdWB106590;
	Tue, 13 Aug 2024 06:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723548159;
	bh=z7WrAWCeMeiiIcLJiiaaGuDSFqe408Str4upbBJRSDU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=p9X78Ok6kfJ/8HZkIjmdW1OmAycQPmojGKKb61ZoUAO58FqWQDgeYz19YgyhX/Q1w
	 JY1KTkaXqyX+mxX6vtg1PDwt1kNGgHJYHF7XlzBmi+lCAt2BZW+Q63jsMirPT7moAd
	 wFWfWPZ4TSLnGl/UXd09t5Bou+nb/dbqBuvZGDms=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DBMdSE013980
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 06:22:39 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 06:22:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 06:22:38 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DBMc2Z117488;
	Tue, 13 Aug 2024 06:22:38 -0500
Date: Tue, 13 Aug 2024 16:52:37 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Update various protocols versions
Message-ID: <20240813112237.drwgvhor3eisaj6t@lcpd911>
References: <20240812174027.3931160-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812174027.3931160-1-cristian.marussi@arm.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 12, 2024 at 18:40:27 +0100, Cristian Marussi wrote:
> A few protocol versions had been increased with SCMI v3.2.
> Update accordingly the supported version define in the kernel stack, since
> all the mandatory Base commands are indeed already supported.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/base.c    | 2 +-

I assume this patch supersedes [1] ?

[1] https://lore.kernel.org/arm-scmi/ZrZMLZq_-b9EFRgn@pluto/T/#t

>  drivers/firmware/arm_scmi/power.c   | 2 +-
>  drivers/firmware/arm_scmi/reset.c   | 2 +-
>  drivers/firmware/arm_scmi/sensors.c | 2 +-
>  drivers/firmware/arm_scmi/system.c  | 2 +-
>  drivers/firmware/arm_scmi/voltage.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index 97254de35ab0..9939b1d84b7a 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -14,7 +14,7 @@
>  #include "notify.h"
>  
>  /* Updated only after ALL the mandatory features for that version are merged */
> -#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20001

Just curious, in upstream master TF-A I see 0x20000 still? [1]

[1] https://github.com/ARM-software/arm-trusted-firmware/blob/master/drivers/scmi-msg/base.h#L12


Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva


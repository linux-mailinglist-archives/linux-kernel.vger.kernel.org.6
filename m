Return-Path: <linux-kernel+bounces-209314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18667903265
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D7E281D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4617167D;
	Tue, 11 Jun 2024 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dUSA/8Oc"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF644171671;
	Tue, 11 Jun 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086891; cv=none; b=FL+X8yj+Thm3eMBRIIrHbR61uj0PbDFvWea4yqgoi9oLGhATbyCKGE5HNRwD6H7ptin+JN/3nu51Bb5F+cDxyAD5vR3a72xwkGTs9I7uejuduFi6Geyd20nm5/xrP4Z6BCKIkj5g1bc6VmuaOj7Dsukq1cXa2nG9vPjeF5KHlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086891; c=relaxed/simple;
	bh=7y3NYO7po3GNFMmc0kZoJTChSE95BDnqvwukper8rhg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUqjYzxt5qAFHPRtlje8vmwwKtX+6ZPqr+k7jTnDmtmr29f22mUwimWAhFsCV3kQUviSL8M5XNEIQafDOyGh7bll0HcylqBZhgEYhDCWMKm2UOwR2Urp1pJGcmRQpEdTFY37gC1+1K3hWprMgnacemx9UBTlj5L/fz8m07nEExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dUSA/8Oc; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45B6L4gX126284;
	Tue, 11 Jun 2024 01:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718086864;
	bh=CP+LDdPyvvolLB5E7oanQuL7LYswwkSefkdI+mxK7sA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dUSA/8OcxlFnu1uvIxYLxrjjFdJspH3GiAkjgxm+/kKM93I9AnPU5/71ab8pqJnvy
	 KLB6/bMkcskPcff+lhPDHYLqK2zNJ750UHRTHgXtogv6tMoF9JuiYPFX30/6Ob4w+e
	 mPyIJl/H5DSmfd111XhCyNeNkPnBAoRWsi9xKhSc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45B6L46g032093
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 01:21:04 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 01:21:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 01:21:04 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45B6L3Tj069287;
	Tue, 11 Jun 2024 01:21:03 -0500
Date: Tue, 11 Jun 2024 11:51:02 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] power: reset: brcmstb: Do not go into infinite loop
 if reset fails
Message-ID: <20240611062102.ez66rcvf4d464oqz@dhruva>
References: <20240610142836.168603-1-afd@ti.com>
 <20240610142836.168603-5-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240610142836.168603-5-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jun 10, 2024 at 09:28:36 -0500, Andrew Davis wrote:
> There may be other backup reset methods available, do not halt
> here so that other reset methods can be tried.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/power/reset/brcmstb-reboot.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
> index 59ed1513cfb30..441b44e0a9f29 100644
> --- a/drivers/power/reset/brcmstb-reboot.c
> +++ b/drivers/power/reset/brcmstb-reboot.c
> @@ -58,9 +58,6 @@ static int brcmstb_restart_handler(struct sys_off_data *data)
>  		return NOTIFY_DONE;
>  	}
>  
> -	while (1)
> -		;
> -

I agree, while (1) may not be the best thing to do here.
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva


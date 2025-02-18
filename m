Return-Path: <linux-kernel+bounces-519580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE3EA39E49
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BC33A345B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F8269B18;
	Tue, 18 Feb 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VnP7CDu5"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4F269AFC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887560; cv=none; b=LlrMval9HQ8wEKg3Jt/nGwoDN9Z+O+OG++Q68POmQujAGWDhTzBmCoHHouKecZquhELQHcelAaD7nfuBY+ztjq3uWUA/L2sq1rtd9gaT33MvDPvYpu0WkjRji+0QaflzK2GTyUh/cqGsdVD76hgVTXqrrzkqcJ23GIomH50EbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887560; c=relaxed/simple;
	bh=UZhhzGzR2UGI7qZFdG0r0Zh4OzWqriLMqKzVaz9AKsE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYgqlq+QZA/MmRSXQdfcXa7Q7m9OcqvH+bAIKytPhYPfQp/aiH7Zinzov6sLyCx8YxVlrCbt/mwn8gZN3xV3PSvLnkLyNOUcJ4nO8MRkCT/JPzosva9+HcCbsvEZKG7mQpuGaCSl+TltXLzfP0ACRSf1IyQxvG50gXnVGLTbcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VnP7CDu5; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51IE5bAm015825
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Feb 2025 08:05:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739887537;
	bh=Snr4aTwPNVubpRPAi57boRzJiWp/9Aa733cQpJ5lAo0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=VnP7CDu5+QIT/IzJNAD7VWwuksmvy3XZP2vbumeuMUkxilk0rCvNswVTv1/H/INKR
	 0Wj+teBjpedt7EMRr5CO2UskNJnKeq/8zZvhgnE/lsAyc0NpUWXWHaC/u8nFSd0Nlz
	 z03rfbL1gQJPIu1JSivJt9iq1L272RZN/IwVGzFM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IE5bSh013691;
	Tue, 18 Feb 2025 08:05:37 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 08:05:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 08:05:37 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IE5bZb079588;
	Tue, 18 Feb 2025 08:05:37 -0600
Date: Tue, 18 Feb 2025 08:05:37 -0600
From: Nishanth Menon <nm@ti.com>
To: Guillaume La Roque <glaroque@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Andrew Davis <afd@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: config: ti-sci: Default set to ARCH_K3 for the
 ti sci driver
Message-ID: <20250218140537.wfagt3spwkcmc3uv@cushy>
References: <20250218-ti-firmware-v1-1-7a23aacfb9d3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218-ti-firmware-v1-1-7a23aacfb9d3@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 13:57-20250218, Guillaume La Roque wrote:
> Defaulting the build to ARCH_K3 for the TI SCI driver.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Link to comment done on last serie [1] we come back on first version of
> series[2] to not use imply but set deps on ARCH_K3 in driver directly.
> An other patch will be sent to update Kconfig.platform when this patch
> is merged.

It would be good to expand the commit message providing the rationale
for this.

> 
> [1] https://lore.kernel.org/all/20250123-timodulemailboxsci-v4-1-b1a31b56f162@baylibre.com/
> [2] https://lore.kernel.org/all/20221122202245.449198-4-nfrayer@baylibre.com/
> ---
>  drivers/firmware/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 9f35f69e0f9e..109abe063093 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -215,6 +215,7 @@ config SYSFB_SIMPLEFB
>  config TI_SCI_PROTOCOL
>  	tristate "TI System Control Interface (TISCI) Message Protocol"
>  	depends on TI_MESSAGE_MANAGER
> +	default ARCH_K3
>  	help
>  	  TI System Control Interface (TISCI) Message Protocol is used to manage
>  	  compute systems such as ARM, DSP etc with the system controller in
> 
> ---
> base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
> change-id: 20250218-ti-firmware-1b7c7f485e5a
> 
> Best regards,
> -- 
> Guillaume La Roque <glaroque@baylibre.com>
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


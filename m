Return-Path: <linux-kernel+bounces-417906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422139D5A89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5775C283CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279AE17107F;
	Fri, 22 Nov 2024 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HZk7vcO3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073618A6D3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262483; cv=none; b=t1FszRgInIs2FLLjo8OG7YrKV7ehFvCCZRREx/ys9OYtRL0VLrU0wGuvhQZ2RKG6fnuEJBbbNSAh0rKLZ3FXtS6HEgHfZROZ/FVZzc811L7YsRGgq+9KIR8K/P1/JKgcExo0wMy4cFuEaARAxpOL27PQMvtE0roNWbK30RwEcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262483; c=relaxed/simple;
	bh=ciU29li+t6dJKfSucUNe8VRX908oVlTYsw1dnmQ3vLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vFm57E5nu4MhX3sA5GJy/6CPicEw7yYsNXmQoPGBLPa4NkgPRXHiB+g8T95oUZK3suWtJGXUrb4xh7XlPJttUVQ9gBWfBuTjWJlNOHVTW8SDXOpBTOcJsdAAYy0ZyKlI8cpIXG+Tm2rJdO65GM1o7mURZR4OzlbKbSj4aeIc6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HZk7vcO3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AM80qim015202;
	Fri, 22 Nov 2024 02:00:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732262452;
	bh=QJjoCW1qT2TYG2ypJf4/FVAqbU0v/j3s33/VLB1sBcQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HZk7vcO3hEeilzGNc3Oz+lPJN6YbR2Dvggx6XUML0q/vwnvnPCzsAHwvPi5rXJc9U
	 kDGUTSJN5CShzHqHzwZ3cr6JaguKr7pH15WCX3S+Itn0070cy5cPb7x7Q6iB6WT9j8
	 jC2seGfZqsfSmk4aejpF6rex97FIKZv90Hb/RDTw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AM80qsL025322
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Nov 2024 02:00:52 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Nov 2024 02:00:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Nov 2024 02:00:52 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AM80m54055112;
	Fri, 22 Nov 2024 02:00:49 -0600
Message-ID: <315e2d6a-4d9f-fb91-6584-92f622c54d96@ti.com>
Date: Fri, 22 Nov 2024 13:30:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/7] drm/tidss: Remove extra K2G check
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha
	<jyri.sarha@iki.fi>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jonathan
 Cormier <jcormier@criticallink.com>
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
 <20241021-tidss-irq-fix-v1-3-82ddaec94e4a@ideasonboard.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-3-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 21/10/24 19:37, Tomi Valkeinen wrote:
> We check if the platform is K2G in dispc_k3_clear_irqstatus(), and
> return early if so. This cannot happen, as the _k3_ functions are never
> called on K2G in the first place. So remove the check.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index f81111067578..99a1138f3e69 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -789,8 +789,6 @@ void dispc_k3_clear_irqstatus(struct dispc_device *dispc, dispc_irq_t clearmask)
>  		if (clearmask & DSS_IRQ_PLANE_MASK(i))
>  			dispc_k3_vid_write_irqstatus(dispc, i, clearmask);
>  	}
> -	if (dispc->feat->subrev == DISPC_K2G)
> -		return;
>  
>  	/* always clear the top level irqstatus */
>  	dispc_write(dispc, DISPC_IRQSTATUS, dispc_read(dispc, DISPC_IRQSTATUS));
> 


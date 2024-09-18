Return-Path: <linux-kernel+bounces-332654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDCE97BCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEDB1C20BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E2A189F47;
	Wed, 18 Sep 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dI0iUyOS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475104409;
	Wed, 18 Sep 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664335; cv=none; b=SWsRbWuOgi1t5cXq0n7K1Frgwjqk7haaQcW9RCSfXFKLYcZpvlWSOZ578nHxZU5AJjkDC3bo0cSelhBYe5dn4Gg8ProaSSUEkaa1gyS8x5cq1AVPFWC5SO3N3u0QchDOm8OPB+VwBCnIMmZFANwRQgIzquuR7POiVDUKZTGyGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664335; c=relaxed/simple;
	bh=WHN2Or2KmX97EgplTcnWv9pNo/oOs7of4tjRXWWWC8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NKyUEH6NeU4h2XG001Nn/4ty6R4iSWY/QO2J/8h4IyW68qA8AdN/PzHun32GKkQ9LCa7c1tKjs+UdIH54mLaL7tiBgrjaW1/LaZuhZq0b2MDtP/7j/O6pO5z7UBMV4nVnZBqRa83x2mxpSDbZqrTP4MSWN/699PXLHx4l9tfHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dI0iUyOS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726664333; x=1758200333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WHN2Or2KmX97EgplTcnWv9pNo/oOs7of4tjRXWWWC8M=;
  b=dI0iUyOSkIhdEDM/5LFCaEzSSKc2ybCWWxLMHWhUxtgEmvrkflcTHcPO
   7VKpvaRl0YWwy2zqvuOM8XJbtiiLhsUn2oJNoTkjZ4vLPQ7tbnlBaQmRE
   0SEF1gHgYWtOa7YPOKSGW5+o79MfVE4By3Sx6b5g0SWz58kz6vezTDlu+
   oKSLvKArSVQfu9/H7f4LmA7iaJoiXbcpIYkB8dzdc68qGBjee2CMDjJOO
   IhN4lJMp1mQLq5JlF3+CSdn94VCidn09S014pWpavjFfUm0FuL+XWyvyD
   ZIvPWj4zzauCAE1cOhZRMcf2xgZwf8bBjsdh2OJ397nN2LG+zJoBtZFCD
   A==;
X-CSE-ConnectionGUID: 6wyIBGIQTUq+t6epY6O5fA==
X-CSE-MsgGUID: d/oozOpsSRqyFWoxElkoRw==
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="199377516"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2024 05:58:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 18 Sep 2024 05:58:21 -0700
Received: from [10.171.248.44] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 18 Sep 2024 05:58:19 -0700
Message-ID: <672befa1-cefb-480e-b474-ff40e4fe80ed@microchip.com>
Date: Wed, 18 Sep 2024 14:58:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: at91: pmc: Use common error handling code in
 pmc_register_ops()
Content-Language: en-US, fr-FR
To: Markus Elfring <Markus.Elfring@web.de>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>
References: <4a82fe70-b07c-4878-bd31-6ae07b61f522@web.de>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <4a82fe70-b07c-4878-bd31-6ae07b61f522@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 17/09/2024 at 14:34, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 17 Sep 2024 14:28:22 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Bad track record and no real benefit from the patch:
NACK, sorry.

Regards,
   Nicolas

> ---
>   drivers/clk/at91/pmc.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 5aa9c1f1c886..040b70e1ffbc 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -162,20 +162,18 @@ static int __init pmc_register_ops(void)
>          if (!np)
>                  return -ENODEV;
> 
> -       if (!of_device_is_available(np)) {
> -               of_node_put(np);
> -               return -ENODEV;
> -       }
> +       if (!of_device_is_available(np))
> +               goto put_node;
> +
>          of_node_put(np);
> 
>          np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
>          if (!np)
>                  return -ENODEV;
> 
> -       if (!of_device_is_available(np)) {
> -               of_node_put(np);
> -               return -ENODEV;
> -       }
> +       if (!of_device_is_available(np))
> +               goto put_node;
> +
>          of_node_put(np);
> 
>          at91_pmc_backup_suspend = of_iomap(np, 0);
> @@ -187,6 +185,10 @@ static int __init pmc_register_ops(void)
>          register_syscore_ops(&pmc_syscore_ops);
> 
>          return 0;
> +
> +put_node:
> +       of_node_put(np);
> +       return -ENODEV;
>   }
>   /* This has to happen before arch_initcall because of the tcb_clksrc driver */
>   postcore_initcall(pmc_register_ops);
> --
> 2.46.0
> 



Return-Path: <linux-kernel+bounces-297588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8E95BB24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6DD1C23A93
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918B1CE711;
	Thu, 22 Aug 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fpdodkho"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1B1CCB42
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342107; cv=none; b=gUx4dhIg7yJ2L7l9ntSztHUmmeLFFzUDchdftdWs9w8f/AwXBsKyIjWYdMhdbGRrfD6B6rp6tksnVZbtF5OD+uBm3v7icDi/mXko1zE5uezSe91lU1pAamhPZIYTYpipcCQKFsZNYAZycj4oo4qiGmJ87R37E4gmOkqOGVwrfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342107; c=relaxed/simple;
	bh=T6FKB7FiGWOqnwODINwXV6nvlWEjZs6TSxWvbCgu9q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AoKtjRbzc3zcbxjrvia1LqjlQvvrhMV55RvMGb5M0hvt1D/X5zqNLzinYstCmht8tGJh+KwZBTCs/JAN2aMh3dIsfifSnhEIpVX8MXSH3JRwxJzdiUc1f0BuC9a+G5aN+82nq4nlaBV9qU7yA5FUtSMtYoSZcq0yxIfoevGfa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fpdodkho; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724342104; x=1755878104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T6FKB7FiGWOqnwODINwXV6nvlWEjZs6TSxWvbCgu9q4=;
  b=fpdodkho4YekUfJH0Fxgv2g4O8qGugfvP4TVyE9IebV6XBa9JreMD+cr
   1CuA0/9p8QnEU1nWfmZB0PGR5IMD5ddqghqwGJ7QQkm4uTk2NydRBXBSa
   SkWQSVIb0OpBW6+DQTcaasEDhnvOy6xnv2vZBMAJ/eMkDChn+WwYHsdJW
   NCcQwPD31gZMeinIRUau9HeWRWWUoEbLpxPqf4Z7V/tPOmJzXHXrlhEXk
   3QGMBDn4RHNn1lB9os0BDBa1My2P/c44grKPz/3s9zXS9/EEsqJiMM7mh
   av49X81y+YEHAoXP2tToIuIZrHjQf0wtQuHbdxn55wlhuLT26dzZTPgEi
   A==;
X-CSE-ConnectionGUID: SN1/6utRSOOKy8/CQdqDBg==
X-CSE-MsgGUID: kRwOVHM1RAC6HedrkcyYKA==
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="198218186"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2024 08:55:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Aug 2024 08:54:33 -0700
Received: from [10.180.116.170] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 22 Aug 2024 08:54:29 -0700
Message-ID: <a65c4728-4cec-4fb0-a00f-052b0e08d7c1@microchip.com>
Date: Thu, 22 Aug 2024 17:54:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Add message on DMA usage
Content-Language: en-US, fr-FR
To: Alexander Dahl <ada@thorsis.com>, <linux-mtd@lists.infradead.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	"moderated list:ARM/Microchip (AT91) SoC support"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20240821142006.645306-1-ada@thorsis.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240821142006.645306-1-ada@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2024 at 16:20, Alexander Dahl wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Like for other atmel drivers (serial, crypto, mmc, …), too.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> 
> Notes:
>      v1 -> v2:
>      - make info message conditional (thanks Miquel)
> 
>   drivers/mtd/nand/raw/atmel/nand-controller.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index dc75d50d52e8..f9ccfd02e804 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -2049,7 +2049,10 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>                  dma_cap_set(DMA_MEMCPY, mask);
> 
>                  nc->dmac = dma_request_channel(mask, NULL, NULL);
> -               if (!nc->dmac)
> +               if (nc->dmac)
> +                       dev_info(nc->dev, "using %s for DMA transfers\n",
> +                                dma_chan_name(nc->dmac));
> +               else
>                          dev_err(nc->dev, "Failed to request DMA channel\n");
>          }
> 
> 
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> --
> 2.39.2
> 



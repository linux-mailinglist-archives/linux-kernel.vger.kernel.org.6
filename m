Return-Path: <linux-kernel+bounces-236318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723891E060
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4681C215C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7356815E5B5;
	Mon,  1 Jul 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UWKDH2AZ"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E515ADAD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839854; cv=none; b=qdZCfEvX6+irs9pxnPlMYLfa2j14SveTG4temWr5yQyOY+ik3HrFItKmHzylmf4/4UZ5BEPIYyKCl9P3b7+t5Xn9lToISxRetYO3KzRg47IlmtS1eJRhjNcJn6Lgi8wHujkjgD4RtiBzGmpGKSZ4NqJaad3Uhxo1UDCV5tOnuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839854; c=relaxed/simple;
	bh=B3NQ8HCyj1ZTe5E7TLaeqHT43qtQdDbfhF0WcJB5/l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HL4bJXoHwND6caThTcWRY2U8O63XFKZXfLRzj+GCfSF+0dWYw19WKO/W98xgNK3rDOTc8NrpyTcE0a1ui1FPQN5SlxuF4k6ydx1G+HZJxREceEjn1L6pZ6hiQrprytPKN3/hhXhphMiDA176baDLxL71dI/Tl/e2uqh66S8V6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UWKDH2AZ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e21dfbc310so109564439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719839852; x=1720444652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tv7hLmqJSP26fMN3IiNsBgVJSAix2nuXmhfSvybhYBQ=;
        b=UWKDH2AZl3qh51IaJ844eBRRwwGSLeuh5xk19tkKla8v4ZrIpy+m4k4BIjSl2eidlO
         9dpgHw1aDoQTUYXzk2xHzA1WjfNAqwDxOhcVJvogiMigtxJPkvRvw3MOZKwPFJbwWEhT
         zIaq7NxLSNGncfzWmKb8S8pMnM6RrVAeGQxB8AfeuKf6+1Zfd4P8i8ltFBAmKy87qBOY
         6LyYZJ9Nn4F9y+6OY61UcTXywKuFonw9UDJnhm50AJX7YciMtwUHU/o3g0ORLYyO0zw5
         zCBRHbDi09OHjwyPvJCF4bQ8/vwj+anBMK6m8MEgw6AEArmlsU9G9jPYgGViBUqDUW14
         Y8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719839852; x=1720444652;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv7hLmqJSP26fMN3IiNsBgVJSAix2nuXmhfSvybhYBQ=;
        b=HOiCBq64oWdZAw/b6Hk9uDflQzIN3hnsQGDNfj9ScfpNG+FN5e+JqX5RBgJ0ftJr3i
         dqP2Bgf8+vDA0JGYlCRVZbIZzBa86944QQK0uFWlqGV/WWziAHBAV+g5eKMd7MhwGyVs
         NMjB9e83K6PozNzKbkt967EixblQpYYD0FJGN69hZB8i2yKY9uSJlrKNy7WX8uPKwYQq
         dWiWFkeBt5T6dGwX0yhGKVBdt5WOaYfSt/L3047OZwf/I8ZTg9JyKgGa8UaZTUHZpi90
         d9o+ZbPHw7O3jIr6FiKeHZj0q1cCTBTK6NfdDieQJrDaEEHh2Cm4UPW3rFZfK9ZRRPNF
         BFHw==
X-Forwarded-Encrypted: i=1; AJvYcCXmveCA2buttdcVVR+Ytt5Su1kpTB3n34cZyWuJjudHpLQ60seGJZ7HiVIAMbcdXpJOKsvNY8wQn59Q37zN6xYInd4AFw4StNn6Ztqm
X-Gm-Message-State: AOJu0Yz9d6d/DXVF2g1h4jcGWBmGEj6ch1nBHgd4YZCrtPVXOUpBrqhb
	9J+sV1nJaI0pYNKU0zVNyShNyR6+bdlyXoHyv/jXicBan6E7ldu6f03lkonoOy8=
X-Google-Smtp-Source: AGHT+IEZw7OPZRtqEEfxj8LpOcD4ss2+Aeo4eVMjfKvEB8LYKyAWd6+8RBlnjTcAOf4l/FP8eMO8Kg==
X-Received: by 2002:a05:6602:584:b0:7eb:776f:d970 with SMTP id ca18e2360f4ac-7f62ee74896mr592724639f.14.1719839852334;
        Mon, 01 Jul 2024 06:17:32 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e08bc2sm2165340173.83.2024.07.01.06.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 06:17:32 -0700 (PDT)
Message-ID: <f8604c68-8866-447b-a874-562bdad1df79@sifive.com>
Date: Mon, 1 Jul 2024 08:17:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: dw-mmio: update dw_spi_mmio_of_match struct
 with thead
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-4-kanakshilledar@gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240701121355.262259-4-kanakshilledar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kanak,

On 2024-07-01 7:13 AM, Kanak Shilledar wrote:
> updated the struct of_device_id dw_spi_mmio_of_match to include
> the updated compatible value for TH1520 SoC ("thead,th1520-spi")
> to initialize with dw_spi_pssi_init().
> 
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
> Changes in v2:
> - Separated from a single patch file.
> ---
>  drivers/spi/spi-dw-mmio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 819907e332c4..39e3d46ebf5d 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -419,6 +419,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
>  	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
> +	{ .compatible = "thead,th1520-spi", .data = dw_spi_pssi_init},

Your binding requires snps,dw-apb-ssi as a fallback compatible string, which is
already supported by this driver and uses the same match data. So you don't need
this patch; its only effect is to make the kernel larger.

Regards,
Samuel

>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);



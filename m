Return-Path: <linux-kernel+bounces-240539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D9926E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A871F22A18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D31CA8D;
	Thu,  4 Jul 2024 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLhuMsZc"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA11DA334
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720068612; cv=none; b=sGzUxsOH/YBslUhX6hyREIEhNGQn5f1DdJksuFGsvwNK6AbGrNSr85/i89ouSctKo6oNGZ8SoM9AIuFypxFDIpen/4wgJvCOX1PjCgIBX9fCS30ynpdkIavqSUTA7/RMxbxJVhtaicHR3vFLH1veQcAG6PAEnz+yjQP9JoDtIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720068612; c=relaxed/simple;
	bh=uimIdKA0TrWa5z8++8K5fGmiw3AknKo2NW+1PuMJTlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fm/xYP7VgdTdxyadpB41kNRtuDGtPUgODgi4uViyD/c4NSzgBIOTfPTn4fOmrEy2qjzhBau3D4meg9WYasp0NjHbUKur6auWXdqkyAQRkdoiqUNqWfRUWltZcniAqaiyZoKyV6wQ3n3VHiAnVsxpdfnzJt89B6dbEb90gWdlDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLhuMsZc; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso1975301fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720068609; x=1720673409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0bROoDmShRfYVJWcxUuDLMgaTkSSIsgbDg3S3gFNUs=;
        b=OLhuMsZco+kv+7qPfycNRoIUXPQXuuKoN2sITnQAOw2DXqsb9PgJLJcYjDKZT9Bd0A
         nOff0yoDdzsUZJm8FdWBa4OXer1KVaBOL4t3sOHeGreLu59WDIIif5Rt3XfXiQPgFHJG
         pHpVzafaVM/Wc8kTgITD0c5TyxpAxNwOuJEgduQE/QBnP2OQtoqkzPTxff+kgZ4lvA/r
         2OIS+YJ3SDTnEqoJzBCJhcqGHtnE7kSPDq1C9yrW+/q4pbdqAiz+hC0+N+SVotDCHEmp
         5F7L2B6viF11YJVhjIA2ZWg+j153YERNqxCP/hzPFDryj5IT57qAY2Np4Pfof1bzrv0B
         GnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720068609; x=1720673409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0bROoDmShRfYVJWcxUuDLMgaTkSSIsgbDg3S3gFNUs=;
        b=GgNdfyTou3khn1Vfe9WQM1Vg4DdrkJ26ujnkc3Tw6VAW8AjBztJTWj8s3Q+TXj6K9h
         snSO0nX64hOBF6O12YIx/iYdMj1N3FrL8ePHLssGgb/rXg7CaH3xOlA9uZ0hhlOkOuYt
         /PRwv653lsB9eCjkxdnE7s1OKaFQYvUtztcRcuExAwykWTFAyzcvQJHrZ7ZJ6Igeqwmv
         kK6rWDSplfzfn9JclQonigDcl/+AiK1BfBqTXDIEUn89/Ow9wFGg41fwY7+vV0hmswg8
         JdRy/fVtjdv1avTMX48QRpC/AspkrbezryeOvGUgpED7NOuQiJPlUv7FpBzUK8dgN0d2
         axNA==
X-Gm-Message-State: AOJu0YwQI09u3cqYo5Foto4X2EDsRyuwlhfVQ35hhiSn7T/EWAyQp6u+
	uttRygZPOSfjMtaB92r4i9r9K50J9qOfDrxeS7KHUnzYIo7tdUsv
X-Google-Smtp-Source: AGHT+IEHJ/ykgTHYMcUkN63qNzxJ9bqb6cfleOPZzzFBtF0u/7T8g8zQl8zXAPBuMB/j6J0C6id8ug==
X-Received: by 2002:a2e:a497:0:b0:2ee:8777:f868 with SMTP id 38308e7fff4ca-2ee8edc2deemr2275391fa.35.1720068608661;
        Wed, 03 Jul 2024 21:50:08 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee871e7a66sm3138181fa.82.2024.07.03.21.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 21:50:07 -0700 (PDT)
Message-ID: <0acd9da5-80ec-4a45-b00a-8e28ab4e345a@gmail.com>
Date: Thu, 4 Jul 2024 07:50:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mfd: rohm-bd9576: Constify struct regmap_config
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
 <20240703-mfd-const-regmap_config-v1-6-aa6cd00a03bd@gmail.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240703-mfd-const-regmap_config-v1-6-aa6cd00a03bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 18:37, Javier Carrasco wrote:
> `bd957x_regmap` is not modified and can be declared as const
> to move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/mfd/rohm-bd9576.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
> index 3a9f61961721..634c65c7d108 100644
> --- a/drivers/mfd/rohm-bd9576.c
> +++ b/drivers/mfd/rohm-bd9576.c
> @@ -57,7 +57,7 @@ static const struct regmap_access_table volatile_regs = {
>   	.n_yes_ranges = ARRAY_SIZE(volatile_ranges),
>   };
>   
> -static struct regmap_config bd957x_regmap = {
> +static const struct regmap_config bd957x_regmap = {
>   	.reg_bits = 8,
>   	.val_bits = 8,
>   	.volatile_table = &volatile_regs,
> 

Thanks a ton Javier. This looks good to me but if you feel like going an 
extra mile while you are at it... Do you think this could be extended to:


diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index 3a9f61961721..17323ae39803 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -57,7 +57,7 @@ static const struct regmap_access_table volatile_regs = {
         .n_yes_ranges = ARRAY_SIZE(volatile_ranges),
  };

-static struct regmap_config bd957x_regmap = {
+static const struct regmap_config bd957x_regmap = {
         .reg_bits = 8,
         .val_bits = 8,
         .volatile_table = &volatile_regs,
@@ -65,7 +65,7 @@ static struct regmap_config bd957x_regmap = {
         .cache_type = REGCACHE_MAPLE,
  };

-static struct regmap_irq bd9576_irqs[] = {
+static const struct regmap_irq bd9576_irqs[] = {
         REGMAP_IRQ_REG(BD9576_INT_THERM, 0, BD957X_MASK_INT_MAIN_THERM),
         REGMAP_IRQ_REG(BD9576_INT_OVP, 0, BD957X_MASK_INT_MAIN_OVP),
         REGMAP_IRQ_REG(BD9576_INT_SCP, 0, BD957X_MASK_INT_MAIN_SCP),
@@ -76,7 +76,7 @@ static struct regmap_irq bd9576_irqs[] = {
         REGMAP_IRQ_REG(BD9576_INT_SYS, 0, BD957X_MASK_INT_MAIN_SYS),
  };

-static struct regmap_irq_chip bd9576_irq_chip = {
+static const struct regmap_irq_chip bd9576_irq_chip = {
         .name = "bd9576_irq",
         .irqs = &bd9576_irqs[0],
         .num_irqs = ARRAY_SIZE(bd9576_irqs),


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~



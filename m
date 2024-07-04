Return-Path: <linux-kernel+bounces-240781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF09272A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF271C24306
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8F61A4F03;
	Thu,  4 Jul 2024 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl054z6e"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CEF1A08D0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083786; cv=none; b=TdGVFUOxSde6ZvXHhJqpRVZ2ieXlsfOgFxTvu+iAikzrEKtYHfqldtBSBX/HcB3mmHKZMQ8zDts+CpGcKU0FEKjg0ulSADTD8t/1u/a7jiHpvrqAcZMzBO+sUaGZQQyUaR5rle1p97qiL/YoOW7Bqdu18AN4lD+FwUgNvhhsRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083786; c=relaxed/simple;
	bh=lJeXmk1CcWCnW6+sA0Si+XgkMXTZlK92WQIJ55qf44I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORsMF3fYRW3jSXn0fptQ4Lmb3Y6IAr8LdNwlHrS//DAOBhuaKWwVN53VJXCD68s9DaBQioCdtgkOkAW3b9eyYuXIMcYijJ8syxczDLUAdv5JFFMO4s9OpF3c+YrE/rlv/IaKt53jym6LevdTe2MVWt22I5+E/TwiNLRVl86CoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl054z6e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4256eec963eso2507315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720083783; x=1720688583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cx3d5CxqTkB14K4gwBHdHmuzRMB2FNvR/ektMnAQxOM=;
        b=Wl054z6e9+k79vpHVr1S1cuWTHuxExjfhEZ3vq9kBwn3TcMNc/rV70GolW3hoUn8ct
         1LfslvLTBcgiqXdrjikcSnjHxOXEPQ0Xjcdi8eygjB0CUNdcP2i+ylNIG3Ig/AU2oQLb
         YTTP4jdTUXjmjAp3MlWWsQsEfi/FmL8s4V9zZFgyKtELj8J7b8RuOVmMUCN3+ps/yvtj
         I6axz8onNrwuBBq6PngWGp5pN7cdDxG2up6DxZAr7SGz97zeD3JMq5y5K34kiRbA5lxa
         9Y5ztzUIfiCZJz+KXkgugCWo03Ao1d0sJFDirFNyX2qZNgtXlqBjaHP6Vh5UqIvU90XT
         FNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720083783; x=1720688583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx3d5CxqTkB14K4gwBHdHmuzRMB2FNvR/ektMnAQxOM=;
        b=bTiovoAJf6dZKF8zefCpaYJjh+1EOkNWY6D2q8S6w3YSI6RW1wFluw6gEuSZ/+hDOU
         1dspkz5wLNepQwucSu7+TAqXtjR7JuXVN7t/z0fgXb+6nV7dXUNR/OVbVSi7qmsFr1io
         kZC9KAikRhSB1YhyKF7qnl9Xyl9OfUJB1bXFqXk45ziOxlRJeilZj2HIQwHv44oO1gl5
         Or52OnUyunim/KI3lSR/1bxQ/5x0pfJZxmU5ROYDIxcoxfyru3qzKH2ANtC77v2YWSpx
         eVgEob0arPjaHKVcHYqeG7StTAIrlf+PNiQXxLwH+RKIluaBQMgBBb5I3a3RGjgKh1hQ
         Ii2Q==
X-Gm-Message-State: AOJu0Yx6y2LCQxGy2SlC937zZgI0KILzgKmskTvU1N4EQ/6JwJWlS1Fx
	yYlN2C3GFro+JoBg7+aVmNBnbdqoBYZnn0MLfVImquhsblCdsZAl
X-Google-Smtp-Source: AGHT+IE5rRRgQ+3VAktBOrwvlEMxaYncLW64BefnBB2CyyVIkKT2zQeyktZpK58oIjvjEAzP4/eFaw==
X-Received: by 2002:a5d:608e:0:b0:367:9877:750e with SMTP id ffacd0b85a97d-3679dd3df99mr753973f8f.25.1720083782983;
        Thu, 04 Jul 2024 02:03:02 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:2c0f:6313:4446:a47? (2a02-8389-41cf-e200-2c0f-6313-4446-0a47.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2c0f:6313:4446:a47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679c9008b0sm1194575f8f.80.2024.07.04.02.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 02:03:02 -0700 (PDT)
Message-ID: <c83ef39f-2267-4d02-9d77-65baa5a026c1@gmail.com>
Date: Thu, 4 Jul 2024 11:03:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mfd: rohm-bd9576: Constify struct regmap_config
To: Matti Vaittinen <mazziesaccount@gmail.com>,
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
 <0acd9da5-80ec-4a45-b00a-8e28ab4e345a@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <0acd9da5-80ec-4a45-b00a-8e28ab4e345a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/07/2024 06:50, Matti Vaittinen wrote:
> On 7/3/24 18:37, Javier Carrasco wrote:
>> `bd957x_regmap` is not modified and can be declared as const
>> to move its data to a read-only section.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>   drivers/mfd/rohm-bd9576.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
>> index 3a9f61961721..634c65c7d108 100644
>> --- a/drivers/mfd/rohm-bd9576.c
>> +++ b/drivers/mfd/rohm-bd9576.c
>> @@ -57,7 +57,7 @@ static const struct regmap_access_table
>> volatile_regs = {
>>       .n_yes_ranges = ARRAY_SIZE(volatile_ranges),
>>   };
>>   -static struct regmap_config bd957x_regmap = {
>> +static const struct regmap_config bd957x_regmap = {
>>       .reg_bits = 8,
>>       .val_bits = 8,
>>       .volatile_table = &volatile_regs,
>>
> 
> Thanks a ton Javier. This looks good to me but if you feel like going an
> extra mile while you are at it... Do you think this could be extended to:
> 
> 
> diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
> index 3a9f61961721..17323ae39803 100644
> --- a/drivers/mfd/rohm-bd9576.c
> +++ b/drivers/mfd/rohm-bd9576.c
> @@ -57,7 +57,7 @@ static const struct regmap_access_table volatile_regs = {
>         .n_yes_ranges = ARRAY_SIZE(volatile_ranges),
>  };
> 
> -static struct regmap_config bd957x_regmap = {
> +static const struct regmap_config bd957x_regmap = {
>         .reg_bits = 8,
>         .val_bits = 8,
>         .volatile_table = &volatile_regs,
> @@ -65,7 +65,7 @@ static struct regmap_config bd957x_regmap = {
>         .cache_type = REGCACHE_MAPLE,
>  };
> 
> -static struct regmap_irq bd9576_irqs[] = {
> +static const struct regmap_irq bd9576_irqs[] = {
>         REGMAP_IRQ_REG(BD9576_INT_THERM, 0, BD957X_MASK_INT_MAIN_THERM),
>         REGMAP_IRQ_REG(BD9576_INT_OVP, 0, BD957X_MASK_INT_MAIN_OVP),
>         REGMAP_IRQ_REG(BD9576_INT_SCP, 0, BD957X_MASK_INT_MAIN_SCP),
> @@ -76,7 +76,7 @@ static struct regmap_irq bd9576_irqs[] = {
>         REGMAP_IRQ_REG(BD9576_INT_SYS, 0, BD957X_MASK_INT_MAIN_SYS),
>  };
> 
> -static struct regmap_irq_chip bd9576_irq_chip = {
> +static const struct regmap_irq_chip bd9576_irq_chip = {
>         .name = "bd9576_irq",
>         .irqs = &bd9576_irqs[0],
>         .num_irqs = ARRAY_SIZE(bd9576_irqs),
> 
> 
> Yours,
>     -- Matti
> 

Sure, I will generalize it and update the series to cover regmap_irq and
regmap_irq_chip as well, of course including these two cases too.

Best regards,
Javier Carrasco


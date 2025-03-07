Return-Path: <linux-kernel+bounces-551678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BCBA56F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9083B7F7C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD30241663;
	Fri,  7 Mar 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7NE4oXp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1050D2405F2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369329; cv=none; b=jOk7prJX2n/ZNIF/kziqHnQl+S4cfNHn8ImhWKepZQ8pTb1heLJQCSzto+TK5r0lq6qI02UmYZpB2PxT1lpql0eZyu6W3KK7WFzjtLT8KcXZ+jWgoyEqGjSZ9OFhTi+CGKH+Z/5mFmdhSpOvWLax2FxZUpQQoR2JJND3rQtKkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369329; c=relaxed/simple;
	bh=KQS1zGojMtlyo5Lhl62aadLOweiXB7BrdSEtxARRf9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jW2y1DhVN52FxC3QuQI5tGuj+JkMGjoCK/saKyx1QkIO18xv/ydHIq3xhhyEbTjnMsghbkGEIyh8w2RMfnuF89dMI+C4j3enrwitR+ul1KygW1kKLgP5z03WPiUjGwMylBIyiuncukP6s22A/8z/hYtzAo9m5P2REP7XRbkZdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B7NE4oXp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac25520a289so172189166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741369326; x=1741974126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87LLRJ6QEN8pKjPcs70n3/W5zmSE0p6Cob9Wz2RQEBw=;
        b=B7NE4oXpj/yoUiPs8+YVU3eJC1OWK6bnx3B86Ir77M//PbPqFjZzrmt8x2qXdG7BM2
         fk/BLrKx8iczf5n+P0h8YrvzaPdL5ALMOUBCux6wdPZJGunBrS6c2a/ZeQRGWqh3yQx7
         nCkvDHx/tGJ0fD+MQsmPaMXP4mh/D90JorgBdtRgVnN0zz3TtzVZ5BRN8yzd2JCVcdpb
         PoKPSsPigrf6IjbCKyueT5UKmd7053NXuNw98/tzTVwzm3YBtw5HKJIXFtgeZusKXbnl
         ls2lm0akhpGQhz/vEN2e8OFYSFBaP7vGsEhLGOPF6GStT2N2I3Qu03oyO2JJfLSlavGO
         0dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369326; x=1741974126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87LLRJ6QEN8pKjPcs70n3/W5zmSE0p6Cob9Wz2RQEBw=;
        b=mx7ICXrwtkf2YYaXDznnVcc/w+IdfBGisEe4A4p9SZhaqsZbtn93vQ2DixXDRIIiHC
         VyZVKehcRpHsVaqSD8NYOguI3Xt4AurfxGN3QBJU3FxZRTc81TJQlEYEY7NNQ1HDHsLs
         Y01oSzJvLs7i5EijPNnXbRo3Rs9O2MAkM7wubNzJhmbpEVWTunN8p8hmMgurLdetMLVc
         VjBt84Lg8U8GViLVylx7eopKJW2Iy7CSd63nucSIat0aMJkZUR3oAfwHL/8ZgQB5118p
         AHJpA4XLCwZlyFNbJaljtR+4TuMwkARG8n4By3BwCgeSMQTybhlO1wD7gUmBc5nFEcBz
         C1dA==
X-Gm-Message-State: AOJu0YwssPt7x8NxpyizMrob7IoNqT706qeQp37sUX/4lUKJz3bsp3xJ
	ZupjEHw48jy04E3whVL705VspPHB9kbKRmZzTN+y5oQr5JiLGSAQG78uLNW4Q8I=
X-Gm-Gg: ASbGncuA2DGCl7OIW5elSE5hETHvPrDou+xQEIc3q0nowPPLFAfMgHGo2Xpymlbbg1j
	SsEHGRek67pKT2LY/3imbNcpakFs7IISrXV0tfdRVjHNusIgxxJFdSSPydAc+xkz9lcev+ayuaA
	Zx7+0cHE3c/WYtoQChGDDshQCw5HxcsXapRKHFsUBN/xpc0VMYuotBfmcnMSykKOpZ3heljzvRG
	GrqjIqEN43kpw945IuxNk5yYfdh5fvF0E/xSjFpdL1P07dxIF4lymHiUSYibWgG8yJbEOqOFPxE
	M8sWmeoRgamjezgnEOC0z25ElQy6knaEmW9cD+9lJ0jf9vKAhM2D2NMHcFFZ/Fk=
X-Google-Smtp-Source: AGHT+IGf62tDN8mXFcenEaMR6BHaYRH620Q4sbEACg4krU437G/4p/+4UlaCgrWyCIlJS29OT9t8kA==
X-Received: by 2002:a17:906:d552:b0:ac1:ea29:4e63 with SMTP id a640c23a62f3a-ac252a866b6mr423637566b.26.1741369326129;
        Fri, 07 Mar 2025 09:42:06 -0800 (PST)
Received: from [192.168.68.113] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac23973a733sm304374366b.112.2025.03.07.09.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 09:42:05 -0800 (PST)
Message-ID: <1167c489-92cb-440e-a2c0-4f47190de5ac@linaro.org>
Date: Fri, 7 Mar 2025 17:42:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvmem: core: add nvmem_cell_size()
To: Jennifer Berringer <jberring@redhat.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250228180326.256058-1-jberring@redhat.com>
 <20250228180326.256058-2-jberring@redhat.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20250228180326.256058-2-jberring@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jennifer,

On 28/02/2025 18:03, Jennifer Berringer wrote:
> This function allows nvmem consumers to know the size of an nvmem cell
> before calling nvmem_cell_write() or nvmem_cell_read(), which is helpful
> for drivers that may need to handle devices with different cell sizes.
> 
> Signed-off-by: Jennifer Berringer <jberring@redhat.com>
> ---
>   drivers/nvmem/core.c           | 18 ++++++++++++++++++
>   include/linux/nvmem-consumer.h |  6 ++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index d6494dfc20a7..4d0cbd20da48 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1624,6 +1624,24 @@ void nvmem_cell_put(struct nvmem_cell *cell)
>   }
>   EXPORT_SYMBOL_GPL(nvmem_cell_put);
>   
> +/**
> + * nvmem_cell_size() - Get nvmem cell size in bytes.
> + *
> + * @cell: nvmem cell.
> + *
> + * Return: size of the nvmem cell.
> + */
> +size_t nvmem_cell_size(struct nvmem_cell *cell)
> +{
> +	struct nvmem_cell_entry *entry = cell->entry;
> +
> +	if (!entry)
> +		return 0;
> +
> +	return entry->bytes;
> +}
> +EXPORT_SYMBOL_GPL(nvmem_cell_size);
> +

There is a similar patch on the list, could you take a look and see if 
that is usable in power reset driver.

https://lore.kernel.org/lkml/20250306093900.2199442-3-o.rempel@pengutronix.de/T/#m97bbb1870d7140661894a4e806a695e563588524



--srini
>   static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
>   {
>   	u8 *p, *b;
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 34c0e58dfa26..a2020527d2d3 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -54,6 +54,7 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
>   struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
>   void nvmem_cell_put(struct nvmem_cell *cell);
>   void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
> +size_t nvmem_cell_size(struct nvmem_cell *cell);
>   void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
>   int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
>   int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
> @@ -117,6 +118,11 @@ static inline void nvmem_cell_put(struct nvmem_cell *cell)
>   {
>   }
>   
> +static inline size_t nvmem_cell_size(struct nvmem_cell *cell)
> +{
> +	return 0;
> +}
> +
>   static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
>   {
>   	return ERR_PTR(-EOPNOTSUPP);


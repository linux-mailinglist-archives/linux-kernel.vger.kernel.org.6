Return-Path: <linux-kernel+bounces-557562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC68A5DAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A4416B70D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635E523CEE5;
	Wed, 12 Mar 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8NswOF9"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B956B1E3DDE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776416; cv=none; b=kkV+rlvjxZwsQaYP7ADfypruUkvRTXFKFZ2VP8GkdRzgpEo+0ARIrobgvgS9FyRH2idNpw77PPRYzX6boHMHsB/tuly+JPVOJH9FWFrdhUCYSC1o3IPqCp4+BMNrpOWqevtxut2gsv1N/M7voM12HdNBim2iawZo4U3Jco/csZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776416; c=relaxed/simple;
	bh=DNEcuPsj+qi3Wnj8L4nF8fNAnK0CaTO8BtviCLKYIc4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OmMiZn5Fb4ibp5d5dbCqdz6QUGygkl5ABDJnuxpGo5np27YFzwBE2UYhiFO2Yn4H1+do7QfllsMSRPXPVUwC6+M9XQDvgZlNHAZFhO9tiIjM7QexHdVvFjmI8oTj8rAI7t1pvjqaTaeD/C1TsYjMS2dJwioH6qwHvPQiY5qjHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8NswOF9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso70321145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741776412; x=1742381212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PlCdoqnuy1rzQZsJE5kNcyighHEqrB9PSElkNCee3L8=;
        b=a8NswOF9m72UOcPpIEabVkHIJICCSLi+frTGSsxGN9+4AxirUXptKiQdYwgHau8WqQ
         Nqx2C+UaicUrUnxCp6Yxo1tZuTeWV1A34rFoHW5edY76Q4E/ZXLdFY15U0eqpIknqQZv
         fFHn9ACF2NK+ci/jim8ZIOS51gnSIT7/1Mq4KP8ntuXQ4v3j+nbmV9hHxvrrDXHTwM4X
         PKdkavfvkHZYWRGFZ1pH5t6bIvN2LiaZf3ivrfmSbB+A9bqkeCl61kDSXbPNjnmcJ5B0
         zh87p4tfbvhH6AtJhlrdbJx5udOAHDSk+7pG17kPtVzzNZuADWvH9ucbVMw9VxMqhElT
         Sujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776412; x=1742381212;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlCdoqnuy1rzQZsJE5kNcyighHEqrB9PSElkNCee3L8=;
        b=v5ue7cEMC6fusBCxRwRcIPbEupFnpv6qlE2hByPxoTa6SsM3kVNfBBCGAqqKhvUCDF
         jkv45N4nGcDKaAmXWut46yoNlrPzX0q/1QOoYhnJxZm8TQjGGF84ZhlTXHivdUaJICPO
         EeO187OwEIqLTn3P3gWB0s6P23A+u2JoXCbKjKFbJBOO8CxSP7EAktpruMkNgIW5z3he
         xuQfTKjTRVu8WWpUVuYyIeGPvAntBzFnLTtZcbftBrrMg11OL5Mum/uztXhJgt6WxTkf
         jQySyO6TjLgRKtSOqNQ0Xj2hPPdXLNcmMhxSHd3VwXcqUt2UBpIarDFqhJ13MVUBMtU3
         qIBA==
X-Gm-Message-State: AOJu0YzbCMfjj1X5Nv5miB1cS2LANpw9tXpCiiIEDIiypjRIzuJkXTVH
	KnqzLr2EEdnP3hZzS85tvvWpihnXCgFZCFNs9gnvYM9a85JOzNRS8eJjeWZsg5c=
X-Gm-Gg: ASbGncvfJ88bvQ1RVBJJCR2Yds4LpZVuk+FuKzy/UG09J+hEYqcNU+QqC93cCR666M0
	j0NA8LFE775KPmiBIGKqeMVZuc+rBN7mmZqw6R9jaYqyif4hJKDVWDI8pjubuUecWg+nQ4i4OfI
	M7p5pgJ5IzZjJ1F6tsTROlyKdLBOn2umj2MPXJ+7PoObt0Pwe9DjnEGpZQtYShq9JQ5N5zNNY3w
	b33DLfFz7qYKPll/l19avwTscYo0tamW9rycOvn5VKQ3qbMQGLFUzeDTwkXo7apVUVA6BMvjO7O
	JWibgEJRP1IHJq3wQDVc0QH/2hnjQe0s9v7dqRv1al9GrxtXFr8uNQ==
X-Google-Smtp-Source: AGHT+IHEYJN4xPkzICEY1jso6wVewx65u7jQrXPP1xJLeTxQL55K5z0VSuFkgMOyPntNnn+Hd4A7Gw==
X-Received: by 2002:a05:600c:5618:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-43cdfb7e4b1mr156156805e9.25.1741776411989;
        Wed, 12 Mar 2025 03:46:51 -0700 (PDT)
Received: from [192.168.1.247] ([209.198.129.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f44sm20474280f8f.76.2025.03.12.03.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 03:46:51 -0700 (PDT)
Message-ID: <bed04866-a477-498a-b33a-a631759733e2@linaro.org>
Date: Wed, 12 Mar 2025 10:46:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: configfs: Constify struct config_item_type
From: James Clark <james.clark@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <1011717e5ed35ec12113a0d8c233823e820fb524.1723368522.git.christophe.jaillet@wanadoo.fr>
 <d8164311-83e7-4fb0-ab82-90e1a2762b01@linaro.org>
Content-Language: en-US
In-Reply-To: <d8164311-83e7-4fb0-ab82-90e1a2762b01@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/08/2024 10:12 am, James Clark wrote:
> 
> 
> On 11/08/2024 10:30 am, Christophe JAILLET wrote:
>> 'struct config_item_type' is not modified in this driver.
>>
>> These structures are only used with config_group_init_type_name() which
>> takes a "const struct config_item_type *" as a 3rd argument or with
>> struct config_group.cg_item.ci_type which is also a "const struct
>> config_item_type    *".
>>
>> Constifying this structure moves some data to a read-only section, so
>> increase overall security, especially when the structure holds some
>> function pointers.
>>
>> On a x86_64, with allmodconfig:
>> Before:
>> ======
>>     text       data        bss        dec        hex    filename
>>     4904       1376        136       6416       1910    drivers/ 
>> hwtracing/coresight/coresight-syscfg-configfs.o
>>
>> After:
>> =====
>>     text       data        bss        dec        hex    filename
>>     5264       1120         16       6400       1900    drivers/ 
>> hwtracing/coresight/coresight-syscfg-configfs.o
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested-only.
>> ---
>>   .../hwtracing/coresight/coresight-syscfg-configfs.c  | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c 
>> b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
>> index 433ede94dd63..213b4159b062 100644
>> --- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
>> @@ -160,7 +160,7 @@ static struct configfs_attribute 
>> *cscfg_config_view_attrs[] = {
>>       NULL,
>>   };
>> -static struct config_item_type cscfg_config_view_type = {
>> +static const struct config_item_type cscfg_config_view_type = {
>>       .ct_owner = THIS_MODULE,
>>       .ct_attrs = cscfg_config_view_attrs,
>>   };
>> @@ -170,7 +170,7 @@ static struct configfs_attribute 
>> *cscfg_config_preset_attrs[] = {
>>       NULL,
>>   };
>> -static struct config_item_type cscfg_config_preset_type = {
>> +static const struct config_item_type cscfg_config_preset_type = {
>>       .ct_owner = THIS_MODULE,
>>       .ct_attrs = cscfg_config_preset_attrs,
>>   };
>> @@ -272,7 +272,7 @@ static struct configfs_attribute 
>> *cscfg_feature_view_attrs[] = {
>>       NULL,
>>   };
>> -static struct config_item_type cscfg_feature_view_type = {
>> +static const struct config_item_type cscfg_feature_view_type = {
>>       .ct_owner = THIS_MODULE,
>>       .ct_attrs = cscfg_feature_view_attrs,
>>   };
>> @@ -309,7 +309,7 @@ static struct configfs_attribute 
>> *cscfg_param_view_attrs[] = {
>>       NULL,
>>   };
>> -static struct config_item_type cscfg_param_view_type = {
>> +static const struct config_item_type cscfg_param_view_type = {
>>       .ct_owner = THIS_MODULE,
>>       .ct_attrs = cscfg_param_view_attrs,
>>   };
>> @@ -380,7 +380,7 @@ static struct config_group 
>> *cscfg_create_feature_group(struct cscfg_feature_desc
>>       return &feat_view->group;
>>   }
>> -static struct config_item_type cscfg_configs_type = {
>> +static const struct config_item_type cscfg_configs_type = {
>>       .ct_owner = THIS_MODULE,
>>   };
>> @@ -414,7 +414,7 @@ void cscfg_configfs_del_config(struct 
>> cscfg_config_desc *config_desc)
>>       }
>>   }
>> -static struct config_item_type cscfg_features_type = {
>> +static const struct config_item_type cscfg_features_type = {
>>       .ct_owner = THIS_MODULE,
>>   };
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Ping. Just found this one hanging in my coresight branch. Still applies 
cleanly.

Thanks



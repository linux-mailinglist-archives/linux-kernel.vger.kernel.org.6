Return-Path: <linux-kernel+bounces-315251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C14196BFD2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75D61F23717
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334141DB55A;
	Wed,  4 Sep 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="gA8MLGoI"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB42F1DA63B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459293; cv=none; b=TBd1w7ufabH9G7THQsoNruY5Utb8jyJPoWvkHrTjBGT9kY3+Uly2z5aBd7uhRyyzUr+ZkBQPVGhbOJFbKDVaJSaRUfIQWuWLHP97R+fyfgeCIT4IK1Ybty+5GB0Zb5x1DhAzWuzyX2d4Nz6UuBXTTaZ612bGUeD6Y1Tun+kAojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459293; c=relaxed/simple;
	bh=EAbM2UnFa72wVdWWBqqRyRQgWejPG1DbzUNZnzQJkEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUJviAYLmh1D+biwSkk7SSWiYZw+ja2zA6Od1Nnch8ikP/XdH2DgXC3Yc7JmPuSy4SBLj94W0Ljo/ipVoTpNlzHs0zW3ml3iw0ZDlpx2okQ8YMDxQluec+cAlinzbOUd5dmq+tn07danknHpUEb718e+IoKdKVyvSCyWI4V0TaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=gA8MLGoI; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70f624c6015so467095a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1725459291; x=1726064091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2zFJNjmlh7TSNpNu+D4XoMWDhZuFDjWykzgo/SVb00=;
        b=gA8MLGoIbMPSPQq7eLROq7puTaFQB+gZAcenXUIQdB9OHv35cg3UXsErY2RHCdQh4j
         RW1Vkf7yHhQJH3HHVy7JaH4WLfQ5NO3K000hQMHVazD+blDumUzghGDlcG3b8h3S6R4+
         R20xvoi0Ngr9VafzctT+9ulKr+LuQ+cHMO16k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459291; x=1726064091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2zFJNjmlh7TSNpNu+D4XoMWDhZuFDjWykzgo/SVb00=;
        b=wp2SKc2L8urIoiBwap8IhifK5460mVjIL1+gSVTJWSqjJrKdu66d+s98k+CEibC5yP
         mrjVKngC4EmQ9PUfRpHU+LVjA7spJqPP1IxN8uRJu8Um2+VPRaJ6vhveVSBPUUNenqUz
         YNpz3k7OhO9hlAJS8RtapCZjeXE2GDPW/n+I2q/L4Tgyyv+91Zhmdt3687U0FPrNOtWr
         X10Xr+qXbvi3di+/WWDzXhVwq3KgLpETkafqqsg+vSgbLn4PXhVXAAKZwsUt8U8FhWn3
         cqOkwcXwey9lcooQd7tu37UzLJUrn+BXdv+zGRNaTo4XUx8TmdoDZZBXgqzsJbml/tjR
         YWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx+mOdkqvwNPYSgTDEd8lm4EqCiQVC6z9oduGAHZPohCAkyqN4hE0/E/npNzIfHcgPComsgaAjplLLKZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJS9pSmA0a41p2ruMwWPMtFS6CUHbmhIv3BW+qM1CgkKjW2oq4
	biYmjK8AagIt+7dSFx5jqJsdMdYqqgvqIsvyk2qfRWk27YW0dg1AfbOhTPq+3kQ=
X-Google-Smtp-Source: AGHT+IF8x1KRFTbVI/tCqTEz2UCODtWaFHD2bIWQmszStc6yMXrPcpHBsLbt9nMWf8YEb5TSrZ9Kpw==
X-Received: by 2002:a05:6830:4123:b0:709:4829:47bd with SMTP id 46e09a7af769-70f5c3d97b2mr19826590a34.22.1725459290711;
        Wed, 04 Sep 2024 07:14:50 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:9198:79cc:8e64:e479? ([2603:8080:7400:36da:9198:79cc:8e64:e479])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671c2a8csm2854961a34.73.2024.09.04.07.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:14:50 -0700 (PDT)
Message-ID: <72e24344-2be4-48e5-b29f-7564fae3b15c@digitalocean.com>
Date: Wed, 4 Sep 2024 09:14:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to
 UNKNOWN
To: "Nelson, Shannon" <shannon.nelson@amd.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com,
 mst@redhat.com, jasowang@redhat.com, sashal@kernel.org,
 alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
 steven.sistare@oracle.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
 eperezma@redhat.com, cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-2-carlos.bilbao.osdev@gmail.com>
 <3e9a6d05-a76c-4bbf-9f4e-2e126259b70e@amd.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <3e9a6d05-a76c-4bbf-9f4e-2e126259b70e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Nelson,

On 9/3/24 12:37 PM, Nelson, Shannon wrote:
> On 9/3/2024 10:15 AM, Carlos Bilbao wrote:
>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>
>> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
>> This is needed because mlx5_vdpa vDPA devicess currently do not support the
>> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
>> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index b56aae3f7be3..5fce6d62af4f 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>>          return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>>   }
>>
>> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
>> +{
>> +    return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
>
> I hate picking at little things like this, but this should be a tab rather than 4 spaces.
>

Correct, thanks, will fix in v3.


> sln
>
>
>> +}
>> +
>>   static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>>   {
>>          if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>          init_rwsem(&ndev->reslock);
>>          config = &ndev->config;
>>
>> +       /*
>> +        * mlx5_vdpa vDPA devices currently don't support reporting or
>> +        * setting the speed or duplex.
>> +        */
>> +       config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
>> +       config->duplex = DUPLEX_UNKNOWN;
>> +
>>          if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>                  err = config_func_mtu(mdev, add_config->net.mtu);
>>                  if (err)
>> -- 
>> 2.34.1
>>

Thanks, Carlos



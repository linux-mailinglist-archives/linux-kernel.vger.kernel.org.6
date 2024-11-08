Return-Path: <linux-kernel+bounces-402478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DA99C283C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1221C21E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212C1F426F;
	Fri,  8 Nov 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="UQlvs9zx"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89852610D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109490; cv=none; b=t/WZT1cHdhk1ZBxbi/Z7kHZ1NViNZhiD+vD0l+mjOhKb1RKOMVYdjzmC6ukDtL/yFLul7uP/OqCelhzY4tpFoik5mobqCr5x45M8O/xpiWVGwy6ImQVnNOptElzH5jcP5sUi2j1vDsx5PsSBS3u+/Qq0lEfDI4PFBaT9rSOuq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109490; c=relaxed/simple;
	bh=ExUMXG6FhgrKWAiklD9tM+a73nAXl3Qf+VUQQugGkzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2EZSsGpvPTLw/PdazvKcC40MbggT4BtzcW9YzCmi74ajy0Ay5jvdWqnPZ46qGMX0FVTsH5AtqRbziy9EqBzaSSKgu7J1bCfDzLg9XgY1s0GP+kgoZAEQGdUq/6dwPGKOgn9pl7oYasRv0ezX5V/uUskwoq/mNd+5nBc7J4pN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=UQlvs9zx; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5f9712991so1518353b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1731109486; x=1731714286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXbMh2FWVPnoribRVM7nCxASoiz/7gphLz9Rpu66roc=;
        b=UQlvs9zxkSgEEfPV5uME/ewEM0pS1gS8LRIPbWgUbvaHsxhjui4CKrtK1B0QvqMCnR
         +dWTofUVkWa0IuUS9Na5Enl3ZWHun9O2Iiz8yOwV1vSrycIbGl5IxGKOwH7TybD2qm+V
         zYJjllOcPqjykION7wAIYLy+e3Jm5bL0yW6sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109486; x=1731714286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXbMh2FWVPnoribRVM7nCxASoiz/7gphLz9Rpu66roc=;
        b=FbDQCoSaDVaeJcg6EwmGOHunGmvJPMZHm+iPVs3YgnI1gK29bWLQfxv9a6akEtTVU9
         1T3vQpuyKR5dKR//QRXpBToftJ/0agoUbd+T/tcMNsbT74dv85Rr8l7+AGu5JaaJYVxJ
         kYYkcPc5+XsYYcKKrf8l8lOuxKCxm7NfdNlCHqZAuqipl5HsEVqcJERJjnISX3Juu/7d
         +jxHaWuc9W7itvanQJd3OGmHwaC7MtevTt4qyHSrwTTifb3A6R0MRrnOhZYmsqU7Yoi7
         waN0wLLr+q/nc2X2adfQySwyyorDc4c5Yl8eypIWFhkv7KCCUfS4oo1Bd2k/o9wXyX5x
         Je6g==
X-Forwarded-Encrypted: i=1; AJvYcCU0yzZwAMiThs0c0QcCshdlP2YfrguJGU+9aak96FwLAYXW8AeU0e8t+p7stHzr0KZ0/q9nWymZQMVHjBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnF0aLnUgRT+w2eYxgPgeQYgc+NB8XHPvb/i8AVsRbONQIgLo
	f0Z7zCyUNCmbY6eUqtSTF/9/NJT+k5ZLY2sqg5uqN54k6yfi4P5L2oOvhO0yxME=
X-Google-Smtp-Source: AGHT+IG+H1FYbgbfbVNVGwbagbKbs0uGKWVICE1ilxxQpWr7EmkKOvo2KKLljNXMkuaHIGL4cbLpWg==
X-Received: by 2002:a05:6808:13c8:b0:3e6:5580:6667 with SMTP id 5614622812f47-3e79475cf8cmr5606582b6e.40.1731109486620;
        Fri, 08 Nov 2024 15:44:46 -0800 (PST)
Received: from ?IPV6:2603:8080:7400:36da:c10e:e419:c908:c818? ([2603:8080:7400:36da:c10e:e419:c908:c818])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cc6748fsm943945b6e.2.2024.11.08.15.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 15:44:45 -0800 (PST)
Message-ID: <bb010d16-a083-44da-8a72-3ada4c6f8056@digitalocean.com>
Date: Fri, 8 Nov 2024 17:44:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to
 UNKNOWN
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, jasowang@redhat.com,
 shannon.nelson@amd.com, sashal@kernel.org, alvaro.karsz@solid-run.com,
 christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com, bilbao@vt.edu,
 xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com, eperezma@redhat.com,
 cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
 <20241107164932-mutt-send-email-mst@kernel.org>
 <f1d671ff-0429-4cb5-a6e8-309a8567924c@nvidia.com>
 <20241108065046-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <20241108065046-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 11/8/24 5:51 AM, Michael S. Tsirkin wrote:
> On Fri, Nov 08, 2024 at 10:31:58AM +0100, Dragos Tatulea wrote:
>>
>> On 07.11.24 22:50, Michael S. Tsirkin wrote:
>>> On Wed, Sep 04, 2024 at 10:11:14AM -0500, Carlos Bilbao wrote:
>>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>>
>>>> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
>>>> This is needed because mlx5_vdpa vDPA devices currently do not support the
>>>> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex.
>>> I see no logic here. Without this feature bit, guests will not read
>>> this field, why do we suddenly need to initialize it?
>>>
>> IIRC, Carlos was reading data via ioctl VHOST_VDPA_GET_CONFIG which calls
>> .get_config() directly, always exposing the speed and duplex config fields [0].
>> Carlos, was this the case?
>>
>> [0] https://lore.kernel.org/lkml/afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com/T/
>>
>> Thanks,
>> Dragos
> Basically, driver should ignore these if feature is not set.


There _is_ a chance the guest could read this field; As Dragos mentioned, I
was using the VHOST_VDPA_GET_CONFIG ioctl from userspace, and the incorrect
field initialization led me to believe I was in half-duplex mode --
something people told me they hadn't seen since the 80s. But as Andrew
(CCed) mentioned, "If the speed is 0, does duplex even matter?".

I also tried to remove the pointless ioctl call altogether to avoid further
confusion [0] but that wasn't viable due to spec compliance.

Initializing the fields seems the simple solution here (and, IMHO, more
generally, it's as a good programming practice)

Thanks for looking into this!

Best,
Carlos

[0] https://lore.kernel.org/lkml/CACGkMEvfdUYLjx-Z+oB11XW-54ErJsQMKcnu2p=dsj5N_BiEKw@mail.gmail.com/


>
>
>>>> Add
>>>> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>>>>
>>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>> ---
>>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> index b56aae3f7be3..41ca268d43ff 100644
>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>>>>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>>>>  }
>>>>  
>>>> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
>>>> +{
>>>> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
>>>> +}
>>>> +
>>>>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>>>>  {
>>>>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>>>> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>>  	init_rwsem(&ndev->reslock);
>>>>  	config = &ndev->config;
>>>>  
>>>> +	/*
>>>> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
>>>> +	 * setting the speed or duplex.
>>>> +	 */
>>>> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
>>>> +	config->duplex = DUPLEX_UNKNOWN;
>>>> +
>>>>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>>>  		err = config_func_mtu(mdev, add_config->net.mtu);
>>>>  		if (err)
>>>> -- 
>>>> 2.34.1


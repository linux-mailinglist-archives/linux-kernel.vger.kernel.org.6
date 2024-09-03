Return-Path: <linux-kernel+bounces-313307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5510096A38A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884D2B261EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD36189526;
	Tue,  3 Sep 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Ninv5cqG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B428188A22
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379312; cv=none; b=ppFWXtsQZh4v2asHCDMUArw0uxUBZE2CatgSuVr92U6iBNJMtR8D7GIjcD3TTdANA2c763jQ9DajxB52ej+RrbF0hVkEGgAceNPR/c/jjK9U7tmJOxMXdfhrrQKd3fFa6PqA3gzvic/Sgm+WPf/YrN/4DgQ5ZsPWhhNrSOa3HIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379312; c=relaxed/simple;
	bh=NRZT8abCFdh85/3FHugcXrZh7c00Mi9fTSZoCHvP0hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p12Nc+Fo+OYBY0uhYfuop9wqcogaqOea9bM+UiSegH4hYvcmPQVQs3GM+bP0QxJdIP4GuucoB7yfFE8q0ENxzZ/ZA7h3KMxiCo2cRyJfejn8PR5NYUAtRVsXc1TYX54bOjBGNAvA0gtbEurqCCcgjfe4RZmpJzVluSlnzefYwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=Ninv5cqG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so36727855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1725379307; x=1725984107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdVAZ1Lff6N0nukYJ/rHVQx42BffOFWzvcbVrT7bSPQ=;
        b=Ninv5cqGEvljUTmd/ZOBP4WMwK4ZHjGGIJKQNMJSfrzti+6s+Us/5yj2WGDMCqkFuG
         EVrCW8kPaY4Ic6M+/6AshpzPEQW7zfPzenqkcDNtmgJxHkwArTB79NX+Rx4o3pmdqHU/
         cwuc6oCrjFvEvgtONEG2AKSedLKpjvq2UnW44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379307; x=1725984107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdVAZ1Lff6N0nukYJ/rHVQx42BffOFWzvcbVrT7bSPQ=;
        b=H4rr0ZfEHm/cbaaglpASV24FLI80p4MSnGhkt78nxbSQk0g92rFfmaFXMOXkVjQRnr
         lA250CsPlCVCFOYD64sF8MgCIZ7+3xkEdT48N08qXkXJxPMF6gG1rV7uV932uYrWDLTU
         ILvcHHh+vF0n+o/dfo+yhdo8Vji5piD3GyfxFbjYUtYXbYRW1LfNtqck2vYR+XUbyKI3
         jYWRuqEM5Ab8ZNP86uDF1AxM2jVqy5RKg1jUC60wmljEF1ficdM2I5eu6jI079XeWhdr
         uP2jWD1Wm0Xls9QUDUtcot2Vy+ywvN1iqJNtBIVXgtCe7NIOkw5BUFQeKcazpmYrxOQl
         TtpA==
X-Forwarded-Encrypted: i=1; AJvYcCURF0yJRDI27Md9b+qnDrzsVmMB8L5GgUe+yMzoamslLbUjNW52MLFMjBg7CKX2XoOBx8TQM1belZKb64o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1jEwsY4DERvq9bE831P3EjwGdXPYjXt9X9yfLkTkxMaxOxTh
	vXO8sWajMF9OHvauRAWBUTv3zgj8+WbP3VL7jKSzZ7R3fkZQxLFNauBw+0mkRVg=
X-Google-Smtp-Source: AGHT+IHIL/6aYNZW1Hx3t8q1OA7oE/XZn0XaW2g6YYk2G/Tqz2Q4bQue8JZweBesdA9BWRRKLdOFfA==
X-Received: by 2002:adf:e544:0:b0:374:be28:d808 with SMTP id ffacd0b85a97d-376dd15b11emr891434f8f.20.1725379307085;
        Tue, 03 Sep 2024 09:01:47 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:9198:79cc:8e64:e479? ([2603:8080:7400:36da:9198:79cc:8e64:e479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c08e07b6sm9403391f8f.63.2024.09.03.09.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:01:46 -0700 (PDT)
Message-ID: <c383c897-79ce-43fc-966a-06a4d609390a@digitalocean.com>
Date: Tue, 3 Sep 2024 11:01:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vdpa: Add support to update speed/duplex in
 vDPA/mlx5_vnet
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com>
 <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
 <CACGkMEtDSDTS_SVvsf7nwMdabGCN85P-r5WpjgZdVDV5PMdc0g@mail.gmail.com>
 <f5e3768d-bb16-48eb-96df-ce5f9593b843@digitalocean.com>
 <CACGkMEtsNeL+o6Rgb=ehj8OJpfkoojasPK1ZMp4S5bMKBjwcng@mail.gmail.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <CACGkMEtsNeL+o6Rgb=ehj8OJpfkoojasPK1ZMp4S5bMKBjwcng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 9/1/24 11:27 PM, Jason Wang wrote:
> On Fri, Aug 30, 2024 at 9:15 PM Carlos Bilbao <cbilbao@digitalocean.com> wrote:
>> Hello,
>>
>> On 8/29/24 9:31 PM, Jason Wang wrote:
>>> On Fri, Aug 30, 2024 at 5:08 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>> (resending as I accidentally replied only to Carlos)
>>>>
>>>> On 29.08.24 18:16, Carlos Bilbao wrote:
>>>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>>>
>>>>> Include support to update the vDPA configuration fields of speed and
>>>>> duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
>>>>> mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initial
>>>>> values to UNKNOWN. Also add a warning message for when
>>>>> mlx5_vdpa_get_config() receives offset and length out of bounds.
>>>>>
>>>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>>>>> ---
>>>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 ++++++++++++++++++++++++++++++-
>>>>>  drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
>>>>>  include/uapi/linux/vdpa.h         |  2 ++
>>>>>  3 files changed, 62 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> index c47009a8b472..a44bb2072eec 100644
>>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> @@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>>>>
>>>>>       if (offset + len <= sizeof(struct virtio_net_config))
>>>>>               memcpy(buf, (u8 *)&ndev->config + offset, len);
>>>>> +     else
>>>>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>>>>>  }
>>>>>
>>>>>  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>>>>                                unsigned int len)
>>>>>  {
>>>>> -     /* not supported */
>>>>> +     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>>> +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>>> +
>>>>> +     if (offset + len > sizeof(struct virtio_net_config)) {
>>>>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>>>>> +             return;
>>>>> +     }
>>>>> +
>>>>> +     /*
>>>>> +      * Note that this will update the speed/duplex configuration fields
>>>>> +      * but the hardware support to actually perform this change does
>>>>> +      * not exist yet.
>>>>> +      */
>>>>> +     switch (offset) {
>>>>> +     case offsetof(struct virtio_net_config, speed):
>>>>> +             if (len == sizeof(((struct virtio_net_config *) 0)->speed))
>>>>> +                     memcpy(&ndev->config.speed, buf, len);
>>>>> +             else
>>>>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for speed.\n");
>>>>> +             break;
>>>>> +
>>>>> +     case offsetof(struct virtio_net_config, duplex):
>>>>> +             if (len == sizeof(((struct virtio_net_config *)0)->duplex))
>>>>> +                     memcpy(&ndev->config.duplex, buf, len);
>>>>> +             else
>>>>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for duplex.\n");
>>>>> +             break;
>>>>> +
>>>>> +     default:
>>>>> +             mlx5_vdpa_warn(mvdev, "Configuration field not supported.\n");
>>>> This will trigger noise in dmesg because there is a MAC configuration here.
>>>>> +     }
>>>> I would prefer that the .set_config remains a stub TBH. Setting the fields here is
>>>> misleading: the user might deduce that the configuration worked when they read the
>>>> values and see that they were updated.
>>> Yes, and actually, those fields are read-only according to the spec:
>>>
>>> """
>>> The network device has the following device configuration layout. All
>>> of the device configuration fields are read-only for the driver.
>>> """
>>>
>>> Thanks
>>
>> Should I go ahead and remove the ioctl then?
> If you meant mlx5_vdpa_set_config, I think yes.


Ack, I will send a new patch set in which the second commit gets rid of the
ioctl -- but not only for mlx5 but for all vDPA implementations.


>
> Thanks
>

Thanks, Carlos



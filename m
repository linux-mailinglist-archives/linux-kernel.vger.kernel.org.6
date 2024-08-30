Return-Path: <linux-kernel+bounces-308853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB2E9662BB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A85B20582
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018B2192D7B;
	Fri, 30 Aug 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CcZGbGRo"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8018EFD2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023718; cv=none; b=D3H/Rna4Gl/ZYlu1TlwmOfdUwifBM/5YkWOxmtLqzZv/HPxxKc2j2DQvwFXFF5Dt/FDLq9tO0t//CIAXLO1XheGJvFLvUWhNgZy19UALJ7HkuaGbkjYkjcW3YpvCKi2sYUXcUFhLyEkW5CyMxseY1NLwSUEk9vCFlkhk14M+62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023718; c=relaxed/simple;
	bh=0JUFgJrZCyLHbuoyvfTevfGPfsUEGgoeCm03Y51wjd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQCyNgNuON3yZ7flPvNfZBRed2ErJu3TedicgSa2SfK+77UZhk0tW6T9FP3rWoswkc5so8PrQShecwlGO9AcG2iHZ5Sod1HAQdTNwncukcB8fM7uAXGxuJmhR4CYeo7+xi1L/5vdLlE2SJnwjuhZaJjoHCpvAgZ6TwUV/IjciuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=CcZGbGRo; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-273c8514254so1098289fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1725023715; x=1725628515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VprTCVdPbtS+6PHftPZIj/39sG8TMOu+xi6y54Sq9AA=;
        b=CcZGbGRojnzdvUPZBHmA6mhTRe79Fs/j6OUYpkgIcIyRwyrw0Td0Lvu3gEqRHyf0cS
         xFFxeobe8RZdYUcnjaigyJsGZiX6fAdwmWr0LSHb3BmVB3mh1aDJee5o3oQTKMCoJIsI
         wsLuDebwfmyShbN0DfK4A6s5cr2foMRBEb+vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725023715; x=1725628515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VprTCVdPbtS+6PHftPZIj/39sG8TMOu+xi6y54Sq9AA=;
        b=EfRz1BCs1NDiw4cfQwtzt7aXCKYACZBcO1jxg9Ua871kZ1Hba4mbdEaGvg1nrxZDsV
         sN5PObF8Nq/V3eYrma/mwzDSGETRmUzcKFtfYJKZy3KQajBduxe0fRDLMNq97hJnOtlF
         m5IfX7MN63wTacyqQXyCMmtQzON5hlLkR+JTJTCPy78DN6MMGK0DcQdXe+YHh6BM52YX
         u1AO8wqK3F7Z+0cTS4r33ZyyZbZz5JPURCJ0Y6RBThcbohKbh/PpSyYM9J46csCVMkyU
         VLGz01sG0RPi+JKeQfWvD4vp8VkuJeQ2yhTLA0W/kt5AhO6G1RTBVnZnzdbPbxaAi3jv
         jwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ogGHbkGIa/WK+QCvss8kjqWlhPPds0A7CBBArCws7WOtXwyKNt63tye9YOiJZ4cEELAfkqKVTL4dujE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqS/mdINHqnFdNEqv+nPd6Mke8he1OkUu5hmfEnPTX34Z/9AVh
	gMyyD9SP+0GhLLadoawm/jTZfcFHLiohD2ZEYaKZT142rbujuNwhWrf9jXorNfw=
X-Google-Smtp-Source: AGHT+IEEf8JDw0+ehxvIQaSDZh9XomjN8oJZ98PS+YmIyAoTGCq+h+/U7tisWHB2JSk4bSqDG6a6Cw==
X-Received: by 2002:a05:6871:58b:b0:260:f058:48eb with SMTP id 586e51a60fabf-27790129b30mr6397898fac.20.1725023715099;
        Fri, 30 Aug 2024 06:15:15 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:b4f6:16b8:9118:2c1a? ([2603:8080:7400:36da:b4f6:16b8:9118:2c1a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-277abae1dc0sm529859fac.12.2024.08.30.06.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 06:15:14 -0700 (PDT)
Message-ID: <f5e3768d-bb16-48eb-96df-ce5f9593b843@digitalocean.com>
Date: Fri, 30 Aug 2024 08:15:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vdpa: Add support to update speed/duplex in
 vDPA/mlx5_vnet
To: Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com>
 <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
 <CACGkMEtDSDTS_SVvsf7nwMdabGCN85P-r5WpjgZdVDV5PMdc0g@mail.gmail.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <CACGkMEtDSDTS_SVvsf7nwMdabGCN85P-r5WpjgZdVDV5PMdc0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/29/24 9:31 PM, Jason Wang wrote:
> On Fri, Aug 30, 2024 at 5:08 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>> (resending as I accidentally replied only to Carlos)
>>
>> On 29.08.24 18:16, Carlos Bilbao wrote:
>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>
>>> Include support to update the vDPA configuration fields of speed and
>>> duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
>>> mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initial
>>> values to UNKNOWN. Also add a warning message for when
>>> mlx5_vdpa_get_config() receives offset and length out of bounds.
>>>
>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>>> ---
>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 ++++++++++++++++++++++++++++++-
>>>  drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
>>>  include/uapi/linux/vdpa.h         |  2 ++
>>>  3 files changed, 62 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index c47009a8b472..a44bb2072eec 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>>
>>>       if (offset + len <= sizeof(struct virtio_net_config))
>>>               memcpy(buf, (u8 *)&ndev->config + offset, len);
>>> +     else
>>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>>>  }
>>>
>>>  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>>                                unsigned int len)
>>>  {
>>> -     /* not supported */
>>> +     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> +
>>> +     if (offset + len > sizeof(struct virtio_net_config)) {
>>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>>> +             return;
>>> +     }
>>> +
>>> +     /*
>>> +      * Note that this will update the speed/duplex configuration fields
>>> +      * but the hardware support to actually perform this change does
>>> +      * not exist yet.
>>> +      */
>>> +     switch (offset) {
>>> +     case offsetof(struct virtio_net_config, speed):
>>> +             if (len == sizeof(((struct virtio_net_config *) 0)->speed))
>>> +                     memcpy(&ndev->config.speed, buf, len);
>>> +             else
>>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for speed.\n");
>>> +             break;
>>> +
>>> +     case offsetof(struct virtio_net_config, duplex):
>>> +             if (len == sizeof(((struct virtio_net_config *)0)->duplex))
>>> +                     memcpy(&ndev->config.duplex, buf, len);
>>> +             else
>>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for duplex.\n");
>>> +             break;
>>> +
>>> +     default:
>>> +             mlx5_vdpa_warn(mvdev, "Configuration field not supported.\n");
>> This will trigger noise in dmesg because there is a MAC configuration here.
>>> +     }
>> I would prefer that the .set_config remains a stub TBH. Setting the fields here is
>> misleading: the user might deduce that the configuration worked when they read the
>> values and see that they were updated.
> Yes, and actually, those fields are read-only according to the spec:
>
> """
> The network device has the following device configuration layout. All
> of the device configuration fields are read-only for the driver.
> """
>
> Thanks


Should I go ahead and remove the ioctl then?


>
>> Thanks,
>> dragos
>>>  }
>>>
>>>  static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 4dbd2e55a288..b920e4405f6d 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -15,6 +15,7 @@
>>>  #include <net/genetlink.h>
>>>  #include <linux/mod_devicetable.h>
>>>  #include <linux/virtio_ids.h>
>>> +#include <uapi/linux/ethtool.h>
>>>
>>>  static LIST_HEAD(mdev_head);
>>>  /* A global mutex that protects vdpa management device and device level operations. */
>>> @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
>>>       return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>>>  }
>>>
>>> +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
>>> +                                     struct virtio_net_config *config)
>>> +{
>>> +     __le32 speed = cpu_to_le32(SPEED_UNKNOWN);
>>> +
>>> +     return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
>>> +}
>>> +
>>> +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
>>> +                                     struct virtio_net_config *config)
>>> +{
>>> +     u8 duplex = DUPLEX_UNKNOWN;
>>> +
>>> +     return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
>>> +}
>>> +
>>>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>>>  {
>>>       struct virtio_net_config config = {};
>>> @@ -940,6 +957,16 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>>>
>>>       if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
>>>               return -EMSGSIZE;
>>> +     /*
>>> +      * mlx5_vdpa vDPA devicess currently do not support the
>>> +      * VIRTIO_NET_F_SPEED_DUPLEX feature, which reports speed and
>>> +      * duplex; hence these are set to UNKNOWN for now.
>>> +      */
>>> +     if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
>>> +             return -EMSGSIZE;
>>> +
>>> +     if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
>>> +             return -EMSGSIZE;
>>>
>>>       return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>>>  }
>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>> index 842bf1201ac4..1c64ee0dd7b1 100644
>>> --- a/include/uapi/linux/vdpa.h
>>> +++ b/include/uapi/linux/vdpa.h
>>> @@ -43,6 +43,8 @@ enum vdpa_attr {
>>>       VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
>>>       VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
>>>       VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
>>> +     VDPA_ATTR_DEV_NET_CFG_SPEED,            /* u32 */
>>> +     VDPA_ATTR_DEV_NET_CFG_DUPLEX,           /* u8 */
>>>
>>>       VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>>>       VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */


Thanks, Carlos



Return-Path: <linux-kernel+bounces-307796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F8965313
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734BE284277
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9C1BAECC;
	Thu, 29 Aug 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="DOgxxYEn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADF18A927
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971115; cv=none; b=B0a/larqCiBcQRjrjt0e74UWOGDuCvl7z9/e5TRq3ebS8LfPYf+0920oJItZDKcJc+Nz8b/tW7giE2K1KolfPrcLZHm7y/WxWT7a18vIW9JDlrUWwEpFv0TJf9QjqwEkobnZ1bpf8JnsOb528KrAwOY9NG4iXTSlhXMEOiB/qBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971115; c=relaxed/simple;
	bh=ULs1eNO5Gtq22RBbYQ8qaF/dLffxu0QFA0DwjhJE7g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo10qSuEET6l+NKZ9LmrKCwhq8UtgUPe2XEQlVK6o47/cpQO5twLDQxxmpHzvsiQk9dVYGvB5gVM+xyXdcwFUKkGmabzbL9hiC4HnrlRbFS+sI9PDXKS92p4T5JdvbYZqbF+fx3o/mkbqqtJXfD3ReWVKcDDKHICARs3YmIh6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=DOgxxYEn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so736293b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724971113; x=1725575913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6JxLN6jgWh31KN7TEo/vEC+PoZGe47rz1RImVm+TU4=;
        b=DOgxxYEn9uSOZOppxPE7It31SO5AV7xxIclWRIOxbOU47uz3smxrQ3dXvHc7BUPRKQ
         bV7LCS+w2q/E18LODOrWElmSHHrsLuEwxEsPQeZd14kR6QbKlZb8wR8zgroohR/+Jvtl
         wA/WG7wki2YrLlvO5EQs9ch+/RyrNplENG4OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724971113; x=1725575913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6JxLN6jgWh31KN7TEo/vEC+PoZGe47rz1RImVm+TU4=;
        b=rSPMWSl4C5PEbmnkiaH3PFxAZrXeDfLcytm7kZioQMKvV1bPpxQ9yIetO9b4V5QOsb
         7Nc5A/26pEaxJsD0t6h66jUf+Zy6bcHRDrSAkgip05SA1LruEYxF62Ks0uUeob8Y4Zi3
         ScNwaomzgSZ6+zuhAtsOL0hZ4vRehzvfkJYPXWT8Jsd3KKncl3dvTrexLGbXxKI9t7Bh
         6TgSpuA6zLW/F48C0LFTUZB2cSYPu47Ib5wv2m9ALw8EPPK4iA2pX/wNoxWVQqD+S4JD
         674J4YZJ2Kq+ADDvWifFvTN7JuSs4cQwGME5G2KdFEgSzgleg7eQy378al2Bfbfs4kl6
         51mg==
X-Forwarded-Encrypted: i=1; AJvYcCVCsrPGka9yM2O95+6OiUIzpEgBc2P2zdu9iUCWvx4E+9DS6aiszUylk0I8y2AfJPix58g10FHEY9YJQhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81G6XFMS0WY5FSU0eWqHxws8FHXUvyKH5LUqCw1HVwD3GY9WE
	iDi2swJayoqNnsZhY2hMktwySGDNk0qg7/KgT8Ml4AU517bF+TMSYB5fDX3+nNk=
X-Google-Smtp-Source: AGHT+IGXLH/kJOGdNBNyfNCznDW7lIkDKiLgby/nl6dKJoyW0rD/UQl6UGhWKYr21yk4uySVrnP9qQ==
X-Received: by 2002:a05:6a21:3981:b0:1c4:7a11:9ef1 with SMTP id adf61e73a8af0-1cce100ebccmr4454504637.15.1724971112580;
        Thu, 29 Aug 2024 15:38:32 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:b4f6:16b8:9118:2c1a? ([2603:8080:7400:36da:b4f6:16b8:9118:2c1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a692fsm1620721b3a.60.2024.08.29.15.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 15:38:32 -0700 (PDT)
Message-ID: <5415a7ac-68a4-46fd-9ac4-35400385818f@digitalocean.com>
Date: Thu, 29 Aug 2024 17:38:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vdpa: Add support to update speed/duplex in
 vDPA/mlx5_vnet
To: Dragos Tatulea <dtatulea@nvidia.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com>
 <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 8/29/24 4:07 PM, Dragos Tatulea wrote:
> (resending as I accidentally replied only to Carlos)
>
> On 29.08.24 18:16, Carlos Bilbao wrote:
>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>
>> Include support to update the vDPA configuration fields of speed and
>> duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
>> mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initial
>> values to UNKNOWN. Also add a warning message for when
>> mlx5_vdpa_get_config() receives offset and length out of bounds.
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 ++++++++++++++++++++++++++++++-
>>  drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
>>  include/uapi/linux/vdpa.h         |  2 ++
>>  3 files changed, 62 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index c47009a8b472..a44bb2072eec 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>  
>>  	if (offset + len <= sizeof(struct virtio_net_config))
>>  		memcpy(buf, (u8 *)&ndev->config + offset, len);
>> +	else
>> +		mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>>  }
>>  
>>  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>  				 unsigned int len)
>>  {
>> -	/* not supported */
>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>> +
>> +	if (offset + len > sizeof(struct virtio_net_config)) {
>> +		mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Note that this will update the speed/duplex configuration fields
>> +	 * but the hardware support to actually perform this change does
>> +	 * not exist yet.
>> +	 */
>> +	switch (offset) {
>> +	case offsetof(struct virtio_net_config, speed):
>> +		if (len == sizeof(((struct virtio_net_config *) 0)->speed))
>> +			memcpy(&ndev->config.speed, buf, len);
>> +		else
>> +			mlx5_vdpa_warn(mvdev, "Invalid length for speed.\n");
>> +		break;
>> +
>> +	case offsetof(struct virtio_net_config, duplex):
>> +		if (len == sizeof(((struct virtio_net_config *)0)->duplex))
>> +			memcpy(&ndev->config.duplex, buf, len);
>> +		else
>> +			mlx5_vdpa_warn(mvdev, "Invalid length for duplex.\n");
>> +		break;
>> +
>> +	default:
>> +		mlx5_vdpa_warn(mvdev, "Configuration field not supported.\n");
> This will trigger noise in dmesg because there is a MAC configuration here.
>> +	}
> I would prefer that the .set_config remains a stub TBH. Setting the fields here is
> misleading: the user might deduce that the configuration worked when they read the
> values and see that they were updated.


Well, people might already assume that the values are updated because there
is an ioctl available to user space (VHOST_VDPA_SET_CONFIG) that doesn't
warn or return an error - or at least I did.

But, I understand your concern. I propose that we at least return an error
in the ioctl if the requested config updated is not supported. We could
also structure this patch so that it can be used when or if hardware
support becomes available in the future.

Is there a way to query the hardware capabilities of the card, e.g., MSRs
or other methods? Do you recommend any technical manual?

Or, if the ioctl uses, for example, /dev/vhost-vdpa-2, does its speed and
duplex settings correspond to those of the tap device it links to? This
information can be checked and changed using the definitions in
include/uapi/linux/ethtool.h.

Thank you for taking the time to read and answer me.


>
> Thanks,
> dragos
>>  }
>>  
>>  static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index 4dbd2e55a288..b920e4405f6d 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -15,6 +15,7 @@
>>  #include <net/genetlink.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/virtio_ids.h>
>> +#include <uapi/linux/ethtool.h>
>>  
>>  static LIST_HEAD(mdev_head);
>>  /* A global mutex that protects vdpa management device and device level operations. */
>> @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
>>  	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>>  }
>>  
>> +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
>> +					struct virtio_net_config *config)
>> +{
>> +	__le32 speed = cpu_to_le32(SPEED_UNKNOWN);
>> +
>> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
>> +}
>> +
>> +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
>> +					struct virtio_net_config *config)
>> +{
>> +	u8 duplex = DUPLEX_UNKNOWN;
>> +
>> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
>> +}
>> +
>>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>>  {
>>  	struct virtio_net_config config = {};
>> @@ -940,6 +957,16 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>>  
>>  	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
>>  		return -EMSGSIZE;
>> +	/*
>> +	 * mlx5_vdpa vDPA devicess currently do not support the
>> +	 * VIRTIO_NET_F_SPEED_DUPLEX feature, which reports speed and
>> +	 * duplex; hence these are set to UNKNOWN for now.
>> +	 */
>> +	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
>> +		return -EMSGSIZE;
>> +
>> +	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
>> +		return -EMSGSIZE;
>>  
>>  	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>>  }
>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>> index 842bf1201ac4..1c64ee0dd7b1 100644
>> --- a/include/uapi/linux/vdpa.h
>> +++ b/include/uapi/linux/vdpa.h
>> @@ -43,6 +43,8 @@ enum vdpa_attr {
>>  	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
>>  	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
>>  	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
>> +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u32 */
>> +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u8 */
>>  
>>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>  	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */


Thanks, Carlos



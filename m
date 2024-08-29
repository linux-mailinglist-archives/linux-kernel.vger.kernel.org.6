Return-Path: <linux-kernel+bounces-307014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863709646DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77AB1C21A81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46D1B011A;
	Thu, 29 Aug 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Om4jcHXi"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEA1A7AF3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938593; cv=none; b=P+v2bmS4ynZAZMUk4c4Kr3cEDWueoN0UGU83LyKOm/7gIN8rkHYXnH/wN6i5KP/DoQtIxQpBWtMeWYdD3gaOlVcpRoczJG6wNMjfLAd+phVcd4Cz1Fyz0zJ0cDbtP7ijfHSBPd1HIBdNcDfjcIEPKQNJwOE/cJlbArq9Z7RnoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938593; c=relaxed/simple;
	bh=0b4JYB0fdnkgZswINeMZZ5lXdMTAicEdnaM+Pb7nxj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxsXVBlAl+xMMSCabh3KT9p3bGRrnv1lwBuos/UjnGA1GfUUxZqXTgJBhx3+kw4eRO9RR9tpgFT1G+ml3THq1mTUoS8Ta6v4OSvmOxHEsnpZNKR7Otop0k834yjhiEXi87ZaZb/n7rvuz2x84TDH8ni6s/Qb6eAwZ3onL9qh4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=Om4jcHXi; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5c7f24372so374940eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724938591; x=1725543391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcflD0rJdognRnckvpOw1m0o37d9JitlAxoHKprnaJU=;
        b=Om4jcHXiGTu8MtFDE1WClLPAYdOg99bia6eQSoJanpAA3lvxxR6BkCKphZHkYLYewx
         HK8gMi/1K7bP4FW/BHL1z+8VIOmql+DnTUYDryFKOcsuPVb8ePijGpvaa+T3/4eBhYeL
         I42DUesV5qBhvo8BWfnR4XnrTHwfbF8n30vnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938591; x=1725543391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcflD0rJdognRnckvpOw1m0o37d9JitlAxoHKprnaJU=;
        b=aLjcMTwJVkotcMBw1JDBtR2WOWlUiMi+Vyx5AmadeiCoPKb6L9QrySpZXl2NERC/Xe
         bE2W4RAxSqNvwsegBeF7l6zIRdYmLqa+4NPgBhQc09+eVHRnVGFEzUO4tGTipuf+ywHr
         DrAIftfvas0gV4peUbvSMsYY+aa8x1rXf40sJ8KlOMSj/R+TUdiX+8k7cHpM3PnpsgjU
         ds1Q02wbgsjAvwlqvWrzw7vWpYDZd81ImLi0OD688+dSgiT6qghRehgU6ZW8nhCbpEHb
         h4YMg+0vulFnk3KMmpL8lpxGZsgtXunnd1ktvALBbKGWHyYO2dDOmUcHwX30ZzvoYraE
         r8jg==
X-Forwarded-Encrypted: i=1; AJvYcCVb4TS+YS9j7hbN1dyrv47zWFlkFZLcwP8X3SlT3ybMyvkeYjOMBy8UYET59HbcBos0SDLaYqqemMbUCjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDq4rx4R+wg/DnSpfYJaY8DgLvIkzyCZzQpFjEYqQcU//TpTz
	YL7ndJFFuNiqBlstAJ7lzvmyz8/qWvlwgM1ZlS1v6BtkS7cJzwfye/XrO4tHh5zzOQHvE+dcYfk
	erGJg0w==
X-Google-Smtp-Source: AGHT+IGXNyeCI9Os4sl/asG/hqkfvpNaoFn+aw2MfHYyZTFEoIHQm1ybAQK/fnqTcXCVbAfE+0qFpw==
X-Received: by 2002:a05:6820:1b86:b0:5dc:9f44:7a3b with SMTP id 006d021491bc7-5df980cdde2mr3442407eaf.4.1724938580278;
        Thu, 29 Aug 2024 06:36:20 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:b4f6:16b8:9118:2c1a? ([2603:8080:7400:36da:b4f6:16b8:9118:2c1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dfa049b7e0sm210186eaf.12.2024.08.29.06.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 06:36:19 -0700 (PDT)
Message-ID: <4ee9e014-bc88-4d2d-9173-fe0781c3dcce@digitalocean.com>
Date: Thu, 29 Aug 2024 08:36:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
To: Dragos Tatulea <dtatulea@nvidia.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
 <8a8d3c23-5e91-4456-99c2-6e91548abe42@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <8a8d3c23-5e91-4456-99c2-6e91548abe42@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/29/24 5:20 AM, Dragos Tatulea wrote:
>
> On 28.08.24 20:16, Carlos Bilbao wrote:
>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>
>> mlx5_vdpa vDPA devices currently don't support reporting or setting the
>> speed and duplex and hence should be UNKNOWN instead of zero.
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
>>  drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
>>  include/uapi/linux/vdpa.h         |  2 ++
>>  3 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index fa78e8288ebb..319f5c6121de 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>  	init_rwsem(&ndev->reslock);
>>  	config = &ndev->config;
>>  
>> +	/*
>> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
>> +	 * setting the speed or duplex.
>> +	 */
>> +	config->speed  = SPEED_UNKNOWN;
>> +	config->duplex = DUPLEX_UNKNOWN;
>> +
> The values in virtio_net_config are little endian so you'll need to explicitly
> convert them. As speed is a u32, you'll need to add a cpu_to_mlx5vdpa32() helper.
>
> Thanks,
> Dragos
>
>>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>  		err = config_func_mtu(mdev, add_config->net.mtu);
>>  		if (err)
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index 4dbd2e55a288..abde23e0041d 100644
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
>> @@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>>  	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
>>  		return -EMSGSIZE;
>>  
>> +	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
>> +		return -EMSGSIZE;
>> +
>> +	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
>> +		return -EMSGSIZE;
>> +
>>  	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>>  }
>>  
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


Thank you all for the feedback, everyone. I will prepare a patch set with
two commits:

 - One to set speed and duplex to UNKNOWN (in little-endian format, thank
   you, Dragos).

 - Another to update the vDPA tool to allow setting the values for speed
   and duplex, including support in set_config(). I'll add a comment
   clarifying that this support isn't fully implemented at the hardware
   level yet.

Regards,
Carlos



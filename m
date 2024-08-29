Return-Path: <linux-kernel+bounces-307745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C4965258
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07ADEB21885
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B041BA28A;
	Thu, 29 Aug 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="X+pQoj1r"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D0C18B47E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968352; cv=none; b=Jescsf72/G8wPiDg1tRwZWTxxbyQjkalGCHSrXJuL1TN04F9zLpywsV4CGulpaLWAYAsMzn01iIt+q7xC5YLwxeq69Jfkgw1/50hxggYqMHaR4bhjQIl27oWnvTu/3Pg22R81HslzfuLAq109pmAeo83Aws/+toPxo9EqBLamc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968352; c=relaxed/simple;
	bh=/CcmcTMnessIb6rMXo6Vz2q2P03f6osUH9ntyJOQAxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZ2xyN6CSFBbhxG1Cy/rAWVPXLCyQKu/q20yyiMPhGIB1IDsg/f4tpkT6pIHj9ZcMAGeXTgrRXWtH3QInWWOJlkeT9cuPOABlod4DcBJhow0JhP7jCSwqXPvg+kieRo1mXUZnCap9n08cCAfIHl2QQiBIes7yzg1EDWMOSGMfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=X+pQoj1r; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-716609a0e2bso162875b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724968350; x=1725573150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nbmb+IWtpDLVzhb8oZPS2dnRSnnkWab/SsKmSrsVb4=;
        b=X+pQoj1riozZGn63ewd8OxH88LHrjJwfRzzQ0wCBW4q2FyWZ2UZEhCZpu0QKkxmKNc
         fYIVTqRY6fpccvl5ZWGLA+U+5UeVeICtPK+cZ7iCW5gbVR37WE63+py00hEu/pMP6QSb
         Ddt0rGWB0ZFaDu596cJQMDiCWN/PB5b0keDqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968350; x=1725573150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nbmb+IWtpDLVzhb8oZPS2dnRSnnkWab/SsKmSrsVb4=;
        b=HyukPzWnPlZs0xTPkaj4Ph0eyT/nAnLbYFkgknB/V2zACU2IKU/qh6g8GKb5JNlwUI
         EdKTsLu1dkU79Qd40K58TKn6bSfEcjsb8x4kbGu86nsRuC/Gm9AtMEuZ/U4g5FEcLfbO
         Oih8MeotxQCAjHHtkv4uAbSyiS08rf3Lha70uUMJ9emgBrJDdkT5FMNf9RbNzFdUwAY5
         KWKoq2Pz4WmpxFg22JOPOj2L8Ij+fF+jLQud/f9LBZMMFxFEW+yT1DHtF+KFRLKb/JiI
         Fp1PQNu/APwu1OQ6G1Mz2owGoZl0rdMYkTK5CeugQTj50Tro8pj+UE4SBFM0QSKIkk7I
         qorQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoy/WAWGN2vEnHfRysFW7KwugtXXk1+iAI2+9nsQ6okVF+EbuFJozgGJfJr+zYbxaWdyJKKx6Mbd1E6rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycouRD7CwbvALj1j9L3D1tFzuAW25d++HkyMehxGNi+YxjY3T8
	2SkdLDFxOlEXzdTc1beldv5NJxpN4rQSLj4jYNyXU4ADm5TfceNC9SdxOydDl0o=
X-Google-Smtp-Source: AGHT+IFOTao+ygbBsNeq08peBUYhqOzW1NLF2cvp5AwTrSk4J8BKeL7KcmVJZPv+rR6r542tbxicXg==
X-Received: by 2002:a05:6a20:cd91:b0:1cc:e969:a783 with SMTP id adf61e73a8af0-1cce969b0admr2221511637.20.1724968349291;
        Thu, 29 Aug 2024 14:52:29 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:b4f6:16b8:9118:2c1a? ([2603:8080:7400:36da:b4f6:16b8:9118:2c1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5223sm1587084b3a.72.2024.08.29.14.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:52:28 -0700 (PDT)
Message-ID: <a5d0e215-87ed-4fda-917d-7f95409a3d55@digitalocean.com>
Date: Thu, 29 Aug 2024 16:52:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mlx5_vnet: Set speed and duplex of vDPA devices to
 UNKNOWN
To: Dragos Tatulea <dtatulea@nvidia.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-2-carlos.bilbao.osdev@gmail.com>
 <06bda32c-6670-4d47-bd68-f8d0771aa838@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <06bda32c-6670-4d47-bd68-f8d0771aa838@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 8/29/24 1:44 PM, Dragos Tatulea wrote:
>
> On 29.08.24 18:16, Carlos Bilbao wrote:
>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>
>> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
>> This is needed because mlx5_vdpa vDPA devicess currently do not support the
>> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
>> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> Nit: prefix is vdpa/mlx5. Once that is fixed, for this patch:
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>


Thank you, will keep that in mind to fix in v2.


>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index fa78e8288ebb..c47009a8b472 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -193,6 +193,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>>  }
>>  
>> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
>> +{
>> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
>> +}
>> +
>>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>>  {
>>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>> @@ -3795,6 +3800,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>  	init_rwsem(&ndev->reslock);
>>  	config = &ndev->config;
>>  
>> +	/*
>> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
>> +	 * setting the speed or duplex.
>> +	 */
>> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
>> +	config->duplex = DUPLEX_UNKNOWN;
>> +
>>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>  		err = config_func_mtu(mdev, add_config->net.mtu);
>>  		if (err)


Thanks, Carlos



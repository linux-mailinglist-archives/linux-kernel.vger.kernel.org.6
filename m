Return-Path: <linux-kernel+bounces-301669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FB95F3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF4F1C217C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D1018E743;
	Mon, 26 Aug 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Hc7B9JSd"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1F18D64B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682390; cv=none; b=oB4C3Yrr3yzX5FJMlCO0bA8HLXNrXRYumBcd0LPGxKtbrqVfnyOAgoUKECIW+RMdVoQE7VceV4CTf85KZoJRSXo0Zx+BjsmdiYip7dcLLsr2F7JLoHd0FUg6MPH2BRScROGv+0GwMBhXfHB3cgProjBehNeNex5V6OoJ8f6WCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682390; c=relaxed/simple;
	bh=j2YzyquIcqOBkL5820gFp/L4JHF1EzvqRlwP2pitwjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNFExX0xPa+W3Qed2Z2l593/cbVEdh+qalXLZA8kQRdGFXA//1+DGqzRknE2MHYyjDEwUe4suKgpoyNpi97x29cfmI7ldaIga9nrz/UJZBTkqwOOG/8qxfy5B5nxyOIrVc7yLwTSmgCUB0ifwDlNbgNb8yEHm6msQqwX4XL2JFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=Hc7B9JSd; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso3948333276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724682388; x=1725287188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpWiMMhNfGvh8VuUq4vLeaPQYJOMaJrubxkW6+puf9U=;
        b=Hc7B9JSd//Iyn0VeYi6IVZCunEON1ajivtO9ewgOS4ZP8r8JnXM+mMEy/vb+Y8rFW9
         wRTrzFfRY/cybfswtvRubetl7ieaHms+nWCyiShpR5DvHQjwiS0FNMmfG8ElzsxzkvHT
         uLD+/rP5Y0GHqMSz3vpTlivTCIszqM8h3xtkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682388; x=1725287188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpWiMMhNfGvh8VuUq4vLeaPQYJOMaJrubxkW6+puf9U=;
        b=tzh8CFDnJ8zH8MhBHJQT7l5uf4ROcfovi+O3SLhj01oSePRokpY8U84J0uzIXIXXz5
         TI1w/Ph71BNcN4iDm0vj+bwCibgEGjt3dtK4sOXFUKn/MlKGg/BwT/y4kXfSWfgdeCS9
         /mE/7lI1FbUi1+dnHPMfFQLrF+nHnpnQ7vzIvzTzDUmmi2T0grzv4NjN+CQiwUYwzK2q
         WLOBurlLOU6lxllSnGAjUr5N1OSnwfDSMlaP82/ta1VfVTN2mEiq5HHkPOjaFONwtlL1
         JOCTbe1qkNxcr/fTKuVFpvoGUsLGG/wDMC5w/SvMAZT7pH2rI3lNXTNxGW/pFD7A49UR
         y9kw==
X-Forwarded-Encrypted: i=1; AJvYcCX0d0ttkKtnMXQQHYQXZwApHorLnu249NUfnQypntipTC9CN7jPwvQ/KQmS0bpqVc0k2eEenWDrD2SlDdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9HfziwbcAulCFyefZhYr+f4MwamD0ZAtdFCPe/2cStC/V2Ek
	wE0ysNHSIhc53luhyqaXrMAr7NhLeaeTiTWlaeNQIUf2qtIP3rEyQdtwrg/ciJ8=
X-Google-Smtp-Source: AGHT+IGw6RFLC5cQuNUBq9p3JVA7HOeaQFT0Z1elg/9n8uPf+vXVvoyeGNVXBlPDsVt37nm9QXKdvw==
X-Received: by 2002:a25:ab62:0:b0:e13:c81b:184d with SMTP id 3f1490d57ef6-e1776537d2bmr12632704276.15.1724682387917;
        Mon, 26 Aug 2024 07:26:27 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4b3cafsm2002157276.28.2024.08.26.07.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:26:27 -0700 (PDT)
Message-ID: <8a15a46a-2744-4474-8add-7f6fb35552b3@digitalocean.com>
Date: Mon, 26 Aug 2024 09:26:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
To: Dragos Tatulea <dtatulea@nvidia.com>, eli@mellanox.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
 sashal@kernel.org, yuehaibing@huawei.com, steven.sistare@oracle.com
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Dragos,

On 8/26/24 4:06 AM, Dragos Tatulea wrote:
>
> On 23.08.24 18:54, Carlos Bilbao wrote:
>> Hello,
>>
>> I'm debugging my vDPA setup, and when using ioctl to retrieve the
>> configuration, I noticed that it's running in half duplex mode:
>>
>> Configuration data (24 bytes):
>>   MAC address: (Mac address)
>>   Status: 0x0001
>>   Max virtqueue pairs: 8
>>   MTU: 1500
>>   Speed: 0 Mb
>>   Duplex: Half Duplex
>>   RSS max key size: 0
>>   RSS max indirection table length: 0
>>   Supported hash types: 0x00000000
>>
>> I believe this might be contributing to the underperformance of vDPA.
> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SPEED_DUPLEX
> feature which reports speed and duplex. You can check the state on the
> PF.


According to ethtool, all my devices are running at full duplex. I assume I
can disregard this configuration output from the module then.


>
>> While looking into how to change this option for Mellanox, I read the following
>> kernel code in mlx5_vnet.c:
>>
>> static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>                  unsigned int len)
>> {
>>     /* not supported */
>> }
>>
>> I was wondering why this is the case.
> TBH, I don't know why it was not added. But in general, the control VQ is the
> better way as it's dynamic.
>
>> Is there another way for me to change
>> these configuration settings?
>>
> The configuration is done using control VQ for most things (MTU, MAC, VQs,
> etc). Make sure that you have the CTRL_VQ feature set (should be on by
> default). It should appear in `vdpa mgmtdev show` and `vdpa dev config
> show`.


I see that CTRL_VQ is indeed enabled. Is there any documentation on how to
use the control VQ to get/set vDPA configuration values?


>
> Thanks,
> Dragos


Thank you!
Carlos



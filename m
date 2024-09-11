Return-Path: <linux-kernel+bounces-325376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310C9758D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDFABB26FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5C1B142E;
	Wed, 11 Sep 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="AdYjW2vZ"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A90383B1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073749; cv=none; b=fe7wc1nzpqoBIIz6BSI98Q8cKu1gRVQURSoRp5gc7A2UNAGfhGVgNf4YGseEhKnwrkYH4i2MjRo2wuWrYBt9xAsUtCitW2tQGYwi9qUCmdwio480RHeW7vnKq1tA3QM3qSQRBy3TRKCmg+i7hwV7cC7BEACUiakqDOhg8BQCKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073749; c=relaxed/simple;
	bh=upjVQvBHFLKvH6/nR76ihRbNNYVq/nTkGK5Go2fEf0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruZ0Kk5Wqmemjik1PFgiuyelODwl9hHL0Q7j4ytQJyEhmyxV0CddGMVxY8QGnOFXj+mBRnHHoOX5G90IBk7p3FhjtDgPtHyK14/UXzMktJ26JjL44mPeCbxF2TL/sDDrxN2uWEspgiZlU/kQbPsM5p2LC3BAOfIumNuptGQBMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=AdYjW2vZ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e049185cfeso10225b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1726073747; x=1726678547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71kMJfnqMi6GcSxoRHCfWVH1SbLPDeS4BbpEwTiguGY=;
        b=AdYjW2vZWCf0pqhB7xAp3uoYYDpp0QQvnJbgrXRTmrNy71FrMrrCl0KgBEO35gyqyr
         jY1+MNRolYjNF1lt96oNMLbuOGH+jc5PXgZqAFc1kDiXzTMP3dCw4rTTrdLlJi52wGBL
         6evfGwVeA5TVlrtPGykCBKLYNURAt6oPAQ0Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726073747; x=1726678547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71kMJfnqMi6GcSxoRHCfWVH1SbLPDeS4BbpEwTiguGY=;
        b=Z4xTTkRHHEs2yae/PnRUBmN8OP5dbWtMn+xp2UIATWS0jazdhfBy25wlp9b3iaUnPS
         S47YF9nAAiYCLRgwir0KsfqJPeHVkjicAC7JKy0RXzK+5Vy/p1EdZWb+BeGl+ZkPSdc9
         sXYHRSWCp0JG/kAVZMmtJFXbZp3/EA7vSL2GWZ5q35lrkfu7GmkWagMsyGxdII/tC8bF
         epCfd5Shi4Iqzwz7BPUi0UrIq7v8dn8HyDw20/8EgY/6WGwIbDajJyLd7KNERVUBXqFk
         YLotT3oWOU7MirmBsBBGu5Or3MoTXEkzFIP5i2USzs66wu0K473arkzOyy4FFlNocq6u
         lcFA==
X-Forwarded-Encrypted: i=1; AJvYcCWQXYoWTRnEclaxbaoKOzCYOlaAeyh0+9w3AR+feUfOL51cUxocFuFtRjRGJmcJedPZgN611OPx6ZKkgPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4hl9ni5146DDfawz9hog0bC61YlVCS/MjKEwnBNiFsxXeUxZ
	e1lgpqFIgolUb8XzNzTge6DLIPM/BpnpkL7EzooxFcx5GzhwgdVWmMETLljZLao=
X-Google-Smtp-Source: AGHT+IGbyMLLP31vLuaB4sqWmb1kSxOxuK7mSa0lgQKxNiArEKoQm8OVlmJBkqsDSeFjMCa3+PJTAQ==
X-Received: by 2002:a05:6830:270e:b0:711:3ed:88d0 with SMTP id 46e09a7af769-7110957144emr157996a34.30.1726073746602;
        Wed, 11 Sep 2024 09:55:46 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:9198:79cc:8e64:e479? ([2603:8080:7400:36da:9198:79cc:8e64:e479])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9d5deb5sm2351506a34.38.2024.09.11.09.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:55:46 -0700 (PDT)
Message-ID: <4f6db868-d1e8-42b5-92ad-ae22331f5bd1@digitalocean.com>
Date: Wed, 11 Sep 2024 11:55:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA
 config updates
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com,
 shannon.nelson@amd.com, sashal@kernel.org, alvaro.karsz@solid-run.com,
 christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com, bilbao@vt.edu,
 xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com, eperezma@redhat.com,
 cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240910022843-mutt-send-email-mst@kernel.org>
 <CACGkMEscQWywn67yN7fAaRdWkOZV80RryCvyf_02RDWjrKZMwA@mail.gmail.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <CACGkMEscQWywn67yN7fAaRdWkOZV80RryCvyf_02RDWjrKZMwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 9/10/24 10:42 PM, Jason Wang wrote:
> On Tue, Sep 10, 2024 at 2:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Wed, Sep 04, 2024 at 10:11:13AM -0500, Carlos Bilbao wrote:
>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>
>>> Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
>>> vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remove
>>> ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supported;
>>> see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
>>>
>>> Carlos:
>>>   vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
>>>   vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
>> This will need a rebase. Will apply once you post one.
>> Thanks!
> Note that I think patch 2 is probably not right as we indeed allow
> config write for some device.


I'll rebase patch 1 and drop patch 2.


>
> Thanks
>

Thanks, Carlos



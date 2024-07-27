Return-Path: <linux-kernel+bounces-264246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB2B93E0BA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38EC281F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974C186E54;
	Sat, 27 Jul 2024 19:36:19 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D2376F5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722108978; cv=none; b=bUN5icui0JW2sbQloZ/73J6nWzvnYppzAHEaiO9t0fzd3moDViFu8+pnjH7QcHF1+Wh5DilrDkQi2BdgLiSdABl92m914CbnTqGSyFB3Wamrwb+7pB61zrjASPFchWUNdzoAn+UmZ833MtMYBdEDVIzANlVv++QDDJwWOQEkWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722108978; c=relaxed/simple;
	bh=DlMdTsmUFokqx/Eb09JUvpNkJPryOUF+V7nVexJI/YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyvDukIsAuLuHBfwaDc56Bafq5Inlg0EDkCYgHLoSBgvArnLGs3JfaAXazdHTtG3r9/I4lu3pobzj3zfeddKq4ArN55o9orNia+3Z6eRjQ8iQuDuKthfY4BP4CoyiiBzS1hVibI5fd1smhBaiY5rrXi7giBD8D+hdKPJlPXq2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36874fa319cso75241f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 12:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722108975; x=1722713775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlMdTsmUFokqx/Eb09JUvpNkJPryOUF+V7nVexJI/YA=;
        b=CXa1NlBF5J9UxWyXYLBlEgSEHDqfCbckSNyFiO3no+8xgMi4iOQ+4CeJxvPaxYnz78
         KN304MVY3GKCJyylAuTSGa+OuMqej9C0POfV/JMO/XxFyrjCtP/VbBh+fVe+KziPSkVL
         HhBH4g52YmcX6ZCbJsNb8APydr1bE829bcRiCXiX+O9MfVmqAHpq+jnxtLGwaXdWpEEH
         VLLew/9ooasVgzyuY0GYuwUNIvT7eI7tcyh3FJDOMmI9nDKJ5svRiw/KXS+deZcwAdUJ
         C/XO17uXh1Aie2u6IkR4fYUa+Y7k/QwHaPBd40fEAFkjEpL+tiNsiVhm6MxnjzEF06lX
         9StA==
X-Forwarded-Encrypted: i=1; AJvYcCV2juTgVbiFu2VGFwdX5DtN6MAZYk9HaKfVaDoLD4A4qbVFVl8Ouyt0/7gLeU5mrwOLY1AGDs2ykBSwbMqO/WxgvhqrM+nt4ZF9XKBQ
X-Gm-Message-State: AOJu0Yxd2Oh92KTlwheH1Gdyh4lcaTbUYXjXmYsrsVxVzoV6zz1C6USG
	FSS5+UHVEjhKeu+UI7iP1r6oxuMAxpQzXyL8bRTaDNpCNvGZuJHb
X-Google-Smtp-Source: AGHT+IFSxo0NeI4SAM2zvcQLJljvk9476RSvfduNYJLjNUHAzz8CxVLDNaymo6Jb2pnYEb9C+0RwKw==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr42902505e9.0.1722108975225;
        Sat, 27 Jul 2024 12:36:15 -0700 (PDT)
Received: from [10.100.102.74] (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427fb7bdfa0sm153589165e9.14.2024.07.27.12.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 12:36:14 -0700 (PDT)
Message-ID: <b3592bca-015f-451e-b689-8db820cbc7a6@grimberg.me>
Date: Sat, 27 Jul 2024 22:36:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de
Cc: ping.gan@dell.com, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <196a9f11-ba97-4c9c-9815-0ddd0cb50808@grimberg.me>
 <20240726023407.70799-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240726023407.70799-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 26/07/2024 5:34, Ping Gan wrote:
>> On 19/07/2024 12:19, Ping Gan wrote:
>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>> TCP use bounded workqueue to handle IO, but when there is other high
>>> workload on the system(eg: kubernetes), the competition between the
>>> bounded kworker and other workload is very radical. To decrease the
>>> resource race of OS among them, this patchset will switch to
>>> unbounded
>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>> get some performance improvement. And this patchset bases on previous
>>> discussion from below session.
>>>
>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>> Hold your horses.
>>
>> This cannot be just switched without a thorough testing and actual
>> justification/proof of
>> a benefit beyond just a narrow use-case brought initially by Ping Gan.
>>
>> If the ask is to universally use an unbound workqueue, please provide
>> detailed
>> benchmarking convincing us that this makes sense.
> So you think we should not do a radical change for the narrow usecase
> but
> keep the parameter to enable it in previous version patch, right?

What I'm saying is that if you want to change the default, please provide
justification in the form of benchmarks that support the change. This
benchmarks should include both throughput, iops and latency measurements
and without the cpu-set constraints you presented originally.


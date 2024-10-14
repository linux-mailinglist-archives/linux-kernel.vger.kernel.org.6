Return-Path: <linux-kernel+bounces-364629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF699D730
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645C32837E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4F21CB53A;
	Mon, 14 Oct 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXwDyZa0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F111C3035
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933483; cv=none; b=ZDKvRqGnsrobrTuWVExvC6moJ9/oNatOMg2ZTtkK6dbNZxFZY3GKXITc8oMxq8wIBHNT4KiwUwZijkKrpeKXdctuW6sxlnAQge56sJ1E4Pdb1KVswPpIWuxxMWAqKsHJtzI7bMWbSPlj0Yxix25FGzbw3Mwe4AwSWcFe0GLgb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933483; c=relaxed/simple;
	bh=P1unHhBStk4RRcFI3dRYNMe+aV+Q3cE7EjiTMg2bVDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvMgswlslfjpv1pmTpS4h/lorOM82kARoGfeeLilYQ/2L2af/MnvqCihpLMHYOS1+L7rzBsVCzd6y58WvxzRMr4UwbN5PHqbUskZdpLCrJOxFWnCVs8zJ8wj7NOHP6au1OIGlPKy2fnVT5pbY7Lo7nQ9zWF04M6HVb/LM+L4J3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXwDyZa0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728933480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zF47rTw5gKSqUML4iQcgfNgbusXB9cJHVaZjLwRrtaQ=;
	b=RXwDyZa0QeURy6m0K1w8+ZiKpcbJpBGNmUT1ELbllvHrT9dK3IJXfAZoWxDZEVN0B0cLap
	6udDCSaXnU8BcknQ7hWZlQcLaz8Qs40cupoS3FaDF6LOhPr/d2Z2q/zs1T5vrYrUomZflL
	3tvWRB2PLT9JB/Gi+mKZ8VKR1V2gzBQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-qUrqDCaiN5-IL87ikwB0iA-1; Mon, 14 Oct 2024 15:17:59 -0400
X-MC-Unique: qUrqDCaiN5-IL87ikwB0iA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43111c47d0bso23938855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933478; x=1729538278;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF47rTw5gKSqUML4iQcgfNgbusXB9cJHVaZjLwRrtaQ=;
        b=cENKlAfwIUOxvTu34/F6nAs5rsHI9lRELHtZsPSA4AAUr+Wy4PssqzigX9XvPQkR2k
         ZknRmo04beWmGvW6+W1FDtwIQoC2TSZm8r86dkyQHs7yHQgNXolRv0uI3UZDXoD0wd0Y
         KfWp04sF03yGSZkXpY4V8Chma3gdJZybeVx0cw31KIaYoXj19NdFbWIRjYLXiq9FrYEw
         JkmM9P5hMocvgRSZPJ6P6Jlrn3BkSXApqsnHUpLnadqS4hkxitwy0m9AykF6GES1szsY
         1qm1Af6ge330CJGmiJsFfuDgkNf6+gRYxlWA4kB5whlVZALmTICHxW3DqdLic6oDaGyi
         RkgA==
X-Gm-Message-State: AOJu0YwKNVVHE0VVQaXjr1pK/otARDzxfj/3ByLt1hYtvCndR7yaoNMW
	GbxXA0oebdZZxKuQkrNXkB1Y8LUXPoGcCEFcmhxL26tgTM7MEJSnYfJJG/0a5lZpdQWkXcnWgzi
	gLm58rjwhKlxMYhEZBP+OUyYNPk8R5EcOoQkdUjeg5tLRnfv9m8E2CvG6wco/oA==
X-Received: by 2002:a05:600c:5129:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-4311ded5170mr103650725e9.10.1728933478493;
        Mon, 14 Oct 2024 12:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOPrVjVtDpiI7kuxpfNHU/NZDKpMRlCTo/lMm+NEGQtHVKVZOZ0hTh3r3DYjD+mjcUDqCOlQ==
X-Received: by 2002:a05:600c:5129:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-4311ded5170mr103650575e9.10.1728933478030;
        Mon, 14 Oct 2024 12:17:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:600:9fbb:f0bf:d958:5c70? (p200300cbc71e06009fbbf0bfd9585c70.dip0.t-ipconnect.de. [2003:cb:c71e:600:9fbb:f0bf:d958:5c70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748dd50sm162401745e9.47.2024.10.14.12.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 12:17:57 -0700 (PDT)
Message-ID: <f13c8c11-6fa3-480a-8035-6beb965fd01f@redhat.com>
Date: Mon, 14 Oct 2024 21:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] virtio-mem: s390 support
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20241014144622.876731-1-david@redhat.com>
 <20241014185659.10447-H-hca@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241014185659.10447-H-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 20:56, Heiko Carstens wrote:
> On Mon, Oct 14, 2024 at 04:46:12PM +0200, David Hildenbrand wrote:
>> Let's finally add s390 support for virtio-mem; my last RFC was sent
>> 4 years ago, and a lot changed in the meantime.
>>
>> The latest QEMU series is available at [1], which contains some more
>> details and a usage example on s390 (last patch).
>>
>> There is not too much in here: The biggest part is querying a new diag(500)
>> STORAGE_LIMIT hypercall to obtain the proper "max_physmem_end".
>>
>> The last two patches are not strictly required but certainly nice-to-have.
>>
>> Note that -- in contrast to standby memory -- virtio-mem memory must be
>> configured to be automatically onlined as soon as hotplugged. The easiest
>> approach is using the "memhp_default_state=" kernel parameter or by using
>> proper udev rules. More details can be found at [2].
>>
>> I have reviving+upstreaming a systemd service to handle configuring
>> that on my todo list, but for some reason I keep getting distracted ...
>>
>> I tested various things, including:
>>   * Various memory hotplug/hotunplug combinations
>>   * Device hotplug/hotunplug
>>   * /proc/iomem output
>>   * reboot
>>   * kexec
>>   * kdump: make sure we don't hotplug memory
>>
>> One remaining work item is kdump support for virtio-mem memory. This will
>> be sent out separately once initial support landed.
> 
> Besides the open kdump question, which I think is quite important, how
> is this supposed to go upstream?

MST suggested via the s390 tree in v1.

> 
> This could go via s390, however in any case this needs reviews and/or
> Acks from kvm folks.

Yes, hoping there will be some review (there was some on the QEMU series).

-- 
Cheers,

David / dhildenb



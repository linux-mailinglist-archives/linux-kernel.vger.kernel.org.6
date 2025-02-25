Return-Path: <linux-kernel+bounces-531574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EAA4423C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDBC19C40C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0826AAA7;
	Tue, 25 Feb 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J55+h/Ob"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA026A0AB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492681; cv=none; b=dTGf5r2wbet7He2X+MBHEfsWLDsZECxw4Wx1BRdxJwDkSwrMj20x+JQDlRBWj732Wi/Iv1Zts0JqHCfRRbvKUPQSbHfWdOLIf2bpVNLHCQ9vLpnJh04LA2u1TIqAKNrWXzcp3+zfG4tyWNSjhAEbUVGuwHoFLN1dm/yrOXu8wlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492681; c=relaxed/simple;
	bh=JYAuHpQN0jdohteR+QOb1gdS2Iz8AWrwTZWX0+tVOa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaIu9FMiPATD+2tMlA+0Cd1D4+VVoaxNbUmqDvnnGngAVLjmODfN+Y+Mhqw4WHNe8kA82aC/5YhHB/YF6AbwIezw/yoMtFVoF+6QLbfDNVK/+sQgAlWq8eqmLrgpgozsRy9/98+UAK1y1hh9VQWQPqQoZVmcnEJpidK8ScLpmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J55+h/Ob; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740492678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ij9laTgkz4RR9Ifclr6dZ8YPlK5TkYLDkN0fKJZO94=;
	b=J55+h/Ob8DVPvCqeQM8GkXlbHmS7DKZUuiDn+7ER6n9x+eEcoZS57C32N6x5lAvY126TPy
	rnKugXoNGDmMU4/EvXJH/b8/tqnJONbKc7Dftp6pBJKoCZ+AXH1tu+QWc2eqYDE61IkQIW
	rlLU8BLkihcLfGGm0X0gUoWIdFt3l1M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-VzfJfe-ZNTmdf9pgPiAifA-1; Tue, 25 Feb 2025 09:11:16 -0500
X-MC-Unique: VzfJfe-ZNTmdf9pgPiAifA-1
X-Mimecast-MFC-AGG-ID: VzfJfe-ZNTmdf9pgPiAifA_1740492673
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f455a8fcaso4160614f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740492672; x=1741097472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ij9laTgkz4RR9Ifclr6dZ8YPlK5TkYLDkN0fKJZO94=;
        b=RB4rx9b7LqTSV/4mnHBXs4XPWwn4RuamXRIhEt3P/xsdZVMm/5zrOkQ8b18ur8ESww
         cn899v7G2wuH+2D0xAm+xn6tkjewbsZLyMEfVnpuvrVIFWZ9OnuRclSCwHPpxDRxm9kV
         jXSswjps8c5jOhdASiWa0gd1YP8nJ3jAwM/7+qddvqERKpp6x+jc4sgHql7sfzTS6fpV
         3eARGfOrxCtRbc7q6CZ813gyWrGzDJ7n7blOiuNKnqbxEcP601JdZeQ76wkNGyMb/WrS
         IwCJvs51Q8HnJ8ZrnPKUaDYQZYwOBvcWd89Fxwl0COFffAjjBqPn55bSRys9kEd4BM1P
         M/Ag==
X-Gm-Message-State: AOJu0Yz+W/m1ksVMu+bjMQZYmBPoS+KN3XZ0D/a7WMyIVymcwhLq+yS9
	HEWrtqaGzY5ehPRBvMuJpFTnBnt2b5DMRtSaPFndAv1MnoRZ/Tj/X+JZqA/PXDCmWMnc5viUG74
	vGvGxrjqAwWB9BJyvajGP9oNr/MYx6uWULijpahssWNfwaWGNJoqx9pW/Bf2QZg==
X-Gm-Gg: ASbGncsw9jieWOKYl/USOjTaqTLzcvND5z9gWLB+kA/xCmNLog3Cevtc82sM8QCNfyq
	Uqieg1dLghs/CTJPEaffKh2ch4v9FU4G/81cAUOz3JGprv+yBOGTqi62307b05mj54cCGSYSbqY
	VIeTK2cOBa/KYhF+04Ib7TeiH9DpQ6kqGNTAURClQ0FlENdki5y3dHVb/qLrwYSOwkoqNl9lYku
	FPCBDAUnXRez3hir5ln9S2W4PPSTi5wOXuBpNp51DAJ7UdYXWvKTRbJRVKcXQgxNx9ebnpY7/3H
	rF+uzn1XAeT/7A/q/HkFAMroSXkrMEEOl1RsZuSVYt5zCkBqdj7sSdkUKg==
X-Received: by 2002:a05:6000:1562:b0:38f:3141:8912 with SMTP id ffacd0b85a97d-38f6e97c6dbmr12267572f8f.24.1740492672637;
        Tue, 25 Feb 2025 06:11:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz/Lj6mGhXgLbS6Jsu6dZh4afgO/E6Y/RudVLGc6PVHt5IzT0vO+YZHzS+pfkAxXQ+Rn+aBQ==
X-Received: by 2002:a05:6000:1562:b0:38f:3141:8912 with SMTP id ffacd0b85a97d-38f6e97c6dbmr12267549f8f.24.1740492672268;
        Tue, 25 Feb 2025 06:11:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab3741596sm15188585e9.1.2025.02.25.06.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 06:11:11 -0800 (PST)
Message-ID: <95e730a2-9670-44d6-bf4f-1b09697e5e31@redhat.com>
Date: Tue, 25 Feb 2025 15:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: break and reset virtio devices on
 device_shutdown()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
 <7fa37894-7d73-4087-a849-2957f31ad7f4@redhat.com>
 <20250224143029-mutt-send-email-mst@kernel.org>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250224143029-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Michael,

On 2/24/25 8:31 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 24, 2025 at 08:49:09AM +0100, Eric Auger wrote:
>> Hi Michael,
>>
>> On 2/21/25 12:42 AM, Michael S. Tsirkin wrote:
>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>> accesses during the hang.
>>>
>>> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
>>> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
>>> 	...
>>>
>>> It was traced down to virtio-console. Kexec works fine if virtio-console
>>> is not in use.
>>>
>>> The issue is that virtio-console continues to write to the MMIO even after
>>> underlying virtio-pci device is reset.
>>>
>>> Additionally, Eric noticed that IOMMUs are reset before devices, if
>>> devices are not reset on shutdown they continue to poke at guest memory
>>> and get errors from the IOMMU. Some devices get wedged then.
>>>
>>> The problem can be solved by breaking all virtio devices on virtio
>>> bus shutdown, then resetting them.
>>>
>>> Reported-by: Eric Auger <eauger@redhat.com>
>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>
>> Thanks!
>>
>> Eric
>>> ---
>>>  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
>>>  1 file changed, 31 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>> index c1cc1157b380..e5b29520d3b2 100644
>>> --- a/drivers/virtio/virtio.c
>>> +++ b/drivers/virtio/virtio.c
>>> @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
>>>  	of_node_put(dev->dev.of_node);
>>>  }
>>>  
>>> +static void virtio_dev_shutdown(struct device *_d)
>>> +{
>>> +	struct virtio_device *dev = dev_to_virtio(_d);
>>> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>> +
>>> +	/*
>>> +	 * Stop accesses to or from the device.
>>> +	 * We only need to do it if there's a driver - no accesses otherwise.
>>> +	 */
>>> +	if (!drv)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * Some devices get wedged if you kick them after they are
>>> +	 * reset. Mark all vqs as broken to make sure we don't.
>>> +	 */
>>> +	virtio_break_device(dev);
>>> +	/*
>>> +	 * The below virtio_synchronize_cbs() guarantees that any interrupt
>>> +	 * for this line arriving after virtio_synchronize_vqs() has completed
>>> +	 * is guaranteed to see vq->broken as true.
>>> +	 */
>>> +	virtio_synchronize_cbs(dev);
>>> +	/*
>>> +	 * As IOMMUs are reset on shutdown, this will block device access to memory.
>>> +	 * Some devices get wedged if this happens, so reset to make sure it does not.
>>> +	 */
> 
> Eric,
> Could you pls drop the below line (reset), and retest?
> I want to make sure the above comment is right.
> Thanks!
If I removed the line below, I hit the issue again:

qemu-system-aarch64: virtio: zero sized buffers are not allowed

So to me this is needed and the comment is right.

Eric
> 
>>> +	dev->config->reset(dev);
> 
> 
>>> +}
>>> +
>>>  static const struct bus_type virtio_bus = {
>>>  	.name  = "virtio",
>>>  	.match = virtio_dev_match,
>>> @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus = {
>>>  	.uevent = virtio_uevent,
>>>  	.probe = virtio_dev_probe,
>>>  	.remove = virtio_dev_remove,
>>> +	.shutdown = virtio_dev_shutdown,
>>>  };
>>>  
>>>  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
> 



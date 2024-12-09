Return-Path: <linux-kernel+bounces-438123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E99E9D21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C1A166A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E228014F9E2;
	Mon,  9 Dec 2024 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEad8kKh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2313775E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765668; cv=none; b=BNHCSLG0i1P8c/h769UaQy8lrWbu91QL8P2vmdln8GHxp4cOAapQtluBC96sdDH4NTHOVjRTMDMThZpTaRnIMdBEE7oQpj3LgjBw3GQZ1bSWsOsZB5BSxa+SpzG9dKBGAyOJ3UHW056tmIYTjJKEVg+x09nBGRp4xbH1KAKN190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765668; c=relaxed/simple;
	bh=R0FchNnBYl842lKbEf/g93OkUFEVzVvzwd2kpfYXaOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q55G64l+vr3VDZ/ZOSxFs2Wb0O+pJ8BMAoRwBTLURbb6hGZFgHGgA7AXhJoTYDsyOcSmr2fHED8tQir/i6Q1Ox8fSQhmcgli+VxxATl8ksLpmm/qvLNj9hu44UeSlw20/hmIOxqGjPFvCsKU8b7YhPcuvrHIX1+B+DaRIByHm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEad8kKh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733765665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvLYzgf0pTuOcyou9vYjqExC5QJxwloVljjSc64vKaI=;
	b=HEad8kKhP45GQoMjYC8N12CZayqeJ44wyUBx+mi8ML5T1FhAUUiCQIsf+KNG5AxtluMxTx
	49Nqnya4IP/0uNfDKjxA0J//4UybkRugQLrKvVHGcrkcFu6Dq2ud3pVTtZ07h9sH+sSCzj
	PX+boTrsxKSQNhBApZaH2QrCkfc3F50=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-urt9Bt5zMUqG3xBqtIjueg-1; Mon, 09 Dec 2024 12:34:24 -0500
X-MC-Unique: urt9Bt5zMUqG3xBqtIjueg-1
X-Mimecast-MFC-AGG-ID: urt9Bt5zMUqG3xBqtIjueg
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d88ccf14aeso73833926d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733765664; x=1734370464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvLYzgf0pTuOcyou9vYjqExC5QJxwloVljjSc64vKaI=;
        b=FWANgJZ5Da4O3bb4zC3N72xuJzTpJkHT3yoEiu+CyknupgM3CDBXJnsXR7pjHATOfo
         eA4Ugryby0mwOj/00qLzRB5F0MAmTnJs6Lg2DISTEnihM6pIY5mH4ekGWD/EwsZthbHO
         sea++c1DtUnDsz8ydbPrioxbqEeGrzOSkwb6fZEwFUYdFg6ynXhtVjaNhk22uzLmn/5n
         Ml9/1G3tSLOeIUvihzsODDvHpAEPDH1MBpsAN1KsS4xnX+UBddt9OkUymezHD3FiDGbA
         uC/Yqqt3HBiSEwSNaRoPEe/xJvlf6SvmrT1ZJoNbmcB761qw55VM3v1OKM4E3DFPAPkO
         h1cg==
X-Forwarded-Encrypted: i=1; AJvYcCX36ffEzJ/Q5UzNohh7+CJ7IM6MkRxJSu9oPrhYKBlYfE/18kXKymVrKjLqmPUoIw9MpxlyVzhiOesZn8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIyf4TINmCyzS1zFEh6a3uJvxT5TshULVLvXs/unh51wD1ZZ9
	QYLBeNKzvjHeS/31RJGK/4VZg25waCb9NOULSVlt5IRnGlyOLsOhIHhlrFTOLLa0YZ8/vMaE9Sa
	EXH6WeXdpY0INgi9mvC+vnSwEFgATSq77p/C0YjYf9v9NxA8pLM9LG6bIuvw+xA==
X-Gm-Gg: ASbGnctPP+CZmGdYcQpEHJY+splxqUx7no3kSq7ko0JUF5d13aA4DdehKMIFb7lcn/S
	5Iob+0IAOHvO8qV7uvQAYsTqpOovlX8jzTsbUIqh5lV3As6b4kZowVt6FG55DAicvjTJMqllj2i
	Q3rE3Kl2lDdUMkglUCTEjwEWSSb3nzjZBh2tm5LDiL1AlEg1itFCHD4b0UMa9OnzPRqIiqM+Bne
	81+oOV+BdrAmUMMmyr957HvHFDYhVZUxWmzlovkyCjqAgZVGiMIMeaXxoYPAk2BQ3dbDTM8lIXe
	1ndKaXL4bEPpZred
X-Received: by 2002:a05:6214:ac2:b0:6d8:8416:9c54 with SMTP id 6a1803df08f44-6d8e713a182mr276969576d6.16.1733765664138;
        Mon, 09 Dec 2024 09:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd0kpLM7VmFD3YLvHdqJXtgD3B//SGNjV7e+l6mN4D7B+QpL0ybvqRUy8gR/dnnBJyTZwPLg==
X-Received: by 2002:a05:6214:ac2:b0:6d8:8416:9c54 with SMTP id 6a1803df08f44-6d8e713a182mr276969056d6.16.1733765663835;
        Mon, 09 Dec 2024 09:34:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d9063fc63bsm20690816d6.103.2024.12.09.09.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 09:34:23 -0800 (PST)
Message-ID: <4d443db1-85b1-4071-acd5-3187deb9cb17@redhat.com>
Date: Mon, 9 Dec 2024 18:34:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: nv: Set ISTATUS for emulated timers, If timer
 expired
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 kvmarm <kvmarm@lists.linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, oliver.upton@linux.dev,
 christoffer.dall@arm.com, suzuki.poulose@arm.com, will@kernel.org,
 catalin.marinas@arm.com, coltonlewis@google.com, joey.gouly@arm.com,
 yuzenghui@huawei.com, darren@os.amperecomputing.com,
 vishnu@os.amperecomputing.com
References: <20241209053201.339939-1-gankulkarni@os.amperecomputing.com>
 <867c89tc4q.wl-maz@kernel.org>
 <c5b1c3d7-56ca-4afc-a831-045dba4beffa@os.amperecomputing.com>
 <865xntt2kv.wl-maz@kernel.org>
 <8be59ff3-6a68-48e1-8181-0ce4b2e7180f@os.amperecomputing.com>
 <bcb4289b-507c-4ea1-afc7-6febd34d88db@redhat.com>
 <86y10osr19.wl-maz@kernel.org>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <86y10osr19.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Marc,

On 12/9/24 18:30, Marc Zyngier wrote:
> On Mon, 09 Dec 2024 16:46:30 +0000,
> Eric Auger <eauger@redhat.com> wrote:
>>
>> Hi,
>>
>> On 12/9/24 16:39, Ganapatrao Kulkarni wrote:
>>>
>>>
>>> On 09-12-2024 06:50 pm, Marc Zyngier wrote:
>>>> On Mon, 09 Dec 2024 12:25:34 +0000,
>>>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>>>>>
>>>>>>> During automated testing of Nested Virtualization using avocado-vt,
>>>>>>
>>>>>> Which is not merged upstream. So what branch are you using? Based on
>>>>>> what kernel version? On what HW? With which virtualisation features?
>>>>>>
>>>>>
>>>>> Testing is done on Ampere's AmpereOne platform using 6.10 based kernel
>>>>> with NV patches from your repo.
>>>>
>>>> Grmbl... *Which* patches? At least give me the SHA1 of the branch,
>>>> because I have no idea what you are running. And 6.10 is definitely
>>>> not something I care about. If you're using the NV patches, the
>>>> *minimum* you should run is 6.13-rc1, because that's what the current
>>>> code is based on.
>>>>
>>>
>>> I tried 6.13-rc1 based nv-next branch today, which failed to boot
>>> UEFI as L1. Yet to debug this.
>>
>> I confirm am stuck with the same issue with nv-next on AmpereOne.
> 
> All I can say is that it Works For Me (TM) on M2 and Snapdragon, using
> kvmtool, a fresh EDK2 built by Ard, and with the guest running purely
> VHE (FEAT_E2H0 not implemented).
> 
> I haven't tried QEMU, I don't have an AmpereOne. I have also spent way
> too much time on this recently. So I'm afraid people interested in
> making this particular combination work will have to debug it.

yes I do agree. I am currently setting up kvmtool to double check and I
will debug the qemu issue.

Thanks

Eric
> 
> 	M.
> 



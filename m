Return-Path: <linux-kernel+bounces-518158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C80A38AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C28D27A3A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD51922A4D9;
	Mon, 17 Feb 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8BnJP54"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F222A1ED;
	Mon, 17 Feb 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813868; cv=none; b=S/lPGswMlsuB3YA+zxFQUVXt6Ed/t368+VSxkkJM+yQHTYJ8RgeoMf6haRBRz/YcvWVZU4MP/+gB2FyvcQLRmpaUbS4bnstCrc4L+B3LkKeIU9BNnMY2TQVED3C3qI71aFtQQTursZ3O6eJQUHn1qpOQ9O9b5YKfnkHsw+Z8WGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813868; c=relaxed/simple;
	bh=8/L3gmfFAHfFA3roVYdsJEdGq7TwcZjgK8Y4cSwVPIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbt3R5McuKAlxUYDtRffxxLLlqt6yT7xzRT+3lm9npgSL8DHkgcGtfOBa5227fbiM0GCB2Rr3aNzTGxEyR4PJjLPqhwhhynExoKj0XikyAaxmJQrvByIC/Op5sjJFY7hRl4b3JpmlhVZSAG8ptuI1FEkbiAzGw2D/lrnVfyEOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8BnJP54; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5439e331cceso5492225e87.1;
        Mon, 17 Feb 2025 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739813865; x=1740418665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djXZZJISJ1TKosjoS1puXMdvOw7lbev+k0Hn9OFuMbs=;
        b=Q8BnJP54Vw3TADmfQ8ouUtMLWv4PNm1nS/+X005A3sLaZr9AW4X1vSpUbKMhKN4tjM
         0gyV6sa6KbwGMEjkDI2HD9IySdPFQoX3657hIK1Qs9jmBunQOmJrqrZYowStCsCiabjj
         nOr6p8GpHXaZ2yKGmscmTsmvQF6HyU8BG51okHTX6ok0MWasllxfn4+mrAzFoFeQ7bDj
         /s8lXx4f+Yz7BIEYO7dRU3yWmNrGwiXsv8PFK5nDAk1YbmgBNSJOteSoVeTT+zcIYGnK
         p5416RZae6LrJybHYwCLw7Wqal06yzZ8Us2ckWuz3T96BdOMzUtJdrtuVSrEEh+YiOXl
         eddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813865; x=1740418665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djXZZJISJ1TKosjoS1puXMdvOw7lbev+k0Hn9OFuMbs=;
        b=hkerii7QKg0QtQPxVTEnpBlvq1igdSOzEW6FXVUo+mII5yp0v+q4WQZVdjDX2otbcc
         b7kIsMBmgZ6qVpnnBnxdTQKYT6083u3y/ilPWjdem7svHql/QOHcSJBWzX9vQnZRheM8
         61ZugzmpA1EseTmwip5LNsgCn59m/3fKHM1PdIo72dXMxduflUiEVoXPqEyTTimJnQyy
         Xp1QVMSrBnmpneiAwyaTfitGd79WF9ge2Qf+m/9dZMHrCsfXyHgiHLme8PE/5rJxeD7P
         ehp5l2t2006QNPsxDURE+wdv5UbT7zwSVO2VZ1hFBZxDpX57wslPyYZThl3jgHqEcr7g
         7a7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuRg8NfyhnNuYVBkue9qei1sEei+GGx/tFRwkd31joBMm0hB+bE75c4wquFYiXb+vEDfF8zesSww5cq7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XRtSNNM9YXSZZvFO8SjpVfDL0Zb6Purv//6lsV6s6ClokOPJ
	ddoGmC5vL/NaSYjWmfYZKyx413Splh+Irau060NyjAXZzxlKIIW87TQpDg==
X-Gm-Gg: ASbGncvweXOki/W4EPxyrAh7KcvrqIs8w6UQUAqaDWpsQJWfnDGOla39029aT1wTV4x
	3TRW/tJKf/Y6U5ZYnIoKFskMxlWyR4kZG51kKRGRC/v6QZmNFrsqfmnrAYW13ySHQb7cY3AIusv
	UYr79tixi0uQbk9krp7hXJksaczB+5WpiZOeDIoNr+vPC5aVK+asuc0JjisePZNHOqVa0NzCGiV
	wzJmw/Dlk0s3J6pw80WfMJ/Zq6ybMRp94hoFhlZ+Mm2y+7J148Zkjg402PD11MOIudi6WuWctgg
	x0yneZKANsQYCJp6HgeeTzfSZZEdKYxJiiZB/Ozm+kpaAU54RaRBaDAHRy/3Cw==
X-Google-Smtp-Source: AGHT+IHahEhRB+xxQGpF1DyRBvIF1Rb5cbY8BrO1SPBJMBOL7KKWdBONU9dPd4DzVJZu0lRRxJ7BKQ==
X-Received: by 2002:a05:6512:1194:b0:545:a89:4dc7 with SMTP id 2adb3069b0e04-5452feab102mr3061810e87.52.1739813864297;
        Mon, 17 Feb 2025 09:37:44 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54527f929e7sm1341292e87.44.2025.02.17.09.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 09:37:43 -0800 (PST)
Message-ID: <ecf3752d-87ab-4b3b-8660-d827437b0ffb@gmail.com>
Date: Mon, 17 Feb 2025 19:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Robin Murphy <robin.murphy@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <633274AD-E55C-4A90-AB72-33D3E176176F@collabora.com>
 <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/02/2025 15:52, Robin Murphy wrote:
> On 15/02/2025 9:40 pm, Daniel Almeida wrote:
>> Hi Abdiel
>>
>> I noticed that there’s no API to call `dma_set_mask/ 
>> dma_set_coherent_mask`.
>>
>> This should probably be included, i.e.:
>>
>> ```
>> By default, the kernel assumes that your device can address 32-bits of 
>> DMA addressing.
>> For a 64-bit capable device, this needs to be increased, and for a 
>> device with limitations,
>> it needs to be decreased.
>> ```
> 
> Oh, good point (and I'm rather ashamed I missed that!)


Ok. Missed this part while working on the nova stub and hadn't had to 
use this interface yet, but yes will add this for the next revision.

> 
> FWIW we've been wanting to steer away from relying on the default mask 
> in new code, so it would be quite neat to actually enforce that 
> allocations fail if dma_coherent_mask hasn't been explicitly set 
> (assuming it's sufficiently cheap to keep a flag in the Device handle or 
> something like that - it's not the end of the world if it isn't practical).
> 
Thanks for the heads-up on what this interface is expected to look like!


Regards,
Abdiel



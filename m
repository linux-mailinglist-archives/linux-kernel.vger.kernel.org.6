Return-Path: <linux-kernel+bounces-390273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7781A9B77C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F44E1F238BA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41228197556;
	Thu, 31 Oct 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVzZ7VRk"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40014B092;
	Thu, 31 Oct 2024 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367945; cv=none; b=e85FhMLNck/iq/c1scYQHxFyJc/S5/7W45Je+0mHFKnMjkW+JmtwjVi6wl1DNYVFiPpJlxGlEfh+yY7GDQ+hE4fr+EIUpPz1t/IVnPwE07/RWOtnabhVjH3+eIpVyKZLtGc/qNCtAzXB8UkfZO3cMLqZGlxkcpozqkRxfucK8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367945; c=relaxed/simple;
	bh=YAkmRQzLJqOW/2apfBH6zTCbSZ4/Eqwa3wooJ7c3/Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOz0DkqFM4+Er0ifsAAqkA+gC0uKwzAstks23Hr4gdVPmsM+R4eeN/qIIujfF4LkPzIMQCxEfUEOXX93VMyWGkG9SFuOlgEFMN6igYn/EDMYbzyCQkPMIj4dTQRVtYazKkJpC7vRSskM11pEoZAfMe/VWSVFJRB4zJod3qJXbnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVzZ7VRk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f53973fdso659939e87.1;
        Thu, 31 Oct 2024 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730367942; x=1730972742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRe9uuw/pqh76xYDp+E0t5jOAa2J0YbwqHTQs24Iffw=;
        b=JVzZ7VRkjEQbZW+fCbsmVXi+Y7aFlcDSeESj1cmePizYoTVagOQNxhuQeD/GLqBPHb
         86Wq424hSr9hH/SexBUgd1LRWgASSHKj6X9IYq1BFcQzC0cyA7BIqaWCyHIJ/2Vn61/H
         8Oi/L6UlddvkLishuwQB5zhxqbbpbUsXPTzTUYBRRv33XR5BHxPWbj8PIgZw8E4lvS70
         DRZ8L1iV0gBH+oTVqDeBD+MEWWd8IcPgvnx91t12/LhGlo0MZNco1RDKQXrVW8cjQG34
         r23Zo1Es+aiJ9kn5bJb0rc1afFLNZPNE1aCgzvj5RJrKfSu26SDZBm27zOe9q7NmbNRf
         MhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367942; x=1730972742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRe9uuw/pqh76xYDp+E0t5jOAa2J0YbwqHTQs24Iffw=;
        b=QC5fcrDaH7RtMWkHrOKvfwtqbkaUaDq5kmRpHQ8dLLTICjhFiRl2giQD5ceL0MTpbw
         SBvavmdP87o1DqsEx6oc9j5rNZiHVX/1yofJwTg+714HPqM3vUdzb1ZeiTGhGx87YVJe
         jUkS2RwnKvaCCqmFzSPpjwN61X0fomWNHBUc/bLSj0FGailRD+1Iy96hA8sFXeDrdvGM
         10WpDB4VWqpjCh7k9/vwEd7ptx0qgNT2UNwMob8ENCgD8t62vkT73WpTBXsOPDWuWR+r
         LvBRQM1lSvRWhmoGiQP8ts0hZmR+h5fVttcyroyxAbmwTtjUwvQEIQDq8hvo6P0lsw1A
         KVHw==
X-Forwarded-Encrypted: i=1; AJvYcCU492GEXG9fymUL5nXBqZBOeBmFnu/oHfJ9VWBB7NVISXKLtDHUidULDuH8oXtEM99ztXxrHSdxAWdECE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMDwqOCbDT2Ev75jxDogK0VjcXOItElFFI0kV/sO+CBkEVZar
	lRGtFj+qDUV4y7MCw0LbpOtzElNLLChipR+zZMA1BeVi/5k6wHHj
X-Google-Smtp-Source: AGHT+IHxFoxWa0a9+KiC4ojbOt2pPiw0oeQgUHwkdIGttpDnhGkObEQqlxdPJfZEhervLOp8P+iWfg==
X-Received: by 2002:a05:6512:1289:b0:539:fe02:c1fe with SMTP id 2adb3069b0e04-53c7bbe0923mr546682e87.16.1730367941731;
        Thu, 31 Oct 2024 02:45:41 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde46c4sm142673e87.284.2024.10.31.02.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 02:45:41 -0700 (PDT)
Message-ID: <ee45ae5f-133d-4d38-bb4a-d3515790feb4@gmail.com>
Date: Thu, 31 Oct 2024 11:45:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, a.hindborg@kernel.org,
 linux-kernel@vger.kernel.org, dakr@redhat.com, airlied@redhat.com,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com,
 Andreas Hindborg <a.hindborg@samsung.com>
References: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
 <20241023113309.1724992-3-abdiel.janulgue@gmail.com>
 <6CF29D3D-C930-4274-9BAC-365C0F32DF56@collabora.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <6CF29D3D-C930-4274-9BAC-365C0F32DF56@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 28/10/2024 17:38, Daniel Almeida wrote:
> 
> This patch is not a v2, so was anybody against using a raw pointer at some time?

The original idea behind this was to improve a little bit from raw 
pointer manipulation when indexing the data. But yeah, for the proper v2 
I now reintroduced the raw pointer but dynamically created slice from it 
as you suggested below. :)

> 
> Not sure why there’s ’static here. The lifetime of `cpu_addr` is the lifetime of the object.
> 
> This is why keeping a pointer and building the slice as needed is actually a better approach, IMHO.
> That will correctly express the lifetime we want to enforce, i.e.:
> 
> ```
> pub fn cpu(&’a self) -> &’a mut [T];
> ```
> 
> Where ‘a is automatically filled in, of course.
> 

>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::device::Device;
>> +    /// use kernel::dma::CoherentAllocation;
>> +    ///
>> +    /// # fn dox(dev: &Device) -> Result<()> {
>> +    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL)?;
> 
> Have you considered ZSTs? What happens if someone writes down:
> 
> ```
> let c = CoherentAllocation<()> = …
> ```
> 
> This doesn’t really make sense and should be forbidden.

Would restricting it to a primitive type make sense?

e.g:

pub struct CoherentAllocation<T: BitAnd + BitOr>

I'm not sure, but are there other ways to enforce that restriction?

> 
>> 2.43.0
>>
>>
> 
> Everything else looks good to me!

Thanks,
Abdiel

> 
> — Daniel
> 



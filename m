Return-Path: <linux-kernel+bounces-179900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AADA8C6723
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CFC2850A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403785C6F;
	Wed, 15 May 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bIBDbkop"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A785C42
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778863; cv=none; b=jshSgQJxFYqLHH192HrgKYt2qem85OkQ7CTJkkBXuiXhGA11gdjLO4qYo2xji3NbWw7RF+EdaKQpwPCx6NedLUYMpdVyB8EhKO57ZxT3AYPeZFeNHY/c9GOYQWiPElzSzpSsO+tLvzR9uOisjvy3CWVTxFML5iszf2qeIyqIdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778863; c=relaxed/simple;
	bh=s2MsQsbOcEJaFuD6Ni7/NYOLXbHjY6U5QgaDyMhbiHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsAXSXJJeRooye4bBFh4tf1r/TG1d2HQKuqO2ejSaqKo9hjbKRU5I/UhzgSdNoUTArhPdiZobKC0lGDdRIMg6lOPOlEjZz70nx3//wEBDl0NRrZ78ar8UVPsnRYgw2+bSQefUea7gZCtC5EY6rAos5uG3JBDgDu8preVXDo5occ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bIBDbkop; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-351d309bbcfso9821f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715778860; x=1716383660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZQczyYTUAQqghnJxDKHUmq7P5Cpxuc3TDeJECCySJQ=;
        b=bIBDbkopJNG/Nsldb2WVubvW+IxpeiU9i0kgfdckqAbcjDzi05gxMXSHKpyQvXjsPO
         6Bp9tSAe7qbe8AxoJ1qaj8tT80f9hkwoduv52+gOzciFJEmAI//Ot5AZl3bSV3w99Ydh
         beTWaI9zUYiRoqQrqKNdbcNPsA3h3qOJzO4+RpGJf+GvPRDB73wgsQxOHSh08Ggzygjq
         Cz0j0VeeVF+U+3MEZogIY8YguFXsQvabpQF/w9D3TSsxLxRk9Zg1yHZ10u4lzYP8yEPe
         wr0aB0IZkMCHS7geCVn5wn+VUJp0yVA3icNL7PeJ25ykOn34aK4bnsDycCnf5BMMCF2t
         jZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715778860; x=1716383660;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZQczyYTUAQqghnJxDKHUmq7P5Cpxuc3TDeJECCySJQ=;
        b=LQ0cJoxqK1mIDUqB2RiDk1O+Mr4+uyn1R+Rh9Rh5bnaspzN6slvVUi12TZTv6xTCPu
         y2waR2epwmZujtN+l/52Ar29p6cAjCV5Tax8GG06WclBGDcW30Miq9EOmRbnK8QM3TNh
         T06Afi6G3yD8wXexCPuQGWhugvm20ng/ctU/rAkjlP8aA61PVL7xxutDLnWFTXv1e1+j
         BQC+EeQVmNpBMyxrIpDddbMjKZx3hVaDmNtbtMmA6nstFaVsGPxLNAVZQAehIIZpCYH5
         mByU47EWvFfpiTI2jVrX+EJOk5a/4a+L4on8lhg03HVdvC8Xt6sTHpUrgJ2VkwDflxLm
         EZ4g==
X-Forwarded-Encrypted: i=1; AJvYcCW/4UyJ8/fro+jMZfeu4qdcJm81fauGg8Nrg+Qy+oMPFQF07DHnrc3NCHinkJVhNO4jRYYDX/NCMXETsnlqauUZHSVmXDWAid0+XLfb
X-Gm-Message-State: AOJu0Yyxz2OTnYGBxsBSZf4kdXp6TjNvOxDmF5oFSzBzRZ0aSkh8EWqC
	83cpZ7RIVm1czBK9KR9jdxwpzXlDQ254QvSwF1tXfl1pB6DX4TohnShUEAp6JN8=
X-Google-Smtp-Source: AGHT+IGQNbYnf8Vfg9Xp8aIPaXFstDshmOgeyDh575lue3C4UTfVAvFlCh57u4sj5r7QTOh4I+0gHQ==
X-Received: by 2002:a5d:4f04:0:b0:34e:89cf:4576 with SMTP id ffacd0b85a97d-3504a9689b3mr11621359f8f.51.1715778860187;
        Wed, 15 May 2024 06:14:20 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:bd27:5d9d:ab1e:9b6f? ([2a10:bac0:b000:7315:bd27:5d9d:ab1e:9b6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbc5654sm16576757f8f.115.2024.05.15.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 06:14:19 -0700 (PDT)
Message-ID: <8a5fa107-a055-4c05-bcb1-dc4044be841d@suse.com>
Date: Wed, 15 May 2024 16:14:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240512122154.2655269-1-kirill.shutemov@linux.intel.com>
 <20240512122154.2655269-4-kirill.shutemov@linux.intel.com>
 <4019eff6-18a9-49b2-9567-096cdb498fb0@suse.com>
 <hlif565xmuj4oqdpap3boizepwg5ch3dssb67zzvy7i7smzp3n@x6hzdyc2qk4y>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <hlif565xmuj4oqdpap3boizepwg5ch3dssb67zzvy7i7smzp3n@x6hzdyc2qk4y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.05.24 г. 12:30 ч., Kirill A. Shutemov wrote:
> On Tue, May 14, 2024 at 05:56:21PM +0300, Nikolay Borisov wrote:
>>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>>> index 1ff571cb9177..ba37f4306f4e 100644
>>> --- a/arch/x86/coco/tdx/tdx.c
>>> +++ b/arch/x86/coco/tdx/tdx.c
>>> @@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
>>>    		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>>>    }
>>> +/* Read TD-scoped metadata */
>>> +static inline u64 tdg_vm_rd(u64 field, u64 *value)
>>> +{
>>> +	struct tdx_module_args args = {
>>> +		.rdx = field,
>>> +	};
>>> +	u64 ret;
>>> +
>>> +	ret = __tdcall_ret(TDG_VM_RD, &args);
>>> +	*value = args.r8;
>>> +
>>> +	return ret;
>>> +}
>>
>> nit: Perhaps this function can be put in the first patch and the description
>> there be made more generic, something along the lines of "introduce
>> functions for tdg_rd/tdg_wr" ?
> 
> A static function without an user will generate a build warning. I don't
> think it is good idea.
> 

But are those 2 wrappers really static-worthy? Those two interfaces seem 
to be rather generic and could be used by more things in the future? 
OTOH when the time comes they can be exposed as needed.

Anyway that could be considered a minor thing.


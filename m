Return-Path: <linux-kernel+bounces-194403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA128D3B99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0A71F28F29
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB226181D06;
	Wed, 29 May 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NusZwiB/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042E17BB3A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998464; cv=none; b=oHVWZSV6s9mUbhURNHpoZcs56ZSc+hipbhrLj1HDoVGc6VsMQyIimNaDkXeiQUJ3Wws2mKiyjUmAFSsVqYXRX8+itoDpcsPUepcbA2mh8JBnk+mseZpW7lmywvjby0sSWZHDKIOTggNhlGruND7ZwOq3vuPWcXnuL6CYpAyMz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998464; c=relaxed/simple;
	bh=dR2PF2GD3cDrRWlvyFmX5Miqw4FyTYrUYCKkuWxmODw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbGP2Wpk/x8tgjFF358ioonPvjZqcQQhNa2t/X21vPGmlyaIrKHfBU/RGA1W+FKTE8HbTNWSoXZD3w1RxrxnBtnw/A1prRBJEjTh86pCGIEts4tA+Vgp9+MEc4BBj8gPIloJcSz+KpeVitpZux7puYvcHotpQUgdWbA+MDmteBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NusZwiB/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5295e488248so2691152e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716998460; x=1717603260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpISGO3WuUe04PnsEki116NIhgkhQ6M72dVbNN+Aeoc=;
        b=NusZwiB/mqFVA1/PraIXXaW2tTIz0/GVLIt7Vf+C8fL72MyUHS2DqoHHa2o9GNp8Ax
         tb9NXQvYijkyHMJ1Lir6sSDuw9NKCD/9AmAqXBgwmPmg4bcsW6Ul5U14SxB4wsHLC2VE
         kLuNEBie/pj6PlVDGnyBqnF0c6n+ML37CCSRhisxraolyJZOMp75FcwcuiMSc82Et3h6
         e1+8EVbGavHhwrjL3y4scYgHYtuSr+iw5xfbYUAXVTdvRy6pzXYWY4F7YB7OIUEeYmyF
         cQXCodjiV58yIS/WlRNDdfA7Qsl2jXfFhq6gcPdWVIiLc7p+Z4gQ8xChW0Wh19PcrxOl
         cwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716998460; x=1717603260;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpISGO3WuUe04PnsEki116NIhgkhQ6M72dVbNN+Aeoc=;
        b=EP7WhYhPIvACnlcl0K09AQDD4IuK9soNu+A3cRkDL1oZiJbcObBQe3dZDYAiG8qm0T
         vmMwBcWoqxGaP8CMKtzA3ML3ow22BC6OkAuKhVmoe6APcGTIHniq7CLSd329cAZuYJc0
         PnxOKkWrz0bKa9VqOHFyRtBcU8C+aiLM8OOBFA81TRO5GTYR9U+FI1EbJT66FdmEPu9a
         om9/GjhQPdLnnXB7Mtl7pzrEf6klvbj7ldPCi6kA7mqD+UUhZRORugMsqx3KL2HjpFGC
         yXt6grlbKeFR6rvQgcCojy8vChwKKcNzHVyhetS6TKrgbAcWinuG6ntmfEDzsyvEpUEI
         aPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX391Znn/cTdKzE+w0bhu6o2EdTgcbdU7qkCRxlSPUrLid0YfwIGWukChh7vrzWQWKi3+MWUkVl6K1aCBHrQEl8cKPhlwkCnyjmnCMC
X-Gm-Message-State: AOJu0Ywudfx6XvLbxoRMYlW0Ga9eOKcHws9sf4DUCWzRaTx50u47Py59
	0CkVWnBCa6cDiqsYNiHukTDfgwobPtQvXF3EgeoTN2bpBF9pCgaKME5ULeQMaYwOKJ0aZysMDFI
	=
X-Google-Smtp-Source: AGHT+IGkCLpTq/NXEma51zLI7QrwrkLg8ERsRjXIJkb8taYl/yEaoNCXkFc9jLtbaJw0G1gW/HCjWQ==
X-Received: by 2002:a05:6512:ad4:b0:529:b57a:31ce with SMTP id 2adb3069b0e04-529b57a3277mr6886326e87.29.1716998459959;
        Wed, 29 May 2024 09:00:59 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a64255dc8cesm90423166b.186.2024.05.29.09.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 09:00:59 -0700 (PDT)
Message-ID: <997fcbc7-4e75-4aa2-974c-15d984f02d02@suse.com>
Date: Wed, 29 May 2024 18:00:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/NUMA: don't pass MAX_NUMNODES to memblock_set_node()
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>
References: <abadb736-a239-49e4-ab42-ace7acdd4278@suse.com>
 <e33ec69b-21e0-46e3-9b70-6d89548a145b@intel.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <e33ec69b-21e0-46e3-9b70-6d89548a145b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.05.2024 17:36, Dave Hansen wrote:
> On 5/29/24 00:42, Jan Beulich wrote:
>> On an (old) x86 system with SRAT just covering space above 4Gb:
>>
>>     ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xfffffffff] hotplug
> 
> OK, so you've got a system with buggy NUMA information.  It _used_ to
> "refuse" the NUMA configuration.  Now it tries to move forward and
> eventually does a NULL deref in memmap_init().
> 
> Right?

Yes.

>> the commit referenced below leads to this NUMA configuration no longer
>> being refused by a CONFIG_NUMA=y kernel (previously
>>
>>     NUMA: nodes only cover 6144MB of your 8185MB e820 RAM. Not used.
>>     No NUMA configuration found
>>     Faking a node at [mem 0x0000000000000000-0x000000027fffffff]
>>
>> was seen in the log directly after the message quoted above), because of
>> memblock_validate_numa_coverage() checking for NUMA_NO_NODE (only). This
>> in turn led to memblock_alloc_range_nid()'s warning about MAX_NUMNODES
>> triggering, followed by a NULL deref in memmap_init() when trying to
>> access node 64's (NODE_SHIFT=6) node data.
> 
> This is a really oblique way of saying:
> 
> 	... followed by a NULL deref in memmap_init() of
> 	NODE_DATA(MAX_NUMNODES).
> 
>> To compensate said change, avoid passing MAX_NUMNODES to
>> memblock_set_node(). In turn numa_clear_kernel_node_hotplug()'s check
>> then also needs adjusting.
>>
>> Fixes: ff6c3d81f2e8 ("NUMA: optimize detection of memory with no node id assigned by firmware")
> 
> I was expecting to see MAX_NUMNODES checks in ff6c3d81f2e8 somewhere.
> But I don't see any in the numa_meminfo_cover_memory() or
> __absent_pages_in_range().
> 
> In other words, it's not completely clear why ff6c3d81f2e8 introduced
> this problem.

It is my understanding that said change, by preventing the NUMA
configuration from being rejected, resulted in different code paths to
be taken. The observed crash was somewhat later than the "No NUMA
configuration found" etc messages. Thus I don't really see a connection
between said change not having had any MAX_NUMNODES check and it having
introduced the (only perceived?) regression.

Jan


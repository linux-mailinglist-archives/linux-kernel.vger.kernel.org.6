Return-Path: <linux-kernel+bounces-511062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE8A32546
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39C31887B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544AE20AF93;
	Wed, 12 Feb 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rhc0QFhA"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682E20896A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360952; cv=none; b=bvzPyqx0MEr6KEIUwRo8Jg/yGuy3XwMz4I3v5OTuiTZsZG6yOURWI/qQyv+wPZVAhP6+psrf1ss+JCMjPi+K2cxvXv0j4h8Qz7toXW+vbcDyoYqMc/HcYld/+YTTbFlNUQ1qmZ6Y1vzcor2qhKHFb9FHiX9W9Wd0BirjLEj26RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360952; c=relaxed/simple;
	bh=5cA9DHvlTH8FDmWvm4ojHRhcd4ghIiXt5VPf9lXr4hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej7uMokm4qIbqJIRtYU1+Tra3RD5rkN4IyKDOZxOBTu2bRcMk7DjflVoKSSrXkHtnQOpL3gK2ty/ACBpjdN44rVMg5jmofu+acqc0Vf6grKis7VxZiYN2RU1/+8yCdpxllSN/H8nNc1xTI9hiJozTfpiABThIhNeKZOecNf06KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rhc0QFhA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7d583d2afso138724366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739360949; x=1739965749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a4ktuYMZfFjDtI8OUf8Ecv+gnfAOw4b0BObK8n+AqV8=;
        b=Rhc0QFhAhq3vl72lPfF4pBxmkgpqt0bJTLb/rfYBbHvCOVk2Ufy0lJ74RYB3PnQC42
         r4p/aDB+z8JS1wfTX7fTbUx6hfKrzE/GxABjMsYiMxCxpzP6MG8L6BrhCRQenkI/uADC
         6Tw1PHLOeytUD/ucmVPXgpcNDiZxQ1SW5VSsDdX50ALD9gMDltyyPLD21YAdw/q5/JfW
         ztlyQ9/0RhES59QzM4LwRnWKOfgw9CoXakg7aJPh9po6XyKviVoxd2kOqqg61CpLCQvD
         iiJ/iDRpRB/YXnpUQ7PRSHNXRMxCLdsWHCWiK5IS2kgru4QSyMypVKVR9P8qup06pv7H
         au0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739360949; x=1739965749;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4ktuYMZfFjDtI8OUf8Ecv+gnfAOw4b0BObK8n+AqV8=;
        b=dEElk35NsGAlTWWqeZtGVe6AT+bvOnp/xtlMtDAdlzaRCxG6s6Sl4TZsbMu+aBgQJj
         nFK0dbNQx10mrjdhqz5WuixfL3/M0/Hv9e/7yy0UEo15wOkOgSST3ljoBRWnL6pr8rFU
         6rJJMtUgnfyV24RzZU5RNGhZFCQcHD5eU+veRBn6sPot/tZdmr0Oa704Cepf/1nrsJRY
         D+R9zmkhV56tZClQLRxHtJySgmazAABsD4+cXRKGcKE4Iz5eck1iZ3oIcBKSqhYbrPD8
         +rdq9i2/yB3v8HUHI6FSFWXBVLpF2CAtf+/F87nkfHlrCknBpmCRtXnF7kQc8J1krVoZ
         PLoA==
X-Forwarded-Encrypted: i=1; AJvYcCX9TRNZsJZV3CdK+ndRJkfOk1RhUvYzd46FkFkaMJxyXLaEynMUZp2VhbZ2Yztdp3NuHSLVQjGUDSYLrT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOK6lxmypM9cdD7izUgvMEoxSZL2z+Fpc/Ggnr7oi38/Q3p12o
	qmtHw6VDSFOsIvz/XqXVKxrNDVxC6qhBLFDZ51SF2tKS5viKRVRZNO/F0AMd8A==
X-Gm-Gg: ASbGncsZDWK/Ma1oz3gfPKJrbN+NyL4CRYUNFjbJaBw5x/YZ+RmLF7p4Xhj5TdaLD0Q
	LVeqmiN7Xei62UZYMqGq4vSs/dcCf7ViODingFJis+O/bk1+cWsrhlm/xPqUzpIVq+jm4j913er
	1dSTIhvJuNirrmqklN9JkwStiqE0QAAf65DkO7jsh3oBFzuPVV5UMHrrArMvYSp5tJ1mh+G35YV
	NS3P+GqhQz/D1d5MYGjFPA5dDAhvi8+sHAsLi9lXqKQMHIOJFli2buw1B/gD6xmDeu3wsNNpUWr
	KEMJbYx3OPddD3U6VRsQwyYHBlbD9bHkBMbMUU51loGTxUkLM3q253qFLcilApOm8iW+94bEpXO
	B
X-Google-Smtp-Source: AGHT+IHk8v1UXTDdoz1889v2GctlPWBa0NT2L4lQ+sQMLxd1NoafDj+R+R3QOKeQxuem4GhhaCwamQ==
X-Received: by 2002:a17:907:7da0:b0:ab7:b9b5:6104 with SMTP id a640c23a62f3a-ab7f2e8a612mr226475966b.5.1739360948795;
        Wed, 12 Feb 2025 03:49:08 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7f779d9aesm97924066b.63.2025.02.12.03.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 03:49:08 -0800 (PST)
Message-ID: <38eb09be-67fc-46ff-9e78-c37c30f50e4b@suse.com>
Date: Wed, 12 Feb 2025 12:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xen/swiotlb: don't destroy contiguous region in all
 cases
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux.dev
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-3-jgross@suse.com>
 <abe2138d-b1a7-4e53-ae5f-ea3c393d50c5@suse.com>
 <ce7320b6-68f3-43b1-8812-3a5bbd75c9c6@suse.com>
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
In-Reply-To: <ce7320b6-68f3-43b1-8812-3a5bbd75c9c6@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12.02.2025 12:11, Jürgen Groß wrote:
> On 12.02.25 08:38, Jan Beulich wrote:
>> On 11.02.2025 13:04, Juergen Gross wrote:
>>> In case xen_swiotlb_alloc_coherent() needed to create a contiguous
>>> region only for other reason than the memory not being compliant with
>>> the device's DMA mask, there is no reason why this contiguous region
>>> should be destroyed by xen_swiotlb_free_coherent() later. Destroying
>>> this region should be done only, if the memory of the region was
>>> allocated with more stringent placement requirements than the memory
>>> it did replace.
>>
>> I'm not convinced of this: Even the mere property of being contiguous
>> may already be enough to warrant freeing when possible. The hypervisor
>> may not have that many contiguous areas available. The bigger the
>> chunk, the more important to give it back once no longer needed in
>> this shape.
> 
> Really? When creating a domain Xen tries to use GB pages and 2MB pages as
> much as possible. Why would this special case here have more restrictions?

There aren't many Gb pages to be had from the space below 4Gb; frequently
there'll be at most one (covering the range from 1 to 2 Gb). For that as
well as 2Mb ones I think it is a mistake that Xen may hand them out, when
the caller could fall back to 4k allocations. Thing is that without extra
information it's hard to come up with a good heuristic to decide whether
the caller is capable of falling back. Perhaps e.g. populate_physmap()
should add MEMF_no_dma to higher order allocation requests targeting other
than the current domain, or when !d->creation_finished.

Jan


Return-Path: <linux-kernel+bounces-512578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE203A33AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9626316B8EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E520D4EF;
	Thu, 13 Feb 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SGW+z/8R"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B8212FA5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438204; cv=none; b=dS7bj24I/J6czJ9fL0Qz2snTmMJi8uAoKnCbZ33H3F2np5n6WxCNdtENAlEywHKd18z0uZghKHpMogWwcRwF+7YtctWrTIHrnWAslGK/Xuijq/DL/o7WPNxNIN+tTKeHli2pOVQhX+MtpY4W5vjKPwuM34wNDmqIIEJvEP3ZBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438204; c=relaxed/simple;
	bh=HXAoZXhnlM5axrIxBksyjI5+MHvfsmvzr+K/6Bh+ZG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqU0X7V5D2dXjAo3u9+QcPyYycqP+YbJ0c5e4FEMXoCtC22MHBqEjjiqsljphgvYn0KxxVz9pqgEMwz5yG/w3To1FyxDT62MNX/s/lAHzUmpzedJWWuVbvHF0CGVlKrOfFevrwnMMj/07odtxkN932HvSUqZtE18Y5n/fZx4vk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SGW+z/8R; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso142482866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739438200; x=1740043000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zRkrWPOd0IsaAl/i1cBAd/UOOJHGETsQN4vhzcb7v/E=;
        b=SGW+z/8RLXchMNHVw6JfIH1Yocm11GclvvJZ7Sh92MzALDZrN7m5z4O4wJuqQm9eba
         8EfneZzXn9b9B3Fk/Yx9qIaVEXS1dJuZo7SWiHcGfhlfeWAveUIzFwTSWEgINvnK5nJF
         dZuLnddieyekcYlGtyyTGHJ1bne2UMJMo2kd5FOctJBjZQzPzSF6yHWy1vQ0crBJyjlm
         CiV9uZ5nNp5S3NC+m1w0bC49q0rjDR0NkWuJ1QmFeEGcb4QV/giktQdTHBIMlxrSIVA5
         DJkva8RUD9gFaRpUk+KoXXe7ElYyiab+5feU4aTKBQRi1YsGSfBUXmOMWsuN5dHGutpW
         OhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438200; x=1740043000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRkrWPOd0IsaAl/i1cBAd/UOOJHGETsQN4vhzcb7v/E=;
        b=TRfSo00HjCPMl72PDHl61hOn/OXML7PsfH5FE1AT0ZrOAlWSQULkHFWe2ZlIWmXsEJ
         oshripm5zLto6Z/qRFS7R6mtFJRTDhgNipiyjcAdybaoIRgrYZWPWcaPThe/b2jtASHO
         A3Qm4EVUsp94rJ8RZ/wi0B3LANczUYSKkKelvsDWAMblSDz9GwsO//1wT9t/0B4n2VW1
         PTrFx52IZwtTbTQKufJ6qyOqs5e9+JgdUFfVjb3UMzK693V1vyjZYTJOyYbhzTUXK5dQ
         R4Q0vh7Ay2Nd5JHdq3wSBJ6MltJXFUJhcGXHLBDTpPAZSnv0kAIqJejwFQ7jsdPsaBKo
         SiKg==
X-Forwarded-Encrypted: i=1; AJvYcCWLncnlCpyLUlcJfNajj66ZBMeWT63uN3naOefKdUNTgEnQlkJV68Dus2IrseQRv4gCQ1ni3CHJNuVTE9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1r92h3AshPDdLRp7RxCNz7uaGdzq5Z/iHYVGxpdXdI3NgRRSE
	omX3ig9nTsjXAX2hEOw7oDDrrnDC9g1rYm6KcmIJpt59h4bvABMsivKfZqjuzQ==
X-Gm-Gg: ASbGncsEdoLVvQELCbhKgpNVX8oGz3gNdJ2/3vodP44/HKmqWqw/fO0ILyk/DO8GVKn
	/A5I82EwI9Z0WHLQEGJqohIMUW8MX96D1gfVQcmR9ryVWoGhyg02kDP22O4qw5qiVKrYGmidXwN
	PL7+OyTVorty1CFtkER72uoJgZa14WL0dwrxNxcNFVKNsm7+B4Hv/tTIRMituRLJyTCL73T/TyZ
	C5yMK2eqj/gMySLvZ78ncz4UsTlheuxGJ8XKfBuRxU8hzC7MNKAi1vT8NgYGqYmg52w3iWxNA6B
	vQ4Pq8EvN/gx49z8d4B8mBRQHw1b0uSNKcbocA+IurOqUsQqOoWjVGpEmLF/0EnTOqrFmV8KiM3
	A
X-Google-Smtp-Source: AGHT+IHWRf/+KzG9HrxCQBidwzrnatPQtCqKYeDgQtIB6T/iJ+L0xT4HnzOW1pZMcfuVnIaruw9ImQ==
X-Received: by 2002:a17:906:c10c:b0:ab7:d6c:5781 with SMTP id a640c23a62f3a-ab7f33a1557mr632279566b.24.1739438200532;
        Thu, 13 Feb 2025 01:16:40 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5325b58bsm91116766b.74.2025.02.13.01.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:16:40 -0800 (PST)
Message-ID: <b6eac47f-648f-4197-8f6d-96bc71cf15b8@suse.com>
Date: Thu, 13 Feb 2025 10:16:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/xen: allow larger contiguous memory regions in
 PV guests
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 Alan Robinson <Alan.Robinson@fujitsu.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20250213085538.17060-1-jgross@suse.com>
 <20250213085538.17060-3-jgross@suse.com>
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
In-Reply-To: <20250213085538.17060-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.02.2025 09:55, Juergen Gross wrote:
> Today a PV guest (including dom0) can create 2MB contiguous memory
> regions for DMA buffers at max. This has led to problems at least
> with the megaraid_sas driver, which wants to allocate a 2.3MB DMA
> buffer.
> 
> The limiting factor is the frame array used to do the hypercall for
> making the memory contiguous, which has 512 entries and is just a
> static array in mmu_pv.c.
> 
> In order to not waste memory for non-PV guests, put the initial
> frame array into .init.data section and dynamically allocate an array
> from the .init_after_bootmem hook of PV guests.
> 
> In case a contiguous memory area larger than the initially supported
> 2MB is requested, allocate a larger buffer for the frame list. Note
> that such an allocation is tried only after memory management has been
> initialized properly, which is tested via a flag being set in the
> .init_after_bootmem hook.
> 
> Fixes: 9f40ec84a797 ("xen/swiotlb: add alignment check for dma buffers")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Alan Robinson <Alan.Robinson@fujitsu.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>




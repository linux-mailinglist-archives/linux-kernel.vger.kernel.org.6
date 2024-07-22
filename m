Return-Path: <linux-kernel+bounces-259396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D993953D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F40FB21AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680E3BBEF;
	Mon, 22 Jul 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="J2hdpjQp"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6E288B1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682799; cv=none; b=nKUouu+M8zgokg9XGEN8lXWmQKwVtOtfPoAhDXHzd4mi+GuLassOVy+VXnyNPZtNTPQi546MTM3yZplPD7tEOfiGdeZQ6OC2vwKqX5CpkDCj8H0G9b1Kyj07QpVMJfjPL7YKAVip1stXiUB+ccIYjCeN9rpAa0dqm5aiTegL7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682799; c=relaxed/simple;
	bh=jNysOa635nYkmPenm4xC+OdlUNZNLMQJ5Eaz+khjMBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Thf94dOiIOscRDRbntCCzi0oRb04tYN0gBhN/TS71Pv17sl+566nMi94xxbkDy683vizbcC4cOZDcqI0GQsODmO3BFFu+oHnkqCR/fyeHtU9lSD1t71BfDWUjbiX2pJbLLDSEfPfokNGtGXoLTTiF7xuhZZr57P7EaTDhTVFmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=J2hdpjQp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso35690325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721682796; x=1722287596; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xhOAmQNOcZdVJ24vmwPqUlyqfZ/Rg7Wwwx4u5WC3mAw=;
        b=J2hdpjQp7k/GFp7kQPWx3tZAqGryGSAhRFvcqqhvr6GUfaTFapOy2uFO2Wzfwz9RIA
         tJeNJoEgtj0el7rUW7JPVtmg4P2RG1d4T7ZUL02Hk5HuMuXazLKHVsPWAswvzGDGwaxN
         OYKPo+zf0P38ORPjhJ4n6fg0DSjBQB6HUb3j9Te89OEIgsnjJ2qaUJkM8dvhGCmJlvnV
         Lnn9NjDrZdGy8lRi+7hC+EwsO0cYN72dSnLfaSp36MzZo2BKuSaG0MbWn0grQmU6QLhi
         FKVY4/Iu+aISh0V9mies/ksILO7tHOoChnyOx0yX/YvHcEloKOI9/SQpJ4pRp0ehKwty
         rO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682796; x=1722287596;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhOAmQNOcZdVJ24vmwPqUlyqfZ/Rg7Wwwx4u5WC3mAw=;
        b=Mh+RcH9oRbpZ4pp/YRDKdao/YtAt49BTVFLNsTpifCyJm4X/vmP2CXOyr2C+rVDzmq
         K5KVdEiM2Ijwsaq8stCh6fpKiU1hMx3X+ri2csVIQxA7v0VPBybe2DtDLjyXm8BGz3Pe
         GrTXClB2xky6keLpTcZMucnVE0xoaVohJz0HIR6ma+RoiZT2G+5MIHFxuyU/LfXH1aXr
         c5GoM4pv3UzcZRvmdMWdyXev0Wcnh0jOKm5HQspAa9sl5r3cviCYv6vsEsoR/5dexy8w
         3ACd96laBfIJAEPBpoHr2tdTv1v3K/VTj4axr5tEaX9NSKITzTRq6TkQ8aDn+HebwT8t
         05CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAvs6dWKP41jfwHkYe//c96dR5sS6Ix5cpRzO0ULC7Afv/xoc1MMvgLfz9g31BiQqnTzbPeSDaA2vaI+HNk70jOwHhVOaG0EOmVKKX
X-Gm-Message-State: AOJu0YwlgFdxc0LePeTRIGjl6hDk0Bfn83IDB8BqGbAOiqVZCVkC9xlW
	/tUKAEZ4Tzb1hkpFTFtnLGCt/wZnCOM+FQ+x7PrwH1ESNwMkhngqVFs0qtquYVI=
X-Google-Smtp-Source: AGHT+IHS8HIR5eie3M+WQ39jCYnVVianTH2P5I2F/G8SSGCO6r3WxUZcOqhXjjXhphzDDv3/4HJyiA==
X-Received: by 2002:a05:600c:35c8:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-427ed06816amr7022735e9.31.1721682795704;
        Mon, 22 Jul 2024 14:13:15 -0700 (PDT)
Received: from localhost ([149.71.24.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d69019a5sm141079465e9.18.2024.07.22.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:13:15 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: palmer@dabbelt.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, rppt@kernel.org,
	paul.walmsley@sifive.com,  aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,  akpm@linux-foundation.org,  bhe@redhat.com,
	dawei.li@shingroup.cn,  jszhang@kernel.org,  namcao@linutronix.de,
	chenjiahao16@huawei.com,  bjorn@rivosinc.com,
	vishal.moola@gmail.com,  linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v2] RISC-V: cmdline: Add support for 'memmap' parameter
In-Reply-To: <ZoXEmryf8RuLMZWN@ghost> (Charlie Jenkins's message of "Wed, 3
	Jul 2024 14:37:30 -0700")
References: <20240624123739.43604-1-cuiyunhui@bytedance.com>
	<ZoXEmryf8RuLMZWN@ghost>
Date: Mon, 22 Jul 2024 22:13:14 +0100
Message-ID: <874j8hku51.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Palmer,

Charlie Jenkins <charlie@rivosinc.com> writes:

> On Mon, Jun 24, 2024 at 08:37:39PM +0800, Yunhui Cui wrote:
>> Add parsing of 'memmap' to use or reserve a specific region of memory.
>> 
>> Implement the following memmap variants:
>> - memmap=nn[KMG]@ss[KMG]: force usage of a specific region of memory;
>> - memmap=nn[KMG]$ss[KMG]: mark specified memory as reserved;
>> 
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> ---
>>  arch/riscv/mm/init.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>> 
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index e3405e4b99af..8e1d93ae5cb2 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -208,6 +208,52 @@ static int __init early_mem(char *p)
>>  }
>>  early_param("mem", early_mem);
>>  
>> +static void __init parse_memmap_one(char *p)
>> +{
>> +	char *oldp;
>> +	unsigned long start_at, mem_size;
>> +
>> +	if (!p)
>> +		return;
>> +
>> +	oldp = p;
>> +	mem_size = memparse(p, &p);
>> +	if (p == oldp)
>> +		return;
>> +
>> +	switch (*p) {
>> +	case '@':
>> +		start_at = memparse(p + 1, &p);
>> +		memblock_add(start_at, mem_size);
>> +		break;
>> +
>> +	case '$':
>> +		start_at = memparse(p + 1, &p);
>> +		memblock_reserve(start_at, mem_size);
>> +		break;
>> +
>> +	default:
>> +		pr_warn("Unrecognized memmap syntax: %s\n", p);
>> +		break;
>> +	}
>> +}
>> +
>> +static int __init parse_memmap_opt(char *str)
>> +{
>> +	while (str) {
>> +		char *k = strchr(str, ',');
>> +
>> +		if (k)
>> +			*k++ = 0;
>> +
>> +		parse_memmap_one(str);
>> +		str = k;
>> +	}
>> +
>> +	return 0;
>> +}
>> +early_param("memmap", parse_memmap_opt);
>> +
>>  static void __init setup_bootmem(void)
>>  {
>>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
>> -- 
>> 2.20.1
>> 
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Another patch that looks good to get merged if there are no further
comments.

Any chance this can be picked up for this cycle?


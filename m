Return-Path: <linux-kernel+bounces-337582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B8984BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C08B1C22DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7654213B2A2;
	Tue, 24 Sep 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV3nvds+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4B12FF72
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208659; cv=none; b=ELpc+186N4LxNvpTS0HWOw+jla2KFlkg6N7g2mU8q87a/79jPiUMH+1AhRwRcdBkRtBQ59Ba5A9GRaFXIULEgP6zxSik2funqU4b09oEQLXIlTpzr2MbFneL3e+us5ZswaRwTYG9D2rzAUdBd3171ZfZXo71BJQFqxXfh0sKj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208659; c=relaxed/simple;
	bh=kw/LMASQWNus6mqYpIe/RYwGi5d4XEEQXXoAJVb0F5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByViOmncmxLjzu40dlUtNJvBJgqqJ5yAxxh7P0kGZTBgrLs3hpDQXRGknx6NB2weEhal9kY6cuB4eNtTtJEmH8ObU7Y0aWfQF209rKZ5hWcxuBF17M1ngWkYphZaMjB17aVeBDwyT1UTc3MWTXDbqAAcJOL7C1AKu0fl4mX9zms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV3nvds+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727208656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oSLm4Kl8UBZcqRPKiEhKkXlXaEuga8M/MvmM/NauC6M=;
	b=LV3nvds+5t1nQ9RsoDVWInfmMTO9fpk3ELq4c+qdQGZr3YCxYSiBlNtuMtUmmTE1wdt0tF
	xZz3Sj3RbV4jvjKXpgwKKcohG8ruh0zkwIIx34TgK3J4N3/5zgQTbjs5MSximzcxp1YoQ0
	a5U20H2QTa+so3HNACwKsR4ET/0UxFg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-Ip4lL-aQOvaT52qdoSEjyQ-1; Tue, 24 Sep 2024 16:10:55 -0400
X-MC-Unique: Ip4lL-aQOvaT52qdoSEjyQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cc4345561so39516875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727208653; x=1727813453;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSLm4Kl8UBZcqRPKiEhKkXlXaEuga8M/MvmM/NauC6M=;
        b=dyuH+3bzvgoEbN4zUNnfv6xwXrJgaqBv8OT1fL9gtSyKl6DXvJfjhrZsy+x+vzrxpO
         T9wZ/VnwkEQ9z7OHKJftH03Y6QliiLDjW42LaileWrz0KLYlprZKv5WFtXExpkWk7T8v
         RZes3NTIUhEqVEW6M6zh3FEXVtoLOqqMrFCBhUgIG6y+mHgatQBY0fF6TQyOh0XEIYdj
         YtyqPkdTe70E0rH/ItE/NP9GMNJ0xrnc8ckIBP/NCKvNkLBOh5e+9HuneBs/Dk1iLSox
         votkwilXUOY+1EESoxZH3D7DVNli1k6mI0XDKeNIfg9yDiWYKSw4kjQvrwLAtiorV3lv
         JgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwZbL73xfEW+cRsfpZKhAe1m3zr8Z0c8KAg8329J8jkNewz3o/3ukLbYGt9znUmiWUaqEDnNxltfXcjtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1S0CWSsB/Zm4/A1VDjeK2rnXURwPNR795awqvGjQ+L2TYIdZ8
	kNVMSM9drw+vnXXF5ApMt23CW66ytteuuHNwjo3L1f6m770cBnD7w8BAv4CUL7g1+j0YTK38Vyr
	SbdrPT1dfwdGRFqsNQD06Gd/9CWgKaKfBQCHmoJBXyiJMi+NMYcq3410x5ZJ0RQ==
X-Received: by 2002:a05:600c:348e:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42e96248f96mr1623365e9.32.1727208653306;
        Tue, 24 Sep 2024 13:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXXi6Pvc0wS7aYEcHiW7TC+6GNRfttgfcykmeGusFirCpPxaFD8GgM9jJ5qWMnVfdW9Dr2LA==
X-Received: by 2002:a05:600c:348e:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42e96248f96mr1623225e9.32.1727208652875;
        Tue, 24 Sep 2024 13:10:52 -0700 (PDT)
Received: from [10.1.26.69] (ip-185-104-138-71.ptr.icomera.net. [185.104.138.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f976esm2348031f8f.69.2024.09.24.13.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 13:10:52 -0700 (PDT)
Message-ID: <05549846-d813-44ad-966e-e42001570d0e@redhat.com>
Date: Tue, 24 Sep 2024 22:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Make SPLIT_PTE_PTLOCKS depend on SMP
To: Guenter Roeck <linux@roeck-us.net>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240924154205.1491376-1-linux@roeck-us.net>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240924154205.1491376-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.24 17:42, Guenter Roeck wrote:
> SPLIT_PTE_PTLOCKS depends on "NR_CPUS >= 4". Unfortunately, that evaluates
> to true if there is no NR_CPUS configuration option. This results in
> CONFIG_SPLIT_PTE_PTLOCKS=y for mac_defconfig. This in turn causes the m68k
> "q800" and "virt" machines to crash in qemu if debugging options are
> enabled.
> 
> Making CONFIG_SPLIT_PTE_PTLOCKS dependent on the existence of NR_CPUS
> does not work since a dependency on the existence of a numeric Kconfig
> entry always evaluates to false. Example:
> 
> config HAVE_NO_NR_CPUS
>         def_bool y
>         depends on !NR_CPUS
> 
> After adding this to a Kconfig file, "make defconfig" includes:
> $ grep NR_CPUS .config
> CONFIG_NR_CPUS=64
> CONFIG_HAVE_NO_NR_CPUS=y
> 
> Defining NR_CPUS for m68k does not help either since many architectures
> define NR_CPUS only for SMP configurations.
> 
> Make SPLIT_PTE_PTLOCKS depend on SMP instead to solve the problem.
> 
> Fixes: 394290cba966 ("mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options")
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



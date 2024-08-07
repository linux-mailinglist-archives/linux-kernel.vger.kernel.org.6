Return-Path: <linux-kernel+bounces-277819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9694A6F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160D21F249A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4851E3CA5;
	Wed,  7 Aug 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AozdfuwD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D031C689B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029907; cv=none; b=IC85+xWTxtCLBVFlgLu9d/ZPW/lMV3FyCelOo6pFHK8iarkjOyjPeI4KxGJUJ6XU9Hapm7rcjcIJcBHt9R6d0XdAQubLkui0JTXxpif/sQ33MsSh6+C9Mf4DAntOvoP6IdwN3VakXwc8o4lXLtLeUXr48pcHwOJcxJLoOZ/TtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029907; c=relaxed/simple;
	bh=cjKe5aqjltaMy5lpigAbb0QJGUmcGvoVQob3xsuhGDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tGWMSr9fLB/J0w+8fiMCmcgrR44vNalYsLAW7/VxTEqrzOVN/B/Sktg6W6TQPaUnfkQgPD7IDVhgbjLfg4Chwvllw1I/13zPDoqBEZp1J8m9ErIj3t/+cYlcd1+BWI0mM1lQN0wbD5aYNUTgsuBOTSGZIOKIixKlhD/DM/nmElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AozdfuwD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723029904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kUmg6m+rX0ZdRF47MclkDhoxeaVkz+iC7VCa9/iV6Vw=;
	b=AozdfuwDf3+x/z+D5lfpe/CeLWfH6PPBVvZIiIGvnd709b0A3rDel5RDbnX6UX/+8mBB8P
	1zFnCIukhqyx5cppoAhVQOoOsRZSbg/nnBXr8Z1ZvhAoUNPrTBfvbsI1VwxMZVCcDwywOj
	gAs6l+kXdvv5fsYuZK9dM6Pn6qQnc80=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-8KAmFlWuPeG5gKKTVcdiLA-1; Wed, 07 Aug 2024 07:25:02 -0400
X-MC-Unique: 8KAmFlWuPeG5gKKTVcdiLA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3687f5a2480so831858f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723029901; x=1723634701;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUmg6m+rX0ZdRF47MclkDhoxeaVkz+iC7VCa9/iV6Vw=;
        b=ov6NGBAci+cwYONcdi1/R0oqoPuxFi7SGECNjPNrUxN4sqfUw4FVIlqUKITJfETYKV
         shBjivt5EZFOvAlsNa/9aGaamFmCdfWXyEv7LouiL5Qz7BGTVc2J8cyrgyzzwyCK0tep
         pHoNhIf/C0hRLt0paybENtyf9WwCT5I+HMqUqvcuMMuucxuZhK9EZien51fimBYqCan5
         v8TioUdb99tlayChc+OD8flLPAP30U++zFLOgF1bM5ax1FO4DU5HNDy45RROV6/0ePV6
         c0Nvcaifyg8KxRgA/wxUH4R7MBMExDrA1mbi7d2XoW9k27ECrqheGC1jsN3bf1yK6XJt
         76Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVyn+MKCpqas+VoaNq5qofqgKeKG2MDVR7wEncwbSgOlnGprSfPeOg3DT0yULGHpf6JqG71JfElweQYhvN+ohWvgmkYN6XTQPwJpu5D
X-Gm-Message-State: AOJu0YzLpvIn85KvlsffK/IX72d81Nwe4wSdCyfIAZJ07SZxkjezx3/2
	VbdJ/YY3C4Z5DfnxZtHr5orTXpvhgEfe+zyGYgSZvOpICyrkMK8M7f07u76DLF1o3MehWDL8pLk
	pA9ihCl4ghpLCk/+C6OKQ8T8GLAk7DwwTWtqgrxvi3xbJNglO6ZowtEaj0DWJBQ==
X-Received: by 2002:a05:6000:2a6:b0:368:31c7:19d9 with SMTP id ffacd0b85a97d-36bbc0c54eamr16661091f8f.12.1723029901518;
        Wed, 07 Aug 2024 04:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSeCKCmaFkgVQy7NTVGMO35DBiIizaJ1GZqRtDIurBEJSTZSCwcCs/VepdNDXoauGMk9Tgsg==
X-Received: by 2002:a05:6000:2a6:b0:368:31c7:19d9 with SMTP id ffacd0b85a97d-36bbc0c54eamr16661039f8f.12.1723029900802;
        Wed, 07 Aug 2024 04:25:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059e44sm15739210f8f.70.2024.08.07.04.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 04:25:00 -0700 (PDT)
Message-ID: <8da4b0dc-6522-40ff-ba61-ea41fb3437b0@redhat.com>
Date: Wed, 7 Aug 2024 13:24:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: update the memmap stat before page is freed
To: Pasha Tatashin <pasha.tatashin@soleen.com>, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
 ardb@kernel.org, arnd@arndb.de, bhe@redhat.com, bjorn@rivosinc.com,
 borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
 chenhuacai@kernel.org, chenjiahao16@huawei.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, dawei.li@shingroup.cn,
 gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
 hpa@zytor.com, kent.overstreet@linux.dev, kernel@xen0n.name,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev, luto@kernel.org, maobibo@loongson.cn,
 mark.rutland@arm.com, mcgrof@kernel.org, mingo@redhat.com,
 mpe@ellerman.id.au, muchun.song@linux.dev, namcao@linutronix.de,
 naveen@kernel.org, npiggin@gmail.com, osalvador@suse.de, palmer@dabbelt.com,
 paul.walmsley@sifive.com, peterz@infradead.org, philmd@linaro.org,
 rdunlap@infradead.org, rientjes@google.com, rppt@kernel.org,
 ryan.roberts@arm.com, souravpanda@google.com, svens@linux.ibm.com,
 tglx@linutronix.de, tzimmermann@suse.de, will@kernel.org, x86@kernel.org
References: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 00:14, Pasha Tatashin wrote:
> It is more logical to update the stat before the page is freed, to avoid
> use after free scenarios.
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



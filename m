Return-Path: <linux-kernel+bounces-334184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD697D398
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A825B24608
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B71442E3;
	Fri, 20 Sep 2024 09:27:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF5A33993
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824457; cv=none; b=aYV90S5eW1dSLjYPQGzK3U0FoTqeR2+w+p+3AFkFULj7EX4FK0Zv0QfCDLSSr4rWTJdYlfJHMxDT4PiFeW9eimayjFMnxM0zXKfypJf6VQ1K18mFWFXB80AjFoyFybY/Nun1U39haReAi+Am0J099FtrdALyBKLDq5TylpLfi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824457; c=relaxed/simple;
	bh=b2n7NdhsXjhS9GDljJQwpQr3V4tfT6nrH0jLUomVkmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2beTtepioKEpXVCl8mvC50OwvzFDZSAbbMUV3YuZYVI/xh24vZwWqJGnilV363JMLoQ5SwYHsC2Hy6jAs+hXVNxu0dkQTAeZHVscJL2xZ5cQN/ulzMFBofbnwTsEseTMbb2KzNM0wjSG6VkxCEXtFYmBLzsLY1Vqb88xawyuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B7E1007;
	Fri, 20 Sep 2024 02:28:03 -0700 (PDT)
Received: from [10.163.35.184] (unknown [10.163.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21993F66E;
	Fri, 20 Sep 2024 02:27:27 -0700 (PDT)
Message-ID: <89806be0-c95d-4a85-a8da-a253aea68093@arm.com>
Date: Fri, 20 Sep 2024 14:57:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Move set_pxd_safe() helpers from generic to platform
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 x86@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920053017.2514920-1-anshuman.khandual@arm.com>
 <3309e9ca-458b-4b10-8409-9fe315b60ae2@intel.com>
 <925a26e2-bd53-4bf4-b22d-7a0e11581376@arm.com>
 <2924c274-2b01-4b33-87e7-5b66aceba3b0@intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <2924c274-2b01-4b33-87e7-5b66aceba3b0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/20/24 14:22, Dave Hansen wrote:
> On 9/19/24 23:42, Anshuman Khandual wrote:
>>> I just did a quick grep and don't see any difference between the _safe
>>> and normal variants.  A quick grep didn't turn up any actual users.
>>>
>>> Did anyone actually double check that these are still needed on x86 in
>>> the first place?
>> arch/x86/mm/init_64.c
> 
> Ahh, the #defines make them immune to grep. :)
> 
> Long-term, we should make sure these are still necessary.  Short term

Agreed, David H has also mentioned about that.

> (in this patch), please just put the #defines in init_64.c if it is the
> only site that needs them.

That is not the only site where they get used. set_pmd/pud/p4d/pgd_safe()
are also called from respective pmd/pud/p4d/pgd_populate_safe() helpers
in the header arch/x86/include/asm/pgalloc.h.

Besides also hit a road block in converting these macros as static inline
functions as suggested by David H earlier, because pmd/pud/p4d/pgd_same()
macros are defined in include/linux/pgtable.h, way after <asm/pgtable.h>
gets included.

I guess we will have just leave these macros is in arch/x86/include/asm/pgtable.h


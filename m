Return-Path: <linux-kernel+bounces-324178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964A9748F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2471E1F268D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FE94AEE0;
	Wed, 11 Sep 2024 03:53:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74DD14287
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026787; cv=none; b=AOJbcZd3lLaq0Zro+cnd25ouEmqVfm474ACVWMoAenkIhfKA7JdNnlOJky1rJdXekeMnw7bYWPYok7C4GvmPZGeJTFyjYmGjsCvR+DU3rMSsJbwJsetpWFQlqP4etirNhn7u15gbOKSiNXSpgoINrIDbaGMBKJvWIJ72cp1ezqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026787; c=relaxed/simple;
	bh=vMqRa9+Z6o51QoRAWv4KxMXkuejfenJtZzHH+8sgKj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc4pV3ZISJo4OHkeA4rQai0Y/uGNA5yCWP2UJxnxr3W3sHAT7LOCIxpr0Ql9P+nOI/AHi/6/RvghiYhnCi0k8D2SoY8Xfwc51dc5fQxzz2cCSgEnEaUpfUPuIfmvw50h21JaEz21kUd0wVeadimkrQDSFiZvnN0Byc3g1NJSCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26F341063;
	Tue, 10 Sep 2024 20:53:34 -0700 (PDT)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F43C3F66E;
	Tue, 10 Sep 2024 20:53:02 -0700 (PDT)
Message-ID: <1340d57f-3f4e-4873-aa66-e93d3a8f3394@arm.com>
Date: Wed, 11 Sep 2024 09:22:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm: Drop unused set_pte_safe()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20240910101026.428808-1-anshuman.khandual@arm.com>
 <20240910131355.8f56f86045c745cee7a97f85@linux-foundation.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240910131355.8f56f86045c745cee7a97f85@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/24 01:43, Andrew Morton wrote:
> On Tue, 10 Sep 2024 15:40:26 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> All set_pte_safe() usage have been dropped after the commit eccd906484d1
>> ("x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page")
>> This just drops now unused helper set_pte_safe().
>>
>> Besides this macro was buggy due to doing direct dereferencing of the pte,
>> and if it were to be kept, it should have been updated to use a single call
>> to ptep_get().
>>
> 
> arch/x86/mm/init_64.c: In function 'set_pte_init':
> arch/x86/mm/init_64.c:83:17: error: implicit declaration of function 'set_pte_safe'; did you mean 'set_pmd_safe'? [-Werror=implicit-function-declaration]
>    83 |                 set_##type1##_safe(arg1, arg2);                 \
>       |                 ^~~~
> arch/x86/mm/init_64.c:91:1: note: in expansion of macro 'DEFINE_ENTRY'
>    91 | DEFINE_ENTRY(pte, pte, init)
>       | ^~~~~~~~~~~~

kernel_physical_mapping_init()
	__kernel_physical_mapping_init(, init = true)
		phys_p4d_init(, init = true)
			phys_pud_init(, init = true)
				phys_pmd_init(, init = true)
					phys_pte_init(, init = true)
						pte_init(, init = true)
							set_pte_safe()

Right, seems like there is a path to set_pte_safe(). Sure, will drop this
patch and convert the direct access into ptep_get() instead.


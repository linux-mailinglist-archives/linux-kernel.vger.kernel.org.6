Return-Path: <linux-kernel+bounces-334004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F274697D149
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7881F23DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109F84084C;
	Fri, 20 Sep 2024 06:42:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527BD38F9C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814575; cv=none; b=iZgG5aB5iXu6mSibCAx7xTjEU0vaUS8Qc7tDcG+Gj7d6U1H+2tJGO4MYUra0Ec3lLNpOvpzxSPjhRO6VgSjoJUmOOykVoMtx882X6Yj4ll8c8jow3GjrX3l0obFLoAoqpRCgR8kqIkObmBWbD6mpon7p/LvkkX+k5eScxTBNN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814575; c=relaxed/simple;
	bh=Caar0Ui3QeyIyusR/HrVjbDpxF2GyfG3bUi2+8aZIKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWN/eN5Tw+q+T3GwZgv5zso1aolvCMklK3CeKU+U9jhltG81Jri5ZDyyhCaS9kgfYihn0OJqDBgG6R8EABIg6mBS3r6W4AjNjR4fM+f0jT7u6AsFGhGShnjVOccYBXe7IjO5+W9Bzij5ljvPL7yO6MJHw/JkN0E0XSAhoS1LeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9D0CFEC;
	Thu, 19 Sep 2024 23:43:21 -0700 (PDT)
Received: from [10.163.35.184] (unknown [10.163.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5B7E3F66E;
	Thu, 19 Sep 2024 23:42:48 -0700 (PDT)
Message-ID: <925a26e2-bd53-4bf4-b22d-7a0e11581376@arm.com>
Date: Fri, 20 Sep 2024 12:12:47 +0530
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
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3309e9ca-458b-4b10-8409-9fe315b60ae2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/20/24 11:19, Dave Hansen wrote:
> On 9/19/24 22:30, Anshuman Khandual wrote:
>> set_pxd_safe() helpers that serve a specific purpose for both x86 and riscv
>> platforms, do not need to be in the common memory code. Otherwise they just
>> unnecessarily make the common API more complicated. This moves the helpers
>> from common code to platform instead.
> 
> I just did a quick grep and don't see any difference between the _safe
> and normal variants.  A quick grep didn't turn up any actual users.
> 
> Did anyone actually double check that these are still needed on x86 in
> the first place?

arch/x86/mm/init_64.c

#define DEFINE_ENTRY(type1, type2, init)                        \
static inline void set_##type1##_init(type1##_t *arg1,          \
                        type2##_t arg2, bool init)              \
{                                                               \
        if (init)                                               \
                set_##type1##_safe(arg1, arg2);                 \
        else                                                    \
                set_##type1(arg1, arg2);                        \
}

DEFINE_ENTRY(p4d, p4d, init)
DEFINE_ENTRY(pud, pud, init)
DEFINE_ENTRY(pmd, pmd, init)
DEFINE_ENTRY(pte, pte, init)

We had triggered a build problem after dropping off set_pte_safe()
which seemed not to be used after normal grep.

https://lore.kernel.org/linux-mm/202409131220.CJ5MlGCG-lkp@intel.com/


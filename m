Return-Path: <linux-kernel+bounces-539090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE3AA4A0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4A9176152
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EB526B2C8;
	Fri, 28 Feb 2025 17:43:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906B170A11
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764627; cv=none; b=ldwNDS7IdIKf0Ikj/HOUmjpakjOVgcRCwi1ifF5hzkfCXs+gq0AjP19at831N6skDyeWvySQkLG1aWWibSKwGTfhIIJJ4qzDMJOs5eTANxsJIulybdxegVJcFedNvoF9Yy4eihyyGUOj/KVbFpNL2Qt528vykqlEIm9Xqx3Brjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764627; c=relaxed/simple;
	bh=XndCvziIH+5t3X647mBAznTH3Tt9axCF2JGxfpTje8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZWfr08iOjQBWLcVlQzRB2gj687o1AeTF1lUyBOmJuetLFPiP4gZENhknKenFtDjskiFhOEgsuAd/cfrZnSww+JuHwYuCiWls0iEF2JkH9TmX8baLBm+t6lGo5U9VredXrQBCkCIea70RpRf/JFAE+vRGCufU2bX00Bzn4HA7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D45150C;
	Fri, 28 Feb 2025 09:43:59 -0800 (PST)
Received: from [10.57.65.205] (unknown [10.57.65.205])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB0583F6A8;
	Fri, 28 Feb 2025 09:43:41 -0800 (PST)
Message-ID: <21450528-06b7-4964-b975-5f4ab113373a@arm.com>
Date: Fri, 28 Feb 2025 18:43:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/mm: Remove unnecessary include in set_memory.h
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dan.j.williams@intel.com, dave.hansen@linux.intel.com, david@redhat.com,
 jane.chu@oracle.com, osalvador@suse.de, tglx@linutronix.de
References: <20241212080904.2089632-1-kevin.brodsky@arm.com>
 <20241212080904.2089632-3-kevin.brodsky@arm.com> <Z8BiUnkPnvrx06vp@gmail.com>
 <Z8BirVtqibWY6zaT@gmail.com> <ce29384e-b3fe-4196-a986-bb57a5d693d6@arm.com>
 <Z8Hu8oDHRnLx_gxm@gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <Z8Hu8oDHRnLx_gxm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2025 18:14, Ingo Molnar wrote:
> * Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
>> On 27/02/2025 14:03, Ingo Molnar wrote:
>>> * Ingo Molnar <mingo@kernel.org> wrote:
>>>
>>>> So I tried to pick up this patch belatedly, but there's more places 
>>>> that mistakenly learned to rely on the stray <linux/mm.h> inclusion, 
>>>> for example on x86 defconfig-ish kernels:
>>>>
>>>>
>>>>   In file included from drivers/gpu/drm/i915/gt/intel_ggtt.c:6:
>>>>   ./arch/x86/include/asm/set_memory.h:40:57: error: unknown type name ‘pgprot_t’
>>>>   40 | int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
>>>>   |                                                         ^~~~~~~~
>> This patch relies on patch 1 in this series, which removes 
>> __set_memory_prot(). I seem to be able to build x86_64_defconfig 
>> without issue with both patches applies on the latest mainline.
> Oh, the 1/2 patch was missing from my mailbox (my mbox's fault, not yours),
> and apparently the 'PATCH 2/2' tag wasn't a big enough of a clue for me
> that there's a dependent patch. ;-)

Ah that would explain it! Naughty mailbox eating patches :)

> Anyway, I re-tested it with both patches applied and it's all looking 
> good now, and I have applied them to tip:x86/headers.

Great, thank you!

- Kevin


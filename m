Return-Path: <linux-kernel+bounces-538381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9847EA497F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783B83BBBF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663FC260384;
	Fri, 28 Feb 2025 10:56:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68325F982
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740192; cv=none; b=tvRnsw5OR750OtXlYyV/ZP4zFYzVIvehmuMZ3Mi4+nVF4gIXYNZXbcQpjLOnQk5FztV/ezEdnjWnGH/0ZU/CqUChZY4MH2KbcdwYmcNPoNyUbw2NlyHnigoudqcivhhvFY38Qp+8rxRes98htcnLXZkAC38DhwX24D8um/S+tYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740192; c=relaxed/simple;
	bh=u88/uSJlZTz8zOAcatnX20VLboCHUum5KSo1EbPe1fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m29HyBDb6BuTbRVrO0Ff2JETR8m9+ZkfQlWRDdTfaFgRXHT8gIRbuNcs7yvDlLctbmiOgmDmg+222tSgcZUNEQjKMSUZHW/5nGxyEVlYPzg+vyAaL1i3luIXaW46kobZo9kMD9X5J2YRDVh0f1RTk7eVGo1TihSr3h2sLI3Qfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9CFF1688;
	Fri, 28 Feb 2025 02:56:43 -0800 (PST)
Received: from [10.57.65.205] (unknown [10.57.65.205])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C87E93F673;
	Fri, 28 Feb 2025 02:56:26 -0800 (PST)
Message-ID: <ce29384e-b3fe-4196-a986-bb57a5d693d6@arm.com>
Date: Fri, 28 Feb 2025 11:56:17 +0100
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
 <Z8BirVtqibWY6zaT@gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <Z8BirVtqibWY6zaT@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2025 14:03, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
>
>> So I tried to pick up this patch belatedly, but there's more places 
>> that mistakenly learned to rely on the stray <linux/mm.h> inclusion, 
>> for example on x86 defconfig-ish kernels:
>>
>>
>>   In file included from drivers/gpu/drm/i915/gt/intel_ggtt.c:6:
>>   ./arch/x86/include/asm/set_memory.h:40:57: error: unknown type name ‘pgprot_t’
>>   40 | int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
>>   |                                                         ^~~~~~~~

This patch relies on patch 1 in this series, which removes
__set_memory_prot(). I seem to be able to build x86_64_defconfig without
issue with both patches applies on the latest mainline.

> BTW., I did a few touchups to the changelog (see below) - mind picking 
> that up once you submit -v2?

Very happy with the touchups, thanks for having a look! Given my comment
above, I don't believe there is a need to post a v3 - feel free to amend
the commit message when applying the patches.

- Kevin


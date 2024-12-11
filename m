Return-Path: <linux-kernel+bounces-440929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1479EC68E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01043286B65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41C1D7E35;
	Wed, 11 Dec 2024 08:06:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F181CF5CE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904372; cv=none; b=mbN5f5WYBajV9mxqhtdlpNT7Sty17YFkVxmd8y1ftVNYoIK9h9dUppRfl6MN2dnQj+TfHTNgQc3Du9YRkAQHFPxpjwlPwHL6ggV4fCBMkM7M/83Rj9W739e1FmrEksBSuJXI8JPtyXOYtPtGb72llh5VrxhBt/dswlKNl3T/k6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904372; c=relaxed/simple;
	bh=G6srZnesJyLh2HApBhx/PVLg8bcYkku9ZzWhwGguNEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auzw/eRzelJ07xA52ZXaaDzQaykH1qMRhLVKEu21Ky8LTghLMuQHtB3LRF48IPuH4qHbXE15OgA4DyoaAr8XQUL4tMpzM/GTTqk65koyGkixqPuynFMT4DyRRHRXV7D/bp7xjJGCrUiq9rJmP+VxD7NY7Bi59AfUoBMEiVzN6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061AD1063;
	Wed, 11 Dec 2024 00:06:36 -0800 (PST)
Received: from [10.57.70.51] (unknown [10.57.70.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C78303F720;
	Wed, 11 Dec 2024 00:06:05 -0800 (PST)
Message-ID: <c06157f3-08ac-4071-9410-82861bbf0fb5@arm.com>
Date: Wed, 11 Dec 2024 09:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/smp: Explicitly include <linux/thread_info.h>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, david@redhat.com, jane.chu@oracle.com,
 osalvador@suse.de, tglx@linutronix.de
References: <20241210184610.2080727-1-kevin.brodsky@arm.com>
 <20241210184610.2080727-2-kevin.brodsky@arm.com>
 <20241210213626.GNZ1i0WsS0XCoaoEY1@fat_crate.local>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241210213626.GNZ1i0WsS0XCoaoEY1@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2024 22:36, Borislav Petkov wrote:
> On Tue, Dec 10, 2024 at 06:46:07PM +0000, Kevin Brodsky wrote:
>> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
>> index ca073f40698f..88e72b414bfa 100644
>> --- a/arch/x86/include/asm/smp.h
>> +++ b/arch/x86/include/asm/smp.h
>> @@ -6,7 +6,7 @@
>>  
>>  #include <asm/cpumask.h>
>>  #include <asm/current.h>
>> -#include <asm/thread_info.h>
>> +#include <linux/thread_info.h>
> linux/ namespace headers come before asm/ ones, I'd say.

Oops, meant to move it but forgot, thanks!

> But, more importantly, why is this 4 patches instead of 2:
>
> 1. Remove unused __set_memory_prot
> 2. Fixup include hell

Totally fine by me. I wasn't sure that touching
drivers/virt/coco/sev-guest in the same patch as arch/x86 was ok, but
sounds like it is.

- Kevin


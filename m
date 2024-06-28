Return-Path: <linux-kernel+bounces-234252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE3F91C440
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C5CB210D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE611CB310;
	Fri, 28 Jun 2024 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="YmfqWxER"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA081E532
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593866; cv=none; b=j3UEexRdJXpDS6gnQjmfQJKs6awXVEEmt8SUOGBpKgmC0Eg78ZHbX30cMzywa3UC8aqE3RXe8jqwEk8k2QNYSQxs4l6FpgpsqZ7wSJxM8uKXjKG1GxOtie/xGB8Nkfw2e+VgMdrFZGjwwjMVC3FDJLsArrHi7UXTkpiV5HYE1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593866; c=relaxed/simple;
	bh=vq1lqtO2B4twNh3RMXFKKYkAgq3F2pc86OVJbHKxpCQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eXO02W8TVsbQ9onzgbM0eKxFnBv0zxcNeAXpkBMy+FwyiFLVxcEIkp9RTBdG5ITXkQ1tkOj8CRiLpIP1zViv6DoO+fnore/axACgj+uB8P3GRVCR2NZcHLgcgWn95rBwOCmgdZguOkFo8NZYx07b5UXfIOgquHMZ6aWfJGS+6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=YmfqWxER; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1719593857;
	bh=vq1lqtO2B4twNh3RMXFKKYkAgq3F2pc86OVJbHKxpCQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YmfqWxERyKWmhVqObJzlwqaUNaFEbLVvqXMeXtCa44tMIVc79tBlmNvs9LWSlXl9r
	 T/oNSYn0uDKsc3KRaelnreK06sKzSoQdXnXiF1t936SD9X/pNFVxVUTPRuczH8tcHK
	 kDRg65nXTRRq0iDlgRVEg1jAjlekx42+BtCMXiOM=
Received: by gentwo.org (Postfix, from userid 1003)
	id EA4D54037C; Fri, 28 Jun 2024 09:57:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E9588401D7;
	Fri, 28 Jun 2024 09:57:37 -0700 (PDT)
Date: Fri, 28 Jun 2024 09:57:37 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org, 
    anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <Zn7q3oL1AE8jdM-g@arm.com>
Message-ID: <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com> <Zn7q3oL1AE8jdM-g@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 28 Jun 2024, Catalin Marinas wrote:

> On Wed, Jun 26, 2024 at 12:18:30PM -0700, Yang Shi wrote:
>> @@ -568,6 +596,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>  	if (!vma)
>>  		goto lock_mmap;
>>
>> +	if ((vm_flags & VM_READ) && (vma->vm_flags & VM_WRITE) &&
>> +	    is_el0_atomic_instr(regs)) {
>> +		vm_flags = VM_WRITE;
>> +		mm_flags |= FAULT_FLAG_WRITE;
>> +	}
>
> The patch looks fine now and AFAICT there's no ABI change.
>
> However, before deciding whether to merge this patch, I'd like to
> understand why OpenJDK cannot use madvise(MADV_POPULATE_WRITE). This
> would be the portable (Linux) solution that works better on
> architectures without such atomic instructions (e.g. arm64 without LSE
> atomics). So fixing user-space would be my preferred solution.

Doing so would be requesting application code changes that are linux 
and ARM64 specific from applications running on Linux. A lot of these are 
proprietary.





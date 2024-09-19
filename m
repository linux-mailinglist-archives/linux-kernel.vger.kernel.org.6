Return-Path: <linux-kernel+bounces-333127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843A97C44E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587A21C2197E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99B18C356;
	Thu, 19 Sep 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oiu1YfpZ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EB2B9AD
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727260; cv=none; b=PCxSxx3MTO5iKIPSKTb03Bkb45fg0AcJJ9Tt/KKew7xRobbyJkiMJRBSVkT2mpfsbrX8XeosQzLX2WoOiA8EpMT1GO44XK9HXg3zxcnsxGAfMv1bg3OCZ5E7xoHxZ7mMRFKKsJyHLqoG6BQ79kyF1uAGIfGDcfhks0Fta9fwMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727260; c=relaxed/simple;
	bh=VsAwGOCinvik8Ne4fJTXEsZBmEGj0hzYoshW3MPoFYU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=B+dPaTW6FXJEtc/bRBQKqMRnxDJ7eRc42FjI1RDXbOgn5A82rLf2vd/a39qsM/W79o6ZwdUe6GiXELq3Ma9G1WFbFBejJftMzJ4c1r3M0FGNaclFLWw5P5xTupZdmi6SEZPSqxmNWICFDIDYAa5edLxrglQU12puqC0BlL0cK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oiu1YfpZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206f9b872b2so4371395ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726727258; x=1727332058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hj+1vqgujWOrqlQpkce2sq1h+JT76BLtBiXrr9bmsw=;
        b=Oiu1YfpZIWipVRKC6gKM9snNGxWo7xj+1VPSId15CdTIokuh+Jo+qMx5WXhA9+xpCq
         QFUW+9SyBXZ1QFiKpvUW+lwc0ghzglFHpQWgPcF++WBwXQEXa9b0GROqeWhraGQJU2UR
         eFL1hmhKm1wS5x/vcLAkhIELevEcVkjMsmKGDmZyOcRoAnxXtyTmAbmhPxQP7Wgxk2QM
         kLMgQv3HAYP7DJoGqlnIbc3tBKhLQHCexjwznzhKHfIUp7FIusj4F7L+9dmCIadAFfUY
         lKHlUTZxOZshdI0Vh7eFvQGeVUNhboVIgqGbZFLvGXzoW2Z+oRuio9MeNT1QWi3un2FJ
         zEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726727258; x=1727332058;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Hj+1vqgujWOrqlQpkce2sq1h+JT76BLtBiXrr9bmsw=;
        b=isfKLiZ85nzI6qrOwyBkbKY2LVBhl92DfYqhIPrp9Ywy3Wp8IXYNXMKRJZkInYY/G3
         w+30YrOB/HT26xnrwUXNz7LBZ5gnRWt+p4c/MbxVvRYFBpgWWwb7j3rrYWEv7WLwRemm
         a66aXh9/v+Qct+WZy5DOxgXgOF97Om6ROE8AAUO+ImubyXlmz/46Ry4RE9LZi4vFsBBi
         DeaIQ54oXd838H8/TMdFz6ceG6QjSN/R5GAKfdPOHJx42/rJxSPnDTzEKK5VmGdsx/R5
         jJ6ImUmXxMPwfxIN7C7JxeUbtfkN2zS01WHDkI7ZL5cC3w1rzaoovpgiCo5vCku5SCw0
         0hvg==
X-Forwarded-Encrypted: i=1; AJvYcCXNl8/eJ/E2npOgMNt3Riw4NdT8XSAFCwTGsZ/SoGzrMSFOYWE5q3Bpc1nCJKXNLVKKnDtp/uFl82IYaqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDQaqlvrsjD4Hf4gvJhBf/PheTKVpxd0bvadpPdkEDeipaoK6
	rutQ0ZaeNaRATD0Ah8OMvQoRKGnK2Pymfyq9o3RQBZV94WyB0RTUz1+abg==
X-Google-Smtp-Source: AGHT+IE50XMoZa4hBwRIz3mN6qx5JWjHTF23/FUJHa75WuBjbh10hAyGn2DW14ljgJyxa6XgGD0eSg==
X-Received: by 2002:a17:902:eb8a:b0:206:ca91:1dda with SMTP id d9443c01a7336-2076e39c56bmr305359875ad.17.1726727258556;
        Wed, 18 Sep 2024 23:27:38 -0700 (PDT)
Received: from dw-tp ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da793sm73443715ad.54.2024.09.18.23.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 23:27:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, Pavithra Prakash <pavrampu@linux.vnet.ibm.com>, Nirjhar Roy <nirjhar@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com
Subject: Re: [RFC v2 03/13] book3s64/hash: Remove kfence support temporarily
In-Reply-To: <d9d8703a-df24-47e3-bd0d-2ff5a6eae184@csgroup.eu>
Date: Thu, 19 Sep 2024 11:53:15 +0530
Message-ID: <87jzf8tb58.fsf@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com> <5f6809f3881d5929eedc33deac4847bf41a063b9.1726571179.git.ritesh.list@gmail.com> <d9d8703a-df24-47e3-bd0d-2ff5a6eae184@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 19/09/2024 à 04:56, Ritesh Harjani (IBM) a écrit :
>> Kfence on book3s Hash on pseries is anyways broken. It fails to boot
>> due to RMA size limitation. That is because, kfence with Hash uses
>> debug_pagealloc infrastructure. debug_pagealloc allocates linear map
>> for entire dram size instead of just kfence relevant objects.
>> This means for 16TB of DRAM it will require (16TB >> PAGE_SHIFT)
>> which is 256MB which is half of RMA region on P8.
>> crash kernel reserves 256MB and we also need 2048 * 16KB * 3 for
>> emergency stack and some more for paca allocations.
>> That means there is not enough memory for reserving the full linear map
>> in the RMA region, if the DRAM size is too big (>=16TB)
>> (The issue is seen above 8TB with crash kernel 256 MB reservation).
>> 
>> Now Kfence does not require linear memory map for entire DRAM.
>> It only needs for kfence objects. So this patch temporarily removes the
>> kfence functionality since debug_pagealloc code needs some refactoring.
>> We will bring in kfence on Hash support in later patches.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   arch/powerpc/include/asm/kfence.h     |  5 +++++
>>   arch/powerpc/mm/book3s64/hash_utils.c | 16 +++++++++++-----
>>   2 files changed, 16 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
>> index fab124ada1c7..f3a9476a71b3 100644
>> --- a/arch/powerpc/include/asm/kfence.h
>> +++ b/arch/powerpc/include/asm/kfence.h
>> @@ -10,6 +10,7 @@
>>   
>>   #include <linux/mm.h>
>>   #include <asm/pgtable.h>
>> +#include <asm/mmu.h>
>>   
>>   #ifdef CONFIG_PPC64_ELF_ABI_V1
>>   #define ARCH_FUNC_PREFIX "."
>> @@ -25,6 +26,10 @@ static inline void disable_kfence(void)
>>   
>>   static inline bool arch_kfence_init_pool(void)
>>   {
>> +#ifdef CONFIG_PPC64
>> +	if (!radix_enabled())
>
> No need for a #ifdef here, you can just do:
>
> 	if (IS_ENABLED(CONFIG_PPC64) && !radix_enabled())
> 		return false;
>
>

This special radix handling is anyway dropped in later pacthes. 
So I didn't bother changing it here.

>> +		return false;
>> +#endif
>>   	return !kfence_disabled;
>
> But why not just set kfence_disabled to true by calling disable_kfence() 
> from one of the powerpc init functions ?
>

This patch is only temporarily disabling kfence support for only Hash.
This special Hash handling gets removed in patch-10 which brings back
kfence support.

-ritesh


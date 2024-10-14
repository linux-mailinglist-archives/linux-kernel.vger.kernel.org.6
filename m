Return-Path: <linux-kernel+bounces-363983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A999C947
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99B81C228D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79B1A01B4;
	Mon, 14 Oct 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO867Weu"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961E19F104
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906397; cv=none; b=NxEAJLq6YP/Rv7jrOqN0/FZMnfMYYR8a0DgH5GaGEDedPBmrsgDvtZ1LPB3KFwFyfXTASvR1E5qfBqiCrqINdWRx6Jh3WMJVr6Nictf6i552C7DEJK18MhG+pb2MOHHTJSt63G87BxE1zFgHia1SPE2XVVOleYNTDGCx2Q/sM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906397; c=relaxed/simple;
	bh=C6sFmOvZgS6veMvi5bFfx1DTFkz5KDyV+BDRycxOS8k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=eT6LdrhHPyN6FRA6dQg3mKCQyp7nfQs/uB6iu1MGrYP6ZGNbHbbQSnr9+4qm2VO6OMRQFYXtxXJAMIGhUuZaVkbhrFRARY/x64vfbjnoZN2CjTsSoSZh3/bEJb2hHVKl+ymgz5M8oyFII25odAmMEcH6oX3wI2D3IGjy6LuVOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO867Weu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c803787abso27567015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728906394; x=1729511194; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWFh25nJyPJAANz+nHPv+XgVZ4oTsCk51SIBxPDCfHQ=;
        b=HO867WeuwBwSe50xK5tJMli2ofte9R0sHhCqB1xe++DT8RCVxuHfrI0XHjSqJ0Ei/p
         hou5hlvZoSiPcvob49PYV+eS6S99TfSWM9G3u00eSayMr/lfDV7GfFIUxA3+o67XHDsl
         jRCs6iQ5xP1U+HTFNV+1i8+4GLVqSpGwGLaf7d9vOXVp+XwOO52oayuQ/JGaMI81buD4
         AYNj5CAA+v/XvIalfeV3GpYVag1GRlgdifyfSihkE2R89y6icayE95K6NaEWpniRt/YX
         IUMD3R4645Qbuph42dLeoIIyS4PQ4QCQQ2YxZxw9NyvKw7ko3YrFG1bR8PPhT/J5MuBN
         rKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906394; x=1729511194;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWFh25nJyPJAANz+nHPv+XgVZ4oTsCk51SIBxPDCfHQ=;
        b=DvJWSPu5qedHD5q8jymC8XFfrnFqVmtRM+eJVQAtezqwmmXNiXU4MFaOVvq7Rtp/vW
         UbGFjR8bUVbdiHS6zI2G9KgwqXTVmjhdJofeCgWPktnFviKP1Y1r7En1kGT3qZjLtKcv
         QYu5By8ta61zLP1RnhE2m1I2qcGSK+JP6pz9zYy2MltufdDsN/gSKYqLgdi4nz2kK8RR
         e2bOnWhu1XhiK7DtdwVL0/smfi5qbz+dSNbUZKDVlsSM8NX2P3dp6W1Db4iGOzDICP4e
         AGrugeEAjdIQGOrPlEA7WGgJxS0CEP9nqEdVMgHOVTa4qE+MJHuCWXLS4nNatW+kDcsR
         +szg==
X-Forwarded-Encrypted: i=1; AJvYcCVCWa6bHFU8gqfJHup1Qvpv+kyozgbOfCqdpCRA76ahHyREH6KYuQMOsPgfQEuQpUoWpf0cBkGgcYjgxyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4YTjCTMRw6Mzp/nW41qspOKdxLtODrvLeTEDUGSENoWlMmal
	AcY6zpntMeYtbNM8Sbdhuln8zYtIYdzjrKJS7elts/6CuS1DiO9r
X-Google-Smtp-Source: AGHT+IEbzH2rLW7vX0++DAbmN0Cd8+5Z4OH+8mqkENfD5VLnA/+m5ohpTGDY/xnSU5tPiRMckODPdA==
X-Received: by 2002:a17:903:110e:b0:205:5d71:561e with SMTP id d9443c01a7336-20ca0402291mr172569595ad.26.1728906393559;
        Mon, 14 Oct 2024 04:46:33 -0700 (PDT)
Received: from dw-tp ([171.76.85.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb755sm64431045ad.134.2024.10.14.04.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:46:32 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
Subject: Re: [RFC v3 1/3] fadump: Refactor and prepare fadump_cma_init for late init
In-Reply-To: <941875f7-0d7f-4ba3-bc7c-7aedc3b20dae@linux.ibm.com>
Date: Mon, 14 Oct 2024 16:54:56 +0530
Message-ID: <87bjznyliv.fsf@gmail.com>
References: <030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com> <941875f7-0d7f-4ba3-bc7c-7aedc3b20dae@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Madhavan Srinivasan <maddy@linux.ibm.com> writes:

> On 10/11/24 8:30 PM, Ritesh Harjani (IBM) wrote:
>> We anyway don't use any return values from fadump_cma_init(). Since
>> fadump_reserve_mem() from where fadump_cma_init() gets called today,
>> already has the required checks.
>> This patch makes this function return type as void. Let's also handle
>> extra cases like return if fadump_supported is false or dump_active, so
>> that in later patches we can call fadump_cma_init() separately from
>> setup_arch().
>
> Usually patches to this file are posted with title format of
>
> powerpc/fadump:<>

yes. I guess it is good to do it that way (I might have missed it)
Although commit history of oldest few patches to fadump shows..

ebaeb5ae2437 fadump: Convert firmware-assisted cpu state dump data into elf notes.
2df173d9e85d fadump: Initialize elfcore header and add PT_LOAD program headers.
3ccc00a7e04f fadump: Register for firmware assisted dump.
eb39c8803d0e fadump: Reserve the memory for firmware assisted dump.

>
>
>> 
>> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>> v2 -> v3: Separated the series into 2 as discussed in v2.
>> [v2]: https://lore.kernel.org/linuxppc-dev/cover.1728585512.git.ritesh.list@gmail.com/
>> 
>>  arch/powerpc/kernel/fadump.c | 23 +++++++++--------------
>>  1 file changed, 9 insertions(+), 14 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index a612e7513a4f..162327d66982 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -78,27 +78,23 @@ static struct cma *fadump_cma;
>>   * But for some reason even if it fails we still have the memory reservation
>>   * with us and we can still continue doing fadump.
>>   */
>> -static int __init fadump_cma_init(void)
>> +static void __init fadump_cma_init(void)
>>  {
>>  	unsigned long long base, size;
>>  	int rc;
>> 
>> -	if (!fw_dump.fadump_enabled)
>> -		return 0;
>> -
>> +	if (!fw_dump.fadump_supported || !fw_dump.fadump_enabled ||
>> +			fw_dump.dump_active)
>> +		return;
>
> Is these checks even needed here? fadump_reserve_mem() checked for all
> these already, also dont see any other caller for fadump_cma_init(). 
>
>

In the next patch we will move fadump_cma_init() call from within
fadump_reserve_mem() to setup_arch(). Hence we need these extra checks
in fadump_cma_init() as well. I mentioned the same in the commit msg of
this patch too.

>>  	/*
>>  	 * Do not use CMA if user has provided fadump=nocma kernel parameter.
>> -	 * Return 1 to continue with fadump old behaviour.
>>  	 */
>> -	if (fw_dump.nocma)
>> -		return 1;
>> +	if (fw_dump.nocma || !fw_dump.boot_memory_size)
>> +		return;
>> 
>>  	base = fw_dump.reserve_dump_area_start;
>>  	size = fw_dump.boot_memory_size;
>> 
>> -	if (!size)
>> -		return 0;
>
> So this is the only place where we return 0, which in turn will make the
> "ret" in fadump_reserve_mem() as zero forcing to call reserve_crashkernel()
> in early_init_devtree().
>
> we are removing it, becos we know "size" here will never be zero?
>
>

yes. Because we already check if boot_memory_size is less than
bootmem_min in fadump_reserve_mem(). If it is less, then we fail and
disable fadump (fadump_enabled = 0).

So then there is no need to check for !boot_memory_size in here.

fadump_reseve_mem( ) {
<...>
	if (!fw_dump.dump_active) {
		fw_dump.boot_memory_size =
			PAGE_ALIGN(fadump_calculate_reserve_size());

		bootmem_min = fw_dump.ops->fadump_get_bootmem_min();
		if (fw_dump.boot_memory_size < bootmem_min) {
			pr_err("Can't enable fadump with boot memory size (0x%lx) less than 0x%llx\n",
			       fw_dump.boot_memory_size, bootmem_min);
			goto error_out;
		}
    <...>    
    }
<...>
error_out:
	fw_dump.fadump_enabled = 0;
	fw_dump.reserve_dump_area_size = 0;
	return 0;
}


Thanks for the review!
-ritesh


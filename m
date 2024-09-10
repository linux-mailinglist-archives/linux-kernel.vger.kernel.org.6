Return-Path: <linux-kernel+bounces-322540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BA972A85
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A661C215D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B517C7CE;
	Tue, 10 Sep 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="RKYF0GC4"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391217C21E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952946; cv=none; b=C8nA+SszvbXkAeBiH3faTzadXaoQbzXtRr2cU3C/Jt34Q/9wNYN96nbG3IzfdIpP1XrZ+syGbj52V03au1CtEmLBn95FLiDNPokGvPtu/tm4vrqqi7+XEWWsm4PQRwhyH7oc5Jh5E9TiHM0iE//peEjo73dOMKD5lW5QUCSOsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952946; c=relaxed/simple;
	bh=zlqmlYfJ7P8KlKn3UxXLTuIsoBdh8RIDWMa129G/Mzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dQkwUohjam9uEigKCw50E/Nmx2f2LNfM4H2s+GIlqZzg9RbNOpKJ2mPcRb1DSShEN2IUFm+7ODY1PQIBpJPcpM5eX6d9c0k8Fgoi7L9pkGICK9rIsvK1ag75ToZBuBwUj3xplAuNJRtX6ySrCHAJjREM6hQMd+tOQgEu76ZLEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=RKYF0GC4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725952941;
	bh=mNSuJkPjaGszk/6QjVxxo1sA0bso5AxEgAYw67M1VHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RKYF0GC40MtcKhbsq3tYIyHqWmB7ck2yxp2cpwDIkBNflR/gjzE7TYy4JbFxD6toO
	 4D6pWfc6vbTKpP2WO0a+Mi6PvOJ+KYQg6cQgZ+aHz0rnUi32Zja9SNutQ3JqIjN2v2
	 VVCjaJ5MBRsScVkGgEGbGzi1NUbWxvnRwe+jI2CzIXsKQwaseSYvI+txN1xsUsMh+c
	 wvDuhQWJ7/yQ4cfhYfKnKLMNKWXpYOHm0MHH2IU1gQ8glsckvHcGKprry3DOzKcMHi
	 5Mpar3Iz5dODy6ceALimYjqpsZi+X4mhMi4WZjFvnTC+EtYe+oIzOx9XuvN5ojQrIa
	 CejW5FQW6JY4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2wBj3xcfz4x3p;
	Tue, 10 Sep 2024 17:22:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
In-Reply-To: <66e3558d-a9a6-4caa-9102-7c22a695acda@linux.ibm.com>
References: <20240823151158.92602-1-nnmlinux@linux.ibm.com>
 <877cbq5k1y.fsf@mail.lhotse>
 <66e3558d-a9a6-4caa-9102-7c22a695acda@linux.ibm.com>
Date: Tue, 10 Sep 2024 17:22:21 +1000
Message-ID: <878qw0rn0y.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Narayana Murty N <nnmlinux@linux.ibm.com> writes:
> On 05/09/24 6:33 PM, Michael Ellerman wrote:
>> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
>>> VFIO_EEH_PE_INJECT_ERR ioctl is currently failing on pseries
>>> due to missing implementation of err_inject eeh_ops for pseries.
>>> This patch implements pseries_eeh_err_inject in eeh_ops/pseries
>>> eeh_ops. Implements support for injecting MMIO load/store error
>>> for testing from user space.
>>>
>>> The check on PCI error type code is moved to platform code, since
>>> the eeh_pe_inject_err can be allowed to more error types depending
>>> on platform requirement.
>>>
>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>> ---
>>>
>>> Testing:
>>> ========
>>> vfio-test [1] by Alex Willamson, was forked and updated to add
>>> support inject error on pSeries guest and used to test this
>>> patch[2].
>>>
>>> References:
>>> ===========
>>> [1] https://github.com/awilliam/tests
>>> [2] https://github.com/nnmwebmin/vfio-ppc-tests/tree/vfio-ppc-ex
>>>
>>> ================
>>> Changelog:
>>> V1:https://lore.kernel.org/all/20240822082713.529982-1-nnmlinux@linux.ibm.com/
>>> - Resolved build issues for ppc64|le_defconfig by moving the
>>> pseries_eeh_err_inject() definition outside of the CONFIG_PCI_IOV
>>> code block.
>>> - New eeh_pe_inject_mmio_error wrapper function added to avoid
>>> CONFIG_EEH is not set.
>>   
>> I don't see why that's necessary?
>>
>> It's only called from eeh_pseries.c, which is only built for
>> PPC_PSERIES, and when PPC_PSERIES=y, EEH is always enabled.
>>
>>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>> index 91a9fd53254f..8da6b047a4fe 100644
>>> --- a/arch/powerpc/include/asm/eeh.h
>>> +++ b/arch/powerpc/include/asm/eeh.h
>>> @@ -308,7 +308,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
>>>   int eeh_pe_configure(struct eeh_pe *pe);
>>>   int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>>   		      unsigned long addr, unsigned long mask);
>>> -
>>> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
>>>   /**
>>>    * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>>>    *
>>> @@ -338,6 +338,10 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
>>>   	return 0;
>>>   }
>>>   
>>> +static inline int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
>>> +{
>>> +	return -ENXIO;
>>> +}
>>>   #define eeh_dev_check_failure(x) (0)
>>>   
>>>   static inline void eeh_addr_cache_init(void) { }
>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>> index d03f17987fca..49ab11a287a3 100644
>>> --- a/arch/powerpc/kernel/eeh.c
>>> +++ b/arch/powerpc/kernel/eeh.c
>>> @@ -1537,10 +1537,6 @@ int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>>   	if (!eeh_ops || !eeh_ops->err_inject)
>>>   		return -ENOENT;
>>>   
>>> -	/* Check on PCI error type */
>>> -	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>>> -		return -EINVAL;
>>> -
>>   
>> The change log should mention why it's OK to remove these checks. You
>> add the same checks in pseries_eeh_err_inject(), but what about
>> pnv_eeh_err_inject() ?
>>
>> It is OK AFAICS, because pnv_eeh_err_inject() already contains
>> equivalent checks, but you should spell that out.
>>
>> cheers
>
> yes mpe. I do agree, your comments are addressed in V3 posted
>
> here 
> https://lore.kernel.org/all/20240909140220.529333-1-nnmlinux@linux.ibm.com/

Thanks.

cheers


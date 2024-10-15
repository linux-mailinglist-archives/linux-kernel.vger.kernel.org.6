Return-Path: <linux-kernel+bounces-365347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD0F99E0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7AC1B25854
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F91CACEE;
	Tue, 15 Oct 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7Ha/56m"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A91C8FC6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980541; cv=none; b=ugsTifqQoUUgsNjklT0qcQNnInOk/zn0mR56KEfYFn0kfbIwmp/+qzaHOMO/jy24KO2hVEd1EaDmtU1NTEA3KpX2ui1BXUZvJLHdWVnamVNWQWqAtW0Jtk+6FqO9iG8uc/OFy3v/dYWm5U5Xfv0QymUiTSwaZvhrTILS3F1ORZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980541; c=relaxed/simple;
	bh=j2BBpEnHVg0tM+af4TyVuB8eDrqeZKNjZynmL05nmrA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=RU4h9/wlkksG+AgbFjtofCBvk5nYvQoq9cauySirryyMsWLNHBq25fGnH24MXLQzVCt6vrGR1iAz9k/5j7EopPH1Tbf9bTVUigCqzHp+8QEeS+sfWT0XoeDIJY2jSwuBcLwHz/aujVkhl0M6IAULaJ+BSRFvU9DqoPdi/tSf1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7Ha/56m; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20caccadbeeso36958715ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728980540; x=1729585340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSbjcDDQQ4bzhuGeYvy25HeVmQJUWahcI9kmdF2A54o=;
        b=b7Ha/56mUJ0eH1fmUE85zpzyXd5cXXzESzVzV7+2Ry0oLB/UabjxjKPKTaE4rLFFwk
         4BOfZBJumP6asirkLcMgiFHtdp8FfyGUUoAPWLo+DU0GSP+Rp67v5sD7w6AG8zdrqHNs
         Qx7SFdliudPITMW487OiKUjYvgLMIYEucV1JQ9uZjrVD6lVzLdBcB9HUiPFofCGLF/1F
         Ua5j+gXibQMSc5ShhMI8h4eGPTucQx2Wx1RzYFDIRfqzAzKmJq6PDFBUuwxO/WlgXPQx
         S52PXTiPKhXu6g/t4RPSQhhmeuXgrdHeIuZ1L2TbNrHtZp9gGsga4pSg0F2sYTr0B3v+
         Ddsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980540; x=1729585340;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSbjcDDQQ4bzhuGeYvy25HeVmQJUWahcI9kmdF2A54o=;
        b=dYXUL9ElzjyzL6DpTtTKBGg4o/i5JFP+9PKx0H6cccaXITO9A2BCC+DfV5UIDpbM9m
         4nofrExPe0Kpy/Zy4f9B8Y66W16qwlfNr5Gi44nmgE4sJmgvtEsXc0nKGS/XnDK2aHc1
         aMByQ5JhafgPUoy8utvYWB8RlEm8LFFsOVnf5jItaifIjWDssrEF2RHd3+WuSMOVjiyo
         iaiiZx/96ROijTRDco0iTt4MK9pl4+ecZ3Re4bB3964Cvd8jeWuGM4s51l0pZddI+1s3
         RSDLnVjC2gTbwsFRriRKfwmZMWvr85SNDG9yk16nsoKBOKg7M5fI0+kqJNQXsHALGDtq
         eQaA==
X-Forwarded-Encrypted: i=1; AJvYcCWob1NXx0/vs/iGg0EjicRpnMtHpIQ1qtQZHR8/OAetG2UDyJBzq30Pt6EHnXpHOCwa3nqG38L73VUl0po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6foax0C4i2mmWFFvpurNhlgw8ALBYp38x+l3G/ZhadfNfIh+r
	9W2MNVNI1kZGURMPkNCVLeJNE6ZVK2LDZ8XYgQSEgExPzrTTyzW1
X-Google-Smtp-Source: AGHT+IHa2gX9C4jAt0fiNSJu1J2m6zAiD1t3r4LEmOIsmYCZ5gXCIMP/YN4CTViiCc9odAQA4YjWww==
X-Received: by 2002:a17:902:e5ca:b0:20c:805a:524 with SMTP id d9443c01a7336-20ca16be1b7mr170171755ad.39.1728980539523;
        Tue, 15 Oct 2024 01:22:19 -0700 (PDT)
Received: from dw-tp ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17fa48b9sm7087565ad.85.2024.10.15.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:22:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, Heiko Carstens <hca@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, Pavithra Prakash <pavrampu@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFC RESEND v2 02/13] powerpc: mm: Fix kfence page fault reporting
In-Reply-To: <660a2cf7-24f9-4558-87df-5e4c13362380@csgroup.eu>
Date: Tue, 15 Oct 2024 13:49:46 +0530
Message-ID: <877ca9zskd.fsf@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com> <6bf523aa03e72d701d24aca49b51864331eed2d5.1728954719.git.ritesh.list@gmail.com> <660a2cf7-24f9-4558-87df-5e4c13362380@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 15/10/2024 à 03:33, Ritesh Harjani (IBM) a écrit :
>> copy_from_kernel_nofault() can be called when doing read of /proc/kcore.
>> /proc/kcore can have some unmapped kfence objects which when read via
>> copy_from_kernel_nofault() can cause page faults. Since *_nofault()
>> functions define their own fixup table for handling fault, use that
>> instead of asking kfence to handle such faults.
>> 
>> Hence we search the exception tables for the nip which generated the
>> fault. If there is an entry then we let the fixup table handler handle the
>> page fault by returning an error from within ___do_page_fault().
>> 
>> This can be easily triggered if someone tries to do dd from /proc/kcore.
>> dd if=/proc/kcore of=/dev/null bs=1M
>> 
>> <some example false negatives>
>> ===============================
>> BUG: KFENCE: invalid read in copy_from_kernel_nofault+0xb0/0x1c8
>> Invalid read at 0x000000004f749d2e:
>>   copy_from_kernel_nofault+0xb0/0x1c8
>>   0xc0000000057f7950
>>   read_kcore_iter+0x41c/0x9ac
>>   proc_reg_read_iter+0xe4/0x16c
>>   vfs_read+0x2e4/0x3b0
>>   ksys_read+0x88/0x154
>>   system_call_exception+0x124/0x340
>>   system_call_common+0x160/0x2c4
>> 
>> BUG: KFENCE: use-after-free read in copy_from_kernel_nofault+0xb0/0x1c8
>> Use-after-free read at 0x000000008fbb08ad (in kfence-#0):
>>   copy_from_kernel_nofault+0xb0/0x1c8
>>   0xc0000000057f7950
>>   read_kcore_iter+0x41c/0x9ac
>>   proc_reg_read_iter+0xe4/0x16c
>>   vfs_read+0x2e4/0x3b0
>>   ksys_read+0x88/0x154
>>   system_call_exception+0x124/0x340
>>   system_call_common+0x160/0x2c4
>> 
>> Guessing the fix should go back to when we first got kfence on PPC32.
>> 
>> Fixes: 90cbac0e995d ("powerpc: Enable KFENCE for PPC32")
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   arch/powerpc/mm/fault.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 81c77ddce2e3..fa825198f29f 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -439,9 +439,17 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>>   	/*
>>   	 * The kernel should never take an execute fault nor should it
>>   	 * take a page fault to a kernel address or a page fault to a user
>> -	 * address outside of dedicated places
>> +	 * address outside of dedicated places.
>> +	 *
>> +	 * Rather than kfence reporting false negatives, let the fixup table
>> +	 * handler handle the page fault by returning SIGSEGV, if the fault
>> +	 * has come from functions like copy_from_kernel_nofault().
>>   	 */
>>   	if (unlikely(!is_user && bad_kernel_fault(regs, error_code, address, is_write))) {
>> +
>> +		if (search_exception_tables(instruction_pointer(regs)))
>> +			return SIGSEGV;
>
> This is a heavy operation. It should at least be done only when KFENCE 
> is built-in.
>
> kfence_handle_page_fault() bails out immediately when 
> is_kfence_address() returns false, and is_kfence_address() returns 
> always false when KFENCE is not built-in.
>
> So you could check that before calling the heavy weight 
> search_exception_tables().
>
> 		if (is_kfence_address(address) &&
> 		    !search_exception_tables(instruction_pointer(regs)) &&
> 		    kfence_handle_page_fault(address, is_write, regs))
> 			return 0;
>

Yes, thanks for the input. I agree with above. I will take that in v3.
I will wait for sometime for any review comments on other patches before
spinning a v3, though.

>
>
>  > +			return SIGSEGV;
>
>> +
>>   		if (kfence_handle_page_fault(address, is_write, regs))
>>   			return 0;
>>   

-ritesh


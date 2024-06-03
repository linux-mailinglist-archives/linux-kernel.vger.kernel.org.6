Return-Path: <linux-kernel+bounces-199722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FD68D8B51
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFAE1F24404
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E898713B5A6;
	Mon,  3 Jun 2024 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2e4kRq+"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E225601
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449177; cv=none; b=smJhLQkzOImYqKb2RRI/d9S1Gvi7itAflx8cIFE6z+zdgqEJIDzj3WGbcsjlCTR62UxjHludpPGnoqM6Gk1ewzeVIILVvWjGlrNtyklOFi9lSU5Pey7Klcw9HI1QfPGdcc2NbINcMcOFkiXch2bqSrFspaiMKtg6dzJleUfu5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449177; c=relaxed/simple;
	bh=Ma2G1XUY+OMiYrLLXyxX+9ZtaW+ETGjLX3E9Ph3uSks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxIHyKmvPekCTSzoMuxDywIMTgFnNb08WuaqWq1D/8ZA/aDL6jgIEff+bHeYTUfDvEVYZ5Elbz7voc6wFcvxeDkkuZ2pEhVzCeUWhe3yC8+Aq89HfyLhiW+B0PNMubDMO7CuAcTdb9RMTVwPp7VxQH8Hy2yb17Rh8Lq14QIFmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2e4kRq+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4213485697fso23590665e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717449174; x=1718053974; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB2BDnYwWYgmg1wgRjgteD5ghAK6/IehyECeOgz8gPU=;
        b=B2e4kRq+EgyHya9lgygS3nIBN2jMfM/Zbnd5Z5ltLrYcG2GlISNDVeVN17clYtZHCa
         JJRqMIArumdHlJ998rXdk91TPcXzHJ7CJ8Kr4Jid2gIKix/4KyF5ZHQNxkprHb7Xz3n0
         wV7f0b2O8rcc1L3mUs+InYYbEyiEB2Ab/ZiX8pk1g5viQJ1f4c2d8HBrPQkDsM553FKV
         e4AhjLmyggLDGXhUX7umYEzpkNVSkPdRblp91qRuhlBMeW6H1ohAmnOajFlAXg2LoMsQ
         1nOqmkaj++EFGweEuWlFYYzO7whVtXEaU9XP8gxZpzp0uo91euYH0VQGdxCAto+OVeKM
         59hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717449174; x=1718053974;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PB2BDnYwWYgmg1wgRjgteD5ghAK6/IehyECeOgz8gPU=;
        b=e2V8tMQFJaOlWfNCPyUxM8cVkTTo+V9r7xrSX8CLFP26BpZONO/kOmBHC6n3eREgbV
         6PxQ70GXLhEANmCuJM6toEQNvwcuADrJ54oAJKS/vuhIw3/Uqki+v/mfXobzApVjp1up
         bu6unYWQIDtXw1Kz6uod185MJiKepOQbBDQy9JS3SyNh+dx9CYPMfCRiibYt8muT/AXL
         AeiI8MMd7H4Mnj3Oo9LhB/2qyZk67ltDLiuBgv2mPVM50mXSy2NN2fH/bWmh0my/7Hlk
         NCTTtV/WSDPE1Hdn7PrJsn5ji6XuRiicZvhNzYZRG6ePlvwc+B0WzEV/0kANZBVtO/40
         cfbA==
X-Forwarded-Encrypted: i=1; AJvYcCVIqf35DgQFHnL6FK0w9aLFhQD/uTtl6lmEMZHLKuOv+/3ONEZLAfNIfOMVRkKLl8VB54znT6Y3tw5pb7eHwUN6k6EaNVUBLqLnnqMX
X-Gm-Message-State: AOJu0YzhS+Q7BecvXm++WcZyhtXdjBYCnX2O66g58jePVKCvvJcZeCkG
	AiHk8gIqHlq29c6aufoUr/vXvXxfnvcrdhEFRtPvS8Lc6we98CLk
X-Google-Smtp-Source: AGHT+IE2Y+SempoAvOfyCcHhR1wRYb2Sw5aqYx+0WauKtMkawcxWBTuVsMP3NeENU001Q8VYMsFijw==
X-Received: by 2002:a05:600c:4713:b0:41b:b07a:c54c with SMTP id 5b1f17b1804b1-4212e049943mr74431125e9.9.1717449173499;
        Mon, 03 Jun 2024 14:12:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a515bcb0dsm3955762a12.82.2024.06.03.14.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2024 14:12:53 -0700 (PDT)
Date: Mon, 3 Jun 2024 21:12:52 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [Patch v3] x86/head/64: remove redundant check on
 level2_kernel_pgt's _PAGE_PRESENT bit
Message-ID: <20240603211252.6jsxxo5dn5xbd6q2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240523123539.14260-1-richard.weiyang@gmail.com>
 <9e9669a6-de37-4140-bdc5-7d660b8427c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9669a6-de37-4140-bdc5-7d660b8427c3@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jun 03, 2024 at 11:50:06AM -0700, Dave Hansen wrote:
>On 5/23/24 05:35, Wei Yang wrote:
>> --- a/arch/x86/kernel/head64.c
>> +++ b/arch/x86/kernel/head64.c
>> @@ -260,8 +260,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>>  
>>  	/* fixup pages that are part of the kernel image */
>>  	for (; i <= pmd_index((unsigned long)_end); i++)
>> -		if (pmd[i] & _PAGE_PRESENT)
>> -			pmd[i] += load_delta;
>> +		pmd[i] += load_delta;
>
>So, I think this is correct.  But, man, I wish folks would go through
>the git history and make it clear that they understand _how_ thecode
>got the way it is.
>

Dave

Thanks for your comment.

In my first version, it lists the historical change, while Thomas thought they
are not relevant. So I remove those descriptions.

https://lkml.org/lkml/2024/3/23/350

>I suspect that the original _PAGE_PRESENT check wasn't even necessary if
>cleanup_highmap() really did fix things up.  But this commit:
>
>	2aa85f246c18 ("x86/boot/64: Make level2_kernel_pgt pages invalid
>		       outside kernel area")
>
>tweaked things to actively clear out PMDs that weren't populated in
>Kirill's original loop.  It didn't touch the _PAGE_PRESENT check.  But
>it certainly did imply that the PMD doesn't have any holes in it and
>there's nothing int he middle that needs _PAGE_PRESENT cleared.
>

As I mentioned in my first version, the original code is introduced by

	commit 1ab60e0f72f7 ("[PATCH] x86-64: Relocatable Kernel Support")

The reason for the check on _PAGE_PRESENT is at that moment, level2_kernel_pgt
is defined as:

NEXT_PAGE(level2_kernel_pgt)
	/* 40MB kernel mapping. The kernel code cannot be bigger than that.
	   When you change this change KERNEL_TEXT_SIZE in page.h too. */
	/* (2^48-(2*1024*1024*1024)-((2^39)*511)-((2^30)*510)) = 0 */
	PMDS(0x0000000000000000, __PAGE_KERNEL_LARGE_EXEC|_PAGE_GLOBAL,
		KERNEL_TEXT_SIZE/PMD_SIZE)
	/* Module mapping starts here */
	.fill	(PTRS_PER_PMD - (KERNEL_TEXT_SIZE/PMD_SIZE)),8,0

While now, it looks like this:

SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
	/*
	 * Kernel high mapping.
	 *
	 * The kernel code+data+bss must be located below KERNEL_IMAGE_SIZE in
	 * virtual address space, which is 1 GiB if RANDOMIZE_BASE is enabled,
	 * 512 MiB otherwise.
	 *
	 * (NOTE: after that starts the module area, see MODULES_VADDR.)
	 *
	 * This table is eventually used by the kernel during normal runtime.
	 * Care must be taken to clear out undesired bits later, like _PAGE_RW
	 * or _PAGE_GLOBAL in some cases.
	 */
	PMDS(0, __PAGE_KERNEL_LARGE_EXEC, KERNEL_IMAGE_SIZE/PMD_SIZE)
SYM_DATA_END(level2_kernel_pgt)

The difference is at the original version, level2_kernel_pgt is not all
defined with _PAGE_PRESENT set. I didn't dig into from which commit we expand
the level2_kernel_pgt to full, while I think from that point, the check is
redundant.

>> level2_kernel_pgt compiled with _PAGE_PRESENT set. The check is
>> redundant
>
>This isn't super reassuring.  It also depends on nothing having munged
>the page tables up to this point.  The code is also a bit cruel in that
>it manipulates two different sets of PMDs with the same 'pmd' variable.
>
>Also, is this comment still accurate after '2aa85f246c18'?
>
>>          * Fixup the kernel text+data virtual addresses. Note that
>>          * we might write invalid pmds, when the kernel is relocated
>>          * cleanup_highmap() fixes this up along with the mappings
>>          * beyond _end.

Sounds this is not necessary any more. Do you prefer to remove this in next
version of this patch.

-- 
Wei Yang
Help you, Help me


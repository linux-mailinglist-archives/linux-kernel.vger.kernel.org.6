Return-Path: <linux-kernel+bounces-187388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5218CD10F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45660B20B56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3870614532A;
	Thu, 23 May 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EXzYVgM2"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30A146D57
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462903; cv=none; b=FGAQGHxiHNRdssdkN4E03fM+hvbc5Y6pwA55r6Js5hGER9rgWHyyucqPv67aMwSinGJ/7LNouCHqn+iuGc2u7MTWRacoZdRisSOrC0dw14zlcqnfm8Wtlea5uX58/8hLsUa/e3X61Tiogr584LfcMKQx57J8LzWE18cC5q2STec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462903; c=relaxed/simple;
	bh=MjVo/eyrnuH6STcT0XBgYYwy3sYTeprnDpyicAGfwZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tX0hgaUNGSJ2mpsop1EVPACA27cOEWNTOhWnK0uupqlJgAK0r3VXlVgLvj6Q97f4/GrtW/ay6q7JeD9ItyOFHQVRD7EUVz/f/yAePjON5+1u6Gej5b2CCOaozSZfwo1vBVeSTwwnoIgb1XaAvlNnrdvOrLAVQywKXSQsMtKrodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EXzYVgM2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b49162aeso1081876166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716462899; x=1717067699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtKXA649o7axDsK/ROjvUoC2ReIR2cQm65oTtJ1nt2A=;
        b=EXzYVgM2AoXZws4fe2uG+zS+0H62SYbKKo1mmAzO5+IplutbKvWfziRoJdZSKrrmBY
         mCJBErmlAt9noj/xs4uKWMxJ/vCDcsXfQzkWOz25z9pRwDL29jb9yOFOv2QvUbkwvlQ3
         4b4Kxc0qfxed9KelVY/KqJSAbZCyp7hyE0uDR1Lh9ntJ3r66bbtyncXnNjXkzxSHV9W9
         8miDz68o5jQCprw4C7RO6xAsR/fQa6U1mBI9L5RzaTMHvSyAGhnM+CJM+sn+UNZFJ9MG
         Fucpo+73rDwNu/sRWmzDZbbGgBJM0LOq7ntiROYxVODZqeImj5HP29l+b2IAOOJuN2At
         aRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716462899; x=1717067699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtKXA649o7axDsK/ROjvUoC2ReIR2cQm65oTtJ1nt2A=;
        b=NTcEAn4N8hK+XMuWmprrUFEvRYwHFgCYg+RCXHPKaHK5AH4yW8FFvZqHfOLQzxXwzS
         gSNuHOUi/JTn3LoQSxNKLRnaapBF/QdBlgwXf0bOaatbcqdgYO8GE++P1eJ6CdvhovYc
         1BXaqbHKo6BP2k3KDFViLNz99Y3Ci5VOejhAlnevFlSq9bmAQ4hXnU3VVXaQ2YzT2lXV
         aPlvfZxbmwDOemvoj/3LrvgyUi2PocAqo3eo4IzMwDzGfacfMyKLcAjOpPm07yUSnsn9
         T7fNMgQoH/z3QQVG7FzmiimeNtuLoyYvkHElVktj1HKaEPksRW/AACHVOqebRxJ4Byrf
         zCNg==
X-Forwarded-Encrypted: i=1; AJvYcCWqm7eJHXWFWsMdh6+PDXVMzqHUj9RnPzsSeVplkWP9kRzZnYZ8yIFDoBJp4bySPXU4TD3LzMMR3lhFfLDNBbM334be6hElOCKSmrdX
X-Gm-Message-State: AOJu0YzsE3sbaW4p9L4qo8xipSdnyL/0rvYEiFnZvIpMYJWqbRbUJTtg
	ne2Cc6vWVXhif8xKdlxpeNe0VHJLbbPu0jL7qpU+tdW12N5wzm0jTyxS37gu5/A=
X-Google-Smtp-Source: AGHT+IH8kFY8rnlFGYmC1IyNleX9IUJz34fSkhfP4YLpOOf86I+4CNUwuE5ftnmPQ5fKbfnvGIn0mA==
X-Received: by 2002:a17:906:815:b0:a5c:d67a:1e17 with SMTP id a640c23a62f3a-a6228069387mr282410766b.15.1716462899500;
        Thu, 23 May 2024 04:14:59 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:e681:bab5:4646:cf21? ([2a10:bac0:b000:7315:e681:bab5:4646:cf21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7f78sm1911564766b.133.2024.05.23.04.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 04:14:59 -0700 (PDT)
Message-ID: <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
Date: Thu, 23 May 2024 14:14:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-35802: x86/sev: Fix position dependent variable
 references in startup code
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2024051738-CVE-2024-35802-959d@gregkh>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <2024051738-CVE-2024-35802-959d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17.05.24 г. 16:23 ч., Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> x86/sev: Fix position dependent variable references in startup code
> 
> The early startup code executes from a 1:1 mapping of memory, which
> differs from the mapping that the code was linked and/or relocated to
> run at. The latter mapping is not active yet at this point, and so
> symbol references that rely on it will fault.
> 
> Given that the core kernel is built without -fPIC, symbol references are
> typically emitted as absolute, and so any such references occuring in
> the early startup code will therefore crash the kernel.
> 
> While an attempt was made to work around this for the early SEV/SME
> startup code, by forcing RIP-relative addressing for certain global
> SEV/SME variables via inline assembly (see snp_cpuid_get_table() for
> example), RIP-relative addressing must be pervasively enforced for
> SEV/SME global variables when accessed prior to page table fixups.
> 
> __startup_64() already handles this issue for select non-SEV/SME global
> variables using fixup_pointer(), which adjusts the pointer relative to a
> `physaddr` argument. To avoid having to pass around this `physaddr`
> argument across all functions needing to apply pointer fixups, introduce
> a macro RIP_RELATIVE_REF() which generates a RIP-relative reference to
> a given global variable. It is used where necessary to force
> RIP-relative accesses to global variables.
> 
> For backporting purposes, this patch makes no attempt at cleaning up
> other occurrences of this pattern, involving either inline asm or
> fixup_pointer(). Those will be addressed later.
> 
>    [ bp: Call it "rip_rel_ref" everywhere like other code shortens
>      "rIP-relative reference" and make the asm wrapper __always_inline. ]
> 
> The Linux kernel CVE team has assigned CVE-2024-35802 to this issue.


I'd like to dispute this CVE since it doesn't constitute a security 
related bug. Sure, it might crash a SEV guest during boot but it doesn't 
constitute a security issue per-se.



> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 6.1.84 with commit fe272b61506b
> 	Fixed in 6.6.24 with commit 0982fd6bf0b8
> 	Fixed in 6.7.12 with commit 66fa3fcb474b
> 	Fixed in 6.8.3 with commit 954a4a878144
> 	Fixed in 6.9 with commit 1c811d403afd
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-35802
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	arch/x86/coco/core.c
> 	arch/x86/include/asm/asm.h
> 	arch/x86/include/asm/coco.h
> 	arch/x86/include/asm/mem_encrypt.h
> 	arch/x86/kernel/sev-shared.c
> 	arch/x86/kernel/sev.c
> 	arch/x86/mm/mem_encrypt_identity.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/fe272b61506bb1534922ef07aa165fd3c37a6a90
> 	https://git.kernel.org/stable/c/0982fd6bf0b822876f2e93ec782c4c28a3f85535
> 	https://git.kernel.org/stable/c/66fa3fcb474b2b892fe42d455a6f7ec5aaa98fb9
> 	https://git.kernel.org/stable/c/954a4a87814465ad61cc97c1cd3de1525baaaf07
> 	https://git.kernel.org/stable/c/1c811d403afd73f04bde82b83b24c754011bd0e8


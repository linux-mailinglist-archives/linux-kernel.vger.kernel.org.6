Return-Path: <linux-kernel+bounces-356821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD86996730
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CADAB25FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD8190045;
	Wed,  9 Oct 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="b/lq8ctz"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7B18FDBA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469466; cv=none; b=Ik/Syvg/+4RcumNOiV7DTgQcLXnpwzq4XG1A1tsKGP263VFJ5Vh2zFJ9lguQB4e9T33xK7WS9sgkmEww+y/664BPgQTc0DSG4tjewW6WH8DUCO+N5qvePqWGyVl0kGayXbo28uh1Re/vtf+RFcd00US59x7TRfdQIuPRpGtZiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469466; c=relaxed/simple;
	bh=2o/UYiTxGQLpj2U3as30EOp17edcJJEmw9LgXaiqd/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9p4wU3ST6pPIW95fOWJzK4knuY9oNFogc225a4vqklZyJiYEshJaceQDXeWHwGePs2dgxNogtx0hdlVPasMuENKzVjYeIZS3pAC6WF1IpK5RkMCvduKiR9aDeQ2e/lCfNgujmWKbJr3YiRBs6tpAdGSWY0I6xhiaR0jES+OrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=b/lq8ctz; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so9612611a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1728469463; x=1729074263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hm6bUgP58uGQ8bcfYdstOCga9CnzXMRzGE3Fg5u58k0=;
        b=b/lq8ctzRRCuuXsU/F5p5w6gj/MKCSFB+YzsltaX0H5PIafxQXryfxRAQiTCFyZFIk
         0wYSTu7s/Apuzk7Qs/0QtFO1b/OPHFaq/WDzvXX3dbXA+dOf4tB8zkuqrVcmlNL3xpLY
         jgNm2xOv6kXneOSj5CS7/1NxvmUAvWOvOL72M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728469463; x=1729074263;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm6bUgP58uGQ8bcfYdstOCga9CnzXMRzGE3Fg5u58k0=;
        b=SG9ICX089wkx8prrUB0gBhbDDyZQ9AeOKe5ERxVUN69yYkDAWZ6Cbakf0wj+urCq0o
         73jKZyg16KHLxEvShyBAkvO+cV2ZNdtDjlxh97pYXAxgAgJ3yhnEZIkcf/t3OwfdeIZg
         zKwc9rzJgDrabskiB26MVOl90MDR6Fmjw/TeprYjschvWaArl0Qb/1RzelZENuHXJK+K
         PkRlexsE+0sNlZ4Aj3O9qSL7NSMymx/0qO2+tVoxS2e4jdvBx1uZ6qB/8MjgVhLfFNdn
         xtYjnmqfiBaVmt+H41428/weLY5FWIC0egM5LR4GdywPYpsO2du3IlhDWlIekYlmcztS
         tOZQ==
X-Gm-Message-State: AOJu0YwewiBZw/cuFIaGTwbDjIhELr/9MJ2Rlco6cC8kcArzoVjoX1vK
	ESVikzR2dIWzQlQoFshBqANKZxRHm6GGidz9CHcdep+Mccmdiq1XfoZkiSaOaH0=
X-Google-Smtp-Source: AGHT+IEkqPqSA1NCUyjbtMkJ1oudiGimJKbkwCGCVqyQlXN0d/rqnML3tRfXMYSsb7MZT5vpiwEssw==
X-Received: by 2002:a05:6402:2546:b0:5c5:c060:420d with SMTP id 4fb4d7f45d1cf-5c91d6faac3mr1429230a12.25.1728469462818;
        Wed, 09 Oct 2024 03:24:22 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c927e4403asm404944a12.51.2024.10.09.03.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 03:24:22 -0700 (PDT)
Message-ID: <efa42b69-13ba-40ed-99e2-431220d7dcb3@citrix.com>
Date: Wed, 9 Oct 2024 11:24:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/bugs: Use code segment selector for VERW
 operand
To: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Robert Gill <rtgill82@gmail.com>, stable@vger.kernel.org,
 #@tip-bot2.tec.linutronix.de, 5.10+@tip-bot2.tec.linutronix.de,
 Dave Hansen <dave.hansen@linux.intel.com>, Brian Gerst <brgerst@gmail.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org
References: <172842753652.1442.15253433006014560776.tip-bot2@tip-bot2>
 <20241009061102.GBZwYediMceBEfSEFo@fat_crate.local>
 <20241009073437.GG17263@noisy.programming.kicks-ass.net>
 <20241009093257.GDZwZNyfIjw0lTZJqL@fat_crate.local>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241009093257.GDZwZNyfIjw0lTZJqL@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/10/2024 10:32 am, Borislav Petkov wrote:
> On Wed, Oct 09, 2024 at 09:34:37AM +0200, Peter Zijlstra wrote:
>> You need ifdeffery either way around, either directly like this or for
>> that macro. This is simple and straight forward.
> Nothing in this file full of macros is simple. In any case, I would've done
> this as the ifdeffery is shorter and the macro is simpler. We have this coding
> pattern in a lot of headers, abstracting 32-bit vs 64-bit machine details, and
> it is a very common and familiar one:
>
> /*
>  * In 32bit mode, the memory operand must be a %cs reference. The data
>  * segments may not be usable (vm86 mode), and the stack segment may not be
>  * flat (ESPFIX32).
>  */
> #ifdef CONFIG_X86_64
> #define VERW_ARG "verw mds_verw_sel(%rip)"
> #else /* CONFIG_X86_32 */
> #define VERW_ARG "verw %cs:mds_verw_sel"
> #endif
>
> /*
>  * Macro to execute VERW instruction that mitigate transient data sampling
>  * attacks such as MDS. On affected systems a microcode update overloaded VERW
>  * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>  *
>  * Note: Only the memory operand variant of VERW clears the CPU buffers.
>  */
> .macro CLEAR_CPU_BUFFERS
>         ALTERNATIVE "", VERW_ARG, X86_FEATURE_CLEAR_CPU_BUF
> .endm
>

I'll bite.  Why do you think this form is is better?

You've now got VERW_ARG leaking across the whole kernel, and a layer of
obfuscatio^W indirection in CLEAR_CPU_BUFFERS.

Admittedly, when I wrote this fragment as a suggestion[1], the 32bit
comment was in the main comment because there really is no need for it
to be separate.

But abstracting away VERW_ARG like this hampers legibility/clarity,
rather than improving it IMO.

~Andrew

[1]
https://lore.kernel.org/lkml/5703f2d8-7ca0-4f01-a954-c0eb1de930b4@citrix.com/


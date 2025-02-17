Return-Path: <linux-kernel+bounces-518075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5485A38988
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9908816A24D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533F2253E9;
	Mon, 17 Feb 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bEcRaDyH"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C89223700
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810415; cv=none; b=RqiYBSn6uEKDAIwzxGIqgiN3gopbYlncnev787p8YcYi8yonSaQOdX/yLQAT3W8j1qdr88zIypSKRJ7EYtcZg5CVrX6giyQpjOaObf2TvJkUGaxVFkJQN1CV39c8+X9ySCMUqzcpDFn96fuk21YRxj9qQD/nGyXgiMvHtGdPmPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810415; c=relaxed/simple;
	bh=qiiBfKYtJDKnU4FoewK0/2gNGi/q3dFK3BX4XEca3k0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TjEKIfxYpNz91+G+4UMrAc5aGHh8rYBTmA/F1fDiRLBUNwO/UgC86Bm5CsGOaqJH+BZ+HroAKoCN7u+Fi8tKqStjiAsC18kXmFb6XGG6OA86w7t+GX1HiAT4k3q6S4ObvQAzfoKL2NRJJMq8kzWfB8zPBT7+2md6iTj5xidabZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bEcRaDyH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so2988368a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739810411; x=1740415211; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2JZWfSBbMaT7Q5T3cwzlNXztIJ5hdqGIRavswsdXRE=;
        b=bEcRaDyHXbFuC9KzINkHocG7jmO7MrPB5d4bNFCbfVQA927NFrY3oYj+6xdVJdYGFK
         i9n1TF4/IfBxjR23l17cpJ9HhyQObjMv6NtuwMqHMj5Y9AOtcIOnDgvbqItp0EXrTqYw
         ZeCrO0AHti/3oYi5PzVdrJRCDCfdVNe4UMOAYy6E+i6QYj4NaxeoKoLqeBKazJKj22zR
         dollljPol5FHx1JQLTk1YtUihyeLO/EsX5HAZq/udrgrBZE1nxRXHEK3XNADmCLMYhC7
         Sfla/na6qTlnpYYSs2sASExew2mZKqTt+0hlrmW0FHc/3ZDMGzsT038BAoceJamwTE8d
         SfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810411; x=1740415211;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2JZWfSBbMaT7Q5T3cwzlNXztIJ5hdqGIRavswsdXRE=;
        b=VTm/eNy4kHsTjUgEJAgDIJ+pAfE9eEk1h80zpjPzYUxcFPRCjEnf/yAwVwyO7TsjFb
         rim3kdSSUKFwGSU1j4uPvpDTonUfEj7a7VIVzwY8RgBeX0TihB3cIvI1IrBiamUePCMk
         0+LETFcfs9snSut3E5iHkMaWpp8AVKihNUn0cAEIYHl5cDvOSTEncTRWwNBVjR5EP9C+
         fBW//47NZgeTaAgYBWzJ1XG3qZGyRSCW4dZKc83teIZcgY1/NodYFXLhQNajQ6scf+1y
         R+r8X3DvI+6xyupTBMD5lM8cDSHrcKqjJsBJPLVqCCRWchpb9udPYZrxMtrgKRXVDVr3
         GRpw==
X-Gm-Message-State: AOJu0YzD4CYw+G50yG6byd3Q6u4urBzC4xOq78MORfrwj/JgMQiH+HJQ
	89uow5jXwObqSv3V4pASqJk7pcV/GumUcYJ8ccCZ9V64F88Y227fIbY/tphcKe++NyhqVI3T6oM
	=
X-Gm-Gg: ASbGncu+6hCkC2lyZRvtbNq+vLiqZviCPKoU4aRXqfYjOpM+89GMzfCNZ8AGqUjCG5N
	LCHMheeFW7R3u1JxuDGW1BavEzjFm7OGjUaYVa9BdzPziU7r1m6Rnaby2JroMl+m7wPwfqxi/7L
	KUuDA0ueP9mTKiId3Vhiqx4QZPp5SEYFeq41N71dcALP3HIlzLru+OjCfnV4phZkdnIa2OGf4KF
	Oxlo5VV508dX4buyzozsdxID9PCb8bCbm+oOVmw2bHcsAwy8TTvMb42WXM01nLzpqLejWVmYWYZ
	DR+ylvrDHD2WLFNzQwjTcDcMd9tYSkXuPemwxYefknbRXDpccHIemUP/bzYNVFsqkFc9v7BsM/i
	4
X-Google-Smtp-Source: AGHT+IG5wpgWr3x5LOKXnFHy9ZALxD1BNYSUkLKs4X5BSI0srPY3Iy8oY1GS9/V0r7opZx4dYeuRCA==
X-Received: by 2002:a05:6402:13c2:b0:5db:f26d:fff1 with SMTP id 4fb4d7f45d1cf-5e0361cbdacmr9582779a12.21.1739810411128;
        Mon, 17 Feb 2025 08:40:11 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e53sm7375745a12.9.2025.02.17.08.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 08:40:10 -0800 (PST)
Message-ID: <945716d2-4dd4-4d38-b732-41ab8b27c5ee@suse.com>
Date: Mon, 17 Feb 2025 17:40:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v2] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
To: lkml <linux-kernel@vger.kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Content-Language: en-US
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

__ADDRESSABLE_ASM_STR() is where the necessary stringification happens.
As long as "sym" doesn't contain any odd characters, no quoting is
required for its use with .quad / .long. In fact the quotation gets in
the way with gas 2.25; it's only from 2.26 onwards that quoted symbols
are half-way properly supported.

However, assembly being different from C anyway, drop
__ADDRESSABLE_ASM_STR() and its helper macro altogether. A simple
.global directive will suffice to get the symbol "declared", i.e. into
the symbol table. While there also stop open-coding STATIC_CALL_TRAMP()
and STATIC_CALL_KEY().

Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@vger.kernel.org
---
v2: Drop constructs instead of fixing them. Use STATIC_CALL_KEY().
---
Whether the "ADDRESSABLE" in __ADDRESSABLE_xen_hypercall is still
meaningful to keep I'm uncertain about. The situation, as said, is quite
different in assembly, compared to C's requirements.

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,14 +242,6 @@ static inline void *offset_to_ptr(const
 #define __ADDRESSABLE(sym) \
 	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
-#define __ADDRESSABLE_ASM(sym)						\
-	.pushsection .discard.addressable,"aw";				\
-	.align ARCH_SEL(8,4);						\
-	ARCH_SEL(.quad, .long) __stringify(sym);			\
-	.popsection;
-
-#define __ADDRESSABLE_ASM_STR(sym) __stringify(__ADDRESSABLE_ASM(sym))
-
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -94,12 +94,13 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_h
 #ifdef MODULE
 #define __ADDRESSABLE_xen_hypercall
 #else
-#define __ADDRESSABLE_xen_hypercall __ADDRESSABLE_ASM_STR(__SCK__xen_hypercall)
+#define __ADDRESSABLE_xen_hypercall \
+	__stringify(.global STATIC_CALL_KEY(xen_hypercall);)
 #endif
 
 #define __HYPERCALL					\
 	__ADDRESSABLE_xen_hypercall			\
-	"call __SCT__xen_hypercall"
+	__stringify(call STATIC_CALL_TRAMP(xen_hypercall))
 
 #define __HYPERCALL_ENTRY(x)	"a" (x)
 


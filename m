Return-Path: <linux-kernel+bounces-511335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D180A32998
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BBA7A1756
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36E92116E5;
	Wed, 12 Feb 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZbCrvPuM"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B1205AD9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373117; cv=none; b=W/jb0/xCB1FyZ59kACwgV0Mz7LZSoA0tBesWVDXGoOvr3Ww4dOrNBE3xRisVGWuqjQMdU6rndkv/FIEJOcDxPU7EqcS0QYEUb5fOBedDcUStMQpFYUbmlqI/y3C6oflcHFn4AYc/WGz0DkX1Ojg3AObkjfF0jmRfz85UnNIv9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373117; c=relaxed/simple;
	bh=lW2eR9C5xxd+d47ZjXSOq/Rs1Lr85IzEjJbUtB/rYck=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Zq+F98EIvTxtZ/kSiSb2l96Xwg0YESS4QjfnSns1xQh81Kty+X/KLKBo3TkH0TZFNJA3Xeabv3L+Kf3yNHprZ1dCmr88DOop57TGxGV+fVRRTrkRquEW/En0Or0KsM8tj0OGy7pRscmwnm4N4XenaXfDDxhJhglgYzQrFU/Ceg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZbCrvPuM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1289364666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739373113; x=1739977913; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27wXC/RGyRWjlGAoZwYGHUFkKIvXjmAZFqTsWcAXkpw=;
        b=ZbCrvPuMNtjXyth5+yDEBmod5IQMMc/esfFIChaMxHfRaJK6Z+6S2+KZlsH0UKSvSS
         OLu+hI3bCJrZgpVNSxhTYGbr+wh/oRqsG1JWDalWB+Xhm0/PuNU5Rbd5MguwvQWog8nl
         Sn4oQ6jH0IlU4JNLGFxqTjClcIEIsi7LEsUFRnmWYH6sn+54qrlZLpyVLUy6zJ3ezrtk
         YOIg2PrwdLJqPUtelJzPpodCGZtpKxfNLzAmyqifN1J5qI0TkgjsP+ZKAzpdTZeefaHE
         M+H+ZHlnJrj0VGIPpcjDuck1rHggM0McW7f6FCd0dprD0yyYiXwRCkJeDgtlDIz2/Vqp
         QZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373113; x=1739977913;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27wXC/RGyRWjlGAoZwYGHUFkKIvXjmAZFqTsWcAXkpw=;
        b=uCCilOO47zjMZQGb5MFqwQnXla2xyAJXrZvdh1Yn5sRcLh0Sa5Zy1qynZ7cW1e6Hpi
         YDXzLfSPbcEEvAm5oV0zvEu38xtoA1002rrX0w6VBWsXdLZv5e//fxZ99Ci9Jq6WJ/pR
         JIh29Z6iwvBeb2CFnXMb9IGv90K9a8UPjnXOAhQfY1ys/rFaeqIS2Ng1KD3aiRsAcsvc
         lVzmHsoIfqDbZySkGyf2KqOLRGMwuLHvKUphVDqN81pSe+zwGlLzDZsiaz+ZL86ilwb3
         HPySP0596RdfZ9W9hupdj2OtIJlCskHwBnpAT3FnJnhdtHhadVoa/THvhuPAnjVgN/8m
         tDRg==
X-Gm-Message-State: AOJu0YzkCf2dXY2KT8sKuMxBPbmAeqoL0MInoXPRBc+Ziw2JPR+X1lp6
	2iU4PGzIzEMtM+UwNyyrozlN6Kca8IegWBRZZfbc47Ngu7FGDw9D6o4ctMPtL62Zf/x1qFlSdR0
	=
X-Gm-Gg: ASbGncukTKAtKopdEoP3bptCu/2fHfAYeVVl2/N4yXlaNVx8B7Uds1YZjL1+TewPkKJ
	0QO79rAPy1n61Z+1KoCSyWA8d8fPO36Dt1AAQAdhErMNh9iZlCwIA3lyc7Bj7KmGiz4JP1moTl4
	K7dmUKauehUEMHD1w4g5bK49/juooKLBGTr0K+llG4REjrFtR6vjoLbtcDfAEHwZbvkqjsB5R2V
	rq6J/3lPWpL1QBUyYxC7XsHwdMutlhgLdgqxts46ijsj5Y1ey3z1BMMQs+Kn8frB/orMvbMGMst
	+uUFQv8gjH8xEouti0VUSUCc6z29aNb9cepuRKhCzJB3buzRtZeZJ4Toge1WvxLhOyx+KvHWTHk
	7
X-Google-Smtp-Source: AGHT+IHgx2VJWakGuR7z5wkrDlPx3Dd2+2qHizLDchE4j+yKE2uJ4nBaPonow1MwBAOiWnOL7/SsTA==
X-Received: by 2002:a17:907:2d12:b0:ab7:a39:db4 with SMTP id a640c23a62f3a-ab7f34ac985mr313038866b.57.1739373112898;
        Wed, 12 Feb 2025 07:11:52 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7878b18a9sm1150244366b.167.2025.02.12.07.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:11:52 -0800 (PST)
Message-ID: <561c52d6-9728-4dfc-a629-353dc2488c8b@suse.com>
Date: Wed, 12 Feb 2025 16:11:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lkml <linux-kernel@vger.kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
From: Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] compiler: remove stringification from __ADDRESSABLE_ASM()
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

Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@vger.kernel.org
---
I think that __ADDRESSABLE_ASM{,_STR}() better would have a separate
comment, as that presently kind of shared with {_,}__ADDRESSABLE() isn't
really applicable to assembly code.

Is data allocation actually necessary in __ADDRESSABLE_ASM()? Aiui the
sole goal is to have sym in the symbol table. That could be achieved by
a simple .global (or e.g. .hidden) directive.

Shouldn't Xen's __ADDRESSABLE_xen_hypercall use STATIC_CALL_KEY() rather
than open-coding it?

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -245,7 +245,7 @@ static inline void *offset_to_ptr(const
 #define __ADDRESSABLE_ASM(sym)						\
 	.pushsection .discard.addressable,"aw";				\
 	.align ARCH_SEL(8,4);						\
-	ARCH_SEL(.quad, .long) __stringify(sym);			\
+	ARCH_SEL(.quad, .long) sym;					\
 	.popsection;
 
 #define __ADDRESSABLE_ASM_STR(sym) __stringify(__ADDRESSABLE_ASM(sym))


Return-Path: <linux-kernel+bounces-512142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB33A334B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF531632D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D680034;
	Thu, 13 Feb 2025 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rLmdfCY9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81C1A29A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410296; cv=none; b=ukhcaKy+YyPCngsW+L1HOtbaBtrTh05POXRJRs7kXOyOKC4xcHlJKsfiAlF3KtuTif5A3IZ5WKz6mWe8RIOCF09m+TRjzWfUkPg2jy7iUcBpsrDVFiWSKab+qC20fCRY1mWlL8TV7xtHcf8T33bIr1tZGWzcG1YmGm2HC+8zrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410296; c=relaxed/simple;
	bh=K1YqvT/uRu3Beo69LcLvuMznFi3ilLXZg3DzZP3Y8gw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=S+ZYy0jV02zOtIYFCMmRy2X5Mf1g0a7BekPGLlRIOeZIfGmLsB9sgPiYU9C7wxXYWkUIAqWwtCZMwHi4Rj8t4TVnpOBBilFUY2TsLOMcJ4pzwrpSSHoDRNVWJx8XHw2PTfgsNjJsteNjQJ/dk8442TpaGpq5zX5cX0SgJ7YcDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rLmdfCY9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4395b367329so1946035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739410293; x=1740015093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w5EKFWBgqPpVx5P7IvxNzLC6M+MvEBL76rv2xNaJ708=;
        b=rLmdfCY9Qa8YJZhIY7gn2eEr+MhWisLs6wmOYOq1HQYYvICR1akOuUgPL3uRijfZH6
         ozk13rtOsb6LI+KAqdwQ1pxFZazLNefFIZXQEV4Fkul/RXfjShVX3rsVILo+XQTWCqpZ
         SZ1eAvtlWj9fSgoh3fP0tzy5E0GlVrV7ahWSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739410293; x=1740015093;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5EKFWBgqPpVx5P7IvxNzLC6M+MvEBL76rv2xNaJ708=;
        b=hjDY93e0jhOgXBYVH5CnWB4bXBGdzBugE/Jbun7coLCYCvVh9LNdfdbLpd5dkIjkE7
         CsHzSKeleR8gR4TSLAwQmTyB7SajCSHL2Auf4aFQC19oz+lqwCNYbXZn3MHgaQpbecSM
         EC5v97tBGE+D7lfNc1crRFEg7W1QKb+wzYiUaitJd85VC5d+hCRb01ifmgg8uaM02tGc
         O77sYU0HcrFqGrqNa1mWKHnV/hssy0e6fOo1wFyuAJCC5HpL5M7hWFg0qCZpOZXPSQRS
         r1tehQOjzuIIFSCS3q/FBnt/V9AixVq/Uu8XVNmJwoFUOQWsa5HOCdLyyy+n+NcRd/rA
         1tcA==
X-Forwarded-Encrypted: i=1; AJvYcCUJMjsIQxiLBp/N6X6sIVoD4Ds3X6MNiXbDkIViXxF+x8kN6E2n4dIYhZzoyNhKdREwPGhs8mSIIGUFhRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxShf4YWYew5lyMn1Wk8ahr95Hw8cEivUeBYENbD0LTzvjiXiT3
	qxvnTftf4U0TAR8aedBlzoPcR+ukyilcGOOIrFAGMaf2wUmdOs2in004EPVZRNQ=
X-Gm-Gg: ASbGnctrX3BnSJEC/CpXO5JnFAA9OfGoC1iucE4S4+CyC2YsaN3zH5UlKo9LQwOr8xz
	s77hnDMJvJTqvJqz5ssYuoikgtlbBeDCXBlSqhIFAjje1iyvX0jtE5H53LRzrp7asDyD9KRNPy1
	tf71i2o60RMWgOd6xpoe9X6a5cHsjTUHHs8glAcgVyI1xAXL1q/41hLd3sqSsRLVXGqkJIA4J5E
	Gp6Ad5i/0pHBdYC1dprAT0cXTGZPt3mVA9rrXOAiqjBsSbxdEY0bFrRd3eFE/AOtiQB0HqZl/TT
	cDD2uUcrU6xKUMczO/ZgmgP4DThNDed+skzXwEHOtWzSTgiSWsWgIKA=
X-Google-Smtp-Source: AGHT+IHkfWcbtltL+KlPJj6/r329jxDn9hmKlU/J0nwqxobvWMmDKGoutWnwtiQOtr/KoOClttIVhw==
X-Received: by 2002:a05:600c:c8c:b0:439:4499:54de with SMTP id 5b1f17b1804b1-439601afaf0mr13890885e9.31.1739410292956;
        Wed, 12 Feb 2025 17:31:32 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65bcsm428526f8f.65.2025.02.12.17.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 17:31:31 -0800 (PST)
Message-ID: <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
Date: Thu, 13 Feb 2025 01:31:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jannh@google.com
Cc: jmill@asu.edu, joao@overdrivepizza.com, kees@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 luto@kernel.org, samitolvanen@google.com,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> Assuming this is an issue you all feel is worth addressing, I will
>> continue working on providing a patch. I'm concerned though that the
>> overhead from adding a wrmsr on both syscall entry and exit to
>> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
>> any feedback in regards to the approach or suggestions of alternate
>> approaches to patching are welcome :) 
>
> Since the kernel, as far as I understand, uses FineIBT without
> backwards control flow protection (in other words, I think we assume
> that the kernel stack is trusted?),

This is fun indeed.  Linux cannot use supervisor shadow stacks because
the mess around NMI re-entrancy (and IST more generally) requires ROP
gadgets in order to function safely.  Implementing this with shadow
stacks active, while not impossible, is deemed to be prohibitively
complicated.

Linux's supervisor shadow stack support is waiting for FRED support,
which fixes both the NMI re-entrancy problem, and other exceptions
nesting within NMIs, as well as prohibiting the use of the SWAPGS
instruction as FRED tries to make sure that the correct GS is always in
context.

But, FRED support is slated for PantherLake/DiamondRapids which haven't
shipped yet, so are no use to the problem right now.

> could we build a cheaper
> check on that basis somehow? For example, maybe we could do something like:
>
> ```
> endbr64
> test rsp, rsp
> js slowpath
> swapgs
> ```

I presume it's been pointed out already, but there are 3 related
entrypoints here.  SYSCALL64 which is discussed, SYSCALL32 and SYSENTER
which are related.

But, any other IDT entry is in a similar bucket.  If we're corrupting a
function pointer or return address to redirect here, then the check of
CS(%rsp) to control the conditional SWAPGS is an OoB read in the callers
stack frame.

For IDT entries, checking %rsp is reasonable, because userspace can't
forge a kernel-like %rsp.  However, SYSCALL64 specifically leaves %rsp
entirely attacker controlled (and even potentially non-canonical), so
I'm wondering what you hand in mind for the slowpath to truly
distinguish kernel context from user context?

~Andrew


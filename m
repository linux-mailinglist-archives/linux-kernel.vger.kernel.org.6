Return-Path: <linux-kernel+bounces-512133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75762A3348C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1161188A020
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D860D86349;
	Thu, 13 Feb 2025 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfjYpt8w"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B078F26
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409708; cv=none; b=YH433UuCNPGPHKmvqiWe9mt27bnN9f6T3bKJYBX9d9+Wu8eYQO7R5JrCSzhLBaomcZNOPLIfdzf2TcxtGau5d13Jyif96NJMRQFBwGPwqMKk9PrxqYv7gpDEzVF5rYazl/cYpuzPWGLULsLev5ooRuCzEYIN15y+h7osTZr5W5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409708; c=relaxed/simple;
	bh=q+nCXvcuGbP6lZuLocKajT0ORe5EGrF6T3/N8VpC8fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KueByD88zh6dkx1DYuM+ia0sATnA8R+pRuv0j62qvl4CGtwJBXW1kTy7G8haRPDAopWLBy6JYu0Pc4jrpocoK9C5odA8MahMbaxDgq1c7YyC3iF8VhzpQKn3JrTRxuUU0mvxpUBPbLYp7XPWKhb0sTAjha/9R4YgtsBo85SfyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfjYpt8w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43956fcd608so1977485e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739409705; x=1740014505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+nCXvcuGbP6lZuLocKajT0ORe5EGrF6T3/N8VpC8fs=;
        b=HfjYpt8wQHhUYd2ZRQuf3oSOgLs6yha3tTp4A+R34vbmrAbTWh5TVtKS3eLS+iO6g4
         maDCkH/nNp/ZOHuhialk9S6PFGYBcSpYiFJh19PDkIxsEhqHu67n2Bh1P+EIw/2o6YKA
         e33iXmpR/zB8cvDmIW3g4q2nqVnqqaXP8DqsroS13hZuhxJCvf4Q9MK0JIYDo9BfNz8J
         hdprjRXFgcpzEMqp/8eTH6GAil0gRUyHvQHO1LolG5draZPPu9aJYOK+2UgTzLllXMci
         qpGhj5COTTQIzS1/3Cn2pBLuM+fePxvX6+f2nv7XU+wQeMI4fUVGbowzl0UT/eZhupBC
         ZP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409705; x=1740014505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+nCXvcuGbP6lZuLocKajT0ORe5EGrF6T3/N8VpC8fs=;
        b=l5lBv4H8r2rBd2BKqS2FTLm7w3WnEQZ0D27gPYiiwKTRx9IceK3+fAdroJLMAGbun2
         hYsn8JTI16Km+RonDnZqvE3yoE8XvkQjKxSNpzYHqOh3iT49x+OeNmXcnsv1ou4UkgJ7
         A757zvLEfuor2oifC+4UpOHa3sS1+CkugwzVgcuvPiedE1+bJG2rlHeATLJWQpgi13hv
         cUyH65jkbGTdA3II3wiVikft+iPkf3q4prU2AoBHVHqAmigOtGlTsJNwGXyupIZFphQn
         V9j3gCn4aTzSMh/kUe54MqDHvMAZqRIpba53nlgmnDFm6xmHZq9bSL9EeqwUKJVQscaH
         WA9w==
X-Forwarded-Encrypted: i=1; AJvYcCU/2tQ8y7mSpjED8xTsQ536Cz1n3sl+TJL2t4JrJbv2l6t1qKtDawzR3JxAvVLIMH4Hfr3Lw/Z8W8GFeOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjucxttkvSdwIiw5UXC1arWok/AAb7VIsoxu8q6txRHviM9IBE
	VNYWs20VfPf0dgXUUn9+drVqFCe+X4L5o4BJWDqY3MV9TF+UBAKjdPUxwIANConlHSz+pfM6mTo
	AFqmkpxQjnjMdExtyNnCed5Rl2xE=
X-Gm-Gg: ASbGnctVbHnPN3yqnh5oEyGv/SD0DWbNFKtCpYruKE3XU6MYJsMW1vAehE0tRcn1wJq
	V3/jWa41cF5KYHP90ecKzYZS2IfhkCMKOsfG4S2Bt6OXvxrGu4q7ubIn6R/2iY49k342sDccw6K
	Q=
X-Google-Smtp-Source: AGHT+IEjJMkC/hHaotdqSukhMJQZrOiaCkGtVrbEkJiI15zjYiRvHohJ4FkUwvWx7PY95qrg/tcG6HP5nsDWETkesBs=
X-Received: by 2002:a05:600c:198b:b0:439:60bc:71b3 with SMTP id
 5b1f17b1804b1-43960bc744emr6893225e9.25.1739409704648; Wed, 12 Feb 2025
 17:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
 <20241022015913.3524425-2-samuel.holland@sifive.com> <CA+fCnZeBEe3VWm=VfYvG-f4eh2jAFP-p4Xn4SLEeFCGTudVuEw@mail.gmail.com>
 <e7t5yzfw3dq5stp5xjy5yclcx6ikne4vwz7d6w2ukfw2b7gr6t@oomoynf3b2jl>
 <zjuvfdbl7q76ahdxk3lrgaznk7vjj43f5ftzfgrnca6dqtcd5x@5qj24womzgyq>
 <CA+fCnZfySpeRy0FCFidLdUUeqp97eBdjAqQyYPpz1WxYwcsW9A@mail.gmail.com> <aqhm7lc57srsfuff3bceb3dcmsdyxksb7t6bgwbqi54ppevpoh@apolj3nteaz6>
In-Reply-To: <aqhm7lc57srsfuff3bceb3dcmsdyxksb7t6bgwbqi54ppevpoh@apolj3nteaz6>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 13 Feb 2025 02:21:33 +0100
X-Gm-Features: AWEUYZnQToSGphLmBmZFBpfuiZIg1iWlon9vHp3PXB7Fk9evMSAokOcZX5tZFRE
Message-ID: <CA+fCnZdjTkreTcoo+J8wMhwDuAFM4g33U5BFy0OPtE0UCvyJbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:07=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> I did some experiments with multiple addresses passed through
> kasan_mem_to_shadow(). And it seems like we can get almost any address ou=
t when
> we consider any random bogus pointers.
>
> I used the KASAN_SHADOW_OFFSET from your example above. Userspace address=
es seem
> to map to the range [KASAN_SHADOW_OFFSET - 0xffff8fffffffffff]. Then goin=
g
> through non-canonical addresses until 0x0007ffffffffffff we reach the end=
 of
> kernel LA and we loop around. Then the addresses seem to go from 0 until =
we
> again start reaching the kernel space and then it maps into the proper sh=
adow
> memory.
>
> It gave me the same results when using the previous version of
> kasan_mem_to_shadow() so I'm wondering whether I'm doing this experiment
> incorrectly or if there aren't any addresses we can rule out here?

By the definition of the shadow mapping, if we apply that mapping to
the whole 64-bit address space, the result will only contain 1/8th
(1/16th for SW/HW_TAGS) of that space.

For example, with the current upstream value of KASAN_SHADOW_OFFSET on
x86 and arm64, the value of the top 3 bits (4 for SW/HW_TAGS) of any
shadow address are always the same: KASAN_SHADOW_OFFSET's value is
such that the shadow address calculation never overflows. Addresses
that have a different value for those top 3 bits are the once we can
rule out.

The KASAN_SHADOW_OFFSET value from my example does rely on the
overflow (arguably, this makes things more confusing [1]). But still,
the possible values of shadow addresses should only cover 1/16th of
the address space.

So whether the address belongs to that 1/8th (1/16th) of the address
space is what we want to check in kasan_non_canonical_hook().

The current upstream version of kasan_non_canonical_hook() actually
does a simplified check by only checking for the lower bound (e.g. for
x86, there's also an upper bound: KASAN_SHADOW_OFFSET +
(0xffffffffffffffff >> 3) =3D=3D 0xfffffbffffffffff), so we could improve
it.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218043


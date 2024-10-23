Return-Path: <linux-kernel+bounces-378765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1834B9AD52C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FE9286992
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25191E2836;
	Wed, 23 Oct 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfSWaSW4"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3861DE2AE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712829; cv=none; b=NrZ52CetP/y9NiC4mHuqbkQNVAZyrTQ/uMQj9btUe5p9LrExPRxbhBnu0evsZySyLDk5smeaP2D3qdpdLLb3G11EGXfZlIrae/Qeslie+rqySg94W1hCOYi6WfukxKVecdUORrAkjJ7Movg+hz4QzXdizDusixidAHWLh3iidOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712829; c=relaxed/simple;
	bh=M72n/VMflKKIL8GpFlNX+001CH6qDRfRgs4vfD+Lc60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bsG5YYxXWm5xb47g4ngVUtqUnYV8dkp4P0YcY1rllAuCj1DhLu9NAlVxVJNSXJVBf2B75jCUZpD7B40r5Hu8ejl9PxhcmmZbtiDHMRJ/VIgBLpgW2ADAmKA7yTE+wW1/o5B1CIDVctR2cn5fKIlW/RKqJC5wirh8dOgQD8ZzEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfSWaSW4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a850270e2so13979266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729712826; x=1730317626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjeWek960NcUIgiohtPXB+Vg0rJ92eP6xQNpgT2ubOU=;
        b=HfSWaSW4/LSSYn0gVGStCKVyLiJ982jqCeaIAJC6Djwk3wPgbWgTNSbN71ZC+5DGoq
         qoliTFv6nD3FEp9LIQpWbqyBt7XuEZlYdyibkRRO0zgccsBRNUOyyHmZCnPdQZXzYE74
         Ohc/E+cE3eUdPOMqACggORslItHR/1ncv+1fFyKvZEmxM3z2QRRRNYElnK3Ton28Xegn
         MZVS7RSOxf7AVuUGkntZAXPwpNyZuLtkNaAKzuDtNrZk6ipq3hU1KiS9a+l4xNj2MZ6o
         zdLEpuPXMErT944YsIuZnmnBcBMREkYsqhsn7imxkaeibuwl4VTasYwopQpyI81M65FG
         nbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712826; x=1730317626;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjeWek960NcUIgiohtPXB+Vg0rJ92eP6xQNpgT2ubOU=;
        b=jsIpLVEox0WfTmAcPCNXhnK32QMq7tnz6LXMJOKtUtfZ9rxT9Yu26xdetaarj4FbvY
         kPV1fmK692hsjtWOXRounDuaC3wNynp/OQayRrAQ49Fqc1EBJXTtv7l7EWxeqgMD/cMt
         ish/IcUbZnGivLJ/DO1tAyEUfJh6PSBZAgNBTfmpMarWNcn4AyzhlWdqIfVltOUAghjl
         H4tfOcbfuc+8Qhsz2UagqYIGQAf0xHkv1cuYJPoOau2N09lsWyn7G5iKoBN+XY92/WuU
         +8rn/hePndnfVM8NzoiB/v5mvkocoHoGnhqO55KS3yAPo1tH+p0lEIWBvEsutOHuVRjb
         YiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/9YjkJ6byQE7sm/P2psfjDlXxg93LP7RBbwuPShYVr1vtoRnpFPTwjyItA2Z5DIASV9HeM39L++Y0x/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOLwSPUqIOBnmDZGIPQHoWci8PfTKPGp57LSaYxQoYyIkT7DS
	CLrVsrLkZCXDmMEyhY58cdC5hhgjTuvI44E4iSdM0IAvyPmrtSnt4sC8W5JEiC4=
X-Google-Smtp-Source: AGHT+IEIA9rIJ04+Qcp3TzNgVJAqmBz3KuIj/pMJ7zakUwT1dcG/rm3pZHFabLhpGBrqDgGq03uVBQ==
X-Received: by 2002:a17:907:980c:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9abf53587cmr351767466b.0.1729712825573;
        Wed, 23 Oct 2024 12:47:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d62efsm513496766b.44.2024.10.23.12.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:47:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 082235F897;
	Wed, 23 Oct 2024 20:47:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,  "open list"
 <linux-kernel@vger.kernel.org>,  "Linux ARM"
 <linux-arm-kernel@lists.infradead.org>,  lkft-triage@lists.linaro.org,
  "Linux Regressions" <regressions@lists.linux.dev>,
  qemu-devel@nongnu.org,  "Mark Brown" <broonie@kernel.org>,  "Catalin
 Marinas" <catalin.marinas@arm.com>,  "Aishwarya TCV"
 <Aishwarya.TCV@arm.com>,  "Peter Maydell" <peter.maydell@linaro.org>,
  "Anders Roxell" <anders.roxell@linaro.org>,  "Vincenzo Frascino"
 <vincenzo.frascino@arm.com>,  "Thomas Gleixner" <tglx@linutronix.de>,
  "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
In-Reply-To: <4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com> (Arnd
	Bergmann's message of "Wed, 23 Oct 2024 16:24:43 +0000")
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
	<CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
	<4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 23 Oct 2024 20:47:03 +0100
Message-ID: <87bjzalhzc.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Sun, Oct 20, 2024, at 17:39, Naresh Kamboju wrote:
>> On Fri, 18 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
>>>
>>> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
>>> The boot log is incomplete, and no kernel crash was detected.
>>> However, the system did not proceed far enough to reach the login promp=
t.
>>>
>
>> Anders bisected this boot regressions and found,
>> # first bad commit:
>>   [efe8419ae78d65e83edc31aad74b605c12e7d60c]
>>     vdso: Introduce vdso/page.h
>>
>> We are investigating the reason for boot failure due to this commit.
>
> Anders and I did the analysis on this, the problem turned out
> to be the early_init_dt_add_memory_arch() function in
> drivers/of/fdt.c, which does bitwise operations on PAGE_MASK
> with a 'u64' instead of phys_addr_t:
>
> void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> {
>         const u64 phys_offset =3D MIN_MEMBLOCK_ADDR;
>=20=20
>         if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
>                 pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
>                         base, base + size);
>                 return;
>         }
>
>         if (!PAGE_ALIGNED(base)) {
>                 size -=3D PAGE_SIZE - (base & ~PAGE_MASK);
>                 base =3D PAGE_ALIGN(base);
>         }
>
> On non-LPAE arm32, this broke the existing behavior for
> large 32-bit memory sizes. The obvious fix is to change
> back the PAGE_MASK definition for 32-bit arm to a signed
> number.

Agreed. However I think we were masking a calling issue that:

    /* Actual RAM size depends on initial RAM and device memory settings */
    [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },

And:

  -m 4G

make no sense with no ARM_LPAE (which the kernel didn't have) but if you
pass -machine virt,gic-version=3D3,highmem=3Doff (the default changed awhile
back) you will get a warning:

  qemu-system-arm: Addressing limited to 32 bits, but memory exceeds it by =
1073741824 bytes

but I guess that didn't trigger for some reason before this patch?

> mips32, ppc32 and hexagon had the same definition as
> well, so I think we should change at least those in order
> to restore the previous behavior in case they are affected
> by the same bug (or a different one).
>
> x86-32 and arc git flipped the other way by the patch,
> from unsigned to signed, when CONFIG_ARC_HAS_PAE40
> or CONFIG_X86_PAE are set. I think we should keep
> the 'signed' behavior as this was a bugfix by itself,
> but we may want to change arc and x86-32 with short
> phys_addr_t the same way for consistency.
>
> On csky, m68k, microblaze, nios2, openrisc, parisc32,
> riscv32, sh, sparc32, um and xtensa, we've always used
> the 'unsigned' PAGE_MASK, and there is no 64-bit
> phys_addr_t, so I would lean towards staying with
> 'unsigned' in order to not introduce a regression.
> Alternatively we could choose to go with the 'signed'
> version on all 32-bit architectures unconditionally
> for consistency. Any preferences?
>
>       Arnd

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


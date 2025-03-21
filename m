Return-Path: <linux-kernel+bounces-570815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF85A6B4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCA9485B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E761EDA37;
	Fri, 21 Mar 2025 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="M9kWwXLX"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742401EB1BC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541782; cv=none; b=WaF/80IVTb4GUgniNG6uktWswdP74fgeV5eQVI59u9zw4g6d58Ov3FN4nRe++IiHy3+k6WHVfw6ezL7YbKlo6KCwCQkAnj5QzXVLOVyxtpTY0cLuCvbFlaeYt5iLBaYHOeVgCOM6g4AMkV8U1eKLmtioCNANHM0jyQwQHTcWHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541782; c=relaxed/simple;
	bh=32rEkeUdXgVpnkRY7KM86vuJasEtKRbGSmPjSbYp8Xc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sKUaiPckbXeLbxA4xdXXQq0D88KROpOs3UFqgGYw55NS5AB38bqO2rPiCIPFoJs8RuKBkBKjmcaRyPBqCy7gO3JyZyf+LO+62Zc9TIQSpn/7CzUqZTA42hwZsJBOYs8n+aRlxx/sgOw5Nl21RU5kLxnRbjZy4/f3yu652i2Ta/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=M9kWwXLX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394944f161so1865335e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742541778; x=1743146578; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/25ortMfNWyDWu+kRgDZEazYd+Unr6LrL65OHsKgfr8=;
        b=M9kWwXLX6vNoAi2egfFyP3urmOVzPh2gTSjUbT72iHXiNzrPTGdaiwTA6SWExaetV0
         h23nOJ4XsjY8STmohFNDSfpJT+X8skskbsXRi6r5kOp2cZh6dQU4XUoutwRzVd6O4HYs
         jlT6gI4Pbsts9ivYw2nitRVFD1IlseJtLgJGMmNJ2izFY55MVEgEQ4e+RdbqD8ocdSO9
         YWyq1DT0hsD0tVcf0aLVYVcFZb1Iwc+fw8achxREO8J9a1VAgcahpdvTc3RGosgj5v3/
         Y1LWNbvwpFyQjGj5bOcihJYA5dmMVFR+3dMmGn1puPHO4i0VWnptb+Fr9VxMt9u2oCC4
         h5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742541778; x=1743146578;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/25ortMfNWyDWu+kRgDZEazYd+Unr6LrL65OHsKgfr8=;
        b=sjjFyiGsrqop+nsK86EkFIuLtvgGPbYc/+2jfLbJyUYYuJhEhEoX3F8fLMnHUnEJlz
         kjHnw5lcO1xPBevDfS2O5BTu49gefZoNvVRkUkFseKlwiq6UxJG0i3oh50jayY1VfI9S
         aeFhYC7TSZ7Wo9/wyZM19VsPcLhOnvICvBI5um3PPIBCDopFq/G0GJjKThxlwz1ceA8e
         pqoAw3mPlEg9CgkwibVVEf4Qfup8viulH8BYx8MeodTlx2guPnZxfGXlTj4h9wTB2E5J
         V5aRbQ/aR9Q85kE39yU0QvX2vu4Swk4M07nxpaU0KxOeZpRWHvCwhRDFrxtXqpgAL1lY
         A9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYOdGd1ChqBt+Y1PF3Q9QQur+YbLbJpbB6+0j4JZfXPv0ihexcNqGXE7llk5k5xd3CgYIu5gYmkM6WW0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lSmslpsvwCSN9Z6cc5AP85RsDrCaEZCvnyytSkOzPMFZEKy0
	q+id43jec5FNpnulP5jNJjbM0pDTgvTF7yTs2/l1tIEIrjFzg2k8KGz++C02tOo=
X-Gm-Gg: ASbGnctXBcLm4iomJP1CC4a9BuR2nlL+D1gsQUbWuyTsGoFA3L5pKSxH/Hxzj4Wtox1
	w1UzT1+lFki+Jwvje1cMN2CqRvY5BIBUWdrhDqwau0048C3zDBiTjQEPRAQzQ4cSbZiw5LH8A6S
	wWc1eh50tyyW23E5ky/DTb3jH7fcfQmkitZAJFzUfTgHt7LY72LSUT+OiVPqjOOa7NcvlbJ+XFF
	VoQJ1DcATpCkBJvCXBgQnnHfVgFaWlss65QuKLwEN2/fuZUF9vLeWqGuiblahM9yIu0nQtqC7uB
	DDmmQ4T+9dRUzme79MHI7aOgwPJf2NxtnkiSZe64RR0641/0jyxktv5Dkw/zuxtcqhx52hautrZ
	V0Pdr
X-Google-Smtp-Source: AGHT+IFU7wrxqVXUGlM5v1RoJxyo0mt50QhSrJ/ZcnqbElE1lD78gF7+vCkNQEgx0IT1Onq7RRwDeQ==
X-Received: by 2002:a05:600c:1c1c:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-43d50a3b5ccmr5385925e9.3.1742541777651;
        Fri, 21 Mar 2025 00:22:57 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43cbasm68963045e9.9.2025.03.21.00.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 08:22:56 +0100
Message-Id: <D8LRI8WGXGVD.3B0VB9PCQ9I2R@ventanamicro.com>
Subject: Re: [PATCH v12 19/28] riscv/ptrace: riscv cfi status and state via
 ptrace and in core files
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-19-e51202b53138@rivosinc.com>
 <D8LG1TTBMPWX.3MKAEM8X1WYAX@ventanamicro.com>
 <CAKC1njQ8P2mNiiev-NDyTJPjJ6AAVqrtHMcwt_sc5A7Z+3-Jrg@mail.gmail.com>
In-Reply-To: <CAKC1njQ8P2mNiiev-NDyTJPjJ6AAVqrtHMcwt_sc5A7Z+3-Jrg@mail.gmail.com>

2025-03-20T16:09:12-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Mar 20, 2025 at 3:24=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>> 2025-03-14T14:39:38-07:00, Deepak Gupta <debug@rivosinc.com>:
>> > Expose a new register type NT_RISCV_USER_CFI for risc-v cfi status and
>> > state. Intentionally both landing pad and shadow stack status and stat=
e
>> > are rolled into cfi state. Creating two different NT_RISCV_USER_XXX wo=
uld
>> > not be useful and wastage of a note type. Enabling or disabling of fea=
ture
>> > is not allowed via ptrace set interface. However setting `elp` state o=
r
>> > setting shadow stack pointer are allowed via ptrace set interface. It =
is
>> > expected `gdb` might have use to fixup `elp` state or `shadow stack`
>> > pointer.
>> >
>> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> > ---
>> > diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include=
/uapi/asm/ptrace.h
>> > index 659ea3af5680..e6571fba8a8a 100644
>> > @@ -131,6 +131,24 @@ struct __sc_riscv_cfi_state {
>> >       unsigned long ss_ptr;   /* shadow stack pointer */
>> >  };
>> >
>> > +struct __cfi_status {
>> > +     /* indirect branch tracking state */
>> > +     __u64 lp_en : 1;
>> > +     __u64 lp_lock : 1;
>> > +     __u64 elp_state : 1;
>> > +
>> > +     /* shadow stack status */
>> > +     __u64 shstk_en : 1;
>> > +     __u64 shstk_lock : 1;
>>
>> I remember there was deep hatred towards bitfields in the Linux
>> community, have things changes?
>
> hmm. I didn't know about the strong hatred.

There is a good reason for it. :)

The C standard left important behavior as implementation-specific (by
mistake, I hope).  I do like bitfields, but you have to be extra careful
when working with them.

> Although I can see lots of examples of this pattern in existing kernel co=
de.
> No strong feelings on my side, I can change this and have it single 64bit=
 field
> and accessed via bitmasks.

This is uapi and bitfields do not specify the internal representation.
A program compiled at a different time can see completely different
order of the bitfields, so the uapi would break.

We cannot use bitfields here.


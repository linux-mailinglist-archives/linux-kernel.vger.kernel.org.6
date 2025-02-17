Return-Path: <linux-kernel+bounces-518036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A3A388EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB6A3A9463
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D238224AF5;
	Mon, 17 Feb 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM7ahklN"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA0DDBE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808817; cv=none; b=m2Dj3xbMZIUebE+hw0o4dHbpYlTiTTHlphl1+BoxkTdY8JzB7OGpDy31AE+33PZ65jqljHD7YznQcbnZo2Nmw4manYpFIa8aHCN4E8phK02qcDk+tw9GF+A28Yl9IpKXD5zOYhMBgEtpGzV/pC9XZGN1w0iVBoz3C9KuvI8PpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808817; c=relaxed/simple;
	bh=Par9T59MfVuMC1aGyRmRHe+EvTOeC8X8SSLBj3MrHYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPeqTXtZvT1zp00iZriuQUIIhU270rJC/Od+cJKNOc3Z+L1lOhmFdCr4ETeUOZw2orm3AZUD8U/NLMwf/Guvcw3DyT+tD0G7eGb6jt16zm2CPhG0xeItoNBcfM3rIpa0hc4uFAFMtArya+uk5fUWUEWeL3eONZaG2Gdr8bSbwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM7ahklN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so2592903f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739808814; x=1740413614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KxbE/LUi+pBeXrp6r1WoRsJN4gZHatc3HSxCggqAc8=;
        b=ZM7ahklNp0JUjk77QmVKFDAgo2Cfqxi8SNFtmi2XdA4XqMHoEfNeiDBJ7k6JJGEbhH
         3MRfozpQlzp5gPh/japYSSqQAt31ZD75k0/ez76vjfnimSd/wObLixNe32t5/RsU+vf1
         TtuOKA7ZA/+aE+gSEgj5ct/A6Td9+4SqIRvPwXK/QIriw+D2HIV1bl22xSLasmLyiIAX
         6xkMHxV3GYnI8ymlBsiSQ5cA3w+leeV+cqA/35DoSneKhwed7CNo8hTRZ9iD/4XChDbr
         rrA0BW8QM8QShfbm4gtzQZpFZH9ECkXM93YmEI12LP14wJLW+4Kb8eb8T4p9pr2PopBF
         aEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739808814; x=1740413614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KxbE/LUi+pBeXrp6r1WoRsJN4gZHatc3HSxCggqAc8=;
        b=m5j4lkzophqg82MA3acCClMSk++bmHMJjMJ3pOhjHM1utQqVZeI4gi+b82rhOCSdj9
         uIEJh1ZKIAgGfswHo3kqEsDu8nBwUvsaOuxnfoKfDBruuxlyfbQqNI1g9rBANZ4Csrp2
         81WkOyK5WYJVBFrCvWDepwzkLAalNvK7q491NcDxoXh3eEd4R8IeMwKDtPZ9K9gl1qG8
         yhfCGmCzw1xVz+BcnbOGCnBP/U6aXp83fywAOk4uTvxX4ZCFSw5ITgxeWIpuVGGLItdi
         fN4mCchKPdLbzYENFaa11cuQXmgm+JgQ0hcOJI3t7Gf69xtwkVqxEbuK9PZW8SOO9BSN
         Ai+A==
X-Forwarded-Encrypted: i=1; AJvYcCWxtY38+rIeeDi2G2wgMOebyvYLYIx/qOa/T/tGihsisVYbdifv7rjSyoh5JDC+gcbE5F/Y9TrDMReP76U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzZvJKi+Y22ZbvFe4XdlsGLe/UvsESPmcFYFZHkJNi4fDPseC
	K8j6I8SsxPN1N3pblYiveYzcv5JvIDRNTqXF5EDvP+qYlrYhjDHHQyWWmhUiUTQ0MW3sVpxiSLI
	4+X7o6bAOk2brNkwXG1s88LrL0E8=
X-Gm-Gg: ASbGncvD02oeQr4emTx6CFR3XONK+ON40mnty5M4tSWhDm2rqa0RwTZuvF6Zy5r+CX8
	AHHKfbLRZg5cWUM6f3zqou9UyWbfHrSCT1Ppe57G2Nk6qV4A8eXx9XJ7U+3lleQK0juJKFx6dYY
	g=
X-Google-Smtp-Source: AGHT+IHm8HBgn3sImk7NTjtXb+A27btOABGGevI0EONCrC/Ff9AcLGqA4yAvmgT0QuA1lhKIHNQku0J8pxt9SI1xfb8=
X-Received: by 2002:a5d:64cc:0:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-38f4fa6bca3mr698753f8f.39.1739808814051; Mon, 17 Feb 2025
 08:13:34 -0800 (PST)
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
 <CA+fCnZfySpeRy0FCFidLdUUeqp97eBdjAqQyYPpz1WxYwcsW9A@mail.gmail.com>
 <aqhm7lc57srsfuff3bceb3dcmsdyxksb7t6bgwbqi54ppevpoh@apolj3nteaz6>
 <CA+fCnZdjTkreTcoo+J8wMhwDuAFM4g33U5BFy0OPtE0UCvyJbQ@mail.gmail.com>
 <CA+fCnZcoVdfXVN8VBFLx835cV0eGAT6Ewror2whLW761JnHjNQ@mail.gmail.com>
 <sjownmnyf4ygi5rtbedan6oauzvyk2d7xcummo5rykiryrpcrt@kasomz5imkkm> <tuwambkzk6ca5mpni7ev5hvr47dkbk6ru3vikplx67hyvqj2sw@rugqv7vhikxb>
In-Reply-To: <tuwambkzk6ca5mpni7ev5hvr47dkbk6ru3vikplx67hyvqj2sw@rugqv7vhikxb>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 17:13:23 +0100
X-Gm-Features: AWEUYZmQ1uvVHZE607fk9A3oqamhim11vzns-dfPoe7sFHHzYYWlnLIpBeOBi1A
Message-ID: <CA+fCnZcHnWr0++8omB5ju8E3uSK+s+JOFZ3=UqgtVEcBzrm2Lg@mail.gmail.com>
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

On Fri, Feb 14, 2025 at 9:21=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> On 2025-02-13 at 17:20:22 +0100, Maciej Wieczor-Retman wrote:
> >On 2025-02-13 at 02:28:08 +0100, Andrey Konovalov wrote:
> >>On Thu, Feb 13, 2025 at 2:21=E2=80=AFAM Andrey Konovalov <andreyknvl@gm=
ail.com> wrote:
> >>>
> >>> On Tue, Feb 11, 2025 at 7:07=E2=80=AFPM Maciej Wieczor-Retman
> >>> <maciej.wieczor-retman@intel.com> wrote:
> >>> >
> >>> > I did some experiments with multiple addresses passed through
> >>> > kasan_mem_to_shadow(). And it seems like we can get almost any addr=
ess out when
> >>> > we consider any random bogus pointers.
> >>> >
> >>> > I used the KASAN_SHADOW_OFFSET from your example above. Userspace a=
ddresses seem
> >>> > to map to the range [KASAN_SHADOW_OFFSET - 0xffff8fffffffffff]. The=
n going
> >>> > through non-canonical addresses until 0x0007ffffffffffff we reach t=
he end of
> >>> > kernel LA and we loop around. Then the addresses seem to go from 0 =
until we
> >>> > again start reaching the kernel space and then it maps into the pro=
per shadow
> >>> > memory.
> >>> >
> >>> > It gave me the same results when using the previous version of
> >>> > kasan_mem_to_shadow() so I'm wondering whether I'm doing this exper=
iment
> >>> > incorrectly or if there aren't any addresses we can rule out here?
> >>>
> >>> By the definition of the shadow mapping, if we apply that mapping to
> >>> the whole 64-bit address space, the result will only contain 1/8th
> >>> (1/16th for SW/HW_TAGS) of that space.
> >>>
> >>> For example, with the current upstream value of KASAN_SHADOW_OFFSET o=
n
> >>> x86 and arm64, the value of the top 3 bits (4 for SW/HW_TAGS) of any
> >>> shadow address are always the same: KASAN_SHADOW_OFFSET's value is
> >>> such that the shadow address calculation never overflows. Addresses
> >>> that have a different value for those top 3 bits are the once we can
> >>> rule out.
> >>
> >>Eh, scratch that, the 3rd bit from the top changes, as
> >>KASAN_SHADOW_OFFSET is not a that-well-aligned value, the overall size
> >>of the mapping holds.
> >>
> >>> The KASAN_SHADOW_OFFSET value from my example does rely on the
> >>> overflow (arguably, this makes things more confusing [1]). But still,
> >>> the possible values of shadow addresses should only cover 1/16th of
> >>> the address space.
> >>>
> >>> So whether the address belongs to that 1/8th (1/16th) of the address
> >>> space is what we want to check in kasan_non_canonical_hook().
> >>>
> >
> >Right, I somehow forgot that obviously the whole LA has to map to 1/16th=
 of the
> >address space and it shold stay contiguous.
> >
> >After rethinking how the mapping worked before and will work after makin=
g stuff
> >signed I thought this patch could make use of the overflow?
> >
> >From what I noticed, all the Kconfig values for KASAN_SHADOW_OFFSET shou=
ld make
> >it so there will be overflow when inputing more and more positive addres=
ses.
> >
> >So maybe we should first find what the most negative and most positive (=
signed)
> >addresses map to in shadow memory address space. And then when looking f=
or
> >invalid values that aren't the product of kasan_mem_to_shadow() we shoul=
d check
> >
> >       if (addr > kasan_mem_to_shadow(biggest_positive_address) &&
> >           addr < kasan_mem_to_shadow(smallest_negative_address))
> >               return;
> >
> >Is this correct?
>
> I suppose the original code in the patch does the same thing when you cha=
nge the
> || into &&:
>
>         if (addr < KASAN_SHADOW_OFFSET - max_shadow_size / 2 &&
>             addr >=3D KASAN_SHADOW_OFFSET + max_shadow_size / 2)
>                 return;
>
> kasan_mem_to_shadow(0x7FFFFFFFFFFFFFFF) -> 0x07ff7fffffffffff
> kasan_mem_to_shadow(0x8000000000000000) -> 0xf7ff800000000000

I'm a bit lost with these calculations at this point. Please send the
full patch, including the new values for KASAN_SHADOW_OFFSET (do I
understand correctly that you want to change them?). It'll be easier
to look at the code.

Feel free to send this patch separately from the rest of the series,
so that we can finalize it first.


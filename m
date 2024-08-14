Return-Path: <linux-kernel+bounces-286817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E44951F57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084031F23911
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133091B5808;
	Wed, 14 Aug 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdaAfR3p"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE91B580C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651407; cv=none; b=GTV/EkPvt9KGQS8gV71LtXAYDG2GKIbKxwj6xKmS14r7AvVZbQegIxiJ8gALW7v/Vg9uOjFvNvMOil4ujPQ3dIa6qpy6LAIdG++ShEmg4YBszVYhLR7nVgToGi4RnkP8sWTvEvSzWZEnHmtt4p+sQTG0j4ZfK/5qj4moOuOht2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651407; c=relaxed/simple;
	bh=TiI2ZI5HiK8DekkXce+tlQ8vhXo6Fkg2anaLIK4AlBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPt/rNI69KVNoXuW+Q434CrMm0B0EddNcfeSXWe8VpMsyM+MTJF0hGQd2ZJ4r0T7YVgSVlId+kHY2XDWV5kwC83smDXZ6doz5yRagu+gSyAktUO5MZmETLVRMyK9q+zZqZ0KUnYqmbS8YsSNESjOfpp+Wca3l8HSpSqbxTkDSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdaAfR3p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428178fc07eso46713805e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651404; x=1724256204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHzTMnbxJwH6LulEheHcfUtlUWn0EPZAfPsSwomgDYU=;
        b=KdaAfR3pIASkNUpGCYJ0BMBrqxoeEZ199O4uWj5Kdw4Fwo+PEbz8rZEfGlUyKJXRIl
         GLpRS02QTsOZXmJZy7uv9A8z8kM14ouhCSjWJQb2nQuehNbnJXPVPY/cq5Sp6vRs5uUb
         R/9DjJVUHJk+Hy1MZRpg5XRPxrT43sGeBl/8pg7j9ESwluIQqCzqpmfaheuDXysLV2zm
         C0vfGOpbhrsPjWtZOhOFMPLIKibn7NL964PDxtwDx4tzFbpXdqcXT5p5tJzjkGUpABBs
         /zHVC3wfny4ZkjaO/SHdfQi8Q3iQDtzzYK4eGPVEQoH/ngi434v0vgzs79DtKEGAlWwi
         mnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651404; x=1724256204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHzTMnbxJwH6LulEheHcfUtlUWn0EPZAfPsSwomgDYU=;
        b=NfmDRs5+GWpUL3PlmGk/na7WDuWyUFyFZj9Y28EBpOnSCDEbkhOzqEv7OHVWvnUSQp
         Jv0wSeibpdbxWaQ7bDHCILctC7TOxFN7/k9hF8Hc7msLo/qOk+JSbMa+TYIZsBGCY30I
         cqYcEsy1SgJ+CSZI3KCuCwXyXj18pLmM6gJQXDjhEHfzM2L6EtfPtDNxF0IBhd0MGBnc
         1x1A/ytpzOY0GYuXxYKVC0pFmErlKfPZOsZksdNaiXJOilwrFMGPWMdRNTNiXdO9Ig7I
         MPr61oZWV2dn4EgS+7WBYS09uwTHusdBk7b54NZtZ3nenI5JOj9CTYqoa/ukwnBaBWV7
         aqlA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Zv7Qbcj41aWhiUrL0JlJl0gvNJlGRB3FHYz8iReT4wyI0LoPjal8J2cYJIYUkP3A45kGmFdBJwAfsfgbtgvEgw4QiPjzV+K18zsT
X-Gm-Message-State: AOJu0YwIimfjGmdP/qkCrz1bRzk2Jk9Q+TKeDDpqlggUkdMyqjUNtgr3
	7vhrVuEDRejqPtGa9MO75dXkFwZ+TGpQxVdTqEY6+nEyYfxyt8AkUBsRQpQcnV4JDddtbzAanKr
	runbtqRyxms5Mwv6d0tHsSQSNDgg=
X-Google-Smtp-Source: AGHT+IFCfJTnajyYYCqxlWi49n74UtAquQNfM8wgnTC0c8J3TvO5sJy7++uqXkTo0CGLK/Rtpp3hKUkxAInZu3lUAx0=
X-Received: by 2002:a05:600c:46cd:b0:427:9dad:17df with SMTP id
 5b1f17b1804b1-429dd23bf18mr21690025e9.12.1723651403192; Wed, 14 Aug 2024
 09:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814085618.968833-1-samuel.holland@sifive.com>
In-Reply-To: <20240814085618.968833-1-samuel.holland@sifive.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Aug 2024 18:03:12 +0200
Message-ID: <CA+fCnZf0H2yqHUOzQR1vJV=-NK-HVU0d372kavcNjsDd_XY5+g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] kasan: RISC-V support for KASAN_SW_TAGS using
 pointer masking
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:56=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This series implements support for software tag-based KASAN using the
> RISC-V pointer masking extension[1], which supports 7 and/or 16-bit
> tags. This implementation uses 7-bit tags, so it is compatible with
> either hardware mode. Patch 3 adds supports for KASAN_SW_TAGS with tag
> widths other than 8 bits.

This is awesome!

> Pointer masking is an optional ISA extension, and it must be enabled
> using an SBI call to firmware on each CPU. If the SBI call fails on the
> boot CPU, KASAN is globally disabled. Patch 2 adds support for boot-time
> disabling of KASAN_SW_TAGS.
>
> The SBI call is part of the upcoming SBI Firmware Features (FWFT)
> extension[2][3]. Since generic FWFT support is not yet merged to Linux,
> I open-coded the sbi_ecall() in this RFC to keep this series focused.
>
> With my RISC-V KASAN fixes series[4] applied, this implementation passes
> all but one of the KASAN KUnit tests. It fails vmalloc_percpu(), which
> also fails on arm64:

Hm, this test passes on arm64 for me. Could you share the kernel
config that you used?


>
>       ...
>       ok 65 vmalloc_oob
>       ok 66 vmap_tags
>       ok 67 vm_map_ram_tags
>       # vmalloc_percpu: EXPECTATION FAILED at mm/kasan/kasan_test.c:1785
>       Expected (u8)((u8)((u64)(c_ptr) >> 57)) < (u8)0x7f, but
>           (u8)((u8)((u64)(c_ptr) >> 57)) =3D=3D 127 (0x7f)
>           (u8)0x7f =3D=3D 127 (0x7f)
>       # vmalloc_percpu: EXPECTATION FAILED at mm/kasan/kasan_test.c:1785
>       Expected (u8)((u8)((u64)(c_ptr) >> 57)) < (u8)0x7f, but
>           (u8)((u8)((u64)(c_ptr) >> 57)) =3D=3D 127 (0x7f)
>           (u8)0x7f =3D=3D 127 (0x7f)
>       # vmalloc_percpu: EXPECTATION FAILED at mm/kasan/kasan_test.c:1785
>       Expected (u8)((u8)((u64)(c_ptr) >> 57)) < (u8)0x7f, but
>           (u8)((u8)((u64)(c_ptr) >> 57)) =3D=3D 127 (0x7f)
>           (u8)0x7f =3D=3D 127 (0x7f)
>       # vmalloc_percpu: EXPECTATION FAILED at mm/kasan/kasan_test.c:1785
>       Expected (u8)((u8)((u64)(c_ptr) >> 57)) < (u8)0x7f, but
>           (u8)((u8)((u64)(c_ptr) >> 57)) =3D=3D 127 (0x7f)
>           (u8)0x7f =3D=3D 127 (0x7f)
>       not ok 68 vmalloc_percpu
>       ok 69 match_all_not_assigned
>       ok 70 match_all_ptr_tag
>       ...
>   # kasan: pass:62 fail:1 skip:8 total:71
>   # Totals: pass:62 fail:1 skip:8 total:71
>
> I'm not sure how I'm supposed to hook in to the percpu allocator.
>
> When running with hardware or firmware that doesn't support pointer
> masking, the kernel still boots successfully:
>
>   kasan: test: Can't run KASAN tests with KASAN disabled
>       # kasan:     # failed to initialize (-1)
>   not ok 1 kasan
>
> If stack tagging is enabled but pointer masking is unsupported, an extra
> change (patch 7) is required so all pointers to stack variables are
> tagged with KASAN_TAG_KERENL and can be dereferenced. I'm not sure if
> this change should be RISC-V specific or made more generic.
>
> This series can be tested by applying patch series to LLVM[5], QEMU[6],
> and OpenSBI[7].
>
> [1]: https://github.com/riscv/riscv-j-extension/releases/download/pointer=
-masking-v1.0.0-rc2/pointer-masking-v1.0.0-rc2.pdf
> [2]: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-f=
irmware-features.adoc
> [3]: https://github.com/riscv-non-isa/riscv-sbi-doc/pull/161
> [4]: https://lore.kernel.org/linux-riscv/20240801033725.28816-1-samuel.ho=
lland@sifive.com/
> [5]: https://github.com/SiFiveHolland/llvm-project/commits/up/riscv64-ker=
nel-hwasan
> [6]: https://lore.kernel.org/qemu-devel/20240511101053.1875596-1-me@deliv=
ersmonkey.space/
> [7]: https://lists.infradead.org/pipermail/opensbi/2024-August/007244.htm=
l
>
>
> Samuel Holland (7):
>   kasan: sw_tags: Use arithmetic shift for shadow computation
>   kasan: sw_tags: Check kasan_flag_enabled at runtime
>   kasan: sw_tags: Support tag widths less than 8 bits
>   riscv: Do not rely on KASAN to define the memory layout
>   riscv: Align the sv39 linear map to 16 GiB
>   riscv: Implement KASAN_SW_TAGS
>   kasan: sw_tags: Support runtime stack tagging control for RISC-V
>
>  Documentation/arch/riscv/vm-layout.rst | 10 ++---
>  Documentation/dev-tools/kasan.rst      | 14 +++---
>  arch/arm64/Kconfig                     | 10 ++---
>  arch/arm64/include/asm/kasan.h         |  6 ++-
>  arch/arm64/include/asm/memory.h        |  8 ++++
>  arch/arm64/include/asm/uaccess.h       |  1 +
>  arch/arm64/mm/kasan_init.c             |  7 ++-
>  arch/riscv/Kconfig                     |  4 +-
>  arch/riscv/include/asm/cache.h         |  4 ++
>  arch/riscv/include/asm/kasan.h         | 29 +++++++++++-
>  arch/riscv/include/asm/page.h          | 21 +++++++--
>  arch/riscv/include/asm/pgtable.h       |  6 +++
>  arch/riscv/include/asm/tlbflush.h      |  4 +-
>  arch/riscv/kernel/setup.c              |  6 +++
>  arch/riscv/kernel/smpboot.c            |  8 +++-
>  arch/riscv/lib/Makefile                |  2 +
>  arch/riscv/lib/kasan_sw_tags.S         | 61 ++++++++++++++++++++++++++
>  arch/riscv/mm/init.c                   |  2 +-
>  arch/riscv/mm/kasan_init.c             | 30 ++++++++++++-
>  arch/riscv/mm/physaddr.c               |  4 ++
>  include/linux/kasan-enabled.h          | 15 +++----
>  include/linux/kasan-tags.h             | 13 +++---
>  include/linux/kasan.h                  | 10 ++++-
>  mm/kasan/hw_tags.c                     | 10 -----
>  mm/kasan/kasan.h                       |  2 +
>  mm/kasan/sw_tags.c                     |  9 ++++
>  mm/kasan/tags.c                        | 10 +++++
>  scripts/Makefile.kasan                 |  5 +++
>  scripts/gdb/linux/mm.py                |  5 ++-
>  29 files changed, 255 insertions(+), 61 deletions(-)
>  create mode 100644 arch/riscv/lib/kasan_sw_tags.S
>
> --
> 2.45.1
>


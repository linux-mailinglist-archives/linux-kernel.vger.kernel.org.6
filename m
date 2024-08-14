Return-Path: <linux-kernel+bounces-286138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55405951726
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD31B1F24D67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF491143895;
	Wed, 14 Aug 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q9Yne//3"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC4143748
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625782; cv=none; b=V+MB45ysd0/TZHF/EqcxS3jDv4Vaw2qlmEmQQh9Y/mhAHSItO+po6rU/z1ZfvDwEOjAyZk0zm6ABE2PbqNahyEUCEiXmrMOtChLHnHuYw1H/FsMb7+h5wXlTMe9ADpzOKpqCVus+1B3vDSCOYmrkeb/k33zPtruqt5m9Dmd3S+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625782; c=relaxed/simple;
	bh=wQadCnmy4aDcLg/pGq/A/efWmWs40BThFFBuvYrZ3ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrM74Dfr7BcvimyIKnK0+KuI5TdgK2VzObrJquy3kmrR8bF4vJVKwA6psMP9AKBEbicSEi1S7GfZz1f/6+nNP2dzc4APlly2k8zJ78OTBV3igOUBFNVpNiqcEH/mqoygOSV31rq9Xag938RFpVift3a7Sp8mhYGjNa97HUnKF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q9Yne//3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd69e44596so4831045ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723625780; x=1724230580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmaS/ucUO4ax4xArhdHVTXE+tGzy8O1URFQiuKQW0B8=;
        b=Q9Yne//3yiEh6QwwRWcWu3ChqXMg9AIzSW3jy/s0vthx58URDT6ckNWojFK6B7ufAb
         aD7aosAj+gtdhNd7yXpfFXfRtbXZum68Yi0GFus6pO4JtaETKD64EF9bAl2AY9lxjrZI
         lqzFRxgowageb93PlO1oa3owvY0S/xCVe+xfctxUxjGiH5gK7yYEOJc+GECzaMd9jiaC
         KGYpXMO9YECKvhOeg/Dw50WpvTwic57ZRUlo4B0Bs+2c5Wdcztca8PB+d5mANJP2kUpr
         zhowb001574wVX0ah7nW7OjbVVsCDGs8l2q42o8ve6pgx8Dz8ApwP5MGuWXNRnBp0kRo
         gBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625780; x=1724230580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmaS/ucUO4ax4xArhdHVTXE+tGzy8O1URFQiuKQW0B8=;
        b=C51AiXaHou7qvSw/m06KgXkaq9Ef+w8zA8Wd6jN7squz3cqAMYjTPd/4epcNSn8GZp
         NYRkZ6Oq0D5UMpMsTkTncxXOeXb1eevc3vi+U2D7BEgiO8VbbJaxYph/5zqnvqR41Fpd
         R2TqGZL150fEImxkU/XOcgN6yfbNGyFBAQkH7hVpHeLYXzmDTNl1RJz5y1r3StAfI0q3
         Sc6xcxGQYnQoXPu7B4D4kSDxndedksviC1JYaMDFYtKhKsOOfBAe8OVefu2sb9hRfuwZ
         QTj3UQi17PC4ztmDP0Zzd2seKy2nadcLyUoNHMspPNoJc0JtymbywEH8mBGXeubJRXzQ
         3tVw==
X-Forwarded-Encrypted: i=1; AJvYcCXQc+zwLN7dQ7PFr8DzwNhJUzd7oItdXzYFttjbA87hnJjVVD2sVOICuG8fk22Ta5yNCc/M7wWH6IIEqnrxFxFCBJawTmj9yJfjgaAX
X-Gm-Message-State: AOJu0YwanU74S+6UCRabNUPRkSvcZI+2Ya2oyX3ihYvpvNGt9rP3uox5
	tbA3xlyeKZrpm2kQfYXGpw8oms/9gS0349Jk5mOD43ljQTbqqYvWYq8VatIc02F/u3lnwAacua9
	O
X-Google-Smtp-Source: AGHT+IH1j+rcWR7Ja5u/brytrbI7rlDNEm3iDMni88s3lw2tXNH8pNxbcK4NC9zx6bdDjtDvIkOIow==
X-Received: by 2002:a17:902:da86:b0:1fd:8b77:998e with SMTP id d9443c01a7336-201d9a28d73mr22221125ad.29.1723625780442;
        Wed, 14 Aug 2024 01:56:20 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14a7b8sm25439615ad.100.2024.08.14.01.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:56:20 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 0/7] kasan: RISC-V support for KASAN_SW_TAGS using pointer masking
Date: Wed, 14 Aug 2024 01:55:28 -0700
Message-ID: <20240814085618.968833-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements support for software tag-based KASAN using the
RISC-V pointer masking extension[1], which supports 7 and/or 16-bit
tags. This implementation uses 7-bit tags, so it is compatible with
either hardware mode. Patch 3 adds supports for KASAN_SW_TAGS with tag
widths other than 8 bits.

Pointer masking is an optional ISA extension, and it must be enabled
using an SBI call to firmware on each CPU. If the SBI call fails on the
boot CPU, KASAN is globally disabled. Patch 2 adds support for boot-time
disabling of KASAN_SW_TAGS.

The SBI call is part of the upcoming SBI Firmware Features (FWFT)
extension[2][3]. Since generic FWFT support is not yet merged to Linux,
I open-coded the sbi_ecall() in this RFC to keep this series focused.

With my RISC-V KASAN fixes series[4] applied, this implementation passes
all but one of the KASAN KUnit tests. It fails vmalloc_percpu(), which
also fails on arm64:

      ...
      ok 65 vmalloc_oob
      ok 66 vmap_tags
      ok 67 vm_map_ram_tags
      # vmalloc_percpu: EXPECTATION FAILED at mm/kasan/kasan_test.c:1785
      Expected (u8)((u8)((u64)(c_ptr) >> 57)) < (u8)0x7f, but
          (u8)((u8)((u64)(c_ptr) >> 57)) == 127 (0x7f)
          (u8)0x7f == 127 (0x7f)
      # vmalloc_percpu: EXPECTATION FAILED at mm/kasan/kasan_test.c:1785
      Expected (u8)((u8)((u64)(c_ptr) >> 57)) < (u8)0x7f, but
          (u8)((u8)((u64)(c_ptr) >> 57)) == 127 (0x7f)
          (u8)0x7f == 127 (0x7f)
      # vmalloc_percpu: EXPECTATION FAILED at mm/kasan/kasan_test.c:1785
      Expected (u8)((u8)((u64)(c_ptr) >> 57)) < (u8)0x7f, but
          (u8)((u8)((u64)(c_ptr) >> 57)) == 127 (0x7f)
          (u8)0x7f == 127 (0x7f)
      # vmalloc_percpu: EXPECTATION FAILED at mm/kasan/kasan_test.c:1785
      Expected (u8)((u8)((u64)(c_ptr) >> 57)) < (u8)0x7f, but
          (u8)((u8)((u64)(c_ptr) >> 57)) == 127 (0x7f)
          (u8)0x7f == 127 (0x7f)
      not ok 68 vmalloc_percpu
      ok 69 match_all_not_assigned
      ok 70 match_all_ptr_tag
      ...
  # kasan: pass:62 fail:1 skip:8 total:71
  # Totals: pass:62 fail:1 skip:8 total:71

I'm not sure how I'm supposed to hook in to the percpu allocator.

When running with hardware or firmware that doesn't support pointer
masking, the kernel still boots successfully:

  kasan: test: Can't run KASAN tests with KASAN disabled
      # kasan:     # failed to initialize (-1)
  not ok 1 kasan

If stack tagging is enabled but pointer masking is unsupported, an extra
change (patch 7) is required so all pointers to stack variables are
tagged with KASAN_TAG_KERENL and can be dereferenced. I'm not sure if
this change should be RISC-V specific or made more generic.

This series can be tested by applying patch series to LLVM[5], QEMU[6],
and OpenSBI[7].

[1]: https://github.com/riscv/riscv-j-extension/releases/download/pointer-masking-v1.0.0-rc2/pointer-masking-v1.0.0-rc2.pdf
[2]: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-firmware-features.adoc
[3]: https://github.com/riscv-non-isa/riscv-sbi-doc/pull/161
[4]: https://lore.kernel.org/linux-riscv/20240801033725.28816-1-samuel.holland@sifive.com/
[5]: https://github.com/SiFiveHolland/llvm-project/commits/up/riscv64-kernel-hwasan
[6]: https://lore.kernel.org/qemu-devel/20240511101053.1875596-1-me@deliversmonkey.space/
[7]: https://lists.infradead.org/pipermail/opensbi/2024-August/007244.html


Samuel Holland (7):
  kasan: sw_tags: Use arithmetic shift for shadow computation
  kasan: sw_tags: Check kasan_flag_enabled at runtime
  kasan: sw_tags: Support tag widths less than 8 bits
  riscv: Do not rely on KASAN to define the memory layout
  riscv: Align the sv39 linear map to 16 GiB
  riscv: Implement KASAN_SW_TAGS
  kasan: sw_tags: Support runtime stack tagging control for RISC-V

 Documentation/arch/riscv/vm-layout.rst | 10 ++---
 Documentation/dev-tools/kasan.rst      | 14 +++---
 arch/arm64/Kconfig                     | 10 ++---
 arch/arm64/include/asm/kasan.h         |  6 ++-
 arch/arm64/include/asm/memory.h        |  8 ++++
 arch/arm64/include/asm/uaccess.h       |  1 +
 arch/arm64/mm/kasan_init.c             |  7 ++-
 arch/riscv/Kconfig                     |  4 +-
 arch/riscv/include/asm/cache.h         |  4 ++
 arch/riscv/include/asm/kasan.h         | 29 +++++++++++-
 arch/riscv/include/asm/page.h          | 21 +++++++--
 arch/riscv/include/asm/pgtable.h       |  6 +++
 arch/riscv/include/asm/tlbflush.h      |  4 +-
 arch/riscv/kernel/setup.c              |  6 +++
 arch/riscv/kernel/smpboot.c            |  8 +++-
 arch/riscv/lib/Makefile                |  2 +
 arch/riscv/lib/kasan_sw_tags.S         | 61 ++++++++++++++++++++++++++
 arch/riscv/mm/init.c                   |  2 +-
 arch/riscv/mm/kasan_init.c             | 30 ++++++++++++-
 arch/riscv/mm/physaddr.c               |  4 ++
 include/linux/kasan-enabled.h          | 15 +++----
 include/linux/kasan-tags.h             | 13 +++---
 include/linux/kasan.h                  | 10 ++++-
 mm/kasan/hw_tags.c                     | 10 -----
 mm/kasan/kasan.h                       |  2 +
 mm/kasan/sw_tags.c                     |  9 ++++
 mm/kasan/tags.c                        | 10 +++++
 scripts/Makefile.kasan                 |  5 +++
 scripts/gdb/linux/mm.py                |  5 ++-
 29 files changed, 255 insertions(+), 61 deletions(-)
 create mode 100644 arch/riscv/lib/kasan_sw_tags.S

-- 
2.45.1



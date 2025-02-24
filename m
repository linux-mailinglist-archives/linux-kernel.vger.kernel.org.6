Return-Path: <linux-kernel+bounces-529729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13657A42A47
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D8E7A6201
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81B26463B;
	Mon, 24 Feb 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OoojtEWQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47732641C2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419222; cv=none; b=FM/Fhu1wnZF5e4WEuspwMORha4gTSjKMIh+CzVzTxfQgUw1Jgdy+J6NtRlmJQl9zvIAOr+rmyjFh5jUxsPfSbPKN9GHMsfGTVjZUbysA7VwbEuVapjxkwH23gNAM5a8nB2YQubRRLR+IIX0qnH21U3gSX7AOoV6u+ltdK6lSOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419222; c=relaxed/simple;
	bh=hSIR9nCZ9neu209h1KEfLIsL4PxEQ8sqc0mwyA7wrck=;
	h=Date:Subject:CC:From:To:Message-ID; b=Ao5hp6T9tPaBwAfgiZD55NgIsFPLecLuhGNW6nVE0eSmeta/K3QtQ9M965C0jeyxm71Lr4PUPuyGdO7dbdudxEwTHvL7GLqrWhh5PSdRPnvdbWhonrryd8EFtI1A5jBxEG2NU8oF8ehE5J9g5QFd+pLV8zW1BMNBYu52nwrQRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OoojtEWQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2211cd4463cso94466515ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740419219; x=1741024019; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KREiZn2aUeoZOCpfTgjekuUtulMZqcTrq1Q4qOlgv1k=;
        b=OoojtEWQXCKeyLuadS6jwXocWATsufUA2t7QQzEV/xSOHjcgymc6U13hpeUNdEJKWl
         PxPZeSZR4TZ2Bwc4EeBpiMdly7xiEEXG5l7hkphDBpqn3eZ0634YflqkXnEm/woYSkkg
         EU7AKPvje771DTLrqP7ANFhQjC+vaoz0uJhZRTNoC+ccZVpOd1qYUse+Oh9BGno4Fw8S
         4wT8RToRuPs5DIoY+zqwKkJFaHIXXZNnX19rmhHUCpcvY9bVi51Nrxct/vOu61J6onAC
         hAhtKtoW/pbWaZameuwM+nFPDgB9bVNOSyUlLquQ2WuUfvqHlDsI8XGjxtuyO/6TwnJC
         BI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419219; x=1741024019;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KREiZn2aUeoZOCpfTgjekuUtulMZqcTrq1Q4qOlgv1k=;
        b=Mqc9qJ5O7alIoUuuyAdCD3nI+L8oQhf97ikRLezlkAE3Z6X1KN3Bw3uvAnVTeTEdkP
         IBlgZf4Oc1SDnA2WGwXCX95z9sR6yWmsvUZrYXlmG+5FCQkRcmQ8fQ6eafG3I3a6um6H
         7HTREziuweKbKr+IyjJOeBR6K1+J7beU01aqcw3wv4rAW74q+72U1DMYCm84Gnslxo+W
         I/ZA5ch0kygHAHoxFSUHOm+GGVJifPaMXhCm86UwNyh7I+nvaXrG7DSTVgAYhIo7vh3h
         lkZK6XjxFdP9EqeUXj6kM3cBrYpoQjLkU74/NuWFQniF7ipD4jcMFTjLjNTFuBNatGX4
         IBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/bwUQqGERkPGll5ddmSvgQMEXhQHjJ9aAEjYc5ybxAU+nKb6TOFzDtc3Tjw+L/zxEX3c//5QvLZFbJaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8LEEK+d37R/w88sZ+XhSssEH9d6gsswTsf/NmmQJWHFjNvp8
	udN15Kl4tu6u2hnYSRZ+Y9RTkN/k0oda0HUYIKj6AmeiMtNxrp7qMdgxO7w5MVA3vFXwI8jDm2e
	C
X-Gm-Gg: ASbGncsni7wBjixYIHjlScmXo4Efwy2ozojLsCCtGjqv42/Ma2wXPRhEFp9jIMpKen2
	zr5enE/2liSfQ1qtHDWzkJ1vK/6ji0Fal0LoLWyoc/IsJLp6C9bZ0v9+B6U/IixBaW21VJZD5hp
	pmJ9vatc7mul/7mA0xEYXtUYdB8rJcW7fweFDtSpDby50qmGcYoqr6naT4tO4KTGHV0Mid1YsEr
	K93cyp3rHNcn5w23uv9mM0S0hDq758gIj45LrQvoRszg9XxjQCu6HzkVknKQj+abI2Hb+P2BeXV
	b46RJamulfpVO1p8wdG8
X-Google-Smtp-Source: AGHT+IEqwoMOmZ5jmn9mB/+E7cZKw/Jpq0fEXvB/J6j6P9smWjlAXhhBE2c8WtKUt9TrKsEvhEYJdA==
X-Received: by 2002:a17:903:188:b0:21f:3e2d:7d42 with SMTP id d9443c01a7336-22307b5ad60mr1717165ad.23.1740419218777;
        Mon, 24 Feb 2025 09:46:58 -0800 (PST)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d473sm182695845ad.166.2025.02.24.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:46:58 -0800 (PST)
Date: Mon, 24 Feb 2025 09:46:58 -0800 (PST)
X-Google-Original-Date: Mon, 24 Feb 2025 09:46:55 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.14-rc5
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-179f0b99-b80c-48dd-8eab-c795872207d0@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.14-rc5

for you to fetch changes up to 245aece3750d3692ae7a44516c1096936bded7ab:

  MAINTAINERS: Add myself as a riscv reviewer (2025-02-14 13:06:55 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.14-rc5

* A fix for cacheinfo DT probing to avoid reading non-boolean properties
  as booleans.
* A fix for cpufeature to use bitmap_equal() instead of memcmp(), so
  unused bits are ignored.
* Fixes for cmpxchg and futex cmpxchg that properly encode the sign
  extension requirements on inline asm, which results in spurious
  successes.  This manifests in at least inode_set_ctime_current, but is
  likely just a disaster waiting to happen.
* A fix for the rseq selftests, which was using an invalid constraint.
* A pair of fixes for signal frame size handling:
    * We were reserving space for an extra empty extension context
      header on systems with extended signal context, thus resulting in
      unnecessarily large allocations.
    * We weren't properly checking for available extensions before
      calculating the signal stack size, which resulted in undersized
      stack allocations on some systems (at least those with T-Head
      custom vectors).

Also, we've added Alex as a reviewer.  He's been helping out a ton
lately, thanks!

----------------------------------------------------------------
I've been sending PRs on Friday mornings, but these days the week seems to just
run away from me.  That happened the last two weeks and I've been meaning to
try Monday mornings for a while now, so I figured I'll just give it a shot.

Aside from that these all look fine to me: they build/boot like normal, aside
from a spurious Sparse warning in the cmpxchg code.  That might be worth
working around, but doesn't seem like it's worth delaying a fix for a nasty bug
on it.

----------------------------------------------------------------
Alexandre Ghiti (1):
      MAINTAINERS: Add myself as a riscv reviewer

Andreas Schwab (2):
      riscv/atomic: Do proper sign extension also for unsigned in arch_cmpxchg
      riscv/futex: sign extend compare value in atomic cmpxchg

Clément Léger (1):
      riscv: cpufeature: use bitmap_equal() instead of memcmp()

Rob Herring (1):
      riscv: cacheinfo: Use of_property_present() for non-boolean properties

Stafford Horne (1):
      rseq/selftests: Fix riscv rseq_offset_deref_addv inline asm

Yong-Xuan Wang (2):
      riscv: signal: fix signal frame size
      riscv: signal: fix signal_minsigstksz

 MAINTAINERS                                    |  1 +
 arch/riscv/include/asm/cmpxchg.h               |  2 +-
 arch/riscv/include/asm/futex.h                 |  2 +-
 arch/riscv/kernel/cacheinfo.c                  | 12 ++++++------
 arch/riscv/kernel/cpufeature.c                 |  2 +-
 arch/riscv/kernel/setup.c                      |  2 +-
 arch/riscv/kernel/signal.c                     |  6 ------
 tools/testing/selftests/rseq/rseq-riscv-bits.h |  6 +++---
 tools/testing/selftests/rseq/rseq-riscv.h      |  2 +-
 9 files changed, 15 insertions(+), 20 deletions(-)


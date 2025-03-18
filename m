Return-Path: <linux-kernel+bounces-566712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05351A67B96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EC84243AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5B214233;
	Tue, 18 Mar 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohGOqbDy"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051B2139C6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320998; cv=none; b=NJQakjqijpEyysBIa6vrY2M/VCi3/ZPWYvWbuBkiO8J9geVVZml3jvPopvbzKAw9Lm4Zq1vHNAJ3Td9oGdGbRJJZ3onEHBjSbLCrz1N2groGWxAX1K3aJ1JNJ/NHYHRvwwy1Zl1uiWcTp1TPxvZE5akDvzVMr9pBsjhXWJXUkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320998; c=relaxed/simple;
	bh=t2y7MLSmqBahZlOJbeUcz2phe/8UW6fcn4ArpDITisc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3bBTYHETKfofXDfVqAAMtlvZ2V2+xd0Uq7J2Iro+D2eFd++g2eouw2mU7YU1KGh7ZADJknIioyCLRRp/r6TUQDzkF8mANU+BwOcK1o38XRdhBw2Kuk/T+20TtOAvI2t4T/vpEF9HrpNv0K1Wqg4K/WLXAvBxHyxwjg2L2lI4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohGOqbDy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254bdd4982so131926165ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742320996; x=1742925796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Bwe5cvflu2orXWbFuKj4RxdZ74SOqyjelcoad5bS8dY=;
        b=ohGOqbDyvtA1Ey7uZRI9orb1vNOoJpty44O7JNsXIOdSsTdTub6tFEEIWqUoNj4dY9
         H9AiTXmb//j9UgEUfhzS3/SVQfkaM3mxStAaiBsGJoFvC6FVkb8EYOWNqizb2SNlUGoB
         eZYrXCkLDjHdnwACvFu/MvzU0+WftPqkjnwSvDoV7HuSdFkObac6fGrJ9mZzSEbFq2HB
         8p5TwNpg5sB/RaiG2tVO6rYtO52Sg8UXssFLxuvaiUziDO1YtpHy4B1mHFyvsitaugf9
         k4A6QCecxDYUsLCd1ZAM6GnIrMBaUBQsYdCJmjMQkvQoFloLBIn4FlBPjAVZws63dlIP
         f//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320996; x=1742925796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bwe5cvflu2orXWbFuKj4RxdZ74SOqyjelcoad5bS8dY=;
        b=JFwzYxCBCdLSrkTl2uK5iQqAbrZ89tMGXVU4w7ibWg3G1nZYP9xtwnvncOmoI0jhSv
         mamCKBwqoiQbxCyVapAfTd/pG/4tS5SxK4mvmOUA0GYwXtyLfhMkbRVgabQXZhgERoc2
         7Da1RZGMuISCMuSP57V1sx8MwgNMA2Pt4D86dO7ktUZk8rHWOAKGzsYP5/UvzANDN3Ax
         zQhXKw3GvYSPWHqN6cjtwsbDHz4c9Z7VILESLySBod5pyaGeosaIwpWtbWHwsR4/HScw
         9xUR+18NyoftiTrjKXNqbwGHODLo+6VAf4hr86tOGIO0fRaZW1BfuhcGacxYIjqanYee
         kmCg==
X-Forwarded-Encrypted: i=1; AJvYcCW+IUaCn+GcuHTNcs9xeNphvdFNd/eFj0luPFBPB4cpbkGaHsmCViymjRRktfdTyDnJwPRyrQLSHCEx9r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSA3KTcw288rV2+j4zLqklAzmKCkxtERSYcAWliCiWnUwGyiG
	ZcLW/YOE2ezMXNyURBLYfoaOHTEeSNP8mYsvN1PP0re/hbOyViNdKEACUtaw5jFGZ+gGqDSHdrT
	lUw==
X-Google-Smtp-Source: AGHT+IGfQmVyr1s0/LsJeAHmPIC8elkfAUqC11fu17meo1RTyUGhLrsXe0YGoEmOxAeuJZ1obx5+Hnwd5XI=
X-Received: from pfef3.prod.google.com ([2002:a05:6a00:2283:b0:736:415f:3d45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6010:b0:1ee:c390:58ac
 with SMTP id adf61e73a8af0-1fa45a6e710mr9030146637.34.1742320995991; Tue, 18
 Mar 2025 11:03:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Mar 2025 11:03:00 -0700
In-Reply-To: <20250318180303.283401-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318180303.283401-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318180303.283401-6-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests changes for 6.15, part 1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

These are the selftests changes that were originally slated for 6.14, but got
omitted because of the mess with the Intel PMU counters failing due to the test
trying to validate architectural events on unsupported hardware.

The following changes since commit 10b2c8a67c4b8ec15f9d07d177f63b563418e948:

  Merge tag 'kvm-x86-fixes-6.13-rcN' of https://github.com/kvm-x86/linux into HEAD (2024-12-22 12:59:33 -0500)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests_6.15-1

for you to fetch changes up to 54108e73344480c3e5f3799129970009f52c59f4:

  KVM: selftests: Print out the actual Top-Down Slots count on failure (2025-02-12 08:34:56 -0800)

----------------------------------------------------------------
KVM selftests changes for 6.15, part 1

 - Misc cleanups and prep work.

 - Annotate _no_printf() with "printf" so that pr_debug() statements are
   checked by the compiler for default builds (and pr_info() when QUIET).

 - Attempt to whack the last LLC references/misses mole in the Intel PMU
   counters test by adding a data load and doing CLFLUSH{OPT} on the data
   instead of the code being executed.  The theory is that modern Intel CPUs
   have learned new code prefetching tricks that bypass the PMU counters.

 - Fix a flaw in the Intel PMU counters test where it asserts that an event is
   counting correctly without actually knowing what the event counts on the
   underlying hardware.

----------------------------------------------------------------
Chen Ni (1):
      KVM: selftests: Remove unneeded semicolon

Colton Lewis (2):
      KVM: selftests: Fix typos in x86's PMU counter test's macro variable use
      KVM: selftests: Add defines for AMD PMU CPUID features and properties

Isaku Yamahata (1):
      KVM: selftests: Add printf attribute to _no_printf()

Sean Christopherson (7):
      KVM: selftests: Use data load to trigger LLC references/misses in Intel PMU
      KVM: selftests: Add helpers for locally (un)blocking IRQs on x86
      KVM: selftests: Make Intel arch events globally available in PMU counters test
      KVM: selftests: Only validate counts for hardware-supported arch events
      KVM: selftests: Remove dead code in Intel PMU counters test
      KVM: selftests: Drop the "feature event" param from guest test helpers
      KVM: selftests: Print out the actual Top-Down Slots count on failure

 .../selftests/kvm/access_tracking_perf_test.c      |   2 +-
 tools/testing/selftests/kvm/include/test_util.h    |   2 +-
 .../testing/selftests/kvm/include/x86/processor.h  |  47 ++++++
 tools/testing/selftests/kvm/x86/hyperv_ipi.c       |   6 +-
 .../testing/selftests/kvm/x86/pmu_counters_test.c  | 158 ++++++++++++---------
 tools/testing/selftests/kvm/x86/svm_int_ctl_test.c |   5 +-
 .../selftests/kvm/x86/ucna_injection_test.c        |   2 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c   |   3 +-
 tools/testing/selftests/kvm/x86/xapic_state_test.c |   4 +-
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c  |   5 +-
 10 files changed, 151 insertions(+), 83 deletions(-)


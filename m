Return-Path: <linux-kernel+bounces-251245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E0930294
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC70E1F229B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9493C13BAEE;
	Fri, 12 Jul 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23VA+0Ys"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4613B287
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828639; cv=none; b=pZrjBE4ufu7fDGLouh0JnsS4ZpCsFR3vGvnO61W/A792NBqfVf8bDisXpBS+A6lL6T93BSofiah99In8dNrRpzxfm7p3SfWczLVxrapKMaE3sVqmye1hmRkI0LSZSnjNT2KR7almsSpVZtT6Ja8i3u4kSy3tiEvQDYpb+JxhWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828639; c=relaxed/simple;
	bh=ki5lOaFLSSEayVfBzc38mByz3+WYJAeKuMG1UUW+nkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5O8dUKSYzS6dRxUzWCZYtg2JJTyo9aX196+58h8b2aYXIb4HU8nV2KLezobd5aMph90xYbwNKQYIglMFWR/H9giATedGDFvMqdlWWODsWBq+h9vXz8jV8575NPhe0QFx4RXWRubpDLYTt4wsEU8/VLwfFeeqbowm5g50Kb5v4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23VA+0Ys; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso1802849a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828638; x=1721433438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dfUNFO7Wm8JvZKhm4x192tzOTm6Ah0nZskm2pc6F2FI=;
        b=23VA+0Ysz9D4JVYG7SAqPvY9X+WwvUTe+e+JZHfG8ifwd8e4Z6MjOKd7xosz+q4VcW
         1+TKdDAgRi2gRhYsr/nwcdtD4lWbwuTqgjOhIMz4me5CL0LFUaNzDLHfnnWZyT7f+0lj
         S7A3K3BGfXIwPFd1YRA7by1KtH/buKJNdxTiko9Dk7GFiyfg97+eK1VaVrRqj7G3JirM
         dpJoG6iggBIaKh2o7rd/tYFZbHib7Y/vlIJ47WJHwaKzbIS3Xg3G7BGlevA7jFoZbz+D
         2z9UeE+3FLucJnqL4lWfAVe+JW3364koHPXOUkcWzOs2ain1tCkdSRfs7KzB5h/060DP
         BX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828638; x=1721433438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfUNFO7Wm8JvZKhm4x192tzOTm6Ah0nZskm2pc6F2FI=;
        b=QbvI61smA2mKbl7QL/1zf4r++vSQ92u3+Na7Nz8gw8jRnQxNtfDi0xOaie44svES9x
         vFVeP8DyaVQ6OHiQOY/i5lBzthPGTDqtsujBW5N1LDemiEdegaChmn3Z+LQW6ocF+hpJ
         rJV1EjD2urQUjmQchLRsWRgT2Uq8EboE7k7JMIAPO7r6huM+wwtojN4F0JOSJ/xuy9j0
         Cz77dx5PwMqWJbXIVwXVtkdK3/au+g2TpewdL5GovDAf2PahuYJo9SL3zTYrzyGQmF1X
         v5BPb78PKS4IW5ut3A7sGYYw9wJELwl6+yUaCLAA/pyXhVC6aQ6URhpyi4pVRzrYgwUb
         z1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFaTLeKAEUr4mwVHMl0SjtE1kxT4IcxhfLd4PnBhLz2tlIbLpCf3pRZk1q7MHAcbrOL+CpU5Iwb/luwaOPgpZOaEEEiPyKs3LCU9Z1
X-Gm-Message-State: AOJu0YxteOy+bMVuflik2wogimt56HpMN7rk0ym01vyOGoH2Ca9Sryf8
	D0DJgA5wIpyAnSmb/kcCyeDmHclhRlx3dq0e34aJgDeoUvK8Hw7zXaq2j2weYPGIojXhqCcmj3b
	M/Q==
X-Google-Smtp-Source: AGHT+IHwtj09J3bIEFosQkYg8mkyL91+Y/kzrOb+B4VqKA9yIHNlz9cmY9uFkqnxj6u1pWYPHn6QmBnzi00=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:ee12:0:b0:772:6903:ac79 with SMTP id
 41be03b00d2f7-77dbefb08aamr24809a12.11.1720828637414; Fri, 12 Jul 2024
 16:57:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:56:57 -0700
In-Reply-To: <20240712235701.1458888-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-8-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests changes for 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A handful of random selftests changes.  Props to Maxim for figuring out a way
to fix the PMU counters test.

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.11

for you to fetch changes up to 4669de42aa6c78669975d58c92433cdedeb7c2c3:

  KVM: selftests: Increase robustness of LLC cache misses in PMU counters test (2024-06-28 08:44:03 -0700)

----------------------------------------------------------------
KVM selftests for 6.11

 - Remove dead code in the memslot modification stress test.

 - Treat "branch instructions retired" as supported on all AMD Family 17h+ CPUs.

 - Print the guest pseudo-RNG seed only when it changes, to avoid spamming the
   log for tests that create lots of VMs.

 - Make the PMU counters test less flaky when counting LLC cache misses by
   doing CLFLUSH{OPT} in every loop iteration.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      KVM: selftests: remove unused struct 'memslot_antagonist_args'

Manali Shukla (1):
      KVM: selftests: Treat AMD Family 17h+ as supporting branch insns retired

Maxim Levitsky (1):
      KVM: selftests: Increase robustness of LLC cache misses in PMU counters test

Sean Christopherson (2):
      KVM: selftests: Print the seed for the guest pRNG iff it has changed
      KVM: selftests: Rework macros in PMU counters test to prep for multi-insn loop

 tools/testing/selftests/kvm/lib/kvm_util.c         |  9 ++++-
 .../kvm/memslot_modification_stress_test.c         |  6 ---
 .../selftests/kvm/x86_64/pmu_counters_test.c       | 44 ++++++++++++++--------
 .../selftests/kvm/x86_64/pmu_event_filter_test.c   | 35 +++--------------
 4 files changed, 41 insertions(+), 53 deletions(-)


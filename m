Return-Path: <linux-kernel+bounces-566708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34D5A67B90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E01788452A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F42139AC;
	Tue, 18 Mar 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0m3NHmU"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA721325C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320995; cv=none; b=qV3SsXLdG/OtIYeiXfnIceSPmRtOOZBrkPpu/MkoBNbAACBUqbG+leo8R+UvGVAP270TDlqnjeXlcspEmBQ928j0xfn1tWB1nuVIRJcLQGyG58X9/IfgAPSN1qfBAzDbVMYvM79irEhEtgQl3uonbWHnXBr27rkqnTgX2WY2TSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320995; c=relaxed/simple;
	bh=D2Vl0hjvmprdSsP8sLEgp9rXOfSsss492r6Pga44mc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQ70NbOBJ5375R6dSHwbd7Sp49+AWq3aMhVhoZdz6QNHvPLbm8WTXLuwBrvVya3k9BGXcCODMNM85sW3G1WZB0cZwKEW1ZUoPOBqsQ6m82TsFedDuJh8KkgpUgMZ0jgfycCdc1XoyF/uq5ECgF/4cArEKAt3+jWqjsKo9VDozvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0m3NHmU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso8175448a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742320992; x=1742925792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=B/BIFgYVh0LKqAIlv/WzNNj3QrJU16cGXK8ptGwEd38=;
        b=p0m3NHmUUis+/95Ku+oHrYD4lWZSSIkOLRHW40dwHyl/bTw559Nn/gTzOLoLFF4znf
         TTrpv+8T2yhfENjdguivsgDhxXaEBtR4HmpO2zWyb+gbsjivyKY5KM9k76UtO9e94Zmy
         2UHTY2KsGB/wR6v1AkGdC5NEKgOgu6h10avd92BypeXcAJhGrxRMGLo8WjkeihgvGcoW
         RJAk6TM9amKOBWm6Svlx3vtAljJpieKjZ+AcaJviInIEINNpZ3ViruICpkOg/piNgqTD
         sucLX5K5wFyeYgpihXU/c5dh+2DEyr1qtq+M7V1vJf2TWcTVwOwcioSvSwNTCeHktBFa
         qLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320992; x=1742925792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/BIFgYVh0LKqAIlv/WzNNj3QrJU16cGXK8ptGwEd38=;
        b=oIW4mqSgmJu4bWser5lEmNB/bsQm16NrS0nQbAtVHijAwLSvVxGhjknCwRf4IBFGz8
         f3+fRLhwWyx5cTnMUElo+zDZl6aVluoFF7G0OqWJ/EXmonIgZpcPOnSEWQcIH+BQuMb4
         d/4p2hilH0f38JhvfLo3sdNWO4eudywRYbSP+sNpdFfsgBa/muFbzCQUUHA/P9VvWys5
         cGw3MPv0V19V45wFZ5rggdqGnARHlo8QD6c7bjASm+glg82/+LfKLTtLy/19lrfKgk57
         7tukQsue0skIJ1Z2FESCzh4jmzmBV1uhO5Wfa6s4061kMrB4MHvdbKHbKxstnbrxjPrh
         vBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDchmrp1vXIK0l8DdZP0jVwOMLPFD22Ejtyntgc7VQNlEf574o/Kh3pqit7MfkpwtH3bd9PflKu65zEiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylABu0fOZh3iPHurJBgy3NvA9kGhp8BXZ7pXDakTy7jh51eia2
	isqQGdyaNE/Iu2HU8jLyB1d02PACHVAoHwvJ95M5pKNiouAdiuI/Yv63g+4JzjNHJ2+KU1C2fd4
	2bw==
X-Google-Smtp-Source: AGHT+IGzOuilgyAVAxs/CJ+xQoOlaZHr1Qi0K1UT//neS2shFy705WLzEyBiiaDpPFP5dCKHstVWSzHEpno=
X-Received: from plsl17.prod.google.com ([2002:a17:903:2451:b0:223:432c:56d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:188:b0:224:1d1c:8837
 with SMTP id d9443c01a7336-2262c554bc8mr61354805ad.19.1742320992644; Tue, 18
 Mar 2025 11:03:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Mar 2025 11:02:58 -0700
In-Reply-To: <20250318180303.283401-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318180303.283401-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318180303.283401-4-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: PV clock changes for 6.15
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a variety of bugs, flaws, and warts related to KVM's handling of PV clocks
and the associated PVCLOCK_GUEST_STOPPED flag.  Note, there are still a pile of
issues with KVM's PV clock code; hopefully the next version of those changes[*]
comes along sooner than later.

[*] https://lore.kernel.org/all/20240522001817.619072-1-dwmw2@infradead.org

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-pvclock-6.15

for you to fetch changes up to 1b3c38050b5cc07f6873f244f845fb6c8549ce85:

  KVM: x86: Override TSC_STABLE flag for Xen PV clocks in kvm_guest_time_update() (2025-02-12 10:45:55 -0800)

----------------------------------------------------------------
KVM PV clock changes for 6.15:

 - Don't take kvm->lock when iterating over vCPUs in the suspend notifier to
   fix a largely theoretical deadlock.

 - Use the vCPU's actual Xen PV clock information when starting the Xen timer,
   as the cached state in arch.hv_clock can be stale/bogus.

 - Fix a bug where KVM could bleed PVCLOCK_GUEST_STOPPED across different
   PV clocks.

 - Restrict PVCLOCK_GUEST_STOPPED to kvmclock, as KVM's suspend notifier only
   accounts for kvmclock, and there's no evidence that the flag is actually
   supported by Xen guests.

 - Clean up the per-vCPU "cache" of its reference pvclock, and instead only
   track the vCPU's TSC scaling (multipler+shift) metadata (which is moderately
   expensive to compute, and rarely changes for modern setups).

----------------------------------------------------------------
Sean Christopherson (11):
      KVM: x86: Don't take kvm->lock when iterating over vCPUs in suspend notifier
      KVM: x86: Eliminate "handling" of impossible errors during SUSPEND
      KVM: x86: Drop local pvclock_flags variable in kvm_guest_time_update()
      KVM: x86: Process "guest stopped request" once per guest time update
      KVM: x86/xen: Use guest's copy of pvclock when starting timer
      KVM: x86: Don't bleed PVCLOCK_GUEST_STOPPED across PV clocks
      KVM: x86: Set PVCLOCK_GUEST_STOPPED only for kvmclock, not for Xen PV clock
      KVM: x86: Pass reference pvclock as a param to kvm_setup_guest_pvclock()
      KVM: x86: Remove per-vCPU "cache" of its reference pvclock
      KVM: x86: Setup Hyper-V TSC page before Xen PV clocks (during clock update)
      KVM: x86: Override TSC_STABLE flag for Xen PV clocks in kvm_guest_time_update()

 arch/x86/include/asm/kvm_host.h |   3 +-
 arch/x86/kvm/x86.c              | 115 ++++++++++++++++++++--------------------
 arch/x86/kvm/xen.c              |  69 +++++++++++++++++++++---
 3 files changed, 121 insertions(+), 66 deletions(-)


Return-Path: <linux-kernel+bounces-392744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF49B97AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF6B283D7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB121CEE9F;
	Fri,  1 Nov 2024 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3XjldKj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D71A0BE7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486160; cv=none; b=bAo173ltDDWd7kyApLSi12Lz6T1FTiLp6tVu3noQBA9WhhDc/qiwpa/ILOLSOrENMvWfTjOTOOcrCR8QOqLG/LrNePmdaI8FMTgQrvkeb83I/qEtzfXskPVgjm01WA4vIR+AcfMH0HvH8lx1frLeagr6+fB+22Z9mm3U1tR/Qw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486160; c=relaxed/simple;
	bh=cqcJ1VJaJOvWkIWgZq240tLJvRm49fKE8z9sGgc2010=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mThiIXRlpELnHgjabmMaippLFGdIF8Qo01JF7bcCHy83fdKhRH/z3fIpNVOuz7hyqar6dzPs6HHhuOdJVtA5zlbmvNtXIfpj/iPqZPMma9+8OSKrFfMiMdp4eiZK05dq6loiKUyEKt8XZXxetg9yxzykfAL/emq5TmtomsK3v0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3XjldKj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e315a5b199so44161337b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730486158; x=1731090958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r/Sdah9+bjYkwfbsqA53X8mX/jPMxIr8figtONljZA=;
        b=z3XjldKjpiD+huO2Bu/KrIGIFIirUT99yVRXzvcH6s06KnCoo/CmtWQqhVJ4ckikre
         f5JhrT5vlQsXYpjQwzTxW72Wy9df5MicJ8mmZ58D1/wF0Y2CzTvVHCF/oyzBOMRzzJqa
         4UjrSxVEkqB8ToLggBK96uA7UaG2QQKRhI46on8cpr43fBLQd0zb/PwgIMmUxuGcqBy1
         Wb7GqSGUF1MLeRK9sbrbrHDt8999xuy+QJH2Nctt7ZezKWhciHLI+0PEG1T2WEx7nGW0
         PRheIJHA0A0mguUMhP04ZdpQ8SQYKHlYcw4+F8xlxb0ySnFKZ05xuYy2QurKrhwpGvug
         nEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486158; x=1731090958;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2r/Sdah9+bjYkwfbsqA53X8mX/jPMxIr8figtONljZA=;
        b=eS0m3V4zJtkzYve430XHOv8pAbmqCV6i+3Tyr6TQjV9G7ARNIkRdWIV+sRQbl6dF5x
         RkeTcgwFYJlHpOszpjizfPqg1RJpOUPH2WiF5sCEGT1ZmrjP2XDV77s7RWnipHWu0+8f
         91HMBzjO6ikhPwM5+JNrQC22N7f+l6fcAMZ/HtKV1yxZ0RrBA/LNNh0hq2UwrMTaYlPi
         1HGfD8XH9OOxjTNhhc7LCo7EjpnM9eaie7YCg2FJ2J5oblTFeu6cYEjWDSJBXOz81MZa
         R/sPxr6S5lIGJoHrQSTEdTGekUkUQUIJjgZqqFJ49pZim9MRZc/ShbXF3OuTwZPu5CmL
         wBag==
X-Forwarded-Encrypted: i=1; AJvYcCU4jRkxlRcdbeciH4bTKdig9CRDrkD/J3WB5g/1FgD4WgKPJYZR7VQtrvM7u19mUDjx9lCVZLD6XY0qRZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrymKDpjznvmYZDE+WWVdYZNKzPW+JUhbLS3qXl3aM9igCNC60
	gE57rAqw6EpbKSzwikcoQQlTCfVkfjJmZ9cIN798Whx/bANQQnYwkvGTjJXWDyB33yPpCWMtJ0G
	SJQ==
X-Google-Smtp-Source: AGHT+IHe+WXCNMgZIyKibIpwvMMVjCVJ9JC6cpP2eb1U3+19KALVuFAaCNLhStIprzESAY17rsGQVTf2cxg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:7448:b0:6e3:f12:1ad3 with SMTP id
 00721157ae682-6ea64be01cdmr444117b3.6.1730486157801; Fri, 01 Nov 2024
 11:35:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:35:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101183555.1794700-1-seanjc@google.com>
Subject: [PATCH v2 0/9] KVM: x86: Clean up MSR_IA32_APICBASE_BASE code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Clean up code related to setting and getting MSR_IA32_APICBASE_BASE.

E.g. it's absurdly difficult to tease out that kvm_set_apic_base() exists
purely to avoid an extra call to kvm_recalculate_apic_map() (which may or
may not be worth the code, but whatever).

Simiarly, it's quite difficult to see that kvm_lapic_set_base() doesn't
do anything useful if the incoming MSR value is the same as the current
value.

v2:
 - Collect reviews. [Kai, Paolo]
 - Add a comment in kvm_lapic_reset() to explain its usage of the inner
   __kvm_apic_set_base() helper. [Paolo]
 - Unpack "struct msr_data" before calling kvm_apic_set_base(), e.g. so
   that __set_sregs_common() doesn't half-fill a structure and rely on
   kvm_apic_set_base() to ignore "index". [Kai]
 - Tack on a patch to short circuit all of kvm_apic_set_base() when the
   MSR isn't changing, to avoid the rare slow path of triggering an APIC
   map recalc due to some other task marking the map dirty.

v1: https://lore.kernel.org/all/20241009181742.1128779-1-seanjc@google.com

Sean Christopherson (9):
  KVM: x86: Short-circuit all kvm_lapic_set_base() if MSR value isn't
    changing
  KVM: x86: Drop superfluous kvm_lapic_set_base() call when setting APIC
    state
  KVM: x86: Get vcpu->arch.apic_base directly and drop
    kvm_get_apic_base()
  KVM: x86: Inline kvm_get_apic_mode() in lapic.h
  KVM: x86: Move kvm_set_apic_base() implementation to lapic.c (from
    x86.c)
  KVM: x86: Rename APIC base setters to better capture their
    relationship
  KVM: x86: Make kvm_recalculate_apic_map() local to lapic.c
  KVM: x86: Unpack msr_data structure prior to calling
    kvm_apic_set_base()
  KVM: x86: Short-circuit all of kvm_apic_set_base() if MSR value is
    unchanged

 arch/x86/kvm/lapic.c | 39 ++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/lapic.h | 11 ++++++-----
 arch/x86/kvm/x86.c   | 45 +++++---------------------------------------
 3 files changed, 46 insertions(+), 49 deletions(-)


base-commit: e466901b947d529f7b091a3b00b19d2bdee206ee
-- 
2.47.0.163.g1226f6d8fa-goog



Return-Path: <linux-kernel+bounces-357645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E39973BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2507D283DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68D15C15E;
	Wed,  9 Oct 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fraUCpdr"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA57710C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496207; cv=none; b=IUB1w9EhnhWoRBQYkFKGzw9DEiawpR1PvQ4DnW6N8vW8QQPsm59oAzJIFF2B2XGK94/LIMPi3dl+sapgFTZ+mxCywZjYclLZwjP80dTbeiOSAvafTAE9js744yhxFGmL6qMyvTTmePhbNM1uXlK4Qo8gOL5at6tQZxMaSuk4LM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496207; c=relaxed/simple;
	bh=MxvXk1fdhytS5XV5lu7xh3HaviYyN0EEXYtlLds1jTI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lLxzAsPbOYf8mtlEDP7+VpJ0yy2zlOiJv3lhK6VaTXVbtLwPJJNVCbUw9eiHf+pLnXpxjbw03L3Fe/4HMBJfCpNJew3tHD0b2ZdefUtStoK8JV0PvXH+CTGqvhYFc6sbl1G09eEvgpDcPF6Q/C6ehXwtb4/V+HJV7M/vuYhLK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fraUCpdr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31d9c8efcso3248197b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728496204; x=1729101004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvER9ZyOmZvlvkfQ0QlNMg2dDWrDm49qRL1pt110lLI=;
        b=fraUCpdrDCnd6fSKVhhWRR522WY/sjGIZbzLqOjQz3VgJTsg1gm6EUhm0DAziOS8sL
         W8F3pe+bIknTrZLbnAVWOIHsVo+/So2hHAtzuHftVW6jJer38/paLtgQuFOuo0SDQEOc
         P64cu10DDe1DyHubcxLURULJd8nxXcgjLBXQWYrXu1IbAfKNCDamUtb0E09cs+Pfvagz
         1r1PQym46OZhF05lOIS+5mzVX7kKFRIpdTnaX+863zOpT8o124A5kzvLNFdtE1T3cWsO
         aYSweowM00o7tS91h4f6JlquRA9ju9wpeBlyHInqFIf7vuei9SciX5hfmjea9jVKX2cA
         5T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496204; x=1729101004;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvER9ZyOmZvlvkfQ0QlNMg2dDWrDm49qRL1pt110lLI=;
        b=Tit+tyn0czHxbcy3b8VqF2cQNV/gHOj1pNGzXgdC+WZRgbQvQ5kIWk4HR9AzDr2Cwz
         2p3F0WSGCIeAcrVEwORCFllex7sz2W1xEMWMFNh6MqbZGJRukge+kIpAdpUs8dvOZTJL
         YXGZiKj6QsqOPuFMi74j3aIpZdIXRUYDH5vtW83maY9AhxUuJx4CGUHAfYTgy2aUD/yc
         pxlNYwwjetLf8eUk21yXiV1+c3FRwe1339pRTyPe/pttzsS/T2vZuwyvqq/OUgKigfdy
         mI+p04OlJM3Kqv+a23EQ+H8Hak2qR67LSQzpB3zIT4a5VbMwVTh0yqJT3ZOm4GQ/02pb
         bX1g==
X-Forwarded-Encrypted: i=1; AJvYcCUQvyOfBWaZd0LOi7HmIzIVD8LTWWUJ7YwjPvrvYxivBWU3Iy/18orIOeTvUPtSaIfOm8ylEIlNU72cSG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv40A+yeRjXANT2hzrbSPoCi7sV14QKehcPKRw6hzB981KM3p3
	i3+lqC7Yu9KY0IdBySLw0GJvTk+UV5UFirj9bTka52Im/4tyMczMsQahpZuuY2LCYLfSVdePWUP
	Q2Q==
X-Google-Smtp-Source: AGHT+IGYTupOxq9Up6ciBQGUqvbqk9jwoYX//69iW2B1OciHXBy1DvTw0oH9r/dDnWJKR/XTy8KK4KuB+4M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2c01:b0:6db:d257:b98 with SMTP id
 00721157ae682-6e32215253bmr303677b3.3.1728496204631; Wed, 09 Oct 2024
 10:50:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 10:49:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009175002.1118178-1-seanjc@google.com>
Subject: [PATCH v4 0/4] KVM: x86: Fix and harden reg caching from !TASK context
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Fix a (VMX only) bug reported by Maxim where KVM caches a stale SS.AR_BYTES
when involuntary preemption schedules out a vCPU during vmx_vcpu_rest(), and
ultimately clobbers the VMCS's SS.AR_BYTES if userspace does KVM_GET_SREGS
=> KVM_SET_SREGS, i.e. if userspace writes the stale value back into KVM.

v4, as this is a spiritual successor to Maxim's earlier series.

Patch 1 fixes the underlying problem by avoiding the cache in kvm_sched_out().

Patch 2 fixes vmx_vcpu_reset() to invalidate the cache _after_ writing the
VMCS, which also fixes the VMCS clobbering bug, but isn't as robust of a fix
for KVM as a whole, e.g. any other flow that invalidates the cache too "early"
would be susceptible to the bug, and on its own doesn't allow for the
hardening in patch 3.

Patch 3 hardens KVM against using the register caches from !TASK context.
Except for PMI callbacks, which are tightly bounded, i.e. can't run while
KVM is modifying segment information, using the register caches from IRQ/NMI
is unsafe.

Patch 4 is a tangentially related cleanup.

v3: https://lore.kernel.org/all/20240725175232.337266-1-mlevitsk@redhat.com

Maxim Levitsky (1):
  KVM: VMX: reset the segment cache after segment init in
    vmx_vcpu_reset()

Sean Christopherson (3):
  KVM: x86: Bypass register cache when querying CPL from kvm_sched_out()
  KVM: x86: Add lockdep-guarded asserts on register cache usage
  KVM: x86: Use '0' for guest RIP if PMI encounters protected guest
    state

 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/kvm_cache_regs.h      | 17 +++++++++++++++++
 arch/x86/kvm/svm/svm.c             |  1 +
 arch/x86/kvm/vmx/main.c            |  1 +
 arch/x86/kvm/vmx/vmx.c             | 29 +++++++++++++++++++++--------
 arch/x86/kvm/vmx/vmx.h             |  1 +
 arch/x86/kvm/x86.c                 | 15 ++++++++++++++-
 8 files changed, 57 insertions(+), 9 deletions(-)


base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.47.0.rc1.288.g06298d1525-goog



Return-Path: <linux-kernel+bounces-537410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349BDA48B77
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6977B16CF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610127293E;
	Thu, 27 Feb 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8WpM1xD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE427290C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695055; cv=none; b=ubdjz+MBWq2eyfxn1jtqid9HdY61r3pkgqNGfHwZR2sH6j59CpM81PHJxUiWesHPWBnPeNzDVcQ05xsqYc5R8pSCsAwk5N8mWne6aVzpn9apt+e/kktvOMaz5AJqWlfgq/dTLFQYzbB/jbtjFtP+GQ1bnONhCqFHMll9ERs0UpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695055; c=relaxed/simple;
	bh=n/1RgpCroVgyK7X6GzrUp5Xfgz9OBsNnHK+ge61VGTo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DpjswBtTqfcIAK6qd2lqxzaNAknOi5Kenn6+cEUX/rAenI2QnjRfsZM9787Dsun/Hz5E9GyFyNFYizwZnvSI6489gdQoDwEiLntuGa4wkNsHwlyeLaTJYshhaYuEd/ZE27M9HBWZd430zT7W+JOOLO+s8ijNtvpnFgiriK8uS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8WpM1xD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc518f0564so3291788a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740695053; x=1741299853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9o5Jq8H+kOkmCfj/KGvAxCatQK2yuxe16Hy1ihdUho=;
        b=l8WpM1xDc6g7VqkVno/EB1jXXb8D9VR7OUUKUEN/pHha+sT6UzknhmCHuaZ/7xe1pr
         JW5KKgRgwHe4zEFC3sBNd5PtDzdwH1VpE8FZYqfAmEppyH4RHvIGSfPPHATKKJrj1Srv
         lrctFCpCMURXV0wJo7f3AAVyoJ34h6hAbJockkhIrCvvD9tQ8kMew4q02xb1LTeuwt0K
         Ik7Xr7G5UXfIwD0cRzuyZZ5Lqpq4YZd6Ba9lltoq2VDs9zPB521A06a2dPCBlO0jQsJo
         TAiUVfDyEnmrSUd0Dz6J4SUaECNeRkMPxrpD0mYN+jxl2Fnelgo6mMBhKWJJ8OK7AP4b
         xOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695053; x=1741299853;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9o5Jq8H+kOkmCfj/KGvAxCatQK2yuxe16Hy1ihdUho=;
        b=RZRlZhu37FpOYxF535HM3cEtpOMetxIJgQYACd55V0nAcZ9IN80wCwpQuvYFwmRW8h
         Avjg0qTuyhsaNFYKbJ+88jsyMQASR8A1J4Oushnt1LL+qKSndSsLrq/S2oUxLz8slp/A
         u96YjmYaIODQpGuqp0le/eFfU3pwobTFmut+h534OqGfg6ZJUW6AzELrWb7mxrqxNAlp
         H3gZVciInRFzzyQ7OX1HFfXdj06FB/mM14FgdqYfP2vh9wcUKKXaVM1fkXIK4wX1maUR
         7Eza1UUS2LhQkB+BvLcSVOTBU248bChsyFNn7V+evpFxrB2QIuy/g1taCekAz+fs/5au
         lhlg==
X-Forwarded-Encrypted: i=1; AJvYcCUwi8stnTILO1mHZM1WN/wXvn4kVa3Sh7jkVtPXSuhZynb3j3KUfZZd55nNagl5VS38p3VGMrG9dSbZsjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEK26vZIC7PsctEFPl0EY1Iu6zRyPUGLm+sg/9oXNeUFfqdrMH
	tcO3kvpL+ntnVkX4ymJE26GKqtNaf7MI7FUaDH3KlVtUJguOvkbaoOvyAaMmW+IyXRBa/ORbIE/
	tKg==
X-Google-Smtp-Source: AGHT+IFmir73DFHSRZ34KQ2YJsZgJSbeeYd5v5m/4loVQPqZFitd+g8FMqWSYZ+tXSmrGG2rxYiBIZTLRO4=
X-Received: from pgct3.prod.google.com ([2002:a05:6a02:5283:b0:add:a98f:56a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2449:b0:1ee:d418:f754
 with SMTP id adf61e73a8af0-1f2f4e5a4b3mr1477664637.40.1740695053378; Thu, 27
 Feb 2025 14:24:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Feb 2025 14:24:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227222411.3490595-1-seanjc@google.com>
Subject: [PATCH v3 0/6] KVM: SVM: Fix DEBUGCTL bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, 
	whanos@sergal.fun
Content-Type: text/plain; charset="UTF-8"

Fix a long-lurking bug in SVM where KVM runs the guest with the host's
DEBUGCTL if LBR virtualization is disabled.  AMD CPUs rather stupidly
context switch DEBUGCTL if and only if LBR virtualization is enabled (not
just supported, but fully enabled).

The bug has gone unnoticed because until recently, the only bits that
KVM would leave set were things like BTF, which are guest visible but
won't cause functional problems unless guest software is being especially
particular about #DBs.

The bug was exposed by the addition of BusLockTrap ("Detect" in the kernel),
as the resulting #DBs due to split-lock accesses in guest userspace (lol
Steam) get reflected into the guest by KVM.

Note, I don't love suppressing DEBUGCTL.BTF, but practically speaking that's
likely the behavior that SVM guests have gotten the vast, vast majority of
the time, and given that it's the behavior on Intel, it's (hopefully) a safe
option for a fix, e.g. versus trying to add proper BTF virtualization on the
fly.

v3:
 - Suppress BTF, as KVM doesn't actually support it. [Ravi]
 - Actually load the guest's DEBUGCTL (though amusingly, with BTF squashed,
   it's guaranteed to be '0' in this scenario). [Ravi]

v2:
 - Load the guest's DEBUGCTL instead of simply zeroing it on VMRUN.
 - Drop bits 5:3 from guest DEBUGCTL so that KVM doesn't let the guest
   unintentionally enable BusLockTrap (AMD repurposed bits). [Ravi]
 - Collect a review. [Xiaoyao]
 - Make bits 5:3 fully reserved, in a separate not-for-stable patch.

v1: https://lore.kernel.org/all/20250224181315.2376869-1-seanjc@google.com


Sean Christopherson (6):
  KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value
  KVM: SVM: Suppress DEBUGCTL.BTF on AMD
  KVM: x86: Snapshot the host's DEBUGCTL in common x86
  KVM: SVM: Manually context switch DEBUGCTL if LBR virtualization is
    disabled
  KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
  KVM: SVM: Treat DEBUGCTL[5:2] as reserved

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/svm/svm.c          | 24 ++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/vmx/vmx.c          |  8 ++------
 arch/x86/kvm/vmx/vmx.h          |  2 --
 arch/x86/kvm/x86.c              |  2 ++
 6 files changed, 30 insertions(+), 9 deletions(-)


base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.711.g2feabab25a-goog



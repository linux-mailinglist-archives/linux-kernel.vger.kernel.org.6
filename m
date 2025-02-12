Return-Path: <linux-kernel+bounces-512025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB656A332E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1F31889F74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383B2045A1;
	Wed, 12 Feb 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFEp7xgl"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE41FF1D2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400653; cv=none; b=QH1fCZfky4zmrCA9qafnVBqjGJ0p337vyAFtZyjmpJfzFNncgQ22S3J4m87u/npoa90SOSR/M9kQk2mbbjiab2tF6litZhroG7KDRoPwHRU5uwKSLN4CQxbiB901I/tRlAc9HT8NjESTW9/xjXRQfwEnYLEfTONbOItHCkpfuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400653; c=relaxed/simple;
	bh=uXm8uKmNjS20RmDk1SMqOD3I2J1mL4UkI1TzOjxtnkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u9CKoO4Q3qsCqpHrcqtXpHI0Agm+Dfw/8AredMv5zhjfVBJkALFdnvTKXpP/V940EbE4nesZ9x4vFEz1cwdkcTlg+FfYaqpLHL3IHAHm700ElYHjQO14fE2TgC49A8CIz9VergWyqjOvzcJ+mvJMhOTy3IusW4UmfTZFYJow3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFEp7xgl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa1c093f12so781635a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739400651; x=1740005451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7M7mwSZmFgIdf/jVcNpFyiHweXH73hNuBjTuWyoztw=;
        b=wFEp7xgl0OVABYmzcnuN8JJWBU3n5vtSnjKDC5uRcaAlFC0StvVfPmaz81AgoAecA3
         FQJ+WPi/Lk1q8pH++x8EQE2Td6E1Ug+453TTfL+cPFWHeAWeK6Qtyu5axET6rIiK9yPe
         nmuGKLflrjoam6oEmYTVTaa3U2lPytuZxim+34czdxVr4PohG7eZPgGUC8ZkBS8Thv5p
         /+iX6HmL663OXP1G2CuaFQRSv1/Ib1ADz70dXkhbssmnTjqvmg47ap4buTd8UHBMVZGQ
         Ww4A5b/E8o2KD36r7bKZ7QGGnvuR+rI/77m/cKBNdVo/RKXTSpAJiNqJLJkU0qluyvJV
         CEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400651; x=1740005451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7M7mwSZmFgIdf/jVcNpFyiHweXH73hNuBjTuWyoztw=;
        b=r+ft62rukGVnmo2Wpn/PyYywqiDy5kDmdLKqkgV6NpIro0R92ZlikuFgCONC7kxlnP
         htzMna1eqlwxe4FYUJQnCc8sLZcqzhKNKjNhiA8L7/zKSTa+WwDhyxzgIIBod3QBK9ex
         u348ynubL1OM7VB0m4SuSh5MvfzQkF65ZJz4XRqFVUclQFviJ8LFH38FVMlqRYPCxb2w
         ii3ZWbbHd4MtDsQmR6ZnkFO1BMFmKYHBgi55e7L+TuNR4srVpeUzzeSqt/Jy0e93wTiP
         rREFyLTAanvjBcAeL4g2N+e8uHATcg42nSf5ufIROIeY3AGCUAIj8YfmyEwLrc9pfePY
         paQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgRpQa9ix7iuvaHkfJ9sG/lyhlWcbU0ifzF5njxz4I5NiEcAIRmx1GmNbgtEdjjicHB0IIpVsQKRP/bRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSKO4ciFx5C2wlqFFgLt3jlivvlOU9lKLBPqw+y3Wpum2BTU6
	t9IYm6L0kGxhk/3AqnqiDfbbXldEJtpbrBXijHovfjhgQ9keu130hHTIHqPh7yqVBHMC1dtOutT
	m+A==
X-Google-Smtp-Source: AGHT+IFVTTUUI1xszagrzillVwGnjrtr+PRt659s6KUyzEgsoiBKTxdBzhJcBaI8v4c/MK/Id5lMncRdTWE=
X-Received: from pfblj12.prod.google.com ([2002:a05:6a00:71cc:b0:730:78e8:8e52])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2341:b0:730:97a6:f04
 with SMTP id d2e1a72fcca58-7322c38479emr6679600b3a.7.1739400651124; Wed, 12
 Feb 2025 14:50:51 -0800 (PST)
Date: Wed, 12 Feb 2025 14:50:45 -0800
In-Reply-To: <20250212221217.161222-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67689c62.050a0220.2f3838.000d.GAE@google.com> <20250212221217.161222-1-jthoughton@google.com>
Message-ID: <Z60lxSqV1r257yW8@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in vmx_handle_exit (2)
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: syzbot+ac0bc3a70282b4d586cc@syzkaller.appspotmail.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, James Houghton wrote:
> Here's what I think is going on (with the C repro anyway):
> 
> 1. KVM_RUN a nested VM, and eventually we end up with
>    nested_run_pending=1.
> 2. Exit KVM_RUN with EINTR (or any reason really, but I see EINTR in
>    repro attempts).
> 3. KVM_SET_REGS to set rflags to 0x1ac585, which has X86_EFLAGS_VM,
>    flipping it and setting vmx->emulation_required = true.
> 3. KVM_RUN again. vmx->emulation_required will stop KVM from clearing
>    nested_run_pending, and then we hit the
>    KVM_BUG_ON(nested_run_pending) in __vmx_handle_exit().
> 
> So I guess the KVM_BUG_ON() is a little bit too conservative, but this
> is nonsensical VMM behavior. So I'm not really sure what the best
> solution is. Sean, any thoughts?

Heh, deja vu.  This is essentially the same thing that was fixed by commit
fc4fad79fc3d ("KVM: VMX: Reject KVM_RUN if emulation is required with pending
exception"), just with a different WARN.

This should fix it.  Checking nested_run_pending in handle_invalid_guest_state()
is overkill, but it can't possibly do any harm, and the weirdness can be addressed
with a comment.

---
 arch/x86/kvm/vmx/vmx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f72835e85b6d..8c9428244cc6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5869,11 +5869,17 @@ static int handle_nmi_window(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static bool vmx_emulation_required_with_pending_exception(struct kvm_vcpu *vcpu)
+static bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	return vmx->emulation_required && !vmx->rmode.vm86_active &&
+	if (!vmx->emulation_required)
+		return false;
+
+	if (vmx->nested.nested_run_pending)
+		return true;
+
+	return !vmx->rmode.vm86_active &&
 	       (kvm_is_exception_pending(vcpu) || vcpu->arch.exception.injected);
 }
 
@@ -5896,7 +5902,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 		if (!kvm_emulate_instruction(vcpu, 0))
 			return 0;
 
-		if (vmx_emulation_required_with_pending_exception(vcpu)) {
+		if (vmx_unhandleable_emulation_required(vcpu)) {
 			kvm_prepare_emulation_failure_exit(vcpu);
 			return 0;
 		}
@@ -5920,7 +5926,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 
 int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
-	if (vmx_emulation_required_with_pending_exception(vcpu)) {
+	if (vmx_unhandleable_emulation_required(vcpu)) {
 		kvm_prepare_emulation_failure_exit(vcpu);
 		return 0;
 	}

base-commit: b1da62b213ed5f01d7ead4d14e9d51b48b6256e4
-- 


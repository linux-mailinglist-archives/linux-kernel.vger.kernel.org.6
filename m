Return-Path: <linux-kernel+bounces-529649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F51A42945
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E193417B217
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD67264A77;
	Mon, 24 Feb 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xx3G0HRK"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C431264A6F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417255; cv=none; b=agapAKotErjqPACCTZMFwSZ8QafLGuwFjlnqzjn9kYZBSLnDzT0PPFH6YpirY7lWG/Zv3i36k+xkJwp+qxXNxklKDKJoSYKPSnoxYL3k1JTrHrRuBgjHU6Xtm392WD7zMoGmtmbbhXEltwCReiu871UtxJ6UL23GGsmwlGdiK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417255; c=relaxed/simple;
	bh=ChHQhpVxYbTXiAeNRbdrJoZgtAU1eO2sEaSStMSNrpA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ugIL1F4nsEh8QGSHwEhPEaq+iip7SR9o0JPe5/XmxWcOIRLnH59fVeQMA/IFed6XZvgnaFNli5SeO9S7QazPxYgSy20WzAvXPNLvNx6KeHe3ZtdnNSTY7V/sW/LNWF7d4NQOhAFxuWjYCtZKaUzOq6wiKtG/KxDUqsyeiXXTw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xx3G0HRK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so9601755a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740417252; x=1741022052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPxQY7bRKSrsl0rwMMhqxmRexHRZyDzKPiknNpdHSTs=;
        b=Xx3G0HRKNKupzo61QrwIJG8ZRVmfV5aGQ1nhcnI2IBMQWhgMswwhzaskWDqkSXzIHa
         fsqb1v+xmOhcGEZdX+3f2IpEDhHQMjG8Jk74MufYj6Pg1gLUMgEoDq1ayx1F8dKp16TV
         1fLrT7p5zxVyN/cTjar4n9YTriPuM3w3C8kFYWy6d+KKXH2Q63InRz9ceveXdVNOh4nD
         vFVGcLX6Io1jiUuAMMrY1PCnFQJpL/g7KtaBNqZWUEp1KmLLYPUmhfYUn2grXzcb+/GO
         GQ7lIqytHdf6WHbXjjwtGYv8eNldPANl8s7xl7op8RXBxiEDUMTKGTFoL93F54dNBydK
         dblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417252; x=1741022052;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPxQY7bRKSrsl0rwMMhqxmRexHRZyDzKPiknNpdHSTs=;
        b=nVF2sIey7Xel7ECkh3eWvhgU9A9XTWCucYnn1nzX2ALp7Ro+ux99L+CjNL04CfjbI6
         dsiHS0QrcKvRVV+sLBUk0ShzNY3cx7goJ9yQrCVxApBuM4Nnw3vd963Pg6FyGAS2h0DI
         UnnioS5ZL6NIRpSaCcWnN5968qDg7LXKpbjnJjnWgMnOmfAMCcdmvfCEmSe0He0xDM50
         O+6bJefFJi9y05vavgkMsPqT0OC7tPnsBC7v5ftFR1uzF0rJjJZ/smSDA5NRv3fnvmFF
         GTZIRZwJSx2IdBwYtc2u84RfSRpJqkr2tnZE7zZ80fCADO3RicRqI3SU5KFyMFeQQQG0
         Zftg==
X-Forwarded-Encrypted: i=1; AJvYcCUf0UfnJAQOck+CnANvShv8lyWYXyQBaokMhsfkah6cEAcRvm4kPEa6HRFNHcpDEp/TVEKJA0V7hoK5VaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrxG5Negf0MJSgfGTDHyDp8qsoYYVMlNdeJzsTUVgpceyjYE/
	7aYILYf0giB/TU+k/WrBBDdvdmKu3b7A/tyWkKw4uPXGFU+8XxYXuOZt8bH2igLbWgMDTLzlvtI
	qKw==
X-Google-Smtp-Source: AGHT+IHMxO2jlJB8uB6BmR8LSjz1yPyBddEjKyuuWppjAVjkQ/oZiNhamNiA1F9pN/rnOeUmadjA6AOp/dM=
X-Received: from pjbdj7.prod.google.com ([2002:a17:90a:d2c7:b0:2fc:2b96:2d4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cb:b0:2ee:cd83:8fe7
 with SMTP id 98e67ed59e1d1-2fce875d6aemr22583311a91.35.1740417251898; Mon, 24
 Feb 2025 09:14:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 24 Feb 2025 09:14:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224171409.2348647-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Reject KVM_RUN if userspace forces emulation during
 nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+ac0bc3a70282b4d586cc@syzkaller.appspotmail.com, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend KVM's restrictions on userspace forcing "emulation required" at odd
times to cover stuffing invalid guest state while a nested run is pending.
Clobbering guest state while KVM is in the middle of emulating VM-Enter is
nonsensical, as it puts the vCPU into an architecturally impossible state,
and will trip KVM's sanity check that guards against KVM bugs, e.g. helps
detect missed VMX consistency checks.

  WARNING: CPU: 3 PID: 6336 at arch/x86/kvm/vmx/vmx.c:6480 __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6480 [inline]
  WARNING: CPU: 3 PID: 6336 at arch/x86/kvm/vmx/vmx.c:6480 vmx_handle_exit+0x40f/0x1f70 arch/x86/kvm/vmx/vmx.c:6637
  Modules linked in:
  CPU: 3 UID: 0 PID: 6336 Comm: syz.0.73 Not tainted 6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  RIP: 0010:__vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6480 [inline]
  RIP: 0010:vmx_handle_exit+0x40f/0x1f70 arch/x86/kvm/vmx/vmx.c:6637
   <TASK>
   vcpu_enter_guest arch/x86/kvm/x86.c:11081 [inline]
   vcpu_run+0x3047/0x4f50 arch/x86/kvm/x86.c:11242
   kvm_arch_vcpu_ioctl_run+0x44a/0x1740 arch/x86/kvm/x86.c:11560
   kvm_vcpu_ioctl+0x6ce/0x1520 virt/kvm/kvm_main.c:4340
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:906 [inline]
   __se_sys_ioctl fs/ioctl.c:892 [inline]
   __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Reported-by: syzbot+ac0bc3a70282b4d586cc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67598fb9.050a0220.17f54a.003b.GAE@google.com
Debugged-by: James Houghton <jthoughton@google.com>
Tested-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b71392989609..8081efb25d7e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5875,11 +5875,35 @@ static int handle_nmi_window(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static bool vmx_emulation_required_with_pending_exception(struct kvm_vcpu *vcpu)
+/*
+ * Returns true if emulation is required (due to the vCPU having invalid state
+ * with unsrestricted guest mode disabled) and KVM can't faithfully emulate the
+ * current vCPU state.
+ */
+static bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	return vmx->emulation_required && !vmx->rmode.vm86_active &&
+	if (!vmx->emulation_required)
+		return false;
+
+	/*
+	 * It is architecturally impossible for emulation to be required when a
+	 * nested VM-Enter is pending completion, as VM-Enter will VM-Fail if
+	 * guest state is invalid and unrestricted guest is disabled, i.e. KVM
+	 * should synthesize VM-Fail instead emulation L2 code.  This path is
+	 * only reachable if userspace modifies L2 guest state after KVM has
+	 * performed the nested VM-Enter consistency checks.
+	 */
+	if (vmx->nested.nested_run_pending)
+		return true;
+
+	/*
+	 * KVM only supports emulating exceptions if the vCPU is in Real Mode.
+	 * If emulation is required, KVM can't perform a successful VM-Enter to
+	 * inject the exception.
+	 */
+	return !vmx->rmode.vm86_active &&
 	       (kvm_is_exception_pending(vcpu) || vcpu->arch.exception.injected);
 }
 
@@ -5902,7 +5926,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 		if (!kvm_emulate_instruction(vcpu, 0))
 			return 0;
 
-		if (vmx_emulation_required_with_pending_exception(vcpu)) {
+		if (vmx_unhandleable_emulation_required(vcpu)) {
 			kvm_prepare_emulation_failure_exit(vcpu);
 			return 0;
 		}
@@ -5926,7 +5950,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 
 int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
-	if (vmx_emulation_required_with_pending_exception(vcpu)) {
+	if (vmx_unhandleable_emulation_required(vcpu)) {
 		kvm_prepare_emulation_failure_exit(vcpu);
 		return 0;
 	}

base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.601.g30ceb7b040-goog



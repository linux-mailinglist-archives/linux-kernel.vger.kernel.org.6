Return-Path: <linux-kernel+bounces-260471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBDF93A9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DA9B2266A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B26B1494D6;
	Tue, 23 Jul 2024 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMj1p28n"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED013BAD5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776862; cv=none; b=LPXzgPKgNU+CyxpdopI/ZLwe8S+K586w+y6nNQ3NTyoOVXPRZi+XgqiyoR+OhKO3M9j4e1ovHmn0aihcLfycUUiVU1DhHJRZPvKoeYsU8B/i9PnG/SmU1OKW4ww5B3ZV1smqLhY9qGOQt2Z3FQe58P3PZOlpBDCsrkVquu5MYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776862; c=relaxed/simple;
	bh=8Y+iYHayY2JJwgeVzz2tqt/MVZXDqspYUC9TRMwsdlw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tyAaw4YMW9F8C815Kn2in/zBlG2p/AX95bmGeDd5EJxC57S2E0vFbHheqoeMgnQCFKHtf/LgFFZPsUSjhu1VLWJjjy7tcirTCTP3km5zi/yTiKjo7w58ZV0EsCICJYxpH2FkOFYnFChQxsc+pGCgevHhjf62P09BPwBurUqvmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WMj1p28n; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a28217cfecso1132931a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721776859; x=1722381659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhkUKgGKAmtJvBC69563aw4qrws1Qh7sTPRPKMZcT4I=;
        b=WMj1p28nLokCNYDM13AMw9xiLwqoQnA5mw5pcosXr+/804cQzFcSNAAcSId4mkS8CR
         fRpxgMEtmeIY7+0nxPsZeX1CzSs3DkwJCZ19VvlAUH2sZ+PxG+jufTNqdFMBOg6KVNFF
         OioRvAs4YEb2yndIl1Yi07WbNSZNHBlSw4QiG63tAo7t8J6rz4ykN4OeFWQQOLJ1RRVj
         q3I571FYlVZ0c6G1IcxROo3mJQcBqYnj4tjxm+wzVJwiZtgT90jz7w5cG8HO5vaDaJzp
         VP50wgF/DGzUwvOCTqsR/B0m5gDEhPz6UMtyMyf46HFY80mliX5ic3RCDB6KI4KDoHo3
         1HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721776859; x=1722381659;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhkUKgGKAmtJvBC69563aw4qrws1Qh7sTPRPKMZcT4I=;
        b=p25xVL9QtuRSa57r6xBRuKAGTmHW6OuFtrRCsEW0QUl68g0HwcNvWObEy3/5Gjoum0
         T2kgI0S1I2Wiv+JXHxx/+Dxt64a9aGsuZCWEjQu65HQzHXThrJZmZKfnuZIQicmL16rN
         CMfKcapMt00eqsvdTCXxUmwGimMe6t9v9dwGRFnyDvHgr5ww2dqX/3qNq/0xQz54hznb
         RVNxorlaE7Wkgv/rKDtKX2tJ9n7ofTuIuLanLOYI5+RRtRcHAAqKlkUFEXWZ+xg+B9kj
         lBXhvA0nZEKrCMDpjy1tCkuP5teC5GHlPL4viLQGKmd4qx7a5EeajKPYq9uupvdTxVTp
         Us+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9sTyrW5c2ZU5UQLkF9aDDWEmvtiQH9gVsupoSDdBsyBDrDblznyOM2vXe4raOulxKw0ay0gkoGBV0XzksRFY4HmJioY+YAGbZ1ZEq
X-Gm-Message-State: AOJu0YxBBOh1fyIIDv/QeRvATDf72w+XaVa5zYLY2GmH3kJ/jgK6pV2c
	DlLh/WyEsP9PXDIV6O8P/Uh/cUAhG1r6gn6xHk3htnF63wyvrZcrix2yE5eqJezHYcfxAKAZ42s
	+ng==
X-Google-Smtp-Source: AGHT+IHW/3mXbfu5Pg9dVenRcl8JGJI1fc7+S8jmzEbKrBTiWqrOQZhFB+0q7F3ISVuCk3mxT07+/UreqNg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:58c:b0:6f3:b24:6c27 with SMTP id
 41be03b00d2f7-7a87dcb0297mr1138a12.5.1721776859071; Tue, 23 Jul 2024 16:20:59
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Jul 2024 16:20:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240723232055.3643811-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Grab kvm->srcu when processing KVM_SET_VCPU_EVENTS, as KVM will forcibly
leave nested VMX/SVM if SMM mode is being toggled, and leaving nested VMX
reads guest memory.

Note, kvm_vcpu_ioctl_x86_set_vcpu_events() can also be called from KVM_RUN
via sync_regs(), which already holds SRCU.  I.e. trying to precisely use
kvm_vcpu_srcu_read_lock() around the problematic SMM code would cause
problems.  Acquiring SRCU isn't all that expensive, so for simplicity,
grab it unconditionally for KVM_SET_VCPU_EVENTS.

 =============================
 WARNING: suspicious RCU usage
 6.10.0-rc7-332d2c1d713e-next-vm #552 Not tainted
 -----------------------------
 include/linux/kvm_host.h:1027 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by repro/1071:
  #0: ffff88811e424430 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x7d/0x970 [kvm]

 stack backtrace:
 CPU: 15 PID: 1071 Comm: repro Not tainted 6.10.0-rc7-332d2c1d713e-next-vm #552
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7f/0x90
  lockdep_rcu_suspicious+0x13f/0x1a0
  kvm_vcpu_gfn_to_memslot+0x168/0x190 [kvm]
  kvm_vcpu_read_guest+0x3e/0x90 [kvm]
  nested_vmx_load_msr+0x6b/0x1d0 [kvm_intel]
  load_vmcs12_host_state+0x432/0xb40 [kvm_intel]
  vmx_leave_nested+0x30/0x40 [kvm_intel]
  kvm_vcpu_ioctl_x86_set_vcpu_events+0x15d/0x2b0 [kvm]
  kvm_arch_vcpu_ioctl+0x1107/0x1750 [kvm]
  ? mark_held_locks+0x49/0x70
  ? kvm_vcpu_ioctl+0x7d/0x970 [kvm]
  ? kvm_vcpu_ioctl+0x497/0x970 [kvm]
  kvm_vcpu_ioctl+0x497/0x970 [kvm]
  ? lock_acquire+0xba/0x2d0
  ? find_held_lock+0x2b/0x80
  ? do_user_addr_fault+0x40c/0x6f0
  ? lock_release+0xb7/0x270
  __x64_sys_ioctl+0x82/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7ff11eb1b539
  </TASK>

Fixes: f7e570780efc ("KVM: x86: Forcibly leave nested virt when SMM state is toggled")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af6c8cf6a37a..d3a4333807c6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6042,7 +6042,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&events, argp, sizeof(struct kvm_vcpu_events)))
 			break;
 
+		kvm_vcpu_srcu_read_lock(vcpu);
 		r = kvm_vcpu_ioctl_x86_set_vcpu_events(vcpu, &events);
+		kvm_vcpu_srcu_read_unlock(vcpu);
 		break;
 	}
 	case KVM_GET_DEBUGREGS: {

base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.45.2.1089.g2a221341d9-goog



Return-Path: <linux-kernel+bounces-542929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE07A4CF85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E3A1694F2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5881F4261;
	Mon,  3 Mar 2025 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuOwASM5"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F061F416B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046224; cv=none; b=XPR9dSknqXaI6U85/Bh/x8WW9RjEWlpT0VYbsAqDohsutPLqwrEsc/AdDJiHspaGB3VnGwK6rTycrADPHP/8bUYJkodgOo5wtv7pni6AJIaWGNmKw5VgCLa8Iom9UZ2wh0JCOAuHv2HHAlUwivDJWt57Vvf7EVIYXgFbIisTAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046224; c=relaxed/simple;
	bh=cybyLF+6a0xFOLpaO7HAkjnx8B+DEcCnYsdTti7tMtQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XGIBSnP7IgclqKUcEFOV8xdvKq0i19AkxLTBE+1uDijlo1RY3QORKJhIiALwYeUwWdAUsAJ/7+wiIR8llDJbX4lUozxu4F6OAnonUojS75jXrbDI7AjGDayGFsBgbdv95yCo5C5tbZwUOuaU4/NHmu5bmvZtlGaD5bnOLhPCaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuOwASM5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223d86b4df0so9681605ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 15:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741046222; x=1741651022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gd+RfLlKh5tESoQa3l8PmuvkGSAlK2XxIUJYV0fVaBg=;
        b=MuOwASM51tGoiiDzoiaNsI7YoNml4FrOt8Dm5mtoQEwKzzSOcxHdlC7Tz+E6A9VZxf
         Cgx8IPIjgtsu7cXaZMVdLbZ6qy+Ama5R+5qtF9Gi+SLOmkX+MXIlWJiUYyIfYgojw5zI
         XC4L2jzE378HkgtKdkxwfmyVTF5vCiCWcWWNYob8SVRbyRu2J6Jta8+pJ92R5r0T+g3F
         KzhToZrz4PPBo872VhidhQ0djB4ZPs9DreRlx4AdiMfkKfJAboQxIjg0hzGd64mcHiAf
         g1RRqqtmhZM2PDgq7PtrL73FnNEW8VkhS4AO71DYSqFuRClBvCOxbYchSJ9FISle1+5R
         UqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741046222; x=1741651022;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd+RfLlKh5tESoQa3l8PmuvkGSAlK2XxIUJYV0fVaBg=;
        b=o2ET4Eey0I+E+Clq9t1eslZwjilAHozZdNHuYXkxhob65oglz52GnZSTpWLatCJSns
         pQUB3vJvunLIJYaXxRRMnPknctZDtpdAbuOdTGc67mtH6CiDW+RG0e2xc5LqC3F4xVE0
         KLCjGgpUDAbt3LFjPYEgcvjU312KuHqRJAEauQaKF/S0uTLBV5POprOXprTJqcVQYXKu
         BgayMXyicy9+eZAN+rmKJiicotlry+afNwd78btVxbGHIpeoomyMGs+Xdu7z5UUzErzM
         uDB37i/OwGdvZDfkbuubmWWLpamiOkP1DC6BOV3LXdmJGxKeT+/aSrB+G1RUAroEOnCR
         nbbg==
X-Forwarded-Encrypted: i=1; AJvYcCWqzTqgyQvX8zuV3UYbADz/6Axzd4OLDRUls6MSjbd+GF5caxwwOZ4Im/M7i9igxogdSw2QRE4UaRYLifs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzocQUM6mdhBBT2OxTjXqdXkY2oUaKIhesOR422Cc0Em6LGDG5H
	lTGXKopQHBm+yEFUtgqIRcIWWkwr0iFc0aLVylQdAF/+bmUJSw8xDDP26keFSvAzxEEfLaWichh
	Sng==
X-Google-Smtp-Source: AGHT+IGX5wRTQnobJEKkoY5D6cUlZvAzQBSWp/HIXHWLswgh1Uyt2skI71q+ZOuax94kvBsik5c1VZXC7c0=
X-Received: from pfhg4.prod.google.com ([2002:a62:e304:0:b0:730:85dc:cebb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a8f:b0:736:4830:68a6
 with SMTP id d2e1a72fcca58-7364830691bmr10633992b3a.4.1741046222428; Mon, 03
 Mar 2025 15:57:02 -0800 (PST)
Date: Mon, 3 Mar 2025 15:57:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <Z8ZBzEJ7--VWKdWd@google.com>
Subject: QEMU's Hyper-V HV_X64_MSR_EOM is broken with split IRQCHIP
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"

FYI, QEMU's Hyper-V emulation of HV_X64_MSR_EOM has been broken since QEMU commit
c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), as nothing in KVM
will forward the EOM notification to userspace.  I have no idea if anything in
QEMU besides hyperv_testdev.c cares.

The bug is reproducible by running the hyperv_connections KVM-Unit-Test with a
split IRQCHIP.

Hacking QEMU and KVM (see KVM commit 654f1f13ea56 ("kvm: Check irqchip mode before
assign irqfd") as below gets the test to pass.  Assuming that's not a palatable
solution, the other options I can think of would be for QEMU to intercept
HV_X64_MSR_EOM when using a split IRQCHIP, or to modify KVM to do KVM_EXIT_HYPERV_SYNIC
on writes to HV_X64_MSR_EOM with a split IRQCHIP.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790433..820bc1692e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2261,10 +2261,9 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
              * the INTx slow path).
              */
             kvm_resample_fd_insert(virq, resample);
-        } else {
-            irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
-            irqfd.resamplefd = rfd;
         }
+        irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
+        irqfd.resamplefd = rfd;
     } else if (!assign) {
         if (kvm_irqchip_is_split()) {
             kvm_resample_fd_remove(virq);


diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 63f66c51975a..0bf85f89eb27 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -166,9 +166,7 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
 
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
 {
-       bool resample = args->flags & KVM_IRQFD_FLAG_RESAMPLE;
-
-       return resample ? irqchip_kernel(kvm) : irqchip_in_kernel(kvm);
+       return irqchip_in_kernel(kvm);
 }
 
 bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)



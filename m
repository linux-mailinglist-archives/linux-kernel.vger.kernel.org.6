Return-Path: <linux-kernel+bounces-257743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7114937E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D022B2184A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974D51494AD;
	Sat, 20 Jul 2024 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHMBkVT3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10B148318
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433714; cv=none; b=qbptHgflW4qunjEY1o0z/SG03s+HyxYa86VcBWwqNtxi1TKxNXiO9toNm/kVekxmb0ptRXqTi4YBe2Vf8IPCU901t86EKCMT0Y+vhZcViWeB6755+8JDPkV8JYY8/gOzBotL6d6ONPz3P0wb5cUwuS9oulv7/A09ZrF+9/xC8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433714; c=relaxed/simple;
	bh=XgD5GqltxUDG4lPHOu6o7JlASxacI4CRdFqu+5ZOIe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IB7HMSLzKtxT8CsmrkkkHMIws8ZdXKYz8j1NZNnkKwTWKTWwXZYNzuKOWgl8staRH/yoI9Im9EMPywT8CgazqegnJK5Z6/ryNOg4x/Srj33eP56LvahJ5XPz1WkL9f0vetL0S2y9Uu8EA844LgDzCvJcsQFF4F8azULCChvFFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHMBkVT3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so5710989276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 17:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433712; x=1722038512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uP1DFI8G8OMRVwqXzFjttFTT28cC2fff2ANO01+U4QI=;
        b=nHMBkVT3iST6hfzkQAvW5dkGWeEXwXJAssm8KE/yCfjV1f3WLL/4GXIwXYFBDqKR6u
         JON+Qj2IbVciO8f11S/h/T/cpUeHO/9eRF3E8KknMj1iHKCHts43QEtiSN/219kJX503
         MLiA9HD7sSLbsh0aWpejO84A91Z9//ZuQxiEwDsZua7oAn44/X4rshrA25qRwiAVeie1
         mPJPNwORFmLL1suQwHHzTqdlrCbKYfqcO4J4YLJPlBuda2RAfoZ2Z+mluLL2mqu4pU5M
         icBoCPBAskxk53Ac5Ns5z6rXNqi0lSLk9W0yTVhEZeSIHHYe6hQ6ef+9VD0Xz066rz1E
         g4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433712; x=1722038512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uP1DFI8G8OMRVwqXzFjttFTT28cC2fff2ANO01+U4QI=;
        b=WGEKrIVCtA4SpDxLP0A75xTyyGVX/5uXz9Uc7uPvbHUJKkepLCWYk9kg7Gak3SOBiZ
         5JHrNLe70ylSsR8XOpbS50zQf9L3wEAY/b1pQ3l+JTyNetNFycVDDI+rlLmpoEU80G25
         yKaVdhRxS4d3f++Kgt7CmG/ad/aKP2P/QMvz/aC3JKxLozPoFZOKtrtybkFPvnqBf+3H
         RQ1a8eX9ejnnI2VmSK6U9W6y7XGH6Tf3IKtrk0eHP9Pabu7Nx32DPCunHX3PNkwEyJb3
         kZHepuyej5s5HogQQNA+HgihUj1K5ANMehnyy83UhRC+avAiU/h9a/iNos+yvKxEaD5T
         +7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXsjvJ8gkxRTzI0ApaboykoH/RmxsbvCblW1hiE+4yZ+owzu6Co3CXqqpDZT87eZWrxbnKtXrQlockg/9pzG5vz6Yb21O7/2XCYYVub
X-Gm-Message-State: AOJu0YyzcssxRnAY+PDRvCjTZA1qwFQOjpC8SlQFHXjY7VT7w1g6YXRJ
	yL0Thqku6iX1MqzEafEV9T/DvtEN2IsxKEpqssRxcCuzapnLvtqS/2EYBJDkOFInrTM/lYhX0wQ
	Vew==
X-Google-Smtp-Source: AGHT+IGKChwVghPbVLUjeGfiUXsgd7fKmmdWApzzdOSbuKqTecu2/MtGolotqeK0MGxQ8atcvr0qSuh1cds=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1891:b0:e03:2217:3c8f with SMTP id
 3f1490d57ef6-e086fe4020amr2324276.2.1721433711647; Fri, 19 Jul 2024 17:01:51
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 17:01:38 -0700
In-Reply-To: <20240720000138.3027780-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240720000138.3027780-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240720000138.3027780-7-seanjc@google.com>
Subject: [PATCH 6/6] KVM: nVMX: Detect nested posted interrupt NV at nested
 VM-Exit injection
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

When synthensizing a nested VM-Exit due to an external interrupt, pend a
nested posted interrupt if the external interrupt vector matches L2's PI
notification vector, i.e. if the interrupt is a PI notification for L2.
This fixes a bug where KVM will incorrectly inject VM-Exit instead of
processing nested posted interrupt when IPI virtualization is enabled.

Per the SDM, detection of the notification vector doesn't occur until the
interrupt is acknowledge and deliver to the CPU core.

  If the external-interrupt exiting VM-execution control is 1, any unmasked
  external interrupt causes a VM exit (see Section 26.2). If the "process
  posted interrupts" VM-execution control is also 1, this behavior is
  changed and the processor handles an external interrupt as follows:

    1. The local APIC is acknowledged; this provides the processor core
       with an interrupt vector, called here the physical vector.
    2. If the physical vector equals the posted-interrupt notification
       vector, the logical processor continues to the next step. Otherwise,
       a VM exit occurs as it would normally due to an external interrupt;
       the vector is saved in the VM-exit interruption-information field.

For the most part, KVM has avoided problems because a PI NV for L2 that
arrives will L2 is active will be processed by hardware, and KVM checks
for a pending notification vector during nested VM-Enter.  Thus, to hit
the bug, the PI NV interrupt needs to sneak its way into L1's vIRR while
L2 is active.

Without IPI virtualization, the scenario is practically impossible to hit
as the ordering between vmx_deliver_posted_interrupt() and nested VM-Enter
effectively guarantees that either the sender will see the vCPU as being
in_guest_mode(), or the receiver will see the interrupt in its vIRR.

With IPI virtualization, the sending CPU effectively implements a rough
equivalent of vmx_deliver_posted_interrupt(), sans the nested PI NV check.
If the target vCPU has a valid PID, the CPU will send a PI NV interrupt
based on _L1's_ PID, as the sender's because IPIv table points at L1 PIDs.

  PIR := 32 bytes at PID_ADDR;
  // under lock
  PIR[V] := 1;
  store PIR at PID_ADDR;
  // release lock

  NotifyInfo := 8 bytes at PID_ADDR + 32;
  // under lock
  IF NotifyInfo.ON = 0 AND NotifyInfo.SN = 0; THEN
    NotifyInfo.ON := 1;
    SendNotify := 1;
  ELSE
    SendNotify := 0;
  FI;
  store NotifyInfo at PID_ADDR + 32;
  // release lock

  IF SendNotify = 1; THEN
    send an IPI specified by NotifyInfo.NDST and NotifyInfo.NV;
  FI;

As a result, the target vCPU ends up receiving an interrupt on KVM's
POSTED_INTR_VECTOR while L2 is running, with an interrupt in L1's PIR for
L2's nested PI NV.  The POSTED_INTR_VECTOR interrupt triggers a VM-Exit
from L2 to L0, KVM moves the interrupt from L1's PIR to vIRR, triggers a
KVM_REQ_EVENT prior to re-entry to L2, and calls vmx_check_nested_events(),
effectively bypassing all of KVM's "early" checks on nested PI NV.

Note, the Fixes tag is a bit of a lie, as the bug is technically a generic
nested posted interrupt issue.  However, as above, it's practically
impossible to hit the bug without IPI virtualization being enabled.

Cc: Chao Gao <chao.gao@intel.com>
Cc: Zeng Guang <guang.zeng@intel.com>
Cc: stable@vger.kernel.org
Fixes: d588bb9be1da ("KVM: VMX: enable IPI virtualization")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 40cf4839ca47..f1fe4d5a1ed8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4296,10 +4296,21 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		if (nested_exit_intr_ack_set(vcpu)) {
 			int irq;
 
-			irq = kvm_cpu_get_interrupt(vcpu, -1);
+			irq = kvm_cpu_get_interrupt(vcpu, vmx->nested.posted_intr_nv);
 			if (WARN_ON_ONCE(irq < 0))
 				goto no_vmexit;
 
+			/*
+			 * If the IRQ is L2's PI notification vector, process
+			 * posted interrupts instead of injecting VM-Exit, as
+			 * the detection/morphing architecturally occurs when
+			 * the IRQ is delivered to the CPU.  Note, enabling PI
+			 * requires ACK-on-exit.
+			 */
+			if (irq == vmx->nested.posted_intr_nv) {
+				vmx->nested.pi_pending = true;
+				goto no_vmexit;
+			}
 			exit_intr_info = INTR_INFO_VALID_MASK | INTR_TYPE_EXT_INTR | irq;
 		} else {
 			exit_intr_info = 0;
-- 
2.45.2.1089.g2a221341d9-goog



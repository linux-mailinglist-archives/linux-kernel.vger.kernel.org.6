Return-Path: <linux-kernel+bounces-392797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7B49B983A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6721F21F19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B831CF7D8;
	Fri,  1 Nov 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AK22g6er"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334B1CF5DD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488497; cv=none; b=fl6auj9cQzPVSEcPW9hF3378bEuz8KwJCBrF5c81v0Kw07NQAhGIgO/26astsEDzzBQpgz7xgyPj+E6NRuwJ3OHMutpN2UwScMhwBdEgL9o1BQDVAyMCG3efucdg4EFT/tiUHC+Q3yTAuG7jS0FEzuyvdO2QPehLu2wUvncAqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488497; c=relaxed/simple;
	bh=AW20RPSqHiDv3fdCFx5HqXZFyAEwbL8305AAGXtmtFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FBzE4U/Ac1LZZh/DaBHwA6fe3IJ6/WwhKEp6zkJn2c9n9fCd8zryq3Nk2QFfHOECUyfM7guL2nnGLdJKYUvH+U7HcdlQJDG3QHdF/Faa3y8BIjgeRyJ2J7eRgojMm/3z6cdlS8d29YPV8tUbFZEvD9apJRUHrgsdnCcmZdvyhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AK22g6er; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e33152c8225so724823276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730488495; x=1731093295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eKpbimIHH00sjHL9LmhMqa7Xx8rmdKzGFtZAWYFdii8=;
        b=AK22g6er8cxh5A75erKAuaBUdWuN2b/rKANfBJi36YWc9723cQ9QGkVWckkNKOzvan
         PaQ+Zi0jOMDAVdB4S8wzPOb6kzp0jWRWDD8U0+GjtbpHPEcFQWvcCaL5oDAeyp7Bmdbm
         SN/TXzSAlE6kOrVZ6BMtc9tlscvEMpijaNiBOl1J5+a9OcBXqScs2jYPO8B6t1SZmrXL
         KUtRrb6nnc9IiuRvncAwAiAUfRfHGdmEwj/05UGN2swVfJlJh2C7T6qmqKSpyQaNQ3Op
         mJVhqubIryAw0/O33WBZzaI9r+V/cbIljBc9s4DFqKHYcohhq6sE9KReGjqZPjeFC/gf
         euRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488495; x=1731093295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKpbimIHH00sjHL9LmhMqa7Xx8rmdKzGFtZAWYFdii8=;
        b=enRW+zzeMa82XJy+LD0qYtMJyz2VL4WcFdjutV+yRAp628AsSJvddQ+1taf/4q8aLb
         17mT+L5d6LWxvWAYbhrnHm4BRtOw2JraUVNFdhuZRXVaSvWJPPRxzbCzPASnFWw3btNH
         APmfO0SHrJW0O5T2QY3re87a09q/ig7qrgIlNObxSXWIuxHPvNpY+qa3cfmXv4ofGRsr
         gBBLbx9aUQiQ40KnPa4yZZAc6ECtWWvmrvN3MzoClGV+VY7EWNiO4DLyVu15Y4fOYdRE
         NVRWB8A9HQ9FXk8JrTaIRPmYzogCCmA4OZxcisIqp//jc94D4GPoNOu+EctUjSgvVbXt
         vHlA==
X-Forwarded-Encrypted: i=1; AJvYcCVLKfIapHUSWuYcReQQ8inP3ifvwz16/DvOrJxyWWfGxaAqHZo0+XTR1ow74PxuxdW+VspIl5N0dJqW8CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+9F2JqTbJbHE3PUFteQdFJkiVrR6CMRxrEK7Gauf2LbwKztd
	I5l/ifBQJFmGDm4rRWtTtFEFsJ9au9I+PJ2nc4hbOxKMoujiYJxUMZ9x5VZp3MZiJmY1cw+zOb5
	QrA==
X-Google-Smtp-Source: AGHT+IEg0O0AegMc5HJlVs59TSZ96+d/qrSdvFRy5uOr2T1xkt+bIsh/JxfUJG2zkmVqY/VivVCoVROYj0o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:aa89:0:b0:e2b:e955:d58a with SMTP id
 3f1490d57ef6-e330268d946mr2445276.7.1730488495007; Fri, 01 Nov 2024 12:14:55
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 12:14:44 -0700
In-Reply-To: <20241101191447.1807602-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101191447.1807602-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101191447.1807602-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: nVMX: Check for pending INIT/SIPI after entering
 non-root mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly check for a pending INIT or SIPI after entering non-root mode
during nested VM-Enter emulation, as no VMCS information is quered as part
of the check, i.e. there is no need to check for INIT/SIPI while vmcs01 is
still loaded.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 84386329474b..781da9fe979f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3517,8 +3517,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		(CPU_BASED_INTR_WINDOW_EXITING | CPU_BASED_NMI_WINDOW_EXITING);
 	if (likely(!evaluate_pending_interrupts) && kvm_vcpu_apicv_active(vcpu))
 		evaluate_pending_interrupts |= vmx_has_apicv_interrupt(vcpu);
-	if (!evaluate_pending_interrupts)
-		evaluate_pending_interrupts |= kvm_apic_has_pending_init_or_sipi(vcpu);
 
 	if (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
@@ -3605,6 +3603,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	 * unconditionally.
 	 */
 	if (unlikely(evaluate_pending_interrupts) ||
+	    kvm_apic_has_pending_init_or_sipi(vcpu) ||
 	    kvm_apic_has_interrupt(vcpu))
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 
-- 
2.47.0.163.g1226f6d8fa-goog



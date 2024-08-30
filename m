Return-Path: <linux-kernel+bounces-308046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31722965687
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10ECB21254
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5714C5AE;
	Fri, 30 Aug 2024 04:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zq/Ezf/A"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18D13E3F5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724993094; cv=none; b=ddSdkITH/7NrdQ7WtmD6FsWzBUTbiZ87ZNKUbYfIah+9zTdHbTj5YQ01xPKW9RihROBi0uBGdLaEe1p/8RfK/IOP5n8YVuyZo+yZHQQng7v0OugJdm3jeN33VeZ8h7FJ6BYLdSq2qtcYAwSA8qZhPug2j3EHqqioaJQXscXsj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724993094; c=relaxed/simple;
	bh=pc/7ceK4ObBeg/kDLblZ1GBH9vVW+84KaNV53ph5Wag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nacKJFz+xvaHOiNfRXRagbBZ1EXfG8vHfM8nKMMmgvqjqpEVI68K7jRmW3rCpqvCbGHBBUY0OlaDYDS+ZDHjEwhJ/iygDcG/gvnj5mPgvZ4UJQ7RDbpVl3NF38BMAOQ8YpxK5fUWNS6ISSNdeBPYOsdOjDEruFpmpWDM/8b1rQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zq/Ezf/A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b2249bf2d0so31053317b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724993091; x=1725597891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiZ70XdmA4+Hdc1IH2ldo4IIgSO3M+LAInRSo5hPQTk=;
        b=zq/Ezf/AuhH46p7/N+usjlE+DvthtducpSlB9QAF+rPtWJBEke449/a3kFnRZRLq1Y
         lbU+LOZ11YDeaNZqgfJGy4Om3BRKV0RM2KnK2BZix1ZoRZno0o2EvfksuCpD+Mxejw3v
         iCtsJRaEzgYprJBm7d7ivKwOl7P/sWA1xPlozpB14AkY/K6kXWkWjF+zcLEomig9sTYf
         hTmvO+8UGYw1XH9Uf/uhQPzpKNiOiNHEAbv1uqMcBsYzz4GowI1Am08Q/aO76fHTmVkV
         BVWKmjcYTHxC4+ovWi8LO6AhlhOWS2NhRAJAsHhBCXBE39C7YEGEd5k/WeEEaZ1+TKL3
         5hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724993091; x=1725597891;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiZ70XdmA4+Hdc1IH2ldo4IIgSO3M+LAInRSo5hPQTk=;
        b=pFlez4BbQBnIItbUOkK3y67OctJNz+OQXFg8Bz3OkO51pcMU2bdNdGWKv6RTt0XhlQ
         4pi57u2XJDbBL/hOQyn2Rh/HZfbu9Dx2P1wa2/w8F1E8pbTKVkseaRbajfqPqvooFMgn
         4pL/P7ptRN7p8McUaq5ptRKnaWUm6THJH5ksuzEmh+QyXLs/i485OBsp4U0C1qmz4keb
         V8OtvXfM+Gf98nn+iObUDlgkjJ8KDXHNl6+kk3Wc2zWul8yEBjB7cJG/jKlvlgshDXQ1
         dpkDsDFjLmTnTXDronYwNo5GaNAw4pzdPP28DqxCxOtYjsWCyitCSDDj9/TPgePg9BqO
         gGgw==
X-Forwarded-Encrypted: i=1; AJvYcCWXn5XGlwNCdjOfchwg+7QvGsWT20AR7Wlt0d9W7Pz/AT7kNCKC/Ba5wwKxQhaNqjeg5MI3AueBsNiN43Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BeHY1xlHDgOW8ykq9JBkZ/A1mNWeqCu6k3TPWUzI8xYx2ysP
	yeZkb+Qx2SVP7YHK2pMPTuU4FYpPy+/8GHCkzsCZxWf8S8KMrb3qSHNIv/Rnj6qNn1iBB7ouyHS
	J4A==
X-Google-Smtp-Source: AGHT+IEGbYBf8kBIfzCeCPJTiVm/3yEhrFexY1zHyLMig4+kXsZbNN6NBcX6bEYe6aTEcKNlR+NcFzYF2t0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:418c:b0:6ad:feb0:d010 with SMTP id
 00721157ae682-6d4107cb17cmr66777b3.6.1724993091581; Thu, 29 Aug 2024 21:44:51
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 Aug 2024 21:44:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830044448.130449-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Verify single-stepping a fastpath VM-Exit
 exits to userspace
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In x86's debug_regs test, change the RDMSR(MISC_ENABLES) in the single-step
testcase to a WRMSR(TSC_DEADLINE) in order to verify that KVM honors
KVM_GUESTDBG_SINGLESTEP when handling a fastpath VM-Exit.

Note, the extra coverage is effectively Intel-only, as KVM only handles
TSC_DEADLINE in the fastpath when the timer is emulated via the hypervisor
timer, a.k.a. the VMX preemption timer.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/debug_regs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index f6b295e0b2d2..76cc2df9238a 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -47,15 +47,18 @@ static void guest_code(void)
 	/*
 	 * Single step test, covers 2 basic instructions and 2 emulated
 	 *
-	 * Enable interrupts during the single stepping to see that
-	 * pending interrupt we raised is not handled due to KVM_GUESTDBG_BLOCKIRQ
+	 * Enable interrupts during the single stepping to see that pending
+	 * interrupt we raised is not handled due to KVM_GUESTDBG_BLOCKIRQ.
+	 *
+	 * Write MSR_IA32_TSC_DEADLINE to verify that KVM's fastpath handler
+	 * exits to userspace due to single-step being enabled.
 	 */
 	asm volatile("ss_start: "
 		     "sti\n\t"
 		     "xor %%eax,%%eax\n\t"
 		     "cpuid\n\t"
-		     "movl $0x1a0,%%ecx\n\t"
-		     "rdmsr\n\t"
+		     "movl $" __stringify(MSR_IA32_TSC_DEADLINE) ", %%ecx\n\t"
+		     "wrmsr\n\t"
 		     "cli\n\t"
 		     : : : "eax", "ebx", "ecx", "edx");
 

base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.469.g59c65b2a67-goog



Return-Path: <linux-kernel+bounces-445796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76F9F1BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D121889DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E9101DE;
	Sat, 14 Dec 2024 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Um9JNsLA"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48449D529
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138445; cv=none; b=qwgjVzcwncKk9MfHMXnyAtlYe9IRUyz3GvojVtklLwR8Bj+2HSfHYl+Vw8aXtNhg8wmy9+btziU6RPwgSU2aPxrQB5xbEWQ9hxWVXpdqZg2maTyzP6KjiySGCAuglTCPkZFvUgQY5JlG1yD6sc5yvqYBvBc+On2w26agPExo/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138445; c=relaxed/simple;
	bh=TEcjPwY8F3+Wd5Us2Ab9oD01qsPrOs6/BjBcJXXFnoE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PuiILRIbGFaZjXYBJ83olI3ZPHRPmwiLnN18PCoDyC2LxE1u2eRIlfGG28+bFiuzfhXF2bNvOX6iveIEFmrEpPh3qROWr4/mFtEvIlyaGG+PovZnbnTgMfjTO//fkj5MZUkOoxdJCQAxY7IyJA4AIdqG4DMa3T/7OGE4vaNnmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Um9JNsLA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166855029eso21138955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138443; x=1734743243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF0QqBz6fmUE/aM7acX0fYib5RzHVuuLEZBaBu3f+Vw=;
        b=Um9JNsLAJuALkVD/R/J1YgFxo0EfV6I1Z6ydoDVSTxWQNv3AMVSARg4lRFI9ASsB59
         zlH+SZCTzX5mPMnQCYwzG7W9+lkLTV2wabi8rArGQkiPJTFQemgj7sA+MIrSRRB90XJB
         +jMZP2hA5BZGHqBAw5qNszs+DojEOUR5bgYfLXuX/fNLts6KqvwOD7uhUeDNnY9cLdC/
         OrjDUlMX2UQ15Tprg/xX7vJ2XfMn8SQnrKTfQSKt6CYF7e2A5v0IrxlKKaaQezuT/lVr
         gMejPF5LZwYghRl0q5F9l/DWQ/M/jplgWzopkek48GhA3aLmY8EaKMfcUNS+kveRp+x5
         wYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138443; x=1734743243;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rF0QqBz6fmUE/aM7acX0fYib5RzHVuuLEZBaBu3f+Vw=;
        b=bXcxxj4Rd9iMu03nyOv7nIbwC2jzoQlx8HmMwY3c0PHk+/mlAPS2rQJXu059ReZDM2
         SWdlQeScY/kcP257UhEPUJH+DlvvLwuH77+nHYZAHlyMcYBie21em/l+D8hhdIlgvvDi
         kNJwgXBuIW5Dm9d749JEqxAuFYcaL3FvH/Uq8QWI/C52LAIcNOP+AYPi9EMlQOKsTJPz
         nsLax+DrkV/OlA3bb0QnURhvW38Ha0ApyJjt8uZ6wzNvUwsX+95M46p7H330Zp2nZRJa
         /6yEHxFiVrTiJ85JYf6TZSuYdsMMWwOS6M1+OHl2wV4elG5BDfYmTixAdyaZ90Y4RmPe
         Jx1w==
X-Forwarded-Encrypted: i=1; AJvYcCWHq0CBEyHAoJoW/sBRb0JR4cQg83p7d9kE3VxQ1swn96yhN05tpcu+5gW/yqZ9G8x8kDyfN98ihCd3zn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jCdeEhbixVpj9EvehvKh3dser+yU90H5oYoJarYGAUhOD3pQ
	dsOLMHXgzagJ9uBM3tbVKn4PFVElAmWK5uf2lX0NVmXqnbJsWzQwUD5ur5mqh1dabG+KXM4lJ1a
	I4w==
X-Google-Smtp-Source: AGHT+IGMCtcyoBcc8ZgIGCQDeNqNAPncEJv64I/tYQb7qnpKYjRgqHj0C22i46XP4zkRB5BlkxxuJNdzfso=
X-Received: from pgbbw32.prod.google.com ([2002:a05:6a02:4a0:b0:7fd:40dd:869f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c9:b0:216:59d4:40e7
 with SMTP id d9443c01a7336-21892a59f57mr54619905ad.55.1734138443620; Fri, 13
 Dec 2024 17:07:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-1-seanjc@google.com>
Subject: [PATCH 00/20] KVM: selftests: Fixes and cleanups for dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a variety of flaws and false failures/passes in dirty_log_test, and
drop code/behavior that adds complexity while adding little-to-no benefit.

Lots of details in the changelogs, and a partial list of complaints[1] in
Maxim's original thread[2].

E.g. while not a particular interesting bug, hacking KVM like so doesn't
elicit a test failure.

---
 include/linux/kvm_host.h | 2 ++
 virt/kvm/kvm_main.c      | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 401439bb21e3..bf7797ae2cdc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -389,6 +389,8 @@ struct kvm_vcpu {
 	 */
 	struct kvm_memory_slot *last_used_slot;
 	u64 last_used_slot_gen;
+
+	bool extra_dirty;
 };
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index de2c11dae231..9981f1cc2780 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3444,6 +3444,11 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
+		if (!vcpu->extra_dirty &&
+		    gfn_to_memslot(kvm, gfn + 1) == gfn) {
+			vcpu->extra_dirty = true;
+			mark_page_dirty_in_slot(kvm, memslot, gfn + 1);
+		}
 		if (kvm->dirty_ring_size && vcpu)
 			kvm_dirty_ring_push(vcpu, slot, rel_gfn);
 		else if (memslot->dirty_bitmap)
-- 

[1] https://lore.kernel.org/all/Z1vR25ylN5m_DRSy@google.com
[2] https://lore.kernel.org/all/20241211193706.469817-1-mlevitsk@redhat.com

Maxim Levitsky (2):
  KVM: selftests: Support multiple write retires in dirty_log_test
  KVM: selftests: Limit dirty_log_test's s390x workaround to s390x

Sean Christopherson (18):
  KVM: selftests: Sync dirty_log_test iteration to guest *before*
    resuming
  KVM: selftests: Drop signal/kick from dirty ring testcase
  KVM: selftests: Drop stale srandom() initialization from
    dirty_log_test
  KVM: selftests: Precisely track number of dirty/clear pages for each
    iteration
  KVM: selftests: Read per-page value into local var when verifying
    dirty_log_test
  KVM: selftests: Continuously reap dirty ring while vCPU is running
  KVM: selftests: Honor "stop" request in dirty ring test
  KVM: selftests: Keep dirty_log_test vCPU in guest until it needs to
    stop
  KVM: selftests: Post to sem_vcpu_stop if and only if vcpu_stop is true
  KVM: selftests: Use continue to handle all "pass" scenarios in
    dirty_log_test
  KVM: selftests: Print (previous) last_page on dirty page value
    mismatch
  KVM: selftests: Collect *all* dirty entries in each dirty_log_test
    iteration
  KVM: sefltests: Verify value of dirty_log_test last page isn't bogus
  KVM: selftests: Ensure guest writes min number of pages in
    dirty_log_test
  KVM: selftests: Tighten checks around prev iter's last dirty page in
    ring
  KVM: selftests: Set per-iteration variables at the start of each
    iteration
  KVM: selftests: Fix an off-by-one in the number of dirty_log_test
    iterations
  KVM: selftests: Allow running a single iteration of dirty_log_test

 tools/testing/selftests/kvm/dirty_log_test.c | 515 +++++++++----------
 1 file changed, 240 insertions(+), 275 deletions(-)


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.47.1.613.gc27f4b7a9f-goog



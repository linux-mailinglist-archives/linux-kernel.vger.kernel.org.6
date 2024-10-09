Return-Path: <linux-kernel+bounces-357765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDD99758F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448BB28397D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E21E260E;
	Wed,  9 Oct 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVYWPHMc"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D11E22F9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501835; cv=none; b=ZamUgT8dILWuUyD4ckDZgiOMfJFBWehvtojjoUIPzDO2D58OYEiY7bVrkz8YirtYlILFcRGOdr2EXZNIxHdsB81hDwbM//1Pe87m5CfmMS40hhlVeBQJzun7H23IKEbDhhyj+16Lg0KAeGsHsIZwBsB/qBuQPeNamRMsZV0ijXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501835; c=relaxed/simple;
	bh=i1AfRS5ndMXdqtCSQluoP1BVzX/y9mDGJV2x5I9dvrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HUqrDleKxIP2lsJgoEAkn5//dr7u/h06EZrzAcAEOM4y7URrhDZZhxu4GBPmsW6B49AwaPj7iFm0RKt6JwehQ75qiMpT2Hk4cIfyNOgEEzpIsK+Qtyx8rbXLMBDozkEpYM5LwS/rwxXfY0VFB/cgJy62roW7KzvMmMIZ8hHCPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVYWPHMc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso213912a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728501834; x=1729106634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i9BdalRrINJVrDcrtezLTinwXxj+SPewGxzSEbZM+70=;
        b=DVYWPHMcgr3JY2kq13sSYz2oBipEHg8tcrEXVGQKjdH0jizU7rp9g0/wbaRdyG/S2V
         28fUE0aY8zZaBnKzfiyGwKNXaqWNGNCXLzSwvnUfMqYipBh0VnifuFBI9bkOKiqvDh49
         rbKMXeUGI8YPq1kC4zGbZ+52ejP52V93IreckftUuDwWmMunYKYiBFydhgLjJusWXzv9
         Prn3qo5VriiEkRS7xPdhQVM+Vwol9ZkpR6MZejDQYEvtqkfby1dBEX9cErPOledlRNT5
         +kigCtEcJ5vZVWMc+R/j3L4EZWEpDlsxVcVp59C1gldC3P76PFw/x2Iv5X90VLOeCKAK
         7snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728501834; x=1729106634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9BdalRrINJVrDcrtezLTinwXxj+SPewGxzSEbZM+70=;
        b=ARu0CpUH61F8WuOPJqnSKWW89coOnrR9oDhJL0f1n1mhQil808hlSZoPH72pdYY2kn
         tH7yP/fp/f18fvQd2oi5uFO+F3BWFT7iuGqhTGD41jCs2h3G7T+wjHFUXzdWqcyGMRh2
         Z+maIx3OL24KrTaPkMJxFdfFAKdQCutCg8IUMtUrm391xXGhfJ1/a9hCSik4xeWFZFk7
         yK8g4106F1g7wJkPDvrAs//a/8TgpTtvILyUI8jJefa2ya3m88BqAwsl+Wae/k++Zbgn
         pwlVYdzHV+az5J3wbU4Vg6ov2Vkr6/FbjBoh/hTxusmK8tw76JFlCBHR38qvrxC24ZYR
         p/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWkgk3bzBVaduagAcp60iJADp8keYjSDsAPZiA+vE5TPglywSLNzsWSWCrNVAImaqHo9NfjWnkpl2VEZz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEWKA4BJlCuqrp2Ze+RqRTNnnezqfoTHAQOjIPaU1jRVMnSMG
	XS0BUQlkJBvf7DwfGETvmoXGQQNRTfkjGemo0MlhOWb7IOi+6r6L3Nu0rbPsABorNDQdFjZMcuI
	Hig==
X-Google-Smtp-Source: AGHT+IGdx+V3bQgWDNAJK6Wy1vX01P4om5Fw6X1AQADID6XkrRPdfHX3uXvEWSRXRAwVh5niEzh7Nqh+YL4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:b208:0:b0:7a1:6a6b:4a5b with SMTP id
 41be03b00d2f7-7ea3f892d1cmr649a12.2.1728501833564; Wed, 09 Oct 2024 12:23:53
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 12:23:45 -0700
In-Reply-To: <20241009192345.1148353-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009192345.1148353-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009192345.1148353-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: x86: Clean up documentation for KVM_X86_QUIRK_SLOT_ZAP_ALL
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Massage the documentation for KVM_X86_QUIRK_SLOT_ZAP_ALL to call out that
it applies to moved memslots as well as deleted memslots, to avoid KVM's
"fast zap" terminology (which has no meaning for userspace), and to reword
the documented targeted zap behavior to specifically say that KVM _may_
zap a subset of all SPTEs.  As evidenced by the fix to zap non-leafs SPTEs
with gPTEs, formally documenting KVM's exact internal behavior is risky
and unnecessary.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e32471977d0a..edc070c6e19b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8098,13 +8098,15 @@ KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS By default, KVM emulates MONITOR/MWAIT (if
                                     KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT is
                                     disabled.
 
-KVM_X86_QUIRK_SLOT_ZAP_ALL          By default, KVM invalidates all SPTEs in
-                                    fast way for memslot deletion when VM type
-                                    is KVM_X86_DEFAULT_VM.
-                                    When this quirk is disabled or when VM type
-                                    is other than KVM_X86_DEFAULT_VM, KVM zaps
-                                    only leaf SPTEs that are within the range of
-                                    the memslot being deleted.
+KVM_X86_QUIRK_SLOT_ZAP_ALL          By default, for KVM_X86_DEFAULT_VM VMs, KVM
+                                    invalidates all SPTEs in all memslots and
+                                    address spaces when a memslot is deleted or
+                                    moved.  When this quirk is disabled (or the
+                                    VM type isn't KVM_X86_DEFAULT_VM), KVM only
+                                    ensures the backing memory of the deleted
+                                    or moved memslot isn't reachable, i.e KVM
+                                    _may_ invalidate only SPTEs related to the
+                                    memslot.
 =================================== ============================================
 
 7.32 KVM_CAP_MAX_VCPU_ID
-- 
2.47.0.rc1.288.g06298d1525-goog



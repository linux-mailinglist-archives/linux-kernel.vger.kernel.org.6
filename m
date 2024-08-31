Return-Path: <linux-kernel+bounces-309597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FA0966D49
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D861F24376
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0172B9AF;
	Sat, 31 Aug 2024 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjxQ0x6m"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A052263A
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063361; cv=none; b=UelUK6t46mykYDs1rPJP2sdQ2PMLC4HiFe2TJBzojJv2IcjH3bsc0QWBteDE2Wet19k8Env4HiMWLHW+EMnLjtiup7VMayO9iSEkNRkIApMdVbF/cq1luZGdyi9EH9jESxv/RWFKst4JePrUtbadV2vtZ9uHJf/0jAEZxlle0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063361; c=relaxed/simple;
	bh=DjdRqrZVYaDjDoNjboOK73Yx3wVuE0JYZU3mSEZ1MxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSVLyY7Y6X7ivhH/PIAhWo6cdSCsiTB6vlnn1pL/APOhYD48yCjmfsZ8C0phBQtgpTKZn0Bn2g+gfVNICTaMS7hBpianJl75R13e4FmyNmnvvB7xtjXVdelK1pYGhzePHXpfN7spyBh+GUXma1vMSrezoyQc0tCGwYAr4NHx7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjxQ0x6m; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d52d811d1aso3586927b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063359; x=1725668159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7IoutToPYHP78p+giZTIYSlAIHUDU+a9Cu0+YJ5R9Xs=;
        b=TjxQ0x6mO0qhLDz7PUmPBXJZFI6tjXSmkWi5TFrqGLmpDtFk7g7523cJ7jdnCbwpg9
         BXFOJ2kc5WSYChLT4x0HqbWXQLsxoeP8OJkdNCb/MzFGLpMoE05Rz5mfxt/nhFJ4bptc
         v/LJO2riG041V68hCCwRT/15kMP5h+ex1lmJrMQRMUmnfrqi5TWL2aYP56ynv2R4qmUm
         80RXuJd1u7AQExiumlw8SUzhcNksy0+/FYF/PYL2tQQZ2C7CvwN3MU9kt44IVMne8SkQ
         d07/vREGYuaiOVll+dAonMdaVgGCW6IrdMHZHdGCJZi0BYdKTM7BI7LgURCKgr5PvwvX
         2f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063359; x=1725668159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IoutToPYHP78p+giZTIYSlAIHUDU+a9Cu0+YJ5R9Xs=;
        b=fFiegfaDczmS0pRqZv3ZmMymF/JVH6nf1qGRUJJNFc2MpGt6ALL+Lat1RiBdozKA6w
         B5y5971CmQtsMDfAbQr8Kri4ACBG850ET3EwR8CUuzbCLP907HTvy1NpNYxVbxhWUl67
         w3Z5hDZnxL7ZdHZwyh0qCvulZ1/zDkVasWRpr5wgzHT5fmhV/TyP1ZiVZRSBP+I4Pu8Y
         e3du+eik19C6X5QAgesXMj/hMqybk58/YYnrdthbGtf7wK6zVZoiTh+EwAOSRnuSj5jY
         EebGP14MbaBs8g2Ic7Rxpvriao70Bt1VkiUHgckuTID/4OY+0qeojATmiXqZ034K8TKY
         bYEg==
X-Forwarded-Encrypted: i=1; AJvYcCXEAegD8z97+emtsTkTe35oEHiqQn6JawAjuxRZ1M/n60JlkR0ltP3fQEpsoaT/pG3GSek5rW7usNR3Xos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+yUpDdOOdNdspOBgbL2MqHH2dYXwKbiKNDGaLqpoC+Pdn4WD0
	VTg6+2hdzWIpPcZldj3y4LIXx/r5XZ5IcuhelfQwW1Jy00GBqnz10aOgN2SOsiSzqLU8O5zzgLL
	bxg==
X-Google-Smtp-Source: AGHT+IHuUMDVgauY7GuvKPVxwwQlBkVToxZb6WAcgBa0Ma8vA/kxkgf3DqQCO/+ZLc7AXyR0g3JjVsDh5oM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1367:b0:e0b:b36e:d73d with SMTP id
 3f1490d57ef6-e1a5c8765b0mr58850276.4.1725063358899; Fri, 30 Aug 2024 17:15:58
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:24 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-10-seanjc@google.com>
Subject: [PATCH v2 09/22] KVM: x86/mmu: Try "unprotect for retry" iff there
 are indirect SPs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Try to unprotect shadow pages if and only if indirect_shadow_pages is non-
zero, i.e. iff there is at least one protected such shadow page.  Pre-
checking indirect_shadow_pages avoids taking mmu_lock for write when the
gfn is write-protected by a third party, i.e. not for KVM shadow paging,
and in the *extremely* unlikely case that a different task has already
unprotected the last shadow page.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c34c8bbd61c8..dd62bd1e7657 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2718,6 +2718,17 @@ bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa)
 	gpa_t gpa = cr2_or_gpa;
 	bool r;
 
+	/*
+	 * Bail early if there aren't any write-protected shadow pages to avoid
+	 * unnecessarily taking mmu_lock lock, e.g. if the gfn is write-tracked
+	 * by a third party.  Reading indirect_shadow_pages without holding
+	 * mmu_lock is safe, as this is purely an optimization, i.e. a false
+	 * positive is benign, and a false negative will simply result in KVM
+	 * skipping the unprotect+retry path, which is also an optimization.
+	 */
+	if (!READ_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
+		return false;
+
 	if (!vcpu->arch.mmu->root_role.direct)
 		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, NULL);
 
-- 
2.46.0.469.g59c65b2a67-goog



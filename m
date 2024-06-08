Return-Path: <linux-kernel+bounces-206850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25991900EBD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371271C210BE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B37F;
	Sat,  8 Jun 2024 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqAqnYJG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A31FB2
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717805408; cv=none; b=eZ5kwGhDbh9ZNhZhXgAhprRGb0dEEuKp0cXX0z5v2eP9e4VQlwQMSgpXBwPL0u3Wds6qX7qqVzABje/G8Ah2Hcjf7tdoN+4PySkqwzK+o//bpdqCxvjz2v71YmUpdn8UyXBK3+4UOIjcGN1oiLLgJpQcqOqIyKSRhUCdzc8GhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717805408; c=relaxed/simple;
	bh=W4obiWieTwX8XIqKNFsDLPnp7HqRk5M9sGKeUadzy3I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JkQT9pv466aUkeXecuEhTQRc82AHqKot3XyruFJPzqOZasd1iKV+88gSEZu55iupmvyly9N3TMWdvaxqZxtjNGTHiBVbpK62ILsHTe6d+4XhpF9y7wzYt//NcKRw7HK6aUsDbC8I+1Pun6bJYaLJe0JSL3cqmM/RNYeOgsWNVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqAqnYJG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62c823393a4so35818047b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717805406; x=1718410206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovNDgtVbmisuBeW7HmpFAvacvLNy1ePjizPveBsLPr4=;
        b=vqAqnYJGqPaXj9EIsmydKzceL+K+u7rUTs4zdg14cTpkKUSSWaQv16yP2j0uodVzFE
         Qs6xy8kIDCwr03fHNojA5qMRpVYpxTWMEe7p3ce0s+S8o6ifA2PDqh2iaMcmcv7A03OM
         co5cykcGKH2M67d/ipzuu+5jZgHD/6E25749AuHNhfzSITGLYaL7imUkAf37rhZQ66ml
         biktGxOYDUXK16IdzBUoeJs/nJoZpqs+mwWMQG+6FpFtUt56yHM364OSwtiFTogjMck3
         qpUlZFlDP+BlIXSlLt+vJnJLUhpIV2oR4RfHfDxcoKUrpGR5/zMVxv63CHiuaywQmAjK
         gCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717805406; x=1718410206;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovNDgtVbmisuBeW7HmpFAvacvLNy1ePjizPveBsLPr4=;
        b=cgk80s8JdP6UjElWmj4SIX4WE2PBK2VileuZb1Bir+omdClqfSYkgljmbNK0OgBdqZ
         W7bgONOX53vdy9w5S2CC+D1w2SNHpbs7BG7CFjuRHFvKi/mvRdDq4ZTqrOd5WAo+cDVt
         vB7ZOL0Xxjqs/mEm6ztviE9wCYO7Q+S3cL5J8KGvVxjTuGp3Oq/L5h7IT/kCcFJu1bpN
         QU34LmzoDJ9kBPAua3q+X+wI36a606MhCT+3IKej+pclTBI1y++lCY9ewS4F9InrYUcL
         DbeymBDMS0FMAa3uP3D4Yu8e9l2h2aDK1Rh04gtD+SKufw6cGKzFvCo2DUOpk6ty2X3E
         NsUg==
X-Forwarded-Encrypted: i=1; AJvYcCUzviNuTnF25sKCtA6HzMWlWzSvs3KtsU9a6taWPktAXIHAprnw/1Dz/MZMeWasBL/WC4+FR+vayCVjsJ6sQKrsJgDee2EGl1u9zufU
X-Gm-Message-State: AOJu0Yzwq0OB4PvJZkRyAg32eqohC5C+8H3R7R/MDGs5WuHfeqeCczqj
	VD4hsolBZlj/V/zlSpVXH2hwrarv4sNOxIyVG+W/faZ/Bo0TmcQ1TANbExfvFhAMGWEkNL1v3q4
	wvA==
X-Google-Smtp-Source: AGHT+IGCFQlXppceAobvWJ0ws2hb75J4/DwIiNLGsm2o8FxFFflMMK+TT9IocPOq0aInmGSc//ZDlrCDb2o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:64c9:b0:627:a6f7:899e with SMTP id
 00721157ae682-62cd566d549mr8431987b3.9.1717805405666; Fri, 07 Jun 2024
 17:10:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 17:10:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240608001003.3296640-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Remove unnecessary INVEPT[GLOBAL] from hardware
 enable path
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove the completely pointess global INVEPT, i.e. EPT TLB flush, from
KVM's VMX enablement path.  KVM always does a targeted TLB flush when
using a "new" EPT root, in quotes because "new" simply means a root that
isn't currently being used by the vCPU.

KVM also _deliberately_ runs with stale TLB entries for defunct roots,
i.e. doesn't do a TLB flush when vCPUs stop using roots, precisely because
KVM does the flush on first use.  As called out by the comment in
kvm_mmu_load(), the reason KVM flushes on first use is because KVM can't
guarantee the correctness of past hypervisors.

Jumping back to the global INVEPT, when the painfully terse commit
1439442c7b25 ("KVM: VMX: Enable EPT feature for KVM") was added, the
effective TLB flush being performed was:

  static void vmx_flush_tlb(struct kvm_vcpu *vcpu)
  {
          vpid_sync_vcpu_all(to_vmx(vcpu));
  }

I.e. KVM was not flushing EPT TLB entries when allocating a "new" root,
which very strongly suggests that the global INVEPT during hardware
enabling was a misguided hack that addressed the most obvious symptom,
but failed to fix the underlying bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0e3aaf520db2..21dbe20f50ba 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2832,9 +2832,6 @@ int vmx_hardware_enable(void)
 		return r;
 	}
 
-	if (enable_ept)
-		ept_sync_global();
-
 	return 0;
 }
 

base-commit: af0903ab52ee6d6f0f63af67fa73d5eb00f79b9a
-- 
2.45.2.505.gda0bf45e8d-goog



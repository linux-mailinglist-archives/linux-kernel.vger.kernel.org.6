Return-Path: <linux-kernel+bounces-325599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D056B975BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C29283B28
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CB1B9B45;
	Wed, 11 Sep 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMziOChR"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DA14EC51
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087344; cv=none; b=DhkdFOWW6vAhL20nU1EuK3HKSu29g1TtcPN1RpQ4Vq2iFI5mg3K8Tu438UXmtixrSlpLYiWfPLB/tWynxexe8uTuvcYHnuuHKhquZgXbngJuhyohb1xe8Szxmdk2rq8QUdgvtdAQyEb/NzW7xeoqEs0khsTAttndpetL2saCrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087344; c=relaxed/simple;
	bh=+2F9I1POxGoi/9M/7fMvRXE2RmZfeCTY9lrmE922td0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CkQPL3ogsuZBYZpWGV+E/CD9dl2ucRPFnH9PSnoLb3F3362AoqYdt7sjt+dn9EdudhUYJB31tqJ+0B8lIVOPa28Fy8p/u8gM9kcy+B4PN9Ispu1q6KCD8aEybzBtLXovvOOhyp5HjwZIVJ6QakUsLtGX2d+DGmwqqyDdmUghSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMziOChR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2056364914eso4741595ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087342; x=1726692142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+KcQL/bdCq18fS3rSOcZm5DU7Hi8Axoom7HVevkC6r4=;
        b=PMziOChR0jNXXrfubU5QBNzC3Te52ZxgelzJTAeXvS6GNP8lDEhcMqsiamuaXw/t7w
         oEE4NhaVS0BxsGOdPIt+XOCEBIpYHmEb/TWGQUqNkBHwZc2+V6W+U4yegK+/3QyCyVI5
         chYjIpyJ6YuDI89+XrNhObJxJsFHMFV4cdZh8/Ub66/eUVcfeLXDUilUIdZ9+G+pSXeX
         2/X3f5hMiFf8FIebxINe9uh7GzeSOd/Sn6TcqcNp5aHPDKtVsIl9tdR1L+nM1gofblHi
         6BZgrWXxj1XeQSl767Q0HfbLL8sHBJMmQWxl0AyLIDrFK8m7TDJlbotro5wmb2q6iGA2
         1LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087342; x=1726692142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KcQL/bdCq18fS3rSOcZm5DU7Hi8Axoom7HVevkC6r4=;
        b=QSTzHf1n6G721eKwVmqjiyWo9ASI0uYrLolWvOXf3Fkd/4QjcKyAMPDXBReGpftGty
         myCS1dvHMOeiuWhVSt65l0pjHNIyBuBhVyQRzhfwtzQDteadDCTl/wsV+O4nMuZ7a0kI
         hUNC8Yx29BwFPacXB38rnYy/JusE1bUAB+j66Z2A6pwS4YKCCYr63uK5v+Xf7c3UxGIV
         bWdG+Md5v/064WeN61Spm0TTPYWYOyXOzyYT+zgl1Qb8YuU5ge8aOcdbhSI3GrQsrJXs
         B4hl3nHQ1sXVtKaabDx4EVm/BaQfwaLF4+NnBocwvvQ7TlPGY3bENKgoIt1x+tY9DxHw
         T0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9qtkBWuTxfyJLrn5Aa3kthNxxOXBzczB83baCtuDf+DST+3mxI51/DxSGqjlbOFQqGgBKar7/kBQ0FBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKuzQBZ0LmxbTd4pTRXt5w7DB9TbFI0Y/Wx64dC/IocQy9ZTWp
	IbQWQu/6KByDIfSqLyN5fiIKHfSfO+KvWbW4gi6XFda9sYqQtiiKQ2Eob8rbjYjfJ/hsXDROkj1
	YFQ==
X-Google-Smtp-Source: AGHT+IEO5NwWx0FrDp8QKSLHZru3Ive0KlYcZGHHsB7iPFbn3vSIzuOoVV6CHwgKSaGOFRDtrL7V2ub0u3g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f682:b0:202:4712:e84c with SMTP id
 d9443c01a7336-2076e3f784bmr227705ad.6.1726087342373; Wed, 11 Sep 2024
 13:42:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:46 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-2-seanjc@google.com>
Subject: [PATCH v2 01/13] KVM: Move KVM_REG_SIZE() definition to common uAPI header
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Define KVM_REG_SIZE() in the common kvm.h header, and delete the arm64 and
RISC-V versions.  As evidenced by the surrounding definitions, all aspects
of the register size encoding are generic, i.e. RISC-V should have moved
arm64's definition to common code instead of copy+pasting.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/uapi/asm/kvm.h | 3 ---
 arch/riscv/include/uapi/asm/kvm.h | 3 ---
 include/uapi/linux/kvm.h          | 4 ++++
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 964df31da975..80b26134e59e 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -43,9 +43,6 @@
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_DIRTY_LOG_PAGE_OFFSET 64
 
-#define KVM_REG_SIZE(id)						\
-	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
-
 struct kvm_regs {
 	struct user_pt_regs regs;	/* sp = sp_el0 */
 
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e97db3296456..4f8d0c04a47b 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -207,9 +207,6 @@ struct kvm_riscv_sbi_sta {
 #define KVM_RISCV_TIMER_STATE_OFF	0
 #define KVM_RISCV_TIMER_STATE_ON	1
 
-#define KVM_REG_SIZE(id)		\
-	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
-
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_RISCV_TYPE_MASK		0x00000000FF000000
 #define KVM_REG_RISCV_TYPE_SHIFT	24
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 637efc055145..9deeb13e3e01 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1070,6 +1070,10 @@ struct kvm_dirty_tlb {
 
 #define KVM_REG_SIZE_SHIFT	52
 #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL
+
+#define KVM_REG_SIZE(id)		\
+	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
+
 #define KVM_REG_SIZE_U8		0x0000000000000000ULL
 #define KVM_REG_SIZE_U16	0x0010000000000000ULL
 #define KVM_REG_SIZE_U32	0x0020000000000000ULL
-- 
2.46.0.598.g6f2099f65c-goog



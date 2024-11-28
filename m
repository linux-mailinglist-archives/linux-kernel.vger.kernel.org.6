Return-Path: <linux-kernel+bounces-424080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FF9DB06B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08B4281856
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487317557;
	Thu, 28 Nov 2024 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlDAc/c2"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC351E571
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755354; cv=none; b=i3/6IK/YdrXPy3pRjUC/4t8HqR9yHX3UHYehhyzoTAZ+2Esqwm0uRCXP7QcNVj3opBrJlflq6+dB2vU8Z0fXhbsozDStdJAbUAbOXMkWX0NwQtN7keRBk6ih1WB2tnbAlPeIMj9qaMdpSvl7QUJiCA3vcCuxamK/fpj3V7lmDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755354; c=relaxed/simple;
	bh=jpG2Z0wLkJo4m6LTchsXKdavjrJbj2n+h3dPpHrcu5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QnBMEEPvBU9QvHNNzAVv8bm/4bI2OUKPDD9DD0ow9WwEa59TSSwijsXYyEXm+o4dRNTGKaZCfNSIad4kkO4WB5PfEaG04R8bFD1LiC+h+DkdksGXRYeIJo7KA+cyQ/Nj+EqnYHGeBvgbdghPE9Wp3fAF+/mFJnCZnBUBQEWwgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlDAc/c2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724f7c09c58so354012b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755352; x=1733360152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ziTWoMDGGemt4FbzSlGzzl5MJ7+5E+c66t+aoBco/o8=;
        b=QlDAc/c2dz8Vac0PPavKSqLbiYEKn0APmRbTXNK9/OBPY5aypII6RaO02OENb50nUq
         UW60J3QHK/yI011mTxhIR2QxTcX19k3ccjzLcXJEn9WIaf5DUy1ytwUNofLTBDPLZuOf
         JydWLAKMSeIpPbhmRevuP3fTq5YZWtFhJ+Y2WRIuQySWF/jdHzhH7cJu+G3c47w4/lTN
         bt/1bbjJQSTxAm5oGzIqJkW+RYJwd6F/ybuDkwXFEg7EzbQZGtOKc4QjjD04P2bjHh1Z
         9PskMITtgZzuA25DxNAtcXiKjia9cAXSUJIouOYx4Uez7J+F9cw4c/Orna4/ix+VGDm0
         fw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755352; x=1733360152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziTWoMDGGemt4FbzSlGzzl5MJ7+5E+c66t+aoBco/o8=;
        b=HBVGrW0ioctDhfqRyyZbt6tHFBqGK4IO8yHrN9UNdf1L321A3mcJ+QgpbSmC7AxPA4
         yQwoF8rA3NnYOVl9P8tJW/JyX3JlxdlvMaYUBOJdeyhbU1q52+Wa7u+e5ZpEoM90aeHv
         Nfm0489pEKIsusXIjDJfv/2HR7PZyGY3aB5PNPFBRhoUjEvaF1yVqgt4Bb3szp3zs65W
         D7BFkb+T+tGu8gDTy2thTcdlFgDLT2t/Nar9hhzI4g7xzXpLd3O1ed5yf/M4Bt/yT8Qp
         9uFD5bGRkPKtjk3fKQfIFD6VQG59o8cRvB1r5ztzieWpCN0DxWsrY6YP2a5HR0lolh+V
         7UbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBVYWZQm60CPNBGyIYQMwncfbcFlTI1WmJp6ac5ap2bBPtyv0440vAiewk4b3ybHmTsgtQfaQIE3ULi/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKzjH1b7N+CbqHAJ4/miCgEpUd8s5SroNA/Rs5/M863oyuM+yY
	bigGqzarQAOqhl/5hYt5jkakpPxMWK0crD0fnj/qGXOuKt8oGuLpHpgdvtKuUHYPCVI1mf5PiQU
	UQA==
X-Google-Smtp-Source: AGHT+IGFU4JhoxY8Wl9h7ACp8Vt7EFu0qd1J8Nu7Xlwl+xjZW64YiOpSApDQOPp2K//2LZM+CyuzFG/tlB0=
X-Received: from pjbnc6.prod.google.com ([2002:a17:90b:37c6:b0:2e2:93e2:fe46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2252:b0:2ea:8b06:ffcb
 with SMTP id 98e67ed59e1d1-2ee08eb2b91mr6443403a91.14.1732755351961; Wed, 27
 Nov 2024 16:55:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:32 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-2-seanjc@google.com>
Subject: [PATCH v4 01/16] KVM: Move KVM_REG_SIZE() definition to common uAPI header
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Jones <ajones@ventanamicro.com>, James Houghton <jthoughton@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Define KVM_REG_SIZE() in the common kvm.h header, and delete the arm64 and
RISC-V versions.  As evidenced by the surrounding definitions, all aspects
of the register size encoding are generic, i.e. RISC-V should have moved
arm64's definition to common code instead of copy+pasting.

Acked-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/uapi/asm/kvm.h | 3 ---
 arch/riscv/include/uapi/asm/kvm.h | 3 ---
 include/uapi/linux/kvm.h          | 4 ++++
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 66736ff04011..568bf858f319 100644
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
index 3482c9a73d1b..9f60d6185077 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -211,9 +211,6 @@ struct kvm_riscv_sbi_sta {
 #define KVM_RISCV_TIMER_STATE_OFF	0
 #define KVM_RISCV_TIMER_STATE_ON	1
 
-#define KVM_REG_SIZE(id)		\
-	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
-
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_RISCV_TYPE_MASK		0x00000000FF000000
 #define KVM_REG_RISCV_TYPE_SHIFT	24
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 502ea63b5d2e..343de0a51797 100644
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
2.47.0.338.g60cca15819-goog



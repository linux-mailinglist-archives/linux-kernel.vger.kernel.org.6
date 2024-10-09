Return-Path: <linux-kernel+bounces-357384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3CF9970B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161901C224DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74F20013E;
	Wed,  9 Oct 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDEVa4PD"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21701FF7C5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489001; cv=none; b=orGl48WtRwcQFymzyBYW4WstsDu3AtcF2rh7ek46VerXXyNgY9QhzvcIEgZaoBwSN6qRYV+Q6lOhYgZYIUwSEA3FIyibKhbVAK3QShV6W7g9kfpvwsT29hhnkPY6imsMyA4mFou6ht2xg7SWqufCvI5yMP6q++Xh/222pzjoBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489001; c=relaxed/simple;
	bh=LPFOToixC43DMJpxxdLhELluVDI5pW/ki1X7rgFZYA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SgENtU2wwfnEULYZiRN/pI75vxm1lQQBnzAzmsB08WmYrpQddITtU4oeq1HWctbRTL4Doac9wBHCPgiCWpDnsF6rd8JysKqmKn/S0hnsYUKoH7bkQO3t1yApdc0wxpQ1pFqchpnf2yGqx9yZ89CuIEX/D2PwHfvLMI/Dowk0Umk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDEVa4PD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e26ba37314so376207b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728488998; x=1729093798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+3zZkwU+2EpnRGguJhn2Ww+Ghmvy6uOMqwsBdHy8Row=;
        b=ZDEVa4PDOhQ1q/Q0LSGFJku8Btp1er6OCVG6vGwD+/yDBR6aZA8GPUOV3Vb10jIHvM
         7ok0cW2YCsnop9udUND3nhQjNn2vFzZfinkObODIfkztzLYczolMRha4Vw7+444EyiiC
         rOdmLaGO3uabbVEg98u9vyRSumhJ+YgscW6mfRG3l5Bh0NSQipcyDps4PAv9IaEX6B0L
         Jn5n5MdDIfIkEjsyirpaA2oGAF78rdWuvvIrG4qCAGVm8bcsuLXxDo16cWsMy+9JNie1
         JK73gvZOikKA5YsCekCCRo9SKVlEBEGju00xWZjS9QcDr6C0cmIT3wII/Y7AsKFpT/Zj
         fRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488998; x=1729093798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3zZkwU+2EpnRGguJhn2Ww+Ghmvy6uOMqwsBdHy8Row=;
        b=MsDNHUdmOR43bJQ6iZaaMZ+d/otrOBi5f+XuFMcsZJtQYe5F9DParIch8ZgOa9fUyR
         lwYsr/Q5rCPFPRHGD3xw+7Wur08c6X8mL/qYBY+8HcNIBuJF9REp1xr6wo/sj3pxT9Rf
         /rPkYr4HKW3MFoNyn3kjQC3fuZPntqPoOwmWaiViB2y5NqGly1I/zH6PKJNYefobFoYr
         ktNpu1pz0d2fjX8/GRmsBRKamnSi1jLnc/Oyvz4vYdkELSHqNpBe2sbpS4QwB31zEH3Z
         oam/NtkO2BfQ3j3Dwv8aWuO/EZHhSA71ybvCQ4UUAV/E7MlJEQr2TKGCutqmAs84wqXG
         1TSw==
X-Forwarded-Encrypted: i=1; AJvYcCXAjFwL9oI1JJRMmKMtIY2zk171jdJurlz/I7C6MSFiIy4CW8bvQmVfvI3RCDFBCbxdFmBVu03kty/T2xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBqU0qIUP/6EUGlymScdW9Ofs5M6cX+58sZC6qw9nS42X47wc
	phGSciFqcsRMNnsZ1Du/lXKUMfl7Pd71F/ObhaPoXeSM2WJkKMJWQRQ+S2CE8cp5rPwm7J8HEly
	vfw==
X-Google-Smtp-Source: AGHT+IGq8S+cJ3hbYyw4prFkdU6bbiVB3Ddo6czJU4p6VUDHrgM9P6PS5yQttOYl+xpjVaNBwpEpnchtMNk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:460d:b0:6db:89f0:b897 with SMTP id
 00721157ae682-6e3221683d8mr69407b3.4.1728488997664; Wed, 09 Oct 2024 08:49:57
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:40 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-2-seanjc@google.com>
Subject: [PATCH v3 01/14] KVM: Move KVM_REG_SIZE() definition to common uAPI header
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	James Houghton <jthoughton@google.com>
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
2.47.0.rc0.187.ge670bccf7e-goog



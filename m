Return-Path: <linux-kernel+bounces-359770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6887999083
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5901F223A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0CC1F9438;
	Thu, 10 Oct 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9hLcB8T"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A871D042A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584746; cv=none; b=K35eaoU/TYoy8Nrp3ddiaexUP6TGWVSnEHKN7HTlsNUbJtnj6SnyQF+piJ4w71R5RFtf4txNJvyMmfiyYmS1rXRVKcFGuXIYYSDgFwJpFZg72Eyeaqoh8hFKkFfPySI+bwDLJ5KJoVYC4mPMGhyccua1aBL1gXf6Oab4EvhR+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584746; c=relaxed/simple;
	bh=QVyL+E+J2Fu+8nHNQtozyIIO+ywn/WvnTCVSYx092RU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+q9rPL5zP7jUAnuid+Zi8nj6N+GtDF1y2mRtGVs7M2wPMk2CzU5GBtej4s8WiqXRE2p1ZGiEEZkCggqxaB2gtoCoDqWnC5HraWRhwKiqmhwneAWbcWj17SSSCCYAt+DMp3/g1W61L46T5hD9zlsiMmWcwKyiJbyACZr9Z9d948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9hLcB8T; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290a9a294fso1853539276.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584743; x=1729189543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHAZpPaCzYnE+TRrbh6ni4wh+Yys2pChavpSnHk2YEU=;
        b=o9hLcB8TcgrAYeRwjVSZvm39dElO8cyvKzpeBbUmWSYLS3W2vdIeqdtka+VJm68gJL
         Mt1xP26lna3GmuKsA5M6XaLxLrcnmZpwiPqK97xslR+y8/OD8joZ6hTsWJkepTSytJ4/
         5qQ/cvFl9Lhgl/9BAV4EsrHv5625y4MIqZDYmniqgzndR8v9BPPB25oMftqfGBWKejna
         3Sh6VKQ7Q19iuz1MdTuXO7tL450UYOL13DDXwlw+nZBSCcl5e+WElcxqudAEceZSwbPv
         HeAmyiYjnu6f8gH9Kx4SOq0jxKrIFi4JcIiq3wGhRqCUNlPtIfkJbZnXdKTR6rDaWD7o
         bGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584743; x=1729189543;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eHAZpPaCzYnE+TRrbh6ni4wh+Yys2pChavpSnHk2YEU=;
        b=R/facJxMTEnvGYGlg5ynLHADcLkBn/5CIjy8n7C9PPqjGjkfpX9LocQlOSR0TIl2NR
         6R1OF0O2Insa7NPQxdSitK6S6h01UKJTHk1FuC8NF9lsPR26yqvaf8MXGQaA5Mao75X9
         4s92jrjZVy2RJUtsEfgdyRb0j2xkdpl0syIPi+7sfhPR3Honwu2tVSP3A8ji2buXzlS8
         m6kf8lyRWcb7CTe7MxZzD/VxjgzXrJB7ORaqCogGLD05BCLMdB4/sdVz8JbXaGVZ0wCQ
         7FaxoXBoPhigEmCRJhaYlXpfH3HxWOohyiPpK0cD9Ho37R9EJXoEjEy3/fE5oflWqP//
         gQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2FRf6OcEeVBfWyyK2qm3+Bj4meNJXKBV1jyBeuoiOLn9tWohA95XyYRl3FyuhFWufaqaJ5Ds08lm6gyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcXfrCIL0zT+x9oEsvwt5qePnuclnphggAYSOp5O9LNFQjNyQ
	cukZyWpTw0qtSVeaHP5AF+Cn60d9Du5bNH0MuJPxaDuxVAe0HZnOrkDcpMst3VgQS6heXDS+2gz
	NIg==
X-Google-Smtp-Source: AGHT+IGUAGxjHNELfO1gnQBoxyShlnhLiinRslmifWPsD1igdN7s2BU3B9tdatRPL4jwPkA1Z0qI9X+JjYQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:9346:0:b0:e28:fc1b:66bb with SMTP id
 3f1490d57ef6-e28fe4f0fddmr4836276.6.1728584742775; Thu, 10 Oct 2024 11:25:42
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:26 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-25-seanjc@google.com>
Subject: [PATCH v13 24/85] KVM: nVMX: Drop pointless msr_bitmap_map field from
 struct nested_vmx
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Remove vcpu_vmx.msr_bitmap_map and instead use an on-stack structure in
the one function that uses the map, nested_vmx_prepare_msr_bitmap().

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 8 ++++----
 arch/x86/kvm/vmx/vmx.h    | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e94a25373a59..fb37658b62c9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -621,7 +621,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct=
 kvm_vcpu *vcpu,
 	int msr;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 =3D vmx->nested.vmcs02.msr_bitmap;
-	struct kvm_host_map *map =3D &vmx->nested.msr_bitmap_map;
+	struct kvm_host_map msr_bitmap_map;
=20
 	/* Nothing to do if the MSR bitmap is not in use.  */
 	if (!cpu_has_vmx_msr_bitmap() ||
@@ -644,10 +644,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(stru=
ct kvm_vcpu *vcpu,
 			return true;
 	}
=20
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), map))
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), &msr_bitmap_map))
 		return false;
=20
-	msr_bitmap_l1 =3D (unsigned long *)map->hva;
+	msr_bitmap_l1 =3D (unsigned long *)msr_bitmap_map.hva;
=20
 	/*
 	 * To keep the control flow simple, pay eight 8-byte writes (sixteen
@@ -711,7 +711,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct=
 kvm_vcpu *vcpu,
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
=20
-	kvm_vcpu_unmap(vcpu, &vmx->nested.msr_bitmap_map, false);
+	kvm_vcpu_unmap(vcpu, &msr_bitmap_map, false);
=20
 	vmx->nested.force_msr_bitmap_recalc =3D false;
=20
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 2325f773a20b..40303b43da6c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -200,8 +200,6 @@ struct nested_vmx {
 	struct kvm_host_map virtual_apic_map;
 	struct kvm_host_map pi_desc_map;
=20
-	struct kvm_host_map msr_bitmap_map;
-
 	struct pi_desc *pi_desc;
 	bool pi_pending;
 	u16 posted_intr_nv;
--=20
2.47.0.rc1.288.g06298d1525-goog



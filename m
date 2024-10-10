Return-Path: <linux-kernel+bounces-359826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9E99913C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9144B2810A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E42194A9;
	Thu, 10 Oct 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yE9BBZab"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2A218D91
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584858; cv=none; b=PbfVTLs+YEqkNtTt2xIrsXhQtSUAmYQBfr8s/hGKXQXyRrMdFKX1AmrYANk9FyER3Dls8DA2Xg0bHmPvBjLkIx4uweKwnWtGFZPCFFFCnGGkF1IW0YKzVhPji52OVbW7xN0T615fOToaoiXXTmpKWhfm4ftmqxUf05zaI0j4RYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584858; c=relaxed/simple;
	bh=FErwCaq8NdcoMJPhpWM/50ZCDjLg7qNPTjMbO8/YuvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ar/O6jh/n94QUQ8i/aDniA3vka/mMRStZiyzPcaxcDcssRNiyjoRerlxgS+zMqqL3kkfRN0jT9BUzOh7emfnwwOiaKO41/H1ZQrJTwD/YSqAPr6GjOduEVZMypcKkKx1LN1w3e3eGbIGM5snTTIl1pNc/R1xI2r16npd9q63YeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yE9BBZab; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7db9418552fso1114277a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584856; x=1729189656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04eHUk6AClz9cRMQcjlWjE46ZR1uXceY2ogFB00LGDM=;
        b=yE9BBZabvoeIqzV8CVJHKuzxLfL2NYkYVtIdFaPw/BUSfPofvy1yEt9sV7egKYCr6h
         ECdzuEmt/3ij7vj98XqRqiNePbTZy3r1+KnoPq0Y9I3SWy9nfiSrfM3+HN5Tt1cuMsMe
         P5BqP8mEprGZtOyicY4QMcSjOoZuBJSucYO3xKIILjywU8h/g9JRWiGzdULPCY/h7RrW
         gs/lx0IgmUkEs0f46fCv0eA4nTg5+x1s07DF9AqCC/d91Tc45agqIYRUIW48yJgViOz+
         6RSp5Afamp+TyeZzsa3QwnWcskOkhHtKwtjtk2jBDyPhGpbSYoTMcCOFE9DIiSVIltMb
         h9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584856; x=1729189656;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04eHUk6AClz9cRMQcjlWjE46ZR1uXceY2ogFB00LGDM=;
        b=FYF3wgFookw2rD4+CR7Z8p3YOy8ruPkT4TlUeG5zyEmJ1YyJDITGhFuWSeYp7oJnyr
         7neTF/aNDl1S7mU+Zx3QKEjWt/SVZvq6LZER/OjCygGG4vqcSSmzO2nsDFcrU893foOa
         v6aLbsIqFIZsENyxmWEPbTkzKzeX/+sS4AL5I8WDK8Sr1adGdlrqKTwdprGbTV2JVnlc
         ZSOK49lONEbqePiKLn2o63+0RDpFJs3CXmtdT5gortG1Kg1r7SUcz04E2zbBymrcYE9X
         qiljXaQefsXjq6F2Z4PMFcZSb2C3X9yA7vb8Cxwh85bzKUdvLpbvyE101TiPjnVMZ9WX
         VYQg==
X-Forwarded-Encrypted: i=1; AJvYcCVChv5SptX+rXkjWu/HcZgzhM9MYOmjfldg7MU+hhmbiHl7mnLetEw1PNW0XAY+zQ8j8mJHoWRwL1/MTbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRv8PW5pzS6+eskpIEhYoBwAdG6pvZdTY1HF676di6D6SVPMdv
	zvqSzv038Mxcb9G5H/XTNZnc32VrYz/0DV4j7taj7oe1JwlOY53wtun2GcpQf3fO/Oi3Nu/xXPl
	hzg==
X-Google-Smtp-Source: AGHT+IHGiwNd3UbnZUzPre1tk98dNYoM10q7gFGG4lq0PldsJuDm1rxMHI+g8Yc3UsVnmkzWnOurUMFmqIQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:41c4:b0:20c:8f78:67c9 with SMTP id
 d9443c01a7336-20c8f786946mr26385ad.5.1728584855618; Thu, 10 Oct 2024 11:27:35
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:24:19 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-78-seanjc@google.com>
Subject: [PATCH v13 77/85] KVM: arm64: Use __gfn_to_page() when copying MTE
 tags to/from userspace
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

Use __gfn_to_page() instead when copying MTE tags between guest and
userspace.  This will eventually allow removing gfn_to_pfn_prot(),
gfn_to_pfn(), kvm_pfn_to_refcounted_page(), and related APIs.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/guest.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 962f985977c2..4cd7ffa76794 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1051,20 +1051,18 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 	}
=20
 	while (length > 0) {
-		kvm_pfn_t pfn =3D gfn_to_pfn_prot(kvm, gfn, write, NULL);
+		struct page *page =3D __gfn_to_page(kvm, gfn, write);
 		void *maddr;
 		unsigned long num_tags;
-		struct page *page;
=20
-		if (is_error_noslot_pfn(pfn)) {
-			ret =3D -EFAULT;
-			goto out;
-		}
-
-		page =3D pfn_to_online_page(pfn);
 		if (!page) {
+			ret =3D -EFAULT;
+			goto out;
+		}
+
+		if (!pfn_to_online_page(page_to_pfn(page))) {
 			/* Reject ZONE_DEVICE memory */
-			kvm_release_pfn_clean(pfn);
+			kvm_release_page_unused(page);
 			ret =3D -EFAULT;
 			goto out;
 		}
@@ -1078,7 +1076,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 				/* No tags in memory, so write zeros */
 				num_tags =3D MTE_GRANULES_PER_PAGE -
 					clear_user(tags, MTE_GRANULES_PER_PAGE);
-			kvm_release_pfn_clean(pfn);
+			kvm_release_page_clean(page);
 		} else {
 			/*
 			 * Only locking to serialise with a concurrent
@@ -1093,8 +1091,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			if (num_tags !=3D MTE_GRANULES_PER_PAGE)
 				mte_clear_page_tags(maddr);
 			set_page_mte_tagged(page);
-
-			kvm_release_pfn_dirty(pfn);
+			kvm_release_page_dirty(page);
 		}
=20
 		if (num_tags !=3D MTE_GRANULES_PER_PAGE) {
--=20
2.47.0.rc1.288.g06298d1525-goog



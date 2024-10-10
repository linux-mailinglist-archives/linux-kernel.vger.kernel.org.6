Return-Path: <linux-kernel+bounces-359777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FFA99909F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FA3B281D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F641D31B2;
	Thu, 10 Oct 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+lh0lZQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEC1FB3D8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584758; cv=none; b=lS3sxYMt4BQvHN79hCWWg6+deAiXHP38JzLLbtfypd2XfDgCxuhAgvmBbJqJpYJITK+msj2UFBbe7HoCpagsF1q63Uyx/idVMGvcbMID7aWoqzbE/ftw2zXmPQcfPPtJXWO1tk6YmpF7q3pazN6Wc5nbKW2AbMqV+CO6YrfGOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584758; c=relaxed/simple;
	bh=bnwD3uEfCD/YcddkLJu8d23/zYqKX46jf2vKJvYQlNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fLpnJViU0yQced6zi03jcSDOCSwRPQ6DrjiSycslmYVVCVIEullpV//mlddLfcNGgJgbYzYBYu1Jr6kUAL3htxUJComNVdqEKHR9jcWGbmKyimm0xgm4ih/EFIJc2fdNMJBUzhtkWxPcBmPMVt7ooLHwe/tsHihY3gformHU0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+lh0lZQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2d287f944so24078867b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584755; x=1729189555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/prKt8Bu+DRISNBcov5NrkfgoAIYHMahITKzCWpSrCI=;
        b=u+lh0lZQ0iXDXtDscH8PiFZR0maNS7DQsBMYikW3/rmnfcBXpI7TGMudK3dfPgUTEB
         P0isjFKFnrvh+aV0DTRRLJCNrk0qEXoNyKTpSlURgiPJyby8IfIe3wTsXycMslYF84Uu
         LxbGHqs7w+ucwTevI1iLIdHaxVjE7F3ssW3jQgSMXBln1jgkY2wR5qIbf7ZdkBZ9CO4J
         LKRV/cxsUGAhvttyWa4tlVFNCym+L/JIU+85sWhn7wEMpOen81nC7NpKHxGCzaFpRxd6
         w/zKDX4OeUl0XtF7v4HJT2epxE2xdrp+lv8Fag4R953vA0Hy5rN8/x7w1xKjZA+XIYl8
         Vqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584755; x=1729189555;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/prKt8Bu+DRISNBcov5NrkfgoAIYHMahITKzCWpSrCI=;
        b=g0Dv7eL8VxCIhAxqlX78UVFkupkFPP9IIQ08/j6EUtcEyksgARBJYYZyvgZidTUkck
         vrE1Tug6UDVFTCPfTukCyDvTlBQbsG6kc54NZL8B2HhRuGZsRbc2Zi1Tbt5h/MzSaBFr
         JZPxwAhYxZPTJTIkx/7kWrnTQUY/U05WAbtVsSq/oHHMkKr80GbMAXfGA+EHA6QHrc4o
         IZDjlSfcHIFv2qHZ9m9MuLOF/1c8020MtAKDkopsKzC/YwdA1nD06lI8rVyuFtGnmva4
         e3K+gOt1oZEp41vwzdZeeHJBQaCPoOFpyRu3SKc5FHRvb0bpheOdmISUviFS2fWmEXVp
         BgAg==
X-Forwarded-Encrypted: i=1; AJvYcCVHbKD/lvo1LF8oVEVUuPqNg5m6puoPZoDSQhmklTcXlyoLgWpLKRbB3LmY5J2bFU/BJ2IY6wobUY2Yxrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynupGHWb9t5nB2VR9OhbjsOuTY7V4Rny9sdwVtpVOhoqmG7rth
	WS3zxAH1DeyNx1uizClrIFuCEmXZwJg5/+utfoggfzB4A1clMGQZpLL2hRpq6yKnWWB6q2TAXcX
	j9w==
X-Google-Smtp-Source: AGHT+IHNZW39HKgOpo4XLx10sqcp5MldEDD35H2r/7z7SkgDatDPvbEuIFyvlgb9BtXWEl9gaR4EDWCFxGs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2093:b0:6d4:30f0:3a74 with SMTP id
 00721157ae682-6e322171640mr1011347b3.6.1728584755409; Thu, 10 Oct 2024
 11:25:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:32 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-31-seanjc@google.com>
Subject: [PATCH v13 30/85] KVM: Migrate kvm_vcpu_map() to kvm_follow_pfn()
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

From: David Stevens <stevensd@chromium.org>

Migrate kvm_vcpu_map() to kvm_follow_pfn(), and have it track whether or
not the map holds a refcounted struct page.  Precisely tracking struct
page references will eventually allow removing kvm_pfn_to_refcounted_page()
and its various wrappers.

Signed-off-by: David Stevens <stevensd@chromium.org>
[sean: use a pointer instead of a boolean]
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e3c01cbbc41a..02ab3a657aa6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -280,6 +280,7 @@ struct kvm_host_map {
 	 * can be used as guest memory but they are not managed by host
 	 * kernel).
 	 */
+	struct page *refcounted_page;
 	struct page *page;
 	void *hva;
 	kvm_pfn_t pfn;
@@ -1238,7 +1239,6 @@ void kvm_release_pfn_dirty(kvm_pfn_t pfn);
 void kvm_set_pfn_dirty(kvm_pfn_t pfn);
 void kvm_set_pfn_accessed(kvm_pfn_t pfn);
=20
-void kvm_release_pfn(kvm_pfn_t pfn, bool dirty);
 int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset=
,
 			int len);
 int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long l=
en);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6cdbd0516d58..b1c1b7e4f33a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3093,21 +3093,21 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn=
)
 }
 EXPORT_SYMBOL_GPL(gfn_to_page);
=20
-void kvm_release_pfn(kvm_pfn_t pfn, bool dirty)
-{
-	if (dirty)
-		kvm_release_pfn_dirty(pfn);
-	else
-		kvm_release_pfn_clean(pfn);
-}
-
 int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *ma=
p)
 {
+	struct kvm_follow_pfn kfp =3D {
+		.slot =3D gfn_to_memslot(vcpu->kvm, gfn),
+		.gfn =3D gfn,
+		.flags =3D FOLL_WRITE,
+		.refcounted_page =3D &map->refcounted_page,
+	};
+
+	map->refcounted_page =3D NULL;
 	map->page =3D NULL;
 	map->hva =3D NULL;
 	map->gfn =3D gfn;
=20
-	map->pfn =3D gfn_to_pfn(vcpu->kvm, gfn);
+	map->pfn =3D kvm_follow_pfn(&kfp);
 	if (is_error_noslot_pfn(map->pfn))
 		return -EINVAL;
=20
@@ -3139,10 +3139,16 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct k=
vm_host_map *map, bool dirty)
 	if (dirty)
 		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
=20
-	kvm_release_pfn(map->pfn, dirty);
+	if (map->refcounted_page) {
+		if (dirty)
+			kvm_release_page_dirty(map->refcounted_page);
+		else
+			kvm_release_page_clean(map->refcounted_page);
+	}
=20
 	map->hva =3D NULL;
 	map->page =3D NULL;
+	map->refcounted_page =3D NULL;
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_unmap);
=20
--=20
2.47.0.rc1.288.g06298d1525-goog



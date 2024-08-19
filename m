Return-Path: <linux-kernel+bounces-292320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0B956DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705541F2361B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A1175D4B;
	Mon, 19 Aug 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vuv7LmrY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931D175D2C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079359; cv=none; b=DlzJrr4ZklSZyDoKtyHy+uJ7mX6/iVh4L5YLNN29wXq2qXoYxM1/zgucKsHQ8i287BoHyG0TBNBcO1CmwMu/zjSMYtSMoMdZofnrdMvjw85Zi0dAWnO2wOpmBXyDhu6Ltgsjb4YwKyHjkLIsSnVrY5hlQ/9BGFyJkH5DwNu/9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079359; c=relaxed/simple;
	bh=gvXUPSVXR+TJbArq4gRza0CovZloy+FUB0ztPEaCf80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlHBgnJXq3XTZbP78jsi5nYlRn6js8AyPLh5DByzBbdiqkAz53qNNaxm3U4wt88WQJq+Td9nxs6bZWtOdg+DQtQ3thzLflUKRQI5+RKsoBkwx8iLcZIfr07jW394sAIdpAyLAR/Tk45CGGRWkmdJLYM786b+QVMDv3vg42pFbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vuv7LmrY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nORFBheCnmBdqnoFe9uPUvA5oaRV47y8v5ImE/FbbjU=;
	b=Vuv7LmrYfCJc1etmcGrguXXG9+85FFGhKUnGYLUv29Vb87B4ieVJ9x6KBni/4WBKTnzoGt
	AgOj6FOh6B3B6kme5m3BPO1sIG+UpVe27UKYGCfPJCvjqEQhJsMhH/iJijMlt/dquiEJ8h
	ijKue8I3w2UcKG8+fx3TnubIGRgc+/E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-KAsVic3cOMOfMu4DfSmE5w-1; Mon,
 19 Aug 2024 10:55:51 -0400
X-MC-Unique: KAsVic3cOMOfMu4DfSmE5w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D79A1955D52;
	Mon, 19 Aug 2024 14:55:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6199619560A3;
	Mon, 19 Aug 2024 14:55:38 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 6/9] arm64: kexec: Introduce a new member param_mem to kimage_arch
Date: Mon, 19 Aug 2024 22:53:39 +0800
Message-ID: <20240819145417.23367-7-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

relocate_kernel will be used either to boot vmlinux directly or PE
image. In the latter case, the efi emulator needs efi_emulator_param
instead of dtb as input parameter.  On the other hand, dtb is still
required to pass down through efi_emulator_param to the second kernel,
so keep kimage_arch->dtb_mem as scratch and introduce another member
'param_mem'

When booting vmlinux, param_mem equals dtb_mem.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/kexec.h         | 1 +
 arch/arm64/kernel/asm-offsets.c        | 2 +-
 arch/arm64/kernel/machine_kexec.c      | 2 +-
 arch/arm64/kernel/machine_kexec_file.c | 1 +
 arch/arm64/kernel/relocate_kernel.S    | 2 +-
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 4d9cc7a76d9ca..f4c63a1a9531f 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -109,6 +109,7 @@ int machine_kexec_post_load(struct kimage *image);
 struct kimage_arch {
 	void *dtb;
 	phys_addr_t dtb_mem;
+	phys_addr_t param_mem;
 	phys_addr_t kern_reloc;
 	phys_addr_t el2_vectors;
 	phys_addr_t ttbr0;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 81496083c0413..8633a94fcb9f1 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -187,7 +187,7 @@ int main(void)
   BLANK();
 #endif
 #ifdef CONFIG_KEXEC_CORE
-  DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
+  DEFINE(KIMAGE_ARCH_PARAM_MEM,		offsetof(struct kimage, arch.param_mem));
   DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
   DEFINE(KIMAGE_ARCH_ZERO_PAGE,		offsetof(struct kimage, arch.zero_page));
   DEFINE(KIMAGE_ARCH_PHYS_OFFSET,	offsetof(struct kimage, arch.phys_offset));
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 82e2203d86a31..6958c1fc84a5a 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -192,7 +192,7 @@ void machine_kexec(struct kimage *kimage)
 
 		cpu_install_idmap();
 		restart = (void *)__pa_symbol(cpu_soft_restart);
-		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
+		restart(is_hyp_nvhe(), kimage->start, kimage->arch.param_mem,
 			0, 0);
 	} else {
 		void (*kernel_reloc)(struct kimage *kimage);
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index af1ca875c52ce..9fca3a35f04d5 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -184,6 +184,7 @@ int load_other_segments(struct kimage *image,
 		goto out_err;
 	image->arch.dtb = dtb;
 	image->arch.dtb_mem = kbuf.mem;
+	image->arch.param_mem = image->arch.dtb_mem;
 
 	kexec_dprintk("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 		      kbuf.mem, kbuf.bufsz, kbuf.memsz);
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 413f899e4ac63..84e1bbb7def21 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -44,7 +44,7 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	 */
 	ldr	x28, [x0, #KIMAGE_START]
 	ldr	x27, [x0, #KIMAGE_ARCH_EL2_VECTORS]
-	ldr	x26, [x0, #KIMAGE_ARCH_DTB_MEM]
+	ldr	x26, [x0, #KIMAGE_ARCH_PARAM_MEM]
 
 	/* Setup the list loop variables. */
 	ldr	x18, [x0, #KIMAGE_ARCH_ZERO_PAGE] /* x18 = zero page for BBM */
-- 
2.41.0



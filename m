Return-Path: <linux-kernel+bounces-562363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FFA624AC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7025A4215C5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452733981;
	Sat, 15 Mar 2025 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjvPYez7"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F1195
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006103; cv=none; b=rdTyt5WmM4MIf7WoJDKvO2Omrg0lqiYuoZtWhjLiAHeSPmAB0FSMNdjdRtWYl0FW0f4JeOckP1xEGODoyWYHvE7SecJ9WBBsRJue9a8CIR+/C/nxe1FvikkeLd4wUSSs8PYZ9t1xw8f6SO7zh495Mf372TtzyDU7Q3aUn7gBH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006103; c=relaxed/simple;
	bh=bt6b+H0+Tq29i30rceRXL9x4MJus4+Bpjrr9EgkPhpM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bpaCQk66RuKZywKODB0CTD3J37Hwgl4NiTDbmbziD2X+5eMUTzLofuLYXf4mPGB5kimMuCRG7U9XzvSIqfjjd642PZT3b3kzUPuszW71W3c20TnOlftOouKrqviNw3Gkti47l6/IbRNMQb4hfb93OYY34NhA9zuRQzqLXRKbsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjvPYez7; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4768f9fea35so67931941cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742006101; x=1742610901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUw+0S4IAaDwD3W5stow5kvzTojbmPGuc8IbGH7DBLM=;
        b=vjvPYez7ioSweuaiPSQTx0y4jWU4atN6Oh6Tbx6erD4VXit0yHWJNeU7Vp3jrPZZgQ
         KH13OcC4vfyb0HfvnPI3xEyRIfChkDsiBiRyGXs10ANtSIHhXohWw20OILwRZpoSAmWB
         3LZuRNKli/wMwoD76UYqD8kIFWuPqLC/CLEk/IOjK8YvlA03C2jpDAEPIvIgXy7cv7MH
         OaYYR4Eo3eWWHZojX4x4M8IwGIrZTxV+NejhAc1jIyCw/w7yJStztdnm38Yp3sEaPZC+
         u0SF6QYE1uBCO90SkFA46jO4AzjljP9woqxmjW8FyV24I1zu4mD8vweF06iOFIKEQAiV
         vxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006101; x=1742610901;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUw+0S4IAaDwD3W5stow5kvzTojbmPGuc8IbGH7DBLM=;
        b=v5nZvEIrnqAZtqyVOcl6DLIGxO+YTpCFMJD3rQh4DZHhzgfS2+tVXR3afKqrR7z1//
         OUNGx59KOqYops6Xu2WAPfxp+INaoJH+MI3Al4jm0VT5ZuAvdPpdbfpaquqrtmBOIbWt
         4ksZ5P9bMIU4GZfQQHRMAXsvFT7ciFBPXlDsYXr0dyVFW/1IsFxDjhBw4mw2jE2XOim6
         NUx8I86+zZfBmanzGz28ojdLBK4+k2uFrGyEkajbvhD5kvu/4LYAIEDaFsUG57AxfgCE
         KfIp6Rq0ng+uxwqnISRjDLVQwaTzqqGSsLXlmr7h1+NDqV58CsLG0q8NDBhVjrCqPQrD
         WMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmuLbacdPkvYlkaXGPiLEmxfkNlXlNihC91hEUC5Tk6g6CXBmDXE+gdrD/PSlLY/+kA4lCqc6LllS3ucE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAXFMHxbcrsEp4/6XG7ON//H/cVCs/1RaUa+kb3MRJXDVcM42
	ipJif5XViiQ46dYCuTX95RwJ9FGEfa9HgEPOfz30z5SPfggjp/Bpy+v3LXIxSi0Y0pCPcL5Rt1r
	1GA==
X-Google-Smtp-Source: AGHT+IF020CXLzNRsrx3v6dX0rbzclkdn2qtBV7z55bEEyPLl1wfqcSdtChwztGq7Tqi5jOTVvEIHKoL1lo=
X-Received: from pgbbw33.prod.google.com ([2002:a05:6a02:4a1:b0:af2:357f:4269])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9005:b0:1f5:8678:183d
 with SMTP id adf61e73a8af0-1f5c1178019mr6816987637.14.1742006090522; Fri, 14
 Mar 2025 19:34:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:34:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315023448.2358456-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: Wrap sanity check on number of TDP MMU pages
 with KVM_PROVE_MMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Wrap the TDP MMU page counter in CONFIG_KVM_PROVE_MMU so that the sanity
check is omitted from production builds, and more importantly to remove
the atomic accesses to account pages.  A one-off memory leak in production
is relatively uninteresting, and a WARN_ON won't help mitigate a systemic
issue; it's as much about helping triage memory leaks as it is about
detecting them in the first place, and doesn't magically stop the leaks.
I.e. production environments will be quite sad if a severe KVM bug escapes,
regardless of whether or not KVM WARNs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 7 ++++++-
 arch/x86/kvm/mmu/tdp_mmu.c      | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d881e7d276b1..30b81a81a1c7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1471,8 +1471,13 @@ struct kvm_arch {
 	struct once nx_once;
 
 #ifdef CONFIG_X86_64
-	/* The number of TDP MMU pages across all roots. */
+#ifdef CONFIG_KVM_PROVE_MMU
+	/*
+	 * The number of TDP MMU pages across all roots.  Used only to sanity
+	 * check that KVM isn't leaking TDP MMU pages.
+	 */
 	atomic64_t tdp_mmu_pages;
+#endif
 
 	/*
 	 * List of struct kvm_mmu_pages being used as roots.
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7cc0564f5f97..21a3b8166242 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -40,7 +40,9 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 	kvm_tdp_mmu_invalidate_roots(kvm, KVM_VALID_ROOTS);
 	kvm_tdp_mmu_zap_invalidated_roots(kvm, false);
 
-	WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
+#ifdef CONFIG_KVM_PROVE_MMU
+	KVM_MMU_WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
+#endif
 	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
 
 	/*
@@ -325,13 +327,17 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	kvm_account_pgtable_pages((void *)sp->spt, +1);
+#ifdef CONFIG_KVM_PROVE_MMU
 	atomic64_inc(&kvm->arch.tdp_mmu_pages);
+#endif
 }
 
 static void tdp_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	kvm_account_pgtable_pages((void *)sp->spt, -1);
+#ifdef CONFIG_KVM_PROVE_MMU
 	atomic64_dec(&kvm->arch.tdp_mmu_pages);
+#endif
 }
 
 /**

base-commit: 7d2154117a02832ab3643fe2da4cdc9d2090dcb2
-- 
2.49.0.rc1.451.g8f38331e32-goog



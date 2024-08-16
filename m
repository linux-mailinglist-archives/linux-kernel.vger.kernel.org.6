Return-Path: <linux-kernel+bounces-289667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A19548E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DE228734F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F21BBBD6;
	Fri, 16 Aug 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v41VPMJY"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855191BBBC4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811972; cv=none; b=p48buAFMjg1U28itNb1uJjNBeQg797c6nGijtEoBtwPcCBQzj52frkNYJz8J0BDmBwIbce+n8CyPjtxkh6hXJChkNu+XcWjlUCi9C36GlEQsZgwVC4mXviNQWECNiXusCnvIlB3hqgb/5UmhUwVP2AEILVirWP4nSn6vMMESkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811972; c=relaxed/simple;
	bh=mY6xy3N+Ro6xX5leeMZAa8gpa+1gdMNp/aUTBfJ3SK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rkLNtFiYm9gGAjaX8KJi5CZ65c5C9V7nOUCJGgTBB3xg7+Ogf+YCJVFlAMEXkIueF5FjyD0uX2mp9+RmSZMwcTPUlRpRoS3d1jSWhQCeNDSU6fShi268/5Ww1afjp2ohU4m5TBYHLC+y3ebzOYe+IsLz/d7q1hC0ItPtTJluFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v41VPMJY; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-36848f30d39so1062143f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723811969; x=1724416769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVLGFavEAQJdYF6sohZy6GLteiKbgm4SNZHa6M3Hrik=;
        b=v41VPMJYC6FYdkj+ltH/baTPMUoGuQBzxWrwfrBRjf3c7nmmiO+05/h42B6+ceWqT7
         DqfYzLqzs1fFImfQf7UQwh+TZvhtSWDppwxGgFz7tTz4fF/k1rUf/pOUymZiqCpjR58n
         mdMXGUkodton7U139AalbDzmDDsyPhKbo9aQKwGQSs7PLUSyJGGJCsvSf76WQxPEJwXq
         lyAv6RBSsiapSFPnmTQwap9qBra8L5Hj2z8zNsJjxym4OhRvW90AfZMRW66g0aKWQ4wY
         Gye1E6b8O53WN+ocwLqcpnW7OzX8piP/FJfv4MOjYHNr55ad8xqhGg96QeHk2Flcs95d
         S4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811969; x=1724416769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVLGFavEAQJdYF6sohZy6GLteiKbgm4SNZHa6M3Hrik=;
        b=slt3h/vL/OFdyXMyLMk3Y8C24v2JCbUXER95fgRp0CDxSQ/T/VCThACmPyRig2l/5A
         YtXoKzKm8S/Ugnxm1wN8CDKEtu5tblU4fE4AZ7qMvTpL3P6OhyVfC/MGTZOL6Xp4/QK5
         gU5NeWmaIr5DzF6wRxiMXG6tvvcMy4+8zb78E8kBnetpVAfBn7p/jicJGIxJeHdv0M2S
         cLhNFvvklUHgRhBrIyRbEBfRc4a9nVng42dilVIxlXo71ypZrRV/ksKmqfXn6Mh2mAr9
         lfpBJzlDBzJ4+z+xMOzK/diCC77C+/SgIt8oPs1WCZCA/bFtn7gkA3Drv3cVpsDyHaI2
         pVEg==
X-Forwarded-Encrypted: i=1; AJvYcCVuEa8gJrTeUaflB7ZhkOhnqcIELa22953BWGrbD+52FP2OBolB2s2L1BMBDoGrZ+MKPUizycvTvBJoeSzPhuekC+c/LjdrfrbAOjos
X-Gm-Message-State: AOJu0YxEAzLpFZt4it/vjFEGVuq1aOjHM7rU2g0rfuQrMDVCfsWLd4lj
	t+FZvkjtR9i3d2sjA6YHFgqpBIMN4Zt0EHO5uAjUdoXeIA9XsHme+eHlElVjOEDjE6Q1Pz6x7R7
	rtCRElsXka7Gbo9lLQDQAo9IsVg==
X-Google-Smtp-Source: AGHT+IFGgP1UpKc1nFsMN2cnAW/WNRr3YojR2uI15QJjFmnongfC+MYnDiKQo3s4RWZo8/KjRQyeYn/x04TBgYlZR34=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6000:1e81:b0:366:ea7c:bed1 with
 SMTP id ffacd0b85a97d-371943164fbmr3636f8f.1.1723811968492; Fri, 16 Aug 2024
 05:39:28 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:39:06 +0000
In-Reply-To: <20240816123906.3683425-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816123906.3683425-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816123906.3683425-7-sebastianene@google.com>
Subject: [PATCH v8 6/6] KVM: arm64: Expose guest stage-2 pagetable config to debugfs
From: Sebastian Ene <sebastianene@google.com>
To: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com, 
	ardb@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	james.morse@arm.com, vdonnefort@google.com, mark.rutland@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, rananta@google.com, 
	ryan.roberts@arm.com, sebastianene@google.com, shahuang@redhat.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Make the start level and the IPA bits properties available in the
virtual machine debugfs directory. Make sure that the KVM structure
doesn't disappear behind our back and keep a reference to the KVM struct
while these files are opened.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/ptdump.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 79be07ec3c3c..b0d55ea3fb2a 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -207,8 +207,56 @@ static const struct file_operations kvm_ptdump_guest_fops = {
 	.release	= kvm_ptdump_guest_close,
 };
 
+static int kvm_pgtable_debugfs_show(struct seq_file *m, void *unused)
+{
+	const struct file *file = m->file;
+	struct kvm_pgtable *pgtable = m->private;
+
+	if (!strcmp(file_dentry(file)->d_iname, "ipa_range"))
+		seq_printf(m, "%2u\n", pgtable->ia_bits);
+	else if (!strcmp(file_dentry(file)->d_iname, "stage2_levels"))
+		seq_printf(m, "%1d\n", KVM_PGTABLE_LAST_LEVEL - pgtable->start_level + 1);
+	return 0;
+}
+
+static int kvm_pgtable_debugfs_open(struct inode *m, struct file *file)
+{
+	struct kvm *kvm = m->i_private;
+	struct kvm_pgtable *pgtable;
+	int ret;
+
+	if (!kvm_get_kvm_safe(kvm))
+		return -ENOENT;
+
+	pgtable = kvm->arch.mmu.pgt;
+
+	ret = single_open(file, kvm_pgtable_debugfs_show, pgtable);
+	if (ret < 0)
+		kvm_put_kvm(kvm);
+	return ret;
+}
+
+static int kvm_pgtable_debugfs_close(struct inode *m, struct file *file)
+{
+	struct kvm *kvm = m->i_private;
+
+	kvm_put_kvm(kvm);
+	return single_release(m, file);
+}
+
+static const struct file_operations kvm_pgtable_debugfs_fops = {
+	.open		= kvm_pgtable_debugfs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= kvm_pgtable_debugfs_close,
+};
+
 void kvm_ptdump_guest_register(struct kvm *kvm)
 {
 	debugfs_create_file("stage2_page_tables", 0400, kvm->debugfs_dentry,
 			    kvm, &kvm_ptdump_guest_fops);
+	debugfs_create_file("ipa_range", 0400, kvm->debugfs_dentry, kvm,
+			    &kvm_pgtable_debugfs_fops);
+	debugfs_create_file("stage2_levels", 0400, kvm->debugfs_dentry,
+			    kvm, &kvm_pgtable_debugfs_fops);
 }
-- 
2.46.0.184.g6999bdac58-goog



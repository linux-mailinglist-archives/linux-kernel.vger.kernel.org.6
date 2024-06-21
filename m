Return-Path: <linux-kernel+bounces-224659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063391256B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10431C23A91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41DC15748C;
	Fri, 21 Jun 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvNZB+KW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCA153BDB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973174; cv=none; b=FmYt0Pok/P/tlsl5X2ervdp3pU1jBefC9CunCdEN3mm5bYRIlWjsOA6WHUXtrP38JxBzpdCwcQ9N1yOo9FMmgN2MjZbKwCEvuAHAykTkWV/NwDLyot7/UMtjFnALbB1EKl+i9BnxUP1CBU3MiqnaoAxiXeyCvdxQ6sL9UmH7Lww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973174; c=relaxed/simple;
	bh=VKEiAQ5rnCpzkwoGU9Kf5JbSpYjqjdSM0fujBxiasBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=isyMV7LdiwePaImRstNKy+Yaot/T8SV+dyCRV4IYF3+gjIvcb2vs3JhJi8FHUhTvVhxmALHfKoCQoAoqcA3slFMjGqXh6hgLeqLd9YuXI7ju126fsvRQIjoh5fA+VGWFYHLq5ZuAdPjQyenMFAWjwW3kqlO2C0s9MVwsp7G8shw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvNZB+KW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6344d164c35so37049557b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718973171; x=1719577971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaoTyRJP5MVoQ4Wx1amDUxzz/OCpulWviUJ5XDAG08I=;
        b=bvNZB+KW73KMmH6h1kj+OE2phQv4hP/7MXLjqRbASZSPYqr+OJTkXPtHUY1ZWIlxRb
         yaP6B1vSTafRNqhBByk7MlhL4+2k4+Lmce9WkK+JE5FnSylsgzJvcTbzR0XkPOp5yMim
         XxNHPrUbPDuqiuYOSMduAd6wXtpQG2xLpsf6rMDAywkjC2JtG+KlUThiT5Haav1kz2t3
         rftV8vrfFcdtPXP/9VYzy+tI7pyxDjTCAwCtR8fZvO9VCfXV6WKwq601erxtQsrGGmQE
         uuiyK3IKDbMrSlaGAacxGQwKKFb3KzytwrWY0tUxDk+PxrUj8XH7ApFj+MeIK0SJL79N
         uwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973171; x=1719577971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaoTyRJP5MVoQ4Wx1amDUxzz/OCpulWviUJ5XDAG08I=;
        b=qvGpZWjHrCODouZMimzYiv0OfH1ohUXseGx2eMgfO+GULh84mr4CNvpg+z2X14whBA
         m5kfMTx07OTkgjIQ5JiyCw06rmZ31IBV7lzF7n3f/gE/07WMrrj2SHnhbcF+3oghDC/5
         YY4i9/RkIpaaZ1DN5lDrZi5jyv7uA4AwaS7Sdm17OSZEqGuQW2AwkgzhTfkla8CDnPIq
         z33qu40tUtjDA4Yz7WRNhLTkbXIW3urojFM8LlfX9NBJJTryPE5FN1E8F4T9hkR+MqU+
         mO2LthAe0P5IG4RdW0KC/PkTDnn7EB8qcluDvc+nCBFLsW2d8kqhPCNHNMqZJZO8vkBg
         x+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSGdmc4CdR3R60NwaQQvTjO32+705ptCOQPgrWHDNwfyvao+1JxBBtz/O1Wo0WiiekwS5s0HDEtYYkCrbhCXEapARr5XFB+MdSJMmz
X-Gm-Message-State: AOJu0Ywmt7s8NjSMqULkZW+c2qIfk7kVld2q+6NURpERn1hXEgfYeW5k
	2zLwuSgwL5i6yTdvteVLSbL7y9nwSPTXyWxI/HuWBtNesagKpMPKY+4Il35u73IVsoxJ2kfZ0eZ
	YV5zULiLMJDUSZ8TcWQlHbPf5Sw==
X-Google-Smtp-Source: AGHT+IGj7AHqrKDUhBWO+SmknG8+pCJKbMlt4EBG61XGF63G72cpdFy+hwEXTIOexf21bNWp4h0sUsTwv0bTgFiHF64=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:2b12:b0:dfa:7278:b4c4 with
 SMTP id 3f1490d57ef6-e02be18dd87mr1713995276.4.1718973171319; Fri, 21 Jun
 2024 05:32:51 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:32:30 +0000
In-Reply-To: <20240621123230.1085265-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621123230.1085265-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621123230.1085265-7-sebastianene@google.com>
Subject: [PATCH v7 6/6] KVM: arm64: Expose guest stage-2 pagetable config to debugfs
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
 arch/arm64/kvm/ptdump.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index cc1d4fdddc6e..17649e3cbc8f 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -215,8 +215,58 @@ static const struct file_operations kvm_ptdump_guest_fops = {
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
+		seq_printf(m, "%1d\n", pgtable->start_level);
+	return 0;
+}
+
+static int kvm_pgtable_debugfs_open(struct inode *m, struct file *file)
+{
+	struct kvm *kvm = m->i_private;
+	struct kvm_s2_mmu *mmu;
+	struct kvm_pgtable *pgtable;
+	int ret;
+
+	if (!kvm_get_kvm_safe(kvm))
+		return -ENOENT;
+
+	mmu = &kvm->arch.mmu;
+	pgtable = mmu->pgt;
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
2.45.2.741.gdbec12cfda-goog



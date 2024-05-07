Return-Path: <linux-kernel+bounces-171575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5078BE5E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC51B29ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC3515FA74;
	Tue,  7 May 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DAXrv5pR"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6AD1607B7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091983; cv=none; b=GhahlMWvzkDakP4RYDkhWOXsVOSI4peRVoMEA4Xx8NKfah/Qa7biJU85yHCF0VYn3vFMxfmAQnTJfLvZRZIUcyuBZPFCJVDN2HWJaBVk6VA/wzvsYxEbXSKMGZDcVaAKpCLtGMgE6zUT7DWg9/mhIERcj0dyVKsdFMeIwpYCLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091983; c=relaxed/simple;
	bh=bqlipkF/qwmaFsPGQ6jvLZEhD8A7hXZuMOw8nPGleSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z9OWWC0w6K1iKRMLEdFrYWc+mO8clgmTvcxavioA13U5H0aQ0GgC/W9lWwsWuDcXyuXWQSzT+qfdHIsjf1qSqxoOQfOw/3s22b5OMBTT4Gq9EllPuPXpeAOwxb0GcubIITisf4E1ikuHYx13Z56YH4iKZYaoGFLOjgcKhyDrhIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DAXrv5pR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f44dc475f4so2077152b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091981; x=1715696781; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MTOLBzQvBvlY+EmrQy97Trzu0yuGzLHkqXUAWYArG80=;
        b=DAXrv5pRcA2b+bXiFHrSmBUNtmMHuUnQFaLj/g+4Cl0ajiLQXqfkRXzVsxvVY63MTW
         PhlJSttl74G4eQhX8PjtXG+oHQMpi1PEmBrgk5ORnK6xWfDYGnb+amWgjTFoncmD9kIa
         v3AcL7S0mPkG5tYyOwembQGqUICYU1h5Dn/dUVXxrKBwPW7XNoQg02vuXQy/nG86WQq1
         D/u4QkWhz7NpW4TiT8628CeKc8C24R3X4ZX56B5716D8Emj0/sshN8yHopUvBeBCVSjB
         2R/r5WpjAPnOlu8IB4yC22uPjChDdI6iVy2D0jUDSppdz+FtjnICS2VKRUoMuf8/8iio
         dneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091981; x=1715696781;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTOLBzQvBvlY+EmrQy97Trzu0yuGzLHkqXUAWYArG80=;
        b=QGXhV975osaYrOKkI24y/R8PpDoFdPFK14Ss53cZ3E13mioNvQdmBw9J6e4yHTGm36
         IZ6PrMtBA/NA23ac0Q7BaODSQiorAlU0vBpUD8WPhPxSCdesWxktWJeesUBAFs2g9+yt
         C37E8UGwWgngIh70zCy4SyL+TtdR5RxfRC5/DRQazLPaGdFpYMl1WEm2qfOOHO39QAyz
         961YT/YkZe1fFQ2kolzr1j7JyaBL7W0jlKCuSBggRtaWzqlz98vaCefuuCCCHDiMu/DZ
         9jrm8pe1kO3bHqSMzQV3Y1yC83UkPCQGJ30DcNEU7IT9u4VimcNiZVrdBZAqXzDl/cJU
         lWWA==
X-Forwarded-Encrypted: i=1; AJvYcCXg7SNhr5yb7nHl7W0ymDCkqqijVnWP5JfljLPuICO9EZWHHvP9fkcPXOaxzq/adEBp9o91BZQC2hAO011C0XIVEF3h79oZQc6JvgxQ
X-Gm-Message-State: AOJu0Yx5rdp5sjVo1Hi7e9gmvSf7O5wF2qi+rch7yigx7em5Q1Uoh1wY
	5EsT81wCO/LWf4ycNXW8m0tnxmcOiMAtU4HolJpnExpR4xSPfb4C6EtNL2iavGI=
X-Google-Smtp-Source: AGHT+IFrRpCDjD/4eOupdDn8MUYNlbPGsiI9chLNqLmFjLhbFaZkNfyNZ758Eh2Q2HfbLwdvKcrXqw==
X-Received: by 2002:a05:6a00:1305:b0:6ed:88e5:53d4 with SMTP id j5-20020a056a00130500b006ed88e553d4mr14682261pfu.8.1715091979690;
        Tue, 07 May 2024 07:26:19 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:19 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC RESEND 5/6] iommu/riscv: support nested iommu for creating domains owned by userspace
Date: Tue,  7 May 2024 22:25:59 +0800
Message-Id: <20240507142600.23844-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch implements .domain_alloc_user operation for creating domains
owend by userspace, e.g. through IOMMUFD. Add s2 domain for parent
domain for second stage, s1 domain will be the first stage.

Don't remove IOMMU private data of dev in blocked domain, because it
holds the user data of device, which is used when attaching device into
s1 domain.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 227 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/iommufd.h |  17 +++
 2 files changed, 243 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 072251f6ad85..7eda850df475 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -827,6 +827,7 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 
 /* This struct contains protection domain specific IOMMU driver data. */
 struct riscv_iommu_domain {
+	struct riscv_iommu_domain *s2;
 	struct iommu_domain domain;
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
@@ -844,6 +845,7 @@ struct riscv_iommu_domain {
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_dc dc_user;
 };
 
 /* Linkage between an iommu_domain and attached devices. */
@@ -1454,7 +1456,6 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0, 0);
 	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
 
 	return 0;
 }
@@ -1486,6 +1487,229 @@ static struct iommu_domain riscv_iommu_identity_domain = {
 	}
 };
 
+/**
+ * Nested IOMMU operations
+ */
+
+static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain, struct device *dev)
+{
+	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+
+	if (riscv_domain->numa_node == NUMA_NO_NODE)
+		riscv_domain->numa_node = dev_to_node(iommu->dev);
+
+	riscv_iommu_bond_unlink(info->domain, dev);
+
+	if (riscv_iommu_bond_link(riscv_domain, dev))
+		return -ENOMEM;
+
+	riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
+
+	riscv_iommu_iodir_update(iommu, dev, info->dc_user.fsc, info->dc_user.ta,
+				 info->dc_user.iohgatp);
+
+	info->domain = riscv_domain;
+
+	return 0;
+}
+
+static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
+{
+	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
+
+	kfree(riscv_domain);
+}
+
+static const struct iommu_domain_ops riscv_iommu_nested_domain_ops = {
+	.attach_dev	= riscv_iommu_attach_dev_nested,
+	.free		= riscv_iommu_domain_free_nested,
+};
+
+static int
+riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc dc;
+	struct riscv_iommu_fq_record event;
+	u64 dc_len = sizeof(struct riscv_iommu_dc) >> (!(iommu->caps & RISCV_IOMMU_CAP_MSI_FLAT));
+	u64 event_len = sizeof(struct riscv_iommu_fq_record);
+	void __user *event_user = NULL;
+
+	for (int i = 0; i < fwspec->num_ids; i++) {
+		event.hdr =
+			FIELD_PREP(RISCV_IOMMU_FQ_HDR_CAUSE, RISCV_IOMMU_FQ_CAUSE_DDT_INVALID) |
+			FIELD_PREP(RISCV_IOMMU_FQ_HDR_DID, fwspec->ids[i]);
+
+		/* Sanity check DC of stage-1 from user data */
+		if (!user_arg->out_event_uptr || user_arg->event_len != event_len)
+			return -EINVAL;
+
+		event_user = u64_to_user_ptr(user_arg->out_event_uptr);
+
+		if (!user_arg->dc_uptr || user_arg->dc_len != dc_len)
+			return -EINVAL;
+
+		if (copy_from_user(&dc, u64_to_user_ptr(user_arg->dc_uptr), dc_len))
+			return -EFAULT;
+
+		if (!(dc.tc & RISCV_IOMMU_DDTE_VALID)) {
+			dev_dbg(dev, "Invalid DDT from user data\n");
+			if (copy_to_user(event_user, &event, event_len))
+				return -EFAULT;
+		}
+
+		if (!dc.fsc || dc.iohgatp) {
+			dev_dbg(dev, "Wrong page table from user data\n");
+			if (copy_to_user(event_user, &event, event_len))
+				return -EFAULT;
+		}
+
+		/* Save DC of stage-1 from user data */
+		memcpy(&info->dc_user,
+		       riscv_iommu_get_dc(iommu, fwspec->ids[i]),
+		       sizeof(struct riscv_iommu_dc));
+		info->dc_user.fsc = dc.fsc;
+	}
+
+	return 0;
+}
+
+static struct iommu_domain *
+riscv_iommu_domain_alloc_nested(struct device *dev,
+				struct iommu_domain *parent,
+				const struct iommu_user_data *user_data)
+{
+	struct riscv_iommu_domain *s2_domain = iommu_domain_to_riscv(parent);
+	struct riscv_iommu_domain *s1_domain;
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct iommu_hwpt_riscv_iommu arg;
+	int ret, va_bits;
+
+	if (user_data->type != IOMMU_HWPT_DATA_RISCV_IOMMU)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (parent->type != IOMMU_DOMAIN_UNMANAGED)
+		return ERR_PTR(-EINVAL);
+
+	ret = iommu_copy_struct_from_user(&arg,
+					  user_data,
+					  IOMMU_HWPT_DATA_RISCV_IOMMU,
+					  out_event_uptr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	s1_domain = kzalloc(sizeof(*s1_domain), GFP_KERNEL);
+	if (!s1_domain)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&s1_domain->lock);
+	INIT_LIST_HEAD_RCU(&s1_domain->bonds);
+
+	s1_domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
+					   RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
+	if (s1_domain->pscid < 0) {
+		iommu_free_page(s1_domain->pgd_root);
+		kfree(s1_domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Get device context of stage-1 from user*/
+	ret = riscv_iommu_get_dc_user(dev, &arg);
+	if (ret) {
+		kfree(s1_domain);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!iommu) {
+		va_bits = VA_BITS;
+	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV57) {
+		va_bits = 57;
+	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV48) {
+		va_bits = 48;
+	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV39) {
+		va_bits = 39;
+	} else {
+		dev_err(dev, "cannot find supported page table mode\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	/*
+	 * The ops->domain_alloc_user could be directly called by the iommufd core,
+	 * instead of iommu core. So, this function need to set the default value of
+	 * following data member:
+	 *  - domain->pgsize_bitmap
+	 *  - domain->geometry
+	 *  - domain->type
+	 *  - domain->ops
+	 */
+	s1_domain->s2 = s2_domain;
+	s1_domain->domain.type = IOMMU_DOMAIN_NESTED;
+	s1_domain->domain.ops = &riscv_iommu_nested_domain_ops;
+	s1_domain->domain.pgsize_bitmap = SZ_4K;
+	s1_domain->domain.geometry.aperture_start = 0;
+	s1_domain->domain.geometry.aperture_end = DMA_BIT_MASK(va_bits - 1);
+	s1_domain->domain.geometry.force_aperture = true;
+
+	return &s1_domain->domain;
+}
+
+static struct iommu_domain *
+riscv_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			      struct iommu_domain *parent,
+			      const struct iommu_user_data *user_data)
+{
+	struct iommu_domain *domain;
+	struct riscv_iommu_domain *riscv_domain;
+
+	/* Allocate stage-1 domain if it has stage-2 parent domain */
+	if (parent)
+		return riscv_iommu_domain_alloc_nested(dev, parent, user_data);
+
+	if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (user_data)
+		return ERR_PTR(-EINVAL);
+
+	/* domain_alloc_user op needs to be fully initialized */
+	domain = iommu_domain_alloc(dev->bus);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * We assume that nest-parent or g-stage only will come here
+	 * TODO: Shadow page table doesn't be supported now.
+	 *       We currently can't distinguish g-stage and shadow
+	 *       page table here. Shadow page table shouldn't be
+	 *       put at stage-2.
+	 */
+	riscv_domain = iommu_domain_to_riscv(domain);
+
+	/* pgd_root may be allocated in .domain_alloc_paging */
+	if (riscv_domain->pgd_root)
+		iommu_free_page(riscv_domain->pgd_root);
+
+	riscv_domain->pgd_root = iommu_alloc_pages_node(riscv_domain->numa_node,
+							GFP_KERNEL_ACCOUNT,
+							2);
+	if (!riscv_domain->pgd_root)
+		return ERR_PTR(-ENOMEM);
+
+	riscv_domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
+					      RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
+	if (riscv_domain->gscid < 0) {
+		iommu_free_pages(riscv_domain->pgd_root, 2);
+		kfree(riscv_domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return domain;
+}
+
 static void *riscv_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
@@ -1587,6 +1811,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
 	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
+	.domain_alloc_user = riscv_iommu_domain_alloc_user,
 	.def_domain_type = riscv_iommu_device_domain_type,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ec9aafd7d373..e10b6e236647 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -390,14 +390,31 @@ struct iommu_hwpt_vtd_s1 {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_riscv_iommu - RISCV IOMMU stage-1 device context table
+ *                                 info (IOMMU_HWPT_TYPE_RISCV_IOMMU)
+ * @dc_len: Length of device context
+ * @dc_uptr: User pointer to the address of device context
+ * @event_len: Length of an event record
+ * @out_event_uptr: User pointer to the address of event record
+ */
+struct iommu_hwpt_riscv_iommu {
+	__aligned_u64 dc_len;
+	__aligned_u64 dc_uptr;
+	__aligned_u64 event_len;
+	__aligned_u64 out_event_uptr;
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
+ * @IOMMU_HWPT_DATA_RISCV_IOMMU: RISC-V IOMMU device context table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE,
 	IOMMU_HWPT_DATA_VTD_S1,
+	IOMMU_HWPT_DATA_RISCV_IOMMU,
 };
 
 /**
-- 
2.17.1



Return-Path: <linux-kernel+bounces-215017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B55908D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C33F28C4AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F48DF55;
	Fri, 14 Jun 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DdioKCi6"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8683A260
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374952; cv=none; b=UmlGcmxmtsp5d5ss8xfCUXztXukE/HYmZLayUg2hRb84xPsxJEHmmieUHQmMPM83HTo8ZK9S+v6IqfvNVDW2rNOJUxCQU/8jqT9SMeJeLksPUO24OlzBzq4YET8iqCA/d+M26R3Y6lUDPKxrwqR4HDvELI4sgARjjSHknkVYBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374952; c=relaxed/simple;
	bh=AMjRqApdC6JhSqc5cTc8FRbsioFIOI+eQK8ee2g7rO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=opH2hIFE00gAKegeWLLvsnG6MFOGH2R78zudpJNpLDv2TDyRdg8mZn4zA4zdlNAXgrnse6/MlPLnB5CFVVbTuypsaYeMneRY7U5lx/T/ny1yZmqVV+JjaUmyyn5c/gH5wNDF3PCxlX27cgAXmaLOmEPThzDmZSb0vm9C3PjeR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DdioKCi6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f480624d0fso17252235ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374950; x=1718979750; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqErywjP/CjLC2eaDMmEQxFN9AljnO4yCx1Hy/yfHnA=;
        b=DdioKCi63zUMgI2p3dSNdP/2KIdGsVvIWVw98IziwRv2rcw1W0AdfYQOunweqGGZil
         H4XJOHq866sdJnbtnYhj95PRHxzRnd4LRDaDP7TTNQeDh+KqpDOVZHEu8HL/62uaijGk
         2XnEaeuHEb9ZbS7kvpLlZPqfZ5TTd9jYZMiZ3yzSa9AapMlTscOcTQFFwkaxP+btYGZv
         AVu47BEMdeF377bSEZCyCaMOoISQGfxv8UCGsjShP5O/F0QGqxtB8ipSYC1+n616xOmS
         8fJCX2Vga3EvuIYN21V/muMFyYgtx/Wqw9xXe4xp2wFpphBd0Cj538RFusv/BEPL/2Rb
         vtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374950; x=1718979750;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqErywjP/CjLC2eaDMmEQxFN9AljnO4yCx1Hy/yfHnA=;
        b=srtZZ3bP3Is1xHEJtibrhiDqzuo4zWqqn2NmnyVzB8xZZZIIK36Up62nlJFEOZtkrE
         4mjDpwY8EGY0Mify445R+iHeaNDBWlqZWP6XVtHnZlPb+xX6EuhL5YUQRZSuUcavuv6W
         pxCOlZhO4tr7YLOMqraBJ2mL+qgzmZp76rZPy/vrcPEuCC83qD0dtg4szBapwg0I8nqB
         ci/XzA+tUSa2Iw0XVlEVjHqFVcjIf8xBANavBuxaleGuHsfZFHlet+EluT9k3pVESLAC
         9Uco2pqXT79AOaDR6k5A5dObVR9+fS8YJby93reqXdj2Jjag6ZSYXoy5Zf2EHOXaAk9N
         mxLA==
X-Forwarded-Encrypted: i=1; AJvYcCU62hZmdCiT+en5fvTo+JfvvgsW2bAav4MiAXTb215VJXDNcfWg2a4QMQahVN5y3bBcQd/GjnDBPZyyKMtnt2m2NaYLEsqG070h82kA
X-Gm-Message-State: AOJu0YwS5OGdIQuBwlcrQcNpX67iikxx14/nBAWSvHuA4MLS82OUSyP5
	+5IZ5nTmP8yV/gNyC03ZHFf314bqW8wnRjwT4QXv6b3x4HcF+ctYY3atnF6OhUk=
X-Google-Smtp-Source: AGHT+IHSez2BcKKbBZwd377qNguyZGbzCpuJqffZQYRK1qpXa16+hD0f3KlRelSKzLQGJUtI0sNeSg==
X-Received: by 2002:a17:903:1c4:b0:1f7:1525:ddfc with SMTP id d9443c01a7336-1f8625d9e30mr34295185ad.20.1718374950324;
        Fri, 14 Jun 2024 07:22:30 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for flushing cache
Date: Fri, 14 Jun 2024 22:21:54 +0800
Message-Id: <20240614142156.29420-9-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch implements cache_invalidate_user operation for the userspace
to flush the hardware caches for a nested domain through iommufd.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 90 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/iommufd.h | 11 +++++
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 410b236e9b24..d08eb0a2939e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1587,8 +1587,9 @@ static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain, struct dev
 	if (riscv_iommu_bond_link(riscv_domain, dev))
 		return -ENOMEM;
 
-	riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
-	info->dc_user.ta |= RISCV_IOMMU_PC_TA_V;
+	if (riscv_iommu_bond_link(info->domain, dev))
+		return -ENOMEM;
+
 	riscv_iommu_iodir_update(iommu, dev, &info->dc_user);
 
 	info->domain = riscv_domain;
@@ -1611,13 +1612,92 @@ static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
 	kfree(riscv_domain);
 }
 
+static int riscv_iommu_fix_user_cmd(struct riscv_iommu_command *cmd,
+				    unsigned int pscid, unsigned int gscid)
+{
+	u32 opcode = FIELD_GET(RISCV_IOMMU_CMD_OPCODE, cmd->dword0);
+
+	switch (opcode) {
+	case RISCV_IOMMU_CMD_IOTINVAL_OPCODE:
+		u32 func = FIELD_GET(RISCV_IOMMU_CMD_FUNC, cmd->dword0);
+
+		if (func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA &&
+		    func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA) {
+			pr_warn("The IOTINVAL function: 0x%x is not supported\n",
+				func);
+			return -EOPNOTSUPP;
+		}
+
+		if (func == RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA) {
+			cmd->dword0 &= ~RISCV_IOMMU_CMD_FUNC;
+			cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_FUNC,
+						  RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA);
+		}
+
+		cmd->dword0 &= ~(RISCV_IOMMU_CMD_IOTINVAL_PSCID |
+				 RISCV_IOMMU_CMD_IOTINVAL_GSCID);
+		riscv_iommu_cmd_inval_set_pscid(cmd, pscid);
+		riscv_iommu_cmd_inval_set_gscid(cmd, gscid);
+		break;
+	case RISCV_IOMMU_CMD_IODIR_OPCODE:
+		/*
+		 * Ensure the device ID is right. We expect that VMM has
+		 * transferred the device ID to host's from guest's.
+		 */
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int riscv_iommu_cache_invalidate_user(struct iommu_domain *domain,
+					     struct iommu_user_data_array *array)
+{
+	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
+	struct iommu_hwpt_riscv_iommu_invalidate inv_info;
+	int ret, index;
+
+	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_RISCV_IOMMU) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (index = 0; index < array->entry_num; index++) {
+		ret = iommu_copy_struct_from_user_array(&inv_info, array,
+							IOMMU_HWPT_INVALIDATE_DATA_RISCV_IOMMU,
+							index, cmd);
+		if (ret)
+			break;
+
+		ret = riscv_iommu_fix_user_cmd((struct riscv_iommu_command *)inv_info.cmd,
+					       riscv_domain->pscid,
+					       riscv_domain->s2->gscid);
+		if (ret == -EOPNOTSUPP)
+			continue;
+
+		riscv_iommu_cmd_send(riscv_domain->iommu,
+				     (struct riscv_iommu_command *)inv_info.cmd);
+		riscv_iommu_cmd_sync(riscv_domain->iommu,
+				     RISCV_IOMMU_IOTINVAL_TIMEOUT);
+	}
+
+out:
+	array->entry_num = index;
+
+	return ret;
+}
+
 static const struct iommu_domain_ops riscv_iommu_nested_domain_ops = {
 	.attach_dev	= riscv_iommu_attach_dev_nested,
 	.free		= riscv_iommu_domain_free_nested,
+	.cache_invalidate_user = riscv_iommu_cache_invalidate_user,
 };
 
 static int
-riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg)
+riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg,
+			struct riscv_iommu_domain *s1_domain)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
@@ -1663,6 +1743,8 @@ riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_
 		       riscv_iommu_get_dc(iommu, fwspec->ids[i]),
 		       sizeof(struct riscv_iommu_dc));
 		info->dc_user.fsc = dc.fsc;
+		info->dc_user.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, s1_domain->pscid) |
+					      RISCV_IOMMU_PC_TA_V;
 	}
 
 	return 0;
@@ -1708,7 +1790,7 @@ riscv_iommu_domain_alloc_nested(struct device *dev,
 	}
 
 	/* Get device context of stage-1 from user*/
-	ret = riscv_iommu_get_dc_user(dev, &arg);
+	ret = riscv_iommu_get_dc_user(dev, &arg, s1_domain);
 	if (ret) {
 		kfree(s1_domain);
 		return ERR_PTR(-EINVAL);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 514463fe85d3..876cbe980a42 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -653,9 +653,11 @@ struct iommu_hwpt_get_dirty_bitmap {
  * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache Invalidation
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
+ * @IOMMU_HWPT_INVALIDATE_DATA_RISCV_IOMMU: Invalidation data for RISCV_IOMMU
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+	IOMMU_HWPT_INVALIDATE_DATA_RISCV_IOMMU,
 };
 
 /**
@@ -694,6 +696,15 @@ struct iommu_hwpt_vtd_s1_invalidate {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_riscv_iommu_invalidate - RISCV IOMMU cache invalidation
+ *                                            (IOMMU_HWPT_TYPE_RISCV_IOMMU)
+ * @cmd: An array holds a command for cache invalidation
+ */
+struct iommu_hwpt_riscv_iommu_invalidate {
+	__aligned_u64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.17.1



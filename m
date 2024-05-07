Return-Path: <linux-kernel+bounces-171576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E088BE5E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988C71C22000
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165FA15FA7D;
	Tue,  7 May 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mjjOo1eE"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AAF161902
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091984; cv=none; b=G8z3Mn17Ty/kTEFmcLRK8E0h1rTRjXmZ3RhInrNu+72Ej41G0viDBMX4tg+KsfguWoBnSHg/4ghaowwnUefDHzRKBbaPU4S/eooL3Wx9nWYGYg+CnN1iHv2rBtElt3zc7HFSrk9Ziij+4ujurPRL0Bu4h0m3xVVOXppLWqElslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091984; c=relaxed/simple;
	bh=p9LzzUVq84gigk4g1jMkvkAiSTYV+AnJqJecyq5AEds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aDbFYStaw1++dFcwrrJk1Fwpf3PmWjR0IYC9vVnsjFP3ZrqlCdqAopAy2/3SFnUpaUXsar/pLScAyR6sDZl917osaE64DZ0HS4DC8qKLwe/rZPPGTQo4ZlNGrgd3oXvhl4A4GQ0VqMPi+oyvYyxNmUqC99k0bCiUm4Qqt8LlbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mjjOo1eE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f44b5e7f07so2268981b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091982; x=1715696782; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QsG7aE0HnxZsvtjvosuXtYKV2huEonpRW6TKXMCUJnU=;
        b=mjjOo1eEpyGke4cQdaudCWJ/o3HM4QjmGS9ZQjwFrFoWtYIO6f/5XEXeMeT7tk/yg/
         cUKrSnDcJCp7Ux3juRvMlfsVWtkXRmfs+T2qWXrhu4+E0yFBXOfuQEGHd9qxJA4Z0ZxG
         PIiF79Txcj03/7LOLpOLxBkeu45iuWhdcqeXJW5QJzVnrm7AHJPXRQhoTwwAIkjlIjUP
         6e3jy3niKr8L2L2xIdu8KFH490mDEdTF/4NUPd4HHywquVOUGv35cD96TNuSqPizWiso
         0Pt+KqjL2hGcb2e5kh4D3an0avnlrLK7CKQ8MhW1Oa71qOwVjTMIlp3n2T9cl3rqCDOQ
         WtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091982; x=1715696782;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsG7aE0HnxZsvtjvosuXtYKV2huEonpRW6TKXMCUJnU=;
        b=epZHJ6Fkk8Rh+pnsJDf94mnv0DG1eHz9Ce/Y6sXYapX8BgmlPDi76hjpKfH1WeB4I3
         UcAR7qt407EI9wsfADbvxEEIfA6meWKxRJasziau2akEIRNp0p9kJ6pOWd2KvDBVdZp8
         jzPyhLwJAbCjkTkXKWuPMfU7ItdMmWSrjpqqZwLSn7lFfyMWIhK88qGd+w9Wf+4iH8Pj
         Pcn+Eu1sdJHAnuBx7AwC0GyhppwaK3ipG2Wq+/0ikeWiKJW3np18MJ52h98HMyLe8Nff
         jq67ZP8ZxdDLHBGgIxki+gKlr8ZeDusZeDg4N9HqYvLlae1IeB01tA1w70B4680zzvAZ
         ikvA==
X-Forwarded-Encrypted: i=1; AJvYcCUpbX/tSQtWKKFJrE7CnTxaquHOkVLvKHbVL0GiRHSYRcTN+H+p3eDBA0gUzn/dODAoMkEkLV79A28AXyHr4rX2v+wOOO8/6qwn8KqH
X-Gm-Message-State: AOJu0YwRw70wmae13Nm8SoIinHaO9UsrGLJgWBum97lxrKQxa1O1hDUZ
	bFPrMtXYCrQewaKgIBFQg3OxHHA2AdVMcHD67nDU/nhIeLIvuMgk9t+BXUcyfJU=
X-Google-Smtp-Source: AGHT+IESwO+1TpOehpzE3oOZnwENdjrLViV8PyyzyYTAIHr0YOeHnmv3rn25FWxqq/8kskMF3gIH5A==
X-Received: by 2002:a05:6a00:17a7:b0:6ec:e726:b6f5 with SMTP id s39-20020a056a0017a700b006ece726b6f5mr16072960pfg.26.1715091982078;
        Tue, 07 May 2024 07:26:22 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:21 -0700 (PDT)
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
Subject: [PATCH RFC RESEND 6/6] iommu/riscv: support nested iommu for flushing cache
Date: Tue,  7 May 2024 22:26:00 +0800
Message-Id: <20240507142600.23844-7-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch implements cache_invalidate_user operation for the userspace
to flush the hardware caches for a nested domain through iommufd.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 91 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h |  9 ++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 7eda850df475..4dd58fe2242d 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1522,9 +1522,100 @@ static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
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
+		pr_warn("The user command: 0x%x is not supported\n", opcode);
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
+	struct riscv_iommu_device *iommu;
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_command cmd;
+	struct iommu_hwpt_riscv_iommu_invalidate inv_info;
+	int ret, index;
+
+	if (!riscv_domain)
+		return -EINVAL;
+
+	/* Assume attached devices in the domain go through the same IOMMU device */
+	spin_lock(&riscv_domain->lock);
+	list_for_each_entry_rcu(bond, &riscv_domain->bonds, list) {
+		if (bond->dev) {
+			iommu = dev_to_iommu(bond->dev);
+			break;
+		}
+	}
+	spin_unlock(&riscv_domain->lock);
+
+	if (!iommu)
+		return -EINVAL;
+
+	for (index = 0; index < array->entry_num; index++) {
+		ret = iommu_copy_struct_from_user_array(&inv_info, array,
+							IOMMU_HWPT_DATA_RISCV_IOMMU,
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
+		riscv_iommu_cmd_send(iommu, (struct riscv_iommu_command *)inv_info.cmd, 0);
+		riscv_iommu_cmd_iofence(&cmd);
+		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
+	}
+
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
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e10b6e236647..d93a8f11813d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -689,6 +689,15 @@ struct iommu_hwpt_vtd_s1_invalidate {
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



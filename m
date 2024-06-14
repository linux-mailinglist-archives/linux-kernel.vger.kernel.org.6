Return-Path: <linux-kernel+bounces-215019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA2908D51
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE151F22089
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1014964A;
	Fri, 14 Jun 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sdrp3oKT"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D949630
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374957; cv=none; b=gP8y4nHFpb2oQiXokSwtDsXhUxQUNKWHKpROJ7tVsPAqFc0nwjksZFK8Q4BLQfSZ7qoFy561ts5S8cQug6B3AiR00U37etwrIeVI3WB+2mefDmDS3t50aWhGlzgGwUuebFkJKjhr7slXcVYNM3TAkunzmKf5IISEeVBXHNMOxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374957; c=relaxed/simple;
	bh=Q7a++o7eiwUm8M0irLfARJWMrYHyrc7Ai/QKurMYIDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k7uoU/xDyx9rCKVmjS9pm2CIMukRqyO9pEWYR7KtdBfTx0QoTpo9U/GveT8u3ce8A24dcnoIzndc7OCCIWTb9V8A5wc+Xp9LL8/MIzN6V3EAeMN7Q6/8BZ8EYvLLJZ+KccVb0U6vDzWhrP8I6h9cdkEyVlH1C56QD4ISs/RT9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Sdrp3oKT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b594deeso21678105ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374955; x=1718979755; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wDCzcwoY+7Urqf0z9zEneV8CU/qabdLYOlq0L2NAoPg=;
        b=Sdrp3oKT+qzuCM2pbbA7+MtRXJELPBufR3k0gYoVbxidM49WPLQTkiMebW6rlgQfDL
         zukX8zs+5evigM7FdXJU1k5VE86f4twOq7ZJnkaN5k4Dx9DTu8kX4f5FiNAWiSXUz/Rh
         sewN47NzCAoVu2tzEmoPKI4BmvPem34v/LnWxq4TrZ59Yd1u3jI52NEqnYvjNGRNRaRJ
         8PjkVt3ezviUxHfZIgcp1l+AdNPELBfed0oAGkQnupj5144JRiKmT0oWPEZYl8pVohAP
         rNiUsLMBz9hptK7lFUWb6VqgROAUj0FlWic3fTEONxCcZ93BmvnMIYsIEArAEiI/D6F0
         9jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374955; x=1718979755;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDCzcwoY+7Urqf0z9zEneV8CU/qabdLYOlq0L2NAoPg=;
        b=DPXXLtHUbRPTc77hnr+nn7MsexSubm8e+5/7IkQUiVPRCRnG00KCU6xZaIRd/QKYFE
         9VPkqDqdv86iACGq6sXVmfq6J/wHaAUVWrR5l9ObJr1gNDwjlLZ7Dfy9KhIOz7Z3H4Hw
         SPyxWsFqCMGKZnNzosvhjIXT2b2hYqL2K900TU+9QuiCtwLs6XBPF49n0z2ED1dnYY3g
         kh/bQ8ymAWtgTmrzi3TfaleTE9aq2feYjRILqMIGc2YkceaU8KWPZIaQCtwYSEp07L04
         9a/KQGo4ZHFens1jzsc8KZ4sqDSgXG0wsdZTTATaZ8IO7ABXdtKmSBcYY5rdOcFq3ZKf
         C+jw==
X-Forwarded-Encrypted: i=1; AJvYcCXFSszaAa5uvZBLt7q15801bweNfDD70R382iMAug5EaV7caydVjh95lZAqMYCJMrA2itGcNqZH9tiPlJDFr3zlaPPVRe5rsHmBwOBO
X-Gm-Message-State: AOJu0Yxx/OYVE0cAMc940A1S0LtsEd8sWyWYFL4OgGCnQmnBQ7taGoZV
	6mlDbmI7NFf/LZrBlghQZhx/C1ircx6P/bofyYhVSfa0kkonZk93b6G1mg0p0FA=
X-Google-Smtp-Source: AGHT+IFNWiib9Mbp3WUeDaTWc2pLd5fn9/fMVeRdDHjkyMdQAAUYNKmmTVlC+NReoIyOXuSV1VHXpQ==
X-Received: by 2002:a17:902:f68e:b0:1f7:2849:183f with SMTP id d9443c01a7336-1f8625c243amr33675115ad.1.1718374955357;
        Fri, 14 Jun 2024 07:22:35 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:35 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/10] iommu:riscv: support nested iommu for get_msi_mapping_domain operation
Date: Fri, 14 Jun 2024 22:21:56 +0800
Message-Id: <20240614142156.29420-11-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Return the iommu_domain that should hold the MSI cookie.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d08eb0a2939e..969a0ba32c9e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1689,10 +1689,22 @@ static int riscv_iommu_cache_invalidate_user(struct iommu_domain *domain,
 	return ret;
 }
 
+static struct iommu_domain *
+riscv_iommu_get_msi_mapping_domain(struct iommu_domain *domain)
+{
+	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
+
+	if (riscv_domain->s2)
+		return &riscv_domain->s2->domain;
+
+	return domain;
+}
+
 static const struct iommu_domain_ops riscv_iommu_nested_domain_ops = {
 	.attach_dev	= riscv_iommu_attach_dev_nested,
 	.free		= riscv_iommu_domain_free_nested,
 	.cache_invalidate_user = riscv_iommu_cache_invalidate_user,
+	.get_msi_mapping_domain = riscv_iommu_get_msi_mapping_domain,
 };
 
 static int
-- 
2.17.1



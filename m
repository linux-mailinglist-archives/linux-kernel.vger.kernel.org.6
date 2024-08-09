Return-Path: <linux-kernel+bounces-281314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FAB94D56B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A241C211DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2F5A0FE;
	Fri,  9 Aug 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6dU6l89"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CA1C69A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224443; cv=none; b=etFBM2PbRPvvFNPNtA7aGfREH3gd9URmCj86AEQzvGzZLfywmz7REJDX4tMD1758XJtem7DXXTBiazHEIMc+/Ab/c92xvoiklGD0fADSRYSMvHHEj+5w364wUPM5AqnHqL6cAPJhUh/QYsPmM57DqDPp4t81sNj4WFMqbyllLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224443; c=relaxed/simple;
	bh=FlHstR73F4adrjgCHMFGjSYm9SWWKnD0W2zVjuzFlJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuGe3RMfK6MdxiCpFkKZe0+QMRewhZJh4tti9rggmq2xcvL0Rmq+an5EsgCAicncbQS5NVsTtB2m5Ws/1fKQKaCQFgo4Y1CCd1CIR0dHzbom7oyOJSPUe2gBn0SEFUXOYgUNj3wEdtCOPyFI1XlpVl8mS0I2us4pAjqi5QoSjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6dU6l89; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo213991a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723224441; x=1723829241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQPvShp7okcQ7JAAqXTExHsdJANgIA/pYy+7v5WQOgw=;
        b=c6dU6l89JICQw3ZgKP1Ko6woxC1VmsoMo8jLrraGXm6pTWFPJhPASzm0eDYMBTPU6e
         eNvAmdpKdmMrugvvvWAv5du0nrz00+viLbpck84GeMUmfC1nYI9rXv32k0OTF8J7QUlJ
         uAtqxAeoBkPb7eoYA6Y1Vh9gT5cRIhPFSkJhgOrORH25Dk4uXZdz1gDAnhHWCdLDw6Sj
         if+JyAfNddDA1FphqTJbXPALrdsM7ti5R8nJwE/idISiKQ9lvHaKWRRCCMgUyw+Ndd4A
         jDorS5ETqn1XWLWltnd2eZ1mgWzj10D8Z33l9NhZ625cYW0Xe41EJjdmFqgSMfO3+Bzi
         ZUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224441; x=1723829241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQPvShp7okcQ7JAAqXTExHsdJANgIA/pYy+7v5WQOgw=;
        b=Ef9UzN5y80GW6bBXTlw/rATn585AVf7MJJhqhiLinhrZ+6T7uHRQEUtpRkrrEaXdkc
         SydTEWthTBT2+4Hh8+PouXOdAmmlbhaHUpH+sj+SvmnXh4l+WTWGAMug83DFupP1GFVX
         /HuZQtR7rJ9WkcqT9HNP8RojmUVuQxwr4SVyKu5wMsJYGnkANGkZ43I/9HbXmhFek3la
         MqdWuFczxUpFyBONc2e30n6sdE0T9jOQw13x4PFkQw6hSwYXXuSQE5PLIpY4FK/k55iv
         oS/1Ak6wh5IzwZf+p/1QMAZYnwuSgrzfLgwJhXThkgYZUL/P0aVicCdaqlu6SGqyn0b+
         37ng==
X-Forwarded-Encrypted: i=1; AJvYcCVQr0UgCRstWyKI5BehV3H2E9/cNF4AlINsSOzz4TRJDq1LH7aE95k6zkTRkpQNWlxwfesDwVDLOixJdbj9wZte9sMxVPqiI+wUZ68M
X-Gm-Message-State: AOJu0YwvNpkq9lRsMI2NYppv+5d0TJYDspOel6i86AViLBqfpU2CmGRR
	CMhBjPTgduip0B3mmKpn5/9fTWvGrmwy1yzXDi1LljwUDSG3WPv1
X-Google-Smtp-Source: AGHT+IEkjgGPg89j21Z6sTTJq8iGEXpSiujWsxC7JsiG4AHSF1ZSDSAZTLb4PrewOtx7fnimA5C9Jg==
X-Received: by 2002:a17:903:2308:b0:1fb:8cab:ccc9 with SMTP id d9443c01a7336-200ae5cf9aemr27913985ad.45.1723224441376;
        Fri, 09 Aug 2024 10:27:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba0db27sm56455ad.239.2024.08.09.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:27:20 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pranjal Shrivastava <praan@google.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/arm-smmu: Un-demote unhandled-fault msg
Date: Fri,  9 Aug 2024 10:27:14 -0700
Message-ID: <20240809172716.10275-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Previously this was dev_err_ratelimited() but it got changed to a
ratelimited dev_dbg().  Change it back to dev_err().

Fixes: d525b0af0c3b ("iommu/arm-smmu: Pretty-print context fault related regs")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
We have crash telemetry watching for "Unhandled context fault", so we
want to preserve this error msg.

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 723273440c21..8321962b3714 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -417,7 +417,7 @@ void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
 void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
 				       const struct arm_smmu_context_fault_info *cfi)
 {
-	dev_dbg(smmu->dev,
+	dev_err(smmu->dev,
 		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
 		cfi->fsr, cfi->iova, cfi->fsynr, cfi->cbfrsynra, idx);
 
-- 
2.46.0



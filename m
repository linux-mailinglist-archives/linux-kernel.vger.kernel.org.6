Return-Path: <linux-kernel+bounces-267221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D149A940E92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6038B1F24354
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B3195B28;
	Tue, 30 Jul 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxqxsp8+"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AC18A92A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333843; cv=none; b=eDoLAydn/k85RHFQluUGGbZBglMo2tgGc0lfifZy7tzlYpD8FdgDxRe2EN+9q801W2oVDspHdRgXs3+JlaqzJJr0EggCe4Kl+b8qe2NGhnxMEByxl1c6RFUbnjxMGiZDmp063TkaraSAAewymT8oSr0ThYmU8jb7YctqMjoPceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333843; c=relaxed/simple;
	bh=jKC3PO0k+K0NSkcMsItoyKXtPQ2+bKB+WP4svksYQiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rjykPh1JgLBb8JDIG0yYAg/D/jG801XMAvdIWSALPk1JVA2soG0MxllrnarNCi7CYwedyVQGVOROoKObipWotoSl3yOyi36Tkbcxaakvxbz09qmWxekt/0IS0jIbygO9KW4vZrQfFsUaJIj9uFr/AKxJ1EhvKcltR9wnBeeYLSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxqxsp8+; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db14339fb0so3000373b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722333841; x=1722938641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEXs4wZ+PjPw13Ex2O8ZWhqoz1ln80vOYHcSDptS8gY=;
        b=dxqxsp8+twc7aFwV/0deSIHXzy4RzwNAz0S6t5wQZ6PEJtDykNzzNyaQvD1nCAxSIm
         +p1h0xMf3Da0JRKu0b2Vepk22X3KjRiPohNnyDxi2N0RN8zTbiBa+NRw6iOHqu3ObWfs
         N09xdwag2Wsi4hB3BcKzs+Gt1GaiuTGK4Z2go+PFcRdKh6ID4vdLVShXRfwnO67dCui5
         hDJ3zSMIAXSzGrgU4FDe938agCakDPOvG8jta23MhDXrzEJI9rXXkZqJ3hLGneEwXM9p
         5tYiXU7ovKREtJgW+GgL4ZZhTXLqjCQEqdrde4EHa/5LcOVbGz6CVciBQgJ/JiklVFm8
         REVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333841; x=1722938641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEXs4wZ+PjPw13Ex2O8ZWhqoz1ln80vOYHcSDptS8gY=;
        b=m3lUzdV1LZp1pibekTTQ3RgtXxmOsMvkBVidc5un24nFYVlWKRFd13ConkgZSBV/4j
         iwa5i2+4rlqs4Fv5YwL6EiV/BgMwlek7mbpgOFYu0Xv8dZMcBGVBtN+VhXTUSUiK6dFN
         e4sHhrllXtHz/Y6z50DrV+h/kWMug5yqlq+ovUDliaDg0r/RZb4xBSRUNXZx/nS8hurW
         kOqlojqt1BdcMVIyJPEGAxaS3mVK94rbHEBQHZkEmmQ5TcnRJkFeY63mV1WD6B45lJj8
         X64HCRGTWhipe3opeCaCz/RP4xREAEXnMGf94WTlm4fTJukBOFZAik0lLNRRsbxUD6Cg
         FK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiLXyUkiPcUqD00P1baLER4zpXoBEW7oGBPZq8l91luY+z3CX44MjFg+9VxKyQ6MUGNCW/zTN7STQ3qzSZiKTMw+GlJv7ChyB8NGoG
X-Gm-Message-State: AOJu0YxgaMqtXWrryOAHDeRDSCCvWtQS8Uw5+ItQQOBVVQidKh222hM0
	zwacztWbQGAeExunBSrhZ5nrB6QLLEN64oflDU+EdpGnm/PjWmD30pr+CAJdqQ==
X-Google-Smtp-Source: AGHT+IEoucqhmei2W8M8QhIZshadLp47TQTDO+Dm76iLipImlFup2W7brIF1xHIYG7M+ju1nxgBgpA==
X-Received: by 2002:a05:6808:ecb:b0:3da:a16e:1764 with SMTP id 5614622812f47-3db2389bfe1mr14444572b6e.4.1722333841114;
        Tue, 30 Jul 2024 03:04:01 -0700 (PDT)
Received: from localhost.localdomain ([220.158.156.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa49c20fsm7335295a12.79.2024.07.30.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:04:00 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vkoul@kernel.org
Cc: kishon@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] phy: qcom: qmp: Add debug prints for register writes
Date: Tue, 30 Jul 2024 15:33:51 +0530
Message-Id: <20240730100351.51454-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These register prints are useful to validate the init sequence against the
Qcom internal documentation and also to share with the Qcom hw engineers to
debug issues related to PHY.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-common.h b/drivers/phy/qualcomm/phy-qcom-qmp-common.h
index 799384210509..e6a6bcfcac28 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-common.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-common.h
@@ -9,6 +9,7 @@
 struct qmp_phy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
+	char *name;
 	/*
 	 * mask of lanes for which this register is written
 	 * for cases when second lane needs different values
@@ -20,6 +21,7 @@ struct qmp_phy_init_tbl {
 	{				\
 		.offset = o,		\
 		.val = v,		\
+		.name = #o,		\
 		.lane_mask = 0xff,	\
 	}
 
@@ -27,6 +29,7 @@ struct qmp_phy_init_tbl {
 	{				\
 		.offset = o,		\
 		.val = v,		\
+		.name = #o,		\
 		.lane_mask = l,		\
 	}
 
@@ -45,6 +48,7 @@ static inline void qmp_configure_lane(void __iomem *base,
 		if (!(t->lane_mask & lane_mask))
 			continue;
 
+		pr_debug("QMP PHY: Writing: %s --> 0x%02x\n", t->name, t->val);
 		writel(t->val, base + t->offset);
 	}
 }
-- 
2.25.1



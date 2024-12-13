Return-Path: <linux-kernel+bounces-444716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C00499F0B79
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4500318882CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548BA1DEFF1;
	Fri, 13 Dec 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KtGmV/Wc"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F681DF26A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090167; cv=none; b=DuvreooyaMePDpxRqKHZW5r4gktCvER7idPAlPFIY8McYdmz5ENJEjPnft1Vh9Mb78CbMGxhX2oso3E9boAkqp+tDFLKJmmi/fzxjS3KchRnTR3ggQ/7Qb72LNjvt5GSOZ2SSpFrRSwRV39KRghDrY/nddTmjnXFYi/3fa4s8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090167; c=relaxed/simple;
	bh=zXA+bH1fAd5vL+KjIYeRgZV5aeOh71Eu4BbSz01OWsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StRcp8W8KlvLe/2cFf51GZgdhsfY7G+1dUL/2+ei0+NUq9p/tQZo3yOCvkvOZgPQrNLHQfyEHAA5MY2WNCz+e5n57ihW+a+zKPNFrcbxG9d271Nqn9HKTAnFgADnQRWVF6d/mbdHAPA2zUKbO5W2W+oOSijnHf2MQRNEVLegTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KtGmV/Wc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725abf74334so1358564b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734090164; x=1734694964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeEQjuKWeFN2ZDkGY720uCzhuIIhCR6ezIvsDMVpnR4=;
        b=KtGmV/WcAvpH/msRaOf7u9nLBEx+yO3Nd4BmcPDXUWeOFti+gCrPoxjROLPezf5+o7
         gkvrk2iz9lYcpPD+6i6X3aD4e/BCpbZ9IcL8QTYAnUmcWShVA6ldJW958Us1An2kKGEe
         sylBq/fSM8FXpRO29zvQKbyoH5XqyckXzGC6vXYx62i3Mz8XxuxyKxwUERO7H+6RFGA5
         pPf1paj6fFusTQRqrRxDlqLqOtG7odsK8IDDdaDwDnUkqY8Vzmp2n2TF3OyjrjfRoqbf
         T9YLNmoF6fZU2cFU1W6cQitAIq4Tp1EzStLhA9K6H6kUhUqOUlZ4ytY9TVnC7yx9j2eI
         xz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090164; x=1734694964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeEQjuKWeFN2ZDkGY720uCzhuIIhCR6ezIvsDMVpnR4=;
        b=Nuv1hd7ODmMfE0bN6UcQHio47YlYKwpS27t3mM/Q8LGoJe1Cpe/rk6mfmlZMC85i6N
         oJiUM3g+wRjYzQs1mKynbpxVXOmFkcUYCjIZwSPvNsjTdd6rEDM3zg6nhrdjBex8ny3j
         bSP6h/cRbV4Uw4gyLj2hSWHmbwekNMgQhApoR375m2B3vp5bEvAt0zofpOaVL3q6LHeH
         OMZ6KrtDZmAW6hSwbf+ODH6ouddxJjAknq9fDXtVSHuTcFTFP7ySioyMYTvpwe10vD4a
         JDvnHheCt+QWbr5x6JOhUBMUY+y/HV1WjIPRyetVArbcRO3VygrwT045TBtc7/sL0QUL
         I6SA==
X-Forwarded-Encrypted: i=1; AJvYcCWXQHEUJvQWJY56e5LwRAogtVH8j+fe1JnCixd/nH7kI7R9HPPaxEFW7En4rGLqgIYZQ4LJjizek6FQL5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cbMcYDGNh9y8H55XkPke8qIoh0fgCXhTq2lQZpDbdJqfOC7m
	6mM7rKqEElCQfNEvoRCN6t/ZCjheVHSDqN2u7rTULhFpoKhSO32S+xAgVzBtYmM=
X-Gm-Gg: ASbGncvt2dnHaOTHUH5UzVPGPo55OC7176H1QgzrCEKUKG08EmGMRa5bvDKzYs8zfok
	HW53eZRCnDdQCnIoGvHqf0RTbFlfoQuVqNN6P2Dn/QWyO9CN1/1t6oQ2VCoGPch7h2rGC9fmo0l
	Kd70tSnEsZKrCnuAoJ8b/Ppuh1j+2YytKx2wkKV96E788lC/aH/pgvfWLwFmV8poHEc1BI4/iQu
	Itn/lycFiXczyVMCwShC5SeWSdm5qdWzAffX63mwRAmjlFB7/FeFWoWFmiZ/4ape2HpC6vN+epN
	hWJIl5GBxRxtQVs0gTO14j+BEiBAXxulCTNC2Ng=
X-Google-Smtp-Source: AGHT+IGeWdd36o5upIqzrwhc6coASaeu5E8HRRrsujN3Aueo0WxZt2dbtsoJCJze86+/n/dSVtetAg==
X-Received: by 2002:a05:6a20:43a0:b0:1e0:cbd1:8046 with SMTP id adf61e73a8af0-1e1dfaa0ba4mr3644498637.0.1734090164609;
        Fri, 13 Dec 2024 03:42:44 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4b961f1asm8666340a12.30.2024.12.13.03.42.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Dec 2024 03:42:44 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	guojinhui.liam@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 1/2] iommu/riscv: Empty iommu queue before enabling it
Date: Fri, 13 Dec 2024 19:42:32 +0800
Message-Id: <20241213114233.12388-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213114233.12388-1-luxu.kernel@bytedance.com>
References: <20241213114233.12388-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing cqen/fqen/pqen from 0 to 1 sets the cqh/fqt/pqt registers to 0.
But the cqt/fqh/pqh registers are left unmodified. This commit resets
cqt/fqh/pqh registers to ensure corresponding queues are empty before
being enabled during initialization.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8a05def774bd..84806724f568 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -240,6 +240,12 @@ static int riscv_iommu_queue_enable(struct riscv_iommu_device *iommu,
 		return rc;
 	}
 
+	/* Empty queue before enabling it */
+	if (queue->qid == RISCV_IOMMU_INTR_CQ)
+		riscv_iommu_writel(queue->iommu, Q_TAIL(queue), 0);
+	else
+		riscv_iommu_writel(queue->iommu, Q_HEAD(queue), 0);
+
 	/*
 	 * Enable queue with interrupts, clear any memory fault if any.
 	 * Wait for the hardware to acknowledge request and activate queue
-- 
2.20.1



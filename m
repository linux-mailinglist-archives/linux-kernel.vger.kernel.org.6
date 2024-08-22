Return-Path: <linux-kernel+bounces-296549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906F95ABF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA561C2106E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA311210FF;
	Thu, 22 Aug 2024 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uosZLwAB"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99B1F16B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297623; cv=none; b=fsJXq1Gx5Sc5S7v5+I9yfJDChiAsoIu/sG2baxyYNtvfqhlVV5yOeSlz+zr9Wjl1tKJBWNVzPc8hnR73Lw3Wjw5ouUmNZz+i/y9/187PSzKX3J7PlLpB1aS8GKYTM3OjeSp2GwWVx/3eVaW2Uad2T5LVXAsvlaW6bK+j8/V+RzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297623; c=relaxed/simple;
	bh=tw3TxLdNG42xIrFDyPzzuHRABJ41tvX8tXaWqdnA28w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=M7MfJmwhC7qSWFnaB/UJMTWX+1lX+1TWcOqC5WZMceKa4f4lvcuLYCAvLy+jcqeGx5MbI7tKe2rhWvCiW7HEcAHxQJTdLGPDCvK8EN/uUdWAfsT4V/XkSELKpUD0A6iJKiz4SbHIgVnlsHtGsJdvO/NyIZKWKyf4+K8ifNPy8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uosZLwAB; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724297618; h=From:To:Subject:Date:Message-Id;
	bh=ndIYElBQiIJRlNA+Rhfq51L3EXZRYJO3yC/l/ICB21k=;
	b=uosZLwABkecuEnEg46JuLKgw/Vd5h8n2rNI0pqOj/fmuiM7WtjbxJUCzSWSv/84tNQ8P1ZXHIsTY0psJcEp7WL5k7WwohF0UmAiSRh2+VZDDxPv6EUHu5UdVag1I0MYzSx1hr3CrevjfNvKNtpI9prFh4ubPRRyLQ7ZGHeOT330=
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WDNiHbD_1724297613)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 11:33:38 +0800
From: Jing Zhang <renyu.zj@linux.alibaba.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v2] drivers/perf: Fix ali_drw_pmu driver interrupt status clearing
Date: Thu, 22 Aug 2024 11:33:31 +0800
Message-Id: <1724297611-20686-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <2a70eaa3-f1c5-4803-948b-4b8eb86190c6@linux.alibaba.com>
References: <2a70eaa3-f1c5-4803-948b-4b8eb86190c6@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The alibaba_uncore_pmu driver forgot to clear all interrupt status
in the interrupt processing function. After the PMU counter overflow
interrupt occurred, an interrupt storm occurred, causing the system
to hang.

Therefore, clear the correct interrupt status in the interrupt handling
function to fix it.

Fixes: cf7b61073e45 ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 38a2947..c6ff1bc 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -400,7 +400,7 @@ static irqreturn_t ali_drw_pmu_isr(int irq_num, void *data)
 			}
 
 			/* clear common counter intr status */
-			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, 1);
+			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, status);
 			writel(clr_status,
 			       drw_pmu->cfg_base + ALI_DRW_PMU_OV_INTR_CLR);
 		}
-- 
1.8.3.1



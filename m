Return-Path: <linux-kernel+bounces-291991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C3D9569D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE661F236C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9F16848F;
	Mon, 19 Aug 2024 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EagovWvJ"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271D167296
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068137; cv=none; b=tsOWb42+W4GFkFR4nDDdl0Z8Mvz60t7LW5/JtO4Zp9AIElDQuUohq3ZT0d21AWS9mQybjawUaJ0woKnKv8nHYj5nhPLqztTIVoQ0tfJJ3Xqg8Qu/l0iD79MRExn/fDT+b5up8BxA9AWicF1bIEE3pOz4u+ABVh1eS0NKoZ+tKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068137; c=relaxed/simple;
	bh=DIyGM3oLphN0IcFaV41gVZSTj16Lh7ziLSqCsdXfM88=;
	h=From:To:Subject:Date:Message-Id; b=ObrcKiuqMSkTyrEpro1E4KoiyAynq69BGTuZLiNMRauXryxdvPAbkk+i2Afc46ddGNYJLQFSPOX0KAjro0NCK61a1Y8UtFWI7YeELkrhsOF79tRh4DDlMK1cEmJBeFTePiZ7ybqNbrpCDnUmdvNG5PKEWRK+t1CVc3mWdxBT7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EagovWvJ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724068128; h=From:To:Subject:Date:Message-Id;
	bh=CsNYcfq73m8l6qFDgKhixVingNQS6pVlmbEOXs8aoQQ=;
	b=EagovWvJuTUqWS1JYCu+wPqw+cge1DKx8Gl4eR2Yo8cuG011osiBcguD9LGcc2LWQkW4MG/t8//wXM8B6ZWnxKnaVIm0b16NuMrpYhKsAXghFHZVFQzxC9RAurc/zIIZbj4u6iZldsCGNw9bOLUYIqQfLvBRwuo+iUgwk1kKdi8=
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WDCpn08_1724068122)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 19:48:48 +0800
From: Jing Zhang <renyu.zj@linux.alibaba.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH] drivers/perf: Fix ali_drw_pmu driver interrupt status clearing
Date: Mon, 19 Aug 2024 19:48:30 +0800
Message-Id: <1724068110-45239-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
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



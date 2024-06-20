Return-Path: <linux-kernel+bounces-223218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C45910FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C06A2857C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582E1B4C49;
	Thu, 20 Jun 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUwu9T40"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDEA1BD915
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906256; cv=none; b=RkxlpJ87bwgSFaOciqKoOfdrNpkBuyzH2pUYpKJVhgw7bNfE/6NJzePkaeg9CTL+oa5HG95cKbW/27wvsYdivv+rUZAcAV7aUzNY3rWRCBBd48GMbkxkxHvRlTy1VybbuaCDTsGdDHTs88jCig7uQIBOYjoKIfuSE9MC7hx5Y1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906256; c=relaxed/simple;
	bh=IJH0Xr1pzPS2QRONxWqkkm6N53c8msn9QYo80VGvKXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKysLKrFIzbQFUfc/QCLTDD8cCI/x2XpSYciPc5rCax+PTGxdktdLDl0Zk11eVu78/cKaQunNJ/kfSY7eSHDLbsB3k1N3u6SECR7Drf3usNRuTw5a13sbdISJwnIi+vMTYx8+rvhXbIsvA4pUOlrup9cTuzlDKM/C0QJwb3/iWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUwu9T40; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e41550ae5bso903926a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906254; x=1719511054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5DGzLYbAUAdrqbJyW80kv/C/QU59EDA9QcwDgDhhzU=;
        b=MUwu9T40imIjXvxFeNDOMqpFLMD7DqnrIFwdIO87dT2BGC0rNjG9nrBKp3E0WHBULS
         IlYlVkxGELvGw+5SWCxK0+7e5a3XCCKtjD26h6O6hXmZR8UyHCKSXLx/MLud50ow6idi
         e5XAE7uGc8SsU3UFDrmDs7Rt2ftWVSSkTG+pco22wBCx5fPejDWtrPuNzwM/vAB6HW/2
         INnx5MfIGOzZ0fYNMIk8Gw9vfJpD4cs6Y91LvjSXFmnDWmaZ9ppyKxQvoicQTYLkfI1n
         nL/ao5PkQFpYbUgf5STpVC8q/fjuP5ZZsgmeM34Kwm20cVlRzBgQDEATjx03/t5pnLBl
         upPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906254; x=1719511054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5DGzLYbAUAdrqbJyW80kv/C/QU59EDA9QcwDgDhhzU=;
        b=er3zW+n4JW8/FZzZVTshc2IfXeSFdSTZFURJt3U9u+U+1Cr9IrcK7Tr3CAHf80pzPm
         DXrarcTbK4JdhHlWbk+M1zLqqTDz6QP7w5XUx3G2i39j/O68DtDAlaMKnaHIXdRcvauI
         /chajvnfTZC9bOHEmf6yvnxqhLrdnduIqhGme1IJymRzISFAz+gRZxm78gXBDQr3EeVA
         9PP760TPtgUqwPxX/KfmsLe2JAze1SnZf1q16CijIO0/p9GYbX+RvhpB/xOfMeWPPeX/
         e78ILPeVi7ttH4hHwj63yQA8SfOnsDTOJKVjLsbZyTrTNC2lNL7/Dyw/0Q60SD5AFVxK
         VVxQ==
X-Gm-Message-State: AOJu0YxzAcg3fFUwYQW00zCr2SbbBcRqAEXp0LzXaxsXTu9aEjOnWYTc
	M+R/P//hazln7Q14YW4vcIrHhl26P2YPFMxEK63vEOFffLjbCVqdsrOqlf1d1Cg=
X-Google-Smtp-Source: AGHT+IEumLOfgHy9ptSYIb80BMzk95Th2CfOVKwPVPTL9GX5qt4vT11e0BpVTPi3+WCx/rlRYbxNTg==
X-Received: by 2002:a17:90a:e60d:b0:2c4:a7af:4d79 with SMTP id 98e67ed59e1d1-2c7b5c75d03mr5990223a91.11.1718906254495;
        Thu, 20 Jun 2024 10:57:34 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9b5dsm1989603a91.43.2024.06.20.10.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:34 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 09/40] drivers/perf: optimize ali_drw_get_counter_idx() by using find_and_set_bit()
Date: Thu, 20 Jun 2024 10:56:32 -0700
Message-ID: <20240620175703.605111-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function searches used_mask for a set bit in a for-loop bit by bit.
Simplify it by using atomic find_and_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Will Deacon <will@kernel.org>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 38a2947ae813..1516f2c3d58f 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -17,6 +17,7 @@
 #include <linux/cpumask.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/find_atomic.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -266,15 +267,9 @@ static const struct attribute_group *ali_drw_pmu_attr_groups[] = {
 static int ali_drw_get_counter_idx(struct perf_event *event)
 {
 	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(event->pmu);
-	int idx;
+	int idx = find_and_set_bit(drw_pmu->used_mask, ALI_DRW_PMU_COMMON_MAX_COUNTERS);
 
-	for (idx = 0; idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS; ++idx) {
-		if (!test_and_set_bit(idx, drw_pmu->used_mask))
-			return idx;
-	}
-
-	/* The counters are all in use. */
-	return -EBUSY;
+	return idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS ? idx : -EBUSY;
 }
 
 static u64 ali_drw_pmu_read_counter(struct perf_event *event)
-- 
2.43.0



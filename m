Return-Path: <linux-kernel+bounces-333081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8D97C335
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9351F22232
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1A3134AB;
	Thu, 19 Sep 2024 03:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N+KGvGP1"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026C125DE
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726717646; cv=none; b=M2h85mmkDwLh5K/EzjXUgQ+pLbrOrgg8ceOyWub2EkbSAMN6hupm3YY+FMLE9aTshHvnqR+I5ZJF8KpuoD+X3GNK4kdRh9Ssz3feaIZ8cCSklTot38ojyybFKIbMVT2fw9LFrlzP6SuNsXepnWcu3wLwN4nwsnZnSYrKcp/s0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726717646; c=relaxed/simple;
	bh=e0OFdj0lpd7riRsXPDRhTjwJHNsX7V5YaXr9nipqHXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q9+jnJwl1p84sLOw1+dDu1Hzw7UfRFNMC+X8ZLXVruRzZGcti1oanH0WSVc5HQafIBoL04oCjmcoJ4VA+KmP1GpsXWA0XZVREbfyxzyjytsvRRQc4YbYqcqjRqrvunGXJmF2T4s42JB6McCVF+pY/HOSTl4dcxVoIK7+NwKOAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N+KGvGP1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7179069d029so270945b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726717644; x=1727322444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8Wd/pkbfHSw6JOPxNYyJ9mdgKFr/6pXLapB9px/A40=;
        b=N+KGvGP1rGUZdsDzyNtOrMPz9PezOzUm0/MCkT/m+ywTT8F8xyNpmx1e07GW9HnVm1
         PmiJrcHcAM0vVtnTeMCFJ8zFEaeDpgCSAm6PBN82p+6LgfwHZk2etWRASz9/S0QrkN1g
         fPJJO5plviZfncEcoKn+fCU9RFsOoifbNmLaiKEOumP+Ww5rQeeoRm6NSnQA6Ir5Y+Mx
         Eopa0zaV4rr5WuUQbeqSt1JgNxXdcKKm/I838sqRME2+YPgJJ6XOTqO07WX0XwnT0P4m
         RRZ914Bclpp1mP5g7ch68JzoDz9/dOSUMbhloLRP+CKgRVSGB50uhasOrqy0QklJ7Gt7
         ZaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726717644; x=1727322444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8Wd/pkbfHSw6JOPxNYyJ9mdgKFr/6pXLapB9px/A40=;
        b=Y2IMLiRru6JZbiqXC7laQ5e/dm//T8a3jUoJerWf0Gbp3irhCdMgN1DFp8R+uBmf60
         YDGDHFxVo+9yTyrl/NqxLbhuuL9R6p23mv3sW8wo+RmCZQcEoMkTktE5qtbjLpG9YQWd
         hfpRQBtagUzCUhhXcCNgHe2ULiLX6ewjV3lGupCeOjJvs4d3/U7pZZUk1zbB8UgELfF5
         WPmEJuEP/oODw1jeoh8sv4prjsuE5LnOMbzG8twab7yN928vlmtTvooPLOThZ/CjlolM
         uUB5tijwJaoqvxeI0sPZdTsPvLCp6Zty0k25eWv+R3WslQEJzOB6+vRzw2pQdx3V8vUw
         bACg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ziuh4fRkpgMj4fjyDLHdhSihMLgoOm5ytZtQRZutr5t+ZcRz3N7lHFoGrPJDoy31R+yZzzsXqrb4uXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yvHdJNoBzr02XqzLHy8BdaNajb2YXL+s98AhpK4/81SRKWO/
	zIZ1aBzXJr8SlLp+IUU7n0IQ2S5UlowRiKbFK4hSGdHig088DkN1TT9TV19kL78=
X-Google-Smtp-Source: AGHT+IEDOJNSUO2mBw26T8OEjCzYNAuTNuBRNDMH3WRaF9pDa0z8VPH+i872tLVdSRjH9OOq2GbmWA==
X-Received: by 2002:a05:6a00:4fc4:b0:714:1a74:9953 with SMTP id d2e1a72fcca58-71936a6267cmr30982838b3a.16.1726717644249;
        Wed, 18 Sep 2024 20:47:24 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc344bsm7427062b3a.194.2024.09.18.20.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Sep 2024 20:47:23 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] drivers perf: remove unused field pmu_node
Date: Thu, 19 Sep 2024 11:46:01 +0800
Message-Id: <20240919034601.2453-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver does not use the pmu_node field, so remove it.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/perf/dwc_pcie_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 4ca50f9b6dfe..59526a48499f 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -82,7 +82,6 @@ struct dwc_pcie_pmu {
 	u16			ras_des_offset;
 	u32			nr_lanes;
 
-	struct list_head	pmu_node;
 	struct hlist_node	cpuhp_node;
 	struct perf_event	*event[DWC_PCIE_EVENT_TYPE_MAX];
 	int			on_cpu;
-- 
2.39.2



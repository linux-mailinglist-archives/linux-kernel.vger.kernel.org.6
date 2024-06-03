Return-Path: <linux-kernel+bounces-199457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE38D876A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50983283B18
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DA8136994;
	Mon,  3 Jun 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJhXjDmZ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7B13666D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433047; cv=none; b=DNfsCs/lv7eQjWaLpG7djSpsrQ6LuPNiueeH5G8kga86yoxNrj25VL+7jSz5xMbX4wBv89hjuihAKrltkk+3p1QlPJVqt+0D7sSaHOzGNCvZZhSJpAR4C3gYoS2+4QpKprnamTZ1GCwxoQlqkhH4jlbawBFT1SAeREpQWvv5UCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433047; c=relaxed/simple;
	bh=j9efUysIbU+0fDZp59JmxjJMpgDLHkYjIzf8rBgtCHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A5iE4CR0rlabidOnNFdFqyZ84WMWyNU4i2bQwokCyNeuQ1fqX3ejQ3QK7Ph5Fufs93brU4ni0kWvcKkgdANHXT6HKmL8InOexhY5bUFy81uKPb44QJnGB7sbxJCGMr6huTgqOP/iMN2cPu0G1uEJx1nAACy3jb54PrvasVvYCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJhXjDmZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f62fae8c1aso29056925ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717433045; x=1718037845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQJCX2mLLjVwtGvAcK2JVSlXXTTlVczYVL9TcQ37x9I=;
        b=rJhXjDmZ9qsdMDC3KEeOWHBB/U6XvzuwFHaGSdsPm0HTLjLDItRq4Q5dq1m8P+VxbI
         J0I+GmHfbtMIl/vDqrVt/KP0VJKH8qK1cozyTuDYusIbzoXjL5Mr8Y/S6ohewV7SSOBP
         jt41vgl3P50jOkRr7VHfQ7EXTbHYRh759nIRqgJEbMCmABjBf8acO2kObAMr28RZBjfr
         9bIguu1tdQfEBOHS9L6BOhwxXajnRzXm2ADXtqVSQJnAwkbsYuXQ1sXAzkCDSnR5gwkz
         OYHs6jivPj7RQ0Dt7FlP6RGLtxmB3hLzcQDyGcCmZESAvK9MhaCsZe0FGLYnAUvoX01/
         o99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433045; x=1718037845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQJCX2mLLjVwtGvAcK2JVSlXXTTlVczYVL9TcQ37x9I=;
        b=iNIpD18on0ZH8eL3yxiLHYywo0zRa57t5uv/o05TaJSXBolw/Br3CKtW72pFBKDvmY
         MGzIUMlWhKfMWADtRe3Vf2XZnd0BaO5MnnFjv8QRXORBpx38SSDnVML7/9DuUXgtOaNE
         JpiURdqNpERTzu/+FMi6URPYlMjEX0HlaLFyjU8XBuesUDYYn40Q7BLPdG5rhKL3D/eL
         +6a4NXvJMp27CAdN1fW1aUL9HFU25y8P0/cVxFMmJZtJOCRUT3+7dUVn+mU37ipj12NJ
         teqzXyS2RSYY1S4zhQ+Uk1oz1smO5tAw6Uow3TuKc87hGYM1TaOS53Z9fMjwR8AtT/jA
         hT1A==
X-Forwarded-Encrypted: i=1; AJvYcCXNwRv2wkXEQ1LABX1EVIWcgTL/tInzPkmQ8DmV6+wy5nzFxj9cHGk0uilrjltM1n6rF9ojTS9o6cMRDrIGyCoSLglYNZFMGAXA6p9H
X-Gm-Message-State: AOJu0Yxi5jLMM1QrOVDaLmm7T2Qc5dLOXIeA/pl6TjlyrZ1dZOxqoWFc
	28DnkDIEmPChUzTrLyJ7E4J6y2UYHsPLFGvfQB1vt1GMHIXJHVpCglCCup0jgQ==
X-Google-Smtp-Source: AGHT+IGYx+sx85xzgEc86M80PuqE2ZoS4273PGYCLxOQNlGQ9YXpPTVaa2w3bk5t3yHX6kqLl4+hdA==
X-Received: by 2002:a17:902:e546:b0:1f6:5bba:f134 with SMTP id d9443c01a7336-1f65bbaf520mr68933315ad.46.1717433045079;
        Mon, 03 Jun 2024 09:44:05 -0700 (PDT)
Received: from localhost.localdomain ([120.60.128.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632401919sm67523825ad.248.2024.06.03.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:44:04 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mhi@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] bus: mhi: ep: Do not allocate memory for MHI objects from DMA zone
Date: Mon,  3 Jun 2024 22:13:54 +0530
Message-Id: <20240603164354.79035-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MHI endpoint stack accidentally started allocating memory for objects from
DMA zone since commit 62210a26cd4f ("bus: mhi: ep: Use slab allocator
where applicable"). But there is no real need to allocate memory from this
naturally limited DMA zone. This also causes the MHI endpoint stack to run
out of memory while doing high bandwidth transfers.

So let's switch over to normal memory.

Cc: stable@vger.kernel.org # 6.8
Fixes: 62210a26cd4f ("bus: mhi: ep: Use slab allocator where applicable")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index f8f674adf1d4..4acfac73ca9a 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -90,7 +90,7 @@ static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct m
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL | GFP_DMA);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
@@ -109,7 +109,7 @@ int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_stat
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL | GFP_DMA);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
@@ -127,7 +127,7 @@ int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_e
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL | GFP_DMA);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
@@ -146,7 +146,7 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL | GFP_DMA);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
@@ -438,7 +438,7 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
 		write_offset = len - buf_left;
 
-		buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL | GFP_DMA);
+		buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL);
 		if (!buf_addr)
 			return -ENOMEM;
 
@@ -1481,14 +1481,14 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 	mhi_cntrl->ev_ring_el_cache = kmem_cache_create("mhi_ep_event_ring_el",
 							sizeof(struct mhi_ring_element), 0,
-							SLAB_CACHE_DMA, NULL);
+							0, NULL);
 	if (!mhi_cntrl->ev_ring_el_cache) {
 		ret = -ENOMEM;
 		goto err_free_cmd;
 	}
 
 	mhi_cntrl->tre_buf_cache = kmem_cache_create("mhi_ep_tre_buf", MHI_EP_DEFAULT_MTU, 0,
-						      SLAB_CACHE_DMA, NULL);
+						      0, NULL);
 	if (!mhi_cntrl->tre_buf_cache) {
 		ret = -ENOMEM;
 		goto err_destroy_ev_ring_el_cache;
-- 
2.25.1



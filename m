Return-Path: <linux-kernel+bounces-326599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1C976A97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C371C20C51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59691AD266;
	Thu, 12 Sep 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha0MaveG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4B1AD24B;
	Thu, 12 Sep 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147808; cv=none; b=Jncq+n5mFt2oZyI/6CsDM0pl59kSQg/vro4CkHwWo4vbhvIN9iRX0KMXKnxeal44TsUhTB4yqkD8i9ulyfPplnRwZfCSvodNVk9dFekb/txGR3Nnv2+5//MUwGj+iL/BACPlL772CI2loFnc7MEM+rAqhOOMoG0f1OQ10d0NtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147808; c=relaxed/simple;
	bh=8500eMWZymNpi3cxy9UL+TjjIgP5T0G19YtEfhUQpAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=arPXreEx8ciQ0Z3y75gBrvca0+LzzG8WI8R7AkMOwZ9ogXKDPgl4PSIt4IpNtjJYf4vLwryiivHmrrnkn6+sRW7y69Kp+otorKoQtJ58avlzfqdQ02AHYsL4yTuMR76tjamayj4dY3qdnHD4z4vx1zGPCbQDK0ll4dz17uCVaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha0MaveG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so9297155e9.0;
        Thu, 12 Sep 2024 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726147805; x=1726752605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31vuczscfrohitTr22PmxSxpLT+YhLOaIZ8Pw2lBn5s=;
        b=Ha0MaveGb8e2tYnT3SkMWqlZyV0b8+cpxAjlNuNlLSOyrh1lO3FCjhuT+wPSQlT/eY
         M3928zxsgHp3ELfnqD0YnILUNDhmFP/b2ZRpfbFDD5SuQhVlHilijb/H1+kDiZU4os1i
         qntJpYVSyKW2h94HMw3lDH8d8j53b8+YiEn6kvpJiNCEKPy27+4uyRk8r8zbCxXokbHX
         /VINh95hxwOWmDTjfO5o3gv0sGUxmIsjYmBsmJywoGgxz/9NYbgCyBRAvbM6joIS+oZc
         NVmMkLOKjWvopy1GxI8BE3WBNdCbcmCMc/vl3/qDVwpnhd5YGgeg4SL/bo7/3jY9C2h+
         /qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726147805; x=1726752605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31vuczscfrohitTr22PmxSxpLT+YhLOaIZ8Pw2lBn5s=;
        b=DZvtpJP0esJURUGFjR8aO4xuq9wYRy6NR9DfMB5aU8C0diMLMZpP6Jjow1PiJ8nBbn
         hHal3R7eXju7CmDvMbtBCVH/oZ3vQD5S+Gu2mUEphOceU3IDJWJA2Y5Ao25ShkhsTZTn
         0lPjaIQfGrWNqrsgoQTmykxjdZmNC00VldqvfY9SKQM+tL9awzC/5/aEg7MLA8eu3k40
         Kv12c5o8P3ZhauF43nhdj/4V8ZMhxsbNDZC2sA3LxSpx7qD10aWVzUibhyamZqRr3W9N
         cV2dPSaCTfdxAz9rC//jpE/0gtr3+9ldlCeajHDaQKuWfb+N8R5+24AfDVS209IklurO
         +fpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH/cIBSW4JAOKcamCj7B5d/dreMgGy47iK65dwPO3GM2IDtBWDKivZWMNZTMj1h8GnkIyDZWXdEU4LbWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpo8qP5uVjMGCdwUqVLhWDcvoAI+37Q/PQ2sVjIiBbZtuIBJA
	IOoUi/sTQo9O7JiluEAJT5YbJ6bwE8YjyaUjuoSPPfC0oqxAIV9KiJwxPYay
X-Google-Smtp-Source: AGHT+IGzVzLXofsdgNNXgFJHkQ58sJOkqe1BUUgZwCpXjNdePvaiYdfkXqFXBFazbMIOcP73wP/qvg==
X-Received: by 2002:a05:600c:3b15:b0:42c:bdb0:c625 with SMTP id 5b1f17b1804b1-42cdb539d15mr24385645e9.14.1726147804722;
        Thu, 12 Sep 2024 06:30:04 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm83578455e9.1.2024.09.12.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:30:03 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ofir Bitton <obitton@habana.ai>,
	Oded Gabbay <ogabbay@kernel.org>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] accel/habanalabs/gaudi2: Make read-only array edma_queues_id static const
Date: Thu, 12 Sep 2024 14:30:03 +0100
Message-Id: <20240912133003.589686-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array edma_queues_id on the stack at
run time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index a38b88baadf2..1e401f42eef7 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10304,10 +10304,12 @@ static int gaudi2_memset_memory_chunk_using_edma_qm(struct hl_device *hdev,
 
 static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size, u64 val)
 {
-	u32 edma_queues_id[] = {GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0,
-					GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0,
-					GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0,
-					GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0};
+	static const u32 edma_queues_id[] = {
+		GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0,
+		GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0,
+		GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0,
+		GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0
+	};
 	u32 chunk_size, dcore, edma_idx, sob_offset, sob_addr, comp_val,
 		old_mmubp, mmubp, num_of_pkts, busy, pkt_size, cb_len;
 	u64 comp_addr, cur_addr = addr, end_addr = addr + size;
-- 
2.39.2



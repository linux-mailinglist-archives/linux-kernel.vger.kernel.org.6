Return-Path: <linux-kernel+bounces-354311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DDD993B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6CD1C23DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17B79C0;
	Tue,  8 Oct 2024 00:19:50 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8F20ED
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728346790; cv=none; b=bNhNKuY2NB2yH8pWByvwB9TBMKh6JI+VQgcU1FB21TJErfjCAAoFpnspLdNElFDLxMV4XqxyLCfK1fslFMRij94FhO/ec44Kb2f2oTJHXauLsXQ6AJzc2VNtYUTmD/BCLD5dxu4yQ81xSyqXhzGcnWWUAFM+GQ+Hmw9pXoqtoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728346790; c=relaxed/simple;
	bh=hYbpknmZv1Wf5kY87MzCjpa2/VIs0v7yv/FVVUOCUGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAR2ss02iGMaT9hHvBgTMFeWSNT41Ov5XfxNLBubcs44ekP7hYygENeXfapv3NEt+1WevQ8HVuT6KKm6WIgFsq3hc4fgrP7XxBlROVW2hDM+68Rg0IgEqS49fcwNByplZk7+ixWskVfnD1KYMj6omIIlcICW4UZ4XcQD7/l34Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c544d345cso837565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 17:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728346788; x=1728951588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHWxSRmAIq5y+t+Bsnw0e3+Xv51/57FXG9eUtKPq2dg=;
        b=HymiI2jLs/ZW5VzKABTFPR0mtmzjTI04GWsQu3bWTBqIw2/VrD7W8NNtfER+/EZTLr
         sMnYWymUFdPhbYITiB5ggKHwhrymsnRbf0qgxhYypl6e9w4mId/b7Be7OpE86bu1lti6
         QCneYiT6qDORkskOAXMAtI+fkQY0WMtEKw+J0IJekMRyKH4Hwdqc/QCbTa/FvNQIurbm
         TC5zM4o/C7GFPB9NBj4ae3tj4A/zt0RodUG68+ypSbj2jH5lk3hQbl3iGTfev47H4B0L
         lr3l5KD0/SI38SbIlBTejL0+5pBOv60XCllMg8h5/y/liZ64I6yXxXmQumlvT9w6pgO8
         tpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4YYd2apUaZBSo+F3cRtCmmxX0Fvwav3qMVTnDNvhrtC8eLBz7PTIDyUHnYpWubH6SOGqyt1+4k/Fm6TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEU8nrlTwpE0UzvY1c2u5HTkFCkM+72teSS3RkWy+RN9hbWZLs
	f4pnEY9RoP0znZ/N7iWILxv1ehKtFNBPP3GZFeQkzukz7VfbKJP2
X-Google-Smtp-Source: AGHT+IGEPV+q46O9fac0wxKhozafa0XGsZakH4+zUnU4jeFRpYv1WrbIiCUsH2PPprfZ0/21whVgTA==
X-Received: by 2002:a17:902:e745:b0:20b:6c1e:1e13 with SMTP id d9443c01a7336-20c4e357c4dmr22343035ad.23.1728346787792;
        Mon, 07 Oct 2024 17:19:47 -0700 (PDT)
Received: from snowbird.robot.car ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6821508sm5635942a12.31.2024.10.07.17.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 17:19:47 -0700 (PDT)
From: Dennis Zhou <dennis@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] percpu: fix data race with pcpu_nr_empty_pop_pages
Date: Mon,  7 Oct 2024 17:19:42 -0700
Message-ID: <20241008001942.8114-1-dennis@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the data race by moving the read to be behind the pcpu_lock. This
is okay because the code (initially) above it will not increase the
empty populated page count because it is populating backing pages that
already have allocations served out of them.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407191651.f24e499d-oliver.sang@intel.com
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 20d91af8c033..325fb8412e90 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1864,6 +1864,10 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 
 area_found:
 	pcpu_stats_area_alloc(chunk, size);
+
+	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
+		pcpu_schedule_balance_work();
+
 	spin_unlock_irqrestore(&pcpu_lock, flags);
 
 	/* populate if not all pages are already there */
@@ -1891,9 +1895,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
 
-	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
-		pcpu_schedule_balance_work();
-
 	/* clear the areas and return address relative to base address */
 	for_each_possible_cpu(cpu)
 		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);
-- 
2.43.0



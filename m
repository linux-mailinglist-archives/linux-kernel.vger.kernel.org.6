Return-Path: <linux-kernel+bounces-370476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D379A2D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72389284379
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32221BAF1;
	Thu, 17 Oct 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qo/APAmy"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002E21BAFB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192078; cv=none; b=daaVdtTG4ciJfZ5gR/Uc8Oa15L8QOiMfbm21bE5FG+fs/Z6d9dbCOD6sLge41rov35Q1JeJlLd7PtZuv+O7chj1OAYLUqzaA5f48Isleqvutafl6FEgUYsPz7XDNXK1dwLAVXb6BiZXpinAuZV+1gydeO0efjJc0dX1Fppah6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192078; c=relaxed/simple;
	bh=0zs08ErXNkXpJX2WEoQyflbtsloFifFAmEQMAAvOMqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gl64uzDwis7kFdaDUfQbR17LzlJsSwKJWnmIgkpxro8MmHwVhvehNrZUM4AVlpd4vpYpdaC5fGgVkhEuKp0NKSwSAFJaj6Fe1DYsnh6Fq2NvLgD4R9RHWu0tMB2eyR2iRbPg4x+v91k3r1BBezcHrK5mlq8riJw5WQtfzsAD4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qo/APAmy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso3881a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729192074; x=1729796874; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0EY2wO5j+yrOq4St7e0IMOZCqkDsHWJzH0T4sQWpz0=;
        b=Qo/APAmy6XUun/E3Y7rtPTY43Ri4iRBG+8lejVWGLJhix90vzOqR3yXQyzmbHOZnPK
         kPoalF/8zAjPSIbpq177YplbPNz4jAx1iSbQy11yZC4qH3m91Ct1/Q9g9DTrvNtfilyN
         pUbPRugnHlCdEW3JHRGHy2twV2NB36J3UJtJanqG0d81e7qaRwvK3+dZBUmn9qqHXp2u
         CN76tkph3oZzKjdeVn9nRPIpVj9aU9KW9Yx4QVRPVMce0tFKQrc+BxqfpjGpUu242q5c
         f2jDYPdYY4f3yfqZDFgotvzjXQUcAjYTHEXxD+L9mgo8AoO2f8SV7Jj1C2SatsUbt4Xv
         XGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192074; x=1729796874;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0EY2wO5j+yrOq4St7e0IMOZCqkDsHWJzH0T4sQWpz0=;
        b=Rg3hEDLPVcCBAfiEDuYRMXfVtgRPqp7r5X4rSBgzY2HSviwyfDt/xYgbUR5LH5EJ2m
         5jVjjBfmA/q/jXmN+teqzCyUYy3MpC8f+HikqDYmsp36FomThx65K+BzyGKpJK5vWv0O
         K5zoaK9yEex+491sQa/tYsPVzvk95o9rpN+hWFIlFjZl+PPS6sBkCCdL2QTXRVJ1ZT8X
         hTYatVr8NCo0zWJkBanCTOPGrA0y4n9qucfDKT7YtCzvugrLvcbzwzMBYD69YA1ZecAT
         3FtOF3K8udxXjyptCthbVVGrmZEmAK2SEy3/DG9vlH+cIBPsRCL+t3IzVUSS6LXKmQEY
         YRxA==
X-Gm-Message-State: AOJu0YxsXbogupbLx+o8lxv7b01S4n8keAwnucDue0zV0cH+ZSNDW0LR
	hOZI6WSxfaOdcmrAah85Oo4JjJj6riTum5EJniLnDhwBW2jfHiX5PfnUVU6vdQ==
X-Google-Smtp-Source: AGHT+IGamfn9nJtTlYJ9AGl6Um3+RxxEMMfWUXGMLx5wr6eC/3TynD7HD2K2u4khVsrr8dAPJsfKrw==
X-Received: by 2002:a05:6402:2789:b0:5c2:5641:af79 with SMTP id 4fb4d7f45d1cf-5ca0a101773mr69833a12.0.1729192073556;
        Thu, 17 Oct 2024 12:07:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:8198:1ef9:b40f:d133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e443ecsm1024295e9.34.2024.10.17.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:07:52 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 21:07:45 +0200
Subject: [PATCH v3] comedi: Flush partial mappings in error case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-comedi-tlb-v3-1-16b82f9372ce@google.com>
X-B4-Tracking: v=1; b=H4sIAIBgEWcC/22MQQ6CMBBFr0JmbU2nDGhdeQ/jgtIBmqA1LWk0h
 LtbWEni8v3892aIHBxHuBQzBE4uOv/MUB4KaIfm2bNwNjMoqQglkmj9g60T02gEyTzWlax0jZC
 FV+DOvbfY7Z55cHHy4bO1E67r30xCgYJMrTUSGSrP1977fuRj/sDaSerXrXauym7bdEayOlmrm
 527LMsXW75krOEAAAA=
To: Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Frank Mori Hess <fmh6jj@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729192068; l=2056;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=0zs08ErXNkXpJX2WEoQyflbtsloFifFAmEQMAAvOMqY=;
 b=0tICpoQWdXydeEYW0viSsSNmigbCw5f3m1lWG2JtSKX+UdRcXkNdBSh4jb2lKFRbS6UWbpAJI
 GnFrLEfEbJWAW53/nQ0bqb5fX24h6Xre4ZuXFPQoLnYRffvy2hvevea
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If some remap_pfn_range() calls succeeded before one failed, we still have
buffer pages mapped into the userspace page tables when we drop the buffer
reference with comedi_buf_map_put(bm). The userspace mappings are only
cleaned up later in the mmap error path.

Fix it by explicitly flushing all mappings in our VMA on the error path.

See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
error case").

Cc: stable@vger.kernel.org
Fixes: ed9eccbe8970 ("Staging: add comedi core")
Signed-off-by: Jann Horn <jannh@google.com>
---
Note: compile-tested only; I don't actually have comedi hardware, and I
don't know anything about comedi.
---
Changes in v3:
- gate zapping ptes on CONFIG_MMU (Intel kernel test robot)
- Link to v2: https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com

Changes in v2:
- only do the zapping in the pfnmap path (Ian Abbott)
- use zap_vma_ptes() instead of zap_page_range_single() (Ian Abbott)
- Link to v1: https://lore.kernel.org/r/20241014-comedi-tlb-v1-1-4b699144b438@google.com
---
 drivers/comedi/comedi_fops.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 1b481731df96..b9df9b19d4bd 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -2407,6 +2407,18 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
 
 			start += PAGE_SIZE;
 		}
+
+#ifdef CONFIG_MMU
+		/*
+		 * Leaving behind a partial mapping of a buffer we're about to
+		 * drop is unsafe, see remap_pfn_range_notrack().
+		 * We need to zap the range here ourselves instead of relying
+		 * on the automatic zapping in remap_pfn_range() because we call
+		 * remap_pfn_range() in a loop.
+		 */
+		if (retval)
+			zap_vma_ptes(vma, vma->vm_start, size);
+#endif
 	}
 
 	if (retval == 0) {

---
base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
change-id: 20241014-comedi-tlb-400246505961
-- 
Jann Horn <jannh@google.com>



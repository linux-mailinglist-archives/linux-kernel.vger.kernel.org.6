Return-Path: <linux-kernel+bounces-187886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3E8CDA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE30F28183B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8982D69;
	Thu, 23 May 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FSVBIdPu"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F34F602
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489387; cv=none; b=Oc2mo0gItCJpSLiCHt38emwjCdlzo2V0VdLb8lu0gMC9/zfQxJwGt2RpRC1IyAWrGt01MGLXzGMjKou3XNa0Mw3LvbnLntJv7m/PgUlNePlJ01FIBQRlvFmsFd/b/frBxvdi1ZO9MquS7znfFCRk2ELd9tApd2x2gCAS+gXCdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489387; c=relaxed/simple;
	bh=OgXMrbQw5esj3pNjQhcGzhpumWC39Xp2gTHLG8/BMdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwvKB74pSOVzkifVCZ3CPpPd3r4HjSoHJwNvoKWYlZjHj7XBdyPO0XKvCwpYVYY+4hz6kudqBTAGDjNGgkCclTldM61Be32wIQUC/rOc8yOk1nQuPI0C2kDLerMoMWOKPc87v4c4dxKOlE48riLMjHVS/auIEcv8TY1EpsiQ4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FSVBIdPu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f8f34cb0beso3272b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1716489384; x=1717094184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz+q3u/Fp0102KdTBvg4J3ovItadDXTAdO5aV1qWmSo=;
        b=FSVBIdPuRIIL4vrbmVyp1D/Mb9Jh1aH/4h4pDNRlKAHY+OqlEZmsg4a869XIhDS0yz
         Vhkm5mHaBgBDKjMMCShDO5ONlZY0cIvoD4+RFXHAT8wOgb0gI5xEE86ZjXDTiJgOAYJq
         FTG6Ncp4tC6LbOs5ql361CqAWIyy1wjeuxS3ZcalgOF67z+wjnb1gHKWw6C6/8UmZhwV
         u8xUWlEW/3CdtEjaR5GPKu0Hc8r1BjEnE2btsz7Y8+OIwpCde3cYq0qbFjfnHMZnRicK
         9BgxPqoFBF1XBmE1L/LHFxjMX40ZLZ47FXDdjVui/OJa+nZTutkYkQlW7DPQzFw5UjmB
         hbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489384; x=1717094184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qz+q3u/Fp0102KdTBvg4J3ovItadDXTAdO5aV1qWmSo=;
        b=JONM0BWaH3L6e94UbhPde5dn+K3jvUcTPMu4nI1rKXYPtfoX7qXs+fDI425FCNaQH/
         66cA2fn40/Qx8epXahUGR79vEh+WVkAO3GnUNCrP3EKq12ykCQw6cY65VwbQzYv9GkX6
         9a2kpIUwAMVDeFEvuLFNrG5fwI3aFx+srgKY6U9wsJd3tbXNohEUMt65H+zneMWgGBbJ
         TPAcGCQOVb3liqwZ6Zvj7uBZ3PGaJquaMiTKS37qlBAF4swgGigkjhqBPii7BRUa2Kwc
         iVWGCRA/wIFaKUvILKETRwZ/AXo7yhImeKEx4pJR3QYKqnFTPeUXfH24XiFwXy2UabsA
         UlCg==
X-Gm-Message-State: AOJu0Yy+hLdE+O6tXNAYp/RLiK0yWz+Nzvap1aTUeK6NkTAm/2PoRmJC
	mq9AiqY0RtXxm0oZ3MFqgwBE/zMGqh5CGXnPHt5er5lE37gBfXM2Zu4ypHjW84s=
X-Google-Smtp-Source: AGHT+IFUTsvXDTrQxXlh03uhTPfPZ/be+kqFgGy/t90jRL6U9LRtWnJ8XOVcA+NlDeCpNMF8onOypQ==
X-Received: by 2002:a17:902:6505:b0:1f3:2f9c:bb72 with SMTP id d9443c01a7336-1f448125a9bmr3155455ad.5.1716489384110;
        Thu, 23 May 2024 11:36:24 -0700 (PDT)
Received: from dev-yzhong.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f303b062e5sm71161015ad.219.2024.05.23.11.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 11:36:23 -0700 (PDT)
From: Yuanyuan Zhong <yzhong@purestorage.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after getting mmap_lock again
Date: Thu, 23 May 2024 12:35:31 -0600
Message-Id: <20240523183531.2535436-1-yzhong@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After switching smaps_rollup to use VMA iterator, searching for next
entry is part of the condition expression of the do-while loop. So the
current VMA needs to be addressed before the continue statement.

Fixes: c4c84f06285e ("fs/proc/task_mmu: stop using linked list and highest_vm_end")
Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 fs/proc/task_mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e5a5f015ff03..f8d35f993fe5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -970,12 +970,17 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 				break;
 
 			/* Case 1 and 2 above */
-			if (vma->vm_start >= last_vma_end)
+			if (vma->vm_start >= last_vma_end) {
+				smap_gather_stats(vma, &mss, 0);
+				last_vma_end = vma->vm_end;
 				continue;
+			}
 
 			/* Case 4 above */
-			if (vma->vm_end > last_vma_end)
+			if (vma->vm_end > last_vma_end) {
 				smap_gather_stats(vma, &mss, last_vma_end);
+				last_vma_end = vma->vm_end;
+			}
 		}
 	} for_each_vma(vmi, vma);
 
-- 
2.34.1



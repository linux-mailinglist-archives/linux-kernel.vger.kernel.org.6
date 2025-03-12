Return-Path: <linux-kernel+bounces-557931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8529A5DF75
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB9D18975D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD7C1E5B7C;
	Wed, 12 Mar 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrDPnV8J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E42033A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791100; cv=none; b=T/HYZYFTB4lwU4SgFUJCh1zMqSwihTnBc+VQsf38sspZm0Qrh9dpkFFeKVSk1IetNYNBcIcbr1X4We1u/SZl3BYniaSWlqXA+wlEnq9aw/nNMmgPa//pokJvm8AexgYakkRyETltXhH96BAeteflBiVg4td7N5wVve0X6//aYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791100; c=relaxed/simple;
	bh=JqS8CbFG98vGYZPOc1OBSSPlVJRCWiANSlVO/O6Oh9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S28StNAU7e7WtVAFSv6SyARCjFQSPxYpXibgbvt6UndLrf27bP58u2Vu2WrfiaGs5u7IkDjnOEnhTR9jYhWO2RttUS0Ou6LR/vMMlh7QsLCMmPQAd7f78uxAvYWsWlbeihGITzNdp7WtGKmoF2zq+05K488bEtjznXbCUGlyYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrDPnV8J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741791097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yKAxRE4cpEVReAVBfRWToeyYUILhM0htuYiSpO0zMq4=;
	b=KrDPnV8J3jifJFr+48Q6I3e9qi7J4YchQOKjqEgJp8v7hozlEdsmKRAZX2pIG8brDqOmHl
	2RPHd0aMXXW44YJFzahsLFqyXk0h17vDbsfltyRdh1MhnSkrIyZUDcXKNptvVFtVVlYvGw
	CjNxz1gtqS5FZT01Sgcoq6ceLWFkeTI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-JBL7dfauMSa41Rglu0-wOg-1; Wed, 12 Mar 2025 10:51:36 -0400
X-MC-Unique: JBL7dfauMSa41Rglu0-wOg-1
X-Mimecast-MFC-AGG-ID: JBL7dfauMSa41Rglu0-wOg_1741791096
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4767348e239so83399971cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741791095; x=1742395895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKAxRE4cpEVReAVBfRWToeyYUILhM0htuYiSpO0zMq4=;
        b=tcf+DaysW/PvxtKse5ypjz7cOjsYpJBpFpppDgsFmFxkJuVYW+dpt+ZbWOIAzlliwQ
         WJV+Mh+/r9iHcIuuyWwZXit3QQAZpd0hfZqLXGIII+6MlXwc3Tx/9QmmvZflvdsC8nRf
         7bPQkFEmYAKgZxmoDNrLBkAKuo6M1pqzeNzpJ4cFrytObDS1+jo92M7+FwHf/5We9Ryq
         EFTUFPhHZAv8gXYOtRgACRtK5tZTmSmV8NSCLCTW7UqHy811bt84Sn6FdOtA2Y2u9NHg
         Vf2kRplCTXaibAmSqrBRsPvzfNyyxCF6JBZ4nYqcMK7XNY737iNc3k2HDFoL9CHIAY2H
         Z9XQ==
X-Gm-Message-State: AOJu0YxAgk2US2vld+l1AplGyXqzILt2IYi/UtxjiQN9CgUW5+2L/mR/
	siWMaUS3G0eEdJKjecZaJ5abceMyZyzJaOKLOSjkyRVc1JIdmHD4aVoe+bePDyh1pLD5e1mnLAE
	Db5aROnk8beiu/THJKlwhq0wXTPvjDXhViq67WLfv1n/G6U74LU5+OPO3kdLCxnnN+XZa80mz4y
	4YF4lxh72Gi6CGVg85Jq5xq6myhsNu1rkTKY5BdH/Wp9g=
X-Gm-Gg: ASbGncvAmBfNx67w8v8g3Bq+iJWzjDqC4x6BLrQGjO1l0wQohKjkprssAFy9qAR32+5
	rxl59ouXkm2cTXkvRaYxE7St9uvg/+WQTpzfYVJuhsCwQBGCNMbAqaHMRn8qgkf+9NNPj98Gzno
	DZArzO148m1/pMMfaVBeOuNWp39nzSNAticKG/WAPJWqVi/uTP074yHr2V2KYeSeoiK8ykWQO/W
	nrO3hukO+bUVRZqPMqnxaO5ipLGO05m+W2qcD9r4N8d9luMUgX/9imXQHs7Xw1451brxV1HevP0
	0wiU
X-Received: by 2002:a05:622a:355:b0:476:6215:eafc with SMTP id d75a77b69052e-47699502529mr104046081cf.22.1741791095674;
        Wed, 12 Mar 2025 07:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7uhKZcz1zhEaWhyp/OH/LmrbsvVXXd2Il8QyoPaX0rwx04CgVoOuAopMHTDzurW2U5mJAXw==
X-Received: by 2002:a05:622a:355:b0:476:6215:eafc with SMTP id d75a77b69052e-47699502529mr104045581cf.22.1741791095226;
        Wed, 12 Mar 2025 07:51:35 -0700 (PDT)
Received: from x1.com ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476ae289d35sm9367941cf.17.2025.03.12.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:51:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: peterx@redhat.com,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Pavel Emelyanov <xemul@virtuozzo.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] mm/userfaultfd: Fix release hang over concurrent GUP
Date: Wed, 12 Mar 2025 10:51:31 -0400
Message-ID: <20250312145131.1143062-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch should fix a possible userfaultfd release() hang during
concurrent GUP.

This problem was initially reported by Dimitris Siakavaras in July 2023 [1]
in a firecracker use case.  Firecracker has a separate process handling
page faults remotely, and when the process releases the userfaultfd it can
race with a concurrent GUP from KVM trying to fault in a guest page during
the secondary MMU page fault process.

A similar problem was reported recently again by Jinjiang Tu in March 2025
[2], even though the race happened this time with a mlockall() operation,
which does GUP in a similar fashion.

In 2017, commit 656710a60e36 ("userfaultfd: non-cooperative: closing the
uffd without triggering SIGBUS") was trying to fix this issue.  AFAIU, that
fixes well the fault paths but may not work yet for GUP.  In GUP, the issue
is NOPAGE will be almost treated the same as "page fault resolved" in
faultin_page(), then the GUP will follow page again, seeing page missing,
and it'll keep going into a live lock situation as reported.

This change makes core mm return RETRY instead of NOPAGE for both the GUP
and fault paths, proactively releasing the mmap read lock.  This should
guarantee the other release thread make progress on taking the write lock
and avoid the live lock even for GUP.

When at it, rearrange the comments to make sure it's uptodate.

[1] https://lore.kernel.org/r/79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr
[2] https://lore.kernel.org/r/20250307072133.3522652-1-tujinjiang@huawei.com

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 97c4d71115d8..d80f94346199 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -395,32 +395,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
 		goto out;
 
-	/*
-	 * If it's already released don't get it. This avoids to loop
-	 * in __get_user_pages if userfaultfd_release waits on the
-	 * caller of handle_userfault to release the mmap_lock.
-	 */
-	if (unlikely(READ_ONCE(ctx->released))) {
-		/*
-		 * Don't return VM_FAULT_SIGBUS in this case, so a non
-		 * cooperative manager can close the uffd after the
-		 * last UFFDIO_COPY, without risking to trigger an
-		 * involuntary SIGBUS if the process was starting the
-		 * userfaultfd while the userfaultfd was still armed
-		 * (but after the last UFFDIO_COPY). If the uffd
-		 * wasn't already closed when the userfault reached
-		 * this point, that would normally be solved by
-		 * userfaultfd_must_wait returning 'false'.
-		 *
-		 * If we were to return VM_FAULT_SIGBUS here, the non
-		 * cooperative manager would be instead forced to
-		 * always call UFFDIO_UNREGISTER before it can safely
-		 * close the uffd.
-		 */
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
 	/*
 	 * Check that we can return VM_FAULT_RETRY.
 	 *
@@ -457,6 +431,31 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
 		goto out;
 
+	if (unlikely(READ_ONCE(ctx->released))) {
+		/*
+		 * If a concurrent release is detected, do not return
+		 * VM_FAULT_SIGBUS or VM_FAULT_NOPAGE, but instead always
+		 * return VM_FAULT_RETRY with lock released proactively.
+		 *
+		 * If we were to return VM_FAULT_SIGBUS here, the non
+		 * cooperative manager would be instead forced to
+		 * always call UFFDIO_UNREGISTER before it can safely
+		 * close the uffd, to avoid involuntary SIGBUS triggered.
+		 *
+		 * If we were to return VM_FAULT_NOPAGE, it would work for
+		 * the fault path, in which the lock will be released
+		 * later.  However for GUP, faultin_page() does nothing
+		 * special on NOPAGE, so GUP would spin retrying without
+		 * releasing the mmap read lock, causing possible livelock.
+		 *
+		 * Here only VM_FAULT_RETRY would make sure the mmap lock
+		 * be released immediately, so that the thread concurrently
+		 * releasing the userfault would always make progress.
+		 */
+		release_fault_lock(vmf);
+		goto out;
+	}
+
 	/* take the reference before dropping the mmap_lock */
 	userfaultfd_ctx_get(ctx);
 
-- 
2.47.0



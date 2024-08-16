Return-Path: <linux-kernel+bounces-288828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C1953F34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4809B1C21371
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3152A3BBF0;
	Fri, 16 Aug 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ENufe4NX"
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA11EA91
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773617; cv=none; b=KwqHetxPcY5nENTjJz3zhAknUBqjMYco5AbN1K5M8TDox+kd45TvjAs4S9wvJo87vnfQpViLWWpfkpWdQ6mPYSeQFZVSuSrxpRIZcl/w/dUKvljmwu78IiN4sxY+zn5A6NQCRxhMoMXcjwJGDye1qBEe7GW+BT70t7NBKoYaDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773617; c=relaxed/simple;
	bh=cDbUxhLghKRwQjhhyye/0uvMgHqwGM+UZdmfKqCKMII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+U6KrVMyQlYVTeDDwY3SfcQ0n8lsEllu0Gm01MsPjd3rq6AxKAPa9bhPrTQXsfbmbFrQr47H5Phcq0t8jrOzqFDehQZ2+OBd/AWT4v67Gu1UEoDRlOo4PLieRQomSHJhqJcRSad3kpCtaTi5JgSxddx+q+cpeErISAuBTJBtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ENufe4NX; arc=none smtp.client-ip=140.205.0.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723773612; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LWI9UQJ/pky4HAg7t6kPtQh05UbFRBIY+bNweOhhjQc=;
	b=ENufe4NX0ajkWpUG2Y1SQAvCSSRaDw8iku+l1k+scMv8lySKlz4HCwyHJjW83woKHNNn6in1yr7W56GauJbD/tnAMhjxI06dI/YOWFHb7W3GxwA23tMUHJv4iIv1SUOByY8QLJ7cFe+ZueEKIdFVq2Tm23uQNWJmVNlyxC2yzak=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBojH_1723773296)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/6] um: Remove the redundant newpage check in update_pte_range
Date: Fri, 16 Aug 2024 09:54:43 +0800
Message-Id: <20240816015447.320394-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two checks have been identical since commit ef714f15027c ("um:
remove force_flush_all from fork_handler"). And the inner one isn't
necessary anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/tlb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 44c6fc697f3a..dddbc473baa7 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -82,16 +82,13 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 			(x ? UM_PROT_EXEC : 0));
 		if (pte_newpage(*pte)) {
 			if (pte_present(*pte)) {
-				if (pte_newpage(*pte)) {
-					__u64 offset;
-					unsigned long phys =
-						pte_val(*pte) & PAGE_MASK;
-					int fd =  phys_mapping(phys, &offset);
-
-					ret = ops->mmap(ops->mm_idp, addr,
-							PAGE_SIZE, prot, fd,
-							offset);
-				}
+				__u64 offset;
+				unsigned long phys = pte_val(*pte) & PAGE_MASK;
+				int fd = phys_mapping(phys, &offset);
+
+				ret = ops->mmap(ops->mm_idp, addr,
+						PAGE_SIZE, prot, fd,
+						offset);
 			} else
 				ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
 		} else if (pte_newprot(*pte))
-- 
2.34.1



Return-Path: <linux-kernel+bounces-289453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511A2954660
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB543B23B41
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13F177982;
	Fri, 16 Aug 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="xPi7Vj3j"
Received: from out187-18.us.a.mail.aliyun.com (out187-18.us.a.mail.aliyun.com [47.90.187.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08C16F85B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802418; cv=none; b=rda/OGybUWcKzIxZdsOLOl9ikTR4cCxLss/XHUTFOXZn79yhDj69OHVjBtHvOxpSPerOpjm/tHdUtxTdyRBBLPrXfg+WmAeluMkBYGQQvuHgiJ6jsB6/3qrBvwm3hLJqTLLtQQtzkcQznghnIIy0FvjQ1wLKdxsK3It0SDRcbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802418; c=relaxed/simple;
	bh=vrr0pFgKlFH8zr7+GGp+kmqkEdG880bRycdUnGqf6EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8cw3E2Xq0Vbjg462WW5hrsyn1mA+P42hwob0niygBaSUQJFrBxum4bNFgWXDWnrev84pCeQRE6AdPnF6wjd4ozUABK6FODm0Yr0eEWG47Qq9UMgykq00M0hI4xqDumfklFFk+zTUUwYn/OvrBg9Uhkyc6LTeIsFGEc8QXJ3PkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=xPi7Vj3j; arc=none smtp.client-ip=47.90.187.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802404; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jo0r7PE2P21mYE53WxHNzNjxHnLxdNhP0Cu28IOO4aU=;
	b=xPi7Vj3jFV1eOeindJKlymWpzZI37w83WwzgR3pLdce5jDJfkIVu7ggVyjhKa6SQ73yn2wO+kld85ZQcIPlHPmHZ7KJlZ4Edck+JUfb6T47Go1cbhLHvRMGODiZwujbsEaUWc7F9mdV+6YoH5h8uUcxdanMgimLNuvPaGswBxA8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE5W_1723802403)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:03 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 2/6] um: Remove the redundant newpage check in update_pte_range
Date: Fri, 16 Aug 2024 17:59:49 +0800
Message-Id: <20240816095953.638401-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
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
 arch/um/kernel/tlb.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 44c6fc697f3a..548af31d4111 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -82,16 +82,12 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
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
+				ret = ops->mmap(ops->mm_idp, addr, PAGE_SIZE,
+						prot, fd, offset);
 			} else
 				ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
 		} else if (pte_newprot(*pte))
-- 
2.34.1



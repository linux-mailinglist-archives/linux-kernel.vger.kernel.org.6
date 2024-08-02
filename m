Return-Path: <linux-kernel+bounces-272153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8838D9457E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43199283427
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18A2AE7C;
	Fri,  2 Aug 2024 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ruoI7wUh"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB822C9D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578543; cv=none; b=bBNxWc1cP575RrIRDF2mlPR1aZjLLL01NN0ucmYmR8raBcwgFugCtUMHR2lq8BU6eI/iYDIVCw1sZllN+QTlrIi1OcgsyjiGHsp4ShRSwvrx1e6bpusSxnMBrro1vY3PxTAAQWtNASNDBAygUBR/7/n/2o4wFEABdcyFjvWslh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578543; c=relaxed/simple;
	bh=rnOEnHj57Ecps6WpxKy8K22emS/RfPrsaFXxhwwr3i8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GakGz4tRpfyK4/6tQlBpjegllf/4K6GOIrypN4adzNtT8qTOJekSk8bzEKXcRoThiJEsM7OI0FWaQlPeGaC8kGaS6/rLRGDOYx/tBNlew+NmL6L7p7DP9rXyA2FADh8AemEsqQGVREmJIwKcMC0LWyCZF0yuRrgMpyMyT37V4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ruoI7wUh; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722578538; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SU+iX0NwO6z83LjebT3mt5E8i41UAjpbw3d1tOz7gCY=;
	b=ruoI7wUhF+jrM8BX/WRnXjwy1FEEjtMzTn8ZWlHZDlLaAfgFeyZgoxadx0P17TRLHCyRkbYjv2069XS8iHVvy9j8reW0UB8T0nkvwBkuOKanEa1FCSRK/Zs1b+VS+TkO62fzkxM6XDpDleAf292XquZrtQoozLg5EHtUxfG/OT4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WBwGAMB_1722578537;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WBwGAMB_1722578537)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 14:02:17 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm: Remove duplicated include in vma_internal.h
Date: Fri,  2 Aug 2024 14:02:16 +0800
Message-Id: <20240802060216.24591-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files linux/bug.h is included twice in vma_internal.h,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9636
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/vma_internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index 14c24d5cb582..b930ab12a587 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -12,7 +12,6 @@
 #include <linux/backing-dev.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
-#include <linux/bug.h>
 #include <linux/cacheflush.h>
 #include <linux/err.h>
 #include <linux/file.h>
-- 
2.32.0.3.g01195cf9f



Return-Path: <linux-kernel+bounces-196737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94718D60BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8B31C24028
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DEB157488;
	Fri, 31 May 2024 11:32:12 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A0155C87
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155131; cv=none; b=Yb2bdgWK1tD9siMl/bq8l11zKZFLzFZupct+RX/+FBkwezUjEUpOr8k+YWTy9prVvmNqz0tboRzenAPZqRCqJY7mfFIeHtFsP6plSpWO/gLycIwOTqIPOtdQDfCfXHeLiTB9paFBkV9jwSx9lYRlAJFGJPI0My7Sdd8L8w1fII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155131; c=relaxed/simple;
	bh=W97XgZ013twIobtXTwIaYlD+FlPJM3ZrqLVVtcPYlB8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RegEPevXOMXLpUaVNeFuhg+6v1u51fpRtCZVYfoGTejhP3mIAbjgdM3Xj9MiP8Z41ejZJBlA825LmFrmWgjFXXm3I/01/Iu5Tkxfbs8b2zjy5Xa3FGNg9FU1qyQjTm23Eeb/jOrROd4vWa143k590mGCrA+woyTRFcxMdOJCKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44VBVSdt090530;
	Fri, 31 May 2024 19:31:28 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VrLSp0x3kz2QN5wn;
	Fri, 31 May 2024 19:27:38 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 31 May 2024 19:31:27 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <axboe@kernel.dk>
CC: <bvanassche@acm.org>, <dlemoal@kernel.org>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH] block: uapi: Fix compliation warning of using IOPRIO_PRIO_DATA
Date: Fri, 31 May 2024 19:31:11 +0800
Message-ID: <1717155071-20409-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 44VBVSdt090530

Generally, the input of IOPRIO_PRIO_DATA has 16 bits. If use format "%d"
to printk IOPRIO_PRIO_DATA, there will be the following warning or error.

fs/f2fs/sysfs.c:348:31: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
   return sysfs_emit(buf, "%s,%d\n",
                              ~^
                              %ld

This is because the output of IOPRIO_PRIO_DATA is converted to "UL" from
IOPRIO_PRIO_MASK, which is not reasonable. unsigned int is more suitable.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 include/uapi/linux/ioprio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0..9ead07f 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -11,7 +11,7 @@
 #define IOPRIO_CLASS_SHIFT	13
 #define IOPRIO_NR_CLASSES	8
 #define IOPRIO_CLASS_MASK	(IOPRIO_NR_CLASSES - 1)
-#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
+#define IOPRIO_PRIO_MASK	((1U << IOPRIO_CLASS_SHIFT) - 1)
 
 #define IOPRIO_PRIO_CLASS(ioprio)	\
 	(((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
-- 
1.9.1



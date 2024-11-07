Return-Path: <linux-kernel+bounces-399107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514309BFB21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08ECF1F226EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E8E2CA9;
	Thu,  7 Nov 2024 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OnbRl181"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0D944E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941393; cv=none; b=J74muIbvaJXAWnZzb3iBKDNNnCAGWEMWohAZSzJptcnEL5FqhYEEprQ1s1igT+mAHjuraahxzgIimxqpbSfNH67Xb3LdZv/eHdjBADiWYaS4TOzIGkQbYmiACYPSe/uhj+B3KeRnst4/dJWncE85hXTGc42Hx9KXVW4hnZzKI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941393; c=relaxed/simple;
	bh=ujxv6AVqlgiwJ11L4xJcYK9eyf7odIV2YvlYms/8vuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eddMUvaeFKEf3o50A3wUh+gGRA9m06o53oVUlxnaHQuOc1sLR5KxMhQz/hA9I1eBjfkxq4DqZH3oBPdfSGbD9K5aMaw0DfIJdZP7WbvxvAltznzZk04jnCQa8BUhrPJBU+sqBJJvdYYOUE6+d91RgBKSVPVl/aOUF6le78kMlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OnbRl181; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730941381; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=v0DVufawgn8EOdvVe8gSpxcdjOljGbR43bLm6y9/QKo=;
	b=OnbRl181mSVky4poEbu4rqKuzaKVVgJpEslv5UVXwOPAUETYvo84Y0ed3rSEjpxqtEXDNvQ8MOQB2S2TDl5VGSIiRSeQ5lObgsMjGcgfw5RUMyF3av/ZvIG7uosk3BaYzs/kvXUrjL2jiuZ+SC+XiCxKyghWbGA2MAwqq8i8SY8=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WItWykL_1730941380 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 09:03:01 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] powerpc/machdep: Remove duplicated include in svm.c
Date: Thu,  7 Nov 2024 09:02:59 +0800
Message-Id: <20241107010259.46308-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files linux/mem_encrypt.h is included twice in svm.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11750
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/platforms/pseries/svm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index c5d0f92c7969..384c9dc1899a 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -10,7 +10,6 @@
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
-#include <linux/mem_encrypt.h>
 #include <asm/machdep.h>
 #include <asm/svm.h>
 #include <asm/swiotlb.h>
-- 
2.32.0.3.g01195cf9f



Return-Path: <linux-kernel+bounces-329082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9D978D0E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2C1F25F04
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D111758E;
	Sat, 14 Sep 2024 03:13:09 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAB17BA2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283589; cv=none; b=dur5agoH0XO8yvKoJcFuyKxYr55ihMiAjfaHt2lqOsaey5fF2eO1ucviGovNQdqmJC5tGs7kWgE/+VGw7Ksat+DZk5bWRtQ146eLwtMduXGLgSML4ObERSxqeSO+9r03YqaTJyETUw78vsBWGeW9XTK9XYwmCow0qCsfBaMw3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283589; c=relaxed/simple;
	bh=eFzergyr9CHVtmYSpVbh4M7inxyMIwlG9sQsDx8D+c8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwB8ArUfylYbjzncVCvXC5mRjUjUX16jEdK8wPIY91FsFOS2hXRji8Kv0WPI+AYJSlWLcUlE5cuBC29tbrPw4HiW/c4pCZQScvVovtwRca379+fC5gcOzaDYjtUqU2DU3D+FKCDfL1TrU9b3fSWZMeFlOggy1TQqsTIGC07QYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 48E3D2s3003632
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:13:02 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48E3CH60000371;
	Sat, 14 Sep 2024 11:12:17 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4X5GHq16q2z2Nk1dW;
	Sat, 14 Sep 2024 11:04:55 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Sat, 14 Sep 2024 11:12:14 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>, <xiuhong.wang@unisoc.com>
Subject: [PATCH] f2fs-toos: use getpagesize() to get default blocksize in Android
Date: Sat, 14 Sep 2024 11:11:47 +0800
Message-ID: <1726283507-16611-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 48E3CH60000371

When 16K page/block size is enabled in Android platform,
a error maybe detected in mount process in kernel if "-b"
parameters is not specified in mkfs.f2fs.
Just as the following check:
if (le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE_BITS)

So use getpagesize() to get correct default blocksize.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
---
 lib/libf2fs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index ecd22d4..98ee0ae 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -685,8 +685,17 @@ void f2fs_init_configuration(void)
 
 	memset(&c, 0, sizeof(struct f2fs_configuration));
 	c.ndevs = 1;
+#ifdef WITH_ANDROID
+	c.blksize = getpagesize();
+	c.blksize_bits = log_base_2(c.blksize);
+	if ((1 << c.blksize_bits) != c.blksize) {
+		c.blksize = 1 << DEFAULT_BLKSIZE_BITS;
+		c.blksize_bits = DEFAULT_BLKSIZE_BITS;
+	}
+#else
 	c.blksize = 1 << DEFAULT_BLKSIZE_BITS;
 	c.blksize_bits = DEFAULT_BLKSIZE_BITS;
+#endif
 	c.sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
 	c.blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
 	c.wanted_total_sectors = -1;
-- 
1.9.1



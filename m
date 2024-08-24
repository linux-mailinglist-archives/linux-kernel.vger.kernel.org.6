Return-Path: <linux-kernel+bounces-300003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91495DD70
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27FA81F21DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A131155747;
	Sat, 24 Aug 2024 11:05:25 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B614F136
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724497525; cv=none; b=libnZ1ReCeVSwRLeCszbIUduwKhpar6lCe6q9a7eBUz+lzxathdy1IEeEDkYrJ+7rB7KNxuaynCnEcqkDwI5pXBDh8cPpKpX0arqCMO3d7hmSY+kFlHAxoqxTkIQnZh2no4peOSXYsDgQzypplqy2hAzi1cJno9amdHPCLnDlO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724497525; c=relaxed/simple;
	bh=Q+1TT7PEhlKksOg4sQDaz9blZBjApqBf7CRLlM/Ns6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQWEnEULEV4oduZxp0RYnurFOQHJJPlbFcqim39zWslveXdRzOPA9EceYTi0RsWJdLB6V1uRAzKx1fC+/KVRkcs1DqzhV5y2X4jOqyvikcm+lwdPLDsx0k6T5pVvJsP8dkBEN0jgUQCowki9G8anBKaoJie0enJoaQQfMzHt7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WrYwP0vScz13wB7;
	Sat, 24 Aug 2024 19:04:05 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BADC1800D2;
	Sat, 24 Aug 2024 19:04:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 24 Aug
 2024 19:04:47 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>
CC: <lizetao1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] arm64: enable ARCH_SUPPORTS_KEXEC_SIG_FORCE for arm64
Date: Sat, 24 Aug 2024 19:12:34 +0800
Message-ID: <20240824111234.2216355-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

When the CONFIG_KEXEC_SIG is enabled, an illegal image is loaded through
kexec, and the illegal image is successfully loaded. The test example is
as follows:

  # cat /sys/kernel/kexec_loaded
  0
  # kexec -s -l ./Image.illegal_signature
  # echo $?
  0
  # dmesg | tail
  PEFILE: Digest mismatch
  # cat /sys/kernel/kexec_loaded
  1

The root cause of this problem is that CONFIG_KEXEC_SIG_FORCE is not
enabled. Solve this problem by enabling the ARCH_SUPPORTS_KEXEC_SIG_FORCE
feature.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..9952c40a2bd8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1549,6 +1549,9 @@ config ARCH_SELECTS_KEXEC_FILE
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool y
 
+config ARCH_SUPPORTS_KEXEC_SIG_FORCE
+	def_bool y
+
 config ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
 	def_bool y
 
-- 
2.34.1



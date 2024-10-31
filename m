Return-Path: <linux-kernel+bounces-389904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D139B72AF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6FD1F25019
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F5584E11;
	Thu, 31 Oct 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WwvXTiqS"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964D1BD9EA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730343645; cv=none; b=RXLTL7/BKZWo067MlV36BE9xg8OP6GzD4PXVuINCfQ9LaafOidyzEBjEZUKEF/cgdd/G1A6tCH3y/rLYmORTouDTEV5o5MPuZ/CLxoxo2X/JPUZPJQwDB12osyxXUasjer0MdTCIR6g+xydIwSciM/d85rmQyn+YuaTPH36skGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730343645; c=relaxed/simple;
	bh=/Sw+z/80Lzo23kTe7rNa+WZZNcm0tePGE2zpNFb9PUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mAcoTo5t62GciBSWTWIVV+xstNH6RyEZeNcj23zGIbAcTaFSHFdZ3aH04G9kc7+l3K16kxsc+IudeOwHlphdGz3+4/vCnO+j5WkU1I8V2RzA3gm1DKHH9dNIIQCQDlG+q/uzpxVPWDcI3pjjqLm9N8kxu+N5gjjXGzpR/ou5CZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WwvXTiqS; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730343630; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KihwTcXniMbyEQE4I1zarxhI+C9GMZdwYjrvSYvYi+0=;
	b=WwvXTiqSzNcow490nSrd+C4VtUzwZ46iNEgag8CzNr3dK983l2qlhyNZfRHT9V1c7Nzxk6x65q78kZyI7sXRt1QKzkoEAYOvzCJupcO3lKu7qFecpFSgWF7CfFpwY5P9f8Vac9ZTuGv5duXh/RPIw4z0mfqQ4B5tW9fUImscpbc=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WIGhwJy_1730343625 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 11:00:30 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: hughd@google.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm: shmem: Fix an incorrect type in shmem_parse_opt_casefold()
Date: Thu, 31 Oct 2024 11:00:25 +0800
Message-Id: <20241031030025.32217-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from the call to utf8_parse_version() is int.
However, the return value is being assigned to an unsiged int
variable 'version', so making 'version' an int.

./mm/shmem.c:4368:6-13: WARNING: Unsigned expression compared with zero: version < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11587
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3560188fe329..a1835f528581 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4355,7 +4355,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 				    bool latest_version)
 {
 	struct shmem_options *ctx = fc->fs_private;
-	unsigned int version = UTF8_LATEST;
+	int version = UTF8_LATEST;
 	struct unicode_map *encoding;
 	char *version_str = param->string + 5;
 
-- 
2.32.0.3.g01195cf9f



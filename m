Return-Path: <linux-kernel+bounces-367886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7C9A07FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C821F229CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F633207200;
	Wed, 16 Oct 2024 11:03:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84920605B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076623; cv=none; b=aM6bV3DKbaIzREABL3eo6DqdHjfn23jT7qpGWM4+FK7E0DzY9VtBD5ynlWd/YhjyDSWwi4uULkBRLu766M/ZundH2NM4vfxLgnSRnIQsJ0RYqBs5TZEorMwcDcjTj9oVY/hAFXptcJZg2oaQQZMKYRu7HjXf8Hh1/NQZLv/8xP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076623; c=relaxed/simple;
	bh=jM05HbSUNCofUV3Nc0ximHkTg86J270bgCbLK7ktQk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BY4z7QdpwVsWvxjEZ/zsdUlxEBn4PL6KRMM9hzDdZJ19I8TyibGua3gzV+VEatKXmaLu5yppCfqiOmO/5NZ1LypYpgMwHlKZDNDsFPvoGLyKLH8x/nHU5EKKQed1gZcKLDEhxA7+jz9s/Vmam7sEco6ch+pd/6sX/EYFyqEJ9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XT7M73jM8zpWr7;
	Wed, 16 Oct 2024 19:01:39 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id DCB8B1800A0;
	Wed, 16 Oct 2024 19:03:37 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 16 Oct 2024 19:03:35 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <dakr@redhat.com>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<amadeuszx.slawinski@linux.intel.com>, <cezary.rojewski@intel.com>,
	<cuigaosheng1@huawei.com>, <wangweiyang2@huawei.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] firmware_loader: Fix possible resource leak in fw_log_firmware_info()
Date: Wed, 16 Oct 2024 19:03:35 +0800
Message-ID: <20241016110335.3677924-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The alg instance should be released under the exception path, otherwise
there may be resource leak here.

To mitigate this, free the alg instance with crypto_free_shash when kmalloc
fails.

Fixes: 02fe26f25325 ("firmware_loader: Add debug message with checksum for FW file")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/base/firmware_loader/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 324a9a3c087a..c6664a787969 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -829,19 +829,18 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name, st
 	shash->tfm = alg;
 
 	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
-		goto out_shash;
+		goto out_free;
 
 	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
 		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
 	outbuf[SHA256_BLOCK_SIZE] = 0;
 	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
 
-out_shash:
-	crypto_free_shash(alg);
 out_free:
 	kfree(shash);
 	kfree(outbuf);
 	kfree(sha256buf);
+	crypto_free_shash(alg);
 }
 #else
 static void fw_log_firmware_info(const struct firmware *fw, const char *name,
-- 
2.25.1



Return-Path: <linux-kernel+bounces-251391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2F930454
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90A91F23A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11213BBF6;
	Sat, 13 Jul 2024 07:44:43 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C51B960
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720856683; cv=none; b=Y9agBJ9GHnXL80rvDsqnFG+GKP69goKeaU3Ayq40s65z1ZIRPwxDEuQ6+WOJAohsheukjjBJ6So7yUyT4nn8VQCIH3SPsfEfUQBLQmd1qk3sGSJsmeZjPA4Q1T74Y/jXqYtwosOhGreDIj6dPLOKYJ64FYpXJFgYzpJybSQLmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720856683; c=relaxed/simple;
	bh=J0PzgiEXf2NNhQ8wFAX6wADfm0QBmzJQo/EBBq4GmxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AEupNW+LzwBZg/COAIuGTowMD52+8YGKOTkRzzEsw6IA5s/K4bA7B6iWfhqePzK1spfgZeRZbu6geuW/wW1nIezVInHYXUX7VaYcdvsC1gE4606H8Bw0efhyCHCEk9PnIZwXRRD3BgL9ICf7y4FmCiZ5vbEpFJJTC/GdKbOSIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CB1A2606BA37;
	Sat, 13 Jul 2024 09:35:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ny2PvNGbggCq; Sat, 13 Jul 2024 09:35:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 252586196A6F;
	Sat, 13 Jul 2024 09:35:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EW9KpJFCFHXD; Sat, 13 Jul 2024 09:35:28 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id D883D6196A6B;
	Sat, 13 Jul 2024 09:35:27 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	Richard Weinberger <richard@nod.at>,
	Ben Hutchings <bwh@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ubi: Fix ubi_init() ubiblock_exit() section mismatch
Date: Sat, 13 Jul 2024 09:35:19 +0200
Message-Id: <20240713073519.25325-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since ubiblock_exit() is now called from an init function,
the __exit section no longer makes sense.

Cc: Ben Hutchings <bwh@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407131403.wZJpd8n2-lkp@i=
ntel.com/
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index bf7308e8ec2fe..60d0155be869f 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -670,7 +670,7 @@ int __init ubiblock_init(void)
 	return ret;
 }
=20
-void __exit ubiblock_exit(void)
+void ubiblock_exit(void)
 {
 	ubi_unregister_volume_notifier(&ubiblock_notifier);
 	ubiblock_remove_all();
--=20
2.35.3



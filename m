Return-Path: <linux-kernel+bounces-257045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E56E93747D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B082821B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5095D477;
	Fri, 19 Jul 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY90NcYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F659155
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721374758; cv=none; b=nDm610H/Xml7Nc4w9+kYZ8casaFhu0FvXn0saepjcw72x/+EI0lVIG/RunGOYBVBYDT7y2U9Y8nix2Q/7K1Y+lBAs1JadFsovvtdJwvXjAVlcFZLjAlcKWxWOcDrPS6lsV1xtkBN4hGyrsQmX7sNobE053b0CxUb+Qe9CRisIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721374758; c=relaxed/simple;
	bh=tSlyB/cO6NE7Wr22LWyuh0vigIs77ob5HEn6B1Bv6Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZcUlV3QebbuYdXf1X6MbyjVjSJyRSFaVcvINgL2wqvExdkuzxBQLEoXv+R7034S1u7AhoQouuD4xLaYy2PqB0JA1IzaOoBeoun1Z4m+MsGceRpP1kNpe0aWVvdQL8zaeDVt+kftRR+K0o14ZvQzj40R/F25lvTTU1dm/dookd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY90NcYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D358C4AF0D;
	Fri, 19 Jul 2024 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721374758;
	bh=tSlyB/cO6NE7Wr22LWyuh0vigIs77ob5HEn6B1Bv6Iw=;
	h=From:To:Cc:Subject:Date:From;
	b=BY90NcYaqUeqX2OWpwxWjM0UK3u8wuMbSl6dHERabgv00qkUKUd8JydFFGYR23oAR
	 lZtbHju4x2Y8hnWtmixVSQ1eZr5f5Mm+Q/kB+IAkbj0/D9xPJZzmjCIGcK5YpV/uWy
	 M6eUXC9qiJvHP5B9wr9b6weGTsSlpgA2zwR0zm+dOzwV3tceSxpkjYg9G669hjbOrX
	 5cG/fuJQL2yuwhzqXM3N8X5AY+SeOoKrKK6pQQs1+60lGjVnW3V/yyYTR9So9romRn
	 d0iSgnweeRnHbcvlR7pDPmEHZTXkrJZ8I/RaQStqAju9yH4I6hZHCN/Eut1p6W8MyQ
	 K8eVSwVbw9FFg==
From: Arnd Bergmann <arnd@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Hutchings <ben.hutchings@mind.be>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Li Nan <linan122@huawei.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Jens Axboe <axboe@kernel.dk>,
	ZhaoLong Wang <wangzhaolong1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: ubi: remove __exit annotation on ubiblock_exit
Date: Fri, 19 Jul 2024 09:39:06 +0200
Message-Id: <20240719073912.2743171-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Calling an __exit function from an __init function leads to undefined behavior
when the drier is built-in and the __exit functions are dropped from the
object:

WARNING: modpost: drivers/mtd/ubi/ubi: section mismatch in reference: ubi_init+0xbe (section: .init.text) -> ubiblock_exit (section: .exit.text)
ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.

Remove the now incorrect annotation.

Fixes: 72f3d3daddd7 ("mtd: ubi: Restore missing cleanup on ubi_init() failure path")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/ubi/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index bf7308e8ec2f..60d0155be869 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -670,7 +670,7 @@ int __init ubiblock_init(void)
 	return ret;
 }
 
-void __exit ubiblock_exit(void)
+void ubiblock_exit(void)
 {
 	ubi_unregister_volume_notifier(&ubiblock_notifier);
 	ubiblock_remove_all();
-- 
2.39.2



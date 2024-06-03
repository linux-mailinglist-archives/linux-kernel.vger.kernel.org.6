Return-Path: <linux-kernel+bounces-199233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E148D8430
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BC31C21DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BD12E1C2;
	Mon,  3 Jun 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6mfXiT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46D12DD9D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422064; cv=none; b=rBPjtojrPeR0C++IH6111awJ44Wva8T3Y28wFF2BPWbtfiIP6kauF6myFxPYiNpKxBhj47G/hTW9N7FIvselcBWwe8eLMoWKcX2wVlsM8G6COF9zav9Zql3aunbL0oePsBLIvkYmcNTqHMtzGlvZkJlBbIuW/xOb7BYPYSrV83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422064; c=relaxed/simple;
	bh=Up225fPrblCk8vyakWXB0/yPHz5gAz1M47n4JUzhfjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQ539ipfR961aBI1AEZtYAj4mPg15aGXRw8GVeo3imaGoA5x15yPUM0/e0yenV9Bw4j3E0TaNmsGeak6wOFjjwYR+Vh0Rj52aI7qWf3QTm3VfExaGdP2s92qiDx7ilFhoQ27BmGDyCtvMvtAP5/InQNS8lU+r8C26R5y2jbrc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6mfXiT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EA5C2BD10;
	Mon,  3 Jun 2024 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422063;
	bh=Up225fPrblCk8vyakWXB0/yPHz5gAz1M47n4JUzhfjk=;
	h=From:To:Cc:Subject:Date:From;
	b=h6mfXiT4Wx8nQ/F3zZbIjuPJn7F0/oQ0WKqJ3/5tgr4AwAa/PWsGpOpy75Wr5vGus
	 2yilPSnU3BcK0GbHpTa6tTz/MJIflbzNCGkixAoczqN11vcB2qNDV4Bzue+vs3M42J
	 TfmqPQrR3Qs47NBFTWy8a1XG+LQZNmCdYgKoOqkk3IcUBAM1ENo3APBrnXZIBlhrzE
	 pS6WCPJcxTBDvObJTiQmxAmYvBpCWRi4aTShELTy3+JaKwo6VbE99VM+1la7kqwWwX
	 gre9endQ1POpewU+qIqg3VP3oVOrxBL9jvPA2RWk5Zb9plhqzpicUxbSmU4UJOgj+a
	 lyO67RfnXfiog==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mtd: spi-nor: simplify spi_nor_get_flash_info()
Date: Mon,  3 Jun 2024 15:40:55 +0200
Message-Id: <20240603134055.1859863-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework spi_nor_get_flash_info() to make it look more straight forward
and esp. don't return early. The latter is a preparation to check for
deprecated flashes.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - rework the handling quite a bit, thanks Tudor.
 - drop the spurious comment about the partitions, it goes way back
   until the initial support. I don't think it's accurate anymore.
   If the flash has the same size, the partitions can be trusted. If
   not, anything can happen.. We don't know.

v2/v1:
 - none, this is a remaining patch of my spring cleanup series.

 drivers/mtd/spi-nor/core.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 7128d45870d4..e0c4efc424f4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3298,32 +3298,28 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 
 	if (name)
 		info = spi_nor_match_name(nor, name);
-	/* Try to auto-detect if chip name wasn't specified or not found */
-	if (!info)
-		return spi_nor_detect(nor);
-
 	/*
-	 * If caller has specified name of flash model that can normally be
-	 * detected using JEDEC, let's verify it.
+	 * Auto-detect if chip name wasn't specified or not found, or the chip
+	 * has an ID. If the chip supposedly has an ID, we also do an
+	 * auto-detection to compare it later.
 	 */
-	if (name && info->id) {
+	if (!info || info->id) {
 		const struct flash_info *jinfo;
 
 		jinfo = spi_nor_detect(nor);
-		if (IS_ERR(jinfo)) {
+		if (IS_ERR(jinfo))
 			return jinfo;
-		} else if (jinfo != info) {
-			/*
-			 * JEDEC knows better, so overwrite platform ID. We
-			 * can't trust partitions any longer, but we'll let
-			 * mtd apply them anyway, since some partitions may be
-			 * marked read-only, and we don't want to loose that
-			 * information, even if it's not 100% accurate.
-			 */
+
+		/*
+		 * If caller has specified name of flash model that can normally
+		 * be detected using JEDEC, let's verify it.
+		 */
+		if (info && jinfo != info)
 			dev_warn(nor->dev, "found %s, expected %s\n",
 				 jinfo->name, info->name);
-			info = jinfo;
-		}
+
+		/* If info was set before, JEDEC knows better. */
+		info = jinfo;
 	}
 
 	return info;
-- 
2.39.2



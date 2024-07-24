Return-Path: <linux-kernel+bounces-261049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9893B227
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C621F24E88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9E15A868;
	Wed, 24 Jul 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Njwdyesu"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA5158A19
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829441; cv=none; b=ond9V6ZPrdvAxpPLlzDYJvIJI4ToC6K32Ks/sE4pcs2pO4POyX0hheEmakVErKtWBSTOlMFIe42//4YDG8UsOvDZ0dJErCA19RDW6dx7vnkg38Cr4LcKuZvoChezGtlUMIPxe/f93pQ978gLhRpWbSx7F3//aIa88cLHvdVzJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829441; c=relaxed/simple;
	bh=SCLNff6uXb7/3wrdyKO3f/bKrvDhO9JvduRpC1kRCSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L38ptskPf7CnwW7iP5xOxuU5gi2PReO/iSU5zPBax/LtLJ/Kefu0QIHrMazNTZTNEoNHWrkmMhv2IIpWUeS6VvcQHtsQfCeNohUcvywBJrcFlUPpswwd02Hf3LtW9pKxAbfhcIl9/K2TRtm3y3K2LlLZyctZc5P0Uc+HnqGlzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Njwdyesu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23B4620008;
	Wed, 24 Jul 2024 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721829430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygdmJeHBtKUEIRBzNdm/VrVb86KhwUfxux4SNqiARGg=;
	b=NjwdyesugsN0j9zpdhh0TemeulT7V6aLoopT0O0YObjsX/R5rmLH6qkD+jCdV/SAM11d+O
	0bVb1upf4WRdfBvWv5v4cPIwBOuImZP7tyT64jO2LGhT6EcsaRAmYQtCI2hxV7NmxxQK/P
	UY+snO07lTOZ0sj4PFPcORRIX1TUJWWZHcIbdmaBlwwKlupitSglijnA0GPHEDMFj3aMC5
	Val9zZjdfPofXyNEKmpYCcsUCq6mOU/F26oqJhxddhnS9KaspTKJ6pIFTj/tWMzMW8Ez4D
	L75pLxV2hTnQ+PCJ7avBN8sh4otNh7ZI1i4k9Lujw3cQqTMpNhcIKnQl3OrCwA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 24 Jul 2024 15:57:09 +0200
Subject: [PATCH 2/3] nvmem: rmem: make ->reg_read() straight forward
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240724-nvmem-rmem-v1-2-d2e3a97349a0@bootlin.com>
References: <20240724-nvmem-rmem-v1-0-d2e3a97349a0@bootlin.com>
In-Reply-To: <20240724-nvmem-rmem-v1-0-d2e3a97349a0@bootlin.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

memory_read_from_buffer() is a weird choice; it:
 - is made for iteration with ppos a position pointer.
 - does futile error checking in our case.
 - does NOT ensure we read exactly N bytes.

Replace it by:
 - (1) A check that (offset + bytes) lands inside the region and,
 - (2) a plain memcpy().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/nvmem/rmem.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 7f907c5a445e..b2dd25acd7d5 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -21,10 +21,10 @@ static int rmem_read(void *context, unsigned int offset,
 		     void *val, size_t bytes)
 {
 	struct rmem *priv = context;
-	size_t available = priv->mem->size;
-	loff_t off = offset;
 	void *addr;
-	int count;
+
+	if ((phys_addr_t)offset + bytes > priv->mem->size)
+		return -EINVAL;
 
 	/*
 	 * Only map the reserved memory at this point to avoid potential rogue
@@ -36,20 +36,17 @@ static int rmem_read(void *context, unsigned int offset,
 	 * An alternative would be setting the memory as RO, set_memory_ro(),
 	 * but as of Dec 2020 this isn't possible on arm64.
 	 */
-	addr = memremap(priv->mem->base, available, MEMREMAP_WB);
+	addr = memremap(priv->mem->base, priv->mem->size, MEMREMAP_WB);
 	if (!addr) {
 		dev_err(priv->dev, "Failed to remap memory region\n");
 		return -ENOMEM;
 	}
 
-	count = memory_read_from_buffer(val, bytes, &off, addr, available);
+	memcpy(val, addr + offset, bytes);
 
 	memunmap(addr);
 
-	if (count < 0)
-		return count;
-
-	return count == bytes ? 0 : -EIO;
+	return 0;
 }
 
 static int rmem_probe(struct platform_device *pdev)

-- 
2.45.2



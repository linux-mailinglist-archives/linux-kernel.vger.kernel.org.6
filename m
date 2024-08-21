Return-Path: <linux-kernel+bounces-295376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C8A959A32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDA42814FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EEF1C1AA5;
	Wed, 21 Aug 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="KVp4uR8R"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF961BA29C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238003; cv=none; b=tg/kEl3DWc7NohCdsbYZRrhu9sTbjm2AGAX+XXJoimHPChdow5XLVlCF8VMPQxktjg3+p93RzMIwMJXmgIcZ+g54bVNYkEcdsGYCnmdnsoRS/Bq6C23ry4urni1UsuXMPbKR5VU1MKwZ0BlN0D5NUi3N2upPk7X55KohYnBHd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238003; c=relaxed/simple;
	bh=FefeWmBE3XufmHRreHUqF2kiLEqYzrbKkLAjSc7pSZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZgi7k/jQdTymDd0DAa1Tlh29GxHlMoNN6K+79V+uovTrHwX/VCwXogy3ln+uz42JpVtFfIqHOnEt4B8WFwvb7d9wIJjNc8Sl71F307i1f6lkMW580dDi6YWXsopD3V3CBcF1V7duvSPCAeGUnW/uNAwHYabAgwjhbAs13dTXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=KVp4uR8R; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F3A11483DF3;
	Wed, 21 Aug 2024 12:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237999; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7R+I3eWvRMVL77L44Gt897N18NavS4Wc92V6aQKadT8=;
	b=KVp4uR8Ro7N7VsYnYCe7XQW9iovUZvzIxkjmraWg6QtT5tIdFvmg1TaDL2MdPL5cco68jN
	nQWP5krf94zjpxKBG/OF5ZZkvbJ4mkLHaZebnUVJ1k4QIpc1jCnj3ERK0O4thIb2bJMHhq
	j3HJBWWtGCGna5vefOmbNA/TMj6GlsJnBRDWRrrR0lU1l7z6pFRYusz/b++dYL4IJj08ay
	0/YQmSPtbGij9AmB6NNTPT5pRZ1vXHBXwHh/hZc/PC3FvNTKThDGiOjedgeufu5lPbUJ0y
	yjTDVY7XPPJYoDXOkECg5awvIbh02hRaqhAWPNbmDbS84fs6UndhWNDiwaNHYA==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP OTPC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 12/12] nvmem: microchip-otpc: Expose UID registers as 2nd nvmem device
Date: Wed, 21 Aug 2024 12:59:43 +0200
Message-Id: <20240821105943.230281-13-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

For SAM9X60 the Product UID x Register containing the Unique Product ID
is part of the OTPC registers.  We have everything at hand here to just
create a trivial nvmem device for those.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/nvmem/microchip-otpc.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 047ca5ac6407..52af4c137204 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -45,6 +45,9 @@
 #define MCHP_OTPC_NAME			"mchp-otpc"
 #define MCHP_OTPC_SIZE			(11 * 1024)
 
+#define MCHP_OTPC_UID_NAME		"mchp-uid"
+#define MCHP_OTPC_UID_SIZE		16
+
 /**
  * struct mchp_otpc - OTPC private data structure
  * @base: base address
@@ -249,6 +252,16 @@ static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
 	return 0;
 }
 
+static int mchp_otpc_uid_read(void *priv, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct mchp_otpc *otpc = priv;
+
+	memcpy_fromio(val, otpc->base + MCHP_OTPC_UID0R + offset, bytes);
+
+	return 0;
+}
+
 static struct nvmem_config mchp_nvmem_config = {
 	.name = MCHP_OTPC_NAME,
 	.type = NVMEM_TYPE_OTP,
@@ -258,6 +271,15 @@ static struct nvmem_config mchp_nvmem_config = {
 	.reg_read = mchp_otpc_read,
 };
 
+static struct nvmem_config mchp_otpc_uid_nvmem_config = {
+	.name = MCHP_OTPC_UID_NAME,
+	.read_only = true,
+	.word_size = 4,
+	.stride = 4,
+	.size = MCHP_OTPC_UID_SIZE,
+	.reg_read = mchp_otpc_uid_read,
+};
+
 static int mchp_otpc_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
@@ -303,8 +325,25 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 	mchp_nvmem_config.size = size;
 	mchp_nvmem_config.priv = otpc;
 	nvmem = devm_nvmem_register(&pdev->dev, &mchp_nvmem_config);
+	if (IS_ERR(nvmem)) {
+		dev_err(&pdev->dev,
+			"Error (%ld) registering OTP as nvmem device\n",
+			PTR_ERR(nvmem));
+		return PTR_ERR(nvmem);
+	}
 
-	return PTR_ERR_OR_ZERO(nvmem);
+	mchp_otpc_uid_nvmem_config.dev = otpc->dev;
+	mchp_otpc_uid_nvmem_config.priv = otpc;
+
+	nvmem = devm_nvmem_register(&pdev->dev, &mchp_otpc_uid_nvmem_config);
+	if (IS_ERR(nvmem)) {
+		dev_err(&pdev->dev,
+			"Error (%ld) registering UIDxR as nvmem device\n",
+			PTR_ERR(nvmem));
+		return PTR_ERR(nvmem);
+	}
+
+	return 0;
 }
 
 static const struct of_device_id __maybe_unused mchp_otpc_ids[] = {
-- 
2.39.2



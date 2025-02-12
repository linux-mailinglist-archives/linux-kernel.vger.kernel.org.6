Return-Path: <linux-kernel+bounces-511076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC52A32577
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A16F7A23F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ACB20A5E8;
	Wed, 12 Feb 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aO51AjiC"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0551C54AA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361407; cv=none; b=Lt+b5jM47iRhoov/TemjrdFz7WIty9ohHxFnB64KvioUWZqJycp1ggY/X06kqyHpX5771mCXj+E0Qnd2jVsG5S2XaFMhgVss568IpZ8lNhZA6Q1CUf0r8v7Hql3kqZngRWX9a4dGGn21MCKFqUNZboOIp06bQDpBnlHt84GX1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361407; c=relaxed/simple;
	bh=g57jTDv/8L3QsH/3Of2EgNEym5SUxaQAHGt2tSfjEZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQ86JrhKde+pg1DvGulLLVtwDXYR5GTNHEX3Y8p6JP4e8H5LlFpPzknnz/+fC2+5GSgpiAbJouECOnMiORovJszXKrzxb0UA6c2tzlSMGf369eoa/xF758wR10gd05KTQ5JmRG3PItvwRPMzvB7H8ykrhtLcDp1HSYKuFDpwbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aO51AjiC; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739361394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TdlWoiWzqb/Alg2Sp4K8UbonWAARBt2LoHBY4ldSriM=;
	b=aO51AjiCWl3EP318/k9ULhcBQi0Wf36dawgbkP7BcfFsIiy6sWmVxd7Y8oD6/Vn9kJvaG2
	uc4M5CjjqUMzwkykok3m+fJjWw/ZZhIe4JjhWUVuyQxaYoaOx96UEMT+DVHe0DpV+p1LRz
	Qi84Wzel9JagkXrp3npMI6hghjqwL7k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hpsa: Use min() to simplify code
Date: Wed, 12 Feb 2025 12:55:57 +0100
Message-ID: <20250212115557.111263-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to simplify the host_store_hp_ssd_smart_path_status() and
host_store_raid_offload_debug() functions.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/hpsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 84d8de07b7ae..1d19eb2ca1d3 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -460,7 +460,7 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
+	len = min(count, sizeof(tmpbuf) - 1);
 	strncpy(tmpbuf, buf, len);
 	tmpbuf[len] = '\0';
 	if (sscanf(tmpbuf, "%d", &status) != 1)
@@ -484,7 +484,7 @@ static ssize_t host_store_raid_offload_debug(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
+	len = min(count, sizeof(tmpbuf) - 1);
 	strncpy(tmpbuf, buf, len);
 	tmpbuf[len] = '\0';
 	if (sscanf(tmpbuf, "%d", &debug_level) != 1)
-- 
2.48.1



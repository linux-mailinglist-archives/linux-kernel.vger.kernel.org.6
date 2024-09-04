Return-Path: <linux-kernel+bounces-312847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B43969C63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430121F2239E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87111AD26D;
	Tue,  3 Sep 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cs1iL06J";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fR6X6WaD"
Received: from a7-29.smtp-out.eu-west-1.amazonses.com (a7-29.smtp-out.eu-west-1.amazonses.com [54.240.7.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A1F1B12E7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364157; cv=none; b=QtffnyPfoA0vM3ybGgrQuJ/McqoyzwDkx/G8yTPOsGhBc6b3JEc9/A8asPMDVmMMvweMfKgXN3h9ybCqgX7n/9hnrBUgdD1cg4C9YWozV8Rcg7uzM8E28qFXlf9/f5/WUjz+TZCNCIUynHsPliIowrwriVlDs9+XN2cLVzIE1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364157; c=relaxed/simple;
	bh=ObT60zcbCbi35EjoJKU5eE2w1p2W/0osNYaH1E6YL3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRZYmvru3UR0h5BJLOpCXKNoeAtRELTPj+TaIFyYXgGsAOlMOShOMAo0l2Z2j2IAmlTpxeTmY7Ld9MJ/HaF06IbYdw8NfKkT2Ppq/30HKARNjN7V0pudP6CW0ti01htoFwH7534jIwqOSvTm4Pux3JlTqsZjq9AljnHEM76gAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cs1iL06J; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=fR6X6WaD; arc=none smtp.client-ip=54.240.7.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725364154;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=ObT60zcbCbi35EjoJKU5eE2w1p2W/0osNYaH1E6YL3g=;
	b=Cs1iL06JJ8AVKJEAn7FtXcpy06VqD4M9iex8FAVjFsMgZH2XawvAkmK9ea0qRxcZ
	V/YCzDssBJN8pAmZR/USHUOCshQpGBHkPivHX8JNrr0Omrvtsi8FvIfqVPCFR6k19Dg
	ki+dbC0YTyUiLc3qpQ+3xyrvv9KPEIPpN5R3sBGN0fBVHOskkL2geN7xDDh5YuddtO8
	stZiI7+4iSFg8hoBCItOy9MQcn1trtP9AyAvT8kVJaD90TA3EiXUqaKgFMIlYJqZwzz
	JVNL9LLOgpEjz5Z7bDAzdArEuPIymN1iZ5kvNtQC6ekuHS5mn2N0jJpMJzeU32flkNA
	4KhELCB9yg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725364153;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=ObT60zcbCbi35EjoJKU5eE2w1p2W/0osNYaH1E6YL3g=;
	b=fR6X6WaDNaqrb/eC3ZaNPg+1+ZkkFeCZq95YiWsrrezI8ufsUoKaYm6+ITxxn7NP
	zNat38Rg9+KX3hcCXaTy6fMColjxO5G/32S4x8psCveXY6/ENm+1y89ECuACjZJw2bq
	INtloZw7ckGpEUI3NvuZwadBh5rECGruVVjeBO9A=
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, 
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] nvme-pci: refresh visible attrs after being checked
Date: Tue, 3 Sep 2024 11:49:13 +0000
Message-ID: <01020191b7b7adc0-bca16d06-b051-4ce2-bfee-c8038a62462f-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.03-54.240.7.29

The sysfs attributes are registered early, but the driver does not
know whether they are needed or not at that moment.
For the cmb attributes, commit
e917a849c3fc ("nvme-pci: refresh visible attrs for cmb attributes")
solved this problem by calling `nvme_update_attrs` after mapping the cmb.
However the issue persists for the hmb attributes.
To solve the problem, moved the call to `nvme_update_attrs` after
`nvme_setup_host_mem` is called, the one that sets up the hmb, in probe
and in reset_work functions.

Fixes: e917a849c3fc ("nvme-pci: refresh visible attrs for cmb attributes")
Fixes: 86adbf0cdb9e ("nvme: simplify transport specific device attribute handling")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..9455c4d53d7d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1878,8 +1878,6 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) ==
 			(NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
 		pci_p2pmem_publish(pdev, true);
-
-	nvme_update_attrs(dev);
 }
 
 static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
@@ -2736,6 +2734,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result < 0)
 		goto out;
 
+	nvme_update_attrs(dev);
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
@@ -3046,6 +3046,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result < 0)
 		goto out_disable;
 
+	nvme_update_attrs(dev);
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out_disable;
-- 
2.34.1



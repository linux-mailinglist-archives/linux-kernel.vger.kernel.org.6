Return-Path: <linux-kernel+bounces-425515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD109DC315
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6422827BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38892158A09;
	Fri, 29 Nov 2024 11:47:05 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B133C5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880824; cv=none; b=GfL6cqs275ryu46vLcG26TxQLoayLQG7LaqC0XwF5SmTwz5CZD1OO4Ymg07zKGPldr2sRCgMBJf7BHPkxO8JRgeG8IHZdCnK7qCkBM6HcXIUVPxhOrObgi+30zi4JoY0PGKs6DDCQ6ejoZtx7LQ4L2Fj7B061a/8FRVYQRPacq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880824; c=relaxed/simple;
	bh=WG1yitDn67Gwd2HJAYtL1ufsI8J141HiWoteMrGEpLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mcKaZAkbv9nXUDj6DHOkl3UBLjXejOv4Oc1S2vF6KuQpoJ50AJQaSTOR8Wp41G44lQgC+nkbYmgLhxIwykINHsB4jQJBXF8AzE8XeTKkHTbsdqyp283I05R2HRnpdD+3gdc6YlTMoOv+S9lHuGP/DdCfFcH9TgVd3wU2yp5VPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1253E1A2A8A;
	Fri, 29 Nov 2024 12:46:56 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 065CA1A2A8E;
	Fri, 29 Nov 2024 12:46:56 +0100 (CET)
Received: from lsv05875.swis.nl-cdc01.nxp.com (lsv05875.swis.nl-cdc01.nxp.com [10.168.9.2])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A804320376;
	Fri, 29 Nov 2024 12:46:55 +0100 (CET)
From: Sahil Malhotra <sahil.malhotra@nxp.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Cc: Sahil Malhotra <sahil.malhotra@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH] optee: fix format string for printing optee build_id
Date: Fri, 29 Nov 2024 12:46:48 +0100
Message-Id: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

There has been a recent change in OP-TEE to print 8 and 16 character
commit id for 32bit and 64bit architecture respectively.
In case if commit id is starting with 0 like 04d1c612ec7beaede073b8c
it is printing revision as below removing leading 0
"optee: revision 4.4 (4d1c612ec7beaed)"

Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
---
 drivers/tee/optee/smc_abi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index e9456e3e74cc..eb51dc18f32d 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1272,8 +1272,9 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
 		  &res.smccc);
 
 	if (res.result.build_id)
-		pr_info("revision %lu.%lu (%08lx)", res.result.major,
-			res.result.minor, res.result.build_id);
+		pr_info("revision %lu.%lu (%0*lx)", res.result.major,
+			res.result.minor, (int)sizeof(res.result.build_id) * 2,
+			res.result.build_id);
 	else
 		pr_info("revision %lu.%lu", res.result.major, res.result.minor);
 }
-- 
2.34.1



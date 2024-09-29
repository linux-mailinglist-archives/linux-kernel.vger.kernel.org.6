Return-Path: <linux-kernel+bounces-342778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140949892EF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4821F2223C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ADC208A7;
	Sun, 29 Sep 2024 03:42:39 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE017C8B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727581359; cv=none; b=FVcAzLb6lFu7lceJSyE0BJ6rVFZxELVjd3cyEC/eou/Ik2R66uZuo8O06MgHrFIGiEguQJkK+5YetbEr1RQ0MhEa8kDAP3jjTh6jJ2YOTdnTFHFwBPFkOsyi+f9KVzgZ/SJ26h+YsI5F/q+/eiXwzowPJh1Zmb6GxqGYxDRvdTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727581359; c=relaxed/simple;
	bh=pE+BzXbZxh9x3ZkVaXFexhxwNufUAvFQkw5XyCzxzRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NIHGTOVDYtHC29SWADBQ75Ok0euK/SNNGu97/sUb6U7vKg8BaMwnAMVi/TG0TaJEv737QGTNcMOLi3UeGxhrJLjEMaA66NlCPRtMbKqjMbEy3/l1xdHdodUMabPeXjzarFn7jLSjFrg75O615DWHBiRuIi8/5gCABUaCqBicgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id ZCT00121;
        Sun, 29 Sep 2024 11:42:21 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201616.home.langchao.com (10.100.2.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 11:42:25 +0800
Received: from localhost.localdomain (10.94.12.73) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 11:42:25 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <gregkh@linuxfoundation.org>, <alexandru.ardelean@analog.com>
CC: <linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] uio: uio_fsl_elbc_gpcm: Add check devm_kasprintf() returned value
Date: Sun, 29 Sep 2024 11:42:23 +0800
Message-ID: <20240929034223.59209-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2024929114221142bf2079b071793e49279942207ef58
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure but this
returned value in uio_fsl_elbc_gpcm_probe() is not checked.

Fixes: d57801c45f53 ("uio: uio_fsl_elbc_gpcm: use device-managed allocators")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/uio/uio_fsl_elbc_gpcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index 496caff66e7e..6378e752f828 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -384,6 +384,9 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 
 	/* set all UIO data */
 	info->mem[0].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn", node);
+	if (!info->mem[0].name)
+		return -ENOMEM;
+
 	info->mem[0].addr = res.start;
 	info->mem[0].size = resource_size(&res);
 	info->mem[0].memtype = UIO_MEM_PHYS;
-- 
2.31.1



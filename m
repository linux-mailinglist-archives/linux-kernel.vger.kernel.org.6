Return-Path: <linux-kernel+bounces-541755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72605A4C133
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918793A8CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595813FEE;
	Mon,  3 Mar 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="icF3kH8K"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D401E521B;
	Mon,  3 Mar 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007068; cv=none; b=IQHk27mUHPyfELwBpGh8ewJkg1VeB7Lm6o6wThpeNPoikKOCRa0tyC/9E9Fg9jsyAufQzXj7s1UcOmXM18IpfTY90a3wYVBJsOVHTVGK08VxoomcFiXFDbD3J3lKjn9NrMtArRwvnEWx+m7YEMo7Rw3j288HjN18Uc8OnMeN8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007068; c=relaxed/simple;
	bh=deHDsGRnpCFYdcazA6My4sNfesgr2kjXi9cLuvrb+Wk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=HBT527qtlofqfd+ETVFwiGFzX2kY22T9yLPv06AVyYiKwHQqrA/cTJ3LjP5e3kB60qP+Cje9bHRXEyvd7vEENVTplwWFWfwdMqWpuLt/inzxLQk+jBYpib1LQJK8Zc4IE4/ndBpJ+2xn6u/EGF7ZP2ZQwgMm3IrJM0L83WHQcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=icF3kH8K; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1741007055;
	bh=8ZJXM2NAmR6MyGN7HaDcDXJKKSGF+vXDJJylE3dFnus=;
	h=From:To:Cc:Subject:Date;
	b=icF3kH8KuI96AG2fko302LzcoIiduXqxOxKxo6caoxTMyUer6v/1L/tJOx18kZLUn
	 +CosaUqSw+QmQoF1HSmHNsM1z+NXPN/wDp2mb8hDjffPeloL6bv2FqSbESe0L4nWaI
	 TIhPd1qK2i7dww9wrOLfM0aTkj96sJoRr8n6FEtI=
Received: from localhost.localdomain ([223.74.103.43])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id E6E2DEA1; Mon, 03 Mar 2025 20:57:46 +0800
X-QQ-mid: xmsmtpt1741006666tfxfxmyk9
Message-ID: <tencent_9AD8E7683EC29CAC97496B44F3F865BA070A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb53m7Gtfg9e79EoNraSi66kuTiy0gUooAgagGKEmngQ0SJ6Wy9sx
	 F5OisJve/K89WyCH5XUug+qgmKPCy5+UnXlA8H74OMoa2NFN/tm61tHtDP8b6pxzDdTT5qPbSZr4
	 7+I75D/6Go/Ks8NrLS+frBt1Xy/KoNwTf3rNXTTcDmR9yeCqT7CYgEm/8I4GtCE8wF5fT3PvxbFY
	 3oaO8cxaGrUFuDdb3vzuwYiYEYieDch57vjS8cFZ7agwmvrdkHr72LtKxdoKZQgkfQ87vZ5OxQ5x
	 OzMlRm3N3GFNlsYwzbE3Qbvc+OP+vABEc295+0fOzeNor/tA5nDgEzgvxfnawGae3qFXWze14C8w
	 Ez1QK17r+ud2s2uYeFlp1sNRtWsjUyBrIO47yFDxGug9pYitDZqC8Kqp81rPPCsr0u2h6TfjD5Q1
	 QOqkNaxDnWET1PGUbxhNAUMeOOSg6WDhxLtWMQjN8sT+d3v3x9APCOQcsoB+zAb8rfGn1Sd2PxVY
	 nJc0LG0hj9a5c9bhZzholnnzPbvg6lPEVEziONftXR2N6jeYLy2oSyvjcJ//6UKgLo7B3FZ0BRc6
	 zI9/Hy1xmtadl+rHFh8yYoBcz58KVdknEusfksWuUbi/SYc61dbD/NHWXEYZRE+A8hhrKMTAcEmB
	 pbAiB0eQR4qWoB4bQDL/0A42oVZ6fkddt8R5OHzbIXZyjlKNeoMsRZ7fj5x36bB4PBo0KDTB2p1n
	 FOmCuCv/VQql6X2bAh98IHps8rJXNMhHh/5b8nVTVirLUgI4D4XXMf5/V4gYq3TenXZ66wHinmZv
	 nAHgM33NZf+4jZG32OU967A27p+r08n/Idbh4NDqR4kvD7VY+mWT7BR1VhQkU9Ww8y66lZ8MgCmP
	 hjiLNIbUxfF1byHMHWJdxa3dbnRB2rvcSR6HGFIVaAY3XrnpL93wBtgO8CxF0ykcg7qxLg4I/ryW
	 MAJJtgijGyY1L2F493BA/J3xbmbQI3UX7U1SWH0eTw9ZFsD1ek90fGon/Z5Tyxlf6/cKEATqR2zb
	 jpK2Luo9gz+qB2MoHVwh3nYqU17Vk=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: xinghuo.chen@foxmail.com
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	jingfelix@hust.edu.cn,
	Xinghuo Chen <xinghuo.chen@foxmail.com>
Subject: [PATCH v2] hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe()
Date: Mon,  3 Mar 2025 07:57:33 -0500
X-OQ-MSGID: <20250303125733.3395-1-xinghuo.chen@foxmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Xinghuo Chen <xinghuo.chen@foxmail.com>

The devm_memremap() function returns error pointers on error,
it doesn't return NULL.

Fixes: c7cefce03e69 ("hwmon: (xgene) access mailbox as RAM")
Signed-off-by: Xinghuo Chen <xinghuo.chen@foxmail.com>
---
v1 -> v2:
Use IS_ERR_OR_NULL() instead of IS_ERR() as devm_ioremap()
return NULL on error.

Link to v1: https://lore.kernel.org/all/tencent_370DBB5BD8EF699EC030ACA74BCB440FFA0A@qq.com
---
 drivers/hwmon/xgene-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 1e3bd129a922..7087197383c9 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -706,7 +706,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (!ctx->pcc_comm_addr) {
+		if (IS_ERR_OR_NULL(ctx->pcc_comm_addr)) {
 			dev_err(&pdev->dev,
 				"Failed to ioremap PCC comm region\n");
 			rc = -ENOMEM;
-- 
2.17.1



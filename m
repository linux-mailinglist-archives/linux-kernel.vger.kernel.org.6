Return-Path: <linux-kernel+bounces-168817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60C8BBE16
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 22:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFBAB21300
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 20:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96D83CA4;
	Sat,  4 May 2024 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sVtoP/wK"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7EE17578;
	Sat,  4 May 2024 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714855460; cv=none; b=o6dR2nd+zfHECC1Oo4RHNxBZG0IOF70TEq6RrxSLF1SU+mKR7mBEdYVNTBpUfcwEdjuP30WRETxU0JQr1cxaX9iQEhJYTCw4WKkt0VMpIPM4poRKWx2NbG5zHxZYHaunykRkFbGTat5gP1XlM/RymP+z5kTqIM8d83X5bh8WEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714855460; c=relaxed/simple;
	bh=Woz1MD9/NijvVG8MTLwNijJgEfXM134tNxFmEi6WXeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZAxNduux6nKMcpZZ2MESjtLGYoy4pVdrfkZPfIQ0P7OBPfHg1VQuSplFecWFGsZzkG+HGOuT3lJwOzrZ3y9mg0GFgJrPhtiJ/R0vNCwDVnfn5rUkesv2TpqOEZodls9MnJlSX14mp9bfUbZGzsVVqd2OoxHxpFweBtpEWZM1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sVtoP/wK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=/HLlbzIaJQzB0yvbypNhoOF63v0aCE5E1l/hroSiDok=; b=sVtoP/wK5kIeBu+s
	eT5gr4UfvPAlaulWIQM+/NA3wCy2dJowoNB7XwCO9FlBG/NVkmY1lLPE3MIG9GcJKmopwUhJgvjUj
	6huIU24VavxL5Y4eWtuA6kA0qhO5WfbBGK16gmra6/+eNcY/pyWl3DEbmTr8YboYQ6PN8vS7/BVuk
	bU34GYD+qAhMmdxCfKsHV0hgVBmqITpvto6Smbrc+uAyUMxDLlycfCnqSUx2pcxC1YebmjVfp++DA
	tYLCzR13BPAVdG4DT/RLmzn00EUqiVjZTGN7UU64otDnuzmYsW3c1I0UaI0XEo5i+WHGPoX3ILQco
	2cTVcmwMS//TxyjdTA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3MEn-004jGi-2X;
	Sat, 04 May 2024 20:44:05 +0000
From: linux@treblig.org
To: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] soc: sunxi: sram: Remove unused list 'claimed_sram'
Date: Sat,  4 May 2024 21:44:01 +0100
Message-ID: <20240504204401.198913-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The list 'claimed_sram' seems unused, as far as I can tell it always
has been.
I think the 'list' member of sunxi_sram_data was intended to be
used when it was on that list.
Remove them.

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/soc/sunxi/sunxi_sram.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 6eb6cf06278e6..71cc377b5e243 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -33,7 +33,6 @@ struct sunxi_sram_data {
 	u8			offset;
 	u8			width;
 	struct sunxi_sram_func	*func;
-	struct list_head	list;
 };
 
 struct sunxi_sram_desc {
@@ -103,7 +102,6 @@ static const struct of_device_id sunxi_sram_dt_ids[] = {
 };
 
 static struct device *sram_dev;
-static LIST_HEAD(claimed_sram);
 static DEFINE_SPINLOCK(sram_lock);
 static void __iomem *base;
 
-- 
2.45.0



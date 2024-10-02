Return-Path: <linux-kernel+bounces-348042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3552D98E1E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00321F24295
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30B1D1743;
	Wed,  2 Oct 2024 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x9oOIcId"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C761CF7C0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891465; cv=none; b=CEYYtmSJFo/Sgv/xDxI47tFv5EQYgI48gCmjgNCwoCG+YAxaTGv6w5t0LvkrZFVDbtI7ZlXtzmSmrUjH/knuKDDfcyE9kRmVwFTkvZuTRbeuzgYAvzQqGZx2MUP+19HrXiJhkzdaW2gqaUHm6jzKotnMAmuIf5MdymPExP2XEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891465; c=relaxed/simple;
	bh=rz8JAFjsjsVowpA2nxzzCem6/hVUcRWem+15QWeBIZ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U//l6phLjcdtIQoiM3NTJtyWYEckbwlaAolhWAr5vBabPsLMC8r132cMmOCq2VeaXQYpJZi1PF9o9qa7ruMa2mDuPYYQEJxfQXLUcfvfuNBNSe3/YPt0ZnczRoKOVp/ZhK9eCbAyuqdKiV88VJX4HXf29Pk4U/pJUJiuIBz6z0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=x9oOIcId; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 492HonLf096412;
	Wed, 2 Oct 2024 12:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727891449;
	bh=D9PCum0HyoqSpwC0i4ipngZTLS2ludQXOcLTt/aASvw=;
	h=From:To:Subject:Date;
	b=x9oOIcIdQ4fKCK786eVp28izZrfEKKj+AFEJLw99X5XocNNHcf79PYgeIiaJSHqti
	 vyuEZgxqpc2ofiOvg8GGStvsJHvu9KDY6b/0cD4X6xgrxSob2RwVUMwwLFpqoGE7Ap
	 Rrv5bG+RIcs00EQ7NOloYHr81TExET3fQMA/NGQA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 492HonXu062400
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Oct 2024 12:50:49 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Oct 2024 12:50:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Oct 2024 12:50:49 -0500
Received: from uda0214219 (uda0214219.dhcp.ti.com [128.247.81.222])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 492Hon1W127998;
	Wed, 2 Oct 2024 12:50:49 -0500
Received: from reatmon by uda0214219 with local (Exim 4.90_1)
	(envelope-from <reatmon@ti.com>)
	id 1sw3Uv-0003yB-Am; Wed, 02 Oct 2024 12:50:49 -0500
From: Ryan Eatmon <reatmon@ti.com>
To: Russell King <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        Ryan
 Eatmon <reatmon@ti.com>
Subject: [PATCH] arm: Remove build path from generated mach-types.h
Date: Wed, 2 Oct 2024 12:50:49 -0500
Message-ID: <20241002175049.15219-1-reatmon@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For reproducible builds, having any of the build paths in a generated
file is problematic.  Simple fix is to just remove the path.  This is
similar to the same code in arch/sh/tools/gen-mach-types.

Signed-off-by: Ryan Eatmon <reatmon@ti.com>
---
 arch/arm/tools/gen-mach-types | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
index cbe1c33bb871..9a2a5c0f1c45 100644
--- a/arch/arm/tools/gen-mach-types
+++ b/arch/arm/tools/gen-mach-types
@@ -24,8 +24,7 @@ NF == 3 {
 
 END	{
 	  printf("/*\n");
-	  printf(" * This was automagically generated from %s!\n", FILENAME);
-	  printf(" * Do NOT edit\n");
+	  printf(" * This was automagically generated, do NOT edit.\n");
 	  printf(" */\n\n");
 	  printf("#ifndef __ASM_ARM_MACH_TYPE_H\n");
 	  printf("#define __ASM_ARM_MACH_TYPE_H\n\n");
-- 
2.17.1



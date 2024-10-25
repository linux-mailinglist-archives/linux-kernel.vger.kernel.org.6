Return-Path: <linux-kernel+bounces-381144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276F9AFAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAB9282D76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486A1B393A;
	Fri, 25 Oct 2024 07:28:30 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAC67A0D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841310; cv=none; b=bDTdMNUy5oI0PRDFlXCpQWvi7ddvQ/iwic+WyMV3kpZHuhVnlD9KCJJ/7nksKdpaY7D87bxap5Or1+JH31BmrBR5Gz6Oi8lcV5zlgsZxoKyBBMzsNlRJvQIzFpfuiFnx6zYtG5YmQbIx5Ooku/9n/+JLKnr7hUXXPgZzsE/TEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841310; c=relaxed/simple;
	bh=IK1SYJDdVHXNB27XSsEUBnpChIyh4Z266Z25HUC1250=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WDGCPLwh7r4sjjkkO0DvA2t30ZR3BSG4+Q522r85mlGsBNAlXLQMYB/OjWZ2zeAQL9IQeBUAfkft9M7o9XkJSVkd0O3wm2H+XgNJDtGWHwugtBDDY2+sTA15cp5vhAc6VErNbAlySPxPvio1FY2ef0LvVyZhTPqVS/uvpsAsx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XZZ5r7216z1HKF2;
	Fri, 25 Oct 2024 15:24:00 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id E89E71A016C;
	Fri, 25 Oct 2024 15:28:23 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 15:28:22 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <hpa@zytor.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <pavel@ucw.cz>,
	<sebastian.reichel@collabora.com>, <bp@alien8.de>, <lkundrak@v3.sk>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
Subject: [PATCH] x86/platform/olpc: Fix not used variable 'len'
Date: Fri, 25 Oct 2024 15:42:03 +0800
Message-ID: <20241025074203.1921344-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Fix the following compilation warning:

arch/x86/platform/olpc/olpc_dt.c: In function ‘olpc_dt_compatible_match’:
arch/x86/platform/olpc/olpc_dt.c:222:12: warning: variable ‘len’ set but
not used [-Wunused-but-set-variable]
  222 |  int plen, len;

The local variable len is set but never used, so remove it.

Fixes: a7a9bacb9a32 ("x86/platform/olpc: Use a correct version when making up a battery node")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/x86/platform/olpc/olpc_dt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index 74ebd6882690..1b91702e89a3 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -219,13 +219,12 @@ static u32 __init olpc_dt_get_board_revision(void)
 static int __init olpc_dt_compatible_match(phandle node, const char *compat)
 {
 	char buf[64], *p;
-	int plen, len;
+	int plen;
 
 	plen = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
 	if (plen <= 0)
 		return 0;
 
-	len = strlen(compat);
 	for (p = buf; p < buf + plen; p += strlen(p) + 1) {
 		if (strcmp(p, compat) == 0)
 			return 1;
-- 
2.25.1



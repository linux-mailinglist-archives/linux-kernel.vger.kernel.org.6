Return-Path: <linux-kernel+bounces-190136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4168CFA00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700151C20D62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764671AAA5;
	Mon, 27 May 2024 07:24:26 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351E225D9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794666; cv=none; b=sWjxRdBsM+aYWwjj4HAek+bZzXKoYDHabPseZo0d2AmLYmVYpA+hC/C8gVS6TXtzG1/nI/XDLMfagmY/iaV9l85W4vPAfFG9aR8Ux26/XGK1N8b4qD66jPG3gHI10Hy0A7pSsvfW6aQ2A+/UnDl2Pzxnymkg2iipWF7vCv9dOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794666; c=relaxed/simple;
	bh=aPiIhR+m9iGDtxCHtCYVb7JeTUjsH3WI98/sUyxl4uA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hsqdI1I/pKep71f44ZM4GBDH9Px45WKOmZ3rqsh1J8woMeoFixsdeLhrgqTHF7H1I1doQohknkxQClkedLPMBgN8dbiViI2mlWaGu9ykLvUnWtaTYhG74WmBc7ebBOSoeJhWM7wE+MeYvbTHAk2QFGwDusfWQZU5kVLdy9+wvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp86t1716794606tnasmnbu
X-QQ-Originating-IP: /Xk/LN/8Z4qIinQBp8A8RPUX74FSdJzZpdFc91wgj68=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 May 2024 15:23:25 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: LWG2AsFjWxiu5HW3atjRW0xiWRXDEc4fT7z9nYD91M230xWwwalVIaJirul3z
	kMhmIJeGSzp0KK/C6LvpQAtaT2G7cLEghmJoEib5KjXCR9b1G725FHUhT4kpcfpKecSkdub
	pzOsW1yLgk6Qw5zUSyF1pJBM47Tlxj8wGDUyjzDjXa7fXmJAVPsV7sYAIhGjGvroorRVCaN
	E2pLo9H4mUQcF0AOewfLkmXDBrKAgg2goIB+oKIIcVpk9Ag2pQO1DkKJiOugjvcc7cXJ6b5
	iapqOwea25jBdz5mumnzlM13D6eH1A85NRp9VFEoGiAh5zMh02DS4gSHhgOn1VmKXcjkGV2
	3ZfNxdO+2Sthp6hiWvyw+9oQi53T6wc89I9MsrkFKvBwXh528a5HGA+CEASow==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8843610495016260499
From: tuhaowen <tuhaowen@uniontech.com>
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	huangbibo@uniontech.com,
	wangyuli@uniontech.com,
	tuhaowen <tuhaowen@uniontech.com>
Subject: [PATCH] dev/parport: fix the array out-of-bounds risk
Date: Mon, 27 May 2024 15:23:22 +0800
Message-Id: <20240527072322.26130-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The array buffer size is 20 bytes.
When executing code in a 64-bit CPU environment, up to 42 bytes of
data will be written into this array
(the size of "%lu\t%lu\n" is 20 +1 + 20 + 1).

In fact, this line of code for 32-bit CPUs also has the risk of
crossing the boundary, but it can exceed 2 bytes at most. With good
luck, it is local variables that are damaged, and there are no serious
consequences.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 drivers/parport/procfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index bd388560ed59..9f501d5fa1ec 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[64];
 	int len = 0;
 
 	if (*ppos) {
-- 
2.20.1



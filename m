Return-Path: <linux-kernel+bounces-553497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D794A58A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F8E3AAA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320AB192D70;
	Mon, 10 Mar 2025 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScPWVe2q"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0E5D477
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573992; cv=none; b=nfOfgctR/8dm8L1XdC22oijHdNrHe3loKGfruSTqcZupRuEBGoUTwl3Uz9qOb9DdfbuaGF49qwUfuKn7EXLWA67RXEEnAXxm4re0n90V7i/ZUU+7nl6N7TcDBFvBc27oCU2pKfeCz6JfHLVEwmdCtWfN3gPIHvz1toT7hpDLyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573992; c=relaxed/simple;
	bh=+Uvl5eyr1GY7S560wvBpkuEmL+MwllzTbiyZAPDACAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0inpKaguh1xGpM3yW5/whuNtqY004jrEfhgY0RpzZyF3Vjl1CAqH3oLFv6lV2CRNBSvzzSoE0CmAzobbzl6/2Y0tQ/Gr9+gSfZg/TTQkcddjEVIdjplSDpy88bVeDtsBJgrXS2WbG9ApS5vqfmPyZzDW09iQuIxIqS8dmOheTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScPWVe2q; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so6980904a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 19:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741573990; x=1742178790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcbapetLovo2W2SepHXGcQe6qkTViLueaqQf7erxU7E=;
        b=ScPWVe2qTO6M0icw+/QXArNIUqhtve+IQu4Sr/aPVVqhCyD/0I7lyCdF/7eJckDYMy
         vV5X0IfCTzOzxpG7PpvWiPTXo1p2Pr1H2Hdnu2P2wbKogq3079Q7t/LhMmMMWQ1VQoLE
         dQJvhd2kJfTz8VlZ0WNHdnhzYCTx4Uw7xHUXNQlyzDp0nyLGyHX863UByxDpLL8Nz9+L
         otx3g97ycfnx7vG0yL2lL8v8cHUdMbOrb2fL8Fq5lW7HCa//L93CozjvHcp5drh2ss3Y
         HXndMpINEKzMHIQwyY7OVOoSwtjphAB2Z+0H/5is2AvnVYDvrQGKo7eishtrMQu/rL+7
         z4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741573990; x=1742178790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcbapetLovo2W2SepHXGcQe6qkTViLueaqQf7erxU7E=;
        b=a0YU3ZXHgOdLBCpGj5dfDRqGU5HjcyM7zbbj2+mbD4phRB5inorT3SX2GNkMW7hc5G
         tJ6Bn9F/4m7xXETvgvlsk8Xkw59yJBOlFZnChDn56TZ1iVGUDUrEiRBaz1MDprGB/Jna
         lih0P2sAoF9bt4R8ykJ38pIjF/vFeMQjKxz2Uh6amC8Zc5Ly10sHucECmOzTe+5QUXZO
         MiFu5duy+ihCnLz11WqODtrC16HPNLk9sVcmRJCLoEJtzKCcXynMy7EcB+okMBu86f1u
         eiVFP98bm7IpckM9n+5JgFH8sOqZKnhhy3HX1koFpaMjVrN+QB8h3yllh6i28rGT2MI+
         xxFw==
X-Gm-Message-State: AOJu0YxHF4XQxOdLG54UZkL6qzwPM1D1XB7+PwR8MFn3K5IrSjQMkYeI
	rDqBF25w/Zf6SMukxj9Fuvvd2IeQuhdQaHuUhFDptgDMJtn3/6Va
X-Gm-Gg: ASbGncuiiUVtj2R5asjALJz8DjTUZ95fSXFE84c0/zDvsEEufLBhK6NvURqCsSPb5V5
	tDwFsBnwcIE2M/tdGhqOTvTFvTrA/nfnVwD5F9vyjV02wsxgf3t5VGE0w/F+8KW6kSdZTma5vLh
	2HgNXvURqsSx+IUrAFbRRnOhHcb4rAiptdMTgxxm3IH8MYfRcCh1mc5MdGMWGyJNFDTNi1lQkBv
	Iz5+nkU92fU+xevsknfZXChv/NUUdcdZI3O6F/jbCB+XiWdb1cd43bXKHFd6qGt+qTSGUOgeN5L
	o0HvwJ66X2rnQkVNimxzMiAKbP1LCT3OLmIQ/cQH7TxC9XjbMf1j6Rs=
X-Google-Smtp-Source: AGHT+IGx+M7ljHG/mywM9Shfk4AJAJeRI74bZst+ADOJcoz6pHAEQqSE+VDO4Kbs+P5TxbQMWbpVYQ==
X-Received: by 2002:a05:6a20:938a:b0:1f5:7eee:bb07 with SMTP id adf61e73a8af0-1f57eeebfc8mr2342083637.1.1741573990431;
        Sun, 09 Mar 2025 19:33:10 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bb5fcd68sm3906592b3a.135.2025.03.09.19.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 19:33:10 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v1 1/1] i3c: master: svc: Fix i3c_master_get_free_addr return check
Date: Mon, 10 Mar 2025 10:33:04 +0800
Message-Id: <20250310023304.2335792-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

The return value of i3c_master_get_free_addr is assigned to a variable
with wrong type, so it can't be negative. Use a signed integer for the
return value. If the value is negative, break the process and propagate
the error code.

This commit also fixes the uninitialized symbol 'dyn_addr', reported
by Smatch static checker.

Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/029e5ac0-5444-4a8e-bca4-cec55950d2b9@stanley.mountain/
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index f22fb9e75142..1d1f351b9a85 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -940,7 +940,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 					u8 *addrs, unsigned int *count)
 {
 	u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
-	unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
+	unsigned int dev_nb = 0, last_addr = 0, dyn_addr = 0;
 	u32 reg;
 	int ret, i;
 
@@ -998,10 +998,11 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			 * filling within a few hundred nanoseconds, which is significantly
 			 * faster compared to the 64 SCL clock cycles.
 			 */
-			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
-			if (dyn_addr < 0)
-				return -ENOSPC;
+			ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
+			if (ret < 0)
+				break;
 
+			dyn_addr = ret;
 			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
 
 			/*
-- 
2.34.1



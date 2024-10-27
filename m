Return-Path: <linux-kernel+bounces-383647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF099B1EB9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078CA1F21806
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095BB16F8F5;
	Sun, 27 Oct 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FTlfTqoT"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFDA16DEA9
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039118; cv=none; b=BB7KkW5aJkOSCnip1pvP7dF4FBreTRAhcHXfGEdhDrhPBuZK/6Za2T3b0qNI1etMGiTkZrQSgmExZaRYSxTUjUAAri2p+v4dq6M/YJLq6p4cVCJ310c/TQoOGAvWj/NZbLTZdsl0aX7zQZf8vr9oaFGagrCugg3yD3js0dPKiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039118; c=relaxed/simple;
	bh=zYDWsatrAEYiMVbaBg+FS3dlDr6tObizWONN/5+LERg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIX5qbr03Cg4raLqT+jw1vBEyMHfIlGRznmQNB3C92T3QLPisLwnTWFddGFwG+KP6HOKzBmZtyHs/W828WFZiMsR7MchrV/ll9x7LcXkRN2QGTWE4CBYfDJGgVqS01m6f/7LWZPhvDW+v/FW65CKnOLYJEzB/QwaMw36K3HITUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FTlfTqoT; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730039109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=90TbkQToyaIIp8wtsz9zjfvHhI1P8wFuLM/XlwUgLjE=;
	b=FTlfTqoTAEHECs/qbgOUYTMkQnjc1H5HS1P8c/ip8pGcDEbEOLBTO4JQcV7ecfvTuSHBap
	4OEidYx+LPbhgy5bXUPkZgv0f6K0UyB40gJNO7A1Wqp3di20sHM0xT3weZxXsFN+i+3MbR
	VGOhV+V589dPdvelnnv79Ie9PhqLIYA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Russell King <linux@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yanjun Yang <yangyj.ee@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mm: Use str_write_read() helper in die_kernel_fault()
Date: Sun, 27 Oct 2024 15:24:16 +0100
Message-ID: <20241027142417.75809-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_write_read() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/arm/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ab01b51de559..b2d59d260a1f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -136,7 +136,7 @@ static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unable to handle kernel %s at virtual address %08lx when %s\n",
 		 msg, addr, fsr & FSR_LNX_PF ? "execute" :
-		 fsr & FSR_WRITE ? "write" : "read");
+		 str_write_read(fsr & FSR_WRITE));
 
 	show_pte(KERN_ALERT, mm, addr);
 	die("Oops", regs, fsr);
-- 
2.47.0



Return-Path: <linux-kernel+bounces-398101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE989BE55C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552741F24AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6933A1DD547;
	Wed,  6 Nov 2024 11:15:13 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92DA1DE89E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891713; cv=none; b=UqSFzZb3xpWcK/204x3BugZcO7VHRg4ZznBzaMyjGBJRVBEiTHuXJ+IukIJuyooUczYbbIXedrIS6JKsmFd/NlF5KQqeUcgQiOqNWH8mM1kd72KVSfbPmy8c4qf8mfLNOd4ewwZt04Obmva4wlxr/ERnPyySxcB8ucJcSdWFqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891713; c=relaxed/simple;
	bh=DzxmMznsK93waCeQ8Slt0XMiputj9n5t55vd8rStUFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQH0bm/ZQ807sCtEQI4LY+qhJh+TS5YGgHRBJXHdRQnIONsHl1diLdm3VhyhQOXcdpAIYPO+Zmkim5jOlMc5gPF5bx+hPmyuyFqlGshJJZcY6yp/ZJLpUz8ERCgvk4TI23p/i+g8mt5ZRihlIkcy3a7ZDzPg2nsoYeiEa15FC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5672b4fb205f-df071;
	Wed, 06 Nov 2024 19:14:59 +0800 (CST)
X-RM-TRANSID:2ee5672b4fb205f-df071
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5672b4fb23ce-26439;
	Wed, 06 Nov 2024 19:14:59 +0800 (CST)
X-RM-TRANSID:2ee5672b4fb23ce-26439
From: liujing <liujing@cmss.chinamobile.com>
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] char:ipmi: Fix the wrong format specifier
Date: Wed,  6 Nov 2024 19:14:58 +0800
Message-Id: <20241106111458.2157-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the types of io.regsize and io.regspacing in the ipmipci_probe function are unsigned int,
they should be output in the %u format.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
index b83d55685b22..8c0ea637aba0 100644
--- a/drivers/char/ipmi/ipmi_si_pci.c
+++ b/drivers/char/ipmi/ipmi_si_pci.c
@@ -118,7 +118,7 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	if (io.irq)
 		io.irq_setup = ipmi_std_irq_setup;
 
-	dev_info(&pdev->dev, "%pR regsize %d spacing %d irq %d\n",
+	dev_info(&pdev->dev, "%pR regsize %u spacing %u irq %d\n",
 		 &pdev->resource[0], io.regsize, io.regspacing, io.irq);
 
 	return ipmi_si_add_smi(&io);
-- 
2.27.0





Return-Path: <linux-kernel+bounces-303115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB441960795
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB521C2207A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1218319D8A2;
	Tue, 27 Aug 2024 10:36:33 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE3182B2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754992; cv=none; b=mM/8s5gyONkebODl4vtvdO4U/NimSr3yVryIY1NNT7mfyfTZCcjHSNwtyqT2a6Qq1HGbTu+lLvLno/DnFxIUAU1mn3IBsAy6/z3cu/jyo2Hbk8QSO7MwjDEtwtWTuKObqIEgxS7j40xDtP7Qw2vsdZv68oRoa/8tSnOvm4bFOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754992; c=relaxed/simple;
	bh=v+MSMEyRsdso5jh7+4FCdf+iXX4bB7T8C+D9NMJOOFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NM1jas5oQEyn9PtxaIpYabVGaohCeSZ0jAUMQhtuGgOdnY5CjymXijknA5RktIk9mabfeUF+6AtQSmOZZrbFgZvPU/Fx2S6I46EE70s/hySv61iAh6x1WmvJakV18j+fnb5RZKg9Nw+yE1iz0c2OOS/6RqBDTdUDesXtEDaDOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id YKL00012;
        Tue, 27 Aug 2024 18:35:12 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 18:35:12 +0800
Received: from localhost.localdomain (10.94.8.212) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Tue, 27 Aug 2024 18:35:12 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <minyard@acm.org>, <Asmaa@mellanox.com>, <vadimp@mellanox.com>
CC: <openipmi-developer@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <liuyanming@ieisystem.com>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] ipmi: ipmb: Check devm_kasprintf() returned value
Date: Tue, 27 Aug 2024 18:35:08 +0800
Message-ID: <20240827103508.2092-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20248271835134c8eb9de200cf2d731de7bc6944f5735
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure but this returned
value is not checked.

Fix this lack and check the returned value.

Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 7296127181ec..791dda361196 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -321,6 +321,9 @@ static int ipmb_probe(struct i2c_client *client)
 	ipmb_dev->miscdev.name = devm_kasprintf(&client->dev, GFP_KERNEL,
 						"%s%d", "ipmb-",
 						client->adapter->nr);
+	if (!ipmb_dev->miscdev.name)
+		return -EINVAL;
+
 	ipmb_dev->miscdev.fops = &ipmb_fops;
 	ipmb_dev->miscdev.parent = &client->dev;
 	ret = misc_register(&ipmb_dev->miscdev);
-- 
2.31.1



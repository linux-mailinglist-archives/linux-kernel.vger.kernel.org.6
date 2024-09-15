Return-Path: <linux-kernel+bounces-329905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1697974C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E95B21750
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3A91C7B79;
	Sun, 15 Sep 2024 14:49:58 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32D1C6F6E;
	Sun, 15 Sep 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411797; cv=none; b=Y76SQuAzZhvB2k7yPm/Ou+stX/PdzdNIhTy+HM7H33sK9nJeXiUFj+G/KBSwrbgJfUfQKzBAg+4iOygY4BsBEuIIZzDQK1QCYgeUYUBzzIyqV6TgK0LzuLAdSWh+vo6gC0+BnPaz8Ha/h/m9kutR508ivGnZgX7msr0iAroCuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411797; c=relaxed/simple;
	bh=QkyEFJBS3vifcGy0kSnIOT4GQR6Cs+7WvhnKDUpt/rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nn00RtRYKt603BVHGRDz/+CMUcb+/Lf8DFLmnIXG6+VF3lu4vvrF6/nBmEJm+uG3VeLPjnlpIlY0IRVL59f5x/grgH3PhBLGwHGAeiGb+bE+Q+P10nuL6QTlJKVs2tCijHzDNIFh9hJmI/i/b/atKfeDKODgCp1+Na2GfH0LrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpip2t1726411645txvd65k
X-QQ-Originating-IP: SOHRkuydfx4I6TjMUSremBpQBJlecf2ngxV/C3P6LDE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 15 Sep 2024 22:47:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14811978415710129958
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: davem@davemloft.net
Cc: wtdeng24@m.fudan.edu.cn,
	21210240012@m.fudan.edu.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	przemyslaw.kitszel@intel.com,
	pabeni@redhat.com,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH net v2] net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition
Date: Sun, 15 Sep 2024 22:40:46 +0800
Message-Id: <20240915144045.451-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

In the ether3_probe function, a timer is initialized with a callback
function ether3_ledoff, bound to &prev(dev)->timer. Once the timer is
started, there is a risk of a race condition if the module or device
is removed, triggering the ether3_remove function to perform cleanup.
The sequence of operations that may lead to a UAF bug is as follows:

CPU0                                    CPU1

                      |  ether3_ledoff
ether3_remove         |
  free_netdev(dev);   |
  put_devic           |
  kfree(dev);         |
 |  ether3_outw(priv(dev)->regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
                      | // use dev

Fix it by ensuring that the timer is canceled before proceeding with
the cleanup in ether3_remove.

Fixes: 6fd9c53f7186 ("net: seeq: Convert timers to use timer_setup()")
Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
---
v2:
- turn the LED off before delete the timer, suggested by Przemek
- add Fixes tag
- Link to v1: https://lore.kernel.org/r/20240909175821.2047-1-kxwang23@m.fudan.edu.cn
---
 drivers/net/ethernet/seeq/ether3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index c672f92d65e9..9319a2675e7b 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -847,9 +847,11 @@ static void ether3_remove(struct expansion_card *ec)
 {
 	struct net_device *dev = ecard_get_drvdata(ec);
 
+	ether3_outw(priv(dev)->regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
 	ecard_set_drvdata(ec, NULL);
 
 	unregister_netdev(dev);
+	del_timer_sync(&priv(dev)->timer);
 	free_netdev(dev);
 	ecard_release_resources(ec);
 }
-- 
2.39.1.windows.1



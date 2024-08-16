Return-Path: <linux-kernel+bounces-289668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA019548F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467F02873EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BBD1AC425;
	Fri, 16 Aug 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="NVr6JfYf"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA72E859
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812134; cv=none; b=OLUg0JPc5CYCI+LcXnCZRx4ygt94dRvGWNUVjFtCjMUP89+qZKmRcoAtaZwxKjeGoDss+XBB1OLYBFr2NwkA/J2Ys69wl5HBoMIqQqzCku6LJkcw/8HY8bhjaWwT8VcXnKH7mWeb9yMliO7HycQMANo5/0gm0+PJDYCL7Yzfz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812134; c=relaxed/simple;
	bh=sF0dNzfSIqtPCamjjg4ICQJcK0LPVhHebOf5ZflD/uM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BzLPA4JoER1V15KgKxCukSKYo7uODVTrUM9soTk35kzxBGtZ+niJ1O47zXDmrqu+vyDVRTltNvTQIXw540tUNX+CzjcLKmfHniidtdgpZ1KwHVnfAALG+yvCNITNhhpOXwCFEEuou0FZXn575c3RGYSxf6jv3PJjtagRETNf6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=NVr6JfYf; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723812119; x=1726404119;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sF0dNzfSIqtPCamjjg4ICQJcK0LPVhHebOf5ZflD/uM=;
	b=NVr6JfYfnr+7nlk6pHbl79ehkJx5e1GgvoXS4t430vE6qjPLaUizGbSWF9zKWrgx
	7yWEmKUDgbm6/uVT/I/XO3CpE1WH3SUN/Uxmrxc0991beUoMIT/4xHV4oSYlsZFd
	F0aB1H/EFuSWgBGQRT2y1SEPfFJHLmnXY8N7N+DG7Kk=;
X-AuditID: ac14000a-03251700000021bc-70-66bf49175b97
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1E.21.08636.7194FB66; Fri, 16 Aug 2024 14:41:59 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 16 Aug
 2024 14:41:59 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC: <upstream@lists.phytec.de>, <heikki.krogerus@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <javier.carrasco@wolfvision.net>,
	<abdelalkuor@geotab.com>, <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] usb: typec: tipd: Free IRQ only if it was requested before
Date: Fri, 16 Aug 2024 14:41:50 +0200
Message-ID: <20240816124150.608125-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWyRpKBR1fcc3+awbyX2hanzu1ltmhevJ7N
	4v7JDUwWXat3slj8bTa1uLxrDpvFomWtzBbd79QdODwmLLrK7DHvZKDH/rlr2D36u1tYPT4+
	vcXi8XmTnMf8348ZA9ijuGxSUnMyy1KL9O0SuDK6Z1xlLpjMU3GkYR1TA+Nmri5GTg4JAROJ
	w/v3soLYQgJLmCRWNPF0MXIB2Y8ZJdYvvcMIkmATUJe4s+EbWJGIgL3ElclfWECKmAUOM0pc
	3dzI3MXIwSEs4C3x+7IPSA2LgKrE+6vXWEBsXgELiWl9C9kglslLzLz0nR0iLihxcuYTsBpm
	oHjz1tnMELaExMEXL5ghDpKXeHFpOQtM77Rzr5kh7FCJrV+2M01gFJiFZNQsJKNmIRm1gJF5
	FaNQbmZydmpRZrZeQUZlSWqyXkrqJkZQ2IswcO1g7JvjcYiRiYPxEKMEB7OSCO/TL3vThHhT
	EiurUovy44tKc1KLDzFKc7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTAuNDvIvt7kwz3V
	g2n8bt8DLl7Lu6GlP0mhzCqnQ7HFhGVx9FahqEa7mm53drX87YU1W7a1cz/y3CL/p6dXalHU
	rB67X6f1npfpMYuvvLl6h255dGRnwQG1JamNlc33T/W+l1Pc1My07MUmrR/Pwqz07j80Dai1
	Ofe5cVPFrROZcXef3ReoMFBiKc5INNRiLipOBACbb3VsaQIAAA==

In polling mode, if no IRQ was requested there is no need to free it.
Call devm_free_irq() only if client->irq is set. This fixes the warning
caused by the tps6598x module removal:

WARNING: CPU: 2 PID: 333 at kernel/irq/devres.c:144 devm_free_irq+0x80/0x8c
...
...
Call trace:
  devm_free_irq+0x80/0x8c
  tps6598x_remove+0x28/0x88 [tps6598x]
  i2c_device_remove+0x2c/0x9c
  device_remove+0x4c/0x80
  device_release_driver_internal+0x1cc/0x228
  driver_detach+0x50/0x98
  bus_remove_driver+0x6c/0xbc
  driver_unregister+0x30/0x60
  i2c_del_driver+0x54/0x64
  tps6598x_i2c_driver_exit+0x18/0xc3c [tps6598x]
  __arm64_sys_delete_module+0x184/0x264
  invoke_syscall+0x48/0x110
  el0_svc_common.constprop.0+0xc8/0xe8
  do_el0_svc+0x20/0x2c
  el0_svc+0x28/0x98
  el0t_64_sync_handler+0x13c/0x158
  el0t_64_sync+0x190/0x194

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/usb/typec/tipd/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index dd51a25480bf..256b0c054e9a 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1465,8 +1465,9 @@ static void tps6598x_remove(struct i2c_client *client)
 
 	if (!client->irq)
 		cancel_delayed_work_sync(&tps->wq_poll);
+	else
+		devm_free_irq(tps->dev, client->irq, tps);
 
-	devm_free_irq(tps->dev, client->irq, tps);
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
 	usb_role_switch_put(tps->role_sw);
-- 
2.34.1



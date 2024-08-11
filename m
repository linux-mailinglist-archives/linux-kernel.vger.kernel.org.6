Return-Path: <linux-kernel+bounces-282091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43FD94DFA3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46159B213C1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A1F171BB;
	Sun, 11 Aug 2024 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Qj4UjuOs"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16A17BD3
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343125; cv=none; b=tFkF+bY53lqYQDeT3GOWghIl8/ATGJVyCTGiai+BKNY0FRFGAXLoWJr4Njux9n+YVUkPQluEtsC0qsIWBBXg3UKffbhvr8QF6USbTXfkJVqKy5SP/OJGyl/bY22tRpjua61+tv+rD+LNlIGRaQ5dPaY9ILAu+GtMWKGRan/5tZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343125; c=relaxed/simple;
	bh=dQTlaHXUFgfsmj2Lw2/TT4Rt6c+clI2AtfZ+RlX3jps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDpx0EoRXChxB4BZN4/YUdiPKw1Bwy7aojlHIyiL3emY+oboJIXYlFI5mU2q7LJ+IX81ORBmUqKhUNZ8i6Qh9HwM0CAqtuE+AVP1fkvg7I4I3gV6DQMBXRPfCiYXR02Rl0kIHD6gVl2UxnZ2Ctr9OE1jfVByfhsmG1U4E3XT1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Qj4UjuOs; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343124;
	bh=2VcPsd7HHLMiNqCMN+JyCrrtl2begrjoUL5rrJZMpqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Qj4UjuOsDLdajhKSDX4vG3IfpWlMncpxSIExuKkYo5n7idW8psYOHbP7XEkbf97Rp
	 tNWlP7h+Yxo0STnuBotTwE+s01Qi7NwIBObQX3k4P3e55QtW7jzLeSLSrOZ6R4wNZw
	 2SBm+pVOSeHe7cLyg6Ns990Gmqi+gLjxulV32Zn3gwvdn2laKVUlPeiztFLQPTej3M
	 3OGcu5N3Xl3pY1HuoCAQrTh/rjacJz6EJyp06HuRwRnHsxUkjl6e7X5bFLzQMj2EoL
	 1GzZZYi8OlGD8IgFuPTIt7HIkW/G3VE+URIDhz+4NH/PeqNX3kJQL702DjmFW98fmw
	 Wrt0Pury1Vg4Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id C8B5A1349C09;
	Sun, 11 Aug 2024 02:25:20 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:24:54 +0800
Subject: [PATCH 03/27] serial: core: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-3-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: GVfeQH255DYcEPtnxx0vhCnsH0ZzA3Yi
X-Proofpoint-ORIG-GUID: GVfeQH255DYcEPtnxx0vhCnsH0ZzA3Yi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
serial_match_port() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9a18d0b95a41..d22a9db8f54e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2368,9 +2368,9 @@ struct uart_match {
 	struct uart_driver *driver;
 };
 
-static int serial_match_port(struct device *dev, void *data)
+static int serial_match_port(struct device *dev, const void *data)
 {
-	struct uart_match *match = data;
+	const struct uart_match *match = data;
 	struct tty_driver *tty_drv = match->driver->tty_driver;
 	dev_t devt = MKDEV(tty_drv->major, tty_drv->minor_start) +
 		match->port->line;

-- 
2.34.1



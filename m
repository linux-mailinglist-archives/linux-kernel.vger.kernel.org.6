Return-Path: <linux-kernel+bounces-427075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181059DFBF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BDC281A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4171F9A90;
	Mon,  2 Dec 2024 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IKGE5XsA"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166321F9A92
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128426; cv=none; b=Rm+NEsEz8mD7wPYroWlO3If3ulPqLcA6BHQSkHjGqaEme9BG+kK52eC+UUFSEZ3UZ8JDg5zmMuEb6HJ4IpeumgJclDPjCbbNV9st5yJV3JfarmrAXRrGiSvl7gBpm7U73W6jSoK6VgxMUn7xMIH4LbnpIJJNw8BbAF5m6Q3XvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128426; c=relaxed/simple;
	bh=bfLBtlmbc2Pn2pQZpnvTNRR67h7skReTe3s4tW7NDME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ib8BFRBn1631xeWUOaj0BsDaYRakkeKCLIM+o9XMF+5bViBYxdvgbvG/j1m4jcbr5axqtv45H09zKjulm5nsnzNLut6x5+IryUxEifaoI7U0UYVF6jTZ+thzIdOXUDgv+ahbVjmH+8YHq8+7wwuTs6jkLzU1f+4CKJQHXtO3+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IKGE5XsA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=8ijJAaQZJUatxI
	R/coQwKygqN3dUxNOLIrfB5ZX6Hy0=; b=IKGE5XsAbNOrj1CDhf7VH4vxHo6w8I
	f0fHbL5iZmBd4L0OK+op7ktcbzMO8q/scicngO2KwohiYouw/SyFSDIKyWsMH187
	RwRwuWdSz3EMCSBTKEIjkjVB3qKs51KkkDryC7B/VC1ZJTLRFnTq+IXJUJaMyhy3
	O542z5fdTKQ020xT+oM+ueHWxg6U0VVCJS90Me/BHdUY85XvRup9AIxl2f1cbmVJ
	Ltb6YlglHRLdL078EMYZczaAxdzY5BXna0PJNVdb0sSYL56q/q2rJ6s+Dyd9UVaz
	rIveXfzB58/P6HOWONdWvw4fv0JgnTYfGGiMMfsmL0ogZeEoUeWY0RPA==
Received: (qmail 2439680 invoked from network); 2 Dec 2024 09:27:00 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Dec 2024 09:27:00 +0100
X-UD-Smtp-Session: l3s3148p1@00T/T0UoYusujnum
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: keba: drop check because i2c_unregister_device() is NULL safe
Date: Mon,  2 Dec 2024 09:26:58 +0100
Message-Id: <20241202082658.9673-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only. Please apply to your tree.

 drivers/i2c/busses/i2c-keba.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-keba.c b/drivers/i2c/busses/i2c-keba.c
index 759732a07ef0..7b9ed2592f5b 100644
--- a/drivers/i2c/busses/i2c-keba.c
+++ b/drivers/i2c/busses/i2c-keba.c
@@ -464,12 +464,8 @@ static void ki2c_unregister_devices(struct ki2c *ki2c)
 {
 	int i;
 
-	for (i = 0; i < ki2c->client_size; i++) {
-		struct i2c_client *client = ki2c->client[i];
-
-		if (client)
-			i2c_unregister_device(client);
-	}
+	for (i = 0; i < ki2c->client_size; i++)
+		i2c_unregister_device(ki2c->client[i]);
 }
 
 static int ki2c_register_devices(struct ki2c *ki2c)
-- 
2.39.2



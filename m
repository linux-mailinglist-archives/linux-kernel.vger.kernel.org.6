Return-Path: <linux-kernel+bounces-427407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9269E00ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D013B202EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916B1FDE04;
	Mon,  2 Dec 2024 11:22:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F911FDE0B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138565; cv=none; b=f7dyCvT24f6hiRFxpRY1Rz5oPzP6TCNEX9sJll7zAXwB/B6HAxpjUIuDwMEc8pYhq8it5ajsrMYM3WjcDm403FJDE9gsT4tauAkYFbxIYomECaNlHyHyAh5VG09O3kFJZzFXwbpAbvnctJ3f8MYLUMMqUFkYpCFc1sMxirBmS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138565; c=relaxed/simple;
	bh=P8t38gZgVtQGfHlRwL+12Evj7x6PEBaDv2Q4YuWoIQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqZUVomlg12/up/uLteLDsHBS39RusAiS5Hdsns6PzTB3dCcUjC5md4Hlp2PtlpXg/+mv3Zk2Y1i52LwcePW2/4jSTDBRq0fgjmqLOgJR9fCMjNB3XpLEwMmzKVMHU/1+tQ2YeaVsi+9o32JOlcRqYi89vwlHKrDsXTNrU56nsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI4Ve-0000UH-EB; Mon, 02 Dec 2024 12:22:34 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI4Vc-001Hsx-3A;
	Mon, 02 Dec 2024 12:22:33 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI4Vd-003R1L-2A;
	Mon, 02 Dec 2024 12:22:33 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 02 Dec 2024 12:22:29 +0100
Subject: [PATCH v2 1/4] nvmem: imx-ocotp-ele: simplify read beyond device
 check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-imx-ele-ocotp-fixes-v2-1-3c021a97eb5d@pengutronix.de>
References: <20241202-imx-ele-ocotp-fixes-v2-0-3c021a97eb5d@pengutronix.de>
In-Reply-To: <20241202-imx-ele-ocotp-fixes-v2-0-3c021a97eb5d@pengutronix.de>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 stable <stable@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733138553; l=1029;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=P8t38gZgVtQGfHlRwL+12Evj7x6PEBaDv2Q4YuWoIQI=;
 b=DasEWzoF6ivaUdopeZSea2AgkEgyHZjhfiWd2ODse1tTTQJ7TQrl90n+TxlMZQthwA7kUTQ61
 U/nxZmnN4mTAxLnoI8gz77cuGsFHOvvn+MW/dYwxfs+4R52WGpO/4Ca
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Do the read beyond device check on function entry in bytes instead of
32bit words which is easier to follow.

Fixes: 22e9e6fcfb504 ("nvmem: imx: support i.MX93 OCOTP")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: stable <stable@kernel.org>
---
 drivers/nvmem/imx-ocotp-ele.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index 1ba4944976987..2e186b7d3b040 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -72,13 +72,13 @@ static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, siz
 	void *p;
 	int i;
 
+	if (offset + bytes > priv->data->size)
+		bytes = priv->data->size - offset;
+
 	index = offset;
 	num_bytes = round_up(bytes, 4);
 	count = num_bytes >> 2;
 
-	if (count > ((priv->data->size >> 2) - index))
-		count = (priv->data->size >> 2) - index;
-
 	p = kzalloc(num_bytes, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;

-- 
2.39.5



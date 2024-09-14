Return-Path: <linux-kernel+bounces-329481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048409791DF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372251C21501
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648911D0944;
	Sat, 14 Sep 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mNY1rBPx"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79571E487
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726328519; cv=none; b=MdcybymE580BuLjaHNOnrPZEaYQRsxFUh2S75ebuLCYDN4Ue43qqeO0JyKn/K5jSe4pkFxHj3CWHwPuHxDLkE/qf+THnkpyluD3eiTui9Pd7bwixqcaFfLai2IByzmkhhmsVeCe8mwRvMy0foeSmHRTr/chylTJl5L0xKwraJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726328519; c=relaxed/simple;
	bh=MlOD187Zi5ij3VslII2JeRMUAl8BTdsRdLzSQpk5oXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EInk196o+xsYC5TOhlyorlNU324XFAMvHkkw+1o4T5zNTMf4LtU+Cq3pCmjGPZtVdNuqrD47dXtUGBP5JNYaVDIuOzJuuFBodmYihbJWb0Q3j6zr/AFEZ0b1Vk+A9zkze7Zw2qDadn/LE6rrCSG7wYuDKfqU8U9NTbYjcifNjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mNY1rBPx; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pUuBs2kqnUkczpUuBsZAQc; Sat, 14 Sep 2024 17:41:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726328509;
	bh=vKwgWmnbA3QuKEEAm+WYy246t2HIUMAY8j3NUoCGyt8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mNY1rBPx7uKcmPSEqculwktpC2nlZFtzTXcFJH3B9ymaBW8/IXxXeBCeAX/nhDEj8
	 89sii0RP3HK5yInShqEwlZbaKgNBVkJ9FXnpSGDHoZbCN8Ivpl6fmlf9g0y1HcZ/Fx
	 EtxyozzbtffLfaUwSpTBDxmrjikr0M8eqpDuj29/F7d4EfpCAWgVq6YiYlOBPCO+V6
	 Gwjh6VQ1boVtyypHT8TRjMUzSMBH4EFL2TihF4OPNgpe1Bgek5ZJHud9WhOj3vYSh1
	 /APrimk0qqLqekhT1c8zGP7TdjdbiQk1ioNbYMTkXZ5alwfKfYHpGSyKAIbTCkZvCL
	 yK9BUK+Eyx0lA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Sep 2024 17:41:49 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Beleswar Padhi <b-padhi@ti.com>,
	Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v3] remoteproc: k3-dsp: Fix an error handling path in k3_dsp_rproc_probe()
Date: Sat, 14 Sep 2024 17:41:13 +0200
Message-ID: <591e219df99da6f02c9d402f7854bc3ab23e76f9.1726328417.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after mbox_request_channel() in
k3_dsp_rproc_request_mbox(), mbox_free_channel() must be called,
as already done in the remove function.

Instead of adding an error handling path in the probe and changing all
error handling in the function, add a new devm_add_action_or_reset() and
simplify the error handling path of k3_dsp_rproc_request_mbox() and the
.remove() function.

Fixes: ea1d6fb5b571 ("remoteproc: k3-dsp: Acquire mailbox handle during probe routine")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andrew Davis <afd@ti.com>
---
Compile tested only.

Change in v3:
  - pass the correct variable to devm_add_action_or_reset()   [Mathieu Poirier]
  - move the devm_add_action_or_reset() call just after
    mbox_request_channel() and simplify error handling in
    k3_dsp_rproc_request_mbox()
  - Because of these changes, remove previous R-b tag

Change in v2:
  - fix the subject (cut'n'paste issue)   [Andrew Davis]
  - add R-b tag

v1: https://lore.kernel.org/all/9485e127a00419c76cf13dbccf4874af395ef6ba.1725653543.git.christophe.jaillet@wanadoo.fr/
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 8be3f631c192..f0da29fa7f60 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -224,6 +224,13 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
 	return ret;
 }
 
+static void k3_dsp_free_channel(void *data)
+{
+	struct k3_dsp_rproc *kproc = data;
+
+	mbox_free_channel(kproc->mbox);
+}
+
 static int k3_dsp_rproc_request_mbox(struct rproc *rproc)
 {
 	struct k3_dsp_rproc *kproc = rproc->priv;
@@ -242,6 +249,10 @@ static int k3_dsp_rproc_request_mbox(struct rproc *rproc)
 		return dev_err_probe(dev, PTR_ERR(kproc->mbox),
 				     "mbox_request_channel failed\n");
 
+	ret = devm_add_action_or_reset(dev, k3_dsp_free_channel, kproc);
+	if (ret)
+		return ret;
+
 	/*
 	 * Ping the remote processor, this is only for sanity-sake for now;
 	 * there is no functional effect whatsoever.
@@ -252,7 +263,6 @@ static int k3_dsp_rproc_request_mbox(struct rproc *rproc)
 	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
 	if (ret < 0) {
 		dev_err(dev, "mbox_send_message failed (%pe)\n", ERR_PTR(ret));
-		mbox_free_channel(kproc->mbox);
 		return ret;
 	}
 
@@ -741,8 +751,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 		if (ret)
 			dev_err(dev, "failed to detach proc (%pe)\n", ERR_PTR(ret));
 	}
-
-	mbox_free_channel(kproc->mbox);
 }
 
 static const struct k3_dsp_mem_data c66_mems[] = {
-- 
2.46.0



Return-Path: <linux-kernel+bounces-311463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE2968989
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DF41C22890
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A83DAC1E;
	Mon,  2 Sep 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMRQe1Ln"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278612139A4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286217; cv=none; b=hTj2zktG8b+NlO00C90r8Bi5KVjIleBvg2EZw/xY+JfQSQVCOHVNhwnJVKH6AdEH8HkarCCGanOhozsfo3a8fr7aeSxSC3yzNcIsAlMmy8lerrTibYHEmHiTomKkjVkLODqzMQRHML1x1RJHO+Yxt6xpG+y6B7PoV9esrn8pxbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286217; c=relaxed/simple;
	bh=UORapo7YlNTuvEJAeLimPXM90asjpEKjHP5U8x+YZ/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsHHqOsvADJsN54XbiEj7j9QGsln7+zbol0EMMMXoL7J3HKhFLvNELZCQ1G2gpmAkOovy2DJg8djFcOVaG6YHdOMs3fuaxrhv3kI1oW5sjkEPxDOrJGzuKM/vcEULcMYMkfJBNKuWzYy+jSDetFxfOTqYJ71g9wQfznsatNBwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AMRQe1Ln; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso4540611a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286213; x=1725891013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7dzsMwdjr7BdMT9siJ5A6qZhkd2DGrmBmUTDDuztxI=;
        b=AMRQe1LnhUyCUeXMFWavboo0HAHqBFBgQpa565z52Wn+CUEqTyL5KM3t4tX2PJDGd5
         9q8BkQ4IqIo9v9FyzeImxtDg5qJdexvGkZ9PlSTMCHwVjFAF7ToCa777KVdnmbulFIEh
         SWklBpNQZ46bUNKTmIhxF4lL13NdEqrGaKXzbKEJt8H68UT5cjTrWZLEaIaRVBcXbf8z
         XQMr9sE2L/A9uUgiD3fR+albjgdZ3fqjRPAsF6eTdACvNqRA6eb/XWKRyIqEDdp0rEV6
         Pe35khki8mZ8+vVmafW34VjjLViHoPe354WANAg3XY8g7hRnmT1JKI5SvXzlLIPUWXHV
         4DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286213; x=1725891013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7dzsMwdjr7BdMT9siJ5A6qZhkd2DGrmBmUTDDuztxI=;
        b=B1RBjcxg9z0DWIafKoA57jUKfcLGuJ39UgoIiwvBrJPobLJCfaP0QYHW6wSYNEJAfb
         wnqnSydXic3cdAEkFwzVO5oAaWwTunzCEbQJPfvyWl06y2hlDr5fwvBQe6uvPHHuD49q
         kjWbWjXcfDbuJur72NkBHzdF9VsOnveYACfykXR8jK8bjhyL4kPGjCXrxnF48yXg9pEU
         FfCbLRMGJUDSCc29LBnhcm/Q/xtQbZDuV2S6k06ysUEsgnglxDlcg7k1PnkhUuv2EJM5
         wyCjqheUNwbaT7jOb/JCC1XB0iU5zYDfwboJtk4G+Sja+WoO6zRnLPNAsVSMVu+mjS67
         VnOA==
X-Gm-Message-State: AOJu0YxYlTSLbSrh4FsXHC5uxL6gu6ucXz16wgdnCtOf4aXknJ4CXZCB
	4ra6ddoyt/hbX7R7fInENnvVRB6tRQibTZjFBv3FH8vagI+lCn/5P87YWf6K6r8=
X-Google-Smtp-Source: AGHT+IFDLeYmh3ZwnVxagcpzj2n7lgxU+6XtZaDAv0CjoaeABPjeryT5ak67NrLKA0BEeVBr73R7Lw==
X-Received: by 2002:a17:907:7ba3:b0:a86:bd58:ecfb with SMTP id a640c23a62f3a-a897fad6fc2mr1072884466b.66.1725286213235;
        Mon, 02 Sep 2024 07:10:13 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f16sm561716066b.150.2024.09.02.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:10:12 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] slimbus: qcom-ngd-ctrl: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  2 Sep 2024 15:10:03 +0100
Message-Id: <20240902141004.70048-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902141004.70048-1-srinivas.kandagatla@linaro.org>
References: <20240902141004.70048-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index e0b21f0f79c1..1ac8e2912fd1 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -788,7 +788,8 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(sctrl->dev);
 	DECLARE_COMPLETION_ONSTACK(tx_sent);
 	DECLARE_COMPLETION_ONSTACK(done);
-	int ret, timeout, i;
+	int ret, i;
+	unsigned long time_left;
 	u8 wbuf[SLIM_MSGQ_BUF_LEN];
 	u8 rbuf[SLIM_MSGQ_BUF_LEN];
 	u32 *pbuf;
@@ -890,8 +891,8 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 		return ret;
 	}
 
-	timeout = wait_for_completion_timeout(&tx_sent, HZ);
-	if (!timeout) {
+	time_left = wait_for_completion_timeout(&tx_sent, HZ);
+	if (!time_left) {
 		dev_err(sctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
 					txn->mt);
 		mutex_unlock(&ctrl->tx_lock);
@@ -899,8 +900,8 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 	}
 
 	if (usr_msg) {
-		timeout = wait_for_completion_timeout(&done, HZ);
-		if (!timeout) {
+		time_left = wait_for_completion_timeout(&done, HZ);
+		if (!time_left) {
 			dev_err(sctrl->dev, "TX timed out:MC:0x%x,mt:0x%x",
 				txn->mc, txn->mt);
 			mutex_unlock(&ctrl->tx_lock);
@@ -916,7 +917,8 @@ static int qcom_slim_ngd_xfer_msg_sync(struct slim_controller *ctrl,
 				       struct slim_msg_txn *txn)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
-	int ret, timeout;
+	int ret;
+	unsigned long time_left;
 
 	ret = pm_runtime_get_sync(ctrl->dev);
 	if (ret < 0)
@@ -928,8 +930,8 @@ static int qcom_slim_ngd_xfer_msg_sync(struct slim_controller *ctrl,
 	if (ret)
 		goto pm_put;
 
-	timeout = wait_for_completion_timeout(&done, HZ);
-	if (!timeout) {
+	time_left = wait_for_completion_timeout(&done, HZ);
+	if (!time_left) {
 		dev_err(ctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
 				txn->mt);
 		ret = -ETIMEDOUT;
@@ -1168,11 +1170,12 @@ static int qcom_slim_ngd_power_up(struct qcom_slim_ngd_ctrl *ctrl)
 	enum qcom_slim_ngd_state cur_state = ctrl->state;
 	struct qcom_slim_ngd *ngd = ctrl->ngd;
 	u32 laddr, rx_msgq;
-	int timeout, ret = 0;
+	int ret = 0;
+	unsigned long time_left;
 
 	if (ctrl->state == QCOM_SLIM_NGD_CTRL_DOWN) {
-		timeout = wait_for_completion_timeout(&ctrl->qmi.qmi_comp, HZ);
-		if (!timeout)
+		time_left = wait_for_completion_timeout(&ctrl->qmi.qmi_comp, HZ);
+		if (!time_left)
 			return -EREMOTEIO;
 	}
 
@@ -1217,8 +1220,8 @@ static int qcom_slim_ngd_power_up(struct qcom_slim_ngd_ctrl *ctrl)
 				ngd->base + NGD_RX_MSGQ_CFG);
 	qcom_slim_ngd_setup(ctrl);
 
-	timeout = wait_for_completion_timeout(&ctrl->reconf, HZ);
-	if (!timeout) {
+	time_left = wait_for_completion_timeout(&ctrl->reconf, HZ);
+	if (!time_left) {
 		dev_err(ctrl->dev, "capability exchange timed-out\n");
 		return -ETIMEDOUT;
 	}
-- 
2.25.1



Return-Path: <linux-kernel+bounces-311462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C88968988
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63612845AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519252139CB;
	Mon,  2 Sep 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNt6koip"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952532101AB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286215; cv=none; b=EHfWjBiGKWBvpeJ8erGmb1CXTVfzZAzSzuOiRzx2KIjsKQbohhNsH+S5zzTkwPjksDPdrdOz1NMy2y78QorraOSTNcNG+QGzS34PIwZC0QzFCoqmryc5jelAW/c6+b7oFaP9gdjg11a4F0fGi2zTb50KjM59W0cxKTTPGXB3lzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286215; c=relaxed/simple;
	bh=AFl07KV8klEOJ6+rT1G4qkvtt0+o8Zw3nuDs4h233sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ioe5cjNPX6dvRgYrcndHK8Yk5kMRVX4MN9t7nBOgwDooMwV5ULMJvz9teIRw1AKRTxTtChrFaROsjVV1wlcN7dxjhca5LyAP4Wfus0Fyajrti2MI6fwND7Zb3L22k6PC3N7y3nssetxQAMLzsZbqJnSYhnv1+4OnBKkFuKdQHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KNt6koip; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8692bbec79so484470266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286212; x=1725891012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpr9dXIidsXFpm+K15CdNYJqzGIzIYw+BZn+15r3Xp4=;
        b=KNt6koipVN9FNS1vBCWuKpicp6z10jRTAp1bJB2TVdTXwHCdL/NEBsiqKHoi43vqVl
         Vktt8GNY5lngHY3DV0Nnk55oQEHI/aCBjD0puOrfM05nD3K726nQ5X9KJC1fm1wnTaL/
         wF12P6SlM0XNv6/eW6Q7G3wU8tMSyX0NKouyg2nX8JA7hi1P7500Wl04GqEw7juNyqRV
         VjyYg02ZVO+UJNztgFO38XPG2AdUfG2iMiF4zu8yv2HshBaBdewdrhu8GOAqp0bb/+zj
         9fvX8SSUJLpwMLo24iPvORYahuN5cd9v96H5hWounzVrLHGijPKZIIbWas/j49pcJnB3
         G3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286212; x=1725891012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpr9dXIidsXFpm+K15CdNYJqzGIzIYw+BZn+15r3Xp4=;
        b=eYwwFeaOeiOZRXilKBvg28Hrq8S1aoL5QOFlN98eF4z/6g/3F32VIUafB9xPj6r8dF
         EDYdriypqnLwxffh/Pusg+yXwjmqGlT0kpV1DCTudABt6UmTjtfWbmnS0+7VUBr39oU/
         vf2w/ihDOdQ24gkR7hj5RjmW0eLtXSH39xLToJgihKJzmlW4/lKL1V31Z5Wfg+TKgzmg
         alRg8FwC0ZP3NN3v8jUMw8GjzgzwTPEjQJVi2UoWbuytowN5E+ri/Y2v1GrMSUOY+iUu
         IghRU2bVuWJpAd5JPUPqMucAI/LY5uaR54cdYdcOi8TZf38kh3eDZymAAo/eEjZ6yfQo
         PbrQ==
X-Gm-Message-State: AOJu0YxEES34ZH/dj9bVRrvgUdutQEB9Dr/LVzP5brxXxa7iDHXcP4hR
	fTI+veCTpPGhSdkAQ1Kog/F8GVXPXknoXKxJH6P2huRl3BvtEANjhP+1Tm9SGfrtYsBW8aH1edp
	w
X-Google-Smtp-Source: AGHT+IHcERo4BB7U4JT+gMACRHG24hTd6QLkbBaA2Vzft6CwbCbxaBJa+aGSL0RMP6WviX4D4BWcxA==
X-Received: by 2002:a17:907:1c28:b0:a86:a77e:83b1 with SMTP id a640c23a62f3a-a89a379b622mr700498566b.47.1725286211829;
        Mon, 02 Sep 2024 07:10:11 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f16sm561716066b.150.2024.09.02.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:10:10 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] slimbus: qcom-ctrl: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  2 Sep 2024 15:10:02 +0100
Message-Id: <20240902141004.70048-3-srinivas.kandagatla@linaro.org>
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
 drivers/slimbus/qcom-ctrl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 0274bc285b60..e25f9bdd9b23 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -330,7 +330,8 @@ static int qcom_xfer_msg(struct slim_controller *sctrl,
 	void *pbuf = slim_alloc_txbuf(ctrl, txn, &done);
 	unsigned long ms = txn->rl + HZ;
 	u8 *puc;
-	int ret = 0, timeout, retries = QCOM_BUF_ALLOC_RETRIES;
+	int ret = 0, retries = QCOM_BUF_ALLOC_RETRIES;
+	unsigned long time_left;
 	u8 la = txn->la;
 	u32 *head;
 	/* HW expects length field to be excluded */
@@ -374,9 +375,9 @@ static int qcom_xfer_msg(struct slim_controller *sctrl,
 		memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
 
 	qcom_slim_queue_tx(ctrl, head, txn->rl, MGR_TX_MSG);
-	timeout = wait_for_completion_timeout(&done, msecs_to_jiffies(ms));
+	time_left = wait_for_completion_timeout(&done, msecs_to_jiffies(ms));
 
-	if (!timeout) {
+	if (!time_left) {
 		dev_err(ctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
 					txn->mt);
 		ret = -ETIMEDOUT;
-- 
2.25.1



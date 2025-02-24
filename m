Return-Path: <linux-kernel+bounces-528396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C96A4174D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFF9188E4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8F19259E;
	Mon, 24 Feb 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4P1yHYy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F178F37
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385642; cv=none; b=TCdjDPcTDDBa3ujo2ehI7RWftlP6Ihod4FpJgJvN0dVktelylng/AgtJ3kIDa0Yy+TLkT6XqCPd5wVxRypleI1msAwQcyNTG64F9W0381aZHR2NhS7Bxysrl+eEJNhePLPmLb7kdThKEmLgSnpkH6HXl/HLSkVziQKuUgcxyxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385642; c=relaxed/simple;
	bh=AvLrAR2hqzQ0JNsRuACWtnei7y2xBFOifmlqDERTMbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RO28peCo9sW16kXA3daQuATSyVEpW51pkYSKT5DfarkgW98U6rDJpcPz5WPqqKmSPTixBgcfMvTaIJQ/1ZCLCFInW4/3FoRykGwaNyJWlAB1xDz7gZYAgzdfLCmgqov5nROXWtEAqBLzXbKEpFTrjVfFO8fw9e1lZH7hQzKJIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r4P1yHYy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so38732425e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385638; x=1740990438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tx8xv35ofByeg3xa/QLRoDfTGHfxK8XYZ3X6DCdp5Pg=;
        b=r4P1yHYySrYWHN8IT3J+u5NH3GBrwy4MUf9mCNAXSTJ1g+lNp4FvzMUnR3ocLS2rcA
         G/tdelNra5fkRI/cuQZv/dqt/F6p23Yty06E6mTcVRIoAHAB6pGV2KloJoxGCSLGvBDX
         OIh7HTlGLmbr9ew3Sc2+GYek51K/MPWsEwwNw0ZlJEC39iQAyosnQN5NzlWd4LKa2rlV
         EJRct1Fmot7A7pDwR4QybfncvhxZnaF1y6uXjtJEkU+2V9mLDR3r1/txUa3RGwGrh3V7
         euOhy8i+dauB6IPmguCltz1b8xUMsLQv5JSim4K5NSBBY+keeOoyJQrz8MMDuyhRR0GJ
         h9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385638; x=1740990438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx8xv35ofByeg3xa/QLRoDfTGHfxK8XYZ3X6DCdp5Pg=;
        b=OsCPuKTFdY48QHp3bSj5j6BGyCyZ+yjrE5F8clhWDzx/ikW8hkQ0M0XQA74VfqmEzG
         lww6eOCg0tZUBHJW3Ed69S+C6NgbX3Ezi9l5h9NVK/O/P/StjC+VKmmA36t+qhzQkV+4
         vGqczSfkh8slawOf9dELx9/F+l9v+oCpiAcO7IkIL3SQrYXN2EA87gKgZJlxQw5ymDfD
         09eywZBpbPPOmHX7JOClZLi5NPhcx/0LWtVROwSYeSZDAC/EGKSHgPLuQbOfUbkMzskd
         Xvou/+pgnELyIKUuFTncwopHSL11jWWPJ3tTkvtgCNb7ejxKIFU991FN9R118IifcDec
         xnVw==
X-Gm-Message-State: AOJu0Yyhz0LiWHhuS8V+a/0RTyICbORkYuDf8v82ZnRmfaCyB8/AvL8r
	/uZm2qX4fz6rtuNSwUuqP3/pA8RivFFPz+G3w5LdX9sPYX/KaX3jL43byEYU1lU=
X-Gm-Gg: ASbGncs9RA/Pl+7ZeFYy297ce68IZn2pSbL4o6ezMh874d7ctK01sWIsYN86A2b3Wva
	mDdtys+aeHg/iwy5GERIWM0KJXjv+sN9p2pks8eped3x5XJ8c5fN1qeyDVeH0HTuKmGGrdf8M7d
	jfiJndK/GmPezI+buPEAM8daNMgjOyQQT+mo2iN4OfODMCc5NPRoc23W8Gvb0mPDcjCGz8L7cec
	bUU/JoIUHmFglBQTOTVL7BrTx2N6xQSHUNcMBQrPdmTy/XLzyKMujJKFfghIa5X2kUzCgBsdXWW
	J9Ayn/1FBx9pE5BbgPVAOrmAKQv/seXW3QBegrG80SVcuCrWdh59lhiIkn9KR1rks75Pm3Ftpaw
	2ICi7VA==
X-Google-Smtp-Source: AGHT+IGXaPHgFzfEDoc1M7uOk1At9JP0vGwcN7S7NwZMnE9hpvptsRJ76S6cLQM63Jf8UOK1fr44Og==
X-Received: by 2002:a05:600c:4687:b0:439:9aca:3285 with SMTP id 5b1f17b1804b1-439b6ad5cbfmr74734555e9.6.1740385638546;
        Mon, 24 Feb 2025 00:27:18 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce428sm101226065e9.5.2025.02.24.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:27:18 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 24 Feb 2025 08:27:13 +0000
Subject: [PATCH v2 1/6] mailbox: use error ret code of
 of_parse_phandle_with_args()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mbox-mutex-v2-1-9d699148fe4e@linaro.org>
References: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
In-Reply-To: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740385635; l=1202;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=AvLrAR2hqzQ0JNsRuACWtnei7y2xBFOifmlqDERTMbc=;
 b=AY3TBAQEpiZjXrTWfxERKo9juVaJd14ASBdE4yREGo4s12VcHPjqf90yGVPNVgQe91mOtZWlW
 iRlAfRzsZGYARbYc8hySbDpYwZdiQQLOW1t3hD43cd1CWJNUqlVa0fZ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

In case of error, of_parse_phandle_with_args() returns -EINVAL when the
passed index is negative, or -ENOENT when the index is for an empty
phandle. The mailbox core overwrote the error return code with a less
precise -ENODEV. Use the error returned code from
of_parse_phandle_with_args().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mailbox/mailbox.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d3d26a2c9895..cb174e788a96 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -415,11 +415,12 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 
 	mutex_lock(&con_mutex);
 
-	if (of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", index, &spec)) {
+	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
+					 index, &spec);
+	if (ret) {
 		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
 		mutex_unlock(&con_mutex);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(ret);
 	}
 
 	chan = ERR_PTR(-EPROBE_DEFER);

-- 
2.48.1.601.g30ceb7b040-goog



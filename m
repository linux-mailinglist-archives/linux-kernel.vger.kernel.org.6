Return-Path: <linux-kernel+bounces-284745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E69504AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DC81F219A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933519A281;
	Tue, 13 Aug 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXYjvtXC"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD6199EAD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551237; cv=none; b=Ne/GxsBr6keJM6C9S886lEDHbSFyI5HeysZ6t34EFMdjRdMvms2oKkYhGRreW1Lt2UOrT18mEVvKnVfVtMEa2VtcCsDGN4WOeg6c5ouO9LSDYAOfMsDxpZZukN0RX9lWDASwM4AUFhMWXoQBpVX53iZi7ZMEH+8huiN66jkT8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551237; c=relaxed/simple;
	bh=Q2wAxRulEUNylV84MEI5qrVLjgN6aDtCQyka6+hlcM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbH5l/ogUpVYUnDM8oWxYh2SicLLJ9fLb1jVHPDmB9ceCJsxIKKXkPGV8anl9eWJTVkS+97nXb5TNWqzFgWUL64QCEEGwueOqise61PnAEWoHZ6uR6ZMvDyRpas+mVt8DAapWjQdKslamc2lTKKWJvplpGFwniuJ4RlRSd9Mg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kXYjvtXC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a4df9dc885so86958885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723551234; x=1724156034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Etl9GyPmdRz22pfGaoR8C42DApQqo8svGDO8wQI1tI=;
        b=kXYjvtXC9AQDwE8RQupA4pmEQYRg5Y9TfZt0n0+E6NqgA0wUBgGXZi6KRM7idRWdap
         f4JutDpECFSfSE0WYFUKzqGQqC+lbc4x+iRL1Gv2JV2LpAcqDFXpThyw6h2m4OQBlPVZ
         Dy0NGcDr9NzsUB5AQ/HfroBSiAU1cdjLlZMcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551234; x=1724156034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Etl9GyPmdRz22pfGaoR8C42DApQqo8svGDO8wQI1tI=;
        b=TFT+i3jk/cl4AunkRO5HI2bmsA09LTtBWzCIU3+u0yB1Sgd3PN+7ybHac2azFs3RIk
         b5tNbDoLVMc1jz7k8dqmsr/Y6hJBQOpnJ0YpOJS26q3YSQNBQf2XFVUR1VviX09OMAjN
         DxOH45uJ3ygq/6/lTc5DD2I+LFeQ7HYkBajwShSwyeOnEcHq9U3wr9BNp//ppucpN58g
         qCS1wf0xoY9OQ5aFBhOEstbRLTvygjofMCeX7NPBU+TWV4PF6WOeVmISHoPxPH2AyfoC
         Jk9FrtxKcNZe+c9ungMFb7VT9R9iIyq1Yvi1GQ+u/ndpDg4lwQdr504tIT/2x6I+MFrk
         16cA==
X-Forwarded-Encrypted: i=1; AJvYcCXy8/2JRK0ftwaQCrLAP4rs7p3bf3H9QiutTH50+0v+APelPNprLK5qF+0jxTtdHIvVHr2eaZaknizSxG8tzGhAe12rCw6dRxY9h9Zj
X-Gm-Message-State: AOJu0YwlQPjrA3DXbtYSVtOhIFWY9IbWoPlmaVpeLSh/dH3Q0YsDzEPp
	TECeZ+Ut7ZUKcg2frZFVm7meTUPlUMQiq9F9Mg2yddJs4pYK1xa6e2t7l/Q6KANu83UfEeYnPao
	=
X-Google-Smtp-Source: AGHT+IE5trF99pt6yxLy0hVGziVuLU740Yhk23ir8obTxxE56RFdMfq2z26jixLlIL2miIGD5ezz0A==
X-Received: by 2002:a05:620a:d82:b0:7a1:da71:e73a with SMTP id af79cd13be357-7a4e37605b0mr498168385a.2.1723551234290;
        Tue, 13 Aug 2024 05:13:54 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d71ca8sm331765485a.50.2024.08.13.05.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:13:53 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 13 Aug 2024 12:13:51 +0000
Subject: [PATCH 4/6] media: tc358746: Move clk_prepare to its own function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-smatch-clock-v1-4-664c84295b1c@chromium.org>
References: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
In-Reply-To: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Smatch is very confused by a clk_prepare_enable() being called in an
error-path. Fix this warning by moving the clk_prepare_enable() to its
own function.

drivers/media/i2c/tc358746.c:1631 tc358746_suspend() warn: 'tc358746->refclk' from clk_prepare_enable() not released on lines: 1631.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/tc358746.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
index edf79107adc5..389582420ba7 100644
--- a/drivers/media/i2c/tc358746.c
+++ b/drivers/media/i2c/tc358746.c
@@ -1616,6 +1616,16 @@ static void tc358746_remove(struct i2c_client *client)
 	pm_runtime_dont_use_autosuspend(sd->dev);
 }
 
+/*
+ * This function has been created just to avoid a smatch warning,
+ * please do not merge it into tc358746_suspend until you have
+ * confirmed that it does not introduce a new warning.
+ */
+static void tc358746_clk_enable(struct tc358746 *tc358746)
+{
+	clk_prepare_enable(tc358746->refclk);
+}
+
 static int tc358746_suspend(struct device *dev)
 {
 	struct tc358746 *tc358746 = dev_get_drvdata(dev);
@@ -1626,7 +1636,7 @@ static int tc358746_suspend(struct device *dev)
 	err = regulator_bulk_disable(ARRAY_SIZE(tc358746_supplies),
 				     tc358746->supplies);
 	if (err)
-		clk_prepare_enable(tc358746->refclk);
+		tc358746_clk_enable(tc358746);
 
 	return err;
 }

-- 
2.46.0.76.ge559c4bf1a-goog



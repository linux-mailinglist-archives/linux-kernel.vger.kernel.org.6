Return-Path: <linux-kernel+bounces-444983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D49F0F80
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41A116541F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B38D1E0DB5;
	Fri, 13 Dec 2024 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZhdlTzP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C01E2309
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101371; cv=none; b=b4NbXQiZFYp1pDC8RS1meZ48iYRuiuxXaaSgvtkVojE7Ad8MkjKyRHRTp/ZKuzxA6ZHVIAK7C8MBikrHQwvGR5iRhAP0B5Uhp64zIr2HyN4gQKkJg+9aiHjHMZ92juz05GqGMBYNO0CTK/SIUwJhPZHHjoPGOoq3YxOKSiUXr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101371; c=relaxed/simple;
	bh=m1RG8uDj8WQP7hbZHg/PSSoUtWF3HmCISvW9JYlyfUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XY9YWUR8XMTu6ZEc8cFflExanInqUCNvYE3Rgn54fSO7IkGaU01y2+NP0zf1UIG2Oehc9mFYc492c1SCbVfF8w++acHda5EPQ1jzVlMiJmercOfriRzaIJbk1ET8MqoRWPbDYDBYGrejjqqz++SA6NWStPVQFqHQ+HMlS5ouP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZhdlTzP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38632b8ae71so1340811f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101368; x=1734706168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqYUm1i7e1fblFqY9jJKn51mYoOB0b0xVEyAilyqTvk=;
        b=dZhdlTzP4cRxkgIudvUB+aNZ00gwQDk8V+X1t8Bc5ZpQYvhx8OVZOppKKWFQQI8O5/
         O423DO6DXwquWIUesOg9d9NfGGTlLSygAZIWhhYyesmPjTv7WPeBaLCVcBUP0WHtVh2Q
         K8FUyH8NnFbN3/+13FtB1T4AAc6Ie/15s+cqcklcbxz3CJhv6nxZFJWDCAS4NDe97jWj
         mjHwvThyENPXPqWwEz5sQYzLiwvI9HtIi5kh/s/30vK8dOpLb3ds9Y1z+Yta6k+YneeT
         YUx+COKMVfd2bvT26lb0WM6BbHtX0Y1MQbtgRXbpmBEl2tyxBxk8CKvKR0u9ENm9ySvJ
         DY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101368; x=1734706168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqYUm1i7e1fblFqY9jJKn51mYoOB0b0xVEyAilyqTvk=;
        b=gPhB0DZYrsvmDuKQTx9HdQMMXuUsbRPZsu93Qwap163G0dDnwQzUtAK4DpYgM+48YE
         PqXLNqIdgsda7Jbz/6ROnqGe4dUFzOsKKVZC7q0kkFwwv4sqjKDgLMiDEL8tt3VJb/1E
         2I+5tV9C0okQ6jKhGkfgllmVFkMApgBv5XFQ7XhYTJpmJvxmEa4QvKsvin0OJO+guNbu
         86f7PN9j9fDqwyTWkNZy2aX37TJ8BUn9zdyRS2TBlm0L7J2iRFRaic+7sZIabz7dd392
         JonkHpWR7QG3QqaRZyEGbe6Ttgm0vxPet0a/23IFHK3KkdCP/hLl6Sly7PNh/HNX04EH
         BdEw==
X-Gm-Message-State: AOJu0YxOclzq14eWxFJbxFNf2Yc3VGIIQClYQMPBywROtdMGt2F2bQCV
	JCBvRoTZuchj+q2gJ6TteT6C7bW5Nrq2flUpjWqAw8DzmmyyUflXtIh9u9lgJYU7TcuAsQ3y9Wa
	C
X-Gm-Gg: ASbGncvcYuAvPISXy5cLejyWhvpu8wzGPxJ/5a+B5PCQ6K8j2VbN9+umr86am08fpzv
	MJ339RuPXvCTHfvmoMhFXPBe16ir8P0FZjULI/m/vf6+IKzT++m1wQuvVWrL0Th+e5EGwUiMYQz
	kyv93KeCaP078lxynufYCfEzI3YhLx5E8XTJh1GydYo8GcmPfUdB+cV00b+3Gedwr6o8Q0qml1/
	OLDU95bvY8NdoSUBpFG/3BNCuRc2ELXRHBbHK3RgSEiWKl/3l5ZETE7qw==
X-Google-Smtp-Source: AGHT+IFDVH3ne6sNymKAo1QgYJon0YdqlPVHMjDohMOhYt3kQjiXEykwiHRGKr2ebn9u641ZWv+SCw==
X-Received: by 2002:a05:6000:3cd:b0:385:df5d:622c with SMTP id ffacd0b85a97d-38880adb0b3mr2087916f8f.30.1734101367931;
        Fri, 13 Dec 2024 06:49:27 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:dd7a:c2d:2b46:b1a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c50b7sm7196295f8f.57.2024.12.13.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:49:27 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: james.clark@linaro.org,
	mike.leach@linaro.org,
	suzuki.poulose@arm.com,
	alexander.shishkin@linux.intel.com
Subject: [PATCH v2 3/3] coresight: etf: etr: Update logging around flush_and_stop() errors
Date: Fri, 13 Dec 2024 14:49:19 +0000
Message-Id: <20241213144919.110642-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213144919.110642-1-mike.leach@linaro.org>
References: <20241213144919.110642-1-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Insert additional context around tmc_flush_and_stop() errors.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 12 +++++++++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  8 ++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d4f641cd9de6..62b4b685c1a1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -84,7 +84,9 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&drvdata->csdev->dev,
+			"Flush and stop error disabling ETB\n");
 	/*
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
@@ -146,7 +148,9 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&drvdata->csdev->dev,
+			"Flush and stop error disabling ETF\n");
 	tmc_disable_hw(drvdata);
 	coresight_disclaim_device_unlocked(csdev);
 	CS_LOCK(drvdata->base);
@@ -496,7 +500,9 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&drvdata->csdev->dev,
+			"Flush and stop error updating perf buffer\n");
 
 	read_ptr = tmc_read_rrp(drvdata);
 	write_ptr = tmc_read_rwp(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index a48bb85d0e7f..122a067d1bb8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1139,7 +1139,9 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&drvdata->csdev->dev,
+			"Flush and stop error disabling ETR\n");
 	/*
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
@@ -1578,7 +1580,9 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&csdev->dev,
+			"Flush and Stop error updating perf buffer\n");
 	tmc_sync_etr_buf(drvdata);
 
 	CS_LOCK(drvdata->base);
-- 
2.25.1



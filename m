Return-Path: <linux-kernel+bounces-349233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D398F2CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5179D1F220B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00221A727D;
	Thu,  3 Oct 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENCNE+cL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287C1A4F15
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970095; cv=none; b=VjJ/hplwzSCZoqPVPdvp8SWlE5jDVj3SZd+BOZ7FkbZgH0P7tIjOe7Dzcmyghp+tXZo4Kippl9sEyD6+XFeMJebNcC8XV5m3fkrWfi5UHFdnnbM/IbBJTQtttb3sH7WH2WSaTh2bGgM691GVfdWTEAb3V+zhj3uHWUSaGsrkIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970095; c=relaxed/simple;
	bh=KuJYhS6BLwFHq2M3BsUApExs70W98G5/TG0tISRMP7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ejTN9gRyVxAVilPA8w3ymiEr9Oiw0oI+dSg4tQ3XQVw/QQcX4yPzBW/xreQsQLkHjjeWwV/1FkozKDPWSuuMsAJ7XANsZHwvotFRo22eXptz7lsytFoZtfcdS0Jmh9rj6ErN8PxUrDVpXRN6/LSc6c7bPt4eq7cb/5gtoq6OJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ENCNE+cL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a910860e4dcso179010266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727970090; x=1728574890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDWnOefZjmiIEjMknhotah0eI13dQMdxoD4kz7zvhSU=;
        b=ENCNE+cLdICmlPtUceRaEBy6qY0M3cJQxPHM6jZNf/WD8A0cuU7c96DMrEguQxCX0g
         IvySPeg9JFjAwprcHDru3fIGB09XjH2fd9kwGhkwjsUjs0pGHVdG38vcgHVd0Ua9CEql
         ddPdqosYcZfuUd5zNYjk5mcoBde0bO0TqvDtXTAMNfljSEZH3yaVlhsDB1a8yJjq92Sr
         xxPRasxhg5I07F0ubmRXCBbm+3pjc8B6YJAwHpc9AoHDCw3pnFOlVk+aVOGTnNKqLgl1
         uTgQv3amBoB42RMP+sZYFhkTqFGYidOWmJDj04KUQ6jZkEnlVb24Zgdiw7QMWnsSy9Wo
         JiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970090; x=1728574890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDWnOefZjmiIEjMknhotah0eI13dQMdxoD4kz7zvhSU=;
        b=mQjKWtHkwalzCe3DmkQMvHXmLUQGE9yDOWEMph4G4jBDNDZJ9/sqnGckIuJ5KKZGue
         AjUklRS8CpML6B3J9YWKBsJgYfLgBtfvgtdG+NVQzEFm6ZkI5x+Qd0Qsom2VWolFt0Nr
         F4gu+Ewg+RaVj682b91uW1+66FKhQlnffZcL+2RklCNdXsWNnsqSNDCNaHtsh3rbV+4B
         inWBRIMXvZ7z7Gd1JNyUHSr+kNx6tKfgHxIw2u1BJqsx+iI1o2E6KGYXPVDEW03mLnDt
         ZytvoLP4oSNYr2MTJW5Kj4a4ak6VLlzcmQVLWLOC0+/6RIRfkj9nMW4F0Y8Iug3KO72R
         NdAg==
X-Forwarded-Encrypted: i=1; AJvYcCUQvWAWQY+7g8XqVYs7wvLT1uqnEqxZaj3eyjg7N6eztK0DNMxj6wXciQiEuskUyWJd+kqhGQ7Uc+FUy4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyNkO7WEUxm7/b6bO50s4QnmzX25i5/37ruxl3vcNb/zRpRZU
	7aDMQwyXqLFgm9DbA7Lx8zjauIMzl9qmeQGEVtzDYujWv7pr7dUxKRqYaecAwrA=
X-Google-Smtp-Source: AGHT+IG3rMtoMbI9NN5aMRWEJU21BT28htx5oYE4D7ib0ifyGr9FipmKAjWzxrRPM3WSGUHkvnJTYw==
X-Received: by 2002:a17:907:1c04:b0:a8d:7210:e28c with SMTP id a640c23a62f3a-a98f821eabcmr730643966b.20.1727970090572;
        Thu, 03 Oct 2024 08:41:30 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104c4f3fsm98492866b.200.2024.10.03.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:41:30 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 03 Oct 2024 16:41:27 +0100
Subject: [PATCH v4 3/4] media: ov08x40: Rename ext_clk to xvclk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-b4-master-24-11-25-ov08x40-v4-3-7ee2c45fdc8c@linaro.org>
References: <20241003-b4-master-24-11-25-ov08x40-v4-0-7ee2c45fdc8c@linaro.org>
In-Reply-To: <20241003-b4-master-24-11-25-ov08x40-v4-0-7ee2c45fdc8c@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jason Chen <jason.z.chen@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

The data-sheet and documentation for this part uses the name xvclk not
ext_clk for the input reference clock. Rename the variables and defines in
this driver to align with the data-sheet name.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov08x40.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index be25e45175b1322145dca428e845242d8fea2698..3ab8b51df157af78fcccc1aaef73aedb2ae759c9 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1215,7 +1215,7 @@ static const char * const ov08x40_test_pattern_menu[] = {
 /* Configurations for supported link frequencies */
 #define OV08X40_LINK_FREQ_400MHZ	400000000ULL
 #define OV08X40_SCLK_96MHZ		96000000ULL
-#define OV08X40_EXT_CLK			19200000
+#define OV08X40_XVCLK			19200000
 #define OV08X40_DATA_LANES		4
 
 /*
@@ -2081,21 +2081,21 @@ static int ov08x40_check_hwcfg(struct device *dev)
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	unsigned int i, j;
 	int ret;
-	u32 ext_clk;
+	u32 xvclk_rate;
 
 	if (!fwnode)
 		return -ENXIO;
 
 	ret = fwnode_property_read_u32(dev_fwnode(dev), "clock-frequency",
-				       &ext_clk);
+				       &xvclk_rate);
 	if (ret) {
 		dev_err(dev, "can't get clock frequency");
 		return ret;
 	}
 
-	if (ext_clk != OV08X40_EXT_CLK) {
+	if (xvclk_rate != OV08X40_XVCLK) {
 		dev_err(dev, "external clock %d is not supported",
-			ext_clk);
+			xvclk_rate);
 		return -EINVAL;
 	}
 

-- 
2.46.2



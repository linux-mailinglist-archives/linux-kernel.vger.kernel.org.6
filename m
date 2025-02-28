Return-Path: <linux-kernel+bounces-537987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984A6A49349
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532D93B638D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE3243362;
	Fri, 28 Feb 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feH99N/c"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD188241CB5;
	Fri, 28 Feb 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730816; cv=none; b=cGs2gCilM7yhXxCFLXbD4WfBI/m8WXRtOdJ18Ju4J3ryvXrIfsEP5yyRJGvAw01gyBI0y0qIHcUJJRM+viKY8jZYrbkOjs8cXr5Fsh4rvYsHhtRaxaB8a1vMGl2jke9lxh90FH6nOFU2/gDdTayttos9ZuvHQR6zLAZga+/E6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730816; c=relaxed/simple;
	bh=UoYB/trv8Iol0MuUUKBG5qPWot2+WIDQonMIAwMDczI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IgYoeL8Sdi6zlnhc/c7ZmOK33Ey1HgyB+GE6Mh/X7N6yTdAisvqk9hsusqcnmb1q4GSxP+fiexPFsppM09bqL9H0cnduLJJHYcvdDiPmqk2cK5yLabKyVBlR/axPwAyPueIOBYuotN+h1aa11nfvlKAEcyr8oaM1U2PoefbnLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feH99N/c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso18672115e9.1;
        Fri, 28 Feb 2025 00:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740730813; x=1741335613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPge7hJBFTAy8hBIjP18QmIC3VRabllYYNmaNi1fIfE=;
        b=feH99N/c6b3yr5lA5lUsxwTYApKInOIidaiKq2cQFKulgkOT7TgwIdIervjUS27s/D
         oUiChYQdbyCFAuTt/bC3TE7X04kfXoDaaHwia7yGFkAQPRBYQS2xN+I/PJpIZ8YjepiG
         9OJ5eL+gzL6Ts9xljEj7J/hxAI+j6L1nm0eFcDe4yu4YcEJPIJOR6KSb+lqOp82KR9hx
         6qJIOdT7YfIvdGRNQqglFeAvOCgihVIXoh8oO3HQfe/SKny5AGQPhTAS3R5fJjGiKodX
         Q2+XoWxPNkeh5p05UBVxhfoYdpWWpxbDDIOz7memt8SY7wgKJ9KCEKjBIJl4eR8q1ZUA
         7efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730813; x=1741335613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPge7hJBFTAy8hBIjP18QmIC3VRabllYYNmaNi1fIfE=;
        b=Sqo/Oz4LrC7uAsZcfvXHRF4mhCp2xPgciLYMAfkjkIJ7l++CMCCdc65rOeBwDrh2c4
         AdMMb2Gd2/LwEnmabNV0vG+ePiJyVIrBVIOCQkLMprbuEwhEvaKPQJTQ/pKdohRApeNv
         /FFAXz/+pK3ozmz/zZ2/Bhb7xqd5fPD+SPNb353D+g+cg/28PG8qicKMw6f50K2dwyQS
         2D4bkZu1NAwim4tjxgmcaj8vV693TM/TABwD/kfK7HwrM7PIarHQyUF5fiqi6S57p2F6
         JWCUgIcHxEWi3U3hV/verc56mLsSyC9amHe9SExq3NrkDKTNF7a9HCBj+Mo89FQN9yUR
         03Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWS4dChe2Y3kRiFCoxjnePeRldtPx2vJzfzslW2xymlyV1sF3HKwXUymGoynx2MYlpLBdHF2nDT6T+Kw9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJgPNDQLNlhDcYD/61wuf4XmzrvjoY7D1/3Y+zqim//ahxT1N1
	iz06gMaBAkhY5HWhm+oKmmQubdwcimczj9u83lj7I+5uVTnYBNKAXAp5A6SQcDg=
X-Gm-Gg: ASbGncskRT5lrJuxbj9aeCKkeAq7bor6jzSwS4TTzWbvPRwf/HTn9jRI/ReVE7jkqAh
	ApdHrE9MkTN5DBIJqmkdlwtwCaDzJ0u5eQ+eREa+iwfOWnhw/oaSwSoHTb1YdaTbm6lrQ8zqd7F
	OTlK3sIyjP7+71zfzpYbuZZ75bpcgnOnthkGbndhcaQO6b7nuQdyupfP9G2wKvYECy8GU8/8Y1I
	B6K/ZK1bXc59/XL6RXzTYv+SlKelI22E4f99KFUK2RCiSkM6Ztta1XZBd1m7T2XE3axLRDzQBne
	6wyh5rVaEOPxPgVZMQwhBBcoKTQ=
X-Google-Smtp-Source: AGHT+IF4wqDn0bWt72AMDVpq0SAkVtQs1nZiW788ghlF7P5exRytaopy9FghXRWiJbTb3ReocT2sWw==
X-Received: by 2002:a05:600c:4f12:b0:43b:8198:f713 with SMTP id 5b1f17b1804b1-43ba66d9e7emr19590375e9.4.1740730812888;
        Fri, 28 Feb 2025 00:20:12 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e4796600sm4404636f8f.20.2025.02.28.00.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:20:12 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Huisong Li <lihuisong@huawei.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] soc: hisilicon: kunpeng_hccs: Fix spelling mistake "decrese" -> "decrease"
Date: Fri, 28 Feb 2025 08:19:36 +0000
Message-ID: <20250228081936.675072-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 8aa8dec14911..828ec8fec5d7 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1476,7 +1476,7 @@ static ssize_t dec_lane_of_type_store(struct kobject *kobj, struct kobj_attribut
 		goto out;
 	if (!all_in_idle) {
 		ret = -EBUSY;
-		dev_err(hdev->dev, "please don't decrese lanes on high load with %s, ret = %d.\n",
+		dev_err(hdev->dev, "please don't decrease lanes on high load with %s, ret = %d.\n",
 			hccs_port_type_to_name(hdev, port_type), ret);
 		goto out;
 	}
-- 
2.47.2



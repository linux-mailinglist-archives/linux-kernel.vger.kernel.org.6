Return-Path: <linux-kernel+bounces-337657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCA984D07
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927731F24487
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83713E043;
	Tue, 24 Sep 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaW4M9Fk"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B182488
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214533; cv=none; b=KqlwrMlWZa6Zf3KZVIJgswoGplrE8zqp8Upb+G7ySbfv8zYjM0j3Sl6KSOazuq3eSZnb3yyynj6A6QZbVVzNQaKe0i9MePspv2sUGBgDh9/hdUDs0BY/EY0fkBXF56Uck6xPzqQY+ymXQ0lLdmZUsLrvnUJTJ3sWghk1b2fPKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214533; c=relaxed/simple;
	bh=EG/KWhZZFvy7hLwd/A35h3ay5FzfFcLNn0z/3ioTMao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfQAZ9YkK0rWoDeRMyMQkJ/LORUxInVs4/WBNZuCR0Mq++9qMXFTYv2punkOd32hEhsbUCyVo49hgYNlA2SFf5KJjxxuOlrWtJO3G/6zsqc+RrdNj74E5OAOBOb1Z8tLXXGyNM6t+IWSnBcsWTeUl/OsHkTutqHw3VnVoUVj488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaW4M9Fk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83562f9be9so709973666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727214530; x=1727819330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42fS/11bUiOMSfuMHc8Z8L/JLgZHa52tzymot3taoLU=;
        b=ZaW4M9Fkhh3wpEXXNQAIcJxhez8Uo/fly3Kw+M/fDMnSoMhmxjipVyMXbSDM77GKPG
         Nixey631qN2kpFlnQXk7GBPz8OFNM/41GI4VGXWDS4wYjl3MvTBTbiu9ImU44C/Zw/Ez
         jbOTFefrdg83BiDRrSvTLmrNVZfZzYl43XKZmdVP63a42oUlQ15rDnMQmY4xNlqCGR9K
         TVbUEba7ZLpDyohc4Zcqz9ZaR2xSO0F3pI1Xap+OBHeiR4Q7PepxJwRK+fiD+ba1KKI7
         r7PNHmUYKuWD4T7FF39A1BPHndVCxljvL8EYUiWUrK4citT2s9cT0M32SzbrfcHNBXZ1
         pYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727214530; x=1727819330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42fS/11bUiOMSfuMHc8Z8L/JLgZHa52tzymot3taoLU=;
        b=CVrCBprTtyxHy7frgkLl+GAzjPLxstoQR3rbuuw6qfLVHnjl9XQIBBxNBS2t1tG98x
         BctEbRtWd+P+OCCd+mzbqqoJB4EEAsQq+RByIgPIBY/f1oq3eckW2u7DUmvLUbBSpynB
         qKmbHp89dwnQAj8ZgipuhZq6XmKZ6yCaCOYf4l4QCqXbjgTT+LIZAAODo3m4+O096jZE
         8P5LGYU+rgqREaqAghV2xrLt2dwdgh1yQ+sdBmUluj7CxqRhbVtsrNdEl+XQ6yO9NIR7
         4YFHFqxS08ZBu9I6vJyLAjMTPdRSDVWQdfeUi1XaKoV2QZeMimjaNLQTKDZat07nHTa8
         eeoA==
X-Forwarded-Encrypted: i=1; AJvYcCWEWj6Gm5vNaNnRWkhDrl4TDx1bqKwOG6rpkHvkYWCWnkw77ur3xgxHgK9A9j3fL5VkH3DwXljmxMbZKbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJCW4DxP1jc5aoFryButvv9+Xei+12Nz1fM4skGx1++vxwoo7
	H09zq8Mfre2btbeiKukZVNof3XoEv2xL8gZfJNZoyZmjWobsUDcL
X-Google-Smtp-Source: AGHT+IEcsh5hbn0VzcMk8VSK6rCIcezG81TD2g56dwCn3Xo8YS56YTtkQkfB/KbdWy/O1qvZOimo5g==
X-Received: by 2002:a17:906:c107:b0:a72:50f7:3c6f with SMTP id a640c23a62f3a-a93a0383da8mr52087266b.14.1727214529973;
        Tue, 24 Sep 2024 14:48:49 -0700 (PDT)
Received: from alessandro-pc.station (net-37-119-39-155.cust.vodafonedsl.it. [37.119.39.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f500casm134780766b.60.2024.09.24.14.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:48:49 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: nm@ti.com,
	ssantosh@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] soc: ti: knav_qmss_queue: remove useless statement
Date: Tue, 24 Sep 2024 23:46:10 +0200
Message-ID: <20240924214612.38854-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the statement "continue" at the end of the loop
where it becomes useless.

Problem found with Coccinelle static analisys tool,
using continue.cocci script
(coccinelle.gitlabpages.inria.fr/website/rules/continue.cocci)

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6c98738e548a..1cc54905b398 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -723,7 +723,6 @@ static void kdesc_empty_pool(struct knav_pool *pool)
 		if (!desc) {
 			dev_dbg(pool->kdev->dev,
 				"couldn't unmap desc, continuing\n");
-			continue;
 		}
 	}
 	WARN_ON(i != pool->num_desc);
-- 
2.43.0



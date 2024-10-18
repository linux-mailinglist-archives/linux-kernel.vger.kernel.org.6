Return-Path: <linux-kernel+bounces-372046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952669A43BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE1A1C21970
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1E2036F2;
	Fri, 18 Oct 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="gSNcxDbK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A71D0DF7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268669; cv=none; b=jILmQlTLkqGoWv3UgYO0CQp4ee2cF4ri/Y6Tf+fcd1mlNFnBIOx/EvzoNWh4icTXCjOKdpc4QqD3tcM6R9zwlPzUlM3Kt1lY8d4OKL3I3nWxPM4uRYMZz/Try3k99f/ZhJ0822HKpwlc+YZRIswEb+8v18h4N+P8usVwMDyZt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268669; c=relaxed/simple;
	bh=01OmuGFUNQmRAxj7LtspDTDEt788Pg4nhvfFhahXLso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3xy1VazTcBTEiz1WpDU6+XvABFvN9htV3uvFb1rvpb2Vn7Ag8WlsTXErBGHjOdIMeKokE8RrXhyDT7svQfKLUld+thoS1Lm14I6Zw6hRmUhcoo3LEW7nyvs1W/J7gDytL4ffrh1v0J376xSPVUUKaDhc29j03e6B9rbIyj8lPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=gSNcxDbK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so29695875e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729268665; x=1729873465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l04dyyVzM4ASaoUOb4EeBqz615dHFIixDrN8t8rAv3s=;
        b=gSNcxDbKwJOItjXw8KSFGWMcW5o6FPTWaa176lqFAtfHnfbCqqSoLWOCLIopXlfBpL
         MqtIYAcVKFnqv46ZewjKaQGSP3N4odSVkTWf0XqwQFsFxDplFy2TW0Usmxuu0CHYSmHf
         CnxjEMUuUdMY/j7INOLZVuIoor2aXY0X1/TTSuBeZOqysr5yn2+5BUVR25Yme2Sper7s
         quEBQZ2USCuONwvXTcTJvI2FoeBBd1xh9BrwYQbDL0YfccYDNlUNUD+B1woI5oNTHsFC
         2lL2J72TvuuBsMNItk3LHPhnQVR7pSt7j60Elsmg7MPobHtWyhBPyNJlD/Qdt309Rg2W
         +PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268665; x=1729873465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l04dyyVzM4ASaoUOb4EeBqz615dHFIixDrN8t8rAv3s=;
        b=D7kKq8eg1SPgtWfzTv5rmtiScMfeMZ+VfnUJZLG5aqzc1O7e8URa9D3mnnR8Kj9mv4
         pxYZFBf7B9OjTYJBnJ5QX1bQLeEbJZqPAJMUr3sCki31O99ZzCf+SrNLp3yhvH6GxrHk
         fmWD+7wJmIwC3wlp8XCPNaPUXRTUG/Sfo1vP0Q3drx87Vef+9czborgcwOMqULyLpIPQ
         UU2quh0pP7EitTEnS/yY0q6J9dnH/JU0P4e+oggQhqpwRuUpuU7Xk3pgqtWrmxhFVk1g
         WLlLfV4OQq2kfdNyvXMRE6brs4I9n5JuWuIF/9Lmu8inkWRU+sAlHYcLpdA9A87wbQeT
         pEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsFzOvz1SO+Y8nbTDeSDvFCEoJROV0H9OW7N8ZKTnzEfHCCiW6K2GmHXLQ69O9RA6cK9EZU+5Gh/1LN0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZ/H7BKe6s/Lccj4dHx8V9RwYPEM2Mxjxr7wl3XLCeaaG1oUf
	wt9BafIEyyVAXxICU5VdasmZBtj8GJDAgqoXVS+SgbJGg0c47GHmx37CfgB+Qck=
X-Google-Smtp-Source: AGHT+IGhdQwCy7dGozKjCuyT8kKsDdG3f8/KAU4iCzV3UU05p9ozWe5ZuVHalGWiqzrKF3YocjdHLw==
X-Received: by 2002:a05:600c:4e12:b0:431:4a5a:f08f with SMTP id 5b1f17b1804b1-4316161ee27mr24720365e9.4.1729268664785;
        Fri, 18 Oct 2024 09:24:24 -0700 (PDT)
Received: from localhost.localdomain ([195.88.86.203])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-431606c649csm31401105e9.33.2024.10.18.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:24:24 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: gcherian@marvell.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-crypto@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: cavium - Fix the if condition to exit loop after timeout
Date: Fri, 18 Oct 2024 10:23:10 -0600
Message-ID: <20241018162311.4770-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while loop breaks in the first run because of incorrect
if condition. It also causes the statements after the if to
appear dead.
Fix this by changing the condition from if(timeout--) to
if(!timeout--).

This bug was reported by Coverity Scan.
Report:
CID 1600859: (#1 of 1): Logically dead code (DEADCODE)
dead_error_line: Execution cannot reach this statement: udelay(30UL);

Fixes: 9e2c7d99941d ("crypto: cavium - Add Support for Octeon-tx CPT Engine")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/crypto/cavium/cpt/cptpf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavium/cpt/cptpf_main.c
index 6872ac344001..ec17beee24c0 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -44,7 +44,7 @@ static void cpt_disable_cores(struct cpt_device *cpt, u64 coremask,
 		dev_err(dev, "Cores still busy %llx", coremask);
 		grp = cpt_read_csr64(cpt->reg_base,
 				     CPTX_PF_EXEC_BUSY(0));
-		if (timeout--)
+		if (!timeout--)
 			break;
 
 		udelay(CSR_DELAY);
@@ -394,7 +394,7 @@ static void cpt_disable_all_cores(struct cpt_device *cpt)
 		dev_err(dev, "Cores still busy");
 		grp = cpt_read_csr64(cpt->reg_base,
 				     CPTX_PF_EXEC_BUSY(0));
-		if (timeout--)
+		if (!timeout--)
 			break;
 
 		udelay(CSR_DELAY);
-- 
2.43.0



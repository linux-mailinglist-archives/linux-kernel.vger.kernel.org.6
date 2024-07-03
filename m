Return-Path: <linux-kernel+bounces-239231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB11925831
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5B1B24F86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB71741E6;
	Wed,  3 Jul 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKi+XauI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86575173326
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001785; cv=none; b=o8rDdYIQGmrSkaJ2wQ2Dl6FtA2QHYYq80a16S4AryKEmXG89Q56LnYvXpIj7+XhXGXMgTCMsiuB01CeIB6zriQAn2dPZ1ILnVCEdz1lZ5XKkBy3EaTYw5fuKKUcLiXFhWdl3B+hrM2USx1m7KNwMKdNSIxn73wfbYfv4zGF1uAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001785; c=relaxed/simple;
	bh=2Hgb11TSE9fOERRmOGKvCbJsU5ExxL44Ao0bbckq9aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6Pux+BNpDAmu+ji9n+aXWanxhjDlPxKWQ1mHzxHlrpFmg/AgWdIZ1JkRGWsLkoB/vPuNc33qwXUsnl6QR2iH47mf79rn6ZgI5s+f9LfbdnWiphLdTbZw5COyhY6IXhKIbzLs8j+JYCGM7ziyBEf3QVkio7n8GmyXpHODl+0GYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKi+XauI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a729d9d7086so87488866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001782; x=1720606582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3joTjD/EvzvybWiPdLIbHTzIsLTnwS1UMLvS3hxDr3Y=;
        b=FKi+XauIGCJOUtOzsELIww5nhWM0C4941lxBHO7f1h8OT0CSAEpIMrpoIH5ied8Q1q
         XX6LqZcf/Wyp4KhqBbMKQwi3yEpPCnwyUrA8TWwWciAwJVZxbwnjWX0x7LdqhC853ssm
         1cYe/6GS5YZqeeFYQ5GN+PwQyw17K3E68kZfVH3PyGmMk1wjm/t1AumoJjDFfGqkRKss
         cRpatoOBJnib240YQbtr+hK0a+DwiWH3COk90PBweevlmwbFMr5pzPS/06ZJw8vgnSjD
         Yyda+V/cGDkq1454drCiy+krvdgsJAeGgSykrYJNeVzB9w5Igprd9TkAzM9pJPfsjCrs
         4UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001782; x=1720606582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3joTjD/EvzvybWiPdLIbHTzIsLTnwS1UMLvS3hxDr3Y=;
        b=rrrNjADgKK4cCiLgioVw8yhyjy/isq+yL31vg6R4+cbuOc8VLlKKz1RvIQXFKzqihb
         KVkJiAFvdLxeBO4wrZE70w+iydKheYYtxUNof+C7w5bv+gHfYUJ/i8G9SUqotZJVHwGg
         qaqiOf1EtneUlaQTIEaTGKGFQ+i1AO6pDXj0Gs/UM5ocs6gLVm5jI1mkfLKZFzKhdvEp
         so1rndIXWDfceUDy+LpAIk6Xp4sjPAaWAvjE0Ph4p+YeGNIH4Qbp0zBuM5gpAhgos9AZ
         lZ9Ja0nELOn3PLUpRSMobvNvCluIZQ/b2xlUQtvsHM6z8fPHmy5PvydjAWp2YQ+6h4qQ
         GilA==
X-Forwarded-Encrypted: i=1; AJvYcCXwSkGTe3s3O4WYjudxPhGSfzP4Fpu6Yim8tj0OWBg9JBUn+YfmYJAic1VYKssQcFi4IadbH1GiHwoGNooVS/YrUGXhBwVg69PGA5Kr
X-Gm-Message-State: AOJu0YxAKQGvXVrfuNh5F8XpfqKI0J0lDt9biBtbUbHRB4VEfKZdQdHU
	+EaXcOWnV0Mq+q1huaCw2MlXKcuCovLbLlWoQNWrR6gbpv8emK7VTzZKqXWfpQw=
X-Google-Smtp-Source: AGHT+IEELsiExLgIL8ViDXZhbHcr5lLNtKgOIwnhglxgd+MvGmadP9WGtD7IcS1FdBHJkN8UmxvuUQ==
X-Received: by 2002:a17:906:3390:b0:a75:1923:eb2e with SMTP id a640c23a62f3a-a77a24202d2mr96155166b.14.1720001782114;
        Wed, 03 Jul 2024 03:16:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:16:00 +0200
Subject: [PATCH 8/9] soundwire: cadence: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-8-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=2Hgb11TSE9fOERRmOGKvCbJsU5ExxL44Ao0bbckq9aI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSToVO7krJpsryvmNegqDera+Tzu8RsMQNven
 Pl+d2kxioeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk6AAKCRDBN2bmhouD
 10eBD/wOYMaY6NC26kuLeUu0bJQ+sYDgl1g6Q7lkH1bSLC5TO9SnH/0h4y+otOvZV67HNOwAd8N
 cH2zTy/Z2E+pNrHspUPiOSxzg9tDPXMpcdSSnkBvqqine3JZhibf6kXd0c73jtRcTTRleFWfMy6
 J4SOVEjrRO2VSXzv+M3iNRyUC9FU3ObCHmT55JAnRdRSwf5BYLZzD9GqqWtRtfmmAP/rY5CWWRe
 zOEDY+edSJHyVzoANpMEySXRE5xTcQpCs/qSjW/ZXTKfLH4NNKdEgpkfP5XBQD4Q7+PdmM7c6NM
 FGvnKZzzhMQaB8780Awfj0aJnoQePjrz9gVJR7eqyT2OByegp3MjXPEFye5daGwyUs+A3+st2Xe
 s8YO29KiNQUs0XuOXqtCPgQWQaOqeyRuiojdUr9LUk4DtwwAHpctlQzpbCAKcNI+mTLCI05PsQQ
 hgMuEtwxzPRyV/brU8MILtqInRt7H29Rm130MdNAe4ZopUxqoLeuz3m8jtUZ7Ujn3BJWYGpi9P/
 UZfv4ulXMnDaAzhV4NITyL7vL525gjJveZi9/fb0FAFnGHnO1mBVOhAFTZEt8z0+xF15ibZINOr
 Pfp6TunC1dFQJKp7P8LsFxDOoNeVkJJ9nFsFn1ckc9zlLHE1Ev492Zl5aDKlzYbF4nurrDdwhJ6
 /PNP2BP22TZcJaQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/cadence_master.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 74da99034dab..e0683a5975d1 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -6,6 +6,7 @@
  * Used by Master driver
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
@@ -323,12 +324,11 @@ static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
 static int cdns_reg_show(struct seq_file *s, void *data)
 {
 	struct sdw_cdns *cdns = s->private;
-	char *buf;
 	ssize_t ret;
 	int num_ports;
 	int i, j;
 
-	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	char *buf __free(kfree) = kzalloc(RD_BUF, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -389,7 +389,6 @@ static int cdns_reg_show(struct seq_file *s, void *data)
 		ret += cdns_sprintf(cdns, buf, ret, CDNS_PDI_CONFIG(i));
 
 	seq_printf(s, "%s", buf);
-	kfree(buf);
 
 	return 0;
 }

-- 
2.43.0



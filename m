Return-Path: <linux-kernel+bounces-437476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AFE9E93C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B248B18877E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0722488B;
	Mon,  9 Dec 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h84n/pQb"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6692236EA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747057; cv=none; b=BtI0STVUoHRR4a9Cjv50ZGYqEzmSVyACUc3/vFGn0TDBCsm8zOmxIXKmfk9Qq4EJJsxn9mBWPmoHpzSZb2+t3dNNnWU3S0wDj9J8hSCmHQr4Kd5V31wptGbkQo1Pp3BhnWoEtN4P/sWY8oVPQvtaUwPmzRo0Trtdymj1GnkAdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747057; c=relaxed/simple;
	bh=4OE2UNumV4s+P2YUC0SiuAHNvh4UuP4uD4bB25xADG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtsL4/fbbyg45Q9JBJ+Pp0KzmoYpACvdWfsM7De7eRzJR+Y8NTIEOcxBanoPTB6Dia4Fxn38qE5gVTAeRohtu6wqvfB470HXPUqg7yILgzik/Tb7w4DXdsUQ5VxMvbW4T+qN73FUPosRIZwho0BMGZG6ALg8297xU/pjSStGlkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h84n/pQb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6647a7556so35748366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733747053; x=1734351853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYnPC+3dnQ3xTBOM4P/CUIbuS3rg7DS/lMF/rRnPfpc=;
        b=h84n/pQboWq8MNlXDDWrDmlmtWfZU4esF7eLnQx1emFtcm2fMxuYD6J5XR1iwlo81W
         CY3gAtdN75j84IupY09vcoTnEqyQmCe+9h2ZJbaeEQzoPdO96SwhSqYIqW1ndrNHcZow
         y7fmdiRwcjfvPDCDPQGRwTGHcxZkz9c8iOmshY4Wn3ogPaAG86eZC6Q/rhAUjY7RWHEU
         dsp9enWG4kZkhYYjPtp4850OJG43UmiGZejVrrtyOFDp75Lw57/aZeeRCvb+guffVUQQ
         qq9T6IZRK7BH3YjCa4FjOyic3UuNAspeqZh7HjvQtSdWZYQ4qSrXFNweqzA8UEH9em9N
         9/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747053; x=1734351853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYnPC+3dnQ3xTBOM4P/CUIbuS3rg7DS/lMF/rRnPfpc=;
        b=Bw+CnD+j6rBb9q8pFvK5q+ppg/JbWWfKGO57GxaBVrWpT3c2Q5OOFMclrFvpzvzhCb
         AKFOXMaGq4WNFdL1Sb33oCaumuF83N3Axd+OWIEGBqx5RgIqzzyFUq085kK1PXx0OgxW
         sAsy6ZkG3VOnn1XMgMG3SoVuAMRS49l1chJuhnSOHEuG6EQTjB2b8tLVhnAKa8kfFwFp
         q3wEcZFuyFznAVdSu3JNHD2jL7fKdc4J10dWRBRDwS815Kxp6w9ScJxG8JTs40R7YKbs
         BoNAiuDSOC1hd1tsZnk0eNQJFcu2vaQPm1DyACbtNoB3AXUtSQZkcv7pfjwSQFrGaM2b
         eafg==
X-Forwarded-Encrypted: i=1; AJvYcCU/FLOW+l0UdTjIWUpTR9Y6M4pSvcPB3VjF8UWhFpNDdUzYxiIL9p3iD9Bs5zwlu6RyCrf+17Dkqn4+jls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpxtGjcNaQ3aA4HP7iS4crx9HSFDyIqIJ9Xyv5ujZnrvzzHNa
	pa+PqBZwK8TP1tw1MwnRvLxW54+gbiBMbilvfc8J6PP1bqjT0cSg9gKNKFVcWUshrhv0uT9hfmX
	n
X-Gm-Gg: ASbGncvWJSmYQY0zucXG2Cm6RgI/rdN8wAqmCJTK/056thG5JER3x43VeA9NKC0wepG
	RAwpi6MKlyCzbErr7PhiKI0/MWdOFsqBK07JG3y0ZspvD2yygbRyABJgK8ykSOpPpcXI7k3E+Zu
	DqKMJkHfdr8JN3e+/MqrLnK4MONRLGh5nIFy1hpangkjXz+KxMnwymuY7C+OB0BZDQijNIzHx2Y
	defFpSRVeIXEAYbKLrFO3mPMx5YePWVGXXECs03VGwYaCd9lW+4EoW2ai+mPXUXMQ==
X-Google-Smtp-Source: AGHT+IGA6c7ObX/AOXazYgFDpzOOBnfoe8Yqzc7iHHBjGsOsomSWtlEo9XgjPuAQbV9iNrzjXdFM6A==
X-Received: by 2002:a17:907:180d:b0:aa6:9407:34e1 with SMTP id a640c23a62f3a-aa694074166mr69867966b.10.1733747053409;
        Mon, 09 Dec 2024 04:24:13 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66b96a249sm309925866b.159.2024.12.09.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:24:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 13:24:04 +0100
Subject: [PATCH RESEND 1/3] clk: qcom: rpm: simplify locking with guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-cleanup-h-guard-clk-qcom-v1-1-b1077540230c@linaro.org>
References: <20241209-cleanup-h-guard-clk-qcom-v1-0-b1077540230c@linaro.org>
In-Reply-To: <20241209-cleanup-h-guard-clk-qcom-v1-0-b1077540230c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4OE2UNumV4s+P2YUC0SiuAHNvh4UuP4uD4bB25xADG4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVuFoTo9hkhnYTavcOtwQzo5Vc6u5rjORkxajj
 HdN4pZbS8GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bhaAAKCRDBN2bmhouD
 12raD/96VfLAsBFtWhV3CZjopOabQG1tVIiYugRecFOeUe4huzVbCLV24Gqo6CtGetm5JOKfHz8
 iOSOY+JilVXTGN/T9VCT4Y1i7fMcLnSTCtj75satrIA5mLoFRShxSQmz90dkJ0F/7JrIaiQclr4
 XTEHI9O+9ixi3Qyoha3GeYDXlNnXvNuqJZHG8K/nhGiqhgyLASdqi4hwF5RickcC92c67eAkKp3
 XvmvRFhuej/UHMCXyXF38kpM5XvOJw3VfV6p7A56yGJ+25c3ubuMS49pob3f5fAxPMShjJixZDu
 D4np7E0/HR6uPHdSBwn5hTNIs/xbID39CkOedY+jBf4pSHr3ANd2YhdAFtPzIY8OWeFyLapwFGP
 m/v/pr/u7UDpG8Iao7aKOfKQHH1ntv4CSbW842ouj1ialhf6u8Tu2+KK3jFam/rZcszMRtkU3tn
 1NwjLkqtoQS5fLMLXM0NwY6hBKGx0E93IoJv4T6VbNFxzpveX1jQYLXPiOwVY3r4RkB9rzrpoFZ
 5X2yWBqKwPg8Q6m/hTMCFt2EDkgyrbsgDHtzRDW3Lqu95IKhlhh+ulbH+7kL3mszVT9rie5XONW
 of1ch36rPll/SRPjtrYKn1RsyEQcfe8hboHNol/IBiNvb3nqhn9QCO8hakL4OPLlj/s7p+mm1ab
 1AloIYvxm2ViWPw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/clk-rpm.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index 9da034f8f2ff504404abc4f7a0d3b8fb841a6ce0..ccc112c21667ebf8522b06b37234f46c69b07698 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -224,10 +225,10 @@ static void clk_rpm_unprepare(struct clk_hw *hw)
 	unsigned long active_rate, sleep_rate;
 	int ret;
 
-	mutex_lock(&rpm_clk_lock);
+	guard(mutex)(&rpm_clk_lock);
 
 	if (!r->rate)
-		goto out;
+		return;
 
 	/* Take peer clock's rate into account only if it's enabled. */
 	if (peer->enabled)
@@ -237,17 +238,14 @@ static void clk_rpm_unprepare(struct clk_hw *hw)
 	active_rate = r->branch ? !!peer_rate : peer_rate;
 	ret = clk_rpm_set_rate_active(r, active_rate);
 	if (ret)
-		goto out;
+		return;
 
 	sleep_rate = r->branch ? !!peer_sleep_rate : peer_sleep_rate;
 	ret = clk_rpm_set_rate_sleep(r, sleep_rate);
 	if (ret)
-		goto out;
+		return;
 
 	r->enabled = false;
-
-out:
-	mutex_unlock(&rpm_clk_lock);
 }
 
 static int clk_rpm_xo_prepare(struct clk_hw *hw)
@@ -324,12 +322,12 @@ static int clk_rpm_set_rate(struct clk_hw *hw,
 	unsigned long active_rate, sleep_rate;
 	unsigned long this_rate = 0, this_sleep_rate = 0;
 	unsigned long peer_rate = 0, peer_sleep_rate = 0;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&rpm_clk_lock);
+	guard(mutex)(&rpm_clk_lock);
 
 	if (!r->enabled)
-		goto out;
+		return 0;
 
 	to_active_sleep(r, rate, &this_rate, &this_sleep_rate);
 
@@ -341,19 +339,16 @@ static int clk_rpm_set_rate(struct clk_hw *hw,
 	active_rate = max(this_rate, peer_rate);
 	ret = clk_rpm_set_rate_active(r, active_rate);
 	if (ret)
-		goto out;
+		return ret;
 
 	sleep_rate = max(this_sleep_rate, peer_sleep_rate);
 	ret = clk_rpm_set_rate_sleep(r, sleep_rate);
 	if (ret)
-		goto out;
+		return ret;
 
 	r->rate = rate;
 
-out:
-	mutex_unlock(&rpm_clk_lock);
-
-	return ret;
+	return 0;
 }
 
 static long clk_rpm_round_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.43.0



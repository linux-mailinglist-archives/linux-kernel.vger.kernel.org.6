Return-Path: <linux-kernel+bounces-437477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69F9E93CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8B165D04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A12248B6;
	Mon,  9 Dec 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSkfFdnj"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64272223703
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747058; cv=none; b=tvESxeZpE2+cnI53DYVLOH6bDzsWff9MBEBvp+pTvvLh0DFRjqVaKFa7mdC42j9/0PqtH9H3fqyos39zQ28xW366sHKYja30kUdI08ecnhrTTvOxZ5mbF3tAqsORBhizs3dkkDiDzbi+UR0/YMMl/f0Pg/Yc/4I0lZvLdtPPTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747058; c=relaxed/simple;
	bh=rkMjCrwS1+wByjVOGZBOyBmwHcPRefAACRVZAjVFMrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uB4z+WJxfNWyennvl4GKfBRVuzG34XJahc+g8dqBWHwZHQA4vcH47FdsJOPTL8BuneHi06pYMzKNXg6oNaXxOEnI6sBxbqNsm+VJNEI8qb5w6Q/cXOqwNUZw16TSl1a8T09hZHgxbMAQTSBwO2wqOsGEgM4exTLUxqWLIC3HQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TSkfFdnj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa65f707419so40886066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733747055; x=1734351855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VS86PQrU3aNTPQz7X0NdV1vS6PaGx8hn6CNMCEHmEw=;
        b=TSkfFdnj85CTjX7fstayGkA+yd08BtcXBT/3toiUjY3nBkkYZBXSHhN3uk3kBVpPMc
         vAexlKp7C2eSDL63Hz7EXl3hZSBshsIx/mqlkgt8AR2Yh2U1JYzuWX4u2GKtPjE/ujVs
         RAykGzOOb37O2A/EDHjXwX7tWS++CrZI5fNBDrTMVIl55WgvPENwXKfpEq0wKsYToyBG
         uDkaT0PcH/XRXTTBZhD/RgZzA26FxUcOKXXR/wbkCI8JHxMO3WFFKdnTAIOWpjpKiy02
         7dhz+75DkHynof/09jlwwFvPdxmM9C33wIwuWayf3bHuZUsMy2WenQKMXRmVSLxNklM5
         W4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747055; x=1734351855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VS86PQrU3aNTPQz7X0NdV1vS6PaGx8hn6CNMCEHmEw=;
        b=dB86OPT1VmMS4kCUfa0wiarzT4xH3gtXrkaR6kB5PuyUHYt7pWUX1zKewoRFZxdYLF
         lsiMxl4lad929zM48H+5xiVz+OHvGdidfaZrtJHH8cgjn4y5ywmBTZntJfbc6FrVFWVC
         GQs845mP30QPXCQEIS30HQmx2kwLR3Q7hZyfNwFoO9ShobhyTqutm1MKToNlL5au4Qrn
         +N6vx7uKQ4ojzyaEQU4ghwXJfXoBkggryCf1zZsqMb/jMla0WjmfdlgbypEs6pPN0Ugb
         66pkuaflZaA52qye6Ak3fG8ZyIukKNQeipXLuwsSP3ciATuji+bkpysuDw10byvgAlab
         4Kkw==
X-Forwarded-Encrypted: i=1; AJvYcCWUIA6GPIf8qjQEo1qZ95uuWvZAo5xtWsluvCG8ZAEtgSOTdW5c0XMy3/cJDcFjlXE+tszhGBHkpsoE7so=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYTMCMsexdFyqeWlEa4Simn5MWTozviF/waF9As/bkotE8ap1
	asjwpJdA65wMCHfRiBn/oZrt16aTkwkgRqO5vKZbzlRZDlQ5vjeZ98l+eqdpMe4=
X-Gm-Gg: ASbGncs36dN82I1O4S92uJtC/jS9nFIJVeUS9delkoFsTy617HKoxi6OE+RDbyDcv6R
	uIN8jrbC70Qqq/F95L/fVrArUEB2wKXzg15m55GIGVCs/YNl7hxjg5YQLYuYGCDWDrHQwMsd03d
	P4VHPiWy6dcq29lG6dhoWqQXHIqPSr3JnIJ4F1JrWFGE0AfJmxl0eeTZNfaFhPXvy/is3wswFYd
	LPDba1I6oVvb5MzinT8yADJDcjxPgCgoBH+CgtfnR+PFbW1p10W2dHnjby9omZwZw==
X-Google-Smtp-Source: AGHT+IHMa1lVKER8h4Ap0+h8iEA/ASsQQiOkTcbxptlpeVP7AhBWBqczT0R0GsKDETc4Mf1TgulAPw==
X-Received: by 2002:a17:907:874a:b0:aa5:3e81:5aa2 with SMTP id a640c23a62f3a-aa639feb836mr488047766b.4.1733747054666;
        Mon, 09 Dec 2024 04:24:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66b96a249sm309925866b.159.2024.12.09.04.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:24:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 13:24:05 +0100
Subject: [PATCH RESEND 2/3] clk: qcom: smd-rpm: simplify locking with
 guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-cleanup-h-guard-clk-qcom-v1-2-b1077540230c@linaro.org>
References: <20241209-cleanup-h-guard-clk-qcom-v1-0-b1077540230c@linaro.org>
In-Reply-To: <20241209-cleanup-h-guard-clk-qcom-v1-0-b1077540230c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rkMjCrwS1+wByjVOGZBOyBmwHcPRefAACRVZAjVFMrg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVuFpiHvV0uVRDjZL66G52Y9rZuBpcDh97yVqm
 7VCNFzDmjqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bhaQAKCRDBN2bmhouD
 1z6bEACDJRMV3tKG8OzJzEzGyfz0lOZpMOl3jN/tTBoHX1ttuGWTy4ndNdqgrS10DEBZX6AukHR
 2RkvqWkTyKKdNzNQuzOUVZceVDzp6+14dJh8OmLv9rh3T1CybD01NWxDyX9E7dHwpzdzjKuOzik
 ysttIokEqGs7IBZ/l/nokgkJYYEd29LH5YirY5+WRuNafy79CfiPlh6J+BUxTMaw+qQuWFmoD4t
 PQFyq2OQiBrgTYYxqsxrT4JmK2wXe6+MD2E7A6hE6VJdr1O23cjjMVX3b6+Y0+zZbP6h7VO6cUc
 VyQzxXWG70zOEUW0ncp8VxGy836HsZoZT6XQuxBfOW+3dq2jEzkzDA3JMmNc/gFNaqb2eOHd0ll
 P6LbKNLNdJScsdo+7cCv6RlcXMffERSL6CNnOY62KiEfAIJyXrxcvOL6RvGd7qZA6Dom2kJeNAq
 6M3qnKP7ZQsFDIENjvEUPMTO95+zN6Ql5fL8pkAPLtsOESS6QvIBV7qnYM+dyTwGeTMJzqk9LZ6
 g/725GdkH60DSX36J3YUYaUjUqos7CJFgBuENmayd8k+e+t3MOOzpeh9pEF0K++9Z8PV1kbpVOP
 LEy2KoplchfXrzS10mQIx+q5O2+boaYrOiH4dh5kiLIoLpYZv1npQMxIclDZpW2qHr0xOE8sctQ
 WzPlTI+EO1P8OkA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 45c5255bcd11bae69b83138ba1d5e52a8a3f3be8..b8cd9f7301194a539d5fb18f974a5600496a1032 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -309,10 +310,10 @@ static void clk_smd_rpm_unprepare(struct clk_hw *hw)
 	unsigned long active_rate, sleep_rate;
 	int ret;
 
-	mutex_lock(&rpm_smd_clk_lock);
+	guard(mutex)(&rpm_smd_clk_lock);
 
 	if (!r->rate)
-		goto out;
+		return;
 
 	/* Take peer clock's rate into account only if it's enabled. */
 	if (peer->enabled)
@@ -322,17 +323,14 @@ static void clk_smd_rpm_unprepare(struct clk_hw *hw)
 	active_rate = r->branch ? !!peer_rate : peer_rate;
 	ret = clk_smd_rpm_set_rate_active(r, active_rate);
 	if (ret)
-		goto out;
+		return;
 
 	sleep_rate = r->branch ? !!peer_sleep_rate : peer_sleep_rate;
 	ret = clk_smd_rpm_set_rate_sleep(r, sleep_rate);
 	if (ret)
-		goto out;
+		return;
 
 	r->enabled = false;
-
-out:
-	mutex_unlock(&rpm_smd_clk_lock);
 }
 
 static int clk_smd_rpm_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -345,10 +343,10 @@ static int clk_smd_rpm_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long peer_rate = 0, peer_sleep_rate = 0;
 	int ret = 0;
 
-	mutex_lock(&rpm_smd_clk_lock);
+	guard(mutex)(&rpm_smd_clk_lock);
 
 	if (!r->enabled)
-		goto out;
+		return 0;
 
 	to_active_sleep(r, rate, &this_rate, &this_sleep_rate);
 
@@ -360,19 +358,16 @@ static int clk_smd_rpm_set_rate(struct clk_hw *hw, unsigned long rate,
 	active_rate = max(this_rate, peer_rate);
 	ret = clk_smd_rpm_set_rate_active(r, active_rate);
 	if (ret)
-		goto out;
+		return ret;
 
 	sleep_rate = max(this_sleep_rate, peer_sleep_rate);
 	ret = clk_smd_rpm_set_rate_sleep(r, sleep_rate);
 	if (ret)
-		goto out;
+		return ret;
 
 	r->rate = rate;
 
-out:
-	mutex_unlock(&rpm_smd_clk_lock);
-
-	return ret;
+	return 0;
 }
 
 static long clk_smd_rpm_round_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.43.0



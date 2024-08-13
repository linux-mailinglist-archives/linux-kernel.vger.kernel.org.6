Return-Path: <linux-kernel+bounces-284569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6805B950294
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1856E1F2258F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AC2191489;
	Tue, 13 Aug 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwRw7BTm"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E79208AD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545552; cv=none; b=F+rFbyrz9WGpfkOaLjNA6iXLav+SJS4Iq8N0qF+dGV+6wwo4lDk/kh/gg5G+uPxHfGyutItjgMrhUMHvYxNDnxqR7La8JmxSoEHDIfvBWWDtaJNOFaDG90oDhpFn50J0SB/oNdnT34a+iHLWQKnPjWd7JeOO10V8VM3304vmb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545552; c=relaxed/simple;
	bh=fBiBB72seByPR/LQjvOJc5w6OgAxSgqTj1kzOZj3ods=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pq2b7BX7oLNpcvkeenntXq2QD/B8WVvTIQUyo0sNV4KsuYDo9BOtitrW8nMG70ov3ONNYQ8U1pPd8XL6kBZA7SjRvzMv+keqeUc1FmCfk/9RK+N35nhFvf97JWzZTjXv8r11ffTmTJis+y3G6bxyizHT9AHV49IzYi2I0OcX9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwRw7BTm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44ff9281e93so28077321cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723545549; x=1724150349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jodWGM3qFCwiaXWXlR6WrhJO0c3QgWrsycfmzzz4DaQ=;
        b=vwRw7BTmuDXi7bmCrLEn45b88nQHpvViz1JFALOM0Y13ZbPqltypcc3W7and4wZDah
         Gq9Y6UNTHLlGcxP8lyL8RoxOfl++XLJrC3t6cCDXW3nb/bgB+Sr3D3uaWqm9xNEswQ/I
         +STmmU+TRWKWD/ZEEYAxwNG3pZiEzeEs6dLEhfta/rxlub+DUY40n7lMmSY2U/Fac/C6
         p8DepSE2m3iMP/s+VPTqVK7oyk93Y/xAN1VQsVFsBIlLh+OICQYiqJYEscJsC4qTkJOK
         1OyQVlDG724Ec8Fs0nFQ4ZeE9MTzSojqMrGEV0asGVmChQ+uSl2roktYypWQapMEwGFI
         Z/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723545549; x=1724150349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jodWGM3qFCwiaXWXlR6WrhJO0c3QgWrsycfmzzz4DaQ=;
        b=hKgypsnVWpGXFwkucyB/U4EIG96p6Kt5lscGIzYZS0qhaIHfcLZXC74+Q1thWF44oi
         xBQdCJ2CUAYPFQDkFqbM+IXimrempfaX+D3eStcwi1k/PP1aylBKowB6k/l7HJA69RV1
         pTf07PETroX0SPzvMMoB3OUGdfwTtaL3HzDhqbp+WOk1RlvsLCIy/gpwjqDNWj3qtkyv
         t20ICLavGyZRNmsJ2su5SoiKtwDCuGgAbQ3T5wRCpcQJNHRT1Z7RYHVN2M3nbeWwZTMP
         0Wjuwr9nRs2G9mwGHxNAxgWZTYItN/f5/SGfKiZOfZjDyCifMmgNxxBR34MoMUSsyMHU
         fsxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0f8sHkGA8iMyIF4wO/UxqxCl7GJ+l2FlH8G7DQ6zanxXOiMUU80Mv8IjOC428bni9t+bjY/19IiWC8hMbu4uTA7oM6thDDYpP35I3
X-Gm-Message-State: AOJu0YwD7ikCRG5oUhe5PqHI3LJDkXJfKieqJ3eDdIst25zu2FyHXTP2
	oIpQta05OeY79ZsAQSd9W1r0vUyJHlHjR9fCw1PYQIGTlyK3IIwDw2yC6iSIuZY=
X-Google-Smtp-Source: AGHT+IEQhu0sZEQwCMkuuHp2+Eej+3CluKEqgv7pqdVvvNrpNNxUEkdiadArn7M6LWgxB6RNVXMWSQ==
X-Received: by 2002:a05:622a:2486:b0:44f:fb58:8c3e with SMTP id d75a77b69052e-45349a60677mr39456191cf.46.1723545549177;
        Tue, 13 Aug 2024 03:39:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c28fdcfsm30942681cf.90.2024.08.13.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:39:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] nfc: mrvl: use scoped device node handling to simplify cleanup
Date: Tue, 13 Aug 2024 12:39:04 +0200
Message-ID: <20240813103904.75978-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nfc/nfcmrvl/uart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 956ae92f7573..01760f92e68a 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2015, Marvell International Ltd.
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/of_gpio.h>
@@ -59,10 +60,10 @@ static const struct nfcmrvl_if_ops uart_ops = {
 static int nfcmrvl_uart_parse_dt(struct device_node *node,
 				 struct nfcmrvl_platform_data *pdata)
 {
-	struct device_node *matched_node;
 	int ret;
 
-	matched_node = of_get_compatible_child(node, "marvell,nfc-uart");
+	struct device_node *matched_node __free(device_node) = of_get_compatible_child(node,
+										       "marvell,nfc-uart");
 	if (!matched_node) {
 		matched_node = of_get_compatible_child(node, "mrvl,nfc-uart");
 		if (!matched_node)
@@ -72,15 +73,12 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node,
 	ret = nfcmrvl_parse_dt(matched_node, pdata);
 	if (ret < 0) {
 		pr_err("Failed to get generic entries\n");
-		of_node_put(matched_node);
 		return ret;
 	}
 
 	pdata->flow_control = of_property_read_bool(matched_node, "flow-control");
 	pdata->break_control = of_property_read_bool(matched_node, "break-control");
 
-	of_node_put(matched_node);
-
 	return 0;
 }
 
-- 
2.43.0



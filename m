Return-Path: <linux-kernel+bounces-289526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9D95472A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B19288071
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9911B86CB;
	Fri, 16 Aug 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTon0r9i"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C161B013C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805699; cv=none; b=cEEvftFVf0uzRE4VXLJcXN7uoaiadtvfOxi8Ihii/9y0h/xACRzloGSFDycsjVNb9kNttf61aU/dQIgodRqHiB7SArgrf1ysienp/NPYDv2gs0Rio6Y87WZe5iUcM/3vRJQ6uOxriNesvKy0gvznz6PE0DRLF6/JMnsaLLyTICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805699; c=relaxed/simple;
	bh=SAst7T1lfs852WDMPyN7cdI8dxlvyoFUdcgyCbTBwGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCpRtQK0GS0neLrxo3QX9Of8De+28ot6UXUzFn6zZMROD0yH3RRAQs7u4V1qEN+HFcPUofLzuwsA+CiB8OBe16hydO2/xOkrVy+g1+8CAaGN7ZkYix+em091TVGAIR3BLGY8hvIKIilCzdjphPS22SDd0l45dh3cAHoGZ+uQHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rTon0r9i; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42808071810so13274065e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805696; x=1724410496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YRde/fYbJz8xZyUhMQmHjg4wnmznu+US4KTcpFxBxo=;
        b=rTon0r9izOcVxaIobCXLhmFUDXqudTjXAxV9Jq8pTl1qrAxiO/DtQJhxkC10c/sv+M
         9bGpuBJrihGaKKG4CWdN8m+UOS6ic+aU6Z7Qqz6QK0fTEnPzf8vf9K30PtZLeolvDBhN
         qOx9Z5CnGNx8PR2xZl8n1vBmijTtdUa5BHf32UaISQK+svdRguv6hXd2NAKxXgtkvMT3
         uUJQc36mUibTTikhF0MeC84sN19JG/6cITboccgCD0cYGk3VCXjRLNJBKR8XltLtpNLe
         sxnfuA+oCFiLK9vhIAatdX4X2c52b94CBDI0NOY6UVPcjUrHg2P/esXdyCdl1/9Ec9m8
         T3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805696; x=1724410496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YRde/fYbJz8xZyUhMQmHjg4wnmznu+US4KTcpFxBxo=;
        b=JsW+RU5Y/B08UGoLWwi7TQCe8ZNh3Z4fiaFeUCxeMgnMmACSMa5+/gZzkYLXNFVQjS
         svquIgmCBfePAAM6wf8abXoOhOycGiLIAzlNPjViJ7zbKz+ysDYlsfFnVfIlhXAhQ3VV
         kTqQxynTP9IGYH033e1Ob2grKTa4UQKZfECOOY8RV8LOYZc1ORQ8b8EbMtfSMRVmaaUh
         VTWRmwzjGFqDx4riHVygsFEDG+0x0TAKdqwkt1rVcbucwDO5VhopSlKiopt/SEgCvgG6
         hzEVvkpDWggGCGA8QdJkFML4i5UbcOc7z7qfpK6vU6QQfnaoYuIGDeU8C4q4UtN34ZrO
         Fp3g==
X-Gm-Message-State: AOJu0Yxf+ehaHzBkrN/WgeQLl5rJf6EhzTPEZeX18cw/5RqicZ45Wmj6
	2oFK+lusUZWeUgyhUsAn1GHjvlvRdazbyH/gmz8Q0FmRw1AK14RcVywDkaj3zy4=
X-Google-Smtp-Source: AGHT+IF6JR5QgFzYZqDis0yng6ewdCGRElyq9KQSPO+EpQI/aW4zcsFVDjGZ6uVazhi1rffyYnq0KQ==
X-Received: by 2002:a05:600c:4f8d:b0:427:d713:a5d3 with SMTP id 5b1f17b1804b1-429ed79daa4mr16802255e9.11.1723805696134;
        Fri, 16 Aug 2024 03:54:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:31 +0200
Subject: [PATCH v2 07/13] memory: tegra-mc: simplify with scoped for each
 OF child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-7-9eed0ee16b78@linaro.org>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SAst7T1lfs852WDMPyN7cdI8dxlvyoFUdcgyCbTBwGY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/slbj3+EXAI6pk399+GoDZQ7kgdWtQ7XQ9i
 iI781jL8UuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v7AAKCRDBN2bmhouD
 10ZTD/0Z7SRvLmaBE+Gm6YtZvr0IwKzMR9efFrxg+sCxIUabM6l8TKG73/GeZE1pWa2NzX5Y5MT
 B+MgKAT7I93N042qHHUfGjB4ZNqu3HoHMBrDTFFoixqjMeJ3em7cZuCi84Crr1chTAqvyqQdZK9
 idnbYS4yHD6T/VcXQ/6OhgyMuf1OfyghFcekCQGQQB3ifinxb9Sx6u81HbboWBwlCLU1vAOMCya
 l/8TUj7AzauBbQOT8cHxiVmydvVG+QivUVINIkENi6eWcdAPRl4qBYanLQTckl0s3HOeKO8rSjg
 VwvimtJXbPTRswVDhrO3r+Q5KlgN0Q/03mPM3GRPRCYBfZ5Q+M2NOGrc1pmHMmkC/IJjO6D6fmr
 P2s9hAJHAvHYlucn5l7uV2zqb5UB1s/MIW8Fh0ZTuSFFo/HzH7MFBXdYgQSagiLYliwLeVLbsoe
 vloGmpxWk4IvfxapJl3a5beo99W8PALAYRwiMTl9C9yU3ysvJ3l16kMkCQAsIB6fB07zi25a7AF
 5lyltwEAXdORJvYfV2qpH0ubioiMFhxVu/lTr4N9gd8r2F6HEj4aNZKhFhfk4KpWypXInpaW3BD
 rkFiaKUi14wboHIU0trpU3cNYvV66uyuLxMKTEGykTQ7eihutPKJyUtr1HdprrvuO4dl9aNcMU1
 aV0RVoW1QBvtjIw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/mc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 224b488794e5..bd5b58f1fd42 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -450,7 +450,6 @@ static int load_one_timing(struct tegra_mc *mc,
 
 static int load_timings(struct tegra_mc *mc, struct device_node *node)
 {
-	struct device_node *child;
 	struct tegra_mc_timing *timing;
 	int child_count = of_get_child_count(node);
 	int i = 0, err;
@@ -462,14 +461,12 @@ static int load_timings(struct tegra_mc *mc, struct device_node *node)
 
 	mc->num_timings = child_count;
 
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		timing = &mc->timings[i++];
 
 		err = load_one_timing(mc, timing, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
@@ -477,7 +474,6 @@ static int load_timings(struct tegra_mc *mc, struct device_node *node)
 
 static int tegra_mc_setup_timings(struct tegra_mc *mc)
 {
-	struct device_node *node;
 	u32 ram_code, node_ram_code;
 	int err;
 
@@ -485,14 +481,13 @@ static int tegra_mc_setup_timings(struct tegra_mc *mc)
 
 	mc->num_timings = 0;
 
-	for_each_child_of_node(mc->dev->of_node, node) {
+	for_each_child_of_node_scoped(mc->dev->of_node, node) {
 		err = of_property_read_u32(node, "nvidia,ram-code",
 					   &node_ram_code);
 		if (err || (node_ram_code != ram_code))
 			continue;
 
 		err = load_timings(mc, node);
-		of_node_put(node);
 		if (err)
 			return err;
 		break;

-- 
2.43.0



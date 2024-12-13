Return-Path: <linux-kernel+bounces-444962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C744B9F0F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA15281BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB21E0E10;
	Fri, 13 Dec 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0pWMkvCO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637F1DF991
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100227; cv=none; b=kEUyrkXO3E68XMMb5nFreSsOWsfVpBDGsvii9iVxvBLWh7zcIpzAi1Z2QGBnV7U+b7/eyT5TjA+L9mwSjbIPb6ezXMeNqjO/w6sCHDRCq3mk1QewDpvz8fWQZ7GiDwVbZn/eu6a8wzCfN7oUBGcIHonvQgAETQrdUbIs9oBfp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100227; c=relaxed/simple;
	bh=l+LOytW4KMl4YzA8MDmiu6FsOw4fpbkKcHgg4999JHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hr9isaCjOdzFl1s/5xcx3rhiVoz8Id2HWkknJLxHxjZM+U7pQ+uyPdbuPnk/rHSWPm/IqvkFP30i8/RIJOoxFqgf/VkWPwvaNJvhYzngMxhHeaHz0xi7y49iuIzvHy4cKXzC1vHg1JtUeEpirxbW0MAFOhVvaVqcQm3uuo0qoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0pWMkvCO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43628e97467so11644925e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734100223; x=1734705023; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi1TXEqqDBiezezG8nYR4uQXdlaFaxavbh3mrGsln2Q=;
        b=0pWMkvCOTJrT2kn9fwe4Okalukj5zMiI17hN7TVGE1JdIXUYYYiq/308giGOZdGqDy
         /F3V06jHbIYMkxlUkRLG2GhNl8W10qJQa9oVusPDT5WBHGxX1lNskzauWCntaVk1Ma6W
         mqSq1ZKLSb2S0AADQ2uMtO+WA0hRwfRn7S2l8hDyABUIR25rpT9ng/c1Rx5FPQQeg2Fs
         z9hYXQn3mTfySuXRH5iDAUeLvk7w6pyodEQGxgR+gklY8m07lK8JEhh69XER0G8aBCy/
         75jvI3Drpv0dYl1IoCRV87pgeHMcOqvepN5w0XJLubEUUXhSgCKaQOBJJITuaB6vf018
         pAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100223; x=1734705023;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pi1TXEqqDBiezezG8nYR4uQXdlaFaxavbh3mrGsln2Q=;
        b=OK7XqlGFxwtH12lgrOBUJoZ9LWbSbeek/f4suE8j/gcJEvg5Dj2Oh8OUF7SJS5f3Tr
         vX44EFNhNiSeDRgyjxDS7SqiLh1A7St5+gW51W4PgYPXge3mzyLyby/W+sHH1s2yyulI
         i6SauJ/dtTLF2Do3C7e91uxe36W32J0EjllqI7mdQhAujKZByDwEP43/mKasuI4WAcZz
         Nwv1ourpnmYknnljXSczdA662luKHbRpqFzZ5Oq6mpoWbWnN7zBqbasFAaQzHNHJOoS2
         xydZS+/ZkqWMsQsmK2p2FkC3jIzH7k5F097wehk0mEBWjucbUfVtrzsU+psKgFbycP2F
         q5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUQv+D6f4eAOu2BlYjvVbU5qh0yXEkxJ99eEYUP0/PcVL2DG3dAdRcV67eT5wizHNOIPhunnmGMqBcw9/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKe4ssTu8e53RzmkUkp4zPdbYJPAgONP4EHNMHdY8HYKH8RrI
	/igNECPI9DHkw5T4Pe18q8rd7aY6Lr1nPMW7iF4/ML3CMePvAWygWJi282DuOng=
X-Gm-Gg: ASbGncson/qYPVAq++vd+VxBTh12PkRSAMEG9owH7NnUvgwPx92NUNnyP3XwGUYvQl9
	vSJ5ntZtxs8Uh47oXgF919M/GYAXIqo4O1kMxKim+ftpdyh5iz5pRFBs6TwY6rHBoljMIc/uxLx
	5gGDbvAilXfEGUqYIUTf8GYwvE7HOOWVrCsr+El9G9+lUbW69d2IhGwczkfl4KZKo62DzdmQtou
	JvOXuS9y/TzU2S8A305pozyxb1VUdAjoFmwFeDrdBeNOGXXCvZMfkR1BEO7admk9nM=
X-Google-Smtp-Source: AGHT+IEBmcupQ7jLd1GlerO1KBdvvlUtU+d7uGcD/hEi+3rvYzaqGrrDbYHOw1AfBKz8/xsv1HIlnQ==
X-Received: by 2002:a05:600c:a08b:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-4362aa1543dmr28303935e9.2.1734100223162;
        Fri, 13 Dec 2024 06:30:23 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:3da8:c88:4a1:9b7])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43625579464sm50747805e9.10.2024.12.13.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:30:22 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 13 Dec 2024 15:30:17 +0100
Subject: [PATCH] clk: amlogic: g12b: fix cluster A parent data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-amlogic-clk-g12a-cpua-parent-fix-v1-1-d8c0f41865fe@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPhEXGcC/x2NQQqDMBAAvyJ77oJZU8F+pfSw3a5xqY0hUSmIf
 2/oceYwc0DRbFrg1hyQdbdiS6zgLg3IxDEo2qsyUEvekeuQP/MSTFDmNwZHjJI2xsRZ44qjfbH
 3XU9+uI4yPKFmUtaq/4v74zx/w3KPD3IAAAA=
X-Change-ID: 20241213-amlogic-clk-g12a-cpua-parent-fix-64362495fc9b
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3449; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=l+LOytW4KMl4YzA8MDmiu6FsOw4fpbkKcHgg4999JHE=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnXET9FTQHlDf7COIAQ8tPKiSkEOeg1ym4k8nLN
 w2YmO/f+xSJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ1xE/QAKCRDm/A8cN/La
 hV1vD/oDVg1JFi3oFO2Jgffxn8O9WOKcGf5BljQHVgYNnYlO0R5E8Z0XETf+jKNf1t9+l7n65n9
 LEj685/INquJNq/DB0GqKRtBy8FuWJWEfoK35F07328l+LSh98VzWqB3QWMRb+LkyT9NQwrkN4h
 t19ECF0qW8AhO/kisqFU7bChtVoTrigfi+JCmmyE8vQgiMWaeUizUh1/DIlFOZ1iXOp805T1PLi
 FwQtPej0JyLfkjyw2lJ6ryu/EOEAmaYXvPGLCD3e24yt8Y5kFWnHdt/AfgylfLBnZEAW3+mkRnn
 +k+ClGBYBKjUnbx5PFWZ4+8zqK1meKPXwy8ZT8DFrC+48zevkLBGtZ5PVQwBywDwjYRBya/a2NH
 Q90mai8gFNfmTAKeK4P7i4wwzywzXg8uD9NX5vGczQoThKOcSJPaF69dGyY5/tGDo+lktSv8t6u
 Cl6cPEtw2RpLhzOCw2NQK8QSyaHfKUIfVayUZGttC1muG5li22PY/yE/2nXl+rdjNFL80fzKkMA
 uQuGWkG1ESYa0BE8q+5FFStR5UdMTRAZJQ99crrEJomu09ftxVfNAd9JpuIf89vvJoFXzSUQe06
 PWyv2wb3sA87J3EJrOgBID930xZbfC2KIXq1zbiI4kUXzYflicq4EJfNGNFkAyhFCNBpxjt9upc
 pSxW8yaFTC0phXw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Several clocks used by both g12a and g12b use the g12a cpu A clock hw
pointer as clock parent. This is incorrect on g12b since the parents of
cluster A cpu clock are different. Also the hw clock provided as parent to
these children is not even registered clock on g12b.

Fix the problem by reverting to the global namespace and let CCF pick
the appropriate, as it is already done for other clocks, such as
cpu_clk_trace_div.

Fixes: 25e682a02d91 ("clk: meson: g12a: migrate to the new parent description method")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/g12a.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 20be7b037c07535bd2115f6e70404a95a7832756..4e6584377e43fa7c9956017ddfcd3f295fafd686 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1137,8 +1137,18 @@ static struct clk_regmap g12a_cpu_clk_div16_en = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "cpu_clk_div16_en",
 		.ops = &clk_regmap_gate_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&g12a_cpu_clk.hw
+		.parent_data = &(const struct clk_parent_data) {
+			/*
+			 * Note:
+			 * G12A and G12B have different cpu clocks (with
+			 * different struct clk_hw). We fallback to the global
+			 * naming string mechanism so this clock picks
+			 * up the appropriate one. Same goes for the other
+			 * clock using cpu cluster A clock output and present
+			 * on both G12 variant.
+			 */
+			.name = "cpu_clk",
+			.index = -1,
 		},
 		.num_parents = 1,
 		/*
@@ -1203,7 +1213,10 @@ static struct clk_regmap g12a_cpu_clk_apb_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_apb_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1237,7 +1250,10 @@ static struct clk_regmap g12a_cpu_clk_atb_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_atb_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1271,7 +1287,10 @@ static struct clk_regmap g12a_cpu_clk_axi_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_axi_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1306,13 +1325,6 @@ static struct clk_regmap g12a_cpu_clk_trace_div = {
 		.name = "cpu_clk_trace_div",
 		.ops = &clk_regmap_divider_ro_ops,
 		.parent_data = &(const struct clk_parent_data) {
-			/*
-			 * Note:
-			 * G12A and G12B have different cpu_clks (with
-			 * different struct clk_hw). We fallback to the global
-			 * naming string mechanism so cpu_clk_trace_div picks
-			 * up the appropriate one.
-			 */
 			.name = "cpu_clk",
 			.index = -1,
 		},

---
base-commit: 799ce46951dcc75682223cdab12fdc905f2fe735
change-id: 20241213-amlogic-clk-g12a-cpua-parent-fix-64362495fc9b

Best regards,
-- 
Jerome



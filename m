Return-Path: <linux-kernel+bounces-322392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716CD972875
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF9528553F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102416F8E5;
	Tue, 10 Sep 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2DVRiGw"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28016BE23;
	Tue, 10 Sep 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943230; cv=none; b=rtlMkacqEJFLKUgrwwLYelEMe92rhi41XvgizwoensBcoUHHxUwVmBibifqf/CseboxsWIahyrKShWXZ/8GGuy7Fn7e0oOG/0X0swJSwLK49QMRJK2kHtBXgT/JVKa876UbEK0ATr/9rHBxFj46B4yoGlzTmTlaVzlxNe6C64Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943230; c=relaxed/simple;
	bh=03NJV2IjFFRVtnOUi61Rts7+B2w0enc00fFfqAjqIfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tuwvj19FKxZE+MlHi7ldPQd2uO4+ZWa4WjfcB5ZNZWrfCN8uLrvB1LTzGfQA8d14zs5BjCXgN4jbQ0ubPxeOULJTB334MPt0Zf7L5SGTjMeji4m1QzateuZmNTm3iQNXWEPePBNK/mgC1gdeCVFnhj4K0ruJYkx0+kLAgOgADw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2DVRiGw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb2191107so16946625e9.1;
        Mon, 09 Sep 2024 21:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943227; x=1726548027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tRmeZ7ssDDYlSOX1HCpNp+tOOHoJskFLu0y5AxWZio=;
        b=Q2DVRiGwgnkGW5KOjsc70cEYNyLATfnPIp3iKba0Epqm4qbe3MMOZXEL0sDUrqDig7
         cRTeTSvZaXA/WLcye3RvUcT3HiT8Ewl4tsVaUyGOnISXLj4kw5Xef0Zs7HXexDwHt+gj
         NL7yHmECOW6wv641kfXtREAAWPbcsjKBM0jr6qYTeYNrri/qklSGgSF4jQUBx6QvQLka
         H3NedDXJsDEC7dQjvTklesShyAKn3OT9BmDezS2F49RS4DLgIteNZWDdx57mCkEUbkC8
         x1PfAn525BAg4Wl1ZU+fDNq3+62qhe0YgfiN5KcjKisgcdeSgH7i48Z9jOw31uUFAR6v
         IsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943227; x=1726548027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tRmeZ7ssDDYlSOX1HCpNp+tOOHoJskFLu0y5AxWZio=;
        b=ld4yC5/CYikSGq2MwEZ4aJCFBp6XdnbnhwV1QI32l/NVCW0c6ozHElzIun2BhBBnsv
         ejdNcw4MAohXCeUaXNHv5KG/jqOU0wbRi2VHrdepDU32pxUvW+ID+/5ixCECTIhKCdKh
         2MeMDRTErIhw0mQWBQ96F5GT0AU7vEshrS4smNM+w3B3T6cJEH8IIa7rieq6WBY3d9u8
         gWDkH8owyFnTkhjEGy/oYaHCCotVv6sNmT7A86UUusb2/VBh8todRjOs3jI6E3epUo62
         LI3ssO9VWGV8gxs0K9WUTcOB8HsrTbn/tEVNrKiI7clKvD9hTmG11G5vKxwCPl9uf2PI
         IAmw==
X-Forwarded-Encrypted: i=1; AJvYcCWToZzauhRpCOGs8XrOI5e4mvTKJFCdKi88+uJd5GRF5Xbwy4K2M3RqEpSlyILhWUr6GohqcFf4bAFcEBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6v5fU35L0+OCmJcha2yvo2kXWNVFJkznlmM18fu686gx6SDi3
	UmIRtIv6jIxwbuqAM/pbOg8vvyeJdVbQjlwXnq1lpTPPXeOGC6JqBuETuQ==
X-Google-Smtp-Source: AGHT+IFL2GmeTsj+/nDdBemioOcPl2tlnn1ZJlaH+DfX1s3gCut+oBqayM+UQpJPrikDRrpSD4PIbw==
X-Received: by 2002:a05:600c:1c86:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-42cadb6a2d2mr70793595e9.33.1725943226864;
        Mon, 09 Sep 2024 21:40:26 -0700 (PDT)
Received: from localhost.localdomain (201.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01cae3asm5516055e9.0.2024.09.09.21.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:40:26 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@kernel.org,
	mturquette@baylibre.com,
	tsbogend@alpha.franken.de,
	yangshiji66@outlook.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
Date: Tue, 10 Sep 2024 06:40:22 +0200
Message-Id: <20240910044024.120009-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
References: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clock plan for Ralink SoC RT3883 needs an extra 'periph' clock to properly
set some peripherals that has this clock as their parent. When this driver
was mainlined we could not find any active users of this SoC so we cannot
perform any real tests for it. Now, one user of a Belkin f9k1109 version 1
device which uses this SoC appear and reported some issues in openWRT:
- https://github.com/openwrt/openwrt/issues/16054
The peripherals that are wrong are 'uart', 'i2c', 'i2s' and 'uartlite' which
has a not defined 'periph' clock as parent. Hence, introduce it to have a
properly working clock plan for this SoC.

Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mtmips.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 50a443bf79ec..62f9801ecd3a 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -267,6 +267,11 @@ static struct mtmips_clk_fixed rt305x_fixed_clocks[] = {
 	CLK_FIXED("xtal", NULL, 40000000)
 };
 
+static struct mtmips_clk_fixed rt3883_fixed_clocks[] = {
+	CLK_FIXED("xtal", NULL, 40000000),
+	CLK_FIXED("periph", "xtal", 40000000)
+};
+
 static struct mtmips_clk_fixed rt3352_fixed_clocks[] = {
 	CLK_FIXED("periph", "xtal", 40000000)
 };
@@ -779,8 +784,8 @@ static const struct mtmips_clk_data rt3352_clk_data = {
 static const struct mtmips_clk_data rt3883_clk_data = {
 	.clk_base = rt3883_clks_base,
 	.num_clk_base = ARRAY_SIZE(rt3883_clks_base),
-	.clk_fixed = rt305x_fixed_clocks,
-	.num_clk_fixed = ARRAY_SIZE(rt305x_fixed_clocks),
+	.clk_fixed = rt3883_fixed_clocks,
+	.num_clk_fixed = ARRAY_SIZE(rt3883_fixed_clocks),
 	.clk_factor = NULL,
 	.num_clk_factor = 0,
 	.clk_periph = rt5350_pherip_clks,
-- 
2.25.1



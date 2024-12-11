Return-Path: <linux-kernel+bounces-441209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E069ECB19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B02E16A31D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D32237FDB;
	Wed, 11 Dec 2024 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jth0fclF"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54A237FC2;
	Wed, 11 Dec 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916214; cv=none; b=W7s1kWpbD0bGNeohi14XQj/pD5rkObh5v0P7RRovaPgr1Gj9Y4VaFI45J7ebNRBm3LL8bLU9AeSBfg5jVLfVm9PhIYowe6uJEzzg8q73wOUZZnrxvqolXFmjwaV++Km2HNJIJOMFyYYPEed4oD9JHT3pIqcRc5UnDkhVnHxLbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916214; c=relaxed/simple;
	bh=M6EDmeyKicXLbYEzl0d4IsyU5odx0cHU8RR761Qn6bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9YzczC/L14GquvDf3gDJdwNTD7Mx/CuRC3Ev61JQlErHo1Ng7IWUMvlhAHaOWjqqAHxIUO4101R/1zlon9p2x3AT7xU6icQg6YfrOyfBisFdx5jwXYgTm7kq5BZRTq0NAXc8nV/XjZhjT8rUpbKxDy+yXPhZ2+FX73YXXouzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jth0fclF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e87b25f0so339687f8f.0;
        Wed, 11 Dec 2024 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916210; x=1734521010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAQdbixR3F+hjNBvHf6g37hsdm5eu5HmcRse0V/QexE=;
        b=jth0fclFaeM8l1AYL4gNzvJwWP2+4VAs2t3K8Nn0FXV24ijwTi0/YjqfbBUF9KtQMJ
         pZ9RrsWN71+dkzk6aitcbRPdhnBzEDiADr2FJPcWgsWIt2Tb5O3Egm+TH/o79CAUR6Hs
         cz/KMK3NiKeLnmvOsSrnwtSflBRrBThDxy6U/1TiNrZfabPAMzfCUCOzyMasRfhn9k5M
         iTGfL0OGSUGiZbHiueFF7lphLCUdwChqG38cyJtkf++YZGN4ecjnZrP6cxNqf585+Pd0
         VtxJydVFd3cgIiS3dFB1K9RUmOaWpFE2jQP9PSdZOFuDle9tI2+WgeyA0oO7m9ibuci+
         xXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916210; x=1734521010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAQdbixR3F+hjNBvHf6g37hsdm5eu5HmcRse0V/QexE=;
        b=p4uoXon5G2pL2H3jGnToizN5iwP1K13xa7ZLd6YLC0DAdQiinn6x0Qsh4peb0nVpor
         r31k9rIuEOLgGR7EKor8zF5Hza2SpQaDmY/QyJcQhALmMIkXt+EGRcCFSVPAsk8i4EMz
         d8KmCTfb1fE1dGgRCZWz8DHIKtuJtuxVUeMfTGrU8ThWDp5UrGodYcdoOmzw4hbe6efY
         BNhfAUrah2mQl1nDoAFxXkrW9AX5iYhm8JV3T17AvGeUeD99TLZT2D2xaVioIe5jSsYx
         A+f+Hw4e4P3O55X3KrIONj3jqyBWCpz8nHgn+wp2uB9fG30gB2rXdjcB2WiU0ns7icpR
         5waA==
X-Forwarded-Encrypted: i=1; AJvYcCVtZdl2KQXoJcjkF+k1zhjdD1FEOG0OcKYxQYB5xyLVzTGY0G1EVi3LBWhmHqbs99ux0H7xNrjDymrlfqkB@vger.kernel.org, AJvYcCW1LsTziBdCYhCjKygTbI3N9kQHolO9Y9Vqt4qcJRo8jneVnuiRe1QM/Z5W77mA+q0Ev8W82Q1emn4Q@vger.kernel.org, AJvYcCXEBrMnEnhJ3itBa62EcNm3tkIZQAbQCYTbDPtl1BGyd94DcDo14AO/3iWmWzs5ZWc3mjJnuxh+c4EL@vger.kernel.org
X-Gm-Message-State: AOJu0YwPwip5s+dcvepEXatJ8pgJuRtuxk6DYYxPKbKMaXSzu6XsQDg1
	DHrds6cauhgZVFxbO3PdjxjROBd+QSBSXtevc10Q98vOYO+2I/Ek
X-Gm-Gg: ASbGncvXqmo+K8TO4NW4hH5woHXgN9QP2Rjya0uIrfdv8337c1hG7ymlTU8ptgKh7k2
	Il1q9QMl+itPdzu0JmxwL2a4UDFYys09BM1L5Fsfsy1jPAmbEln0bGCEQbnCWsJK00409f6UNMY
	DhbyLbJLoB/8fEZne2a+HWOqvkcdQhEfFzKwLBus0lhT0+PPESsH8EYNUvVL3KCB3DwV5uko4xb
	g2GgZJTzOH6PuQEFLhP35eCmPtsPPOSD/OpLd7xHGM2c4ZpJShaCer1ROdRScqGqCn2aXdETk1u
	i0eyeftxMUFc3naNJz5gC4A=
X-Google-Smtp-Source: AGHT+IHaKHZFJBgXle5myqCQZBh9/gfGrQC8e9DgZC5hSDJOxCiWwMtjIRaQWPJXUGmQnpemasW2SA==
X-Received: by 2002:a5d:64eb:0:b0:385:e95b:bb46 with SMTP id ffacd0b85a97d-3864dee54bemr1459988f8f.22.1733916210342;
        Wed, 11 Dec 2024 03:23:30 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3878251dcdesm1041292f8f.104.2024.12.11.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:29 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] clk: en7523: Add clock for eMMC for EN7581
Date: Wed, 11 Dec 2024 12:22:38 +0100
Message-ID: <20241211112253.27905-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211112253.27905-1-ansuelsmth@gmail.com>
References: <20241211112253.27905-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clock for eMMC for EN7581. This is used to give info of the current
eMMC source clock and to switch it from 200MHz or 150MHz.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index e52c5460e927..a6f870f61a12 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -89,6 +89,7 @@ static const u32 npu_base[] = { 333000000, 400000000, 500000000 };
 static const u32 emi7581_base[] = { 540000000, 480000000, 400000000, 300000000 };
 static const u32 npu7581_base[] = { 800000000, 750000000, 720000000, 600000000 };
 static const u32 crypto_base[] = { 540000000, 480000000 };
+static const u32 emmc_base[] = { 200000000, 150000000 };
 
 static const struct en_clk_desc en7523_base_clks[] = {
 	{
@@ -279,6 +280,15 @@ static const struct en_clk_desc en7581_base_clks[] = {
 		.base_shift = 0,
 		.base_values = crypto_base,
 		.n_base_values = ARRAY_SIZE(crypto_base),
+	}, {
+		.id = EN7581_CLK_EMMC,
+		.name = "emmc",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 12,
+		.base_values = emmc_base,
+		.n_base_values = ARRAY_SIZE(emmc_base),
 	}
 };
 
-- 
2.45.2



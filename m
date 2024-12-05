Return-Path: <linux-kernel+bounces-433080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0AA9E53AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F03E1882B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916520C481;
	Thu,  5 Dec 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ckvzo2L+"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02F20A5ED
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397605; cv=none; b=fA7DK0yEPlUYqslqOakHYAqrXxko9yvKpJrIVlUdDQcV6CdWgfb/ECJbE9DlGruMqkNlaVgtJVi1Fu9W+wWiTmVDCXcxZV7l6GUHuBtdjuT9jGoAZ3BYOmtpCQ+NcK/YpghGRBUPTTOsMtRdkzsLrqoa9FSrevNNqLSJCK1mDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397605; c=relaxed/simple;
	bh=2lVjzE030DeEHPrugPun5apKDh5VjrrAaL+npHrn3mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jejWuWf8+et7QN2qlydolRuwKJ8lqf3uUD8NySoUbe4KNPF1N7YnoitBXq0WtLTHiHLtOXXULsWpMBXu2+vZfRGBA8C0X7FmI1TCc+XZs2xHTAtrSz427J08Jm11B+XFvxb5aBhj6KdTdU9fxdhntB7lxg0FMj+iz6rSC7p76nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Ckvzo2L+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa549d9dffdso109912066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397601; x=1734002401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sIT0jqKNMZhKzMLzfgvLUDfd+FJ1ix9dxzYWA8kfsM=;
        b=Ckvzo2L+prOnEqGfiYOhEPSNfJZAXT1zcjowD1C/bDrwIWGeMg5CJhPCCtQfRXf/mt
         EkK9GidXhXl0RH6EpvCUMloo5Yp1AINa4jM7F5RJNyqU7ttc5OW+Qc7RgzL04BlXHWot
         w17jtVEQu70J5M1jQFBv3+uV2TfBEOcUWWnwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397601; x=1734002401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sIT0jqKNMZhKzMLzfgvLUDfd+FJ1ix9dxzYWA8kfsM=;
        b=Mq95+7NLGIhLbL+LekaDkhtI0EeRQSwMfdgZSTLfgmG9K03y0wRXMvyNGGhrZbK4xj
         bZvFm4BNBqIkNsNic2+mXKD5qJNwI23hUEvGh9ouuoyWu8MtBOhnfYjjnIoo8JPBlY6Z
         TjZKe79xYLAaa1ItrUq9N9QJFEAOcqzBpkNdrEAWXN9LMXXoUCznbpPiY+A/NlfAKUgY
         Y4iQ6RKXRViZOodebIs3SGZuzzoLZ5tp5whNFXbqj/2k7BV7sj7pUmr2IXvM8f6OIJWS
         1Pasb5NNVx6AAQNOKYWmrYj4qVMaoFZ7POZH5beA1h7b0ZgbF5SOMZN7+N38XdYTVQ6V
         eWIQ==
X-Gm-Message-State: AOJu0YzfryO4Xr1uIOOahPhcLKlcErEKO6q4ygRXYc+PNMblCuErVs/g
	eCElaWKwjQT3/vlvPfBZwmsQNqlUSyWtlA1b7M4LN7YO3U3DjnSDSlwAYKp2zkwoyOeupffrT/r
	2
X-Gm-Gg: ASbGnculy+V/KzFjSs2qZL2XcLJwI1P0Cq32J9U8Zjt4uhBLV9Y60MdkhkMCyKJqLff
	xwFqWZrb8/nD+PefXj9Du/gNPHVpo641S2S/kiUtO04JY49XCkIq3+u0aDj74+ASYAStFs9b604
	WfEhPOomUW75AfOvOGjNkINI+lRAW3Vp8T7IwJXP+CrcCag7s/kSNa0TCzcZIMooaiIcFdaPxpi
	SVTRWOasB36kAOs7nUvO+jWyrVvSl4S9mp+J3cQj9XONLZluqaGeuQ21TTtOXVtxK7luiCEXk01
	+S2YaAfJxaBTLNBKnyKpYivgG6qk3uUD+sfSjD10o6MT8A==
X-Google-Smtp-Source: AGHT+IFWmfdNCt85Uk2ZsGUp6FJYDKMTwFmyiWTZIau8bHhRLJjRv3qW139XBm4OciWPi9ZRYi576Q==
X-Received: by 2002:a17:907:7847:b0:aa6:2a5c:fee2 with SMTP id a640c23a62f3a-aa62a5d4b52mr116294366b.31.1733397601340;
        Thu, 05 Dec 2024 03:20:01 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:20:00 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v5 13/20] clk: imx: add hw API imx8m_anatop_get_clk_hw
Date: Thu,  5 Dec 2024 12:17:48 +0100
Message-ID: <20241205111939.1796244-14-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get the hw of a clock registered by the anatop module. This function is
preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v5:
- Consider CONFIG_CLK_IMX8M{M,N,P,Q}_MODULE to fix compilation errors

Changes in v4:
- New

 drivers/clk/imx/clk.c | 28 ++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index df83bd939492..9a21f233e105 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -128,6 +128,34 @@ struct clk_hw *imx_get_clk_hw_by_name(struct device_node *np, const char *name)
 }
 EXPORT_SYMBOL_GPL(imx_get_clk_hw_by_name);
 
+#if defined(CONFIG_CLK_IMX8MM) || defined(CONFIG_CLK_IMX8MM_MODULE) || \
+	defined(CONFIG_CLK_IMX8MN) || defined(CONFIG_CLK_IMX8MN_MODULE) || \
+	defined(CONFIG_CLK_IMX8MP) || defined(CONFIG_CLK_IMX8MP_MODULE) || \
+	defined(CONFIG_CLK_IMX8MQ) || defined(CONFIG_CLK_IMX8MQ_MODULE)
+struct clk_hw *imx8m_anatop_get_clk_hw(int id)
+{
+#if defined(CONFIG_CLK_IMX8MQ) || defined(CONFIG_CLK_IMX8MQ_MODULE)
+	const char *compatible = "fsl,imx8mq-anatop";
+#else
+	const char *compatible = "fsl,imx8mm-anatop";
+#endif
+	struct device_node *np;
+	struct of_phandle_args args;
+	struct clk_hw *hw;
+
+	np = of_find_compatible_node(NULL, NULL, compatible);
+	args.np = np;
+	args.args_count = 1;
+	args.args[0] = id;
+	of_node_put(np);
+
+	hw = __clk_get_hw(of_clk_get_from_provider(&args));
+	pr_debug("%s: got clk: %s\n", __func__, clk_hw_get_name(hw));
+	return hw;
+}
+EXPORT_SYMBOL_GPL(imx8m_anatop_get_clk_hw);
+#endif
+
 /*
  * This fixups the register CCM_CSCMR1 write value.
  * The write/read/divider values of the aclk_podf field
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index aa5202f284f3..52055fda3058 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -487,4 +487,11 @@ struct clk_hw *imx_clk_gpr_mux(const char *name, const char *compatible,
 			       u32 reg, const char **parent_names,
 			       u8 num_parents, const u32 *mux_table, u32 mask);
 
+#if defined(CONFIG_CLK_IMX8MM) || defined(CONFIG_CLK_IMX8MM_MODULE) || \
+	defined(CONFIG_CLK_IMX8MN) || defined(CONFIG_CLK_IMX8MN_MODULE) || \
+	defined(CONFIG_CLK_IMX8MP) || defined(CONFIG_CLK_IMX8MP_MODULE) || \
+	defined(CONFIG_CLK_IMX8MQ) || defined(CONFIG_CLK_IMX8MQ_MODULE)
+struct clk_hw *imx8m_anatop_get_clk_hw(int id);
+#endif
+
 #endif
-- 
2.43.0



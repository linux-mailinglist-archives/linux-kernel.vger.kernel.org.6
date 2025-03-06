Return-Path: <linux-kernel+bounces-548797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81AAA54985
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3AD1881CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3896213253;
	Thu,  6 Mar 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pSVkit05"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6820E6ED
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260651; cv=none; b=Kd8dpxkwV7XCT8NcPH2ZPpZXO2/W6puYHlgJiP6S48ECBslrJ0rXSL6mUCp0Q1lP5AZSVgUp8KgPEaGyu04Xk/3Robs995Qv1TQ1vQLm83thyw5Dkjnx9mzKNtXncKdzBqwjnB1fO84mJma2X2rQ5psldyG9fcS71qb3pdbEAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260651; c=relaxed/simple;
	bh=2cbL/UoMZsHKenEkqVA3bsu+mxjHyTBuUjF0+bypM38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLi5ug6OBWzR+Lrs1SWoI55WTmFV46hAXLx44CGHdA1q0Q83KXUBX+TZAiOrpLR9+J9Bi9DdCwR5biTsPs9aTtUwfFyWT4Sf1+PTpa3zGaJyQpecR0y8/DbzPRARL/wkbfojGT5D2RWLyoPVwMqr4Ogs0YcQvWfYdyvgayitIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=pSVkit05; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bcad638efso3039385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260646; x=1741865446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDZuiTdlw8039p8GoLYv+uw7eDAfVUu6FSj2o7a4bY0=;
        b=pSVkit05K3ngkzJiJ/bWf1/Bu8yCXWIievGvW90zo9c6f4Rt/HsJwcsRsZg0dyWYAD
         Qq+gPNz66iQXOxW6/rhzDpW0Fd2OKLu2TAZCSS8ojNycRfccdGNKbf2CUSnY5Msg/L9M
         J+VWxyNpV1cDYdYsHuWje2grUQI+IsqXcBPqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260646; x=1741865446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDZuiTdlw8039p8GoLYv+uw7eDAfVUu6FSj2o7a4bY0=;
        b=oBrW7TNdoxQtGmtrPe7TDq2hn3JzuJ3DSRdkxtnt8gbRwDMywTwoRIq74R3V/5Q/Dr
         SdoFJKmHfIlLQ/gqS7I5oZt2Jut1XgG+bIZzE9BOFSsJ1Uo5vd+wnKVSIve6nouX41D/
         xPAAYWSwM/Gz0fJX4oqhISopXV7tq0c/OmLGJTHYlpT57TKY3+07Aswp4VzpIgKM7/rO
         Qss3lZ5Hjn8CUytH4mG2qPgRYCexXuz0CWGuN5dg5NvlceYxi+KG+9qE/hI5VxpGArUo
         QOkdGkSJKopPPw+G04rn6O/rBiry+Q5mis17UZxQAXVCsr2MCd1+MmujeiA9cK2E/6af
         fFdQ==
X-Gm-Message-State: AOJu0YxNTi+6wVjSCU+R6+IFjH+oAjgYaxwMDcsaWvoQCm2V7emtJNz9
	JS9oKk9b1iSMkxqIyqKvX1ZF/i9hdkqkruImqLCx8pfojh2sQkiJCyVYVRokemQGjvfTaw2hhIv
	5
X-Gm-Gg: ASbGncswvQ2kTemV7TEwxetkOq4R6iUsCbatBwDvPxDxjba7QS8VROPvCgEFK4ZLwry
	nepJxcZ4u2Hv1sw8zoblU2uBEtjQpUZoopDE2ugtaOdSBd6DpVr5Nl5sQ+ZxKNSvAdzH5Fv2SMW
	zVA0e/fxPdF7lx40fD1PWtghnbJZ2Pei+uEV1vgPhATRR4GMSOfKQbg9bm6xkm410xr8waEdZSu
	YyrHxxyT/u3qp+27yQ5VjaKpueJlxMegCFUNJvF8IafMO13wPQDYVMy0IGdzegxm9RvrC3fC/lk
	I+fJK0OYtykFHUjYQVm3fttuukD9OJOlw1hcNnAakTXJYr/bhLmpMYrRhSZN2NwC7FXDhLUvvPN
	7NsTfSA==
X-Google-Smtp-Source: AGHT+IH78TpklUwBDK3WnRiDd3pPrpHVptMGkVV2plYHJnbyxlkTLYCF4Q+vemKiKROYa/bzJLhC9A==
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr66278975e9.16.1741260646580;
        Thu, 06 Mar 2025 03:30:46 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v10 10/18] clk: imx: add hw API imx_anatop_get_clk_hw
Date: Thu,  6 Mar 2025 12:27:59 +0100
Message-ID: <20250306112959.242131-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

(no changes since v9)

Changes in v9:
- Add 'Reviewed-by' tag of Peng Fan

Changes in v7:
- Add device_node type parameter to imx8m_anatop_get_clk_hw()
- Rename imx8m_anatop_get_clk_hw() to imx_anatop_get_clk_hw()
- Drop the gaurding macros so the code can be used also by i.MX9

Changes in v5:
- Consider CONFIG_CLK_IMX8M{M,N,P,Q}_MODULE to fix compilation errors

Changes in v4:
- New

 drivers/clk/imx/clk.c | 15 +++++++++++++++
 drivers/clk/imx/clk.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index df83bd939492..a906d3cd960b 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -128,6 +128,21 @@ struct clk_hw *imx_get_clk_hw_by_name(struct device_node *np, const char *name)
 }
 EXPORT_SYMBOL_GPL(imx_get_clk_hw_by_name);
 
+struct clk_hw *imx_anatop_get_clk_hw(struct device_node *np, int id)
+{
+	struct of_phandle_args args;
+	struct clk_hw *hw;
+
+	args.np = np;
+	args.args_count = 1;
+	args.args[0] = id;
+
+	hw = __clk_get_hw(of_clk_get_from_provider(&args));
+	pr_debug("%s: got clk: %s\n", __func__, clk_hw_get_name(hw));
+	return hw;
+}
+EXPORT_SYMBOL_GPL(imx_anatop_get_clk_hw);
+
 /*
  * This fixups the register CCM_CSCMR1 write value.
  * The write/read/divider values of the aclk_podf field
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index aa5202f284f3..50e407cf48d9 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -487,4 +487,6 @@ struct clk_hw *imx_clk_gpr_mux(const char *name, const char *compatible,
 			       u32 reg, const char **parent_names,
 			       u8 num_parents, const u32 *mux_table, u32 mask);
 
+struct clk_hw *imx_anatop_get_clk_hw(struct device_node *np, int id);
+
 #endif
-- 
2.43.0



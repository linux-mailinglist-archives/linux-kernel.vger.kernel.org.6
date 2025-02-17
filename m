Return-Path: <linux-kernel+bounces-518121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F180A38A37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875477A4303
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890622688D;
	Mon, 17 Feb 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOxBd9SJ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FB227581;
	Mon, 17 Feb 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811651; cv=none; b=F4mVx4hs5VmKZJkTRzdMfYO9+/LfEnqVrwI/8r8GSSf2USx0msmn8wth4v4pkL60pCNoqv9xo+FCPcfQSBB2+Z0TWXSCcwXDybw6HYmx052uFs3I3RXqoUG0ngqOqZPcy3fIYEUJU6NR1kfcVD4hSMlpVPgWDuhtDEGTJYX8G8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811651; c=relaxed/simple;
	bh=e6CR67bIRx0I1NIUZ+DzirUjK8FX47WTt4E/ldbm6GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADbRI1Ar2O9I4D9t5Y+QjVngq9gNqaq1AvfjSr2Rkmqx/Ev1p/WR4pfG4wkxw77o02/9HlvnUNpUrm1D0GweS7jm/XF0CpGOPQ/RvHYqkcFV4mKClBBv2Iq9QyNkdWoNV9Fwt4cIY85l7EvMfKOl9bUrdPHRYQDIR2KWamztsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOxBd9SJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so4018562a12.0;
        Mon, 17 Feb 2025 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811648; x=1740416448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SCJ0pUE2LwQE2TDd0hXt9uN83Fn/ucHR2/2/GAmZHY=;
        b=fOxBd9SJdx5ky08wiJ1rR8XFHTZ9f5lkjP4G8gAkcBvsKdW6k9wBbqBgGgg7dCjb3E
         xCiqq9NMit/Gt72Y7g9JQGgYUM6LgPp5gikCgSczrSAZ+Z5VLUFvSVZFRQYZtLmSah34
         oTPIh1+wQ32KD6pym52ZAk54+x9nsToPcBfsxFISqMVOL6ihxKk7wkn3pxaYdOa5pms1
         26K5ji9YQWJFbn0jaG3uvt0h8/gobjwDWckKh1rXDmkd4/n2j6XqsQRV0VnHI3wPURW7
         UN8Px+Cd/UXDZ8nP5lu0OjBr+d0+lEMdWO7e6pXD9Zx9LAHZ1JUPKZwzE8G6X8RKAzCr
         6ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811648; x=1740416448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SCJ0pUE2LwQE2TDd0hXt9uN83Fn/ucHR2/2/GAmZHY=;
        b=aZVp9UB1+wZ2vY53iMjMcUGjk/BCSbZJvZNu+kUNgQapHejCcK86ZwKd4b+tTKpG74
         N5KmWEKoAtFeA+OXqKydkUvjpOhNkjS5uhmkJsbC4F2P2k7C6lSIOshJDY8B2tJRuadj
         KKipJi5HQ1vWME5Crw1lCpccTzQ1q5d1wPW/fy+HMn9WZa2mBhvD+G3LERqKJYS5SXHk
         hJuPUl5y272xLHJD9/f18LxUPAghgXf63d3YKana5eBE7bCKBTz2poAsRmclRQZ3I1aT
         eVcFX6DHxK1CqX65GiNec/isKiu1WxPDnK8ph0wIw+5EloKRS/WQMnTP1IbJARnFQ7ER
         bs9A==
X-Forwarded-Encrypted: i=1; AJvYcCVGNfXZpEVSlQ26VjQ07JIUUmlihjk3Y1dxLkF/t+HW+tCrkSNth4zq74dle93BhnpRmw2qpCq9tcfL@vger.kernel.org, AJvYcCVIDXmsnToTox14zXmP5LMev1fHjHwsRpBo1wLHT/l06OjZQqyuwhmazr3RfoLkMerMaoHbw5TRjfPzJN9R@vger.kernel.org, AJvYcCXVxLpWKu//lDldlEBE5xLtRbl1t9g3ZTuM6EYHUvptrp3Ald08UGXH++x4xN09Ju1hcCrEV2Wz6Hoy@vger.kernel.org
X-Gm-Message-State: AOJu0YxVx1vGzE7rKDHIsl4vlcnMeUib9Dn6V4pPQIz6r9AxGk+0E9Eq
	ivxxBVsG/nsSKCYaZ/7pyh+wylt54gz/jKqg866trusQXZA1NZ0sgCezD7SC
X-Gm-Gg: ASbGncuYTxhRJG20waQxdRYpMK7xzv1Stzi3kpxVkbA4GkkuyKELJl/6qBWo0Lulnc1
	VXFao2mEPddJhInGZAAkQL0p95On6WqXoxpAw/kmRKPQ859B6Bu6BeD1Gr5oXqUC1f5HX1uQPLp
	cPvIGs2OeMEplsvqbKihHKuGNJm9Z++dLayhzOkSY03ljNqp2CdUf3HmzbCCwTHldVbGOEmsOqh
	MS29dbVacrItsmsE6fhrPcysJDUxQdRdXPt6Zp3VXntalC1gn5L4cBBx2gHF7fZI4gFdSwdhkSv
	O5a1uC2IekNPnp6QC4liSt/gLLPBHL7Spld/0zGXaey1r//GpbufQg==
X-Google-Smtp-Source: AGHT+IE8uiVGrKUzV55CQFqCJ8GrM70TxsS8ElrSoepZMqDoUHx4Rfw20qczDxgzE3AFyPp76GMMbQ==
X-Received: by 2002:a17:907:9802:b0:ab7:bcc0:9067 with SMTP id a640c23a62f3a-abb70dd72f8mr1224609566b.40.1739811647800;
        Mon, 17 Feb 2025 09:00:47 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376aa2sm920570766b.103.2025.02.17.09.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:00:47 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
Date: Mon, 17 Feb 2025 11:57:16 -0500
Message-Id: <20250217165718.74619-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
References: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The DSP and OCRAM_A modules from AUDIOMIX are clocked by
AUDIO_AXI_CLK_ROOT, not AUDIO_AHB_CLK_ROOT. Update the clock data
accordingly.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index c409fc7e0618..775f62dddb11 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -180,14 +180,14 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_GATE("asrc", ASRC_IPG),
 	CLK_GATE("pdm", PDM_IPG),
 	CLK_GATE("earc", EARC_IPG),
-	CLK_GATE("ocrama", OCRAMA_IPG),
+	CLK_GATE_PARENT("ocrama", OCRAMA_IPG, "axi"),
 	CLK_GATE("aud2htx", AUD2HTX_IPG),
 	CLK_GATE_PARENT("earc_phy", EARC_PHY, "sai_pll_out_div2"),
 	CLK_GATE("sdma2", SDMA2_ROOT),
 	CLK_GATE("sdma3", SDMA3_ROOT),
 	CLK_GATE("spba2", SPBA2_ROOT),
-	CLK_GATE("dsp", DSP_ROOT),
-	CLK_GATE("dspdbg", DSPDBG_ROOT),
+	CLK_GATE_PARENT("dsp", DSP_ROOT, "axi"),
+	CLK_GATE_PARENT("dspdbg", DSPDBG_ROOT, "axi"),
 	CLK_GATE("edma", EDMA_ROOT),
 	CLK_GATE_PARENT("audpll", AUDPLL_ROOT, "osc_24m"),
 	CLK_GATE("mu2", MU2_ROOT),
-- 
2.34.1



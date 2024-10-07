Return-Path: <linux-kernel+bounces-353033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503299277E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7196EB24192
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C0718C016;
	Mon,  7 Oct 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1wd6Jma"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE062628C;
	Mon,  7 Oct 2024 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290925; cv=none; b=ZawBnQA/dNATqEkvDWQbdaz5qkKgviHR1/BmEa13BYZ9jnlGBC7w9U98OHWtg00lCi+kSLxZLGdrjlCdjcTp462ZaX3hkbu1YGSmGkhZs2jfDxA8Qee/oSx+23q19c++y9R2vLhpuQ+xuEX9wlNld0xyeTveWHvZneUBTcWYkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290925; c=relaxed/simple;
	bh=WopIqxNCDiLoff/Ze+eAjvtYLdMjmy90+UIfvteCqpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4QDEIntynU/FCAwAJEuy8lEeke+/434/9DMx9vGzfNEi/a67N7la59IvwWjfIo62LCzYlCVWG+2yT31GrtaOykxUQJlHo+3rRmAZiImMx/RKCyH7KSrkUMxkWn91oSahJ6dJ1Jv0CjzK5KijGt+kVmtkZfsJ92FCjsmUueXcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1wd6Jma; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99422929c5so193012366b.0;
        Mon, 07 Oct 2024 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290922; x=1728895722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhKs2FfCM3Z7w1CzENDRQ+tMB67rwQA/Uj+rq9gCPhw=;
        b=H1wd6Jma6JydXOgeRzn1G9/cchKNO5ZjaV6ntLgZfsPdcdQfG/oYqQpaHY21AWbXHZ
         dEs28Szc9EeP/RgAzVgzzFNbM9yLl2DNajc0+gj2pdmNTUmF937GENoMCC8IzvRnRNU3
         JbPom2CyVTGyZZefiVXuNV7UmcbHpJ8lN3IAl9qgjXaSfVNgMk/kgxQjJg52QOadWPFF
         eBY+UoerQ65WayccHvS6yqeaJycE8CDs4Zx8pKeMgVhIUbPdhESgByldckjPwyOve1J6
         rs41UCUfmP4zGj8GOWBtNF+qSirjoGqPLDjZYXOJ2s8x5YEynPDpHpSSWPqIU+gsVvIk
         rWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290922; x=1728895722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhKs2FfCM3Z7w1CzENDRQ+tMB67rwQA/Uj+rq9gCPhw=;
        b=Qno02vvJQW/pZ139UERI+dfAIffnxrdlvk4LRC+0LG48PzbQhMHgQgIt8kkx3xMTiT
         yGBSB3bMMqpRTtsDlYzie7waWZ+MFSMWGiZjkD1sObKlKLhukKHKz2eIo109Y9l8R/JQ
         gJ63p3TH/9/9mia99NJo7rZoeuRJRCySMyy0YZ4shQr/TMbzAKEhMLofU4yn5K6VcjxX
         kLHJpmj5uqkf8s8OUPUl/yTa7p5P/UQhvCT3i7n4nQ/oJ5tBBhkH5PJ0k7m+GIbUbzrR
         KL+ZBYlJpsAXFppg6+o76VCl8LLdNtHCIh4G+mx6w/S4lNskMULZ+Zp24QYA1VGfo6or
         DqKw==
X-Forwarded-Encrypted: i=1; AJvYcCW4zG6f74scl7caPLFJsJ30b1WnoUw3hebaXL8rb1v0DXrEjH3NL7/dExOg/2Lh5V5sFncWUx8zkmE=@vger.kernel.org, AJvYcCX+fSyrAA/SrH1TWvPDfvNLV2VlMLcnyqH6z2mjxsKa4DnrVHZsnahxLTZXt7p3dSUgGFmYXO1UWKzlO+/9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsz4sOuRHXfXK5Rk6OSKPhUY2mOIkj+zg6Etp+12WoZEGk9GQs
	645LZ/0jFAqNxmzNJaCBeoE5sN/g+sox+R82UpUbVRrORGVnlo+Z
X-Google-Smtp-Source: AGHT+IHKchNuoOAZZvcCsHWGswmIrcJQuFy0gw3grDmvDHvzW723I7g1EoMwqLb5dtqxi5M6N5tpYA==
X-Received: by 2002:a17:907:8b93:b0:a99:5bb3:1237 with SMTP id a640c23a62f3a-a995bb315a1mr139414866b.52.1728290921889;
        Mon, 07 Oct 2024 01:48:41 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9937615e85sm327739166b.175.2024.10.07.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:48:41 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] clk: imx: pll14xx: Fix potential integer overflow on multiplication
Date: Mon,  7 Oct 2024 09:48:40 +0100
Message-Id: <20241007084840.1167527-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calculation of fout is using int multiplication and assigning
the result to a u64, this can potentially overflow if the int variable
mdiv is too large. Fix this by making the 65536 a u64 value to ensure a
u64 multiplication is being performed to avoid the overflow.

Fixes: 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/imx/clk-pll14xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index d63564dbb12c..2afe361fc711 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -107,7 +107,7 @@ static long pll14xx_calc_rate(struct clk_pll14xx *pll, int mdiv, int pdiv,
 	u64 fout = prate;
 
 	/* fout = (m * 65536 + k) * Fin / (p * 65536) / (1 << sdiv) */
-	fout *= (mdiv * 65536 + kdiv);
+	fout *= (mdiv * 65536ULL + kdiv);
 	pdiv *= 65536;
 
 	do_div(fout, pdiv << sdiv);
-- 
2.46.2



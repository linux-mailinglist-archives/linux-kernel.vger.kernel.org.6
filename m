Return-Path: <linux-kernel+bounces-301763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F195F53E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0742228202F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51E3C17;
	Mon, 26 Aug 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R2z2VeFX"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9F189514
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686582; cv=none; b=ucbc+nbX9gziXoByV5gftMTZcQFNUWHsLSUFtAOu8E0KJZP5WgHPIMlKtzC560zl1hSgcDQ1EVfxgrF9Prpn5BCf0P1FF8+fDAMhGd9AYrBO2dGpJeV8RdH6f1Jm4lRkwsoEf1NJN+JbHCJiKrysJpmQ+fGuAU2Z+Szilstj/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686582; c=relaxed/simple;
	bh=H/wPKvUXk3R2KA9yNeUxfOeqIe9r87SxPUQbHN9UFq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=btTq4HxzXkDkbOITJj4oVZb2t5Uay/L2Tpbk2jjqgqAyk4PzPSdEJqi+WQDz2itO01Qx6BTsqTDfOs3fyteFZ/WZgYa1KGGpufGWlfauhunjxPixU8DXLrkb5jcgM4dXGbwvGMobUdp0pUFUyvSlx7I/VIVGyHqrYL0HRaz9DpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R2z2VeFX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2704b6a6fe6so3278424fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724686578; x=1725291378; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8paq11lau0AGq3N4ibielyErO1Qy9yYsKM6UQc5T7m0=;
        b=R2z2VeFXHpH1ukQ1HaPFyQS5uG7kGP8VFNfd8nA2BH9ze5lsoYaQCet8//OUeJa2aL
         6tciTOxK+48Rpgu5HVsAMkldfYwx4BU5h8EWFkb+XHLHj5AtEcRI5CWlIzQR7NwisH5c
         AYsoshMw3vz7AvP4yL2BirKVDuBwYwB1yTNHywX3Af9p59PfdyEKAQm+IuuxHMgUQde/
         88IXsk+z8dpQ/vbDsk38pRzUhrn0Gqtcy+/agGmmmDGMiz1rgjHNFSlSWI+qOPlCrWNa
         XtT2LMva26mPZYNDDrMO4zBd+/vGumR3ivLWn+u0tJhrR+gw4JGFxa8o8q/4wnXn/e7y
         Miyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686578; x=1725291378;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8paq11lau0AGq3N4ibielyErO1Qy9yYsKM6UQc5T7m0=;
        b=IBQQCco6pDfxT5PPag7EDTAr0gMraEqkQmJJiLCEnDJRjuIPc1JnLNyA2J6Ys1v6iZ
         YaamulAJRbmzqw9MmNjcPlDrCSbDM+y15pGm8bEjJXAeP6eb9E2WUNQc9k92O9qPulEA
         uu8Rz1csLiViQMWSqQbci9C9UGabgu1PsIKuaUWsupX/TmUcRpzFLfqCcH1OKxpUjz/E
         5ZtHQtafgfrnTjJ1AvfA6AmdPVF9t96IKy+99Oe43FwUgBTBO/dCgbt+y9CfRR44uOTL
         avZmMJ9vwLPfHpxH8GVtGztuoSr2Q57yTRTjzbO+pc2pw3ZuQ26Yp+v0tWTk+5CDYoz5
         7NNw==
X-Forwarded-Encrypted: i=1; AJvYcCW4AOnsiHg0FCqagDy0c+6fDzGih/6EYAAZp/dACohRJwKqbHzSm/1yqj4v6rpuWfa+aUku99p3YPD+vi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Yx0tnlFIvGadxrufNhwpH56QAOkavGBvT1NJTDoWUz+GC/S2
	sYDqevFNltfS9+UlP/9wpeMWYCkLbzzt9eZMT5EILe9oyAk5hgjutiweNrurFFa5exg4A44HMbG
	V
X-Google-Smtp-Source: AGHT+IELakByaVIpYO50hKRKe3IJ2sU7ak5lAEs6hF++oVE7ipTq0I7RvmMG1/ES4KMrEw4rGLjx1A==
X-Received: by 2002:a05:6871:547:b0:261:908:5899 with SMTP id 586e51a60fabf-27759d110a1mr36958fac.10.1724686578558;
        Mon, 26 Aug 2024 08:36:18 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-273ce9969besm2514690fac.7.2024.08.26.08.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:36:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 26 Aug 2024 10:35:29 -0500
Subject: [PATCH] clk: ti: dra7-atl: fix leak of of_nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-clk-fix-leak-v1-1-f55418a13aa6@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMCgzGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyMz3eScbN20zArdnNTEbN0kUxPzZAtzYyPDRCMloJaColSgHNi46Nj
 aWgBllqWIXgAAAA==
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

This fix leaking the of_node references in of_dra7_atl_clk_probe().

The docs for of_parse_phandle_with_args() say that the caller must call
of_node_put() on the returned node. This adds the missing of_node_put()
to fix the leak.

Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/ti/clk-dra7-atl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index d964e3affd42..0eab7f3e2eab 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -240,6 +240,7 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 		}
 
 		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to get atl clock %d from provider\n",
 			       __func__, i);

---
base-commit: 1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8
change-id: 20240826-clk-fix-leak-b547c87321a2

Best regards,
-- 
David Lechner <dlechner@baylibre.com>



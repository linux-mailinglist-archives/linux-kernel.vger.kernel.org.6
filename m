Return-Path: <linux-kernel+bounces-573783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB35A6DC53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138353AD4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9725F7B0;
	Mon, 24 Mar 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="M6drabyy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370ED25F7A1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824640; cv=none; b=rCDt1WlY00ghf41ILU3+CQEui1k/dGpy7VdRnDcgOO0wORA0R5yatFT5PnnsuAJ/5Co2xbmpWachT9juNl/T74GWxU+HcSSoOk2aueLiVXDLgxmx8vSF4TAcM+8RDKlOwpGknQcAdzAPHpoCZiBaZZ7LbL0zXC49gu0Y6pnDMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824640; c=relaxed/simple;
	bh=MoEp5ZcQhE/r7CJZd5xBLtT4vzDpLgktl1nQu8ou+Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfCW25rFsgf1qZLkriLN+CXdx+08ooslRxfqcVsEbElq9ZOK63rh5FjnFBp0A/PXvijd2xt2JLFgQr3cONps5SGTT0fiCfkll24vAQsfhCaVPcFXAse+5UdFvivSgy/Ucbpma/uigjYY4oWUCljZvdtggoBuXvVZzZzse0ZimX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=M6drabyy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe574976so24953895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742824636; x=1743429436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZXYQlywBGjxUCQ5Y1L04Uo3ant2KBX+A6aBOQRIOrE=;
        b=M6drabyyi/z01OwSHdmg7VKp4cLSJuykKmkO1o2xwiMWEeMwSRQHzdq9GBW2pLnkeb
         0wDrhkAL7RRJ2Yecwz7LjUirkPLcv/4u22jgwreT5giFHDAjmymUn2H+crVBpzYTT9Rd
         evOUDLeyPvg3VDXucjtXN+IW7j1Jw46wFckgE/2Bt2GD+t/LXXo6NOHT6WRRyprwEYDJ
         UgkmqMKYz0/sgDFCM4k24jjJfvbK8/4mo3wICsVHe7efVAEGH/JxzD9wPw8chmOHIw60
         13rXfkaPfmrNCCSXEAwg154H3Oj770VFbDDnRkJFpBIpQsYfngVjr3NIf1i/yjbAlnmF
         20gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824636; x=1743429436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZXYQlywBGjxUCQ5Y1L04Uo3ant2KBX+A6aBOQRIOrE=;
        b=YHzpua2mngQ7fjT5Nnop0HoBM8939eSwlvqCxcL+f84GWEIZ4cjik6wV6ft0tySzCd
         yOHReQDMbP3w9QbRHAUBvuCPc+fydiKlx4y7rng0kIgjTtqEHjVWzN7yKL8UdS4Etk0k
         Xsr3tWDGC7hr9SC1bJ+nhx9v9Y2QITfb3EywgKT66nfJ9DbPG8ScVBVcEU7SAZlgWijf
         RMYHSTFpSqVKkgjErAOiS86pkbwrqXyBf51WHaYMEXiyrmLNtI14pzTD5Wa0R1BDQQwR
         KlMD+ZiULSPoo9ZNM4UgKSc+4IwfSQVOq/QUeHx0dpL7APdJp1tYjeQaGbnYQ7uNNSOU
         z2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBuMqRE+QLP34NGAvAakcTMPnVdBTzjrONwAGzq0QYe/mAUtuMUjDnJmkSLHFCvP1Hsy+uWdFoHjBjc4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0iueutJ53wJCsTZiW9jhMnVKi80zqnwF+GsWdxN14o1rVDIir
	I/8NIiIT3kxppimOwxUpfB/fSffkusjxfEE8yQfbjCsEEEgGYteCY8KWaLCFvVQ=
X-Gm-Gg: ASbGnctW1bzmTHLv+DcSCdO7kDoCB2BtLcFm5Oz4JXcQMM1zRf5YIZRFU0wz83rsX7x
	6v+RzQ1XVsLpEJzeDtb3l1DrFG+nbhZhJiGn7wfATSnYm5/4kTqvZ1CnB+h5cGmZd5bkGJRLGkH
	ObuMuVpirCeeP9214J+B1cUO6UJtI63uI/gIb80gnF8JabjUjv0gPuwG3XuDXzUez/+WXlwclXd
	v5kfHwY6H5iM+UB39/HSGov/XBF5uCG0rPMQHTQT3srzHSNW62bnznt7ZF5Kp6V8hehnUY64OjM
	HCEWkxBzu9bPPE9V3IEJR7DH4JrKQ+f8C1xLKY2yPj/oWKu4Y7UjPhxa3HzvzoLtG+B7Vroxgw=
	=
X-Google-Smtp-Source: AGHT+IHDKpLBvO3q5uFPvr/70DmnnwzOfgKjpHIucZu6pM8ksgy7yC5qAGJIQYpLCs15vezBXQWNUw==
X-Received: by 2002:a05:6000:210b:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3997f9336fdmr7677171f8f.42.1742824636553;
        Mon, 24 Mar 2025 06:57:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbcfaasm120146525e9.35.2025.03.24.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:57:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 4/4] arm64: defconfig: Enable RZ/G3S thermal
Date: Mon, 24 Mar 2025 15:57:01 +0200
Message-ID: <20250324135701.179827-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324135701.179827-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250324135701.179827-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- collected tags

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a2..79e566f0d47f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -715,6 +715,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.43.0



Return-Path: <linux-kernel+bounces-427636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF299E0411
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B612B44A25
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540C3205AB6;
	Mon,  2 Dec 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="X5Cjly/K"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC061204F7A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147377; cv=none; b=cDLDahqB04QFWS3MznKaf6JolY6aRYCvyn7XFPa1m/UXRgkoS+PH6QP6y3AiH8NTzQJIkKDgxMI+kDKOpj+HAg1ZNK8Xf8alI1n2VUg8qsBFgZLPvDY4Iludx+JqJ9zP3E27XF3rbW4M67DtTr3Pafan46qVlM8GM7/Fr7gBRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147377; c=relaxed/simple;
	bh=gi4r/9fiAEQcJ1/VpsFKftfVoGeRUSEvG5SkeQqi7t8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjOqqrThX/7TGTZYhrvKTnlwiHHOaP32CPklTpetg3tDbhC4TKGxCrgEqAd0OdDzY8UGmfmTzYjF1Qe6BbohmVkXFtmxpaDGT479Q8tgajSxTgZ9K2IMholsES90Qu8XPWk7oR0eOwtuWKCQcrSlSU7IFxez41kXdo/LvCif82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=X5Cjly/K; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so62643791fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147374; x=1733752174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwe209DAaje+GcWep9b6H0DEbfZW0MKQs07MfOwMWx4=;
        b=X5Cjly/KKUHZFYcDu1VQKm21CzLtryFHPMONpoaSCvLJL9wXEvLnlzYJV2IXy8qu5o
         LdBW5v6M5A+gFG9cXDnnN3BsYSA2gwMTB0slzdOhaEI6O1gp+EAut5bCKTspmQ9/uU2+
         X45mj0IDppXB+EHNj5sXaVTgiLHYaV+o2ol1lvp5Go+wllXUXJ/sGzlCpM/qLzuYDWO0
         +RY7gNcr2O2qv6t3UvqCjimuYBvPZU5fVwe3ucdgVnrTAhUNQubnOQkeo1Gk0T3/NOQc
         e9S9MUrba3uuwDUFPVPgqbQV7c1b58SDrupqXSk3uPoUWa7SJiDnEMuldd1KxqRf3WGt
         lyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147374; x=1733752174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwe209DAaje+GcWep9b6H0DEbfZW0MKQs07MfOwMWx4=;
        b=Tz9ukh9cjZIJk7bft7P+8F1saLHj9Eq3rpy3Z95WE2UmAgMrjtfIJhpv6y0wRdsTdM
         AZmU8bLQKzxnbW6dz0lQM2+COXEqYbWf7OxnVhuNVAaaGOb2XLgonxS3hrYcn11qM7oz
         A9NZ1W8OSsXNRPhlpxWMCLyIe7+slopF7B9UCFs17Miv/3c8LOoUX9C5v2DaTDvyZ5wU
         m7XIHUsH6DOujeqcmDSVpqCR3oalo/Nd4bGBS6ppQNyu7kATnQlczaPuFnYLCdMOmQKQ
         XStN8kaEo0vg7J4mY7FNrDi6iw5qxu0yLLfz69srzSnQf3QAS7JqMDiM8//z/gprsvLv
         1wqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk4d4XVkhzboBeg5Yq0ytojcbcq1ZafapDuIi3uoQoSKkJosnQFPuHob2OorM/ZKyLMd6l0jvA81oAHqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsLCO8hcWyDht3GR6QRApImgK1B+T6bHwjz0sLgq71Ddt40a+
	rNL07qSHa94G8M5tWJYkgx3X2THgIew8+0wGKbWK1efXSH4itEcLGOlRKBxVXWk=
X-Gm-Gg: ASbGnctkUk/L7rwaOHpP2qjxgmB62HZwpgu0YzOK5uFS9eC9hsft1mOWUJ4OFnSox3e
	gX+uNqdXrkaArfGKqLu2vx6rf3u0FjzaPE4cZB3B5Pm4SDV8sSR/jdhAvFjaiZpfZvr3juhgput
	9Rb2uaB0BoqMODyWM3fPeKaHP7ZQxL1HelA0+oOHiVaS0hNAl8aW0ym702/KiWjy51hhDOX50ef
	DJQiOp2edDA/Ri3rdLioWHiKTWgKIDEmg22nDrD1V387VjuC7sBaLsi4Yl2inZP
X-Google-Smtp-Source: AGHT+IGPDUqvNQWOZK2p/wfCfolkShxEPG/W6xNxeCm8LRmsFRVGzSdVT9pHra7gpWP6h2+ulPowbQ==
X-Received: by 2002:a2e:a583:0:b0:2f7:5a41:b0b with SMTP id 38308e7fff4ca-2ffd60a96f8mr185401491fa.26.1733147373869;
        Mon, 02 Dec 2024 05:49:33 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:33 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 5/5] net: renesas: rswitch: remove speed from gwca structure
Date: Mon,  2 Dec 2024 18:49:04 +0500
Message-Id: <20241202134904.3882317-6-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field is set but never used.

GWCA is rswitch CPU interface module which connects rswitch to the
host over AXI bus. Speed of the switch ports is not anyhow related to
GWCA operation.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 3 ---
 drivers/net/ethernet/renesas/rswitch.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 5980084d9211..bef344e0b1fd 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1902,9 +1902,6 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 	if (err < 0)
 		goto out_get_params;
 
-	if (rdev->priv->gwca.speed < rdev->etha->speed)
-		rdev->priv->gwca.speed = rdev->etha->speed;
-
 	err = rswitch_rxdmac_alloc(ndev);
 	if (err < 0)
 		goto out_rxdmac;
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 72e3ff596d31..303883369b94 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -993,7 +993,6 @@ struct rswitch_gwca {
 	DECLARE_BITMAP(used, RSWITCH_MAX_NUM_QUEUES);
 	u32 tx_irq_bits[RSWITCH_NUM_IRQ_REGS];
 	u32 rx_irq_bits[RSWITCH_NUM_IRQ_REGS];
-	int speed;
 };
 
 #define NUM_QUEUES_PER_NDEV	2
-- 
2.39.5



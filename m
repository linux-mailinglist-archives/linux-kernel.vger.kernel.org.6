Return-Path: <linux-kernel+bounces-373326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600DE9A554D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AE61F220D8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6BB194A44;
	Sun, 20 Oct 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL3ajn2o"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22710BA33
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729443068; cv=none; b=skUyvUx71GFrJfDzbsZIc1XhvP0TIWv9VNUuISauS1+A9uqRtnH7kJqsgK5oxO/ZRRuEvvulq/5nF+KnN8NHRC5LBd//jYNxwoQViqjObbpcYZPuEpYiF5Qw501v/yJun/BSKX1HqHjqGV6Ibf3FfLNFQP/07sp1q9wI0Zl3Xqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729443068; c=relaxed/simple;
	bh=ZFGDqSXGb6xaVVKBuMNBM1c3gQkpiF8/Hal552ez5Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebDKosidmiZXtmy+EJb0ma/fKbFkSaghNWM1x1kZhW/2LL++Ah2YdXWoPo6IudkeqNnIVuzy/h9a3hZnp+oN7fId0+6DEF4QZs5pIwosiAqPEdfyN7dzr9E3FKraUjzcmBFEpMLr8qSAZGnxucY3/Kw6fHH/jXcV81qnoQg6PiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL3ajn2o; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83ac05206f6so70241639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729443066; x=1730047866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83791tpaLyYi3ZWkO6Z9ZFEE4sUYJWOvQU7P98DEjZo=;
        b=jL3ajn2oTEz8JT7eqvoGnypi8nAdEj5mTa+1150ruwnElwKrFxPEB9QYq6bD5eZLCY
         9HgpNuucRqKbVNho34GVIvdTsGWZWadbnCLIAZ4NL+YmA2YIG7TKC0ku83U9f/peq6JH
         mpEcuwVXEIzfijDLUD2vUGwpcXqq/8PJgGCzbHOjNj0Pn9Zy5LTBv4FlSBMr/DxrcaiK
         oK4gHpvdA7CHoLIFapZWmKEqVOhROYIRvEf9zSb3Eg+vgLpT8yv/KJZmPkgjUKby8YSk
         t8I18scy2frwvTwEXXgh3qq2nJtO42JYhY6hdX/enI6rGWEKAGR53rRoiSuSnDtCCK8X
         +TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729443066; x=1730047866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83791tpaLyYi3ZWkO6Z9ZFEE4sUYJWOvQU7P98DEjZo=;
        b=pwwhmlWrdqdtHImQu81rqsPmP5mlNRHQ2IEtjqsMuS1YvFWmll1HXMq8UWi3bnnxmA
         r/FgXam7GYhXdezlr+TwmkF3LIGKGExjI/VYAjZwoxKBWmmMSf9GGEP4oJ3GPc8w3dHH
         NaEviDbgKyyPGjov9kMb40FA0zGcUSBRWISsMDhd23B57yu13mDbWHAHWIpqojqTDCmC
         WrdGC3iA4jksacnwgTuffzTqnaviEZ4ZDEUHYci7mRkSG8IF3N0K5TkBZcYjC5HgfrH3
         WOz849FX4o6CaZ5scv6ByyVo0q4Jy3Gh3yYLAjyu/XtProgMLvB+6W1nME4xoy7esh88
         fTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUERhuQPOM4+l3Xm0H5sMf5pYEz9gpz9DGLynfBkZNGj4ufPW7GIstZKA/yOgkrSC+TzdwhAQuHt99JiCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK9LGarDGMA2BXFEZhKvACUbyNZDpuubD6SxqZ9VrFyhWC2SmK
	qQZhpJby2APpJ54/WBbgTGeGS1Fx+XnByc45N7DmBJKdIbIZjGAg
X-Google-Smtp-Source: AGHT+IGZSuHCfLPLCFrOJy8WIidvXYITJodQVFuPRmWCdbvG7lYSa4Vi6MUftNfbdwhE6XcysTCphQ==
X-Received: by 2002:a05:6e02:154c:b0:3a3:972a:3991 with SMTP id e9e14a558f8ab-3a3f40a859dmr79426105ab.16.1729443065996;
        Sun, 20 Oct 2024 09:51:05 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net. [75.72.162.184])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a52fab3sm533821173.35.2024.10.20.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 09:51:05 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] phy: freescale: fsl-samsung-hdmi: Expand Integer divider range
Date: Sun, 20 Oct 2024 11:50:45 -0500
Message-ID: <20241020165102.340838-1-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Integer divder uses values of P,M, and S to determine the PLL
rate.  Currently, the range of M was set based on a series of
table entries where the range was limited.  Since the ref manual
shows it is 8-bit wide, expand the range to be up to 255.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 2c8038864357..3f9578f3f0ac 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -406,16 +406,15 @@ static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u1
 				continue;
 
 			/*
-			 * TODO: Ref Manual doesn't state the range of _m
-			 * so this should be further refined if possible.
-			 * This range was set based on the original values
-			 * in the lookup table
+			 * The Ref manual doesn't explicitly state the range of M,
+			 * bit it does show it as an 8-bit value, so we'll reject
+			 * any value above 255.
 			 */
 			tmp = (u64)fout * (_p * _s);
 			do_div(tmp, 24 * MHZ);
-			_m = tmp;
-			if (_m < 0x30 || _m > 0x7b)
+			if (tmp > 255)
 				continue;
+			_m = tmp;
 
 			/*
 			 * Rev 2 of the Ref Manual states the
-- 
2.45.2



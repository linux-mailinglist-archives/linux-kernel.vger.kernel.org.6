Return-Path: <linux-kernel+bounces-296302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A595A8D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8139B21263
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2594E6FC5;
	Thu, 22 Aug 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwonk+IH"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30219B658
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286567; cv=none; b=rbfWgY5LuN0ZPWoG3/9msM8gXLO7fdrVPgZAhNM0EILQcAWpvTaQBZGuWjfW5P3w27QaD1Nl/YXv3L44OY3KwA8nK2v3nS/EIPQ83dXTbjq7AsyZTlocER5TGOfeMkpvCjrsuEiPvmMm1HWj4vDAAk1sE6yHDB1dzUIqfAaSCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286567; c=relaxed/simple;
	bh=DZINcWbYvLBnkXMIjWaceM0xrF/s8/GGRUcjnVdS99I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L8sfNjUKf1LfApD1mQkV6FD3wV/qB7Jq+NHKIYKWBeIc6uNzrIFmoIZictYtgU+sGNA+LXgoHUVgRhyCd01+fpiA5FDvh46SPd6xOWNU8c6QB89qIRbhs4XEK3d7IIMmgTjVQjro40iy0oMBjG2Dzm2G5Msv2dYOz16b/3fMIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwonk+IH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71430e7eaf8so198926b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286565; x=1724891365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzg/nsI1MbFA5MFtMZllhZX1eeTJ8tpCl7jB3/2ZLrA=;
        b=Iwonk+IHlp0yy0cx6xw1s3/B683KlWC6X/PLKg7zQkAE2cHO4rGvOwBdGH7YmIiw3f
         zLhOgJzpy6nwbG/dLM6iRAGDhk+aW/cVHVUaFR3md6jGpuj4FeE/+U1lLjxgBeQcdNpY
         mqgRsFgPsMW75EA2HW5TtuhIymiKawK9MDel1yrSIX8HmI+Md67jez5/2270eGYC9wuF
         1Fkd64Wj4EQjKq2tXiz9Q9v8KPf6PSQhnE6e8roQuYTqcbDXscmQKSiG/WzgUpPXHD1q
         Lv3weYe8jENd5egpiTlemBpdTLWn0oSQvZcpeUxVYpe+RzBq/F8a3xsdSNOfJ6tXWD7Y
         7kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286565; x=1724891365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzg/nsI1MbFA5MFtMZllhZX1eeTJ8tpCl7jB3/2ZLrA=;
        b=X+dgirVTWeSLdna52rh5egkC7FyPtTabt9og2PwAM3FehqT3ymVm9Nx21jUmblt++2
         v9Ql5Tmg47u4aNzXql9C9UT+3F6Rao6ISv4y9voAwlkaJ2FrJmJ5jEhT70EouEy2xVla
         qYGQsHDDFUYE5XX1NpyxsTlq7Q4lRq790sJdaMmFc134pct+xWsVFlA0aAVAsspLv03R
         6BhBWA9gkHhAxZ03Sm9UFST+E+MrNDBSUjbZO2dnVg9HmQ4WXRo+fhy+R91023Q7TwFN
         nHdzcATuSnLCNmLIj/oUAR3V6NvnNP9UdmzlYdksPCMp/PgFPeFPgQk8k5t+mZFM93Ja
         /Y7A==
X-Forwarded-Encrypted: i=1; AJvYcCUW0WzC8SmdCExUy2eaxVQ/MKXsFSutUhlP9X2tSPNLlbRfQ5kw3yIHuUF+T7mVqDXzW4ciqm434SvkNzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyQjDac0gKWokud+FEssMas66qGZBGBNSZQqvS6Y1HE7ks1Bk
	hd9Ek12a88WUchR1i14nRSSWKvSfDikWlItsLx79kmAMVIaZJiJw
X-Google-Smtp-Source: AGHT+IENhxWDehQMJE4AyEPrHbdego7IJ8NpsdReufgLGO+pv3fgRFxoZkTAFoOY5aPkCxI9/JlT3Q==
X-Received: by 2002:a05:6a20:d707:b0:1c6:fb0b:51d8 with SMTP id adf61e73a8af0-1cada03ebcfmr5668271637.9.1724286565048;
        Wed, 21 Aug 2024 17:29:25 -0700 (PDT)
Received: from sholum.unicamp.br ([2801:8a:c811:1:c632:51db:b42c:82d7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855665a8sm1740335ad.43.2024.08.21.17.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:29:24 -0700 (PDT)
From: Wallysson Oliveira <wallyssonryu@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	/home/sholum/Unicamp/LKCamp_Oficina/linux/~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: the alignment now matches the open parenthesis
Date: Wed, 21 Aug 2024 21:29:01 -0300
Message-ID: <20240822002920.11753-1-wallyssonryu@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The line 994 in the file drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
was not alingned with the open parenthesis.

Signed-off-by: Wallysson Oliveira <wallyssonryu@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 18b948d4d86d..c7ee71c60a84 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -956,7 +956,7 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 					 (u32)priv->initgain_backup.cca);
 
 			rtl92e_set_tx_power(dev,
-					 priv->rtllib->current_network.channel);
+					    priv->rtllib->current_network.channel);
 			break;
 		}
 	}
-- 
2.46.0



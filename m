Return-Path: <linux-kernel+bounces-179419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58C8C5FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306711F23B44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807565473A;
	Wed, 15 May 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="kM8Tj8MF"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA464AEDD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748766; cv=none; b=X8YgbNEiOsx5pd3RM36Z3N8ocNfuEmCEBnjXNH1wRaef2SXUZd58L6FVt1YfYHChoSl/IstIXVmr1AJqocjlX7wkZla/c1lUBKqnMKKS7lAxpCHb9kCj7oVUgdvX2820gYS8Oq5Z0Sev9QNZv/TOETgljq5xP8p7eEN72y7A+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748766; c=relaxed/simple;
	bh=pZUnpdAFnAe4C3QJi8PJJ34AzyytuNkvi1fP4KzRYf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSvIj4FYeeE4w+OiaWw75eTQIyaOu5DZdbb5jIKuaLFGCjPfa2WEEw3zJfaUn3PuEZ159b5gh5fd61E6f/Llo/aDWZm3B3aPiJc5V0vdaRLNqFwD2sxRikmuESLlGHj7dE9GFmNxJUBRQufRirVtoMcuwXxJYk35WnZd699sdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=kM8Tj8MF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so6010627b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748764; x=1716353564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrSwXoVqq+/2DYEvpPVjb0pEsc1j46P8FG1c7fjndug=;
        b=kM8Tj8MFpbYxuiUE8C2ZeRjCwNMi3Nfxr267SB6wnRoPr0OvO7LXRtIVLYU3wvue3X
         V9jM4MYr6JnMob3JDaLPFC4KRSb3Gs+5dkXCoaWkaghWNhlL/S5OrivskEaocG2MWEZS
         nFtDKaakzS23LYt1c5SEmRJQC6pSvnLgp2Bm4jCk+sgvDBpgdOhv7mlinXsv3Vg+Zvlp
         mEW5bZ/tjvzvWE7QkSSn/keYv6f9ojzrfYqrVtP2ZPBtUsrwdXHaaSb1z9aRsooHzJer
         OARmJCShCUzH/ckABw3kOg66dM3+plUqAs21eXR/n1+ETcqhlmuyxNN5TiAJwRdx9it5
         cTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748764; x=1716353564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrSwXoVqq+/2DYEvpPVjb0pEsc1j46P8FG1c7fjndug=;
        b=NHgwzZe5tjpDP2pNR4V+0GmxC2UV5IQkUTX7WX8ef6jUYUGykzohcoKRrVHUp0Rh07
         n6TL5zmFTeituzEgLqwWFlwn7ZRz1XAuJWElG/MjEzqPZD8aTnmlVFXnu0IileD1bhaG
         5WDqgQVHzHfhrTVf8sR5llHdWh9UKBs0PjZPnu9PGP6R3WE6hp4JaiYssiYzGMxT1FyY
         quvralhfyHIIoCfzbL41aiD/jgbZQasn7T8BkrpHNFLFIrWItGziVal9gdaBuFMne3ew
         MZDOZNWFNsvRAU5TQb63Rwcc50Fli0l/eAcAd9scMjvhhpWIC8HGKQum3EIhW4MJATqx
         4z+w==
X-Forwarded-Encrypted: i=1; AJvYcCUZD7NEH0fd+tF3qnHcweth92nFr/Hpk8SniPzIFOw6ygMNRSPYEr6ZAcYLPmoKlNmtB6ako/Vs7BC5cm/e7AnvtoVJKQ04uncp262E
X-Gm-Message-State: AOJu0YykX4mMT6qVGQs6g3cnQzWuvdNyt6CbdnVmiMw8U1F60+CAbusJ
	P5O+mPiAiiFta64xvNCN2zOrv8UsIZLNb/ZKeuOsu0lXime4pu7g2ZNqnAJuDMli8W8s1uSvHGL
	g
X-Google-Smtp-Source: AGHT+IHhY7medMDp5omGt2f6yWLWkN6YEbtG/+AOAtQmJU+daxsryOOOQG6Os2MQmpqKPFdhB6vbNQ==
X-Received: by 2002:a05:6a00:1701:b0:6f4:b4a2:ab3b with SMTP id d2e1a72fcca58-6f4e0348597mr16852708b3a.24.1715748764558;
        Tue, 14 May 2024 21:52:44 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:44 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/31] Staging: rtl8192e: Rename variable Decrypted
Date: Tue, 14 May 2024 21:52:11 -0700
Message-Id: <20240515045228.35928-15-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable Decrypted to decrypted
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index fdf8fc66939d..1901a319316b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1646,7 +1646,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 
 	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
 	stats->RxBufShift = (pdesc->Shift) & 0x03;
-	stats->Decrypted = !pdesc->SWDec;
+	stats->decrypted = !pdesc->SWDec;
 
 	pDrvInfo = (struct rx_fwinfo *)(skb->data + stats->RxBufShift);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 996662a06e3f..f69f4ca39fd5 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -481,7 +481,7 @@ struct rtllib_rx_stats {
 	u16 bHwError:1;
 	u16 bCRC:1;
 	u16 bICV:1;
-	u16 Decrypted:1;
+	u16 decrypted:1;
 	u32 time_stamp_low;
 	u32 time_stamp_high;
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4c8cfa40927c..3afce436a5d8 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1025,7 +1025,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	sc = le16_to_cpu(hdr->seq_ctrl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
 
-	if ((!rx_stats->Decrypted))
+	if ((!rx_stats->decrypted))
 		ieee->need_sw_enc = 1;
 	else
 		ieee->need_sw_enc = 0;
-- 
2.30.2



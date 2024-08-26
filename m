Return-Path: <linux-kernel+bounces-300614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7B95E605
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A251F212A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748810957;
	Mon, 26 Aug 2024 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VgapXful"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60051BA38
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631455; cv=none; b=QzLk4jsN2HqmAhOfA9nM8MicFU9vA6un+1+bHAqvwMlSN25v7O3uHtT+g2wZlc3SIG5c0TGNSiRvmco4e94QNhq7p5Zr+pGNXISmrBgRmGbygaJ1jw/y0AkyYjm0+RL4DM98QCjrXpGURshE20AkzW0xlvfjTNCCPfa80lG39yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631455; c=relaxed/simple;
	bh=zJE4yeKuaoyoi4Jo6/8iLqyv4Ax/0tmF0Uqz/TM69gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1INtjM/wE/1W88BvkJMLCvP53WyQYsG1DzrgHYpp4Q7m0rF82xP63npMhpRVfs88UZVC6DF9bWmcMVnGPzumolFVC4UlfRu9ClIJKTq98xYobPddUs6gz8CJ08SJUcxRO4ytEMRlx0hTuuDLGz0Fwtt0Fttv6nXEUIvvtg32rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=VgapXful; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201ed196debso30690655ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724631454; x=1725236254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3FbEnIMuszk6cKLXUnn3+Uk+c/zxQQ0xu6nNjwDcyE=;
        b=VgapXful86GO0v97xoXAJ+adpAF6l2rR9LxlewdZZ9/5qQvN4ZCRME8VGkTuMbADCj
         YKA4t1oKcQ6lP9dYtOqWpt+0FHO7lgVL27PPzRTCe0Fk8OYzgoIzyx1WfAleiNA68Un5
         oClZQtxzg4njNKdhgQDGPN5j84yNW2tHkZbiJqyv0bEChZXogk+BpJohASEATIXj7RZH
         IvZp71DxXGiNjCQUQLs/cMHQETTJ4RPZFMiCIxUZJB0HOFuNOZP5r015TjDXiNopTHYY
         tsKEngm8G4jaqjc3p6h6dJd3opuGPsf4gcJJmB0acXqc83wT4tyWqiyq4iGBYATdRHY7
         jE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724631454; x=1725236254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3FbEnIMuszk6cKLXUnn3+Uk+c/zxQQ0xu6nNjwDcyE=;
        b=sCdwIf+cMpZ5gRe6LZnd1EoC1cWVYoDqsidcRaBX24AYTdkkUKvkTEo9U54sbqRMiK
         nc18XwafAbshGN+M0nGl120M3MPaxr3LcKztJk/ymXBR1WmV7drAxpmlESMj16I5VfvJ
         fL3jBDSWb5/pVNN1oz4R+zWw4uVON1JPAxr+blBzLOql2tu6xPts2h8X7BtgNPo3wzTP
         hHuVi9+JOSDt+hFlQpY1aSZ//5Zra8znZATwly1djrbViC9UevT4rjqxxraTUDZdBkT6
         ahjMhlHq+2Qu7Iqj7ZRc4DFMuIyGY7UDXZOOp7xw3qfb4GkPV3WxiXRCKFu7yb7qUDfi
         U9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVa7AAYkraAwdPO7+fBKTPmf+SyjZaBmZDrHTNCBjVbIGlxgrwqgLjkJXyGUvtArC3A+Ff+cNAdQNLEgXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw30Y62waQ9gD84GA7OP27Zq5733+JMHnDzh1zRr0VfHu2v8IFs
	N53SkwI9XOLiQfakPUZ/Hi6E27QZvqLgtlPNO1Iqn+q1Wy2MBaMJ1ldQe/S/5so=
X-Google-Smtp-Source: AGHT+IHL3L4ZGJVusWxEPBeZu31/2LgHsqi7FJ0ncEGe0ckHnLnw6vIqzeJHzf9nPzT3JlmOTopyaw==
X-Received: by 2002:a17:902:f115:b0:202:4a00:444c with SMTP id d9443c01a7336-2039e6691c2mr58140155ad.55.1724631453648;
        Sun, 25 Aug 2024 17:17:33 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203857051b9sm58695955ad.234.2024.08.25.17.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 17:17:33 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 5/6] Staging: rtl8192e: Rename variable msDelay
Date: Sun, 25 Aug 2024 17:17:23 -0700
Message-Id: <20240826001724.274811-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240826001724.274811-1-tdavies@darkphysics.net>
References: <20240826001724.274811-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable msDelay to ms_delay
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 939f0a7c3a90..059b1f478a6c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -510,7 +510,7 @@ static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 					    struct sw_chnl_cmd *CmdTable,
 					    u32 CmdTableIdx, u32 CmdTableSz,
 					    enum sw_chnl_cmd_id cmd_id,
-					    u32 Para1, u32 Para2, u32 msDelay)
+					    u32 Para1, u32 Para2, u32 ms_delay)
 {
 	struct sw_chnl_cmd *pCmd;
 
@@ -527,7 +527,7 @@ static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 	pCmd->cmd_id = cmd_id;
 	pCmd->Para1 = Para1;
 	pCmd->Para2 = Para2;
-	pCmd->msDelay = msDelay;
+	pCmd->ms_delay = ms_delay;
 
 	return true;
 }
@@ -645,7 +645,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 		} while (true);
 	} /*for (Number of RF paths)*/
 
-	(*delay) = CurrentCmd->msDelay;
+	(*delay) = CurrentCmd->ms_delay;
 	(*step)++;
 	return false;
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 41ae98e01a30..a5ce3d2b8600 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -166,7 +166,7 @@ struct sw_chnl_cmd {
 	enum sw_chnl_cmd_id cmd_id;
 	u32			Para1;
 	u32			Para2;
-	u32			msDelay;
+	u32			ms_delay;
 };
 
 /*--------------------------Define -------------------------------------------*/
-- 
2.30.2



Return-Path: <linux-kernel+bounces-207675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3E9901A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125F41F21D46
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863222619;
	Mon, 10 Jun 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="aSYZ5ULp"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344BE47F58
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998548; cv=none; b=ZW+fVFGhAMerxSXQ7/y4K72mNI9WQ5TWHSM0HNz3lWsBn3pvkPdwrItnTiQ/PA+I8bz65oTZ56k+63QapG50pxSGD99ThaueIygdIWgjkGYJ6ADpJ1LS2tI48JTdrz1uIgXz50iBumg2mIvk5bwt3WRwUPxdfD+pym2bvcvipmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998548; c=relaxed/simple;
	bh=j5sUN1aL3OBeYbItnTAjl4bBUfZj6kaqB01gKK2uoII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTmd+lvlcJDLLoDt4O1a4CLBX0kJExjHU+dtj28gU0O1BqZseMvKvcY9XU6pOifPTj+9BAlYjjhDMCdQ9VwyuEEa/5EcDM6HEezMUVPs/hRQQYuax2m9jas6MkWFEh8McOrZO7JYpUl/bMR6hBinh26ro4s+wEUzjJJ+Rjn7HSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=aSYZ5ULp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6f1677b26so9133215ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998546; x=1718603346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1OIzPcNHoMj27qXrNDJ7NyztzvXdws07L3n32VSMeE=;
        b=aSYZ5ULpRRgsUn4Lt7THwRBKqsT+S74maDb7o3yg46X6dmceVrnBz5yqWhFUOLSKoK
         bMh4C3oKxwmZj/QCuAkf19IxFxyAffuh7nwVqMBXpys654z0fcD73Ikl4boulOns3gjZ
         jfQTzf2aVyP9R208uAHzwUn6082qw/jyb8zJQndyb9sk2PBiX+lXFcBr87rhRc1FxqOV
         LQD8jh3e3I9XwRBakyTD/SnfCkoGCQJeLLmdso3Eu5vqCpG6xbfCP7n1xyl0guxgtq6a
         tHdwFAQFhfuEMdZ8Q/eCUBsjtwVmncOH152thFOX5koj6JewDE1xoOI3E4pHAvM/1vtN
         tdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998546; x=1718603346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1OIzPcNHoMj27qXrNDJ7NyztzvXdws07L3n32VSMeE=;
        b=NzakP+dLopfWlDl2HgIkdXTPD0IBQAPsVygulejL+tC5ltvfXdeAjsBlYbwHnW/qLt
         teF8UCotuJMQcGPO6l3noGTw0FbocJYKAqhYYdiBDOnT+C2dhoOWlOiEA++fuBiqPrq/
         eQaCvL4fS5FQXJtUDatNJ1psOvZjCOzFcBBm+OVlkm5E478ME3c4kr4IfkPcp3WFGTLu
         eO54tmjzmix3Tmu1u/va2a+gMsmbMPUpIE7UoKjbTAavvebgWQvErtuHzDXuDirAjlHv
         tdITw0rM77GbhvAA+kbx7q0yyVU9G2byuVasyFxX21HDQkOnnJOiRJfW55hLtPDIpAQ7
         IKaw==
X-Forwarded-Encrypted: i=1; AJvYcCWkH3MaCLLHPsJ1dTM72TFa27MyAMhgZgvpHMRZtjivVJLL6Ev3G6PoHc8Qy95sOS2ZXMrXLijbloUbe6YDLkAxQYwZltojULhDe3Uo
X-Gm-Message-State: AOJu0YzwHqoC01qr7fbH4Q25BZH0s5poLTLocBN86QjPozPkOHC6aHiA
	Y5wYMeTXtdyu79PpZ3dZo+l49aKlFSoypHnMi2XFa15pZ9XcyNOWTJU4IdqbuJE=
X-Google-Smtp-Source: AGHT+IFEG6Vc2pZMR0CEERoCvANcsBrGEThmGVpHXLETRQpKr89UfPavThye3WGmwB/7QCurxsEMpw==
X-Received: by 2002:a17:902:dac7:b0:1f6:f0be:4099 with SMTP id d9443c01a7336-1f6f0be4437mr72198835ad.11.1717998546633;
        Sun, 09 Jun 2024 22:49:06 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:06 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/24] Staging: rtl8192e: Rename variable CntAfterLink
Date: Sun,  9 Jun 2024 22:44:37 -0700
Message-Id: <20240610054449.71316-13-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CntAfterLink to cnt_after_link
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 08d057ab8f74..9eeae01dc98d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -951,10 +951,10 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		return;
 
 	if (priv->rtllib->link_state >= MAC80211_LINKED) {
-		if (priv->rtllib->CntAfterLink < 2)
-			priv->rtllib->CntAfterLink++;
+		if (priv->rtllib->cnt_after_link < 2)
+			priv->rtllib->cnt_after_link++;
 	} else {
-		priv->rtllib->CntAfterLink = 0;
+		priv->rtllib->cnt_after_link = 0;
 	}
 
 	rtl92e_dm_watchdog(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index d131ef525f46..c21a0560410a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -241,7 +241,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 		    (ieee->link_state <= RTLLIB_ASSOCIATING_AUTHENTICATED))
 			return 0;
 		if ((priv->rtllib->link_state == MAC80211_LINKED) &&
-		    (priv->rtllib->CntAfterLink < 2))
+		    (priv->rtllib->cnt_after_link < 2))
 			return 0;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4bd7a85e2411..4abd01ff3d21 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1168,7 +1168,7 @@ struct rtllib_device {
 	bool disable_mgnt_queue;
 
 	unsigned long status;
-	u8	CntAfterLink;
+	u8	cnt_after_link;
 
 	enum rt_op_mode op_mode;
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 0c58b70ae03f..bb8ffedaf9f3 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -280,7 +280,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (is_multicast_ether_addr(hdr->addr1))
 		return;
 
-	if (tcb_desc->bdhcp || ieee->CntAfterLink < 2)
+	if (tcb_desc->bdhcp || ieee->cnt_after_link < 2)
 		return;
 
 	if (ht_info->iot_action & HT_IOT_ACT_TX_NO_AGGREGATION)
-- 
2.30.2



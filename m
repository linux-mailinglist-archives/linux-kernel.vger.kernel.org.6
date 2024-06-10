Return-Path: <linux-kernel+bounces-207685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E39901A74
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6472CB21CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516017C6D;
	Mon, 10 Jun 2024 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gSCeAf1m"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D017BA6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998555; cv=none; b=jUEXgGRckfTdJK5vWSE/4CMS5rdq/Z1JO7wuYDqs3MdBEFxkjWPFbdkpsuGAb8Vxog1QbyFVU/L/KtNYrRpCvGP43bgE8sAsx0cvPYfnT2QJvHpK/ufuOjNEz7zrA9CfTGxuusoRxyilmfXBBli1qY6qUPhLsHeIhfbhTcMfScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998555; c=relaxed/simple;
	bh=LCjGqj7+UkAPy5TAK9k04YQbrrrP/shMwMEy3xeEgy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HMNsSUmA5kMC85FybgMTVHySMhRFMtvYFtSSbQ2tYmvYYIHN4YZtQkZt/uhXWHJLJKEW5J3HXnUWweHwqJkfb3ny3t3eU75GtDWu4Op7nBgSkLDp/Pnzu0vGSBCA+5IZmKhtJXl4IyWLxdBXe63i2y1N8mHe1gMaGCQ5XunkjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=gSCeAf1m; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f692d6e990so38545175ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998553; x=1718603353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpjUTHO5n6hg3Nd1Sv8NIxKg+3sBo8Tuyt+QjDrPig4=;
        b=gSCeAf1maT4ivH3KosMNPVskAyM/gdd6RJUc7IpUooc8XVV79JOJuLQXEN79TBseSA
         nS+Lw0BxY1dFWcQULzNIjUzqwr25C8l33m9YMRd34kZSRgrniumJ7KaZNI7dQVQYPkuY
         Y2ZZf6bzME159zVvFTKxjB3UVaDL3s7///DJk0c3Do3jNqu5Sn1A5LvZeqd53fNjoNk4
         OO23i7p6auCIdzhAu+5kagtN6GKWwcKor8cp4GNfL4igR6VWWaUQ9OaPDF2PBAoz/tLu
         xVl3PPubQ45JCopNC3H8o6ESlchmekrp6SXJxCzegPJu0dEdLdxZ26vezOq43a/bCVvS
         5ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998553; x=1718603353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpjUTHO5n6hg3Nd1Sv8NIxKg+3sBo8Tuyt+QjDrPig4=;
        b=Rc7UUGnfE5ulVia2tEdEqMrIOlyhVVetnTjPixbePB5LVxZG2IHihIyELKpexvJ7FV
         mQ/KQh088seu3ZG2C5A+d28n1QTYhm3GYouqkaezLOkIWtHb4xpQaJSqFum/W5Ewzj5E
         Uwuuwe/T4/LkxMEdZlrjWC9bzS6znRJOK8m6pcXsP/ebVmld3JZez+aOwoiFCBm6mVf6
         GZeW+Cf1mPnDscumYG/U1Zb3DHbkGnKP/xSambUT+Tj4YjHnvW7vpc8+3DLKJnq6/Dms
         A6Z3KxviNAtBQVczWFQCWGkGEd0lv5/JwLQvqlRhBMnQb7g1Vy4pxy/TjFvfz0FTvkr/
         CotA==
X-Forwarded-Encrypted: i=1; AJvYcCUvTsveB5UBN6Abn0P0d0DhEshIzqx27x9x39Ds6StvNIQnDXxVJxRW0rB4OEDomv+eEe5ZXTb6je/scFCzD7ZeSu8jvFltZrUxWs+i
X-Gm-Message-State: AOJu0Yy9HU9S0/XPi6RPbzFaSel9bOf3mwQK9dTTvUE2+wFxK+mmw4Q4
	vuslXQMeXfLtvBwJe8/i8W6fiuHaN+21W64XzSaXKUW+7UbmL/FtIJlH9gayZr0=
X-Google-Smtp-Source: AGHT+IH5RL0UeWdqB9thxy1mhrwnDm4kB1mjJw4jkUwMCw1sbPJq5hkYpHjG7aHf7t5UEyT3u3nM/g==
X-Received: by 2002:a17:903:2286:b0:1f4:9759:b226 with SMTP id d9443c01a7336-1f6d0377381mr102533205ad.52.1717998552969;
        Sun, 09 Jun 2024 22:49:12 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:12 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 22/24] Remove variable IsAmsdu from rtllib_xmit_inter()
Date: Sun,  9 Jun 2024 22:44:47 -0700
Message-Id: <20240610054449.71316-23-tdavies@darkphysics.net>
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

Remove boolean variable, IsAmsdu, and code which does not
execute because it is never set to true.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index deae90640e90..eb1668458e30 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -539,7 +539,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 	struct lib80211_crypt_data *crypt = NULL;
 	struct cb_desc *tcb_desc;
 	u8 is_multicast = false;
-	u8 IsAmsdu = false;
 	bool	bdhcp = false;
 
 	spin_lock_irqsave(&ieee->lock, flags);
@@ -648,11 +647,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		ether_addr_copy(header.addr1,
 				ieee->current_network.bssid);
 		ether_addr_copy(header.addr2, src);
-		if (IsAmsdu)
-			ether_addr_copy(header.addr3,
-					ieee->current_network.bssid);
-		else
-			ether_addr_copy(header.addr3, dest);
+		ether_addr_copy(header.addr3, dest);
 	}
 
 	is_multicast = is_multicast_ether_addr(header.addr1);
-- 
2.30.2



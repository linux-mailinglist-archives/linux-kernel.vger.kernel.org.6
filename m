Return-Path: <linux-kernel+bounces-210880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8F90499A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6DD285F63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6283CA3;
	Wed, 12 Jun 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DqpE3oa0"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4922094
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162573; cv=none; b=oYd8wIuWfgnoxHwHvxjS/1tghpYg45ZVEuaZuik+U8LOyM0L+ZiLxeoLM/Sbc4OZD7UtIwmbjeFd9EzEEEOSCFAcVUGeheeEGkm1NTt066WG+S2lz4q+7cemmAu4qTxvary9/UHe89GEFBQxv11+A8tQncB0kyyc/IBEC284qtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162573; c=relaxed/simple;
	bh=B6419FpNbp+/aBwLGzQozNilV2BWM00eMrzVMInnBmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owDjP54dCHiATTJlg7/ele0zZxxd6hZasfnSq9mp1Mx76HFEhT9Nvf322dMHZw5IDrPxiFU9hsQO3UMRAG3VJlYQXrxJuPco/6nou6XOyWPMMrwXNBe+ZiTOXSouMCprM3sTmUbWIEYkMS6Zn0P5UM+PQ+23opnNk1Gki9uIT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=DqpE3oa0; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b2ed25b337so952275eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162571; x=1718767371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkUXIIgxnRHbQ4O/B4sWA8g/vJGypFpqBBuA1kYA6/A=;
        b=DqpE3oa0leLXwa3u/k9c3NfkcN+9rgh0zjNw2FdAumEZtkReOStYoA4S6CbNOxyK/D
         2kzpGc5SkGQFo440mpqJHc0VL5ftvSh1cRT3GhkGIb89kuo5tjiapRUgHlyp6OXabxO0
         EkhJavIbxdphUfvcxsFO4cXzoT/DMaJW7Yczo8km5PV2VraGvFjOBXBOOZmI9NVpzcCN
         VoGS18bYt3HDIjislOdpG86JV6mEFtoY279Y2p2+G88GINBnXqia9OxGclFEKnkP85lO
         vJrqrALTQa4ELGIRQwEszcbpCGRIAJEWASxgh5E65BEZO4gFuSNP0A3K6FRBmeoxIZpC
         d4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162571; x=1718767371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkUXIIgxnRHbQ4O/B4sWA8g/vJGypFpqBBuA1kYA6/A=;
        b=cQsBIMP24jbAdTbNEN5hnPRo/OcpbN0z7CVv0wdOyYbuk10NruorYGOGUp3USuYfKj
         VoLPUm6cr9gP68SWsFYqQg2MYt3W2QSfsHngBj20OVEECsOYg7/IKFjxZkSP5Ch3Y20i
         dtQtHUD1zodYnLYu7skxloxrznfzjDPjCXpLZKp+qvkaei76jmTM/sfmjqrHLYrbfvXy
         M+cacJ0pXK/4J2CcTt4P8VlqQz9aFmS3pa73zR+4qYN5J2nte1XwPwRJPmE5v1dAPD3N
         qsUvQ55xdCpXh/LpsdzZ69y1oq6u2c08vwFV19qlVmMiLWa9QPilPauB2udiBA7K62wA
         jYfA==
X-Forwarded-Encrypted: i=1; AJvYcCWC73xec9DONt6yEfUrMCeXItHPL9kAHrewdYKCk3EV5oDY+S7Mj0yMhw/vuAqMQ32CdstXP6KclzMtgs84FaKWgwjcrCIR+BMO2bcL
X-Gm-Message-State: AOJu0YzAf0q+7EDBOaTt9hdnlI6Hw1Fv0cI2mhD8RtMaNg9Qx9ZH9K87
	IhfrMkZLF6KKlVkH9zspWZehopQorK3sAHLRoHXoiG43E/bXrwcWz0ntSrC1JdRpe0IFs+Xf+jd
	WEus=
X-Google-Smtp-Source: AGHT+IH79lwqNICQ6D0Z3MD9ooOOiJHmZx/dsVgvZvVnkLxSkBzX3m7OiQRxy640o3aaBXoBFOrElw==
X-Received: by 2002:a05:6358:6f18:b0:19f:3764:3c4a with SMTP id e5c5f4694b2df-19f69d35b19mr86669355d.8.1718162570962;
        Tue, 11 Jun 2024 20:22:50 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:50 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 21/24] Staging: rtl8192e: Remove parameter bIsAmsdu from rtllib_classify()
Date: Tue, 11 Jun 2024 20:22:27 -0700
Message-Id: <20240612032230.9738-22-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove argument, bIsAmsdu from rtllib_classify() as it is
never used.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Update subject prefix with 'Staging: rtl8192e:'
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index b6bf10dc1772..9a9bd8450354 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -228,7 +228,7 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	return NULL;
 }
 
-static int rtllib_classify(struct sk_buff *skb, u8 bIsAmsdu)
+static int rtllib_classify(struct sk_buff *skb)
 {
 	struct ethhdr *eth;
 	struct iphdr *ip;
@@ -607,7 +607,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
-	skb->priority = rtllib_classify(skb, IsAmsdu);
+	skb->priority = rtllib_classify(skb);
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 	encrypt = !(ether_type == ETH_P_PAE && ieee->ieee802_1x) && crypt && crypt->ops;
 	if (!encrypt && ieee->ieee802_1x &&
-- 
2.30.2



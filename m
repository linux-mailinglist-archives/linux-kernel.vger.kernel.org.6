Return-Path: <linux-kernel+bounces-561177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BFA60E54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4FE1B60A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7E1F4168;
	Fri, 14 Mar 2025 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwvWjLAk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D561F236B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947064; cv=none; b=iwxLPXWAUIfC0F5jhNjk4Ey7j6+dsYDyuOqrWtaaUgwP6zr/9gsLSfcJs+dvqBDjQEiAYTDhnZnQ3CPM8KzMTu0Am17iv5Od6Omno9h+iGDExc+Pw0isYxfm8xE0pIz+W/3+DouChK9+WPUxylW0D9BJKvQjFw6aYzmpEcwqXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947064; c=relaxed/simple;
	bh=Ha/KS+ElT7WtLbHsW5QrAN3KE92/i3cgTDDDhR21CLo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ScsgP44Us6OadogCiApsaAi+yS5OVqY/6SSLiu8vH89hDyiv644kR4UkfDPLL0k71BigSt3KoaIuBad/P3XUZNmMHJpZlWidLhj9ZXCcsu23e06J4wKkQbd1131OF5cgDTMIbLqYx34CB0AwNfBTwNLtcCIY+f7aX1vPIAN47w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KwvWjLAk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0a5cfd7dso12723345e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947061; x=1742551861; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgud6hXh4dOzT1nJ8XNwGdjcgEPK4Gm9tj6MEJh365U=;
        b=KwvWjLAkJF2owAbDh6RxStqsWNxAWm4zXCtDa/+eAte1WJWGZ0wWbzWh0IZNw9gADV
         X9V3ykoqf/7sVGAidnQtRcDcYQJ2Yp9YR4utvqaR/6gXQyX+FlunGGbYluf/uG+/ejOr
         h1hF8P7C5YSz0x52hVeJf45czACkFuINm103b9LyJo75GOeKW1Z9eU7cpyRrpQMbRSFh
         Mi0g3kTdGDZSISHFawFuhqBXy4l1yyXgcHx3X5dZjYxpeefbHIz2NQq898Q30OjSBlkG
         0V1zNCXDPH3yxJpjnGI4B+J+1Au1+Q97BnEL5dKgJ+IqtkmvcgwGgDaSD21pxF9jNSY/
         DeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947061; x=1742551861;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgud6hXh4dOzT1nJ8XNwGdjcgEPK4Gm9tj6MEJh365U=;
        b=XpsEqiKMpyqPfQ7JIV807d0WwqICtmukKdB1geH5WVJ4NwrCB2ON0xY+ODIuIpzqtL
         BbrFCqvCotXueRIxXxq16y0a8bt1JMdXepjv3Eg3ohWmXrFgGAVVzvpT1rCnbG8lZfZD
         CM8tJrdPfupCz/wX84sgJRGaSDl/ED3QSBin3IR7Rupl8QaVqgVqZEjNK3MrnHXulOPH
         AbkEE1PdU4UIIexhhtgnRrbnLJjM2/zQWS6AXFYgQ6278U/rbpGkwCmkNa+I5XYTa0+i
         KUIbw0qtsb2pxcJjlSz3A1NxtAMRi/bz0SnHXadaJzhZmscJlVjqq8Zh7qdLuU1/wf88
         3UaA==
X-Forwarded-Encrypted: i=1; AJvYcCUMgoOoBja4jG12/O9cza5od1+u3LHYp0ZaCVdfO+9eqfR6sYf5N3ejAU2F2zcXF34qBFXDzeN7SCTxcOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNKqh5SP/CplIebHgYO4hBqAhRFKwO8jTILgjWNoeqQnf8jo6
	vCTnpHuPOoTgAnLv2LD2Y+0ttXwoN00a1kxALTTnKD3CXCPGTFPBflA6/oVyHQQ=
X-Gm-Gg: ASbGncvZFVMBWN/V4tcAU2C5hGs3ftlwaxi0Au97KHqbJEDN1/nJKrovbTg8YO/DNdw
	1+MSij8sRJy6hbxZ9cHNDcoCzSzBQ6KAhs49DWZ4ga3LX3zN8kyO+V/7LklMruVw6PIqgGfJ/BB
	zpuogGP9LbpgKlOzl8BgyVfSbMHNhcgK1ChS8FMVbAaDZ6YErYMOBYjDZgS6lZpbvHF2BNokJlb
	cDpHLo3loC0Li7VoWvoXC31JJRnULzBRF850fuKlUArR53WHnN5ApQpy6JNLX7zHhTquwEVFBc0
	CFwRiVuWrEahafd91cJnpA7teBhIkzSpUoQHHenjr18ru/x9kQ==
X-Google-Smtp-Source: AGHT+IGrqsA9/IFFX+VNcSF8RCUcUm/rFalF5L0nX24Ys1wiCIc0uaBlGoiwZeDMhGOrmCUK6wBs1A==
X-Received: by 2002:a05:600c:4fcc:b0:43c:fab3:4fad with SMTP id 5b1f17b1804b1-43d1ec80ebcmr26365605e9.16.1741947061151;
        Fri, 14 Mar 2025 03:11:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d200fae4asm12118455e9.27.2025.03.14.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:11:00 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:10:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: atm: fix use after free in lec_send()
Message-ID: <c751531d-4af4-42fe-affe-6104b34b791d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ->send() operation frees skb so save the length before calling
->send() to avoid a use after free.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/atm/lec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index ffef658862db..a948dd47c3f3 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -181,6 +181,7 @@ static void
 lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
+	unsigned int len = skb->len;
 
 	ATM_SKB(skb)->vcc = vcc;
 	atm_account_tx(vcc, skb);
@@ -191,7 +192,7 @@ lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 	}
 
 	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	dev->stats.tx_bytes += len;
 }
 
 static void lec_tx_timeout(struct net_device *dev, unsigned int txqueue)
-- 
2.47.2



Return-Path: <linux-kernel+bounces-207680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0906901A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E0281B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49F96F303;
	Mon, 10 Jun 2024 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="C6pJAOYi"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522F6F2E1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998551; cv=none; b=kAY9RJD/sNIbVNCBP6tOk3HBimKXrtlltL33aosskZ6QASmEAW6pa8i57Kj+wSPSrpeH7XJhdrcvRpj0xLPLz6cjC19Vj22wALPO1yrqaD1GgPWnIbJP/YQQIuNBypUsBp1c5G/TCnNiOfUsByvi/zGkX0Z4EY09xfPb5tUjQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998551; c=relaxed/simple;
	bh=X/E3Pq3kvyKK7IWx4aFnVwyrhl9NLwEvBdXDdVjlmFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjCTRzGYvstfBQnmK0EmQRRahF/XDdOd4ww7RVlxB71UZ7ExQQBJZBlu6aVRUFhg5stnBsNk/Gkqmhp82+WeGXbS9s2sOaVw4vFz3RATFdN1ajTRtfkrBqiX/0Ttvhumr6ZzoyuCMLY4jnyPOscMsCRHzYKD/mgIj3Ar/LDczvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=C6pJAOYi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7042882e741so996779b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998549; x=1718603349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K4lcpf2OkEYR2xZopw2ineD+0yCBYkA1VqFFHt8Mek=;
        b=C6pJAOYibK2vygNcma3Ba9Fb+d8YTzLxy4wK8PBelrhCTcD59AcIlCwYi6/7Hc7fCi
         RoO3xeTN64QyfBvVxh1WN7BqR6cz5tXH0obVcEGjCkgfhPq3QsRFBpVt+UuIVpzL4kAE
         cfpUqg/4cDOFFatijBvS6j+K/nBk4AhHQiajf4L2JCIkDqPVI+xG9iCny4SmSOHWH0is
         StoY3RdHSLHzCZkoGeK3BtPdjXHV/ArT/E5j4c7EW9zRaWzgvulHnp7kGWmgRzx0Cww9
         AdWEO71GEN9jqbsLHgqDywF1rA/y7T0wY6rCe+60QsxPFIHXy/qTxDqGEyQFxwt4dK27
         TiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998549; x=1718603349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K4lcpf2OkEYR2xZopw2ineD+0yCBYkA1VqFFHt8Mek=;
        b=nTCuXkFNheH7EPLuqxfefxhkpEbzsHCabUCxE4W2zw/eyhS/5my4+xO7k+Mib4Lhek
         RMMVrqi50LewtUGrp1HXZLV5l84lpAfi5HL3+pFkN8tDrqvBMsemratY8zWYA9vr5rey
         u9+zMhdglRs/zafjTcGuH75kCCfYe+JZp0Po4CA/6HvBKSbYuY7ZK1KZuJgJ9JE46FcP
         GBjvsyCRPKs4ohd/Hc7VLWXA480hK/yH3Zmg0KrHwQR17B9z9/nJ4KTWJmHCL8mZm2jh
         CVpPcGHGFYxLtcovZmz9zvz/RH4rxCa6/nNLYcRtdns0EQO9h/szN+U+tz57hcDWC7rj
         DQGg==
X-Forwarded-Encrypted: i=1; AJvYcCXEeyLJX/3Gwy7n4eaodMy+lfwJzfI3t4Jbw69Eje4gY8BhNvvZ3GrZQq3yBmfum6MARti3nafDFkBEb9izaKtmak66Ykj3vlOhPb9p
X-Gm-Message-State: AOJu0YyN3cBxXsSfa57fBUN8anm1IVDQ2EP8djpASbhwLYpeue9+WD7t
	2w+YgoqU/tuKSkaJsod+RLmcl6r34rXL7oN4DE9hxQmzADi3p2dCpTHEhjpeZYE=
X-Google-Smtp-Source: AGHT+IHtInTe/sPu8KWMorUgVUZIEkw3ZQa4pgT4eRdIsIn7FfmmjKu6CINpnzbdDhF7HzTzjaDk+w==
X-Received: by 2002:a05:6a20:7483:b0:1b7:bdb3:7bc7 with SMTP id adf61e73a8af0-1b7bdb384d6mr1157261637.20.1717998549707;
        Sun, 09 Jun 2024 22:49:09 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:09 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 17/24] Staging: rtl8192e: Rename function rtllib_query_ShortPreambleMode
Date: Sun,  9 Jun 2024 22:44:42 -0700
Message-Id: <20240610054449.71316-18-tdavies@darkphysics.net>
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

Rename function rtllib_query_ShortPreambleMode to
rtllib_query_short_preamble_mode to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 4ac8140d7e68..97581cd58571 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -319,7 +319,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	}
 }
 
-static void rtllib_query_ShortPreambleMode(struct rtllib_device *ieee,
+static void rtllib_query_short_preamble_mode(struct rtllib_device *ieee,
 					   struct cb_desc *tcb_desc)
 {
 	tcb_desc->bUseShortPreamble = false;
@@ -868,7 +868,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				tcb_desc->bdhcp = 1;
 			}
 
-			rtllib_query_ShortPreambleMode(ieee, tcb_desc);
+			rtllib_query_short_preamble_mode(ieee, tcb_desc);
 			rtllib_tx_query_agg_cap(ieee, txb->fragments[0],
 						tcb_desc);
 			rtllib_query_HTCapShortGI(ieee, tcb_desc);
-- 
2.30.2



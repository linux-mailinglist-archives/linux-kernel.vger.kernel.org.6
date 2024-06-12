Return-Path: <linux-kernel+bounces-210875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D497904995
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF74F282E19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD38210FF;
	Wed, 12 Jun 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="mHOP3CEe"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB9763E4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162568; cv=none; b=G8otMam8RVOenKND6ReIcRJiiiQekI2xPyhX/hBn6rdGk82YrLnVdPP6N7HnD9Hg3g97Jeb0qXwWgEWGmoPvrhlNv7Y0hrbbD+6h+XqQgiXj/Ie6SLWeJSCryrWeZ117UWZtkfJ0u+u8k6NEVYbQluLvVqzZkM0+laVUqf5JOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162568; c=relaxed/simple;
	bh=xqYhFHFq3mDjhjbf+ydGJnOq96SvYxfTi4zxwowpm20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPB5O1yZuv87JhvCVraX0R8idpdsIhyj2df5+1xLW0e35ZLs6iIzGHFrO+zSLkfhWemg3sjZCTBBZHcHddBdFlDkCFa0qwMUsi0uLToJ6IaPiaqwOmDjMMg0tqMjtlRDda4EQRkBcMPtMte4N/KTYLpZOVy2r1Kwd2DfQqGMDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=mHOP3CEe; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e40ee57f45so1483054a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162567; x=1718767367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+OGqMxIyTYTRN2LvPValmPFKV1Pwn8huMgM/8/nKaY=;
        b=mHOP3CEeRVbz0awQdg8XyiR1+GR89/1f7dEIEEepCyIfOmff9J17LwUfbV4FmsZ4WP
         QFqOL5gwPuN4rNjSmB2p5qaQSi9xdbZZVpmoYD86L1TbwahcXSRrPxrqktVRTw6DvMOl
         NJ53htbrcTa/5o5IYj+e1yShbVFz6+bjgplEJzBy35hUQk7kUXLISLU/JL1wVvRaVDnc
         n/6pAgLSsm4QFg9aCRj8Z8IHX/K0d3IebxY7jnuGB/US43j1b65MQ/Dr2+IJtnwxD3fC
         /P8iiteBBW7cCivj5KfpFMDugpNDzFHdHWoyAGOaN59wn0OgwpipHvTFMEqfcpSx31FS
         WKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162567; x=1718767367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+OGqMxIyTYTRN2LvPValmPFKV1Pwn8huMgM/8/nKaY=;
        b=g1lyjK+Y1oMY5/Xj1cy+J4kPC+Nuvp21pq4FwSZ5IKy79YKLe8I5uhaYDtc1Z4uf1g
         IHWRensgbcb2VhpRXJt/FcdVJXKIM3lNRp0f0V0XNBI5Gfhf/DYLzWLhronGONs6e4F9
         B5GgJ0mbRHYSrYei8RoBJZraajOvAEm4g2h4dkIraRRE/evsf2z4sQD9bjvNwrEDybp/
         ImuQnsgAGey/KRiySagdNriDCaLvigt+S76gRzISTwfnece83paO3+A6e/tl2Dvmzmlf
         Wn7GlGF+gJHyRx31PUcv96CSTDl5HZOs3TAaGnw9dLoZhKXmpIhgWuB7AnzMLDxZ0ymc
         Ntpg==
X-Forwarded-Encrypted: i=1; AJvYcCWlqxZmrmsDGHhpdvr0sFFxdKMeJoNQNc5+GG9jeXqYPauqGMYIEncZJfHdZrKpE2fkbO2gy37L2caFiSe9i5CKt52QeQTEgGvQiE6Q
X-Gm-Message-State: AOJu0YzZohBsJyBDLzH9/YJBjs8QZiAHHE1eYfTrGyb3nIKZZlApZIPb
	1DjOwoLijJehT7h2OKA4KH3JJLgdbGzO1bmg3AsLV+7uP1pzS/WqiCR5CcW3nn0=
X-Google-Smtp-Source: AGHT+IEZP/8LQIrVJ6fkZMgUyIwe3/bpxWI3Eq9BKhb8OVPt/JCV+CHgIa+UVL4HfOivalNdMRFykQ==
X-Received: by 2002:a05:6a20:3caa:b0:1b7:f59d:fd12 with SMTP id adf61e73a8af0-1b8a9e7f04amr1064259637.55.1718162566665;
        Tue, 11 Jun 2024 20:22:46 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:46 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 16/24] Staging: rtl8192e: Rename function rtllib_query_BandwidthMode
Date: Tue, 11 Jun 2024 20:22:22 -0700
Message-Id: <20240612032230.9738-17-tdavies@darkphysics.net>
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

Rename function rtllib_query_BandwidthMode to
rtllib_query_bandwidth_mode to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 24ae90915b10..06c3166a5b47 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -346,7 +346,7 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 		tcb_desc->use_short_gi = true;
 }
 
-static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
+static void rtllib_query_bandwidth_mode(struct rtllib_device *ieee,
 				       struct cb_desc *tcb_desc)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
@@ -872,7 +872,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			rtllib_tx_query_agg_cap(ieee, txb->fragments[0],
 						tcb_desc);
 			rtllib_query_HTCapShortGI(ieee, tcb_desc);
-			rtllib_query_BandwidthMode(ieee, tcb_desc);
+			rtllib_query_bandwidth_mode(ieee, tcb_desc);
 			rtllib_query_protectionmode(ieee, tcb_desc,
 						    txb->fragments[0]);
 		}
-- 
2.30.2



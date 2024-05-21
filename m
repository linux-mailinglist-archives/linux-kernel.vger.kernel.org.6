Return-Path: <linux-kernel+bounces-184437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27C98CA6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EAD1F22005
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3C6BFA0;
	Tue, 21 May 2024 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DAx0hs6g"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0A57CB2
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261454; cv=none; b=KsfQs7Ui5tuXXmR98XXsqyODNGPi74ZrgB5GA53Ef97DsItS3eyYoT/GC1K6D+yiB3M5a/7TXmlJobtPdPNdvi3ZeGWluk4BT17UlUDYG0KrAWgyQKsaCqzRC/prx78payEqlT7XVkWgWgjE/PSHdvPyxz9hd/2mOXX0ZO4PEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261454; c=relaxed/simple;
	bh=zfJSmyU2EaunM1LXwvAIWF2URUqaOE8rSUmMagLurcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtynjAz8OJTmUZfU2/LGB7u+i+4Ut03+MaOl4k5lDzlzC/QPvY2eH3870UWSWEF8ifHvesBga4eyToywjap8BQKtlTG2yZVlEndBzz1m3Cdnh8l/uZrquvY1BeIr0aQhn+5dSfqma0QOQn6e9FE9k+4vwf5qcCKuR+Y/grAwqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=DAx0hs6g; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so105652955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261451; x=1716866251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEABkOW4VKvCqiq5IqHnapExkz50KHLin5f7EBQIzfk=;
        b=DAx0hs6gRBOQIUcAoPTD1or8j4KlAw9GrsN/7VIUG096sTR7S6Y4COfUcCsG5gHkP9
         TAw4yV3dSBjw+mSDhtwsCE7vOVLgUVAwTbzIt7JlUihAr5YpSOoSmvoR1wAFoGfIgLmW
         l5YKU+vEz5pJupPoATK9sWYDHXJoCNujsjBdZ0quFmC2AG5uN7go9IY70fEj3tPerObc
         EnYNvsKN8vFOxiWOObVhR9XSpuZA8d/9arh6+qTB2SEDwS8LVnF4yj/2WGgK40ZtVtK+
         DSH22uJZe+EzS2horWsTG79rAz/5/q+Vz5Jk8wUI1b3aoQVeR6EmmQAiQKbuf6oOVdVx
         QU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261451; x=1716866251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEABkOW4VKvCqiq5IqHnapExkz50KHLin5f7EBQIzfk=;
        b=f8EAT8hd4g6NKHThFEOSaNkxdaw+qrAA9tndxgUwjStsGvW2F9le/qNcOPKSv/Sdlt
         dboDmpTKqL4+u7+vTibE2Yy7Vu7ckdbXXop6PtX92r8pZzIfBNZdZz7SEADZvR9lqtBX
         2M8Eq91VEdBBYFV3WRtxFu9EBSfuux21Us/RTzNT9dXCbDthwfpBlgCIClFOJiWyE7nC
         l8VGeZi1m7OlpGZxyt7L5wCZDZPr8BYJtzQ9aH969pjufRJNVc5zImz0Fy7pJK2Clusk
         88jYgrvhJScIdkwCdAWVBzivdSjYaJZ4xvfjmE1oFLxVd565C495vdxTH2br6QdJ1GK5
         IAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbUDNT3UX8Jy32rPgEpoM58selTbvR96E8+0DD5KwzcIUCq/cqLpMFEhzTKMxidxNPykxNzWIX+Sf1iUYwJHSA00ScRKTqaUkQN7u/
X-Gm-Message-State: AOJu0Yz2CdErgKyTx5zcFT5331EsYHQROthljQMJ26ztNcynIrzZh3np
	m0Wr+BuwNWgf3eooEyvbuxOgUaTJGDime6PHOiLJsaZ5DTYPF5g3rb7964M7vNE=
X-Google-Smtp-Source: AGHT+IEh9d/TIcGUMSlsJ3sIHqq7naGrzIK8Q/3NUyeOT627ZX75Eg0Fa3k4rVRatRXfjf7q0IiRow==
X-Received: by 2002:a17:903:32c5:b0:1f2:f7c6:7554 with SMTP id d9443c01a7336-1f2f7c67a42mr107221565ad.9.1716261450817;
        Mon, 20 May 2024 20:17:30 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:30 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 12/31] Staging: rtl8192e: Rename variable RxReorderIndicatePacket
Date: Mon, 20 May 2024 20:16:59 -0700
Message-Id: <20240521031718.17852-13-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable RxReorderIndicatePacket to
rx_reorder_indicate_packet to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 24136bba64b6..a30945f30e14 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -520,7 +520,7 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 	ts->rx_indicate_seq = 0xffff;
 }
 
-static void RxReorderIndicatePacket(struct rtllib_device *ieee,
+static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				    struct rtllib_rxb *prxb,
 				    struct rx_ts_record *ts, u16 SeqNum)
 {
@@ -1366,7 +1366,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
 	if (!ieee->ht_info->cur_rx_reorder_enable || !ts)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
-		RxReorderIndicatePacket(ieee, rxb, ts, SeqNum);
+		rx_reorder_indicate_packet(ieee, rxb, ts, SeqNum);
 
 	dev_kfree_skb(skb);
 
-- 
2.30.2



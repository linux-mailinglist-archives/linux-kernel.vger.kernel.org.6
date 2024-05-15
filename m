Return-Path: <linux-kernel+bounces-179423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B28C5FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69261F24915
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB005FDA9;
	Wed, 15 May 2024 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="A0v3uaNT"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D757CBC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748770; cv=none; b=bOhpRDJlE+7ldz9Oh8klE5NhhDT8HDHkN6ZJ6Vzw9S33kJMX/aTqTwC+UF25hUtuH3CceuIMCYVKZvqhZJAAzoti1f/XjgQ44gLXpFDrYr1cAexfkZyl8T0UNnIVutFnRrrlcJHz4LZEduzPjIxemRT5z42yfsTUPMmOJngklCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748770; c=relaxed/simple;
	bh=j8FIoUecn1AFzIJ3lRcqU8BJfgd9wlre/NP/eWzugKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6BaAIDj6YBVcmmPtcSSu1j+lpdfN+Ny+A3Tj4w5RNGFTYgZbt/yjU7HbosGXaxNePdo5rAw1oyLjJdHQCtRIL2SKymaufdCjpCXvpv4Kl/lmNNfeIwY0Nv7h77HAdW/zVuHlN2YsEqbZo4fYJ28cHooOORpZO2UFkoMaSpr6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=A0v3uaNT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44390e328so5870714b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748767; x=1716353567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj4L/CHdV/htnUT6J3pcKdpL1c2PJObvzofLSI2WZDA=;
        b=A0v3uaNTPh1X3btf/3UUK5SDQ5XYxqfe8EVMuBmobdXt6OAUSHa73dfWRJ9TNZ0Hj9
         3wNXZoC68yaohcqcuyR3o9iI5UEkNjEBHpB3f6V6/+CVkzcm9IPQmUEcG+vxXPs908FZ
         9JXNExyDCHEY4YMWGm9Gx9bGu4tt1JN+Vft+kVy3EEq0G9ueX3pAf8hL2SX803q7EGwD
         Iy5zecAsJO7Q6xoPxgiCAJ2Knr0/eaeZU6vRGwoZuLSDqQid0uSy1vzd0n3mTpQJwoOy
         NpepTS0ydsnFuWpDBt0jalgsNscaZF2qxHBemPEP+gPDHBsz7KwkkPKU5BibgOP1beXJ
         XRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748767; x=1716353567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj4L/CHdV/htnUT6J3pcKdpL1c2PJObvzofLSI2WZDA=;
        b=Pj+VmrUVD1H6jSfnVt1TzOhbmV+GzNWFJ5/yz7aobDS70wM9jVlhgfE/WKpah+arhP
         HU/KkGFldSu4REHmI0GEpk7ajx+vkm1cQxwd2OWNHhMdJatLBZiw/p9g/JMmmJwKOmvY
         7D4njb8scJvcJED+M4mrhhUFF1chFBfsdrtDkdb6qfpa8amGQhRNaVEr14FY/9+3bJT2
         Xl6RFiIKR+Q3GhrT6991tDpFc6j+lLKv9a3pgLpW3A1Hbj5i8Kr0Hpnn0JgEaUrQncE6
         maScaLYmpc5GjeYtX7bQuUpcUdaYF2p0k8aZ9B+BUtz7HEit/dKHRpr3Pt+E+cKJyW2S
         wQkg==
X-Forwarded-Encrypted: i=1; AJvYcCUHW4qhYHNeUcn8X34Pg3kySF0VCzzzrn01G4TUPN+w9yZQ9OIXYhdFk0bzaLAvV6ATQ/5SbETJs6qxCHnZYAeSZTuDjhagvHhTMnhk
X-Gm-Message-State: AOJu0Yx6jBG06y9h2zBwKs0B5KXgpBeTrkmS0NU2pZGOx9OYA/ez6QGq
	Tau0uHCBHG3jF3m9VvXLV+i2PN6kw2y1jl/7H4qjiaD7n0Vy+XQpopo0XI5s8TM=
X-Google-Smtp-Source: AGHT+IHF+M70lFpwqTCc6v65QxOTVhynetMH3XiYC0SKHvlzoeD/Pw5xt6gI4J6VMcFzNRb0oD2LVg==
X-Received: by 2002:a05:6a00:1250:b0:6ea:b69a:7c78 with SMTP id d2e1a72fcca58-6f4e02b0b73mr21621527b3a.14.1715748767229;
        Tue, 14 May 2024 21:52:47 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:46 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 18/31] Staging: rtl8192e: Rename variable LLCOffset
Date: Tue, 14 May 2024 21:52:15 -0700
Message-Id: <20240515045228.35928-19-tdavies@darkphysics.net>
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

Rename variable LLCOffset to llc_offset
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 0db75fa7da1e..3223619f8cd9 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -728,7 +728,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	struct ieee80211_hdr_3addr  *hdr = (struct ieee80211_hdr_3addr *)skb->data;
 	u16		fc = le16_to_cpu(hdr->frame_control);
 
-	u16		LLCOffset = sizeof(struct ieee80211_hdr_3addr);
+	u16		llc_offset = sizeof(struct ieee80211_hdr_3addr);
 	u16		ChkLength;
 	bool		is_aggregate_frame = false;
 	u16		nSubframe_Length;
@@ -742,16 +742,16 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 		is_aggregate_frame = true;
 
 	if (RTLLIB_QOS_HAS_SEQ(fc))
-		LLCOffset += 2;
+		llc_offset += 2;
 	if (rx_stats->contain_htc)
-		LLCOffset += sHTCLng;
+		llc_offset += sHTCLng;
 
-	ChkLength = LLCOffset;
+	ChkLength = llc_offset;
 
 	if (skb->len <= ChkLength)
 		return 0;
 
-	skb_pull(skb, LLCOffset);
+	skb_pull(skb, llc_offset);
 	ieee->is_aggregate_frame = is_aggregate_frame;
 	if (!is_aggregate_frame) {
 		rxb->nr_subframes = 1;
-- 
2.30.2



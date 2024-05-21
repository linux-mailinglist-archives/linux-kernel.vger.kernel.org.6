Return-Path: <linux-kernel+bounces-184443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8C8CA6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FC11C20291
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C52745E4;
	Tue, 21 May 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="JM+FM1Hu"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2146D1B0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261458; cv=none; b=S8SBRPIxRiB887cse14gQRK3OXTzHOn7TyM28MVwlsOtFC2p1cF7ATeCF1TnTImP8/AXLDoWf04j56U3NmnRxr54mhg9nsGOmWqXWUDX4zjiQ8RAhdBrXf7hXqHCJvwKLmbYUpODcjqj9A3LSAB1uVnBrHWn65Hl72jDLzE9/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261458; c=relaxed/simple;
	bh=vOlhyRJiwMlcqMkjgh8ZqeWXUxY6D61pDutdGqwl5CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6wo2FzmGAexU3ITN9h1vzomREA5Ofjcx2iH/c97AIBwD/p74ZF3lbwlMuyrLnP8QN5CjhpMAgGk4FHo61VO7ej7lcztOVojgSEX4MKYR+r0Sk0q9l+hJ7P5cCM9/0YuqoDwshjERZaM/6tE6Wy4lh1K84LsJkBcoZs25e8rMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=JM+FM1Hu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1edc696df2bso30589315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261456; x=1716866256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIGSQ3C/BdvZT98agea7mQnapaDbDhw1o6G8ocniTTE=;
        b=JM+FM1HukvOhiVVfpaBzpqrpMhTCy2bh0Monq8xoWuWFx4DKq63gr9YXu3yGvYvMLU
         3T228LHr/qwuHJdfYP3LPd9RpUyaht/PPXDwDRKPoXKE1gE8q/Fh5SWkGXqan7gf352F
         KSdYIINB5MAqiotW1VDrmmyGyNYZ568/NsnNF8ubFV1SAW72fkBWvtJowp3XQ7Iq6hYL
         dEasRh2wl+SPNc/mkYnmJdn8b5EaDFu5sUu7vZaq7fP9cSpRbiOJAh/LwPHTHfXF9uAE
         Ym321F2b0mmNVlhfUbwZlEyjDhqpuAskfxUqpZrKp2Gs34n5WpkMXi+4yltMR9YpxV1O
         aWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261456; x=1716866256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIGSQ3C/BdvZT98agea7mQnapaDbDhw1o6G8ocniTTE=;
        b=Xj072Ch0W3+sEdG2J+lu0f/nUdl3Xwp9fn7YzRFU10ykOsy5y+9BoMq183YnbgRL4b
         ZnnJRbNsFcDCUOuYGN2AjP4M8YeXTJdEMToRcKotoYKom5sqVNzXkAGmCiaK+uNtWpx0
         VECDg9ehA0lOy3EoN4vHzIdrt6MleayOtg/vuBklXLo9UM/MXjulmqjjlU9xqkTFkCcE
         CfuqKacX3iTAXBO1yWe1AtzXQWuxmMiYjyh7JWkBljYBam24d1qaeeWM1x0EzBlqs/SC
         cShs5BdmBX/n5sht/3tsxh6kfkFJyBfBmNP0nsLONB3roCAQDIHoDI9KqdAfmVTU0u+c
         nCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw1Jc3TufMdI6LdI6He8KJoRKy/7+uVyBLxMfuwpGVibIEDQGekpJN2IjmLbQhpJBQJUdgaJV6VK/odTEI6z84tse20oxHENJu7XHa
X-Gm-Message-State: AOJu0YyJ5AQT6g68dVB1Axvqveh8HliCOJY8/zja5OA7xTEENQScXF7A
	t9HIqIXGRIV5vn0bjuIRu3zMzodgwoVoMlHLBbHHdfv24vagr4bCfOwc+BtqBfletoCPZq4yPOb
	5
X-Google-Smtp-Source: AGHT+IHCEk90C+Vq4CiPohjEvBRo0vWIF3yzHeFHSZPkzH/iMjxz0YZfmHGO49DF9SNeggUgvFn79A==
X-Received: by 2002:a17:902:6b82:b0:1e3:dfdc:6972 with SMTP id d9443c01a7336-1ef43d15755mr316580525ad.9.1716261456179;
        Mon, 20 May 2024 20:17:36 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:35 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 19/31] Staging: rtl8192e: Remove variable ChkLength
Date: Mon, 20 May 2024 20:17:06 -0700
Message-Id: <20240521031718.17852-20-tdavies@darkphysics.net>
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

Remove variable ChkLength which fixes warning Avoid CamelCase,
and use llc_offset in its place.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Delete ChkLength, and use llc_offset instead.
 drivers/staging/rtl8192e/rtllib_rx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 52fbbbaf30b0..3a637731506c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -729,7 +729,6 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	u16		fc = le16_to_cpu(hdr->frame_control);
 
 	u16		llc_offset = sizeof(struct ieee80211_hdr_3addr);
-	u16		ChkLength;
 	bool		is_aggregate_frame = false;
 	u16		nSubframe_Length;
 	u8		pad_len = 0;
@@ -746,9 +745,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	if (rx_stats->contain_htc)
 		llc_offset += sHTCLng;
 
-	ChkLength = llc_offset;
-
-	if (skb->len <= ChkLength)
+	if (skb->len <= llc_offset)
 		return 0;
 
 	skb_pull(skb, llc_offset);
-- 
2.30.2



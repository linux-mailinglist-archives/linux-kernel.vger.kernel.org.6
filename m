Return-Path: <linux-kernel+bounces-184440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B98CA6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58ED5282113
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF373165;
	Tue, 21 May 2024 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="QJTX4JQ9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA326BB58
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261456; cv=none; b=CBMfMXF8PTSr2OeeGfr+yTG2Z+wNXKEFhJVL6NXCgnKoxi+9hm2I6N3HUUftPLjciHGxGk4GwO2fgR6w4ZGJhHeQLugtQjJbdANxDEhRs1BZwp3PupDJtRli80XaGllDjEqFRjzLaNMM6FQwop2i0QZZ9+bJ+d51lgWvx2rrRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261456; c=relaxed/simple;
	bh=Qp9Q2ISvQlMozzVKsSzgcrAnhyylfHKJ2ip+J3JJmPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVvPzagC9+CdTeB6wYgkQVGn7Z96qsGWPa0RhqGOHJFMT8CV+F/KMYvQPKP/hK1FTAata0r3xqvu5KdCrN4ZycCMHADW7mJLBuTF4pAC3yKe6kEo2iVdcrAdexR3Hr8o8JJbyXgY3Kn15vyfDNdVee4ANUejWwY1Hl1oytOvIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=QJTX4JQ9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec92e355bfso107912835ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261455; x=1716866255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htW5kSCHk6pUg/aASaEh06kykYiS1exLSGkKV91xbbE=;
        b=QJTX4JQ9wnMLybWkvptQ730U8pYnApfPnyyz12lQ9uQ7Hp1avjGO9gejUSBjOz3GJI
         rg+DLSeMclBoTcMZq4KEXe7iiGs4hZBmFbiTcsfZWW7UpyBqMAlOxUpM1oy1h11afJtr
         cO7wz1RYzFgaT/tAiy32LFc3hfkZENObAW9Lgfk+Fxpk2AK4We5xbh2N1WcJgu0y0vXN
         STgV0Yqx0XTpPXX9F4i0rlL1MC9I1MFTTa7rfN/ez3oOrLxTvppxrHDa48ukzPVvaQ/i
         RtFpcyXJia0TDZjkfgt87/eVsfTcrlAC9+1w+hPVXk2hkC3hkDxQsO5152FOABDl1D7m
         +byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261455; x=1716866255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htW5kSCHk6pUg/aASaEh06kykYiS1exLSGkKV91xbbE=;
        b=spoNVGHXFaaYBApSt8Yo6U4E6G9VkUHAzllopx6ZWZyUtFmLEV8XoRyoD5YWcLViqR
         LeMSuefoR3iKfrG+PSNGMrhfuaWCR18MTWqjmAznvg6Bl1MQb4G+HU7OT9UG8DY0D916
         4iwXxpK80vZv0oHsC5Vk4Y4F2bcvFI5zPdXEhsQPG8j698iM6JGfSG+88sI0zRt6xdTS
         CPhgqHfkqC9t1NWUYrfrYV4DM6lfTMFZnDw2EWOZsA17P/WMZtiJjWp/pg5wa9A2Cb6S
         vEc07K2ZZYrDfN32mWsC2OzqJ5Hvkp0B/9kc/AtvO7XuUlpF3RDrmKRCVU2R7u/zMa7/
         tusg==
X-Forwarded-Encrypted: i=1; AJvYcCXj6OAzQQpX3qlYrt4aNid2lVxfoLm8NdSLSEW8H4rmw0VomyJ2XvHPyw3835vlFwNpOlmv1VWFLpVGjBPOFBWW1jcxmFhP0LW4Cfp5
X-Gm-Message-State: AOJu0YxLgrM01uC0+XNADn/zGVzxal7AWtNfR0voS9y4iV7drBtYB7ck
	fAy3XZm7y02/PM+WxlA03JeWB58s4GKM0q08v/LO63WI0G9pXYTey4YlklkkeGw=
X-Google-Smtp-Source: AGHT+IGDe74xf+ez6yX8mWjW+mXFftRFrHLChSip7NgL/qCcpWcipNqs9VMkv2lF5lXZTBDSviVZ5A==
X-Received: by 2002:a17:902:ec83:b0:1f2:f0d3:db30 with SMTP id d9443c01a7336-1f2f0d3e367mr91334535ad.64.1716261454829;
        Mon, 20 May 2024 20:17:34 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:34 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 17/31] Staging: rtl8192e: Rename variable nPadding_Length
Date: Mon, 20 May 2024 20:17:04 -0700
Message-Id: <20240521031718.17852-18-tdavies@darkphysics.net>
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

Rename variable nPadding_Length to pad_len
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Rename npadding_length to pad_len
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index b1cb73c2177d..c32eec733373 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -732,7 +732,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	u16		ChkLength;
 	bool		is_aggregate_frame = false;
 	u16		nSubframe_Length;
-	u8		nPadding_Length = 0;
+	u8		pad_len = 0;
 	u16		SeqNum = 0;
 	struct sk_buff *sub_skb;
 	/* just for debug purpose */
@@ -833,15 +833,15 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 		skb_pull(skb, nSubframe_Length);
 
 		if (skb->len != 0) {
-			nPadding_Length = 4 - ((nSubframe_Length +
+			pad_len = 4 - ((nSubframe_Length +
 					  ETHERNET_HEADER_SIZE) % 4);
-			if (nPadding_Length == 4)
-				nPadding_Length = 0;
+			if (pad_len == 4)
+				pad_len = 0;
 
-			if (skb->len < nPadding_Length)
+			if (skb->len < pad_len)
 				return 0;
 
-			skb_pull(skb, nPadding_Length);
+			skb_pull(skb, pad_len);
 		}
 	}
 
-- 
2.30.2



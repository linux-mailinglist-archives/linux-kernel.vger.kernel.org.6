Return-Path: <linux-kernel+bounces-398747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6849BF55E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F284E286A78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038BD20C302;
	Wed,  6 Nov 2024 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtsOFUQJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E0209F22
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918046; cv=none; b=lmqfz/rwzYKnWTqcWxBzdKtAUS0kH0xNsOwDcFJslBjxDF+vAe6ThQFel19bP0fA1fHMNvOkZfzXXnT8KJIDTqBenq/I3VTxXPMrnQJTNDczAz0JXLPWNQeMf6Suo6g3lAJpAhBbIiwgnRxEnIuQT6sOACJXkHXBPtJeAbVfgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918046; c=relaxed/simple;
	bh=hBUxEv3qbO/9OB1qQM4GecNfPwIPQArtUwXtuauAVKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwBGSzkeu8XEqaZqxHc+kbwgvoNGcmwdMMRe1OK11g1O2+kCbIm3JOrfd+enHt2V5uNhgwffeZc0TrjJBmyxrGvaiWkMUtMVdDKrXLdJxLzgbHs0xr238JzOyFuGVLvPUB7CDxNdC7rVjZnoBmZBMhgTzSjAhl/kGuWKRvljdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtsOFUQJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f646ff1bso6164066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918042; x=1731522842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmkiHjgr2PxF+ocYxD6zDhmu1c+VcNka7RApTzQc14s=;
        b=MtsOFUQJWhFUO9/rw5msc5rJ7Xb47tf4ZuQnFz+/6cbef8OWIukjOXI4UKvacplUO4
         zOiZ6877vGK7qRt8nbRDUhqLMOk3amsAKGWEbxg1oNQZGRgIthEdFi8P82kYRG+kWNP+
         M+hSih4PppylTIP1f4boP9xOsEIlMDqrb2i+3tA0wCRT0mFEPKCmGkOdozpmiKeY68x/
         Jck0XFFOjR9DlsUq54WxRAjAJdnaKqZF0BC1o0XRwKRO9EZDeh82mpWfsbqvbi+EjFSv
         ln5uq6Yk5PkmKMIg1yyabq84XilnLHzwuCOv/JZ7YkCQgamsln73q7Yo+MMco+RgNL4p
         aJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918042; x=1731522842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmkiHjgr2PxF+ocYxD6zDhmu1c+VcNka7RApTzQc14s=;
        b=M03Kkam5R12Y+XIZYc0k02tsWgVlC1k2vIO2DvGDYR7NpWZrHMUbwR2B4KYSGm+JoW
         O1WuFv4mxxph26Jv4IEq5EzIxiY1l6wYxpNSqeE1oxDj66HQ+zoDgvi3T9z7OlesxqCT
         PPTHxfRyzherVTVRDg3a0ZbwpYF3V4gA56tvBi39PVwebA7kecosL+fwEPZpHMnikIpQ
         xtzDRGsiVhemsjrPhNy/Ys4Xh8YKT6zpQedP3obZrIgtmov9l/Fod9dzczcwfPTgwF8k
         b9oGmVqQwUVaMTRkONY/KiUV6aEqKpb3EVdQ11R0TuZGIcWcOzhFd0kxtn5Yphc4tlRG
         wmSA==
X-Forwarded-Encrypted: i=1; AJvYcCUjx1qIZ6OIPUtaETv98qIhBKOHUgx4kxblEa6A+A3V7Vw4pAt4Zyca35grWTqUECaflosW+v3MOVJLmeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUrg8eZPb8vnn5B41E18VVY3YQ0pEpcbADYCqy2f3uVOAas0p
	jCEu3wc61qszDqbbw1QKxXxEbRzZcrxRMMprKjRto3svoQrfsqYaTrDE1w==
X-Google-Smtp-Source: AGHT+IEp5BaNpq8XkNY3ZfxjAdH9fkFzSbcmwNJDPcu5Ly/IEQRNCIg5pGEllGddL9MyK0lFZPW3Gg==
X-Received: by 2002:a17:907:608d:b0:a9e:b5cf:df02 with SMTP id a640c23a62f3a-a9eb5cfe797mr680578066b.41.1730918042214;
        Wed, 06 Nov 2024 10:34:02 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:34:01 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 13/16] staging: rtl8723bs: Remove function hal_EfusePgPacketWrite2ByteHeader
Date: Wed,  6 Nov 2024 19:33:42 +0100
Message-ID: <58b682a5ecc0cce08dfdbfe20690eea47efebf18.1730916582.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
References: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function hal_EfusePgPacketWrite2ByteHeader to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 55 -------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 9231a4bffb5f..c6cd0f11cd91 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1183,61 +1183,6 @@ static u8 hal_EfusePgPacketWrite1ByteHeader(
 	return true;
 }
 
-static u8 hal_EfusePgPacketWrite2ByteHeader(
-	struct adapter *padapter,
-	u8 efuseType,
-	u16 *pAddr,
-	struct pgpkt_struct *pTargetPkt,
-	u8 bPseudoTest
-)
-{
-	u16 efuse_addr, efuse_max_available_len = 0;
-	u8 pg_header = 0, tmp_header = 0;
-	u8 repeatcnt = 0;
-
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &efuse_max_available_len, bPseudoTest);
-
-	efuse_addr = *pAddr;
-	if (efuse_addr >= efuse_max_available_len)
-		return false;
-
-	pg_header = ((pTargetPkt->offset & 0x07) << 5) | 0x0F;
-
-	do {
-		efuse_OneByteWrite(padapter, efuse_addr, pg_header, bPseudoTest);
-		efuse_OneByteRead(padapter, efuse_addr, &tmp_header, bPseudoTest);
-		if (tmp_header != 0xFF)
-			break;
-		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
-			return false;
-
-	} while (1);
-
-	if (tmp_header != pg_header)
-		return false;
-
-	/*  to write ext_header */
-	efuse_addr++;
-	pg_header = ((pTargetPkt->offset & 0x78) << 1) | pTargetPkt->word_en;
-
-	do {
-		efuse_OneByteWrite(padapter, efuse_addr, pg_header, bPseudoTest);
-		efuse_OneByteRead(padapter, efuse_addr, &tmp_header, bPseudoTest);
-		if (tmp_header != 0xFF)
-			break;
-		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
-			return false;
-
-	} while (1);
-
-	if (tmp_header != pg_header) /* offset PG fail */
-		return false;
-
-	*pAddr = efuse_addr;
-
-	return true;
-}
-
 static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 {
 	u32 value32;
-- 
2.43.0



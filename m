Return-Path: <linux-kernel+bounces-510788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4CFA321F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C57A39DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62C2066E0;
	Wed, 12 Feb 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE1Y1mDp"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DA205ADD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352185; cv=none; b=fyPOka6jZs0h2koBwGKvCI9bjFn4XK+hRYshKlqDdYSgqLY/2X+uFeKwahLKVOqdsL9ukzhec8egZbsS2F2OWV9D1A1/r5bhTbF4dp4sCD8w4/dqRkzGfZNuFeEm46gU6Y77MwIDmoMcvpuDCOZxbRwNkKwxkwKp2zdDnCDEylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352185; c=relaxed/simple;
	bh=8GQ2IbQO/TBdQ5t+CG7jhfSfm6Az5rcS01/oAUZJR5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvZgS1Xca7m10VIrETOCSuE031Tb8vAxW7XdCDpZxoLPF0DOlhQtC/JXIMfhXMwABVRxXT5dU/zuDdLgxr6lwZpQtQxhtGNt7RqP3WeLCVz3KkbMLzz6cyBv1NqWbWCOBqQi66GveQDUYe3QuR2lC3AXbPvKDqNyrLm646ZuDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE1Y1mDp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f710c17baso71171305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739352182; x=1739956982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu04RjybaCqnANGt/0BrWouaa6SjIJlJpx9c2WRJsXI=;
        b=PE1Y1mDpj2RLwqNEOeamSYuPZGhIMsgENgNtjbSMV4AHoYCqxhXXGKAzAOypSmkls/
         vkbFkh0vGdnsLxJV1LEGx+dl8dBK6Gj+FIbhmcn/E+c+y/8R1rv6uvGFewy1ngm6Qy64
         Pd1hwdwnwmxU0DPAb4Wug9dwpAr/EBSPcMA0ClEWns1t27y/k+L9SiTGBn7+5uUJGOxa
         nLF4/7p2vWZHpKp7nJ6RfNgdx8rxFtc0jeYJfk4JI+RYEvUMA3CUVNaxSx9374upCdvM
         387BYe1fKa8Kg9M504RSq55PJDTdcl2JHf/+ApCYgQ9Nwa885QgpM1WSxZLkbRziAFjX
         OdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352182; x=1739956982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu04RjybaCqnANGt/0BrWouaa6SjIJlJpx9c2WRJsXI=;
        b=SJiC1MG9kAyoPSBq306z47dr7A54wV3npDvFj/SKJj04C3khGGYj8CuFlzah+QGXcq
         HLE/gBqmPXWjKS/AjtRHRJhTYs5oRNFp9DPQSEB/gZMLf74MmrpFaddRK3MzMIrVl//7
         9HA+4KRGdZZZa7R7bQ0AeqMllwh/K4vPdx4oV9gxfnJgFomwVUS9KvX7vEkMXJ7Oa4Hb
         aGPDXfMki/7SqEkF+K+UkGERpGUIMwEWfP3JCsZbcctF3oGGFihwobrmNl4+BSpOmXOf
         dsYUMa/Sd82E5PP9Gdb0+iA6tEEPy+LzLriOsaHYHs/4ZgtjXJRcKDNVH4whzgrs/T3d
         Nptw==
X-Forwarded-Encrypted: i=1; AJvYcCW6FWnDLXs9QSJvPNJ8jSSM3/1m0nRgc8c359npBcpCDXAPhiDQRgdGLCQM8S6etH6xNnFaC5BCxMC60aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXk3NHCatAiFHDdxntPXVtwOr15ZNCX6+9KRvvxw6MatrXEVz
	wC9WSRQvXHh7hxxdSrP/tGrH+3G1mK9iUwlUfp8XQDpARNSPnyHE
X-Gm-Gg: ASbGnctn+4he3n7n29VcocogYhmdIXwn46b9X38R5CV4Oe7Gc89U5/KFn6vrjv9mfSV
	UaAXR1GW17ORnz50saGKddS/0ZdRjWfif7bHnKcehEm5QTWVFB7yxLhx6zWrKfXyKtZIj3UeilH
	eUZBfFwPkTD3YdsuWcxgJ82X1ktbS8b//luG8eCzzECloTzfU9I4Vilnsmk6dRNVfnpVNs7nG9O
	f8407qGOlE8S4u+/MkAJf4zcIU+RtjLTTuYHpRcHG2EtYNF6P8YJPg7mJBJJ1r7WJNaIHYNrDK9
	MY81IfYJA+7UwahoR2zDAwNmFTVVUD+vClSnWXqpRRD/E682HKJELpnvLtcmqw/yfNRKOMcnLxn
	o
X-Google-Smtp-Source: AGHT+IEVEHuWDTkCXAnIlbVfuyBTkarR9SODQIlkdYItGRxFMa9+LvgX1ERdoq8t4tLxWuNRs325BA==
X-Received: by 2002:a05:6a00:804:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-7322c43107bmr3993447b3a.18.1739352182475;
        Wed, 12 Feb 2025 01:23:02 -0800 (PST)
Received: from DESKTOP-GL3U3CJ (162-207-94-177.lightspeed.irvnca.sbcglobal.net. [162.207.94.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73091b2a97asm4838829b3a.152.2025.02.12.01.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:23:02 -0800 (PST)
From: Ian To <onlyian4981@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ian To <onlyian4981@gmail.com>
Subject: [PATCH v2 1/3] staging: rtl8723bs: format comments
Date: Wed, 12 Feb 2025 01:22:54 -0800
Message-ID: <2e6dc11ef35d5af653095e416f2a48b6dbcc0de1.1739351267.git.onlyian4981@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <cover.1739351267.git.onlyian4981@gmail.com>
References: <cover.1739351267.git.onlyian4981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some comments were not formatted correctly. Reported by checkpatch.

Signed-off-by: Ian To <onlyian4981@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 92 +++++++++----------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 1e9eff01b1aa..f4556ae54352 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -30,10 +30,10 @@ const char *security_type_str(u8 value)
 /* WEP related ===== */
 
 /*
-	Need to consider the fragment  situation
-*/
+ *	Need to consider the fragment  situation
+ */
 void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
-{																	/*  exclude ICV */
+{
 	union {
 		__le32 f0;
 		unsigned char f1[4];
@@ -342,23 +342,23 @@ static const unsigned short Sbox1[2][256] = {      /* Sbox for hash (can be in R
 	}
 };
 
- /*
-**********************************************************************
-* Routine: Phase 1 -- generate P1K, given TA, TK, IV32
-*
-* Inputs:
-*     tk[]      = temporal key                         [128 bits]
-*     ta[]      = transmitter's MAC address            [ 48 bits]
-*     iv32      = upper 32 bits of IV                  [ 32 bits]
-* Output:
-*     p1k[]     = Phase 1 key                          [ 80 bits]
-*
-* Note:
-*     This function only needs to be called every 2**16 packets,
-*     although in theory it could be called every packet.
-*
-**********************************************************************
-*/
+/*
+ **********************************************************************
+ * Routine: Phase 1 -- generate P1K, given TA, TK, IV32
+ *
+ * Inputs:
+ *     tk[]      = temporal key                         [128 bits]
+ *     ta[]      = transmitter's MAC address            [ 48 bits]
+ *     iv32      = upper 32 bits of IV                  [ 32 bits]
+ * Output:
+ *     p1k[]     = Phase 1 key                          [ 80 bits]
+ *
+ * Note:
+ *     This function only needs to be called every 2**16 packets,
+ *     although in theory it could be called every packet.
+ *
+ **********************************************************************
+ */
 static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 {
 	signed int  i;
@@ -383,30 +383,29 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 	}
 }
 
-
 /*
-**********************************************************************
-* Routine: Phase 2 -- generate RC4KEY, given TK, P1K, IV16
-*
-* Inputs:
-*     tk[]      = Temporal key                         [128 bits]
-*     p1k[]     = Phase 1 output key                   [ 80 bits]
-*     iv16      = low 16 bits of IV counter            [ 16 bits]
-* Output:
-*     rc4key[]  = the key used to encrypt the packet   [128 bits]
-*
-* Note:
-*     The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
-*     across all packets using the same key TK value. Then, for a
-*     given value of TK[], this TKIP48 construction guarantees that
-*     the final RC4KEY value is unique across all packets.
-*
-* Suggested implementation optimization: if PPK[] is "overlaid"
-*     appropriately on RC4KEY[], there is no need for the final
-*     for loop below that copies the PPK[] result into RC4KEY[].
-*
-**********************************************************************
-*/
+ **********************************************************************
+ * Routine: Phase 2 -- generate RC4KEY, given TK, P1K, IV16
+ *
+ * Inputs:
+ *     tk[]      = Temporal key                         [128 bits]
+ *     p1k[]     = Phase 1 output key                   [ 80 bits]
+ *     iv16      = low 16 bits of IV counter            [ 16 bits]
+ * Output:
+ *     rc4key[]  = the key used to encrypt the packet   [128 bits]
+ *
+ * Note:
+ *     The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
+ *     across all packets using the same key TK value. Then, for a
+ *     given value of TK[], this TKIP48 construction guarantees that
+ *     the final RC4KEY value is unique across all packets.
+ *
+ * Suggested implementation optimization: if PPK[] is "overlaid"
+ *     appropriately on RC4KEY[], there is no need for the final
+ *     for loop below that copies the PPK[] result into RC4KEY[].
+ *
+ **********************************************************************
+ */
 static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 {
 	signed int  i;
@@ -1456,7 +1455,7 @@ static void gf_mulx(u8 *pad)
 		pad[AES_BLOCK_SIZE - 1] ^= 0x87;
 }
 
-/**
+/*
  * omac1_aes_128_vector - One-Key CBC MAC (OMAC1) hash with AES-128
  * @key: 128-bit key for the hash operation
  * @num_elem: Number of elements in the data vector
@@ -1530,7 +1529,7 @@ static int omac1_aes_128_vector(u8 *key, size_t num_elem,
 	return 0;
 }
 
-/**
+/*
  * omac1_aes_128 - One-Key CBC MAC (OMAC1) hash with AES-128 (aka AES-CMAC)
  * @key: 128-bit key for the hash operation
  * @data: Data buffer for which a MAC is determined
@@ -1541,7 +1540,8 @@ static int omac1_aes_128_vector(u8 *key, size_t num_elem,
  * This is a mode for using block cipher (AES in this case) for authentication.
  * OMAC1 was standardized with the name CMAC by NIST in a Special Publication
  * (SP) 800-38B.
- * modify for CONFIG_IEEE80211W */
+ * modify for CONFIG_IEEE80211W
+ */
 int omac1_aes_128(u8 *key, u8 *data, size_t data_len, u8 *mac)
 {
 	return omac1_aes_128_vector(key, 1, &data, &data_len, mac);
-- 
2.45.3



Return-Path: <linux-kernel+bounces-510790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F515A321FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0E67A3970
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC1206F2B;
	Wed, 12 Feb 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgbiMLwj"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E402066DC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352187; cv=none; b=CXTH6Ci9d5oZf9H0SmreBzlDzwz+z5rovD/daRhZMH+lbzugj5WMBQFjMSJ1TfND0zoq1FPAkdEDK0K4867oCtoVPEr5AA8+xcaMZZ+cpnW50S5badX+w0m0J61iomqDmM7NzwUBuTqmZE2CfgmECu2yR4TODwd9aBHpjRykF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352187; c=relaxed/simple;
	bh=MURvAg/sBedQVDaqiX8ATHeyU/kkbdU1HxDIqzhOcZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnxZP9eGi6+Y6Gt/UIk3bBTfmA7PhsIPT04Zihz0XT+BLq5iWlPGOge4M5QwFP5OvqZIksVaARPP117oU2L1yAfHofHd2I4XFBV5HmQf3GUeALJTMItsYNoSEY2Vt+frQCnTD3cMvo14DpPXLG/bVs8MhuMIAw0t3SFD7ISRh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgbiMLwj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f7f03d856so67499665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739352185; x=1739956985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgEO1HivjLZosJKcVciMU/JqLrezg/Bp0TI7/JZ0WxI=;
        b=bgbiMLwj+l7IT7NteSPVBBSZNpvUDgx5yoB0ZTPX73KH9DYMwVuGyLNVY6UJlVq48x
         5odXs3wp9RVo7sgH0Olb0XSE9P9x9Gvi8gsYeN4VYAO0Pa+RKRdQXTKMwsw/psJwCp6r
         6Osl7B9gENC/AiMmvVfj0gudznk8+rHQT+yxtls1GRAxg9EEqsWk8lqZk5lQjUJEuN0Y
         oCTVgBGGVh6NLG8FWk9OwTqdtnORkw5MVZezfFb3qnOvvB+1Vp+2MWtRT2LZPR1uwada
         K0NSBvRyWmSI41/T5pn/7TRbZ6RH9TqWVSBNgxeh9Iku6D8ngzW7RRcFBuTY5/GHhYCt
         YiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352185; x=1739956985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgEO1HivjLZosJKcVciMU/JqLrezg/Bp0TI7/JZ0WxI=;
        b=Aum/8ZVqlKWFlrymnH4HruOodr8b42w7LvQoFJ4dEixgHQFkw49uAi0Vyznjw/klF3
         GZNsMr6vGkQ/VxgvOyTN5vlZ9hJ1KyO2cwooGunEMLLqULAH3OooiPtDki7/QI9VAug+
         UqgdjuFVM0H/x1jOcqGGYE2xGu1C2s/Fh23xJ+YCa/llUQ0LRXku5Ank4VjqOZOpUPPT
         77w9wRQ3f9ivqsRX/ocAOu82RdPwW2dzFby0P98O5tn7XjTpuDwcpXHhcPboPRTxUk25
         GN6zWNd4+v/mjZE3pJ3XRzKPs5PvyAael7jJGZfEu4fMfxi5r8dbcs32qk4jjgV9xcZK
         7YpA==
X-Forwarded-Encrypted: i=1; AJvYcCXh5PmCQhFhFBI2KRrkCxX7gGCK5MfO76x1aNT+bYTY6w+fP9YdHmUQbDWCX0xouVlEm0Ti9UHohpSq7hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKczso+1L79U3+rY6g4YwdlLBMjW7LUD+oyuGBjdMvdeeeiorp
	OIwSPMPa2BvelIyeFZZCDl/du2uWzIfoDYOwZaoYlzHVDMjb3xL+
X-Gm-Gg: ASbGnctCGWrVR1Emx5re2xSDXVUQAjY9wZ40SjabJ3wcKHzi7/N34RNPBfNQGT20IEw
	SJVpv4dhEcw8p9nUstDBQxL3mTw9a2NMK1H6qHdXpwy3It24tIXH9f/wKDPC/Ie2ALNRZ7F0nB/
	kRPtQa6fkwOOs0z9IYlS3t+jKszrmXHGMzA65zLejF6GNBQuvMnIC6MUGvh0TYMDoQWgnstpda8
	quI/O4Wp1DOfB08XmZDsZy2hnna+mFKIfRp5R1s3j+Rriwt+OO9KlHvybLvTvzsZwnFq3jCcWke
	e1N3t0Zfl+XChDjrYBrYf92uSibP5s9PasZo/jG1qf+RJ/cybNolqC/9/QdCSJ7AVW0MnUlmMxm
	H
X-Google-Smtp-Source: AGHT+IG1ahvxK+oTK9DbeXMioV1blXV5WcLhl8ADWWvqnSEDFUqzJnKABHHxbLg8LD/6rx9betQF9w==
X-Received: by 2002:a17:90b:2742:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-2fbf5c6ac92mr4543043a91.33.1739352184850;
        Wed, 12 Feb 2025 01:23:04 -0800 (PST)
Received: from DESKTOP-GL3U3CJ (162-207-94-177.lightspeed.irvnca.sbcglobal.net. [162.207.94.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f9b80sm998177a91.38.2025.02.12.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:23:04 -0800 (PST)
From: Ian To <onlyian4981@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ian To <onlyian4981@gmail.com>
Subject: [PATCH v2 3/3] staging: rtl8723bs: remove extra blank lines
Date: Wed, 12 Feb 2025 01:22:56 -0800
Message-ID: <78f3702e2810424d12785f64334127a0f3cd82ef.1739351267.git.onlyian4981@gmail.com>
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

Repeated blank lines were present and removed. Reported by checkpatch.

Signed-off-by: Ian To <onlyian4981@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index e8f583206f92..18f640d48701 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -123,7 +123,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 
 		/* calculate icv and compare the icv */
 		*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
-
 	}
 }
 
@@ -219,10 +218,8 @@ void rtw_secgetmic(struct mic_data *pmicdata, u8 *dst)
 	secmicclear(pmicdata);
 }
 
-
 void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_code, u8 pri)
 {
-
 	struct mic_data	micdata;
 	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
 
@@ -245,7 +242,6 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 	}
 	rtw_secmicappend(&micdata, &priority[0], 4);
 
-
 	rtw_secmicappend(&micdata, data, data_len);
 
 	rtw_secgetmic(&micdata, mic_code);
@@ -305,7 +301,6 @@ static const unsigned short Sbox1[2][256] = {      /* Sbox for hash (can be in R
 	 0x82C3, 0x29B0, 0x5A77, 0x1E11, 0x7BCB, 0xA8FC, 0x6DD6, 0x2C3A,
 	},
 
-
 	{  /* second half of table is unsigned char-reversed version of first! */
 	 0xA5C6, 0x84F8, 0x99EE, 0x8DF6, 0x0DFF, 0xBDD6, 0xB1DE, 0x5491,
 	 0x5060, 0x0302, 0xA9CE, 0x7D56, 0x19E7, 0x62B5, 0xE64D, 0x9AEC,
@@ -480,7 +475,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	/* 4 start to encrypt each fragment */
 	if (pattrib->encrypt == _TKIP_) {
-
 		{
 			if (is_multicast_ether_addr(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
@@ -525,7 +519,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	return res;
 }
 
-
 /* The hlen isn't include the IV */
 u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 {																	/*  exclude ICV */
@@ -627,11 +620,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	return res;
 }
 
-
 /* 3			=====AES related ===== */
 
-
-
 #define MAX_MSG_SIZE	2048
 
 /*****************************/
@@ -664,7 +654,6 @@ static void construct_ctr_preload(u8 *ctr_preload,
 
 static void aes128k128d(u8 *key, u8 *data, u8 *ciphertext);
 
-
 /****************************************/
 /* aes128k128d()                        */
 /* Performs a 128 bit AES encrypt with  */
-- 
2.45.3



Return-Path: <linux-kernel+bounces-297945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ADC95BF81
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AB61C2209F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E191D0488;
	Thu, 22 Aug 2024 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpjFe1aZ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED71BF3A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358463; cv=none; b=d4+BNLghv+EoMeXTQZ3MQkDPLcOPN1ekyzpy+XbrCjol77J2xkHtbDZrnX+3QlA1lJdS8006QOXlWEvUh8/+QWOOStYfZoLYIecfxVjusCN4XuwyQJpcVnY4SeUw3fbiRsz8HvXK8v7r5NhTmpiMbPmMIG8RfcyqqphghY5L+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358463; c=relaxed/simple;
	bh=NlWmjEwwVR5MvLVg70r+w2JPGdKt1+tmyCU3JeooNaM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=eLj0VDnD43oLuUkWy9q2ErXmBTyQE3yyUAbs7t3Xn0IOc6kBjP/n4D8XGkaiBCHRF/Pj8ZP6hPYTMJFuofqJUM+KF2Arohd8+9VsF3Bs7VDtCmFw4rX5F8xHeuzgJDqBcKVn0Pacoa4Bd/MqmjBSpkAZ2yJKgNIF1dxb+iH+Vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpjFe1aZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20230059241so11220005ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358462; x=1724963262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgwgkNZ9d3tHpVJwTEd5s28ymM0oMDBxmCWJifJQBDE=;
        b=KpjFe1aZWlSgRKSmpuhdHnlMFxxk5XttD5OGl2qvsRGXdPiRX+UlKLnkAoplk8fET2
         h0T/DPYMlRie4hvpOIFfnh2IdvrA5Kfu2judFxtwM356/t/PMGTs7fhmOyaVt3WkVgrB
         lgrlbbAL9m0pUuFnuXzbf2Sk3l1ZDUPF5LZkqeanzKo6lgpBRCykS/sHiPwrjlsvvmaj
         QsPVz233D/K+Borr0jFqveNst9Fs5NgkDMbY8r/YGGDpyX8Q67oXaBL3HDaq/KFJCF7e
         tpR7fi8ojBjvqX1GUszA2EzhMtsOm9YFZGJKanwljm6A4xNw5F83Df7a/qRPaoCZa5ND
         CiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358462; x=1724963262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgwgkNZ9d3tHpVJwTEd5s28ymM0oMDBxmCWJifJQBDE=;
        b=F+Lv0ki+NdoFnASQs1T4IcuuE1LrZ2jDhR7GBBpmaCLCurFhEnutiiNqI86/tHn5f4
         hHMSDhuHeu4hzhfAckkIiaHJa1NEaPG3xoQFiQ4dEGGvQlvrig2G3O/ql+ZnoSqqCCpe
         wpW9D2nVSoDh3a3RM2Uje0S6kzhHtqXVQY/Jlgw1iTbjFyN0cE1lMk11GQLCcRqfo/83
         3fRuzM7ZFSGhtGE7/r2x5p1ES99Vddsb0jjP51nsur3dxNAR/4EzakpGMJpsOuqPcKvK
         LFYfNmlPkclMDb3neUuNadfAAq+nobg2jGF97zScv7n3kQdYi2HX6FxATZf6gBlLApjV
         Le7w==
X-Forwarded-Encrypted: i=1; AJvYcCW6bbKGZf8+cwSmDb5T3kGjTSLPzh0cY/3YKUZYzKdVkSXRMsF9L9GShbcaEz1/7yKhopI1aoUAklYkxfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lU3UVUQUkzfmDJBKRxuqkPsyPrtL9LpxZ2GKh/Lz12RZuZ2r
	fWi1sE2mCjYkkot+AbfyDGnVftGCgymbT0Lgk24uE3dhPricnFRXQtYoZr9P
X-Google-Smtp-Source: AGHT+IGwIWOO2z2t7WSEbE9duhKCigo9Wnt8l3LpFkmzUGbkIUMDEhnXh5dcogc9prwkcJedHyHctA==
X-Received: by 2002:a17:902:da8e:b0:202:18de:b419 with SMTP id d9443c01a7336-20388e27f3fmr36357675ad.63.1724358461787;
        Thu, 22 Aug 2024 13:27:41 -0700 (PDT)
Received: from pop-os.. ([2804:14c:73:8181:f583:fcff:5b66:e4be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fc6c26sm16439105ad.297.2024.08.22.13.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:27:41 -0700 (PDT)
From: Ana Carolina Hernandes <anachan.01h@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2] Staging: rtl8192e: Fix arguments alignment
Date: Thu, 22 Aug 2024 17:27:27 -0300
Message-Id: <20240822202727.18882-1-anachan.01h@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the alignment of arguments in function _rtl92e_query_rxphystatus in
order to silence the following checkpatch warning:

CHECK: Lines should not end with a '('

Signed-off-by: Ana Carolina Hernandes <anachan.01h@gmail.com>
---
Changes in v2:
- Put the ')' up one line
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 66e3ae25ad47..b25e83743956 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1145,17 +1145,15 @@ static long _rtl92e_signal_scale_mapping(struct r8192_priv *priv, long currsig)
 			_pdrvinfo->RxRate == DESC90_RATE11M) &&\
 			!_pdrvinfo->RxHT)
 
-static void _rtl92e_query_rxphystatus(
-	struct r8192_priv *priv,
-	struct rtllib_rx_stats *pstats,
-	struct rx_desc  *pdesc,
-	struct rx_fwinfo   *pdrvinfo,
-	struct rtllib_rx_stats *precord_stats,
-	bool bpacket_match_bssid,
-	bool bpacket_toself,
-	bool bPacketBeacon,
-	bool bToSelfBA
-	)
+static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
+				      struct rtllib_rx_stats *pstats,
+				      struct rx_desc  *pdesc,
+				      struct rx_fwinfo   *pdrvinfo,
+				      struct rtllib_rx_stats *precord_stats,
+				      bool bpacket_match_bssid,
+				      bool bpacket_toself,
+				      bool bPacketBeacon,
+				      bool bToSelfBA)
 {
 	struct phy_sts_ofdm_819xpci *pofdm_buf;
 	struct phy_sts_cck_819xpci *pcck_buf;
-- 
2.34.1



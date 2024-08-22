Return-Path: <linux-kernel+bounces-296307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575195A8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8FE1C2208D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F50A933;
	Thu, 22 Aug 2024 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRHf8WR5"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D18BEF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286650; cv=none; b=Zhb/PfWKPXSLiE7vmMLMEJGV/oi0SeNWXPAViAkZUGHpes1xMocm2ntI/BKLbQSWwntO36QKjbvzUSSmSUONKjHiJyYCHy9LjVnaCpFeNj9jPJl8/HoV3m4c0sfpDoRSMiAqEpkOoGxd0ymZ7KvIkZl+5eiZmZUjQPtRQbrSIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286650; c=relaxed/simple;
	bh=J2aU8g4qe+Y8rcEvppQfTwSMn9pHuBRHOVLNGDgiMVY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XY7jXCKUPBnYl6Dki8O+/hRaaID+bqRQiN/E1bNeUrpmAQVeI12ivKeRibGGBtaXh5ngxLQyKlHsDZ4CbAtO1/njW62Kr/AL6HSwd6M/vubQrAsdQU/7oJilWnk1T63BTZefj89gi5kKbqqaJjTvsK1PlweH68tsPM0H192cF+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRHf8WR5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-714261089c1so163822b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286649; x=1724891449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LT23mWzcaHjSiEDWUHOQC5zE07WXnQU2xjGHMC0HRU=;
        b=PRHf8WR5cWpf4miZpJBaA2uWhfGjfmgorctxOHxIQcSXkLwWihHHgOmmIqma9J7UA7
         DMYuCiN+ca/NHar9iXutcW4y+/m2KYm/PSRQKiOObWauYTSSqdv2Z/KGLIUoKt6KoIb+
         47hX9tHXcMjxkvH4lmD8/7PC0/wMtn478q9MlwtL8VupKgNtTK+XDa9KkS4GxMOKkKum
         +uji9UWBpv4123dBEay3KWwBODOooyYTNzPKyDyRaMFybMTNWQpVLCsvq94xpLkRdssC
         o/2EPncXO2nkG0C9SEOghGBd0rczKVU+B7LF8aPba6BbKeRIMKmsw7Nis2HnADl+DK2r
         oVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286649; x=1724891449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LT23mWzcaHjSiEDWUHOQC5zE07WXnQU2xjGHMC0HRU=;
        b=W0iKY4GkxEq84oE+ETlmfOwbtGhA6HDTvOB4VgdijkjiMt8avhghhVDFqdswenV1pJ
         EpP9lmpLIq7hnG/AWdio7Ru/EeQPtVKWmXbtBE5T+GDOeNjUqRq97L0kc5IfPmiTvrrs
         K74RuGogidF6Cy34N7e4iY26v4gX+9mCZH3LT3uQYFPtTrB/GTPxmAgvgsS4pDwT797t
         SZhz1JxFFYATHLxRCcf3jqpusPw8SRm5tR3M8IEQMkzuVi9+hK1SqcmdOaefveziBID5
         jCsPvNBCki31n6x2qW4TgvLXMsyl04cFKNM58Jq38CYbDbXy55NF6EjFyjxlFsdwCYGW
         57cw==
X-Forwarded-Encrypted: i=1; AJvYcCUPtv4aQO64jubexSy/raeUjkebZkNPdvjAWLeN5w2lmGkWQWbSawfXfFjgYKXPrO+ExlIAvwH412t0PmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ROQP4gXYcdlNbQC/eA0K+mQNSlhDVkjbvo0UCeMdtj8HP9xV
	gzTRoILM/UMiO9DiWojf9or6Cgyk4lgUMSD1ZD9orSvGY3frmasLfWTLnhXF
X-Google-Smtp-Source: AGHT+IEQ2Qasb8z2Lvx5Ov1q/Xl81hwXcRxGm9tO2DIEZqdxrFVhn38SOO+Vka+SA7ZbcTfKVuZ9qg==
X-Received: by 2002:aa7:8244:0:b0:710:d294:a2b with SMTP id d2e1a72fcca58-7143176773amr1714120b3a.8.1724286648640;
        Wed, 21 Aug 2024 17:30:48 -0700 (PDT)
Received: from pop-os.. ([2804:14c:73:8181:6ea7:64ff:ab31:e15d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143424a05esm240318b3a.48.2024.08.21.17.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:30:48 -0700 (PDT)
From: Ana Carolina Hernandes <anachan.01h@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] Staging: rtl8192e: Fix arguments alignment
Date: Wed, 21 Aug 2024 21:30:43 -0300
Message-Id: <20240822003043.10865-1-anachan.01h@gmail.com>
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
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b3d4b3394284..bca6e4f57bf2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1145,16 +1145,15 @@ static long _rtl92e_signal_scale_mapping(struct r8192_priv *priv, long currsig)
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
+static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
+				      struct rtllib_rx_stats *pstats,
+				      struct rx_desc  *pdesc,
+				      struct rx_fwinfo   *pdrvinfo,
+				      struct rtllib_rx_stats *precord_stats,
+				      bool bpacket_match_bssid,
+				      bool bpacket_toself,
+				      bool bPacketBeacon,
+				      bool bToSelfBA
 	)
 {
 	struct phy_sts_ofdm_819xpci *pofdm_buf;
-- 
2.34.1



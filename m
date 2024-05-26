Return-Path: <linux-kernel+bounces-189722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EED8CF411
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031E91F21D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB401E57F;
	Sun, 26 May 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxcUNGHc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A03B669
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716722448; cv=none; b=GGzE+q3atu0OtRxktGLNHaIStocYGYxNOqT4M8KBTRRc/506qfRzpg7CjWqRMgWhV48dpJnJ/QbG7rwnUj2n0ZfWG6S0EuVhLwXGEHQZQEC2sYRbDqHGEUM5o+V21nN0S1tWAR3UqXn7/v1X/w2+v5tPs0bNYog3h+yJCzghyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716722448; c=relaxed/simple;
	bh=2KJRg3rxgw4WdUGj6+yaSTtcYpu9GqNWKKviyIlmQEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhoPT9GoVq8lywm5XaqgHAJid8jKd8vHX4gkR+B6sxz8bSxXVuZBqlIrhJJ58xRKHWbSI/wdWTXHt6ARD0lwpETvofbp2FvMEcrIGl8A2jHg3Ege0irtgIFdv69vL8KP0FLlZxiYC/ZYNPvos7nXM7AIFdSVYM/t3/EiHwbzdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxcUNGHc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a62614b9ae1so308936666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 04:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716722445; x=1717327245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IWKpCZ28tVsNAru3OI66zH7hDNq0tpB9AZz0FdEa4s=;
        b=gxcUNGHc4WAv+aPGBy83iM1r8sTfPUFf7W0oli8ZQllmSh6Bs9RBfruYQa2UppZWI2
         H4sAn+8ICIZqeMSZGNmyw+BqQCrqye+nLJXIDehsc8sSdDukKTVwzT5W9ZfFaZcJemB/
         bR0C40Ar5zbdg146TTMyBvMRlhn6uZhv7O0W2OoaLP8Mas9VPXIlN4suzLDDIf1J2lLg
         60FtQK49aR4+eaOyESMlhpngPTdr3ltGHGCdaihMpgHN8mmMH8DBH4Yj9fnPdkeuSCf3
         WZWYegQhzewrwztEMx5+Mo3OWxgJj3L33ivSF8trCmasuTwzO0wjgPBeoGBEuESLTWMy
         +KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716722445; x=1717327245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IWKpCZ28tVsNAru3OI66zH7hDNq0tpB9AZz0FdEa4s=;
        b=bkVrPHLon3eEtelpctEL69+6LL/n/nKsriGIEj8WGgyh7yVvI2HvF690gy+tYYRSky
         htSz77Sq0IxXbC2dZ9IUY25Ek8o5wxq3V7tbSSEz0unUnSl1UdrPHfoLOwB2WfJPb1Ie
         COHIraq0ND1lsdgwWPf37KzMQtHBJX8FHsX8noecgpxF3i2dlqlgBL+u7uApo1N4/kWM
         Vwx5QTvPC4kebDDzlJjToLSlVwTZgN00x8+v9ZgWPUCK+Cmwu0ahOAvCWpdgh/8qhicz
         7tiUzCRuN+u20h1V5AAuCqEXAZr8VJaVeqRq29bUDHrMHJ3Cb03hyOgXCgf77feZfQxv
         xGrg==
X-Forwarded-Encrypted: i=1; AJvYcCV5yRe+ykgPgp9vjEeyBHmjNPTpP7E3uNvkbj+2k3q/Bg0Cf6rLOHIdfV89zTksyks1RC6OT9ga/93e/JcMQwX/PQOJQW0lIstfiO21
X-Gm-Message-State: AOJu0YycwXFbpeEY6Ao2Fmh/5iy+0RBVBERptiyyfDUqtRKcJHQxV28a
	GWo5NO8F3XXGzLdeR+Mr2dN6SXtPXFpdlw/KN/1DkeHg9gVSRrZLXzxbeg==
X-Google-Smtp-Source: AGHT+IGb9pWHY5MwLKWjj4bkOvPj+V1TzZGffzKKFlAOIc2hqsj5ZU1m2qeFlw9/EUo+lBZpSOUVjg==
X-Received: by 2002:a17:907:a19f:b0:a62:2eca:4f15 with SMTP id a640c23a62f3a-a6265128c48mr448892666b.48.1716722444622;
        Sun, 26 May 2024 04:20:44 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e534sm373983366b.170.2024.05.26.04.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 04:20:44 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8192e: remove unnecessary line breaks
Date: Sun, 26 May 2024 13:19:27 +0200
Message-ID: <20240526111928.14574-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240526111928.14574-1-straube.linux@gmail.com>
References: <20240526111928.14574-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove some unnecessary line breaks after '=' and '==' to improve
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 24 ++++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 2fda44c5a412..5392d2daf870 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1392,8 +1392,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 				continue;
 
 			rf_num++;
-			cur_cck_pwdb =
-					dm_rx_path_sel_table.cck_pwdb_sta[i];
+			cur_cck_pwdb = dm_rx_path_sel_table.cck_pwdb_sta[i];
 
 			if (rf_num == 1) {
 				cck_rx_ver2_max_index = i;
@@ -1412,27 +1411,20 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 				}
 			} else {
 				if (cur_cck_pwdb > tmp_cck_max_pwdb) {
-					tmp_cck_sec_pwdb =
-							tmp_cck_max_pwdb;
-					cck_rx_ver2_sec_index =
-							cck_rx_ver2_max_index;
+					tmp_cck_sec_pwdb = tmp_cck_max_pwdb;
+					cck_rx_ver2_sec_index = cck_rx_ver2_max_index;
 					tmp_cck_max_pwdb = cur_cck_pwdb;
 					cck_rx_ver2_max_index = i;
-				} else if (cur_cck_pwdb ==
-						tmp_cck_max_pwdb) {
+				} else if (cur_cck_pwdb == tmp_cck_max_pwdb) {
 					tmp_cck_sec_pwdb = cur_cck_pwdb;
 					cck_rx_ver2_sec_index = i;
 				} else if (PWDB_IN_RANGE) {
 					tmp_cck_sec_pwdb = cur_cck_pwdb;
 					cck_rx_ver2_sec_index = i;
-				} else if (cur_cck_pwdb ==
-						tmp_cck_sec_pwdb) {
-					if (tmp_cck_sec_pwdb ==
-						tmp_cck_min_pwdb) {
-						tmp_cck_sec_pwdb =
-								cur_cck_pwdb;
-						cck_rx_ver2_sec_index =
-								i;
+				} else if (cur_cck_pwdb == tmp_cck_sec_pwdb) {
+					if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb) {
+						tmp_cck_sec_pwdb = cur_cck_pwdb;
+						cck_rx_ver2_sec_index = i;
 					}
 				} else if ((cur_cck_pwdb < tmp_cck_sec_pwdb) &&
 						(cur_cck_pwdb > tmp_cck_min_pwdb)) {
-- 
2.45.1



Return-Path: <linux-kernel+bounces-189721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D1C8CF410
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDD31F21D63
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCD6DF43;
	Sun, 26 May 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS7D0xIS"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0832905
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716722447; cv=none; b=jiV05ZFi826JYWwi9kb4Kc9xcS3a/Bwf/jwsdiHGiTTtI6GhC9PNkd44YEVik0xZxj15i4XOPNs1O/Bvsq2LfdCQNUA9AYgh954DNQKSiirRkzVMn99V4B3YaXudMJUVVee+UB8PApieW9eaqDE6tGx/z4Aefn0fr1a0tNBIZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716722447; c=relaxed/simple;
	bh=4nW91lsMoRhISbgOyFITvMo+Qsc6DiQN/rZt8bOa+/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdW/HeO8QNmc6NdiG9LVBY42KzcCzXjspx8QI6gZ54HBWRvQFV91ZSR1KdGwh+58X14ws8n1RvnDonwLGkeIEfex1j3ykJJmS/wG7iatXeR+wYvmt3TyZve1IViBFJiT9o8BgDlkB/Jyuq7ZzAuNm99QqPt4W6w8695PvKkFeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS7D0xIS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6265d48ec3so246504266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716722444; x=1717327244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syZ0Cd4s3FznpGYw+gPuAARyriAcDeWsVaK2kx6TUGw=;
        b=GS7D0xIS36srUq/KYHzcZI70KqoRg1RP3035hHm/lsIAgD1sP7Db7TZvhVndc+5vjd
         5Uwsy8uUTYT3EolfU6a1ypCJNAK1EXP3va0kgzQz8eqeiX3i/B8RdJ5AS6/7ar3uYR6I
         GV/2lYPNh8JUa1s5L9eAQ72ITftjOJsrEMOnfdVqBqmpSVHFjBI1onehjMoxnD+vPvAR
         eYHL9PZgRdUtnXmm7ey6NdHt1iBKdVqnu00Kx6rXh2ZK1ExhJ9IByXMwcMyz1CUFem9L
         1vGRBft31OmgzGltdO8/axJ+uzCX5YTHM7Z0Ah1Qi5MORQ73IhimtVQG283rBbAH10nT
         bTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716722444; x=1717327244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syZ0Cd4s3FznpGYw+gPuAARyriAcDeWsVaK2kx6TUGw=;
        b=Qk1xPrBtmDHFACLBX8MDaX9Rjl1dkm6n0crbItvcgNQhP5t/WAswcxQ6uZXrCBvflg
         ciw9vbLZbj3wkR3wF2Ek9kkHbJFCbfnAnL8JtYWmun9DiCWG5qR0C0YbsMU5FAc/zCMQ
         zQFTAjsSBHo0ExlAcE0WGYFFCXjUPgYHlCGPOS3hsuaAYcly1y3yBuBPUmCksynl7kxK
         w443z2o9opAkCQw8D9+KbpH9GZDgeg7VHD7/htbB5s4kGWshar926X/axlQZ+bXu9YNM
         mPnI55nI/GrUrM+CGlecnYlMWes3N9kZH3QMHGBfVH2WKx8HWG/Gk6OhT8ypbVdx1/Xz
         yJlg==
X-Forwarded-Encrypted: i=1; AJvYcCWTwVtig2zd1iDJzf1JB50MjoEgwepAWXJbVb9cHWKbPp3Qy51txb3BlzwOKvO9AvGuj9oFkOFolzMtAybW/U/jpzzvp2RiWAtyBoj9
X-Gm-Message-State: AOJu0YxFUZ1DynWm+ySmlTOz5Wm30A38HLTi+ZJYZ4ETUUhBCiOjCGL+
	2XUPDojR2ytCQ/y/rTJ69By+zvDK0VhstfKXbN+NT+enhGZuPwve
X-Google-Smtp-Source: AGHT+IGC7ii5g3GCI9INcE+djtsNq7KWXcdyct1Hk/1N95YMi7CDZgYjH+PyQBKl+G9MfHEBZp4hNw==
X-Received: by 2002:a17:906:c217:b0:a62:2ef9:139 with SMTP id a640c23a62f3a-a6262f5c244mr441785666b.0.1716722444087;
        Sun, 26 May 2024 04:20:44 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e534sm373983366b.170.2024.05.26.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 04:20:43 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8192e: reduce indentation level
Date: Sun, 26 May 2024 13:19:26 +0200
Message-ID: <20240526111928.14574-2-straube.linux@gmail.com>
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

Reduce indentation level in _rtl92e_dm_rx_path_sel_byrssi() by negating
if statements and use continue in for loops. This way the indentation
level of the code that is covered by the if checks can be reduced. This
improves readability and clears two checkpatch warnings.

WARNING: Too many leading tabs - consider code refactoring

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 170 +++++++++++----------
 1 file changed, 86 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index aebe67f1a46d..2fda44c5a412 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1335,51 +1335,52 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	for (i = 0; i < RF90_PATH_MAX; i++) {
 		dm_rx_path_sel_table.rf_rssi[i] = priv->stats.rx_rssi_percentage[i];
 
-		if (priv->brfpath_rxenable[i]) {
-			rf_num++;
-			cur_rf_rssi = dm_rx_path_sel_table.rf_rssi[i];
-
-			if (rf_num == 1) {
-				max_rssi_index = min_rssi_index = sec_rssi_index = i;
-				tmp_max_rssi = tmp_min_rssi = tmp_sec_rssi = cur_rf_rssi;
-			} else if (rf_num == 2) {
-				if (cur_rf_rssi >= tmp_max_rssi) {
-					tmp_max_rssi = cur_rf_rssi;
-					max_rssi_index = i;
-				} else {
-					tmp_sec_rssi = tmp_min_rssi = cur_rf_rssi;
-					sec_rssi_index = min_rssi_index = i;
-				}
+		if (!priv->brfpath_rxenable[i])
+			continue;
+
+		rf_num++;
+		cur_rf_rssi = dm_rx_path_sel_table.rf_rssi[i];
+
+		if (rf_num == 1) {
+			max_rssi_index = min_rssi_index = sec_rssi_index = i;
+			tmp_max_rssi = tmp_min_rssi = tmp_sec_rssi = cur_rf_rssi;
+		} else if (rf_num == 2) {
+			if (cur_rf_rssi >= tmp_max_rssi) {
+				tmp_max_rssi = cur_rf_rssi;
+				max_rssi_index = i;
 			} else {
-				if (cur_rf_rssi > tmp_max_rssi) {
-					tmp_sec_rssi = tmp_max_rssi;
-					sec_rssi_index = max_rssi_index;
-					tmp_max_rssi = cur_rf_rssi;
-					max_rssi_index = i;
-				} else if (cur_rf_rssi == tmp_max_rssi) {
-					tmp_sec_rssi = cur_rf_rssi;
-					sec_rssi_index = i;
-				} else if ((cur_rf_rssi < tmp_max_rssi) &&
-					   (cur_rf_rssi > tmp_sec_rssi)) {
+				tmp_sec_rssi = tmp_min_rssi = cur_rf_rssi;
+				sec_rssi_index = min_rssi_index = i;
+			}
+		} else {
+			if (cur_rf_rssi > tmp_max_rssi) {
+				tmp_sec_rssi = tmp_max_rssi;
+				sec_rssi_index = max_rssi_index;
+				tmp_max_rssi = cur_rf_rssi;
+				max_rssi_index = i;
+			} else if (cur_rf_rssi == tmp_max_rssi) {
+				tmp_sec_rssi = cur_rf_rssi;
+				sec_rssi_index = i;
+			} else if ((cur_rf_rssi < tmp_max_rssi) &&
+					(cur_rf_rssi > tmp_sec_rssi)) {
+				tmp_sec_rssi = cur_rf_rssi;
+				sec_rssi_index = i;
+			} else if (cur_rf_rssi == tmp_sec_rssi) {
+				if (tmp_sec_rssi == tmp_min_rssi) {
 					tmp_sec_rssi = cur_rf_rssi;
 					sec_rssi_index = i;
-				} else if (cur_rf_rssi == tmp_sec_rssi) {
-					if (tmp_sec_rssi == tmp_min_rssi) {
-						tmp_sec_rssi = cur_rf_rssi;
-						sec_rssi_index = i;
-					}
-				} else if ((cur_rf_rssi < tmp_sec_rssi) &&
-					   (cur_rf_rssi > tmp_min_rssi)) {
-					;
-				} else if (cur_rf_rssi == tmp_min_rssi) {
-					if (tmp_sec_rssi == tmp_min_rssi) {
-						tmp_min_rssi = cur_rf_rssi;
-						min_rssi_index = i;
-					}
-				} else if (cur_rf_rssi < tmp_min_rssi) {
+				}
+			} else if ((cur_rf_rssi < tmp_sec_rssi) &&
+					(cur_rf_rssi > tmp_min_rssi)) {
+				;
+			} else if (cur_rf_rssi == tmp_min_rssi) {
+				if (tmp_sec_rssi == tmp_min_rssi) {
 					tmp_min_rssi = cur_rf_rssi;
 					min_rssi_index = i;
 				}
+			} else if (cur_rf_rssi < tmp_min_rssi) {
+				tmp_min_rssi = cur_rf_rssi;
+				min_rssi_index = i;
 			}
 		}
 	}
@@ -1387,59 +1388,60 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	rf_num = 0;
 	if (dm_rx_path_sel_table.cck_method == CCK_Rx_Version_2) {
 		for (i = 0; i < RF90_PATH_MAX; i++) {
-			if (priv->brfpath_rxenable[i]) {
-				rf_num++;
-				cur_cck_pwdb =
-					 dm_rx_path_sel_table.cck_pwdb_sta[i];
+			if (!priv->brfpath_rxenable[i])
+				continue;
 
-				if (rf_num == 1) {
+			rf_num++;
+			cur_cck_pwdb =
+					dm_rx_path_sel_table.cck_pwdb_sta[i];
+
+			if (rf_num == 1) {
+				cck_rx_ver2_max_index = i;
+				cck_rx_ver2_sec_index = i;
+				tmp_cck_max_pwdb = cur_cck_pwdb;
+				tmp_cck_min_pwdb = cur_cck_pwdb;
+				tmp_cck_sec_pwdb = cur_cck_pwdb;
+			} else if (rf_num == 2) {
+				if (cur_cck_pwdb >= tmp_cck_max_pwdb) {
+					tmp_cck_max_pwdb = cur_cck_pwdb;
 					cck_rx_ver2_max_index = i;
+				} else {
+					tmp_cck_sec_pwdb = cur_cck_pwdb;
+					tmp_cck_min_pwdb = cur_cck_pwdb;
 					cck_rx_ver2_sec_index = i;
+				}
+			} else {
+				if (cur_cck_pwdb > tmp_cck_max_pwdb) {
+					tmp_cck_sec_pwdb =
+							tmp_cck_max_pwdb;
+					cck_rx_ver2_sec_index =
+							cck_rx_ver2_max_index;
 					tmp_cck_max_pwdb = cur_cck_pwdb;
-					tmp_cck_min_pwdb = cur_cck_pwdb;
+					cck_rx_ver2_max_index = i;
+				} else if (cur_cck_pwdb ==
+						tmp_cck_max_pwdb) {
 					tmp_cck_sec_pwdb = cur_cck_pwdb;
-				} else if (rf_num == 2) {
-					if (cur_cck_pwdb >= tmp_cck_max_pwdb) {
-						tmp_cck_max_pwdb = cur_cck_pwdb;
-						cck_rx_ver2_max_index = i;
-					} else {
-						tmp_cck_sec_pwdb = cur_cck_pwdb;
-						tmp_cck_min_pwdb = cur_cck_pwdb;
-						cck_rx_ver2_sec_index = i;
-					}
-				} else {
-					if (cur_cck_pwdb > tmp_cck_max_pwdb) {
+					cck_rx_ver2_sec_index = i;
+				} else if (PWDB_IN_RANGE) {
+					tmp_cck_sec_pwdb = cur_cck_pwdb;
+					cck_rx_ver2_sec_index = i;
+				} else if (cur_cck_pwdb ==
+						tmp_cck_sec_pwdb) {
+					if (tmp_cck_sec_pwdb ==
+						tmp_cck_min_pwdb) {
 						tmp_cck_sec_pwdb =
-							 tmp_cck_max_pwdb;
+								cur_cck_pwdb;
 						cck_rx_ver2_sec_index =
-							 cck_rx_ver2_max_index;
-						tmp_cck_max_pwdb = cur_cck_pwdb;
-						cck_rx_ver2_max_index = i;
-					} else if (cur_cck_pwdb ==
-						   tmp_cck_max_pwdb) {
-						tmp_cck_sec_pwdb = cur_cck_pwdb;
-						cck_rx_ver2_sec_index = i;
-					} else if (PWDB_IN_RANGE) {
-						tmp_cck_sec_pwdb = cur_cck_pwdb;
-						cck_rx_ver2_sec_index = i;
-					} else if (cur_cck_pwdb ==
-						   tmp_cck_sec_pwdb) {
-						if (tmp_cck_sec_pwdb ==
-						    tmp_cck_min_pwdb) {
-							tmp_cck_sec_pwdb =
-								 cur_cck_pwdb;
-							cck_rx_ver2_sec_index =
-								 i;
-						}
-					} else if ((cur_cck_pwdb < tmp_cck_sec_pwdb) &&
-						   (cur_cck_pwdb > tmp_cck_min_pwdb)) {
-						;
-					} else if (cur_cck_pwdb == tmp_cck_min_pwdb) {
-						if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb)
-							tmp_cck_min_pwdb = cur_cck_pwdb;
-					} else if (cur_cck_pwdb < tmp_cck_min_pwdb) {
-						tmp_cck_min_pwdb = cur_cck_pwdb;
+								i;
 					}
+				} else if ((cur_cck_pwdb < tmp_cck_sec_pwdb) &&
+						(cur_cck_pwdb > tmp_cck_min_pwdb)) {
+					;
+				} else if (cur_cck_pwdb == tmp_cck_min_pwdb) {
+					if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb)
+						tmp_cck_min_pwdb = cur_cck_pwdb;
+				} else if (cur_cck_pwdb < tmp_cck_min_pwdb) {
+					tmp_cck_min_pwdb = cur_cck_pwdb;
 				}
 			}
 		}
-- 
2.45.1



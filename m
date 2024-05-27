Return-Path: <linux-kernel+bounces-190370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2AE8CFD61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E09C1C211AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA8A13AA45;
	Mon, 27 May 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9NRMtwP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6861224EA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803155; cv=none; b=Tsh6Gtdx+1FKshFFIz220i1xmaoC6mT7pzve+PWeSdMm0QWyHgvlcdWEC2rAcPGIOYeqkk98rfqD3kNZeq7xJmfvGWbJp4+a2OreoOja655a4bqAYv0UzNKSk9DNEPkeBT8UBgjrHL5TrlieURKSBz72MWU1fOldhs+UCrig7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803155; c=relaxed/simple;
	bh=kOTWfpx4J0b/iWSo6jDzUAxf8kyOBBoxftxwS3EXw9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZXmkknwuc0q72tMCHmw6gVVhfIR5GDOZ6kWDkhJxUV3/gFeWs/Wa9v8QjS48bK+kA5RNuEI2WuByaugsKcDgy5VrMe9CNLYMgZPbAwICV+KDT6MMiW3ifY5f37KrsUe4n9Qj/0BeHeQ3vZ3YkEOzg/rwgNrt82uMohT7CG5UAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9NRMtwP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5785e443cf4so2869562a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716803152; x=1717407952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZOP8/F9rHnzuZdAfB6mVQvy+M+VX8KCAQAekWNosyY=;
        b=G9NRMtwPIvL1jD5nYyRftpsKmucHhmQjhH3adMXonAR343Gg7gGn1RPdsKwFXEEa91
         QzxkPY83BP44wcMTHtWENUyUVrRUeI8FpQsq267IGGMvsOvni6oycrYKGuwpf15Cc/rK
         Bj+joWkSI6Aei8JIJulOE4eKHWnQEciWtkhY6Lw6q4YRl9bvd5LjXYEoQ1V9Ff5JEcQf
         vTqyJUIlAe+eE6UCUDvpnn+XAsS/fnPur48fPEpuYiDmYGHujuLQHR+FXEEYCUtFjCBN
         ag/1gcoQboZu4nFxf3aKGmg99GjnE7buwGr3hUpb5mOEX5KXw4N8uejmN4urqNrB/Uty
         GyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803152; x=1717407952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZOP8/F9rHnzuZdAfB6mVQvy+M+VX8KCAQAekWNosyY=;
        b=sPYF5l0cO9Eg5fLn7ExWf/qKY2yseIC/sj8qaEpoXFzwNZ4qKpMhSPhhu3xJ/jgUe1
         O3DKVXuPMsfaEAgOHukYyiTeTzFdee3yJVgWOnAAUMrmSIwPwaJaAKEQ/XiFFtf7f7JZ
         xwPlp7PtqIS3o7CLPMj1sk9IXCjtfuBUQYY9vSUZzxqPhRu+VFCqb1+w4vS3vQ2uNvnp
         ycgFq3eNloK4e4AHbtoaV3wXe2W1cfe/dcQ7lnxlIVcHswLroe1cpWI0+J2/twT2uhhx
         ZMU2ZPuQ9wfd7fEVGQnBIPgU0mKNc3b4UoiYCtzg5Z9DFK8PuhuezW4g0UdbnefR5W3u
         BNJA==
X-Forwarded-Encrypted: i=1; AJvYcCUMj9b+52ENdesO0kg8TbAKLvp8ED58QD0F91mIwootiug2hEiHwHGLDkN2+6MLyNhxK/gFwQYt7kI0gQNwFXEsJQW+nJfS1mesGzqE
X-Gm-Message-State: AOJu0YxTJbL79EDIAOv4YftJMm/Jma2jccKy7E43X0EB/DeKstU4AWmn
	RkVLB5NG/qXmhuhxJDQYv9Yf9BytjwqUU69jj7QWqWPT1eDjngngkp5myA==
X-Google-Smtp-Source: AGHT+IHsbpT71TZR9sImvcRmaf1i8uTQArIk8guJrqh0P2g+p9RYgCKTy+djXXnXbm63Ny+uxDSBvA==
X-Received: by 2002:a50:8d59:0:b0:578:6558:4cb0 with SMTP id 4fb4d7f45d1cf-57865584d45mr3791559a12.33.1716803151747;
        Mon, 27 May 2024 02:45:51 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c6c72ed3sm2304178a12.87.2024.05.27.02.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:45:51 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	namcao@linutronix.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/2] staging: rtl8192e: reduce indentation level
Date: Mon, 27 May 2024 11:45:26 +0200
Message-ID: <20240527094527.2046-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527094527.2046-1-straube.linux@gmail.com>
References: <20240527094527.2046-1-straube.linux@gmail.com>
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
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
v1 -> v2:
Added Nam Cao's reviewed-by tag from v1

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



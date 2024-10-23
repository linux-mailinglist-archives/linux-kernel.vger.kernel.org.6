Return-Path: <linux-kernel+bounces-378990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1389AD853
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE71C21A76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB541FEFC3;
	Wed, 23 Oct 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCqBHbor"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877215B97E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729725122; cv=none; b=f2mh9wufJ9DkYA7KeQoYU/+73/abtYuo2C7DH4HpmYGc/ABBxx3Y0xPmDs48by/HtlutSdXAKTDbv8a6J/nXAGgGJiX7qV+dYWv4GS7ri4gNCNB6QBGk7eJJLDd4GLaZxAeVggdiAMu2KrkqQHXrwNVYQhba+mz9EK5dRJW/+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729725122; c=relaxed/simple;
	bh=52yxQ09WqtOP8XWTM3BCpq4gMiDnmGK4/cPqR1ygOss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WTV+fYPjfpTxFa3I1O5zVGY/2FuQI+oJoydoF1WSFGNVuUycCaHlta4HY3/nnC/HvWvVlhLNHvdriR8PDT8Ornt9buB5+Hhn3A0+6IQWGMpJB1i01aTAmeMOJzn733AUsZ1XKq4wLeBIJDgdeEvhp+QGgOoWEB2V7F2n1cgfWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCqBHbor; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca388d242so1906335ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729725120; x=1730329920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SU8yiz0V0vst08PcfWR+Gq/6ECQ78CI5BJYqXjnM518=;
        b=iCqBHbormpmyGouDk5moFkjgDyHLZ1itI11FhZKPzKjQDkHMVKLO3/c9GRc/jjpHqp
         ZK78bGczdRdswbG4ISYmxaBc+92iOopTS1XUoVjkkQywlXVLq6kwrN4C0QE1ubi/Cm/y
         G7dyIhJXpUM4wvsB8p8UCXq10LvKbKxx01FCtft9fIITAjn/86tGOoH5zxULNclkqaHA
         2kxhj2tn0JAUYlOXg9XSVaAyjnirP5yuDmm3IVpBq29oV1nxizl/g2rVcxIHNxBYR7dv
         UA5oCAn7cPFKXeJJTDQuuN3gC0jdFAFBYjT3R8RkLFDNsn8/hK9tNnUzdUhx8Labc7Hd
         o5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729725120; x=1730329920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SU8yiz0V0vst08PcfWR+Gq/6ECQ78CI5BJYqXjnM518=;
        b=gFdzqdrXpic8gpxcK9fFVaVmgBO+nAnlHDcxrOqCK4PgqlIX4Bbj1mjVUi7LV9HHef
         5qRwRDYg7BCK7Eu+wXG21ROsobcv32KiraBw2ARGjr/5NYC0baWuuAm7EInPmxdwsP0E
         4wRCaH/IWxP27hfJeA4aYvW2oem9wiiG4M1HGw/YzqVsyOTPmwumQGh3Zc8X88xBWlQt
         aWE68LN9tMarerf6sqbBqtcDUF83Qx/zAV7NAVW8J9vbt2eGL4eIGYVEn5YOqu+89c3U
         wqznpraADuIlvxWUmNcsCm68XnhDOJNQxKSJkPrdwD5U951OLjBrj9J4TcpPfiYrcc+i
         +BWw==
X-Forwarded-Encrypted: i=1; AJvYcCVZyIw4M2EeH87UM1qlYkqH+ndQNqv7DSGM0kFtc3VLcTKA3qTw60ZC/1UqgqalD+3d5w+l0le1QREgX3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEda94ye67zBMRiyJPepgEH7clvN9V5D+fswv3FYyN6M6BQGh
	WAF4nGJZ9GZKLY7lZRGCAgNYwEwzH6ee6i+Exavt+gtfMG1gQYuN
X-Google-Smtp-Source: AGHT+IEflSLaad6uyDoEl+X0MW0rMClwemlGqgqmwWEmYqE2G4G794S+5c1kY+WTIzf2CIjykB6Pdg==
X-Received: by 2002:a17:903:32cf:b0:20b:775f:506d with SMTP id d9443c01a7336-20fa9e784f7mr55885225ad.34.1729725119640;
        Wed, 23 Oct 2024 16:11:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:97bb:b4e6:f236:f01a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee65c9sm62508675ad.22.2024.10.23.16.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:11:59 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8723bs: change remaining printk to proper api
Date: Wed, 23 Oct 2024 20:11:55 -0300
Message-Id: <20241023231155.16940-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of TODO file for future work, use dyn debug api for
remaining printk statements.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
I didn't use the netdev_dbg() over drivers/staging/rtl8723bs/hal/hal_com.c
because I noticed now that rtw_dump_raw_rssi_info() and the hal file is a 
little broken with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA, maybe we can 
fix that in a next patch. 

Suggesting to keep the pr_debug() in the hal file for now.

Tks and regards.
---
Changelog
v3 additional changes to netdev_dbg() at rtl8723b_hal_init.c file
v2 https://lore.kernel.org/linux-staging/20241022031825.309568-1-rodrigo.gobbi.7@gmail.com/T/#m4c2796a796d7e5b456975365147c51d7977e9e81
v1 https://lore.kernel.org/lkml/2024101608-daycare-exterior-31fd@gregkh/T/#m1b2b4fdb8a5eec605983c12ca211d394b66cc79f
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  6 +++---
 drivers/staging/rtl8723bs/hal/hal_com.c           |  7 ++++---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 12 ++++++++----
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      |  2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bbdd5fce28a1..ac5066db4e78 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1870,10 +1870,10 @@ unsigned int OnAction_sa_query(struct adapter *padapter, union recv_frame *precv
 	if (0) {
 		int pp;
 
-		printk("pattrib->pktlen = %d =>", pattrib->pkt_len);
+		netdev_dbg(padapter->pnetdev, "pattrib->pktlen = %d =>", pattrib->pkt_len);
 		for (pp = 0; pp < pattrib->pkt_len; pp++)
-			printk(" %02x ", pframe[pp]);
-		printk("\n");
+			pr_cont(" %02x ", pframe[pp]);
+		pr_cont("\n");
 	}
 
 	return _SUCCESS;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index faa6ed2b320d..5994e574ae99 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -909,10 +909,11 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter)
 
 	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
 		if (!isCCKrate) {
-			printk(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
-			psample_pkt_rssi->ofdm_pwr[rf_path], psample_pkt_rssi->ofdm_snr[rf_path]);
+			pr_debug(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
+				 psample_pkt_rssi->ofdm_pwr[rf_path],
+				 psample_pkt_rssi->ofdm_snr[rf_path]);
 		} else {
-			printk("\n");
+			pr_debug("\n");
 		}
 	}
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 46962b003d17..a8ffa219fb2a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -60,7 +60,8 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 	for (i = 0; i < blockCount_p1; i++) {
 		ret = rtw_write32(padapter, (FW_8723B_START_ADDRESS + i * blockSize_p1), *((u32 *)(bufferPtr + i * blockSize_p1)));
 		if (ret == _FAIL) {
-			printk("====>%s %d i:%d\n", __func__, __LINE__, i);
+			netdev_dbg(padapter->pnetdev, "write failed at %s %d, block:%d\n",
+				   __func__, __LINE__, i);
 			goto exit;
 		}
 	}
@@ -83,7 +84,8 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 			ret = rtw_write8(padapter, (FW_8723B_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
 
 			if (ret == _FAIL) {
-				printk("====>%s %d i:%d\n", __func__, __LINE__, i);
+				netdev_dbg(padapter->pnetdev, "write failed at %s %d, block:%d\n",
+					   __func__, __LINE__, i);
 				goto exit;
 			}
 		}
@@ -125,7 +127,8 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 		ret = _PageWrite(padapter, page, bufferPtr+offset, MAX_DLFW_PAGE_SIZE);
 
 		if (ret == _FAIL) {
-			printk("====>%s %d\n", __func__, __LINE__);
+			netdev_dbg(padapter->pnetdev, "page write failed at %s %d\n",
+				   __func__, __LINE__);
 			goto exit;
 		}
 	}
@@ -136,7 +139,8 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 		ret = _PageWrite(padapter, page, bufferPtr+offset, remainSize);
 
 		if (ret == _FAIL) {
-			printk("====>%s %d\n", __func__, __LINE__);
+			netdev_dbg(padapter->pnetdev, "remaining page write failed at %s %d\n",
+				   __func__, __LINE__);
 			goto exit;
 		}
 	}
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index d18fde4e5d6c..b845089e8d8e 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -72,7 +72,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 	err = sdio_claim_irq(func, &sd_sync_int_hdl);
 	if (err) {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
-		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
+		pr_crit("%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
 	} else {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_cnt++;
 		dvobj->irq_alloc = 1;
-- 
2.34.1



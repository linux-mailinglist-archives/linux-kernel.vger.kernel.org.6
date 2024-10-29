Return-Path: <linux-kernel+bounces-387748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A219B559D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B33DB2218F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA5820ADEE;
	Tue, 29 Oct 2024 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td3jXiHP"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195920ADD1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240151; cv=none; b=SnyunuK+aBU6vPJwqmCl5SCioi/8xK5E8t4aMHepZZqhOSaJ4oj2yP3PIbpbD80TCuh/Tn5eLFZdLhOryL2VfHKuNTeDDjwb48eVOSVRLXq3yFEicjjL16vuiXaq9cqMVNFYUsLLiF+nFWCxCMT9Sgb8rz21XvO+hcXpqaorBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240151; c=relaxed/simple;
	bh=dJbjASoif9FFgsaTpGb3upzlwhk4ba+8m28qT0cbYFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cjdpxofP6iFnudWSxjZLkZpwYstY/hNBjFGcVdqZN9+qxgc2VluItzbXOS7zMEjNuwWH6cacDLRtmKikFpb4tpazkX+tZdG7DmhI3YOiLtVQiC9VIph8jB7N2datQw8IaMdLbJ5ayW2SmBgvJaQ7YksPfs2F5Wg48OGWcaybQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Td3jXiHP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71ec997ad06so4346426b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730240149; x=1730844949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiQ9umpLp8PmqXW0LJaiGwFuDWWJXxc3XptWFETDc2o=;
        b=Td3jXiHPedz0HjAR50/VFltDsz6oRMjGsRRD1KQbGXuiPXVHzoyV4GGPN7r90T27xy
         HJ6CpfmhKdfzbwXDgDXzqz/TZDih/qXiuqx/DtYeU216g7tb5tmbSgVC53Rf8szoV9Xz
         e0WmCOw8wSlnb6pNr4JieUmOMGGn1rYFVNsTPpangyyavmGhjfxxtZYNbutbPB5U5DMp
         2Ru/vthos9Glz4IsSnadxO1bzWDyMPKrpeJbIOjduEW/I6oYh0Pk8iWqaiOtxpy6kODz
         yfiLzGUU/SQqiCCABt6dY9PC09SdJ/y5yYkMTpHSgBczLpYj5gEeXhNWo9I3TNt21f42
         rFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730240149; x=1730844949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiQ9umpLp8PmqXW0LJaiGwFuDWWJXxc3XptWFETDc2o=;
        b=kwNUcn8QmRJeO29Lkv4ATylVmb6+yTCw29FmvSA27/A5zaOxd/2RIuyjvg4AeqkA8t
         casL/WmfL6DNBCAVe42vUGWmWZmjtatLP906Exw6iXCd0b35S95r+3U+LXBvknrobKgX
         q3LP1Xf1GTEJqji/CBf8fNFG+si1E2/iXIOVQeMOnydslo+UY2qn185X13+S68bmp9Q/
         mTPVFj170xXL2hiK7kePGX3dSRPyWI6PUPx3ehE7eNaw8Pzbjsmw+EC3Xo3xTykUrc5b
         8kozMsWCZ9/GB2qkSvyg0yWYKCIntj5IkU1zi/PSjy/iZwiYX1Tce0q8O2twtnsjvQ+Z
         KYrw==
X-Forwarded-Encrypted: i=1; AJvYcCVnwFaV/UPs2I0at+IWKzSwSUougbvfxW3WOb+wMjgnro3fIl+AJ/TXS2ztltL2skgffjnfPOspQYI+PfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAeKcP3m1JAaHlwJJWH+FgYiQCOksg0YsI21pdMKLLrPPXVEH
	oRL37BLQlx4cIaSps9Z4Axxr6uyLeq43WmGq0ZxQWIqOWnp7QXYI
X-Google-Smtp-Source: AGHT+IGAXDu33VSy6AmpYrrmbRN+KUjIPi5AXD52xVLWdJ732bmlPlpjGTmoutGCH6nNYRDxU9SfBw==
X-Received: by 2002:a05:6a00:1809:b0:71e:6bf1:158f with SMTP id d2e1a72fcca58-720ab492bf1mr1534141b3a.21.1730240148953;
        Tue, 29 Oct 2024 15:15:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:768d:7e1:4b86:da7d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e451sm8083744b3a.24.2024.10.29.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 15:15:48 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: rtl8723bs: change remaining printk to proper api
Date: Tue, 29 Oct 2024 19:15:44 -0300
Message-Id: <20241029221544.112800-1-rodrigo.gobbi.7@gmail.com>
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
The previous discussion about broken code with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA and
a unused function will be submitted in future patches.
Tks and regards.
---
Changelog
v4 a few more replacements/remove debug line as suggested;
v3 https://lore.kernel.org/linux-staging/f61d8272-4af3-40d6-a333-e7731c3fc5ae@stanley.mountain/T/#med344b7d344044851e1c96d498512c907d8be0ab
v2 https://lore.kernel.org/linux-staging/20241022031825.309568-1-rodrigo.gobbi.7@gmail.com/T/#m4c2796a796d7e5b456975365147c51d7977e9e81
v1 https://lore.kernel.org/lkml/2024101608-daycare-exterior-31fd@gregkh/T/#m1b2b4fdb8a5eec605983c12ca211d394b66cc79f
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  6 +++---
 drivers/staging/rtl8723bs/hal/hal_com.c           |  7 +++----
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 12 ++++++++----
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

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
index faa6ed2b320d..ed391ee16e4a 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -909,10 +909,9 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter)
 
 	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
 		if (!isCCKrate) {
-			printk(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
-			psample_pkt_rssi->ofdm_pwr[rf_path], psample_pkt_rssi->ofdm_snr[rf_path]);
-		} else {
-			printk("\n");
+			netdev_dbg(padapter->pnetdev, ", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
+				   psample_pkt_rssi->ofdm_pwr[rf_path],
+				   psample_pkt_rssi->ofdm_snr[rf_path]);
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
index d18fde4e5d6c..76801a2d1cb3 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -72,7 +72,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 	err = sdio_claim_irq(func, &sd_sync_int_hdl);
 	if (err) {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
-		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
+		netdev_crit(dvobj->if1->pnetdev, "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
 	} else {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_cnt++;
 		dvobj->irq_alloc = 1;
-- 
2.34.1



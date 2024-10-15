Return-Path: <linux-kernel+bounces-364980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1242E99DBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B541C217DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0F7157A48;
	Tue, 15 Oct 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2jnu2U3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD014A4DF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956870; cv=none; b=IaWujyzQPafNIihMAdEwJm6FbmpSJP7x6imQ7A04psypT4VRIBnpbDuIBN5zCnc3AOKZT0384uN+kk/LzLKk3svjKxT5ouCYXQ1FT4ShrpWLwfY94LIfmS2g05P/Ubo972a/Vj7RMWiR2woECJLO+CecYB3+9HG6FeehREBf6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956870; c=relaxed/simple;
	bh=5BdIiRgeOL39dpV6SihL1KVsI1+Y8kNOVttd/LOWzSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sTven2SKBlXHuNh5lY+WSziMBJAD2V3Cg0hKg/Hj8UwF5gzevkXt2ettB2MNFlmduNsSgo/VnOzcstApVqiWehyONPsvQTxuNCng0YDyjBrMbfyQLMrwxd+4dDfq76fI/2p1bHXyqTZXGzy6vvYfXW3u2vAZ6GSYQLVB9bYVjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2jnu2U3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c714cd9c8so37119385ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956868; x=1729561668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5is7VaCws6e/Au/1m2Z1UhAmmcER8bL2lqoXJbsp/hU=;
        b=T2jnu2U3OcJONAjagChqjdj2CUNBCM/78mmfIW0WEJUBfvQUKLCbWKwOLGHai14BR0
         cOuUG7O50aNosM6ii01rd9f+9xLbFbkqcfMuRqZpx9SrfuaDaLIy9lJ+8nOcMvtN/fTk
         pZ+XAjMT9h8yX+n8Z96GwD6hC/k+5NQtY+2zw6slNPzAZPGynDe8Z4stYnVNtPTErI5d
         49V5Yg6lBw3i3dKYMuWZzeWSv1dL4LCuLTuaaXwmqFAKaDGR6FzxRj+LGtlpkx3rofJq
         yZUafkOUV18ZIgyBoDabF+H6vyxSL+ba8w9iAhsl+7ap4+EiM6GLtR7/cC4+DJmTaYww
         JtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956868; x=1729561668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5is7VaCws6e/Au/1m2Z1UhAmmcER8bL2lqoXJbsp/hU=;
        b=UHkoyM7k7x/27u2JAlZRop0z/kItllBvmaacER75oLyPSHqhZdG8w+jjoxqFs31Wxp
         bkUhrWfU+hRxtDucfw+f/HkhZGB5iY6jRGUrbHfldEUd7QiXmdwuCrQJj1xvCaoSs51Q
         ipHdAxTuJwvFTq8nbJRFmWDtd6K1dn0/FQedUK5WizAhY9E6WRN/+w/cnqVahTn6o7TF
         5YLSNidzfkYgiPwgvvQ1IJ6OmS9ggkuB+kzu2yo24SIgy1Jhb/D3ESd01iIMCl3OifFW
         RzuSgDb36hPsFSUz8eglHf2QFrkx2tFX9WJRQoAsajEHqC6I1TLVTWjbLLtuf2edoXQB
         ZmpA==
X-Forwarded-Encrypted: i=1; AJvYcCW43FandeKSN+nMsa7vg6MpduHcNoUvg6noKT72YzjPNka6ssj2tFe5hQdd2zC3cO4Izf5JfUPDUVKu+VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMutIVo+P69rZe72q0BOnLHAFMrBILjRWkeSENbssZl6WPS5do
	cvWRGd6bYYnWX7BbRgeiQf50siKOlLAGmjLVLbmlHYpIzgLkTswv
X-Google-Smtp-Source: AGHT+IEOYa3emi5du9D+64uvhNuIhET+MlLY0rZewtyWdoaLOzkrcYTsPfcOHwelSUWOvPYyU9YB4g==
X-Received: by 2002:a17:902:f70f:b0:20b:3f70:2e05 with SMTP id d9443c01a7336-20cbb230588mr151359605ad.41.1728956867753;
        Mon, 14 Oct 2024 18:47:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4e84:7ad0:3bea:5c55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036251sm1863615ad.172.2024.10.14.18.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:47:47 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: change remaining printk to proper api
Date: Mon, 14 Oct 2024 22:47:37 -0300
Message-Id: <20241015014738.41685-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015014738.41685-1-rodrigo.gobbi.7@gmail.com>
References: <20241015014738.41685-1-rodrigo.gobbi.7@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  6 +++---
 drivers/staging/rtl8723bs/hal/hal_com.c           |  7 ++++---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 10 ++++++----
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      |  2 +-
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bbdd5fce28a1..58da34f125db 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1870,10 +1870,10 @@ unsigned int OnAction_sa_query(struct adapter *padapter, union recv_frame *precv
 	if (0) {
 		int pp;
 
-		printk("pattrib->pktlen = %d =>", pattrib->pkt_len);
+		pr_debug("pattrib->pktlen = %d =>", pattrib->pkt_len);
 		for (pp = 0; pp < pattrib->pkt_len; pp++)
-			printk(" %02x ", pframe[pp]);
-		printk("\n");
+			pr_debug(" %02x ", pframe[pp]);
+		pr_debug("\n");
 	}
 
 	return _SUCCESS;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 719dd116d807..484e0b4e489f 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -910,10 +910,11 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter)
 
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
index 37ebbbf408ec..b9c6cd1f80d6 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -62,7 +62,8 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 	for (i = 0; i < blockCount_p1; i++) {
 		ret = rtw_write32(padapter, (FW_8723B_START_ADDRESS + i * blockSize_p1), *((u32 *)(bufferPtr + i * blockSize_p1)));
 		if (ret == _FAIL) {
-			printk("====>%s %d i:%d\n", __func__, __LINE__, i);
+			pr_debug("write failed at %s %d, block:%d\n",
+				 __func__, __LINE__, i);
 			goto exit;
 		}
 	}
@@ -85,7 +86,8 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 			ret = rtw_write8(padapter, (FW_8723B_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
 
 			if (ret == _FAIL) {
-				printk("====>%s %d i:%d\n", __func__, __LINE__, i);
+				pr_debug("write failed at %s %d, block:%d\n",
+					 __func__, __LINE__, i);
 				goto exit;
 			}
 		}
@@ -127,7 +129,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 		ret = _PageWrite(padapter, page, bufferPtr+offset, MAX_DLFW_PAGE_SIZE);
 
 		if (ret == _FAIL) {
-			printk("====>%s %d\n", __func__, __LINE__);
+			pr_debug("page write failed at %s %d\n", __func__, __LINE__);
 			goto exit;
 		}
 	}
@@ -138,7 +140,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 		ret = _PageWrite(padapter, page, bufferPtr+offset, remainSize);
 
 		if (ret == _FAIL) {
-			printk("====>%s %d\n", __func__, __LINE__);
+			pr_debug("remaining page write failed at %s %d\n", __func__, __LINE__);
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



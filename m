Return-Path: <linux-kernel+bounces-375519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8569A96F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4623B1F27021
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB301514F6;
	Tue, 22 Oct 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZhW5r3q"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44614AD29
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567114; cv=none; b=TNlpV7O/x1veHlsAjSrjY6tOpYFBJw/6uKJi5ItC2oME/ry0m+T3HzSGu7pxdgQugGTwnCv5Oacmh4EnH/rFfcQj5aTTKVgeZrYaAJ68YfD1XkA9BhDgdv5EKEvCea98eG/ijeG/C7UKTUIN7NFGICsCiFKI4lt3d8UvI3HZwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567114; c=relaxed/simple;
	bh=piiT3/ZrzB5kUZ5PWGGdD6yCr5n/TgxwLnoCW/Q1rUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eXLM9gSOA5KFIvawBoYRxPJhi9e2JQxqWxwIj+yzIIn6v2nPTpPWOJ7PJ02QfP4xKtJ1wHDTQcDp1ys7K5ULCFxQhAst9NLOy7FBImqcRL25BSoEUXeLD79k6X9FQnayGrFZd4/LwEYrIoGZPlTZfUw54BtrYAY29U1rIaQ0Rgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZhW5r3q; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ebc05007daso1035539eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729567111; x=1730171911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PpvP7zEl37kj9+P4oZi03XEw8plpvagkd3AZereKUhI=;
        b=QZhW5r3qwuIqQjoI8N7atXiYFp1mnrvKkITlk/EWx0nEHI60IsdmOqLROdvFJPL1/p
         0VEIaAcI82qANb3wGW897t65Blc8FifDFbRESzX6Cmu1v/swmkSvt0yNPAq/KEPvhPTn
         WhI9cEwxJbCDd5xPlxHB1eEOUOJUuy01YuF3IkWjln1iL/LeLCBtPBK3LGGeKkOWi69J
         qJjWW3z7CihhgGLioC9h6FC1C00IPxRxIwuUAKbRleWCdT20704OqLZjdb4jE5O4syzh
         9y0UO7RJKmLDTkLgHIJGpxRJtEB7JOrZAwBdGu5w2+ZR3x27PfpMsyR4/l062lk5CFV1
         5xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567111; x=1730171911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpvP7zEl37kj9+P4oZi03XEw8plpvagkd3AZereKUhI=;
        b=D/mCuCyyxVdHudpUN+ufIeJEceJ/SGcCvF2ffj0IlYWzATgH0Z3XsPKED9EjfDvTuP
         aH53W+htEl8e/66qis3YEJaK1uqa/0MjXO7vV111bvTvClEQNwMqJVMeJAvc97ANcgLq
         qRAZIDKCxu3NvK8ws7D2PMQHaGC6w7HulKG7QfahE04s2En+qUKhOXe1kJQZqa5q37I9
         Xx0oVP/LYmSKo8TToz4xbU1Sii3DZX6f84d00A6cnorvGMCJVo3z0u+oxTtslkyQ3uqa
         9S3F8AJ+S9QeW1BMfBfgZWjkg4ghn5TB+z5HAqSTiW5Ez8//tQ0KxRRh5SfUHkco0FiV
         BWeg==
X-Forwarded-Encrypted: i=1; AJvYcCWqANjgGBc42lKkERDffJw5a5PTDwyDdjVbMfUaPvG2fmFtyRascBoa/eol7xu9m1318qqRidXrK5TxnII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeYvVpPqVw4QGeBMRgL22X1nPsB9U5BVjiK191tSlTTIDfHb1o
	IYiU34vJd/cYCmOjhS1x6kxsbHEyhepurP3Cg40c5FBoGBm3seVo
X-Google-Smtp-Source: AGHT+IHRARnXlUYm0a6dO5U70EwEFqfTyg84VdL67yKHg5b9VrgETNF7ciOBGfx8SjugH/wgS9y1Xw==
X-Received: by 2002:a05:6870:41cc:b0:277:df58:1647 with SMTP id 586e51a60fabf-28cb00ff15emr1008772fac.35.1729567111362;
        Mon, 21 Oct 2024 20:18:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:bc18:8647:da38:8192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaebd061c1sm3170652a12.19.2024.10.21.20.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 20:18:30 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: change remaining printk to proper api
Date: Tue, 22 Oct 2024 00:18:25 -0300
Message-Id: <20241022031825.309568-1-rodrigo.gobbi.7@gmail.com>
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
v2 change to netdev_dbg() as Dan and Greg pointed at rtw_mlme_ext.c file
v1 https://lore.kernel.org/lkml/2024101608-daycare-exterior-31fd@gregkh/T/#m1b2b4fdb8a5eec605983c12ca211d394b66cc79f
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  6 +++---
 drivers/staging/rtl8723bs/hal/hal_com.c           |  7 ++++---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 10 ++++++----
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      |  2 +-
 4 files changed, 14 insertions(+), 11 deletions(-)

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



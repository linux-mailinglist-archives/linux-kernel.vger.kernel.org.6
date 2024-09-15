Return-Path: <linux-kernel+bounces-329694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD19794C5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B152839CD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517A836130;
	Sun, 15 Sep 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQWdpy1A"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81FF2232A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382462; cv=none; b=pZmupWywv7TDyc21DKg7nIY5ny7k0vLqV9exS0UHcDLV/6pnnvcRdfw4fFarirG7ilWR0I8plUKp7aBFE8YV7ng+epBx/OVd9RayP27zupU8EJeD7OAu4ktNZ3/baR9FcS5dzpjBeJXo3+sISdyStqOHNx5NVDqSf0bpAFVLXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382462; c=relaxed/simple;
	bh=L4ckoOgEcriXUQL/QwBl2nPhAj6DntXw9Idi22OGWEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXnzjvlzQCGYC5INFonS/U4VQHSpoa33pws6cmrniF+ZuU6O9C0MiekdVnxhXWH7pvQPTHYk7yHW3ImGMgDkhZT7Q2M1wLu+sMy61toRT9+Jg1PI/Uoopp17hxjDwOZEfqk/BWJShNb5usGWre/yRndn+ipbCtkObMKMyXwexqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQWdpy1A; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso504166466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382459; x=1726987259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4ZygK0P53MPJenBWV9IM3wiIoWtojdoXnHHdWub24s=;
        b=gQWdpy1ALWRLjyQB/2eDJD4TcupmaDlCPPd+7f9iYI4Y3A2fx5tkaN5bVwhQN/sYf6
         vAX7lcERfWRakUKRZZRJc41a6R+BpV17iJnJKlMHNn0LN3sLw9/6mw9+Eaw0uXCX87me
         8N/xBSQXk5Eg3TksYEhv+M+/g5RX8WeLu9LOxTKM3Ma1g2y5CbAlyrtEx1wRATL15nPT
         LVFKAaTN8yRerP8zDEmYOey9jnn+j9kzAf8/17RL3ny3WuPDmPjWihpcETcSfKRDpCzJ
         MrSlMEA8M6yyjcwOGWWse9hOLhVMaFzrYXxdmXapYYfEhNOsnRDEor0U/U1ob3rM0xdE
         wGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382459; x=1726987259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ZygK0P53MPJenBWV9IM3wiIoWtojdoXnHHdWub24s=;
        b=Qo/beyl9nYma83o5fWi4M7rHGPN8py90jnzJF1ufd5uuPjPonUvvXv5BdIp/ljnAbW
         PIY2rHJUapSEmDoH4Oaw87nkgslUXwoRVpdt/jJFtvVRm4lsWZcKVDUpgntl93nKL5Pb
         gITA0YvwMAjxhJvNgRogsxFU4GCyYQ3kDXu961ReU2nbKwBwOLWsbIgv0PqDoOro81tp
         Qsg4OLryx8jwd/WgT1eB7xBDcM7KkEoj5MjGNHu8IRAZG8wXuf2AG0SCForEJmQeky7q
         oxtCma2wR2J6Y/hp/1uTsLXPQJyoSADixmd1C0JKTmOnb7pdxy4pOHB1kKYj1V8hUW4e
         0Dhg==
X-Forwarded-Encrypted: i=1; AJvYcCV4nE9UmYWU0P8O8/tN/nzR1y+WcfWuJtMqbk4cStDSpvWWwZDqfoPG5BeKna52CJKZHcv09bqiPGV2QIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZ/PgjdOzMWsxrEjkQu46wFtD0kyhSPQ6xJgWoL+q/6xyXTjr
	KsDAktZQ+yQ8YCEMgJ8UTcP4ENrxBWWiWUITibuqOzuMGQPBt8eZ
X-Google-Smtp-Source: AGHT+IG+uxlo7sFJ2vaJ7TVX2coDVGQhTxMRdW6BBaBH6eaD1KrSN6tp27pyrtkLpdwgT042uKGnkg==
X-Received: by 2002:a17:906:7951:b0:a8d:481a:563a with SMTP id a640c23a62f3a-a8ffae040c5mr1829070466b.25.1726382459156;
        Sat, 14 Sep 2024 23:40:59 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:40:58 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 03/17] staging: rtl8723bs: Remove unused function read_cam
Date: Sun, 15 Sep 2024 08:38:17 +0200
Message-ID: <a4d6cce804f23d4ac8267a572d168356bc7e84ed.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function read_cam.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 13 -------------
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index cd62ea47577c..85215838a004 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -460,19 +460,6 @@ static u32 _ReadCAM(struct adapter *padapter, u32 addr)
 	return rtw_read32(padapter, REG_CAMREAD);
 }
 
-void read_cam(struct adapter *padapter, u8 entry, u8 *get_key)
-{
-	u32 j, addr, cmd;
-
-	addr = entry << 3;
-
-	for (j = 0; j < 6; j++) {
-		cmd = _ReadCAM(padapter, addr+j);
-		if (j > 1) /* get key from cam */
-			memcpy(get_key+(j-2)*4, &cmd, 4);
-	}
-}
-
 void _write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 {
 	unsigned int i, val, addr;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 82709ffc7bad..ba39435d1a10 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -459,8 +459,6 @@ void r8723bs_select_channel(struct adapter *padapter, unsigned char channel);
 
 unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval);
 
-void read_cam(struct adapter *padapter, u8 entry, u8 *get_key);
-
 /* modify HW only */
 void _write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key);
 void _clear_cam_entry(struct adapter *padapter, u8 entry);
-- 
2.43.0



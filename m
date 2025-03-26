Return-Path: <linux-kernel+bounces-576664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AEA712B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E5C16A694
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9FF19E97B;
	Wed, 26 Mar 2025 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS/wRei8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3219F495
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978025; cv=none; b=SJxGMs/xgxtJzGFRaD3/gATfAWHctyDa2WPXUWEe1+QbmDJX/kOXtxg6b5B+EP5wYpGBb1X+/TKspFX14/CiITvXXIRxE1oHRd+4FpkHbLqkHMpLaSoIKThKGmNx1T45x7cKIA9aPvqoXD66e4gUpHjXFNCTh6GJeNLMjs2Uh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978025; c=relaxed/simple;
	bh=tSAgIjlp/S8IO9PaQ5b+0zUYrJ8/WKz17TC1D3LY5EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siio6WBwLiCCFqZKvj9DHYf9qAKM+wpEn962Y5Tz47nLm8tWI2atPVbZnATvxY9hDWflO85+LcAUBTfDz+pqDYPVyKR6No4cwmFIaR/amdKuki2peoiMbzznhafjXNn4Yshf2PRie8liUd2INidh+N5ER5v6WIr0mVjaLNloiT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS/wRei8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso67778195e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742978022; x=1743582822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YptWzLRWN4G8T9PEhf+CbTz6L757zfOcWe1gCHHyMUU=;
        b=SS/wRei8IT6jPj/y0o8SoL+JDBzR/0jJTi6jx6Dmwi3ATub/6oxuUzF61kt0zPyYrC
         Ec0k6atIOCuXWmxt6DseG+i5dR5jJKemvI5ghLgOVG7jD/pBL69aDs0BqHMStL5KiM9p
         Y1tMWvgy1kWu8WrKCxdPFoF1Wa/J4joA7xwGcMZq/A1WU0Q2HtX2EjH4CKZgWbW0hj5a
         ruKctQ8xRmkmCA5MTr8DY6EZLtFouwFn8sOjqi0cPG2hqIbOjbCck9c1rFEhg+152Oh/
         qqeBYmZAgpwK5w2k7+80d1T1Sl0A3CL6eTqIV0d2cDXZhmJOHUwieEbxMuG6XOnngEpe
         IEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742978022; x=1743582822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YptWzLRWN4G8T9PEhf+CbTz6L757zfOcWe1gCHHyMUU=;
        b=bC2dGQ9YhlOtfX1erT6de5Wb6vuB3y0depBTxmPO5VKLCOGiWc9JxhSdgyrFye1ljU
         3NQ3x85Kfa8g5226jrnMOb1gq6BNJ1ptXABiAnOT2Pv/EmEklO2tmYUJeEM3v5AWhPoO
         nRgCmazi1dvNPnzjr/XBs6aHAOqDSGbieHueDTfFmC/mJJ8bM0IzvKhYH9E61JwyQ6Wm
         0IgqcEdlwIkpfP1In+YQS0nk6IL0pFf5IYZT4ztsGuex6s7/b14sOs5NMaZemXQl22fG
         DJyao6wAmj8r119prA1pFHjVw67eV/lvm4IUEyDQEOake5IjusojOam2CPfn14GFxVO+
         V/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfi184Mj4/xTLIFA2tb2Uu+wzkJSncKgm+miidj3QyCxiOOlXbzrAnHHROQXMya2t3toUIKNbyuFYo9po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxzIC1ff7qbuF3shY3UPL0wQ9dojya/RpuXne/LPqdrGOXNJa
	shsOpNOFoYy9wMqDPP5ctA+5pmX5Kd8hlcrhtXoOwdCx29/q8MRj
X-Gm-Gg: ASbGnctLuaGiOLWdfFRA+AuDJ5toA6JdBqVM2+TcMt8fE6ncdwRm8sydxSedieIkZXF
	pPQ4LO8pes5iR//4KfXMLa1zU8uRRE9eYagmrGZG48/4LhQcwZ4ToaBYKQUCkH3LUlcrK/j6ys5
	nV+QlWJFCdRorDyNCPuWA0MNJg3FgYKDCrAHmVvqZk+thSKOyMOKq75cHMMT6ySLYbWaMx17iiq
	yfKU42XidBFBe4zItkA8Gg3H9WHQFWmeW3VkWm8dwTd7ht6K1J/yIh3YDwOnn6iiv3lNiLWj8zP
	thzUg2WXc/0Ew3+rcqyw5wCllKsZqWHHminuZNWPWQ==
X-Google-Smtp-Source: AGHT+IFGR/5N32FLuT/8q9nzuTHqx03EQhMHCz+C23JuTo7WP+ktMehZeb/v3x+H/xZ8eWy3VAzBew==
X-Received: by 2002:a05:600c:1d92:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-43d509e3881mr195372595e9.6.1742978021600;
        Wed, 26 Mar 2025 01:33:41 -0700 (PDT)
Received: from pc.. ([197.155.71.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f332adsm227297175e9.3.2025.03.26.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:33:41 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: karanja99erick@gmail.com,
	philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: rtl8723bs: Rename variables
Date: Wed, 26 Mar 2025 11:33:34 +0300
Message-ID: <20250326083334.13030-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the variable `mediaStatus` to `media_status` and variable
`lpsVal` to `lps_val` to adhere to Linux kernel coding
standards by using snake_case instead of CamelCase.

Fixes checkpatch.pl warning:
	CHECK: Avoid CamelCase: <mediaStatus>
	CHECK: Avoid CamelCase: <lpsVal>

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

changes in v4:
  reverted double blank line changes committed earier ensuring
  my patch contains uniform changes.
---
 drivers/staging/rtl8723bs/core/rtw_btcoex.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
index d54095f50113..f4b19ef7b341 100644
--- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
+++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
@@ -8,14 +8,14 @@
 #include <rtw_btcoex.h>
 #include <hal_btcoex.h>
 
-void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStatus)
+void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 media_status)
 {
-	if ((mediaStatus == RT_MEDIA_CONNECT)
+	if ((media_status == RT_MEDIA_CONNECT)
 		&& (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true)) {
 		rtw_hal_set_hwreg(padapter, HW_VAR_DL_RSVD_PAGE, NULL);
 	}
 
-	hal_btcoex_MediaStatusNotify(padapter, mediaStatus);
+	hal_btcoex_MediaStatusNotify(padapter, media_status);
 }
 
 void rtw_btcoex_HaltNotify(struct adapter *padapter)
@@ -52,14 +52,14 @@ void rtw_btcoex_RejectApAggregatedPacket(struct adapter *padapter, u8 enable)
 void rtw_btcoex_LPS_Enter(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv;
-	u8 lpsVal;
+	u8 lps_val;
 
 
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	pwrpriv->bpower_saving = true;
-	lpsVal = hal_btcoex_LpsVal(padapter);
-	rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lpsVal, "BTCOEX");
+	lps_val = hal_btcoex_LpsVal(padapter);
+	rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lps_val, "BTCOEX");
 }
 
 void rtw_btcoex_LPS_Leave(struct adapter *padapter)
-- 
2.43.0



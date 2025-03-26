Return-Path: <linux-kernel+bounces-577035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE015A7178B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF5A176F86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4911EA7E5;
	Wed, 26 Mar 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COuhkU8y"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEE91E833C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995628; cv=none; b=NVbRkMzuNP2SGNk7Ez7YQfTEdKeZW10BGGR7jdpHUjNyosUJP7S7U4KEcCuwEMYiWvnM721zmdhqAcjetmSA16hB8+Rp35K/Psj1TpMWUf8Wvp+9PDH+U7kUsOOhiVKhYAlMtFuGGz4RhdZgNaehi84uqOPDpJsLbidqTspQ6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995628; c=relaxed/simple;
	bh=nt8iBmq1U2sZ+dsDy+fiGojzVAB4//DaknXjZ9aDNpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1hB26OL3P745113x0k0b37i9OBa2enVjzncqzwP74UU68IBPBcD6BTW5oqBkUrNpeMzIP9rqNGl5Xu61//dXxADmx9thJJo2Styhsr42AAG4082N3/+DszfxkeGCh9AitL3qMicLd97FNagJmBUXWOxt5GbMOU7UmX95R2XI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COuhkU8y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3914a5def6bso4008995f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742995624; x=1743600424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcjtkRmZu75V50diYJfuq2HFM+HxBgj5vj+NwkadNwg=;
        b=COuhkU8ygvj05i1tBTbLRDqKIjQAmtq66pkAw13TPe1tMK+H/bgQLPzBNdoRYIrFkz
         33IRuIzsH7bpIEvbrQ5//xZ0JkpI/pCGNG7bNpMf1hUgZoeQ+CHNdYWRnI0YaWqeW5BE
         0e3k+fBLQ19RKC2BajuNRTD7++gmXYRiS0PLmFz+bTufR1c12K+OFacU5vEnLZLz2GX7
         vU2oWQsRkFqYGlEYXYt/KXyrckGhWJOLM5ALPg+ISZDEd6HwQepP3rvocBK+X18W8ZOK
         U+cFuMZzqHR8enMlAZRai/ShGbh2GL6bh0G2TaWsC6AqkafmkC1/8WO8KyuID5roz7Gn
         o6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742995624; x=1743600424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcjtkRmZu75V50diYJfuq2HFM+HxBgj5vj+NwkadNwg=;
        b=azPRvVHTE7MBcYcCGFcRFn2JYRMJOXjJY6lmw4NVKxZigQDmt6epnm6q7UCqgZiJJK
         ut30ipPxsbve7iorJtmqrtgywwQaP6pqlprweQWhrairHqz21gONAqPhG54ok49Y5L70
         +k+y4VC+S5QmSCTkBMaVcyn3j0b4G6u5IgS1PFq94j4jwfZ5mBpi/IdAOfTmVfjyY3pb
         sFIp63xSc10nb0JXImLMGCKoVPx/w3nWdv8sG5vwf3sBBRW852MVebLhhDFe+gyYjFwv
         c26f+TUIgzsOx8V/AraXWem0SV1CQm2uttgUAzdjo/lpvvlX0sH8tXs43B5/caqH+8ph
         ikqA==
X-Forwarded-Encrypted: i=1; AJvYcCV21aSZ0tdMcGMyYb12a7fc/+ab7dipO4XX2jP+Nmeyf6QP2QLceAUTvY6wy4BA821B+n59g3WzcSD/PuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/ipethcXqJpPxR5/IMM1/l8n8R3rt0kXGlVI+zPMARU2Zw91
	PjYEhEsky4H4gHdKJ2yw1eJWQRXa7NU9hT91KFw+Ra6FNiqbi5lE
X-Gm-Gg: ASbGncviWxBl+8IILIbcv77HSYLt8ZLOogJVV+wa+j0R19/pbxEUaOVBeBQBCrLkGDN
	bVZTWsSmCO5vBs1Qdum2Il0Y4otm74hWb94OmokKThgbqY7ApZDnL+BzhOYsP0Es9lPE/cOTN4m
	TxuZNhez3jXMI59Kz2rHuwgHiCmjhBaQlRXDiILHTHtxpXZDai8k8YXF2lZrCC+A/shPBcrLOQ1
	w5rot9jx39Iojr9emhqzmc2zYH7tv4CB7eX/GrizFF1LuEZLT5bA/6AjNX1yb5C8pTZFH595XmO
	B9rIePkkhowp1+2AxFOG9YaC3FfCaPgsaz7qXXoF8A==
X-Google-Smtp-Source: AGHT+IGtRgPZrsoC/mmYcSJc3J2eXZaSsDcJzf12SwZ4RBy8sd1QLKiYQmooEtxhYKXQzRLx8il8Bg==
X-Received: by 2002:a5d:47a2:0:b0:391:23de:b1b4 with SMTP id ffacd0b85a97d-3997f9371e5mr20984993f8f.45.1742995624162;
        Wed, 26 Mar 2025 06:27:04 -0700 (PDT)
Received: from pc.. ([197.155.71.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e66c7sm17008478f8f.79.2025.03.26.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 06:27:03 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: karanja99erick@gmail.com,
	philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] staging: rtl8723bs: Rename variables
Date: Wed, 26 Mar 2025 16:26:49 +0300
Message-ID: <20250326132649.22055-1-karanja99erick@gmail.com>
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
---
changes since v4:
  - Include a summary of changes in the v3 patch and place
    it correctly below 'Signed-off-by' and under '---'
changes since v3:
  - Include a summary of changes in the v2 patch and place
    it correctly below 'Signed-off-by'
changes since v2:
  - revert double blank line changes  ensuring
    the patch contains uniform changes.
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



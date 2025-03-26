Return-Path: <linux-kernel+bounces-576542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6339DA710B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C41891AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE318C91F;
	Wed, 26 Mar 2025 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYNgQnO/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9142E3370
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742971620; cv=none; b=tpB2PExwunidPQ1iik0ofgcq2OOO57aV5wRU+xE4rrjjRRJqB9dPLg1moHrMlZCkj6BozsQFRFWRapBCzNmmmqWjPQPmCQ+CEbK4odEcWbAP6brvspC77f/aI9460KtfDDzWLOCIdlm8lh1wLOH/RWE9bYTWXTjQHiBY4ZY57Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742971620; c=relaxed/simple;
	bh=rfs2BZ7t3BWRe4MgBwS40Fxv53iK1LxffPws9X1W4Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZPVHTIVNb5j40XGtJhJa4jJbkWLCXkfgBwPAqjwUNq57rCR+n2gsRuzkaV6XoKAOiEibWlWjy9mq/1vKUP2dxUqqCycfD1OBGfs29JacEeBXJNmWpjQwtTstdPd7tolJRr23KEbSwC0QwnrIHUB3UNZm1tYhY6P1LVUNYFG6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYNgQnO/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf848528aso53864315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742971617; x=1743576417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0ny5+61l3czR1CA2kOZOSeI2wheuddYkyZQLmEzW64=;
        b=SYNgQnO/KqlndXXnAgvxAAWelOrWi272fNXIrfzSKRlKXoFicmDpmV3ep76TLIT/b3
         8hc1vAtPr3YRaM3YFX4zradjtO112Pm1Lup2+sSL/6fFgT9Te2/cDvdPPYhcqFQjojbD
         PO8t0qEh5NuluQUijeiQtogBvrI0oMFAyc88WQCxvfpO4CoNkhn8KCXSg+lRH5/Nbn0K
         +aK9XY+gNbe0afSImuH/V2mEKfbA6MgWjvxAPGj713LAORvHchT6m/Pa+UE2ZlDY0S5k
         eBEutAaO/eg0X4ZstykWDRS/bEXrtDYRpbEWNU+V3ITW+LdvMwkQalJii7Vn6+4UJRxb
         Qh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742971617; x=1743576417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0ny5+61l3czR1CA2kOZOSeI2wheuddYkyZQLmEzW64=;
        b=kVHcUhwN+RJhA2fDJEY4BEyL819vmO9KAYFLqhY+5FZRSb5rf4Je32foHJUydlTDK/
         YbqJDbsJr73qKDceRLtluvR9lUzf5hGOgk8NZnNuVVNXBWx3IoJ3g3+5IO9+6GmS8Hzl
         26qP0iSnX9bWxkGXswCNxyweyFTPck7gtXV7FnxCMzeyMiHEWjZmzSHNJO6AlagKDFqg
         Xd3xqU/roO3mA06zTw4Rhx/Ka8SYEKYoE8ufjpPu0zRLZE0Gox/CW4WHu2pr8Trv4YZB
         TsWxQUgx4KxgeRZrO5jPGL1XD78Ba974MDaeLlJNinngnRB4e5LOy/jLxxnYR0TM9K1X
         Vx8g==
X-Forwarded-Encrypted: i=1; AJvYcCUYQOB+7FC27/52kFuJYevRPENIOrJ86iRhcTqJeiv1AtTaei1nqygl6EKszMkZ8kIFQngOc52Nnt1P09o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhqa6E5nlBgod0Sg4J6EX2r9rpIL4MLmyCdScLp9uv3NK7vpXM
	ZZIBGRrwbI/kMXRNd8JMdekkEt4dXUvNGHqsmL4Ds/hzzoJiix6a
X-Gm-Gg: ASbGncvGLJfbFjiMFBPXCj4OnNswPtHz7CBuE4hhE7x98ZjYOI9Ebbv5nFrWd+ujwBX
	LcKO5IeqFJVPWoeF7RssZ1taCAgP0g7DB4yNyEzh8yvGet4lpMTyVBxcrDuA6sClmbZDfpZE7Ur
	l7rL+GZi7apw8I4wkDPSgolMBvRR6+xtfIi+At28hM5LL+kiHseHYoIQMLHcja1AiL6tM0inBJw
	eecyBhjzakKqmomVIYbFc3Sa7L2M6i1GtNtyQ5iHieKh94ZX9h4KYmjLm2bmFo4X2j85vRj/ehx
	BKd6Ydh9znqnPnGaCexKpl8eVMN/KGTGtCSbZT00KQ==
X-Google-Smtp-Source: AGHT+IE7D2Ij3U0QNaWzufulupKrE6f5+QxvsQxn39MmFMpvn5EuBP413aKBi5byWZMPxUhQOwtkCQ==
X-Received: by 2002:a5d:64cc:0:b0:390:e62e:f31f with SMTP id ffacd0b85a97d-3997f8f277dmr16680318f8f.3.1742971616570;
        Tue, 25 Mar 2025 23:46:56 -0700 (PDT)
Received: from pc.. ([197.155.71.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b83sm16139702f8f.33.2025.03.25.23.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 23:46:55 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: karanja99erick@gmail.com,
	philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: Rename variables v2
Date: Wed, 26 Mar 2025 09:46:47 +0300
Message-ID: <20250326064647.8380-1-karanja99erick@gmail.com>
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

changes in v2:
  reverted double blank line changes committed earier ensuring
  my patch contains uniform changes.

Fixes checkpatch.pl warning:
	CHECK: Avoid CamelCase: <mediaStatus>
	CHECK: Avoid CamelCase: <lpsVal>

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
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



Return-Path: <linux-kernel+bounces-576584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800E0A71169
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CCD3B9A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00CB19D88B;
	Wed, 26 Mar 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAuT8bch"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B4198E6F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974135; cv=none; b=ajf/Spl3MZFiVnl3iQhFMYJoT1yxiiu1mMKqXocw87cw+UUYXjG3F86IXnFMZrIz/jrWYYjcq45UBnkACJYonJupMwJ9F4wMdQhiAPvz9GqMMSARi+Qx0BqJvKmhcIMmXmenFCF0oS9mGCOHRi3MJua4YCcSsz0pP0X7r5r2mtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974135; c=relaxed/simple;
	bh=LfAZcSwVWHBjKeKz8WpCYmIYe3EhckrRr4HaVJWjrf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6Dls7F1SODgKVPx1hMyvOaFsdFUkgI0A6Tz/i6XrJ80c2FuOU6uUcFMoWfiP+DJVby6n+x0I+UPaCUk2wZiChZcdaNie+eBSQFooJPHZ6Y9fUG7KNz8ZCiLLJ9PJbAfAN4aEv+ErXHBIxIWlxQpXo9CzswMCTNA+9nBYeHzIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAuT8bch; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso29356285e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742974132; x=1743578932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XiWJ6VyTMM17GbhhguALUb4t5szUucYhL49egidGGFU=;
        b=lAuT8bchOvxjV5phD9XK8M8dMFTJZrWJJKU48lE61pHpBWVw0ZUZJZAcDjHuf9MDmc
         0Ftq3nodkr4HRfEz2bN4R5jld+9KGIVJPWHSzMlAKDI+ro71b0xtogk7wzVLjAYNrKMF
         btIkvqF2GwLlPx6n9bPXi/zXbpBanirLE/pVXf6wJF1I9oOUmvBUJpxHkIJKI3tN6oRr
         DX49HTopCjcPyl1WSlv4p/Z/FoZOacT6uK0tgL58JK/stwHhEgMlX6nEZKNDPkgsZQZO
         RJWnu3fwZ1BdJNH9l9N3uxf1d29nLfXTAAWIXZyF/W6ZECQhdAfoycNzaZ4fTDAqxhTk
         isMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742974132; x=1743578932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiWJ6VyTMM17GbhhguALUb4t5szUucYhL49egidGGFU=;
        b=A8zBTQ8vpAn8g/fbTMhZVXSrVZ0Y/9pCXTuAGarGmdRQwV/iyT9oQ/J3wM589SfbiU
         axIT2lnOM4wNDR2/HaULDqPbvfl1PTBD4ORblCCv8vL0uJUBKXMLN9+3p3LKuM6l7uP6
         Lm5Xbv0rDaKQyXjAiM4SikgnzlT41CyGIumgMoJFg/z/Y0sH7OWNfIfrhbP0mUx/PHkS
         1ji3xCkSxE/vMVpJBGoiTC85vAJjFTQ6EkxhFv9j7cGuZ6RcD3kto1PY9OSHhNsHYGFv
         /qo+N7F6lG1EUXs1orTTDxVe4f797AYb15Z26KvObQJ1fkGtmpf9rf95xrxGZToIrE8Z
         rnmg==
X-Forwarded-Encrypted: i=1; AJvYcCXtv8zTzgo5PSj6JKefGCJg6pU9NJOn7Or04QeyY4FQ5jPvV5LnzhefRGn9iDKhKHaYOWu4bSdGY7FwquA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKqXqrNtZ1AyQ0hmhORk71a6SwYlctCr3qO4XtVhzNqS/xHG1w
	mcJjDTbrkYEAsxIP4ES7c/emr9nJarurxJMVVJoVDNV6OwkQj1lN
X-Gm-Gg: ASbGnctHEAKNWuYcSYg03y7yALAmb44Uuwvv4DQIaSnqvjjxz//enPaQFrIgmArbRTj
	fUTI8PKHhbTm43GwN9qzzVqJ+omiUtzJ8sjiX7un7JOOlQpuFW9aa3396oBeGnYT4+efgSyMh4r
	zvaVo2oQeMZHDs8uTVd1Thl9y44Kw443T40JJO89lubozNlCr+TvVVTdDg8lY97T09N/JlS78Eu
	QUDhDSyBKeAtFWSyeRIDZqS2R18u75z4RklOlqeC47yTO5+miUTjpbEH5EJd5J204yReH5alA2f
	V/gaOA8CENuytybsGyRjOvv3yzWjPhvWS9Go9scf/w==
X-Google-Smtp-Source: AGHT+IGnW2A4jsdj1Z8yfFb7tuiieNjS2/hY8dI9Tw2HiSljJAD6f8ZVhhG8oHJF3dcYC0mX59QNTw==
X-Received: by 2002:a05:600c:4e87:b0:43d:4e9:27f3 with SMTP id 5b1f17b1804b1-43d509ec5bfmr151377935e9.9.1742974131580;
        Wed, 26 Mar 2025 00:28:51 -0700 (PDT)
Received: from pc.. ([197.155.71.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceae03sm180783435e9.8.2025.03.26.00.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 00:28:50 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: karanja99erick@gmail.com,
	philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8723bs: Rename variables
Date: Wed, 26 Mar 2025 10:28:42 +0300
Message-ID: <20250326072842.10344-1-karanja99erick@gmail.com>
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



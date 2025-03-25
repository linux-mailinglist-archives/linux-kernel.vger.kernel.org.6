Return-Path: <linux-kernel+bounces-575365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB7A701A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1504A3B37C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCBD2641DB;
	Tue, 25 Mar 2025 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6czOBRI"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F6263F46
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906844; cv=none; b=bpb4hOqwHFBU+DLrD2NijATxG0sE77qD7t8HkJXmF3DqSbhyHKQ/fv5pv7v2avUBh8Lx8EyHn0dmYSrijR0kcuI1vS7Va354dBoVkcOC2PJbcH/Ob+xE9kO8Jd31SCkVR+4OkKEHdpO1d9zqfLVajXPiaqVRd6lPg2JE0stGyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906844; c=relaxed/simple;
	bh=W0UjzV++zRmDeWfAHDUKWe4w1h2+xe5Sqgek4dnSeRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCmIchXOY6CndXV5K1mrJNCgiiVb6SoccfDoKmf25Bk96PRNZx3JRSd3odhdhAn04OJtfw3UTH+9ESTiXhFaJvODD+Q/CeHbRtJcy5vUnmZfY1dqpjoJz85uona15MOAW12FLXQCIIOOZyXf8R7hAH2Vwk91t9CfOTKRJp4rQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6czOBRI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3995ff6b066so3097568f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742906841; x=1743511641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f8T5E+tN2GeC9Fls1L5neCulWG3IZUOA7/xIRYDwMGQ=;
        b=J6czOBRIdl+28EMbMl+WiyyxKcZcoLSAgMP6cJWfTBI/ea2hpIn3cTd7JCVqLD1Lks
         47jHVHySmqmtU4zixbnClVCmup5fyfMBCBHoPFgYhzW31gOcvPqcHneUPW72j7xza2Dm
         NVGDgtCk6I/cd6/5+UcrYjV4tXZYhVrE0CMN5kD4jTSqNLmjJBEOAT5Z6Bch2p7iV4wD
         XolAyMpsmY7+vzbkAQUzRckjztapJwQtpOT18O9kDnu+jQQ0HJG5MSjtEr+7HswQzD+N
         EdGZI0FsCggrq7efm4NbpFItFa0wjDzV0/m44egKj6l43DszjDmcto7J3hunJfMOFglF
         Nh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742906841; x=1743511641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8T5E+tN2GeC9Fls1L5neCulWG3IZUOA7/xIRYDwMGQ=;
        b=kpT7MryJSMGK+kAhJWer3pk8cM20W9CN9TpuQlNGnBD8EXWOwMNispa5Lh542FBQSd
         ImSitg57J+S+gbcD5RIQp+2GWzbZRs90s4uB6IfmjIx6uWj4T70Kfpjd2szPfhWOGbO4
         KZg/pfj1/ag6npnIhsH7VBdL7g6T3MHDiB71FPqM9EYcfQGbYyPvSBnjnu/Sp7vAyAQl
         kMoKIjTAFtiUOYFoitwdPV8hkLwaJxDOmFyjIjv83WJNx7isuV3/N6LVrI9SWA5wbpkH
         4u+0WMsd5I0RsOSpOLd3mJ6+l+iMas0ajjuLvRxgxvmsj/3XT9IH1s3u+ZOrmZKzW/yt
         4u6g==
X-Forwarded-Encrypted: i=1; AJvYcCXZyl/dSVQ0aXXp3L+Lrq6Jn2nELHeKYpLZha9cSyMSqgs+sPYGl98t6V6I4XUWkyTmwMKzBNmrBC2dBis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTKzpoB7UkHUJWjTk5dqC4D5IMl/TDk6eADIv6fw+Evf3aoCt
	fKh9f6w/7L94jEQGXUGzW72pshFZgMDc7sMMpPTZZjt0dxn6Naau9xBrM3SF8X4=
X-Gm-Gg: ASbGncu58olXx7xuQJE0dOgYyQfpgt4e1KmGKpeyVsi7X8d75few5YDyvP26CEVpIeE
	y71WoRhyUpSymvoo17endhnPMh9hsaje/4Wx8C2tY4Jne57F80tlBsdk4QzTPhRRpAPCHvruDEo
	sQz1fW83Ak6apzaehiu2L9FNEk3Knw1Sq1P7rbj9qj4y8sHY67y259qMBegGZBj+MyUqjxLAYc6
	4WX7MWAubeodQ7hTs8k7HBoFoyyljeMlOAta7w+4qZcUewATgBofYfPXf7MY6OT8b/n1xIijwxB
	EBos+CExNRwspdghqMUl9jBlSBRfMgxcVy0Wi8ZHhg==
X-Google-Smtp-Source: AGHT+IGskFUgT193BbGSZ39xZtsi6sDeuCGufdjn36V4p3+9ta4/gGj0D++bLlwEKgTd14NEHqrScA==
X-Received: by 2002:a05:6000:1aca:b0:391:47a7:299c with SMTP id ffacd0b85a97d-3997f94de39mr15914557f8f.40.1742906841341;
        Tue, 25 Mar 2025 05:47:21 -0700 (PDT)
Received: from pc.. ([197.155.71.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d74b48b90sm1975715e9.14.2025.03.25.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:47:20 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	davidzalman.101@gmail.com,
	vivek6429.ts@gmail.com,
	viro@zeniv.linux.org.uk,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Rename variables
Date: Tue, 25 Mar 2025 15:47:12 +0300
Message-ID: <20250325124712.47577-1-karanja99erick@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_btcoex.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
index d54095f50113..27dfd00b4249 100644
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
@@ -52,21 +52,19 @@ void rtw_btcoex_RejectApAggregatedPacket(struct adapter *padapter, u8 enable)
 void rtw_btcoex_LPS_Enter(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv;
-	u8 lpsVal;
-
+	u8 lps_val;
 
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	pwrpriv->bpower_saving = true;
-	lpsVal = hal_btcoex_LpsVal(padapter);
-	rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lpsVal, "BTCOEX");
+	lps_val = hal_btcoex_LpsVal(padapter);
+	rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lps_val, "BTCOEX");
 }
 
 void rtw_btcoex_LPS_Leave(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv;
 
-
 	pwrpriv = adapter_to_pwrctl(padapter);
 
 	if (pwrpriv->pwr_mode != PS_MODE_ACTIVE) {
-- 
2.43.0



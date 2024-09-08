Return-Path: <linux-kernel+bounces-320126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE1970664
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B801C21280
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE71531DE;
	Sun,  8 Sep 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku/LxpUg"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF61531DB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790296; cv=none; b=CuYc8L9JQBmotWeF3unmjIkTzS1FfnYkVjYTmivbcK6ijycNTuz2UHMlqiswlm0lw2irSJhXGsJ2dePW0iiDwMnmfQ+hZSL8j9VpWxgiq7LJDDJ8NQzNjOsWyjSvmD2kFqa8gUFt1UEYLYLtHBmRztaO8Qv5syucObMlKffUUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790296; c=relaxed/simple;
	bh=Ojsy58E5fZr2thySvAU8vWmKYpsMIAgUbMJ2FxqEVWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2W3VBYUt5AfLur9r6hAylNBmG3JbCwCeklUVVuQ3n6XEjbeEgCEqXadmYi4QGBQozE+OHeVkbnLUcBi+Ielqv3B8nuVesds4EYDyrA1OU0QqY9CeJeBrlUp8fSHIg4yzQKtB2A8q6017laFOQ/Djwrbe30kdkqP2XDY+b+qodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku/LxpUg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82cdb0baf19so29842939f.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725790294; x=1726395094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZlR+a0vRki2ZB0QGJlI4VIejetRrtr4o4ItkGEyQbI=;
        b=Ku/LxpUgYUS6/Cc0A1Oj8mygX8/zP4SSBvQK1j24rdURXSDiOQHg/h41ubUeUwVQPz
         KYey2lafRwtW+/IYFZDJ6F3aMH6BAlNS8FGNtGGE1TSjo5vm+/PsCHMAd1oo2dRgfon/
         ll4lfuDN+y+78+F3hK4ji4Sl00OykvkVz6wo4a+8dKOMK8nkx49L6Lbtof8NWU6Vrtsp
         ArCDH0uuE4oR+r6n3XdQqrIgbvpu871FUklfdoUPz0mtK4oJZb3WVgb19rNgLmYgV6O/
         iFkpJO8tOx8/Yv7AHp2xCLQyDwLGKttDRbnJILC20c1N0XIsxWpN0u5p1KOA3ivIcCH1
         vKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725790294; x=1726395094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZlR+a0vRki2ZB0QGJlI4VIejetRrtr4o4ItkGEyQbI=;
        b=E7jqqpzAiF0p34VStqPn8V8n/wAmBE0vGSdvMM7e2WbL9116hhFidJh6Q2qsYjx+pp
         lH0eAVY1Q91L4aQjYEcgwpzNjHPHa6YrLfGeK/aQ/8HJTf/IsIj5mDzbdkN87GKqx+/F
         mjBxkgL4MvuzR1GzmoMkUgQ+BlUokUwg2cYFg6dxXMbz0AqtOSjJ9uLyReGMwhSj6Pzf
         6MZRWY5LcKPPvwH0l9YzqYuRAcwqCikDk6gW/RkvxpHrYGR3Gxsu+AmWYpY7LfjRrSsV
         zC7UyKA8yyun/PjTlgrGZeCMnruqbgnOXvIXpbfaDy1XJi9i6oUJnUbT7Yapst7OrrgT
         ujiA==
X-Forwarded-Encrypted: i=1; AJvYcCXbLWY4e8FNKIsEgqtCeD6eCfhozt6cMLND7KQCAi3KUNcbQDTdqGOY4biy2GazV5UrZLpeahH9bSkd39s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/e1txvQB6BSXCeH0ONUf8KCmLFhiIme4WkEw+o7NN4J3vRl6
	oKKb9JH6oQlGZPlYKIWNY5+vycpNvWNgp0KWZaku5/VOlqajrk6PDi9sk+H6pm4=
X-Google-Smtp-Source: AGHT+IEF2yw5m6vzZXA4ZGXbip4ZR6JD+S5d0ZE5PIVtwmi5X8QP+tUW0z7i6VgBnIVIWTcB7HecqA==
X-Received: by 2002:a05:6602:3c6:b0:82c:bdec:1c0e with SMTP id ca18e2360f4ac-82cbdec1d2bmr373927739f.2.1725790294090;
        Sun, 08 Sep 2024 03:11:34 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.172.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm4589379a91.34.2024.09.08.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:11:33 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 5/6] staging: rtl8723bs: fix switch and case to be at same indent
Date: Sun,  8 Sep 2024 15:41:09 +0530
Message-Id: <20240908101110.1028931-6-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the indentation for the switch case statements. Aligns
them with right indentation.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>

---
 .../staging/rtl8723bs/include/rtw_security.h  | 70 +++++++++----------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 1e5e7f52f8da..740c8504cba7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -171,47 +171,47 @@ struct security_priv {
 #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
 do {\
 	switch (psecuritypriv->dot11AuthAlgrthm) {\
-		case dot11AuthAlgrthm_Open:\
-		case dot11AuthAlgrthm_Shared:\
-		case dot11AuthAlgrthm_Auto:\
-			encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
-			break;\
-		case dot11AuthAlgrthm_8021X:\
-			if (bmcst)\
-				encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
-			else\
-				encry_algo = (u8)psta->dot118021XPrivacy;\
-			break;\
-	     case dot11AuthAlgrthm_WAPI:\
-		     encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
-		     break;\
+	case dot11AuthAlgrthm_Open:\
+	case dot11AuthAlgrthm_Shared:\
+	case dot11AuthAlgrthm_Auto:\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
+		break;\
+	case dot11AuthAlgrthm_8021X:\
+		if (bmcst)\
+			encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
+		else\
+			encry_algo = (u8)psta->dot118021XPrivacy;\
+		break;\
+	case dot11AuthAlgrthm_WAPI:\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
+		break;\
 	} \
 } while (0)
 
 #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
 do {\
 	switch (encrypt) {\
-		case _WEP40_:\
-		case _WEP104_:\
-			iv_len = 4;\
-			icv_len = 4;\
-			break;\
-		case _TKIP_:\
-			iv_len = 8;\
-			icv_len = 4;\
-			break;\
-		case _AES_:\
-			iv_len = 8;\
-			icv_len = 8;\
-			break;\
-		case _SMS4_:\
-			iv_len = 18;\
-			icv_len = 16;\
-			break;\
-		default:\
-			iv_len = 0;\
-			icv_len = 0;\
-			break;\
+	case _WEP40_:\
+	case _WEP104_:\
+		iv_len = 4;\
+		icv_len = 4;\
+		break;\
+	case _TKIP_:\
+		iv_len = 8;\
+		icv_len = 4;\
+		break;\
+	case _AES_:\
+		iv_len = 8;\
+		icv_len = 8;\
+		break;\
+	case _SMS4_:\
+		iv_len = 18;\
+		icv_len = 16;\
+		break;\
+	default:\
+		iv_len = 0;\
+		icv_len = 0;\
+		break;\
 	} \
 } while (0)
 
-- 
2.39.2



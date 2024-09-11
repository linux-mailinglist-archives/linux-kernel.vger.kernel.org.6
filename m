Return-Path: <linux-kernel+bounces-325048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73A8975437
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF06D1C22C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518C1A2632;
	Wed, 11 Sep 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8Yzr2jl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A01940B2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061778; cv=none; b=ZwUjRiYUUE9U6v7iedP7bR532pggjWDzposwKE5QSNm9Kz4Dt8EiHYbWy2AtyK8zfi5ca1Ag1xF29xSE/TzroE/6G4cyTtCAqO2Q6JEqWrzR9NJhDQP7Bv+QVAOtOsV63GSFf48h4HOvfM/+SAIXEasfEWfJ5ym7MtpZLSWqT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061778; c=relaxed/simple;
	bh=PStcQrlv8JfPnizprRfybH51i7asfOXO53n0nTRArS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zn0h+akpPAOvDwyz1XdhTd3CD1Gx+2ZYaFfQPMsoT+u7c5iQQ4OXYzVzIiy6p8V7CsPNEepOvn7SdUUJDCyTL9NaZU5ycLvaSQMuNEqmuOYdwGSZeoYBnQQVVsTbzqHxtz8a1NKEWk8Xgo3TGR1HqOcRIWu6iHJocVDmfB9z0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8Yzr2jl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20543fdb7acso46098395ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726061776; x=1726666576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpicHg1/zCLLbxQoUHGVhbruccC5DYxv+chpuNuxfaM=;
        b=H8Yzr2jlxBDGd91WsZu0drcHKjxAAu8/hq87DxzBmKnwzJlydtxSD6SMS3v0DMi9/p
         qjC+MFwrlvbzN6zZTHnLgOt896FVLZISpzSYC5r9LcyA3adeH8rgJOt3hHqXugxB4f6K
         CYXpvGMgs1jApgXjOTtxh6jT9CesDRooPAlOOpFsvXm+dENlOMdmoV5VdS2P7iYXSk1Z
         sYwGzYzo4swgiO6w1lihA0b3PY0ufOiIUKzbClvFDvyO9GtAZTP6MvMP/N8EOf2/yD3k
         2/kVJPCPA6SYw3PQAFnKi4em/c7JzIpNRK5jaiF41lMznNEb5V86+Fw5Ku9Kz5wMDNn4
         eOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726061776; x=1726666576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpicHg1/zCLLbxQoUHGVhbruccC5DYxv+chpuNuxfaM=;
        b=kG6o4VmTQeOwYk7lHXBsaMk42rmxu5AsuSa21e16BQtSRoyBDk+7hv54cA1aY8tSRF
         MVAgfAIjVEYVvla1jiK1nBFBU7PRzlRWVVDZQn9MuGmu4DjQk8DAbqyDw2EpY/VGawpe
         Hu/K68DdbZ6K95rmhTGUN2jvnOVzmWVI129fZXpzrsiTJBZP88nqgHPIzlXI6Mu1nBKS
         xGfK1mLPNoaSJ4uK4828BcpXz9d42NjRAcswcpdIkttMUczLBL+dp+FAo7j8PSUZs+g7
         /NYrKM7BChr1G9yoHdrUxixJwC3IFsWTXR8fSZM71ssgo88VdI2nJ6wKQ4IKC0hjPAOd
         Us3w==
X-Forwarded-Encrypted: i=1; AJvYcCW5gsHNNKsQmWtnAgPaR5163CyzutPK2kNxA8C2Qw3hXQuqAxOJc0jS+FrSVF+ZzcJSMzwSmi2zAyZ5IGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+QdH2YUJ7Mn8ujcK3lZGIFLuW+mjjNV9L3i1A1TaaE8L1K43
	PY0LM/4mF1xoK0LJl/xOICuEu50G+ZEHTVKZH2SmKozQOUoCu4qz
X-Google-Smtp-Source: AGHT+IEo6QjHJ9h8E5tqRMAucgzRiTnaFZ7WtK6IlMAAUNx5y+Xr8J251ZD16i+BOG9QbOJxje2X1w==
X-Received: by 2002:a17:903:190:b0:207:625:cf04 with SMTP id d9443c01a7336-2074c761a5amr64555445ad.52.1726061775890;
        Wed, 11 Sep 2024 06:36:15 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:2f:2714:6f11:a421:14f1:4006])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f20e28sm63246105ad.231.2024.09.11.06.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 06:36:15 -0700 (PDT)
From: abid-sayyad <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	guilherme@puida.xyz,
	sayyad.abid16@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs:  Fix indenation and coding style issues in rtw_securtiy.h
Date: Wed, 11 Sep 2024 19:05:50 +0530
Message-Id: <20240911133549.2664372-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch improves the code readability and improves the presentation
makes it look less scattered.

Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
---
 .../staging/rtl8723bs/include/rtw_security.h  | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index c3e47d52687f..ae65d684a26d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -171,27 +171,26 @@ struct security_priv {
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
+	     encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
+	     break;\
 	} \
 } while (0)

 #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
 do {\
-	switch (encrypt)\
-	{\
+	switch (encrypt) {\
 		case _WEP40_:\
 		case _WEP104_:\
 			iv_len = 4;\
--
2.39.2



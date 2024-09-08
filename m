Return-Path: <linux-kernel+bounces-320124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E46970662
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65CC3B2182B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDA14F9DC;
	Sun,  8 Sep 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKWdl+D1"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393E14F130
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790290; cv=none; b=Hp71WF8fOW0V7i7/wOqLL/4HCFuf396WJ8kqaNg1CZ7xA4TREos6t3sF/Amhkw2ogDiV3iJg57oyrjE6u++trDVh1dC8NA020GLcGNWn4STSuqw93mxjSpK0Wh+/Sz9jPxAUU4bZd2qZWidqzlN7zW8t6XcX20tylxZSLYYNMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790290; c=relaxed/simple;
	bh=s1ZVJGmAf1WF0Wr/k2J6OsVbhkjRW9zrp1i/9wazWnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ink4WUSfFTAejsEotDEjNAK5ZvsEMKrVLbPC00b/Sm+ldupIttLUxqql4vd3bm8jh/3Rh+4pXfm4PQarFK/SeOBcE3tg0CG1tiPFo63DpisKCh85q1yo4j3acffJ1JySSAhLzyUYLPej2YslPyAd+BRIdKv+cHRzeDesTIaeTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKWdl+D1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so2519439a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725790288; x=1726395088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsUwf0eCWNJhcn14DjOfJsivn1oeErSWNJpstq9iJpM=;
        b=SKWdl+D1A5dRXykxrhnmitrqjnsH4kpjPuiAai9IjYUScC39cqvRUg8SZU17gc+qCc
         G139F9g12d41Xd1s2VIhGhE3haioUWrhg5gY2sFeDPbm2JJvtoLJv0xm476q5pEeoMRp
         ZgYZaKXbtF5gQhwB4iu+4XPpFkRdv+b0S+wpJH7vpVyYleZzQ7r6+Fi2SAfqui5VAB6F
         SuG+6nPVscBQETPN42PMnxNl2xqmsrAOzylI2xx1tn0epMefOUBAdOEHaSHwW8i9TzLx
         KMb58TM1V5JW9UjhQfhgIBejG/pIet8oA1de+NgJQvgBRyCLJgVTqIa1gMCLCK7QPaIW
         lYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725790288; x=1726395088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsUwf0eCWNJhcn14DjOfJsivn1oeErSWNJpstq9iJpM=;
        b=omg82fKP0tQDxmt3YiWRVswdBufusbVOAFJfKkTsiU7+dPOwdK6RWn0K4wdN8+JCZW
         ddZloQlkozVPWVH/IBU0zeMa5//qxOnAZLg+v3sLSnl2PES9K/Wu+niLcKkMlOuc+U0M
         3uRkrvRZhaiA2dr2wxHcQDIfcf7iIkr0NQ26Ax3EhhyhUzbEjUAzY917U97K0jgUT9CH
         Evs4fNYCCDFRx2sDybbvteOQSeihmAju0Tgfh2aX36BkjT7W+1sximQ3RS1PoAkoDG5f
         V5K8NkepZ71yWSDwc+xhEE8dM2J4E7qtE/ciHfif5zaLPIfQXQY6ZkWNW9NOga9qpPT0
         17Gw==
X-Forwarded-Encrypted: i=1; AJvYcCX8GmnpGXhcyv5miILq1ZepZaLBghcPTir9POjjVrxoYAyUKoBDfCVstT4KYj+7OJf8kfRTN/TUIovGd5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0y2CGw17hxDbr+LpWm7uGolz11G/krZDx/BESWv+X/ul6nba9
	KPKaCTGw1EZ7yQLys73yrFo0vnuqsZxsz76a17kXWcNIsD6j3BXq
X-Google-Smtp-Source: AGHT+IGYZ/4cGvhA3GCX5HW0cLd4Aocj+nI6+i/9i4QfISAEPr015JG3Br5rF128Gd04XmYXERHwuQ==
X-Received: by 2002:a17:90b:17cc:b0:2da:9dc7:add2 with SMTP id 98e67ed59e1d1-2dafd099b12mr4758575a91.26.1725790288310;
        Sun, 08 Sep 2024 03:11:28 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.172.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm4589379a91.34.2024.09.08.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:11:28 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 3/6] staging: rtl8723bs: fix space before tabs
Date: Sun,  8 Sep 2024 15:41:07 +0530
Message-Id: <20240908101110.1028931-4-sayyad.abid16@gmail.com>
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

This patch fixes the coding style issue of removing extra space before
tabs.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>

---
 drivers/staging/rtl8723bs/include/rtw_security.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 3ccbccf92417..4efa2d258ebf 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -81,12 +81,12 @@ union Keytype {
 
 
 struct rt_pmkid_list {
-	u8 				bUsed;
-	u8 				Bssid[6];
-	u8 				PMKID[16];
-	u8 				SsidBuf[33];
+	u8				bUsed;
+	u8				Bssid[6];
+	u8				PMKID[16];
+	u8				SsidBuf[33];
 	u8 *ssid_octet;
-	u16 					ssid_length;
+	u16					ssid_length;
 };
 
 
-- 
2.39.2



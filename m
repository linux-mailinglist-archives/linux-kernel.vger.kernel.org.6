Return-Path: <linux-kernel+bounces-213983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A1A907D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12641F259E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9213B5BB;
	Thu, 13 Jun 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLYaxXCS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3B13A884
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309790; cv=none; b=sfvcsYeHyNv3Tc/b0gPBt55vNFVoQmHVvsttMEGAXMDIoXkvqcrYNCy8QYkE/mqMHeHIhHzzK2ViOI8MVurIfz1OsdxmLj43XRzAdyI2WlleOntE8zo3lnEJ7YctJ6oly7koPXFGq4WHgM1ZM/6ZJ3Eipbd+lD994lQfG4cCTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309790; c=relaxed/simple;
	bh=qQRjjZZws/Ma6VIvIPN2Ic4SkHiuVcNFQMuhJXO9qHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GR8K9UmpIr3/Hlu8L7PkPtcoszagYmEmMv8EUY/oTJ8jokZhTLvPoTJ9Dkz2gu5J95O2I1FcC+2ANCPnoEKZr2YR0PYG8/w0r/T4o1f7bu/BODvV7Pxij61eRD8lasIQbDcgn8rm4pkv9y4XBKznFTs4Zhuuy1ki0zHwMS+L5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLYaxXCS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso12494845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309787; x=1718914587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcEzKvcxuUEgSwRZ+SIVZqsXz/1BXJpqKsYkBURq044=;
        b=mLYaxXCSH9xaVVqrOVuEV4TSGA8U5taGNLEhz4Ydpt0L7RSZPkLWr43AX9kYg6xyf7
         vdg+CjDkwmqCbIHAflC8BTp6UnJEBmijF25e/MOuSbsVKagjpwzbRZD8Htj26u5vWkGb
         FlP0PxN2QIJ6z0qjyPdcAscx/lKdzxydmVJM9JWW4nEZRpu+O2DziuYYlnDGZ4MH5MLl
         IYUcETGSb6rKgZLYk8LcTmn9FvYBzzd08vc8vKY2V8EXK8oquJqzCiNoQXfrvjoErAzA
         VhKGR/DF+U9XNc56Tzb/Y4nyqJbPCay7ALHQlUGvX3ZUoUDHhS93CE3sxAng1NEDOOEJ
         A/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309787; x=1718914587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcEzKvcxuUEgSwRZ+SIVZqsXz/1BXJpqKsYkBURq044=;
        b=SSQpr6c8DkjJfaKiVZHNwOy/57+qJ9w0rG0fh7sz2msI+vvGgTKbXb0L+dpprQ/1mz
         iiUJYaq1K7aghn6Qt3KOqHxcKXUd6xjqoPEIDaEUprWDIJWlAv1i6LzeQNtYA98OjTCC
         EGRvoaBV3ZS1Lq6O2juwbVSahM4sQtou2zdLjBipbcmmxl5jPN6DYnbrT7bqvFDr0ApF
         MEVU3dFm4XWIyyfOEoC0lUzV76uLl4IHoI5ilUXCo3SwHVu5lmcQzf9DiVVEjlvnQ7zB
         lY5hlMwL/uwqvIZ5g8Niuc/1VqLllY3AgEkJo5ADVKqc71xwNbg9beKWI1CZWWiLeNCV
         Icow==
X-Forwarded-Encrypted: i=1; AJvYcCUfycKBJiLD0wGUVJDRcrBmTO1CrezWVOC8r5ptd6/VAQxbvHxVzrEuwAHYvV0Omgxm6NoEeI6RU1A2mPYNznxRe+ngZj7jv7LFl/37
X-Gm-Message-State: AOJu0YzXtErXB5zwK9LmoDBGGmzTKnn29wIMRSjcrOh8wRmUlZWWTz41
	62PED7iUYigV3M9AWOfl8Pi6lFom/JQjOBoGGdqEM8umyCrBWfZP
X-Google-Smtp-Source: AGHT+IFkgtJwQYsiJ7l7nJncpcRDWZmQnU7mEqNo1TRcNXmKckGuFg2Um4jfRmaXp4EMGNkF5dmDPg==
X-Received: by 2002:a05:600c:4f91:b0:422:683b:df2a with SMTP id 5b1f17b1804b1-423048273d2mr7764455e9.13.1718309787038;
        Thu, 13 Jun 2024 13:16:27 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm73817195e9.37.2024.06.13.13.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:16:26 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH v2 3/5] staging: rtl8192e: Capitalize constant RegC38_TH
Date: Thu, 13 Jun 2024 21:15:09 +0100
Message-Id: <e78f4c30a838d8e98794d80126ca246614b14b68.1718309120.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718309120.git.engel.teddy@gmail.com>
References: <cover.1718309120.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to kernel coding style, capitalize defined constant.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 5392d2daf870..4863ced04916 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1752,7 +1752,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 
 		if (priv->rtllib->link_state == MAC80211_LINKED) {
 			if (priv->undecorated_smoothed_pwdb <=
-			    RegC38_TH) {
+			    REG_C38_TH) {
 				if (reg_c38_State !=
 				    RegC38_NonFsync_Other_AP) {
 					rtl92e_writeb(dev,
@@ -1763,7 +1763,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 					     RegC38_NonFsync_Other_AP;
 				}
 			} else if (priv->undecorated_smoothed_pwdb >=
-				   (RegC38_TH + 5)) {
+				   (REG_C38_TH + 5)) {
 				if (reg_c38_State) {
 					rtl92e_writeb(dev,
 						rOFDM0_RxDetector3,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 863af8ef9f94..3add5aa933b8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -42,7 +42,7 @@
 #define		CURRENT_TX_RATE_REG		0x1e0
 #define		INITIAL_TX_RATE_REG		0x1e1
 #define		TX_RETRY_COUNT_REG		0x1ac
-#define		RegC38_TH				 20
+#define		REG_C38_TH				 20
 
 /*--------------------------Define Parameters-------------------------------*/
 
-- 
2.39.2



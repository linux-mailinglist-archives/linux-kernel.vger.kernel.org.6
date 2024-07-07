Return-Path: <linux-kernel+bounces-243502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AED9296E9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EA21F21136
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFBACA62;
	Sun,  7 Jul 2024 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvtiINds"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F58F501
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335271; cv=none; b=ezn5Tb0/MNcwpKwApwc1GrZYDBeIIotzsPbeCnFlJX7lYhv6s2un+uOq56PSSO+/Q5F6/8/BlPl33EdLDwIe2Ih+S6X2E9kgbrgKg408ZhL6uD6M3/atiOWkU84eNS9omnWLtHUFP/CNc4gzOpAAMphCsGOnQVshUGFuEX7l4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335271; c=relaxed/simple;
	bh=+IuYxCm1vlnF378i4O4W0jciEGj38cmeBQhvj6kIefI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSOyg2qoY6wwPaQhwMXKBMriJI4nHliNkiLkY7no2srFumveYmAH6pny9seQyJpVdR45QvQME7PxDMkEcAq9DI6KEH7oeZj2HquiFprMvbBby1W1XR+vBr7d7HrJDX0qTeB/WxxrYDLhRxjcn24vfwSnb7gT7oyt/TxAP4OkDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvtiINds; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42665d94cb7so359105e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335269; x=1720940069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GrA22IGjkXIPIsfTt9aOZ8ajLSC1LUgeoha8qPdMqb8=;
        b=SvtiINds3ZSAF3vqkAIZrLjmDBp8baOjw6JeWICQAOFE45PfeMb6NkXx3z4xTMsGjg
         7WKvQNqVJH4WpaLQXtyVuEWM+UbfoQoAkayUlYWlsJXv0zXCSBh/8UmoMffTGaiQHkuU
         aDv9o0tgogUnr7xTgz8JMFZRV7pM95TYPb6V+NaP3ODeeEpwztSHVWubEKAC3QQNjSOl
         E/wALbyUHob4XrWZoD/aZXcrTfrCL+HKIJM0ARf7ZocRtAh21ZbVkXoS0VAM0Y2yoqvG
         K5gY9OwDftC+y5VYidZN0mFrHeBgTmW/tWOSB4wHx9Wd9imPHSX+qXpIooiphzHb1A9B
         dUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335269; x=1720940069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrA22IGjkXIPIsfTt9aOZ8ajLSC1LUgeoha8qPdMqb8=;
        b=STtrL7HmYLNZxLcKWyV1M9ivIP+zWOZI3B7E6vkPk3HpUQjAT6KIrd8RGHjjyl7Rup
         KXQOJIkKt4llyGAehpIUJjqC5DcDqnww/2PFtfkDeSUmHnriEAL3OSDHIftUV6jS+9mH
         lGFRHq3uVBqRQ5By0qWPAPjATyTXlOrZfQ2Yeabth6L95g0k1hZYfXny83HVDyFNWIT2
         8OK9AYrPVtDBiZpBk0Xh9H8tbtLzyq3BqSn4jfijcIYFOusGmRG5FExgM3bsFOkIBK0f
         +SYTDPJa8ZPk09pK63G4V6cHNTHFFHy/a7zo7v/lb2zv07NIVxKZTbhcNyR43dyPQbKY
         RubA==
X-Forwarded-Encrypted: i=1; AJvYcCUGIeo/nGtIgnY3LKvzXy2cmrCdG/x7G+JSp2qbi9xtXNV9smKC3V1pL2Y+PRnbLnpch7WIH8xV/pInkDpDwBIS4ITVRRhNmGJZV5MW
X-Gm-Message-State: AOJu0YxPXEvOHlo3sDiCWRCXHq1fg4SkBJl8VB8Bsm2xwGVjYrZZCJKr
	Ix3u/fFtCpXWKzs3rSkeIuKLNs9lBHyL+WwoaT+ANqvE9DVa6QOa
X-Google-Smtp-Source: AGHT+IGufE3eoOICGbDX7bEjamrSracJzS3rK65OoospbvJ4bZw+aIa8Ytp4bOT2V1liAOcVi6lhmQ==
X-Received: by 2002:a5d:6c6a:0:b0:366:e496:1caa with SMTP id ffacd0b85a97d-3679dd73a48mr5689649f8f.5.1720335268857;
        Sat, 06 Jul 2024 23:54:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678877f19dsm13204328f8f.43.2024.07.06.23.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:54:28 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:54:26 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] staging: rtl8723bs: Remove unused macros in rtw_mlme.h
Message-ID: <e04836b646ccd0a97ee0658dc61db7ac748bcb40.1720245061.git.philipp.g.hortmann@gmail.com>
References: <cover.1720245061.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720245061.git.philipp.g.hortmann@gmail.com>

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 26 --------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index f939d267b0c7..e103c4a15d1a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -39,11 +39,6 @@
 
 /* ifdef UNDER_MPTEST */
 #define	WIFI_MP_STATE							0x00010000
-#define	WIFI_MP_CTX_BACKGROUND				0x00020000	/*  in continuous tx background */
-#define	WIFI_MP_CTX_ST						0x00040000	/*  in continuous tx with single-tone */
-#define	WIFI_MP_CTX_BACKGROUND_PENDING	0x00080000	/*  pending in continuous tx background due to out of skb */
-#define	WIFI_MP_CTX_CCK_HW					0x00100000	/*  in continuous tx */
-#define	WIFI_MP_CTX_CCK_CS					0x00200000	/*  in continuous tx with carrier suppression */
 /* endif */
 
 /* define _FW_UNDER_CMD		WIFI_UNDER_CMD */
@@ -75,8 +70,6 @@ enum {
 	GHZ_MAX,
 };
 
-#define rtw_band_valid(band) ((band) >= GHZ24_50 && (band) < GHZ_MAX)
-
 /*
 
 there are several "locks" in mlme_priv,
@@ -252,11 +245,6 @@ struct mlme_priv {
 	unsigned long	timeBcnInfoChkStart;
 };
 
-#define rtw_mlme_set_auto_scan_int(adapter, ms) \
-	do { \
-		adapter->mlmepriv.auto_scan_int_ms = ms; \
-	while (0)
-
 void rtw_mlme_reset_auto_scan_int(struct adapter *adapter);
 
 struct hostapd_priv {
@@ -400,20 +388,6 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 
 #define rtw_roam_flags(adapter) ((adapter)->mlmepriv.roam_flags)
 #define rtw_chk_roam_flags(adapter, flags) ((adapter)->mlmepriv.roam_flags & flags)
-#define rtw_clr_roam_flags(adapter, flags) \
-	do { \
-		((adapter)->mlmepriv.roam_flags &= ~flags); \
-	} while (0)
-
-#define rtw_set_roam_flags(adapter, flags) \
-	do { \
-		((adapter)->mlmepriv.roam_flags |= flags); \
-	} while (0)
-
-#define rtw_assign_roam_flags(adapter, flags) \
-	do { \
-		((adapter)->mlmepriv.roam_flags = flags); \
-	} while (0)
 
 void _rtw_roaming(struct adapter *adapter, struct wlan_network *tgt_network);
 void rtw_roaming(struct adapter *adapter, struct wlan_network *tgt_network);
-- 
2.45.2



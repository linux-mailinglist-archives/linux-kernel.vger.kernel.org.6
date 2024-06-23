Return-Path: <linux-kernel+bounces-226373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D7C913D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02FAB2213C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4537184100;
	Sun, 23 Jun 2024 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilrUVrSe"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C91836ED
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165494; cv=none; b=twK6m4fiZJtd8y/xoRfEo6bEq6nrmnvUdQ+rcqlCbg4GMgREH6FgC9BqenIP5mc9djIfdvR+TUKtAcFbS3SUW3PnMA3OR8y38t17ECrF/petnVpMfYx2ZLUPspAkw7MWqZv8K0BvqYle4QNdWskcVXN0CxuehZVrpSXuGpK2SIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165494; c=relaxed/simple;
	bh=lr0vFNUnl5B5/p2sAh1b0ojBWqDQex/AqwCyZll/Aic=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR/GUjj/zmFoZKoBNX8DcGcWjIfTwUNPWvF8FwhDrLZeiuL3nfbZjT3iNRzRojeT2Jw32RIZ7NfoSOFX+DoBmidjXSJwJBF4Ji2lT2sruk3ywDpVarqqvQlhNwWeTuVnCbHurvqbwiFMGj21IPYtchE+RpuATQjEMDFDdrOtCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilrUVrSe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6fe49699f7so11082366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165491; x=1719770291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmS0+7dIG6j1KvwJzuM842xgAOh3DcpbPlmW0Wbnbpo=;
        b=ilrUVrSeuyYWRSTOqEpIoZWh3CovHvS4AFZIrqPEEJ1z3JJv5fz9QgYeE9Cj0ioloz
         L8GZ/sEPuZkMFFodFMQFt8WccvwFaF+5QxGg0kDxXwodNKCa/pm7GJq1lzppF/Kw4yBX
         JaAmsrbKUir9VgHRCO51fYpvwTYHSE8vUdXtLfDBvjUCUzeR5d4dIQ65o3tppvmLaTa+
         tY05ocUtt2PrubE9ujN/2ftZtmircwgSmXdO9cQlj6F8QnchT3YJpjm5pJtbsIhFpPsc
         NgxIs6hfkEWd8y8fQqkiMEYLPXS4vrdJQFygf5DZiKXmnjFVnApn0vYdfgSTCFVzVs9a
         FIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165491; x=1719770291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmS0+7dIG6j1KvwJzuM842xgAOh3DcpbPlmW0Wbnbpo=;
        b=eJoDx6Xhsbr9j7qFAFHPLMJPKkTWjJUmIlvoQLDUXqs+0/iElJTguedkAUPDp7dJf0
         CmT18TTtsGUqq+3+v+GHDH7cmAVt8TursTqVgIN08VTY9CwijnHQzGBYVP3LbLOaKd8r
         L60NQGUn5EWdLC8irNV0vgA4519mmN8d9l6HySF/ZD6i2jxaUyHXcrDKNpNacIYEqdP8
         F3cAfwrgwIUS3p0OSB5W3clWOm5MaefYPAaNVDdBuKFiCCVQOz18JlJ49qT9QffvQ/C/
         kn7bBatqixzBJEq+ZYWOMFSfiGMQT66ZKgQbBxeoT0dOt6N4AAk11S/F5R8vvPz4G89q
         I2eA==
X-Forwarded-Encrypted: i=1; AJvYcCVxJLKx7Wf+Zkwwu8IzGLNBklDl97ZNBU7BDR6FzGDz59bbKnaOVb2xS2mKFojRyutJ8/fHZ142rcraFrrLT36a8beX77Wm5y54INng
X-Gm-Message-State: AOJu0YyFkRvUj6ioEeaEj8KrDwzmhRhnSL6bhzSKVjajC2NjvWtLb3OJ
	T0MCWAFVfH15/4YcASRm7a7++6DyidL+/GSAVlmLR5D/DQp5jyI87vDEuw==
X-Google-Smtp-Source: AGHT+IErrsDko1DQ+IuS5Tgkp/Lya1O3orqfWbzYeJGrXCBlNxF5P/IQv63RBbnBhjTMjb5/j3PmLg==
X-Received: by 2002:a17:906:454f:b0:a6f:b940:fa with SMTP id a640c23a62f3a-a6fe77ef8bbmr257616466b.3.1719165490651;
        Sun, 23 Jun 2024 10:58:10 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7253a03c7esm35487366b.136.2024.06.23.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:58:10 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:58:09 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] staging: rtl8723bs: Remove unused macros in rtw_mlme.h
Message-ID: <289075f2b84a1ad9be85417a8c9736059ef709ed.1719155208.git.philipp.g.hortmann@gmail.com>
References: <cover.1719155208.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719155208.git.philipp.g.hortmann@gmail.com>

Remove unused macros. Removed also commented out macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 23 --------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index 7ce8eaf4ec80..f939d267b0c7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -26,7 +26,6 @@
 
 #define WIFI_NULL_STATE		0x00000000
 #define WIFI_ASOC_STATE		0x00000001		/*  Under Linked state... */
-#define WIFI_REASOC_STATE	0x00000002
 #define WIFI_SLEEP_STATE	0x00000004
 #define WIFI_STATION_STATE	0x00000008
 #define	WIFI_AP_STATE			0x00000010
@@ -35,25 +34,8 @@
 #define WIFI_UNDER_LINKING	0x00000080
 
 #define WIFI_UNDER_WPS			0x00000100
-/* define	WIFI_UNDER_CMD			0x00000200 */
-/* define	WIFI_UNDER_P2P			0x00000400 */
 #define	WIFI_STA_ALIVE_CHK_STATE	0x00000400
 #define	WIFI_SITE_MONITOR			0x00000800		/* to indicate the station is under site surveying */
-#ifdef WDS
-#define	WIFI_WDS				0x00001000
-#define	WIFI_WDS_RX_BEACON	0x00002000		/*  already rx WDS AP beacon */
-#endif
-#ifdef AUTO_CONFIG
-#define	WIFI_AUTOCONF			0x00004000
-#define	WIFI_AUTOCONF_IND	0x00008000
-#endif
-
-/**
-*  ========== P2P Section Start ===============
-#define	WIFI_P2P_LISTEN_STATE		0x00010000
-#define	WIFI_P2P_GROUP_FORMATION_STATE		0x00020000
-  ========== P2P Section End ===============
-*/
 
 /* ifdef UNDER_MPTEST */
 #define	WIFI_MP_STATE							0x00010000
@@ -62,7 +44,6 @@
 #define	WIFI_MP_CTX_BACKGROUND_PENDING	0x00080000	/*  pending in continuous tx background due to out of skb */
 #define	WIFI_MP_CTX_CCK_HW					0x00100000	/*  in continuous tx */
 #define	WIFI_MP_CTX_CCK_CS					0x00200000	/*  in continuous tx with carrier suppression */
-#define   WIFI_MP_LPBK_STATE					0x00400000
 /* endif */
 
 /* define _FW_UNDER_CMD		WIFI_UNDER_CMD */
@@ -115,10 +96,6 @@ MUST always be first lock xmit_priv.lock and then call any queue functions
 which take __queue.lock.
 */
 
-
-#define traffic_threshold	10
-#define	traffic_scan_period	500
-
 struct sitesurvey_ctrl {
 	u64	last_tx_pkts;
 	uint	last_rx_pkts;
-- 
2.45.2



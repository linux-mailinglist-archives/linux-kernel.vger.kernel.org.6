Return-Path: <linux-kernel+bounces-299205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF6C95D17B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A80280D52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1E188A2D;
	Fri, 23 Aug 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuCKmjhE"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136718800E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427264; cv=none; b=GRSL1E9Ar7NQEwrCyoCS0yiZu9jPVuop9Vt27iFm0emEdr4cvZBA9z0hI0+h9Q/N7G2KRbCp1BOkkLrIEOkDSqwQI6wbzqwohempIwOB+ONL+xe4dGGnqN4eQZ/lmrujjHnm/ovfw2INUqnv4gqGKzZPj3HvOu4XuOg0diK3xnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427264; c=relaxed/simple;
	bh=9a2e+v3FT14bhuAj+QqfdFafJhUg0z4MjKBWadxqB0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H49rOAMl4mo7NuJoThRWI2FpFXmBDQpVL79Wlo+kTAqivddLNZ/eGq/mRiQcHDWW/61twYlBPK0k1JVY2AsfahHRlRbGv0iAu0uG5OM5H5D3NF1ku2lWDD158EPVIs8uja0HbsbuhtTO8iHIijC1PDukAm3tj16jQeT6AJHoWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuCKmjhE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso1655653a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724427262; x=1725032062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvYT3UWBCKLp8ogLPWqf/Z+jzZrJA9UrUg3fh9E7FtM=;
        b=LuCKmjhE/j+phnODv2C3uOE5+gd3Y4rnL6NG1ooYs/7ZdPqq18HxejHKIb3RVyBbRl
         Z/OWN+KuPZ/iOwEgWC5l66Dc4hbIadIaO+4UoRltw8mug9mIObHcRommoJDBuU6JAKN/
         qayGGXoYQkcz37XfoxKQXvtnUkbDWkAiTwrdmeO8ZZkHPEqbzXgOB/39hc6x3HKIEF6t
         NNkgvwt+5YFiL0dhWu6fi2HjmqND1nvQ9b3z51CV1ZgAIARYmSFGuDOSaf8JFRRnoAmD
         d3bEUgndDlOH5UdFGAE/bWHkXkFOuEKrZnBcDjftV//khdVr1sqqQJMP5xrXEqWVaYzc
         RxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427262; x=1725032062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvYT3UWBCKLp8ogLPWqf/Z+jzZrJA9UrUg3fh9E7FtM=;
        b=B5lfX0sqpQR0ViLr6U3vg79zgrvH/NgbPsiZN0PMPnLLL5nQWkQimDRMEP4aLIyK0f
         CoCsNikMyaJB4my/wOLInE5MC7/c/yux0fnuQ3QKxogOOxaJCms/YP/pyxWSSezw/uEN
         CoFdd1vK8cm/h/CbM5nVYsrx63t9hdPa5gR2rWsP/gfdzAS7VPds1bY9Vb/G9aDCv0MZ
         2o11ObJNgGI6revYwFcxY7+d+emMb1wSeeqoeQjE5pderZYLtmuplOfooSfYKKL0YceI
         CXuLCYaF/yYa2Hek3Qm6EaP/xLGNJxkS2jOoIEEOzS/yIBnZwLEJqeO3oFQzzl+32zm0
         ZENA==
X-Forwarded-Encrypted: i=1; AJvYcCUb2LbmgWQWdrtKxJNUPPYnDp27JXSMPw3EIoVuMZQmz7aRjmpp3GA4pTwQhcE+JrJgzezwSefmJD1/0f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCaG9SP9Ne7A0VFOZiBkGaFVs8R+CsTkc1P9dvxs8Lg6abDBRu
	ds3qxg+2BMXh9yE9/8OaKqLpJEJkUvXUX/yVai2S8PgWMessiSqr
X-Google-Smtp-Source: AGHT+IFd1+TQM65D80wpYcq/4gnpICwdY2KG3PE3VutyDwjVB0LL6tzDDULZQp/CxaGN9r8zIiKXjg==
X-Received: by 2002:a17:90a:77c5:b0:2d0:d82:60ae with SMTP id 98e67ed59e1d1-2d646d6f656mr2630453a91.37.1724427261685;
        Fri, 23 Aug 2024 08:34:21 -0700 (PDT)
Received: from embed-PC.. ([106.222.233.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb913460sm6550531a91.21.2024.08.23.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:34:21 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com,
	garyrookard@fastmail.org,
	linux-staging@lists.linux.dev,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	dan.carpenter@linaro.org,
	christophe.jaillet@wanadoo.fr,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: Replace strcpy with strcat in rtl819x_translate_scan
Date: Fri, 23 Aug 2024 21:04:11 +0530
Message-Id: <20240823153411.74142-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strcat() in rtl819x_translate_scan()
Also Fix proto_name[] buffer size issue to accommodate all
network modes.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v2:
- Revert the use of strscpy and replaced it with strcat.
- Remove the 'pname' and replace it's usage with direct
operations on 'proto_name' buffer.

 drivers/staging/rtl8192e/rtllib_wx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index fbd4ec824084..ec0c4c5bade7 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -23,14 +23,14 @@ static const char * const rtllib_modes[] = {
 };

 #define MAX_CUSTOM_LEN 64
+#define MAX_PROTO_NAME_LEN 10
 static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 					   char *start, char *stop,
 					   struct rtllib_network *network,
 					   struct iw_request_info *info)
 {
 	char custom[MAX_CUSTOM_LEN];
-	char proto_name[6];
-	char *pname = proto_name;
+	char proto_name[MAX_PROTO_NAME_LEN];
 	char *p;
 	struct iw_event iwe;
 	int i, j;
@@ -59,13 +59,12 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	}
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
+	/* Initialise proto_name as an empty string*/
+	memset(proto_name, '\0', sizeof(proto_name));
 	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
-		if (network->mode & BIT(i)) {
-			strcpy(pname, rtllib_modes[i]);
-			pname += strlen(rtllib_modes[i]);
+		if (network->mode & BIT(i))
+			strcat(proto_name, rtllib_modes[i]);
 		}
-	}
-	*pname = '\0';
 	snprintf(iwe.u.name, IFNAMSIZ, "IEEE802.11%s", proto_name);
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN);
 	/* Add mode */
--
2.34.1



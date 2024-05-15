Return-Path: <linux-kernel+bounces-179411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEDE8C5FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066C428346B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A924A3E470;
	Wed, 15 May 2024 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="hlJ3kNii"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD63B1AC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748760; cv=none; b=hBePPWXfM74dJLq6H/SwadnQdLZeDCfefwG8cv9rxVoooicOkU0K3X+NHt3JY4HPysZ26ovV9QmA29Y+HYdpB13rehuOrkUSgIQnsK1rnNAKfLRzhVx7SIPEZ/jNwxwRRMhjQiZabWump3/sBBlNCYM2uw4j9JPgYfOi91g2tSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748760; c=relaxed/simple;
	bh=p5QrjqSMLh3C8Hnh5NSEldYXViZN0be6lfcWjlh+Ng8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZiGzjfBfXEjlQuNxPM89hRDs1ugKbs/dAZDQQYmRk3NikDR6AemlB+lSsUrtHP2WUGgCaxHWd/86zMQWU0SV+c3nj9UXmyn2EFt60ddXEcWDvQl1I/+/162jSWqK5mkSbLRhgRbkisRd5LTaraNyb6Az972P8duhR2yQHUQajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=hlJ3kNii; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c99d0521cbso2495538b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748758; x=1716353558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkWCUuQ58U/Du5A5sN3Nb9vbIZaHHcSncvI1Bx9M1F4=;
        b=hlJ3kNii6guIOAUWQtnt9Ps/HwB8buH3fSxUZl/djg0KO71Nk1sS0a2oT9FOrBcgGX
         4tV4UMD8cMIoeS5t9oCqP62A6rkWd8t/NMeTFgT2DgMwINsKSb4TbNltNo1JYV42I+WV
         ltui/U9DwXntaTmcks66Wz9encIgnHzoI4H97NWYhScGIWnadkdIhQB3igJWCJyVzV95
         YNRv6+reXItOn8iDJribSJi7p1P4Oazttr1R1ZP9/rxtyVTOiYuxXbJ/YZmu1Rm3fPzZ
         o6uKru+94sNspnjguFKEorPEoCTUscWTGkfIqKy7FCad7w3E9YpaN3tkOJpMQh1tpRo5
         /C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748758; x=1716353558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkWCUuQ58U/Du5A5sN3Nb9vbIZaHHcSncvI1Bx9M1F4=;
        b=nStohTrc7r9seW9F8vGn8XligamcijRBUoAHLvJB5MJEs4DTk/ubmehKIYZaxeneg/
         vwTyBDiHrCH1bFGOivjk0QhjjBJIu8cA9Fple9xeKfLIdI5r1NTA62SMBj5MK9RxfcFG
         Y8PWakhdaFH/vSweaGAMT55mPXlT4goHQkj1UmvXVhBanaTPa62l2oJJrT48KRhr+FMH
         /jqgUqUxfQ1HMzjwb/1XkCpo9qIu1975rPmFdYZdzaTRV+kg4SFmRBSBiXzTjcBygjDY
         BOtIg7935zeH21RNFwt4ljBN5knW+A54wZt0+eETbcJMLM7n3/qgZZtP+NJxKG1msbgD
         gVzA==
X-Forwarded-Encrypted: i=1; AJvYcCXeVzo3MejAgcDBLosGJLKURbez+VUP9wHkGOiCA8MbzW9OQCqRI9Z8zRc8labu6lcF8KJtyknKl2gAMlazAnI3ZDVjJHfILExn5S8o
X-Gm-Message-State: AOJu0YwEA+2pfyATz/CU8wEkGjI7cRWcSfgQDKY3JDmgcmIC5H6520Zl
	OGbS9B6gvqEDsARcNOdOPk9sqZIJG56R896ranGDj/aV1L4Mbe8yMjUr+PYr0lg/Rw46wopFeyQ
	W
X-Google-Smtp-Source: AGHT+IGxDb10Z+0G2o/84Zt6O13liaWmSFNlegXU40W0XbhGUcKWfwRdmmavROorwt3kjUksvZ0Zlw==
X-Received: by 2002:aca:1311:0:b0:3c9:70eb:151b with SMTP id 5614622812f47-3c9971e10a7mr13733680b6e.59.1715748758588;
        Tue, 14 May 2024 21:52:38 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:38 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/31] Staging: rtl8192e: Rename variable MBssid
Date: Tue, 14 May 2024 21:52:03 -0700
Message-Id: <20240515045228.35928-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable MBssid to mb_ssid
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ce0cd1f557c3..7f1c2f49227e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -916,7 +916,7 @@ struct rtllib_network {
 	u8	CcxRmState[2];
 	bool	bMBssidValid;
 	u8	MBssidMask;
-	u8	MBssid[ETH_ALEN];
+	u8	mb_ssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
 	u8	bss_ccx_ver_number;
 	/* These are network statistics */
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4e7c491c0aaf..c29efa3eef6f 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1823,9 +1823,9 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				network->bMBssidValid = true;
 				network->MBssidMask = 0xff <<
 						      (network->MBssidMask);
-				ether_addr_copy(network->MBssid,
+				ether_addr_copy(network->mb_ssid,
 						network->bssid);
-				network->MBssid[5] &= network->MBssidMask;
+				network->mb_ssid[5] &= network->MBssidMask;
 			} else {
 				network->bMBssidValid = false;
 			}
@@ -2351,7 +2351,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->ccx_rm_enable = src->ccx_rm_enable;
 	dst->MBssidMask = src->MBssidMask;
 	dst->bMBssidValid = src->bMBssidValid;
-	memcpy(dst->MBssid, src->MBssid, 6);
+	memcpy(dst->mb_ssid, src->mb_ssid, 6);
 	dst->bWithCcxVerNum = src->bWithCcxVerNum;
 	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
 }
-- 
2.30.2



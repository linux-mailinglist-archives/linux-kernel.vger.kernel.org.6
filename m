Return-Path: <linux-kernel+bounces-229600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB55917136
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553B81C2264D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB417C9FC;
	Tue, 25 Jun 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOHBC1fr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA753D3B3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344766; cv=none; b=DePPIxC7rIttrGYa4WeyXdoALaiGWkr9Y5BwquhGlXrPQmP/d7jjDnd86Ow291s1+5IIoZ0wfFmOM9xSOAherW98sRRYw1Ox+6YZW+/w6BUK7EavI9JDKRUat1DJ3PjRubraf1hJob72jbPT6wzfPig4eLgkTztXPM8zEzhWh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344766; c=relaxed/simple;
	bh=VwBrEZVFp25N9X9nSaPoLwiMlNl+UokOPiDvV1Ha+xE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K3pLazd46HLcnJtz8DaiaTsdZRwIsfH5aQCSLWMLrrBDtDvnGP9nD3ybWExjvJSluBw8fa5/SI7ei89fwOZi145/gmRV7P3FT0k0Lh3NhhLh/7Wwa19miWzeLWB91vpn76ACX7je6osIzfW+/UvF7Lt80UOre7LE7CK0aQ71IGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOHBC1fr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-424ab8c2d95so551705e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719344763; x=1719949563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uj592VFsfsXigJjlHKa8dxpsEP+lDZMRz5sitwN8a0k=;
        b=SOHBC1fr81Ij8Hs+oYDv4FRQpQ6JKT619Hb94DOPIOJJgM3GuKQiT92k4H0NxDk0XZ
         o8wmr/6tBAMghvuTbGgyT9mOc8KTUTmu2TE3fdEpBx9qJ08yLtnFH+PrTpXsSEsfF86J
         e7RrD4btaXCMdSn0tC+FhLbVXg3TaX7K1moO1RxkWn7EuHqRHyJleLuU6zMPnwXTXzEb
         qgBnhJ6dk/cyC2JpgMye+yMftJzfaptAcFRjJcGDTnbAUv/VX3QE9otEtoy6mLE4QeFf
         c9L6vUOMmCR+JqrqNNsSu8/a2CPNRKZ2Y8ZYeahg24BVrT3vGK3s0BS2PzFZNFiEeATy
         ARjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719344763; x=1719949563;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj592VFsfsXigJjlHKa8dxpsEP+lDZMRz5sitwN8a0k=;
        b=V4xSX5lwf7vOJ3ByBHflgS8R4mh1KELCthUB0jsxq5EBGwh07M2vUiTJ4OY6e/PwZN
         TD/9QFsIACXdR6ovrtZNn7XuImevM+Npo6OBzO+8D31A5fD6TzPek7OVIiEuWpJzBTiz
         gv2oTI7jiDdLiQlJocEFWf1B06fAK8eaeTv0RpZxvZixCi5MHsG0SlED45iP4icBa0BB
         FrWa9SJkiw4TCvVwjHCLN/c5I1A54xDNgxEMzglXpXsgKH6NxWUdLR6Wy0yH4cyAFOPR
         Oqxey/vMjLsPk4w2dYhzHbiwJ2Ve+XXVamKOMdkf/LkH9Rp7hom2dEPKZdxPeqivL3hA
         kIBw==
X-Forwarded-Encrypted: i=1; AJvYcCVULMna217znjapUFFyuaL27eOuaAsa2DKUwU8l4q/x3I8I+Kbof5IXpReJG9sfYqkeFUa/E3sC0f3NRYBilQR1PQOghjfitwL1ga62
X-Gm-Message-State: AOJu0Yw11DxNQ2c7f451U4F8dQ1+c62g6BOXj14vICPmvOl7q/eLoivJ
	uS34rhfzB0dfy8kVdGjRzilZ11njpEMk5HeoY4jrEr/pNfAbY0NUNEv8XQ==
X-Google-Smtp-Source: AGHT+IFdeQrMKSiBuQQY+9Ba/MjPwOWVh6dSr+tITWeZVHuGdXgj2KK5Q67gqOADz3/VQb9LzbTAZA==
X-Received: by 2002:a5d:59a4:0:b0:366:f743:7f92 with SMTP id ffacd0b85a97d-366f7438017mr4163387f8f.1.1719344763315;
        Tue, 25 Jun 2024 12:46:03 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8aa6sm13833708f8f.105.2024.06.25.12.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:46:03 -0700 (PDT)
Date: Tue, 25 Jun 2024 21:46:01 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Remove unused variable pwdev_priv
Message-ID: <20240625194601.GA16828@matrix-ESPRIMO-P710>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unused variable pwdev_priv.

Fixes: bdee203cd80c ("staging: rtl8723bs: Remove switch(type) as type is constant")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406250759.FnxzD3PK-lkp@intel.com/
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8723bs in ODYS Trendbook Next 14
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 2bd8b1447698..eb3c73cc2662 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2550,7 +2550,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	u8 tx_ch = (u8)ieee80211_frequency_to_channel(chan->center_freq);
 	u8 category, action;
 	struct adapter *padapter;
-	struct rtw_wdev_priv *pwdev_priv;
 
 	if (!ndev) {
 		ret = -EINVAL;
@@ -2558,7 +2557,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	}
 
 	padapter = rtw_netdev_priv(ndev);
-	pwdev_priv = adapter_wdev_data(padapter);
 
 	/* cookie generation */
 	*cookie = (unsigned long)buf;
-- 
2.45.2



Return-Path: <linux-kernel+bounces-226363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB453913D75
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4AF1F21307
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B2184132;
	Sun, 23 Jun 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0Q7ssI3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54D184107
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165421; cv=none; b=frJwakylieDmIGwzyyvc0wQ1lcIKFdX4M9yi8vw5zqXYMDrlKeLjl/t8aEUnHXOd7T2dr3SEZ3yL1U16Ona4eflF0oFDo3nHpmajA3/9KXEXAWpRgfDBDmWiCFrafPZ6S7JAsBayirF4I+p9WrC9Nrio6J345qOMZXTq2RiEi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165421; c=relaxed/simple;
	bh=ExoCJqTpMco12TXZTdMcBWBFpKtZp5Wcm0EG+hpigtU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSDCgcx0isHtIynoQblPpL4zEoxTgN+iGN6Tpa6RL9IGm1rJKNhguRaqZE1aSb3eQG9PoHfFhessVKbND85/JPha3UgfUq58cRLakBtTgBmroEpHJaFWKgpVGhRENM22xgi0xyzINGFq1a0abrrDlnM/jjaq40moid2ayNoyP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0Q7ssI3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d3125e0baso329077a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165418; x=1719770218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djIlclWDul2OF8+tWR6DtUTqi1t0I4XJiTb+scEysCM=;
        b=E0Q7ssI3lKSn5oulMWy32qIU+rOfNz7zL5BLIJb2pE8nTIE9yPX839UuqmBDlQ0lJs
         Xn70SVs8/Ojtn6t+SVnuo9w7HQ+66a04bccAIzUH7LsbpMygwcnsr8mPUmJ0Y4b4CKWM
         7jO2NXIpKjdyXgj4IECRv7o4nSTfSNY0vqwNY79j/qsk7ENMJrcUOx0/NGe+6LNXOf3T
         Cwa2H5gtxI4mWZQqpuEfaxAqMVVgMaYOJ+wBv72LLHZDIgO3fzgBjWWiZIDxEKKDSJyD
         E57RzkJTxbPD0q5r7Jqo78ikfeSPaVyzRJP80DxPgLwvHOrVZes2BaCwGo3UszhtksDV
         SYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165418; x=1719770218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djIlclWDul2OF8+tWR6DtUTqi1t0I4XJiTb+scEysCM=;
        b=MgG/ggxJ4coXMAHUN5cBG4FBOsmy5X3xWuc487fQjOxeE5MMRWtCsmRUHpb6tLEXFE
         BbfeEGtbAMetLKtKUCnLG2Um6SP+N7ARBlehruxaBmgw+tmMPYh9JcuiFfWr52v4C3ZG
         1DsPa8PrpArQfhuw9VH7bA2YShTgrj6iPEqFtFhi4KinKZKvay3yXALi778yLzda+Sc/
         p+9rWJ5EpIS7nSHYW2zj4dz5WkNDpN9tU8+ruijJR6VFM3DA+82pvtPXdUImh/Tym+uH
         CMb+5eihEAKk0GQccWaQbM3SMZlxjvqcEcWmmj+yLSL7zEortL/RTSOrRmk8Qkov7r8l
         Jw2A==
X-Forwarded-Encrypted: i=1; AJvYcCVCcfXb+YlBlTfW5j9SfJQU4UozVTvYmlYF7sc4a76T9Lo/v4JH1zSEl3LOC9CvyarOSJCxVYDAU6DWGvUUGiaGrg0N4UU+ZzxslDdI
X-Gm-Message-State: AOJu0Yxd/2o6QWVNc6FLtIv/XPLa8hKYpL4EqNuQonOK1xdPY2qlQw+1
	ba5nqitIuBLYQScdyc25kMT6W5T3gqhNwUds5z71lrWu+nGjs1+y
X-Google-Smtp-Source: AGHT+IGO1NegMuAyrjbF7I54mk1qrVBtQ9O5ZGBQwD1ddMx6OB0srVIgAQF7GFLq0qY30lmHtnxSHQ==
X-Received: by 2002:a17:906:2a14:b0:a6f:bbfd:39d1 with SMTP id a640c23a62f3a-a6fe087be90mr271154466b.2.1719165418208;
        Sun, 23 Jun 2024 10:56:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724adc5dd4sm88899266b.129.2024.06.23.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:56:57 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:56:56 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] staging: rtl8723bs: Remove switch(type) as type is
 constant
Message-ID: <1e3982de9a03e75931bf7977fca83c5402084aa4.1719155208.git.philipp.g.hortmann@gmail.com>
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

Remove switch(type) as type is constant and never matches any of the
cases.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 3fe27ee75b47..82722897d6cc 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2549,7 +2549,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	bool ack = true;
 	u8 tx_ch = (u8)ieee80211_frequency_to_channel(chan->center_freq);
 	u8 category, action;
-	int type = (-1);
 	struct adapter *padapter;
 	struct rtw_wdev_priv *pwdev_priv;
 
@@ -2581,19 +2580,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		tx_ret = _cfg80211_rtw_mgmt_tx(padapter, tx_ch, buf, len);
 	} while (dump_cnt < dump_limit && tx_ret != _SUCCESS);
 
-	switch (type) {
-	case P2P_GO_NEGO_CONF:
-		rtw_clear_scan_deny(padapter);
-		break;
-	case P2P_INVIT_RESP:
-		if (pwdev_priv->invit_info.flags & BIT(0) && pwdev_priv->invit_info.status == 0) {
-			rtw_set_scan_deny(padapter, 5000);
-			rtw_pwr_wakeup_ex(padapter, 5000);
-			rtw_clear_scan_deny(padapter);
-		}
-		break;
-	}
-
 cancel_ps_deny:
 	rtw_ps_deny_cancel(padapter, PS_DENY_MGNT_TX);
 exit:
-- 
2.45.2



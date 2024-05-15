Return-Path: <linux-kernel+bounces-179414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B58C5FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CD7283C82
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D464503B;
	Wed, 15 May 2024 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Z7lzfNOp"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885E3DBBF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748763; cv=none; b=cz56B16kEWTnFEqD1+qUhvYmPugd7VXnmVhJpJ29NqnpryvpmOXzVzvu8ZL1EVbS2dujXgYkAurl4YoB9NfiI6v9Z2U7vwOvTi7zuEA1/4l65Pcdcimm8Bq7tyrUOaInB8qxe/hVKYSl+MwPtuHuzqi6eE72mpHr9aedGEOaUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748763; c=relaxed/simple;
	bh=GyNRy50iVJ8CzHvzzyr2UB/FzU3BE/8SBY88bWxnEJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D88MtX5fhQC9H3WuESWiSCAcBvnOwyMfKW2xwZU0z+dh4MrFC9XGcn0RI3ThL19AR/EX/x5jB5MUpxkjNOTqxGu/VlQO9/6dPhqeIsFi0VZdjXFfTE+NyhsKQoR9h00PvqtxiUd3nZ+daAkja8RqkGe7hJLP+K8FHwRmc9YC1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Z7lzfNOp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f44b5e7f07so5233176b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748761; x=1716353561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKnRcK17hcgNmkRBQJJ1T9dJgIQuI3ZGebQCDIapiBw=;
        b=Z7lzfNOpZVimIthYNtankiSxuV31TZP5XhdJGMayCRU/bH0/rw37/+jFPGycO5xS8v
         z4Kg9V9e/owYNpk0U+JEobutdJIz7w9LZoxCr+WkvRRMe97nwH5lw9ATNOUQf5wMm8HC
         nA4BP+D/CJhyGiCargGpJP7wu9kvyKF6qJ6Re+XGif1DzGO76i3PuRR0xRPKs8Hkpl8V
         999Tuux/VfOmT5Jpx7PvsufmqCUNLcI11WClTz658XsYmfpS7KLcWWoswRXg4ATFNDKu
         Buc9JH0OTvLjPw94SixzA/IDeUzqvlKF0ss4Q4kp+B9XKB2e6updrbB02gLP78PznYZy
         AqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748761; x=1716353561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKnRcK17hcgNmkRBQJJ1T9dJgIQuI3ZGebQCDIapiBw=;
        b=eZrV+lDiM1z9GWNd4WCnBDTiFfdcw3pgl/ptRcZ2Hcokgw5FROygQQ2Z6lqGl2NNSS
         oy5JJo/DBJesS3rByGXX6lSj4mpTN0SKi0BgbGM28VH1Wnem97ysj+Cr3FVxlqQZhxHc
         0xORZ/5clMkiSrAT4hlMpXCTvxMBKizJB3rG7c9tL1wdaZFXd0RUSPQjyvLeqIpB6zM6
         S2EJStAGrqZD4l6i/aj4ZzYe/+Z7q5nJ92d8ROzvkPNC2WLI3lo1JG6LAB1rksElznW/
         DypAwI7lvuPTY7Dc9Lg/mWXvhSpvd/NZkDy87Hrb1AKY/iY0KEiFA6JyGq+w5NT28ZAy
         qmKA==
X-Forwarded-Encrypted: i=1; AJvYcCWkZ7ny6bTWyOv/Ev19zsOi19e3AXjTAKeP76MV1DsQnwKDPtMlxBxTUMVaCS+IWV6NW6cJNrWJa+qqWwu3DPJ3jy9qT16tzBdWP832
X-Gm-Message-State: AOJu0Yw33/4d0q03s1ukmD+bS64Tay2vLp5SfJ2R4Yb8PbviQTX/+CTT
	ZSs3LSaWkoInabmHi4tKTDDskQZfFy/YJgPDk/y/dcbtQ/DSctxqzUThzFUjoSU=
X-Google-Smtp-Source: AGHT+IEoJMfmvJz5Xb6i4RqmtY117K7L5+CRsRRKqbQ7AqBeF9TxfIV3yUZga7Tol11qf6rvojuSCw==
X-Received: by 2002:a05:6a00:cc3:b0:6f3:ecdc:2248 with SMTP id d2e1a72fcca58-6f4e036b640mr15969006b3a.27.1715748761062;
        Tue, 14 May 2024 21:52:41 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:40 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/31] Staging: rtl8192e: Rename variable rtllib_rx_Monitor
Date: Tue, 14 May 2024 21:52:06 -0700
Message-Id: <20240515045228.35928-10-tdavies@darkphysics.net>
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

Rename variable rtllib_rx_Monitor to rtllib_rx_monit
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 76389aef53ee..108fe1520cf9 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1383,7 +1383,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	return 0;
 }
 
-static int rtllib_rx_Monitor(struct rtllib_device *ieee, struct sk_buff *skb,
+static int rtllib_rx_monitor(struct rtllib_device *ieee, struct sk_buff *skb,
 		 struct rtllib_rx_stats *rx_stats)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
@@ -1434,7 +1434,7 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 		ret = rtllib_rx_InfraAdhoc(ieee, skb, rx_stats);
 		break;
 	case IW_MODE_MONITOR:
-		ret = rtllib_rx_Monitor(ieee, skb, rx_stats);
+		ret = rtllib_rx_monitor(ieee, skb, rx_stats);
 		break;
 	default:
 		netdev_info(ieee->dev, "%s: ERR iw mode!!!\n", __func__);
-- 
2.30.2



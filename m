Return-Path: <linux-kernel+bounces-184433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB08CA6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35B21F21776
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF654913;
	Tue, 21 May 2024 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="hsN0zHq2"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90A18040
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261450; cv=none; b=eQflZTJM+hyeRaqNl+8iqIxVLDuIViSv5Q5XzzNXg26ZtclgK9FULxpvzamASi/NeebsBzgJDaErhdmmIQf/qyt82yh7O2DjIB/WLEiL+voK7AURxMUEqLNnEBJEn7uYBpafuEb8IRmker3V4c0RfutWG+7Ihq/4oaJeFTGeQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261450; c=relaxed/simple;
	bh=BUrbjzcQWwyURME4rVWO/h6tgucWYD5267uEWABz2kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0IdWz5/EnfbGAFB6LMpbU44hImC2wuzL6kC8JQXCF/ef+HfmlBohYPRe0pHBgBR3oqzRzZzz2mgcj/cd6to7/YCZMwC8b4MRDxJdDZ9IjxrioNbHeKyNQPHYrBNPIg/wDUMlaxJ1E9HFLaTstk+VrqFCuO7kneEXXdLZgnm3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=hsN0zHq2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f3105f3597so1963855ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261448; x=1716866248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZwyL+RFncPuaE+b/XOsaY3FBas0Jn4bpiLgCt4nDwA=;
        b=hsN0zHq2pqz0hPApH8aJzJFu3vAnjOScpgZwlFiXV2+jOjdEneI8yvfhEZQ2T6nu69
         ZX6ViSGo6iMZnscl+9/0oVqXFyd4wgtpU6IObhevISVLs/INaxrTp/n3JvuPDNznD+x8
         CjXCcxqzIu+jyYitI17L/yb9A9t8tp/kJNFlnZIyDmYLX4oUEI4MK18HFE3nu3I2hRr1
         HcrMLEVo+YUDGEybYvKUbJVfs01mvkWkevqW0VnXhUWfLnjF+7N38afVjW3jrou5hOwK
         IYazG3NJ2RK6ARrrK+4nXF+Ti9atgCDmE9BPdXx9VQ5855MeXLaqnnRMQMPlUHwopPaN
         3j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261448; x=1716866248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZwyL+RFncPuaE+b/XOsaY3FBas0Jn4bpiLgCt4nDwA=;
        b=QEPlZv1R3psR3ov9TW0eG5ZtPcXkmbfklNyykcFndzFxjXVlA4BA5wbnqkK6l9OylA
         aVqxw9Lw9pGchUzFSIjTyAB5NMEH1aixH+8zyHJmPYyUm9z9DGksUtu56/gAyfPb5zbe
         P9o2TPgXiU+cylF3vszSnBiSegHsKZ2n3E3nKgeIg4zrTDdyNeRJMuQTQxIkpMQ5f8nO
         7AWJpZnobZ+n698s+7Qc7EtH4yR/FOvl59rGQGwLLMgfZFge1GvEMOhEcVJcS+vUGizO
         BO3leKXXtwlAtJIACk7GnrBxEXdhDGWClINqyomfH4IK69StupuN0nC6jHpt1PDU8yHK
         QVxw==
X-Forwarded-Encrypted: i=1; AJvYcCVm6vX8/atKBmpvulFUgStdUAwGaPwmjjq0qDTaRzakJCZ3nepJVivnMQG3ETOne5K0cNWoSnssNpWxBlFWeIM/5ZCac1fYG4ISTlyn
X-Gm-Message-State: AOJu0YzHrAcK0tG3JB709eVGI27bw2gnjdv32B/DmICD2SiXhyZ2AQIb
	AlDNSLqyAjxRVzASPkaS4KyBoWyoPj/6jJxBGOd3uNR+uyy/mqjchTkRqZIB1P4=
X-Google-Smtp-Source: AGHT+IGyMNiay+OKPoZtkCBgoCgQD2kIuJLu79V7dIocZ4883CscupBlVT6PBm4ZfOBZs+l6TZHs0w==
X-Received: by 2002:a17:903:1106:b0:1e6:1a7a:98df with SMTP id d9443c01a7336-1ef44050d9emr371334135ad.66.1716261448514;
        Mon, 20 May 2024 20:17:28 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:28 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 09/31] Staging: rtl8192e: Rename variable rtllib_rx_Monitor
Date: Mon, 20 May 2024 20:16:56 -0700
Message-Id: <20240521031718.17852-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
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
v2: No change.
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



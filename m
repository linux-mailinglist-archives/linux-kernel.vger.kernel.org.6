Return-Path: <linux-kernel+bounces-179415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFB8C5FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B1A1C22177
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F48487A5;
	Wed, 15 May 2024 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="g5sMK1H8"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319241A91
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748764; cv=none; b=TB4X+7cvMeZYu4Ibu6L9X0VvPhlCLx2BZhuc/5bXthk68NBauf6Q05cQ2er0PHeh/QnzZenGOH8odakovsoJ9b7OYvS3DnKmZ27Y3s3AVyzRvSj5O8lmCZvg6A+nhQUqRkJfXJ3pe3ZNVIRSFGDhMRpg26OIxllBMnJmCwISem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748764; c=relaxed/simple;
	bh=G4Wl0EW7TkdNWDaEvnSEH82i035fcRPaWk9aCJ5U+Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YmvhTENAkPmt8ht+IegqwBsUhhH/J/2HLgpg70urtjQNJIuHST+PeJS5sTVKcX8v1+iDiaY9OmH9Ej4OL8+tF+AIHPVi9rJ2kwLJ+wPVFfqBZ8MBM9mtLP2vX7vLCoE2OFa3IGI4GIMilnFHsM+jX2H48zLW3BpZ5++40UGrIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=g5sMK1H8; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b295d6b7fbso2446265eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748762; x=1716353562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v6sT1qmzrcclK3POxawe36qikIVYRE9ws3li7lPq08=;
        b=g5sMK1H8Ua2LM1X+XzcBf4SLpdkNYOHEE+cG92mTiGFywDJzmvKFKhnemvaLp11ccC
         S//mOXjCnOTD5+MyOnvIeGdsvUTx5IFnEvpvTrUl5Jb6QpOKIwqjyp1Om4BY5oIiI/fI
         gqVE2SNmijv3C6ARwaEuacn9IELgrhEi2F2k8CRTazqj8Pdty/tby4Y2GAd++Vp4HhUM
         /HRPK7snM6Xb7cNl1i+lYjIN4XD6iftpf4Ki+Y3oy/3JXSUThEc57LcI2sVZxJRSy/Um
         PNOsBOoJQOgOxIF0+q6PfMWfvUv15l+LuJp0+63tgwhZl4Egrj9Wtw3RWVUe2BYrETMv
         66gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748762; x=1716353562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3v6sT1qmzrcclK3POxawe36qikIVYRE9ws3li7lPq08=;
        b=tdfotYCQg+ASgEf9Pz3y2miRBAWGk1QYQRt54kXCNNDUjn60tY/I4VuH3cyrkq6+b5
         PM2zCLBl/z2YvJETXCF6QK87ln7AMQEn5Dz7Vly4uETkYrmqhbTVxrjds28J58Shorgd
         C3QV499bqIqKtnwqfsGIorHVzhEdlNiYg9QhYRLMJzXWAoybxwEOB4z7T3fSz7+JIr0p
         fM5mnUyitm11mujI304g0pOazfJ4Mzbv8kpWcf6cq0ur6h1yHiUzyBtbRDncpApMXnOG
         N+OilafSD5DEmVQJlx/MarCUo+m47Ft2lvKVFzvl9F39c9em7vgxeUj5DLpOg9DafTfd
         WYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWxrZG7KpKcnk+aeksrmaKe8h6vkbzx2YkZQ6f6RTCCurScz3Wx5A1n130MroYXU8jUELPn7QDjhKq94m/+9o5FA8OHn0MmYp9lqxE
X-Gm-Message-State: AOJu0Yz8daT76XHOX1bgLdfCGn+MT4CefFO5uFtbNX7HmJu79H2t791l
	Naqgj7ojOu5D8/16HXoP5bhC+khidagsxxSYLtzpGtjM6efFebKxOXyjukg1ZGw=
X-Google-Smtp-Source: AGHT+IEro0x8SgQC8g7l1699kTobqLsA4XG9sl4xwdXejRWKjL8eEnw+X9b+m908k1fuIELveG67Gw==
X-Received: by 2002:a05:6870:7b52:b0:239:701f:fc32 with SMTP id 586e51a60fabf-24172a23544mr17003915fac.9.1715748761893;
        Tue, 14 May 2024 21:52:41 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:41 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/31] Staging: rtl8192e: Rename variable rtllib_rx_InfraAdhoc
Date: Tue, 14 May 2024 21:52:07 -0700
Message-Id: <20240515045228.35928-11-tdavies@darkphysics.net>
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

Rename variable rtllib_rx_InfraAdhoc to rtllib_rx_infra_adhoc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 108fe1520cf9..ea8cab9707bc 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1223,7 +1223,7 @@ static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
 	kfree(rxb);
 }
 
-static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
+static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		 struct rtllib_rx_stats *rx_stats)
 {
 	struct net_device *dev = ieee->dev;
@@ -1431,7 +1431,7 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	switch (ieee->iw_mode) {
 	case IW_MODE_INFRA:
-		ret = rtllib_rx_InfraAdhoc(ieee, skb, rx_stats);
+		ret = rtllib_rx_infra_adhoc(ieee, skb, rx_stats);
 		break;
 	case IW_MODE_MONITOR:
 		ret = rtllib_rx_monitor(ieee, skb, rx_stats);
-- 
2.30.2



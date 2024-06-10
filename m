Return-Path: <linux-kernel+bounces-207679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041A901A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E2D281B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC374043;
	Mon, 10 Jun 2024 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="OGj1PlWd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79A58AB9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998551; cv=none; b=GwLxB/gcvhfgw3u43zXey5xZHxnTxClaNYZwVbVnjiOYFpE8q5m4/jaFdtGeEReSEN5Q4m+KGdc8XlGGaOV6z5a/Levh9HjHKk6DqGMKPb0GTGdd3U9rQ/AH5/hDYR0hsjrDdEz534TXSEMf3XFYKNG1Cn3sk1Av64hZ8/jYeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998551; c=relaxed/simple;
	bh=TWH+OTBjvp8ox1Frtu2Beh1ekTMCDrvI93IkEmBGW5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZhw421fpJ9TiIK+dGdy3s52T2HhW3a1InjbzG9Hx77hQ3WjGI+WfGSknrfwEjC6NsY8ClQc6mCJyj2hxTJ4yfvTTIMg1qXbVpVCMnjPT2CHK6uKTygKMzxEx6zjLvMsN4FWQnVkB9UKOxEne52liO72yGCOLdSDp/3ScSKdDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=OGj1PlWd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a5344ec7so29457535ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998549; x=1718603349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/YOJlJQUY9anIeQSMAFNoVm85A4u3h8rUzTpCA0Cf0=;
        b=OGj1PlWdpNalrDCZ2/MCFtTWT/GvSZxmNVfKnKMQ90D2ti4lZb3we4fkiRNWEQH1NR
         zmWQM/VQ3eahbvCPFrokw/iLSpDanDRTKtU9k6zLFaFqTRcyuXR06cjR7/Fvi1sFzo0P
         XcHfVMPS6mr3GKL/GS3TBaLzkEySkXIYQi5wRU9QMAZyVYGf4e/bSQlsvQ5NM8ykv//d
         UCdejW9gPqNvFtYoT+1Kqvrfi9PIikduJNy02PKy0G/Q/j0/tVeEH/KwLLHIgnekBcE1
         geKK6qf0r6T25/eZ3jw0x/HmZDtOod3cLxof5BaYmiSJfxnc9W5aiqtrniHXEc3KWt4x
         F3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998549; x=1718603349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/YOJlJQUY9anIeQSMAFNoVm85A4u3h8rUzTpCA0Cf0=;
        b=TiNVPOzyG53C+/VJrZSmzTFEmg7cjMS4MmcI4IDk9qbk0ptWo7H0KZ1lMf2HW3ODg6
         bdT53z38jDYdz7zLSIUJfMaek7+nx0PRxF6fDCCcyuIhB1/8TqCBZTFNzZZNE+7MKGvE
         8Dq/OWJoc57F8eRRgWc1xYPXPnc1yPrTLswf32Cqs4aZDSZpSLv4zS2KNeGwzb3T+5OY
         pSUqQgnSOC2e3lbI+gYDnNL+Zg/DCM2PoNXm7pz62fbWqziVQ976JUBd1CQYyvaWir8Z
         39OzptEJVUb2LWTLXQSgG/gHEe8kGkVKUppv3XD0sKPzNnBHMr2pULhbJHiy0bUHZ6zY
         emjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGSI7ezeioH3JPleMg9BWjN6/bEOEgxQFzVLBpMqLQ9T9UDYPOI92ByglA0/cETwGSudnlZ2FPQVKatfQxdJJ5iAModi61H09RbFlS
X-Gm-Message-State: AOJu0Yzj1yrwUhlBeLEkEx+GL2xWdRxK7vVArGJdAXYB7RV94Jw87QgP
	KD6zEUkIgobKcnOiREGfen+vlLJ/NIHg2+ZpKQp83hzqXIqjEFt0vtyzw3YL9M0=
X-Google-Smtp-Source: AGHT+IFtlGa3tzComzUCzAZSCPh1jOm5lOc2IYxvNh7EeBtaAD53tt47COzAUy0ko//NywxBoMHbdQ==
X-Received: by 2002:a17:903:2286:b0:1f6:a572:86ab with SMTP id d9443c01a7336-1f6d0151b7amr136874035ad.15.1717998549111;
        Sun, 09 Jun 2024 22:49:09 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:08 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/24] Staging: rtl8192e: Rename function rtllib_query_BandwidthMode
Date: Sun,  9 Jun 2024 22:44:41 -0700
Message-Id: <20240610054449.71316-17-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_query_BandwidthMode to
rtllib_query_bandwidth_mode to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index c46bd0ea061e..4ac8140d7e68 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -346,7 +346,7 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 		tcb_desc->use_short_gi = true;
 }
 
-static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
+static void rtllib_query_bandwidth_mode(struct rtllib_device *ieee,
 				       struct cb_desc *tcb_desc)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
@@ -872,7 +872,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			rtllib_tx_query_agg_cap(ieee, txb->fragments[0],
 						tcb_desc);
 			rtllib_query_HTCapShortGI(ieee, tcb_desc);
-			rtllib_query_BandwidthMode(ieee, tcb_desc);
+			rtllib_query_bandwidth_mode(ieee, tcb_desc);
 			rtllib_query_protectionmode(ieee, tcb_desc,
 						    txb->fragments[0]);
 		}
-- 
2.30.2



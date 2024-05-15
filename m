Return-Path: <linux-kernel+bounces-179433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182858C5FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E311B22E45
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D927442F;
	Wed, 15 May 2024 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="EbC7iQtw"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774EA6BFD2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748776; cv=none; b=CeG6nNMNAsNz7e9QGmQMf9QmsF2SPdt19jnuLt38pbPXp8utquf3XC30qkunZkoYLeJkqKrftw0ZLbJi6xcaBUgJMh5g6iT74kbjff4jpovXwlc1Dp35rG/id3xD+2ERiXAoJ1wwLhj/W93wPia4FBeCKAER6u3HGzm+vKmE/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748776; c=relaxed/simple;
	bh=YgfIGaWfPXM0A521V0pgfcIQ1IktpJGFCjIqpUA6O9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlwybll6cZScWgWyzuBZfpJTjtLcQQvCEAQiJPU32hcZb1QaVDIVSc0DHHUHgD6t/SLalIlXnRby3efNCtFS4y3nTBrDK0NnWgjDDB9sEckz6231BgWK8ZtUV5n9+mgC/iFpywITnuA1dhBII+3wd2Kc5nnBVz+fQAXr9TS4m1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=EbC7iQtw; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f054c567e2so3988992a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748774; x=1716353574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kBPmuk5VXOM/W5GBJsDLvPQlcshMIMkziBMZPCVoQM=;
        b=EbC7iQtwIDYaANj89f84xQulq0ib68Tk4/L7tZuWkv4w3D3chyR5fiM7IzZfXCsPp1
         1AqN8hJAdc1WFRyER8gCIl2snOWx0pTmtw8Q5CIZ+8ydRD/u0C7KtBxqiO3PsMRFBPVB
         SjSzgCBEHldS0MA2jVfl/YT2dkWFwEdYZna/i259pSobg7KTB8MufQTBzlR7Q1UMQCI1
         nVgq9O+MmsbKErjVRu2uM20sVHaafoniYUmPf8syVdG14+zx+7B1GSz0DG8/wx0s6Oph
         ZzNInDHPzkgRi5w+fTDNAjy1IyDLNaVt2YN6+ROQXUrT6EFTRaihRH/H+1w3Dr1ciRMI
         5ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748774; x=1716353574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kBPmuk5VXOM/W5GBJsDLvPQlcshMIMkziBMZPCVoQM=;
        b=RqKaetWjD5VlHJ8sqrl5jh8FntlExbEz8IRz2qfFD0D3gHRtyBfo8cW8IGwkLauMmu
         HjVUg/u6QpWP3DpIafY5qQB4zWF9kU3Wt8h591GX+E1T+SAK6eiR6FCo/tIDHPZxAAaa
         IQ0OFslRiSvnKecSk2Pr4gnIG8EX6wGwwaH2uoVPZbG45+4waqd4aEaFO7v7kFzGapBK
         MfyZa4XELhE2ZjZT9pIFPXdgeBZcYxxPWG8qpkkBmHqhPu46FwQEvz8j6Gg91oogPaWk
         CIti62rJ0t6hvOo7WzOoebB3tQYr49XZxsqrCDrYgisiwq6Uckwd/ovH2yXwb4WJyxuS
         4m+g==
X-Forwarded-Encrypted: i=1; AJvYcCV6+/5Scdbgczh5lIRfJKlKGFoHOwiYEC3yZPe3t0UisZApOwUkv0RIEhcLGLzT7HAZ73A5cvUmsoRejSNta2x1t5HajwHqlFGvsM6A
X-Gm-Message-State: AOJu0YzRlB5epNA0ywgu5M3JiAtdH/qFABNyEbElPX4izM9IooMjsdrf
	OAJvbQTsFRsvpF0cMCmLu5Z6khuf5/pfh0dUxBIVDvPxkJg2tvWcDx9ynqJwSCM=
X-Google-Smtp-Source: AGHT+IFjnKIl12vhw4j9yAI+y7qOnxO/arAw+X/M7hef+jV5XKvPa227ibTby/D3/41vipY7aIT7aQ==
X-Received: by 2002:a05:6871:713:b0:244:bf6e:c94d with SMTP id 586e51a60fabf-244bf6ee995mr12183746fac.11.1715748774724;
        Tue, 14 May 2024 21:52:54 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:54 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 29/31] Staging: rtl8192e: Rename variable RfdCnt
Date: Tue, 14 May 2024 21:52:26 -0700
Message-Id: <20240515045228.35928-30-tdavies@darkphysics.net>
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

Rename variable RfdCnt to rfd_cnt
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 976e8b4da1d4..89dcbead5e11 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -491,13 +491,13 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 				     struct rx_ts_record *ts)
 {
 	struct rx_reorder_entry *pRxReorderEntry;
-	u8 RfdCnt = 0;
+	u8 rfd_cnt = 0;
 
 	del_timer_sync(&ts->rx_pkt_pending_timer);
 	while (!list_empty(&ts->rx_pending_pkt_list)) {
-		if (RfdCnt >= REORDER_WIN_SIZE) {
+		if (rfd_cnt >= REORDER_WIN_SIZE) {
 			netdev_info(ieee->dev,
-				    "-------------->%s() error! RfdCnt >= REORDER_WIN_SIZE\n",
+				    "-------------->%s() error! rfd_cnt >= REORDER_WIN_SIZE\n",
 				    __func__);
 			break;
 		}
@@ -509,13 +509,13 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 			   pRxReorderEntry->SeqNum);
 		list_del_init(&pRxReorderEntry->list);
 
-		ieee->rfd_array[RfdCnt] = pRxReorderEntry->prxb;
+		ieee->rfd_array[rfd_cnt] = pRxReorderEntry->prxb;
 
-		RfdCnt = RfdCnt + 1;
+		rfd_cnt = rfd_cnt + 1;
 		list_add_tail(&pRxReorderEntry->list,
 			      &ieee->RxReorder_Unused_List);
 	}
-	rtllib_indicate_packets(ieee, ieee->rfd_array, RfdCnt);
+	rtllib_indicate_packets(ieee, ieee->rfd_array, rfd_cnt);
 
 	ts->rx_indicate_seq = 0xffff;
 }
-- 
2.30.2



Return-Path: <linux-kernel+bounces-184453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1597C8CA6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5941282355
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3E7CF1A;
	Tue, 21 May 2024 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="M8YRq0So"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974278C8C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261466; cv=none; b=QjG3hh1FkwcN8fMw1Hi4B979beMXtnqC1qfwlJaMr7FsvXBBTD6gNNIjsuzVHiC//6j0sP+zcMPJ301sCeTy6vRqZVDGG+Nwimr8Vc7GtBrpm2J3TUUrQGiyFpzZrFzAUGMgEwyZvlIEuQC6JY9X08g9SaksZGN4j88SHyVf8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261466; c=relaxed/simple;
	bh=E214j+oVI9amVqkKz9xdNTWnTsNw6nE9EpWfpQfQ0fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdnH1xSAhNLwA9o5zeS96kMEk6GQ6BZSC2dJvkXABTAAvQwf9d3AAUsP5mDPC5cCrFkUPB2ZxJf0CEt4hCyxp6JJhsyJ4g7zkIBwbqXdPyqjvOzl2eEl432DHRCaiN7RQWU4lsVJFt3y6foyaxiMzPtqcX9/6cZme1wMWYOB+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=M8YRq0So; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed012c1afbso27114505ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261464; x=1716866264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITc+3AXVWxBKyxU7U+mxRvRUw4cedaMFQ7sA0ad4TOc=;
        b=M8YRq0SovGfrhx0l5z98/Xa8iHFR5lbTmPAspEVVCErDiM5bVgfTm/Ezk7uPITFYqi
         8uEgQmnFUj0772hWo8C8LTpxVbWlvis35qQDBcXVKbPV+gcrUi5idlftscyEmpbaL/3n
         vfd9n2VoVkNdlRGT5WouBLWG1TmUT7tbXNc/RDIs3vrPDJdh/5jdjUW3Ho6HbTTCXSRu
         7kgErIfQScDDTDQbhFr6l1mKw5utzYnu1D/KOkDxoc6HEetdLOUcCId5qbR15+/r//Nq
         G0FkFkRjTlEjen7/uNo5lQrfJK82qrslCsRsPf8uZvhIwIhMGn2geaw0vtTv1/ei+Az/
         UmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261464; x=1716866264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITc+3AXVWxBKyxU7U+mxRvRUw4cedaMFQ7sA0ad4TOc=;
        b=bH3ug0cWFpBa0iNCyd6SjV1eohyI44O6RC1R9cEZkfdqX67OVNE1ZzwqxXbUtU+4V3
         slF9om5kTTSNNilZ98pQB736YQTzbgM8dJbv/TklMzN2OdM8xtfKA0Ad71Og96zZGK2v
         eO5O+5wgP2azrjNbD8PSMP8apJIkhH4anpQ/OpG3PuiOIpemoxcAP10RNW1jvLP8ZITo
         CPNtkaA76IqUmRTQ8BIuaKY/9T0tcj4kOft+I4OSo6ZbAgx/NFOTrOHtgR8s6PQyMy7+
         f+FyrzcGQiI+yA/kspfBNV01MHbKJLoHs/huD2Zz7WlrMySKbniMBhYdQhftryZKe1mi
         Eirw==
X-Forwarded-Encrypted: i=1; AJvYcCW3VPWlxer83HVes2jHhaku9pZqj9HYmj58iRVL78NbBYrLWdBRuRsV4BglkDAxBCGNVJvFmH0bdCS2fXGgtVw9SyOr1mN1FD+XryRT
X-Gm-Message-State: AOJu0Yyojy6wC11875mfL7DhVFMNzTWj+GOuMFXuN2wQsnTdE9so790g
	GxN7Uz6JQyIukx+SnRqQWBwZDyxf99RPk9SYa2Ep2Gk4drBCyHo2dr4IcE7zz3A=
X-Google-Smtp-Source: AGHT+IEw5VAAC3r728AHxOxol/YQXn/otGSty/ujAWGLz26xdnFg57Vk8vhuV29f9hFWduZtSB+EdA==
X-Received: by 2002:a17:902:d509:b0:1f2:fbe5:7d62 with SMTP id d9443c01a7336-1f2fbe5822dmr68844905ad.33.1716261464079;
        Mon, 20 May 2024 20:17:44 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:43 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 29/31] Staging: rtl8192e: Rename variable RfdCnt
Date: Mon, 20 May 2024 20:17:16 -0700
Message-Id: <20240521031718.17852-30-tdavies@darkphysics.net>
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

Rename variable RfdCnt to rfd_cnt
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4d4a4a830470..124fa5d54a23 100644
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



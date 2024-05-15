Return-Path: <linux-kernel+bounces-179431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D48C5FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE5D285E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B4C6CDCA;
	Wed, 15 May 2024 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="XzywgGnt"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4739855
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748775; cv=none; b=sAI37Bn7jDANm0pvlm8RQZYpsbSflUgeXXRtNRVp2+4RBsHw8UPt7UqGrOz9Wnj7eTHMKIEHSr5IqoSEzMqdtRPh5qgivBgFlbhPIY3EH5X2yy3yf/WO4HOLD4OHEku9G2Xx0MnLTIg9tqsg/pQv8Bm32PFnDc8bFvdUJ9/Wabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748775; c=relaxed/simple;
	bh=d1ad8JazuYup9pSM6Gqg+bzO99wctALyeJhzT8FFxWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TOuXJPf7wxGZkvIqz5iRAKh4tAd4JLYolS1xV+Utf9zMGrZsqSYnK3ukf55uHL8nE3bb9Wq0YEix0e+gEOOTtlBQbv/SxihGOQnas2fM47fVemMuAH+MSXerLgrpBHNqdQLKv+JWtjxOQkZq8noQPo6TymDmtVF1dvdsd72CBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=XzywgGnt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4302187c0so5015181b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748773; x=1716353573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofFqHQQh40Sk0/pcoDQOyKxCMLOcb85rDpVudvN5l7Q=;
        b=XzywgGnt2462dEGqOQnhJCxz/WeChWPeWVdTqEqL17R/DwvhF3kGEPwpSUmmEKji/2
         0wltHBuD3BZ5q7RM78uMd4OH4UQXR8GQgjrJDpwLSC0aWhQYZXQPyQHV/3xAVqokJDn7
         U3Ma2Tquz5XKsCkNM6IINd3XbSjeqIGzJJyK4UCISoZc3b0fNttEqPZ67FqW7BDGSTb7
         xHDHTY9c0GdH+TiI+RmR12nG2w0Q33dbyAU8bieNyflEP/oZvlk+P9m2+ezPbjohdSdy
         6yvx00dWDTr03TyDXkMxaDG77ibYyAdvlb5P3Ss03Qh3icmI98rNG9kEVyoTnlIRfLVg
         9wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748773; x=1716353573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofFqHQQh40Sk0/pcoDQOyKxCMLOcb85rDpVudvN5l7Q=;
        b=ptEwyZLaqNwIIgFnPSEZnic4ZM+CCDM2l8wS2LvxXEv2gjM5IuXtBu3l1c3FlgOb0X
         3ME1SzTH4AKHTHtiwVOTnMWErFEViZX97e3UxpJpWntglt0pLwR6IXU0Cev6qg0LgoKT
         Pp44n7ARZ/nNd551tPh0CAAfcugfwsJnN3mVusVkCKF0KwqEv2yFAT/Z27ae6AiNAplo
         B87JE5VPpKl3P1kJc97SWLCIO07/HbVsRlBJqMgxvFSiBj5rM2QcpJS/qHiQCh5PEenp
         gpqgI9JfqXN7cCKVOKciMXcuqMCEuAu0CjgmGc8wr2XCC8Bbx4xE9q64QhjC/PdSsNpj
         fS7g==
X-Forwarded-Encrypted: i=1; AJvYcCWx8UeUi8c42kqg0PnuHXw5ZkHdvVFQNdqajAsGv8yidWsgBZRT3t+zxII27ZSdJgBamLIrfExkl+dvcW1sU2iFrKmFDJ+QlOSOIXvB
X-Gm-Message-State: AOJu0YyeuqqpZyCVLYHinJhhMVYgnGBXMHUc7yoTMcLl/kkPn7Wr55+j
	84t1MWB3yqZL4B5/EFVGNjkpbRWuLfakgBEAacamFCdzxFq1/zpGZ93ZnUZyNxo=
X-Google-Smtp-Source: AGHT+IFr5/moepQYZE4CJicvcbd44yoKS4JAFEKNJzmz4eSFgfJDB8IlZNiNsVWXDCPBE8vsv/CnBQ==
X-Received: by 2002:a05:6a20:3cab:b0:1af:fff9:1c59 with SMTP id adf61e73a8af0-1affff91d50mr9027518637.2.1715748772709;
        Tue, 14 May 2024 21:52:52 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:52 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 26/31] Staging: rtl8192e: Rename variable Frame_QoSTID
Date: Tue, 14 May 2024 21:52:23 -0700
Message-Id: <20240515045228.35928-27-tdavies@darkphysics.net>
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

Rename variable Frame_QoSTID to frame_qos_tid
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4fec36cfa2fc..b88c7cd399fb 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -799,7 +799,7 @@ static inline const char *eap_get_type(int type)
 		 eap_types[type];
 }
 
-static inline u8 Frame_QoSTID(u8 *buf)
+static inline u8 frame_qos_tid(u8 *buf)
 {
 	struct ieee80211_hdr_3addr *hdr;
 	u16 fc;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 328972cfd7a7..95dde1938874 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -891,7 +891,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 		struct rx_ts_record *ts = NULL;
 
 		if (rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2,
-			(u8)Frame_QoSTID((u8 *)(skb->data)), RX_DIR, true)) {
+			(u8)frame_qos_tid((u8 *)(skb->data)), RX_DIR, true)) {
 			if ((fc & (1 << 11)) && (frag == ts->rx_last_frag_num) &&
 			    (WLAN_GET_SEQ_SEQ(sc) == ts->rx_last_seq_num))
 				return -1;
@@ -1324,7 +1324,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
 	hdr = (struct ieee80211_hdr *)skb->data;
 	if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
 		&& !is_multicast_ether_addr(hdr->addr1)) {
-		TID = Frame_QoSTID(skb->data);
+		TID = frame_qos_tid(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
 		rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
 		      RX_DIR, true);
-- 
2.30.2



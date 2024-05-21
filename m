Return-Path: <linux-kernel+bounces-184450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B08CA6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C359E28120F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3A78C7C;
	Tue, 21 May 2024 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="dNZAF70t"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFC75818
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261463; cv=none; b=V6z4dM6kIykpkfWyKr9uZMYuweLxyKKmCnPvhjySuHnViqVq0394wvVj2Hq9zya6SSef3HrHJ2lrhxweqfetbL8ZA/hRG5Idmaxn/pPP9CfrJmc2EpSvmVEAqiah062bV8GE0G4KmKEBmUU3JW9TMRtY+JXB3bK4JgQluGMGzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261463; c=relaxed/simple;
	bh=cbh5TxJ9lOr9epBP+PxY9ro4whHmhXzi0y+5nh95DMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qlPqRa5QnwfQPXxjq0tlAhbXoARTfi1fCOv4rtcZo7tPnsl/CgdnbT0VltCLFabCx7iGZbXypvWwcKeqln1H2vj0LqunVmKBoleJAzTngqKkQigI2+jw3I8JULw1mX+40bfyHQIyQmRcnqZufe9bVaL6f2iy+LOp6DTeEbxGFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=dNZAF70t; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec486198b6so88003215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261461; x=1716866261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKXdhlAm8cv2q262aWrYc+MjVhozaby61eiStvWdJh4=;
        b=dNZAF70t7Q55AkwbPYUOlZuyAM91+ZhgM44kw6WP9LxmP810QQ94EaiRBRAjYZ4YOt
         KchDKcGi52EFubXKbiQ2k+TOpiO4if63c5NW0AB1N7qst9U2b9R8gRyZXWfC6uZfJGd/
         7kg9WWvMQxKZ91zeMVknGJiFVDKWgGaDhFkc2YvGsv5etTUflMlreBe3CAVm6u6mPoKf
         tuLCS6RFJiwKk+tpJcIBBtzaLgzranZruwaEn+OjQgdmqE5dq3EdkPFcymbYRt/ydIBL
         SkstDxgU+suHo+Iw4xc3kdLM4JfzNVlgJnP+lZjilQHQPTSaL5GV88q1MKxtbduBweSR
         2BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261461; x=1716866261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKXdhlAm8cv2q262aWrYc+MjVhozaby61eiStvWdJh4=;
        b=idsbhBoX0FEFeZddoCF80xI9c86uQGy2D1Aryg7vDxeUuTmmdu/WAzfAZnc5r0thLr
         KMmkimaOYVyWJeIBq3rrZMt44G8Hm4XfBfZqIvYlwVkNCiycHWEbGhrcliXri0b6Mhrf
         EEB6oEEQ3QoT9RthpdCcjJTsibUH5eXdx1z5/xmhY31DMtGCuZTnMaknXoZA8z/uYtuJ
         fLp7LDPvEgtmLMk2Qcn+6BBGLF2qPG/WCDnRmJ3a4xv3rqjCyGHH1ubmkhEtgg6MCTOA
         Mypil9spdGV0xvg2Ak570VrPq7dHQH1su7Go9RkPT43DiK/GPwEEhbJ7lsi5fXCD1Vgz
         UJQg==
X-Forwarded-Encrypted: i=1; AJvYcCWAr8Ng2ay0vf+YXSoiuu50RELTfWDob95dNxeFz2NjKhBoJKSEKOge5rtebLNSoORzxx/roXtO5wFYMDtGwSpel2WgmVUfOMGyW8aI
X-Gm-Message-State: AOJu0Yyjz4vQdR/+tpKiRnWjJFYbVxIjnkgXiDm6Vt6MUifN8WW+/iAR
	6c10vw3jLj3oU3aQJhsfnkC1VJpmahpcgAXfKCjOiTDRA5VYcJsqWG6sSn7z3So=
X-Google-Smtp-Source: AGHT+IEv01dRQXsvlO+6puFkXHHTmVcZ5c8jKElNm2gicctO/+98PGsaZebxky0gX6+gzQ/k04BD4g==
X-Received: by 2002:a17:902:7849:b0:1f2:f784:97a3 with SMTP id d9443c01a7336-1f2f78499famr50867705ad.51.1716261461656;
        Mon, 20 May 2024 20:17:41 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:41 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 26/31] Staging: rtl8192e: Rename variable Frame_QoSTID
Date: Mon, 20 May 2024 20:17:13 -0700
Message-Id: <20240521031718.17852-27-tdavies@darkphysics.net>
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

Rename variable Frame_QoSTID to frame_qos_tid
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
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
index 2d0a0efedc97..22c04f37bb40 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -888,7 +888,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 		struct rx_ts_record *ts = NULL;
 
 		if (rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2,
-			(u8)Frame_QoSTID((u8 *)(skb->data)), RX_DIR, true)) {
+			(u8)frame_qos_tid((u8 *)(skb->data)), RX_DIR, true)) {
 			if ((fc & (1 << 11)) && (frag == ts->rx_last_frag_num) &&
 			    (WLAN_GET_SEQ_SEQ(sc) == ts->rx_last_seq_num))
 				return -1;
@@ -1321,7 +1321,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
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



Return-Path: <linux-kernel+bounces-179416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855628C5FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F48B283E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED994D9F2;
	Wed, 15 May 2024 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="kDrVNCKH"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28943ABE
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748765; cv=none; b=qNL15ImTI9vfrFTEN4mRRM4jUzmk6jBuZOB9CdH560CNcv1Xla4T7U2ekSwCxbRSHVu8FBlTQ7X5EZ3gQdC0xsAu2dAnNGxFvP2GZAipls+Tp1jX+4Q+KVs2DfkE1QRrQ6aPAkK3gCHA2aWIrq+pa0IkwDRcYu32nYCMpkfidvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748765; c=relaxed/simple;
	bh=VnvL1pR/A33+cx0W1gDMCk2E3fkBNhHbZrMUHsMUhe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1Z0c1U5T4EznlThuNLV5Tg/kjXzNs34AmB87FbMfCqzYLcQ8mvPtRKgZJ1HnaXWeN5dCxstcgbyaulI1/6huEY4R7dUrTGk3PUkiJlX7JN0cw4Hj3ZfBvjaH5+tTirzIBOXPPhNPxYcmSPRNXTazGCa/7HTtp0j2SLa2GD8D0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=kDrVNCKH; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9a0042e7dso1642964b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748762; x=1716353562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgCRtbTOWnZ8kzAmOYjZrKpYOKSuXshKUOyljVtAXXA=;
        b=kDrVNCKHoCtD8UXZvBmG7TG/SsitbEGgMz2TpbpdYwkOnd3DP2oFE73EGf31B23CoN
         rRnMVjcpEJCgk7stUAD8Jp1wnEYmzyIP7PUVayv36K+JI2JsskvWqQtURbPzwi/sVXXJ
         wvB+8w7RfGtxNcE6+abgs/hwa+h8jpQ/LSr/xWcCQzB91IbuNfOi6MhWV41kmhjG5R6h
         t4j2vp/8rlAQY11jaeIqq8wxb0+b9VzCbkEhIJcOXWKpgRijxoDzo/S0Un6tqGwm8PjI
         WAnbzKYGpTtwjYPln0xd8Dyf3theZcPRE57y+68kQG6IZIrYmnVmq/uBfyooskRfp1Z1
         rrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748762; x=1716353562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgCRtbTOWnZ8kzAmOYjZrKpYOKSuXshKUOyljVtAXXA=;
        b=FW3030ZyaeTlynrUSlggdBKiSKuaItliYU7HLUUPsKGlXzubGmLe3aV+VxWNZY4N5U
         G92NW3Gp1qeGDwr0sjulzchgVf2pQ1OWVIuW9++do6eqjRelNR4/Hkpyy00AnvuJpVat
         uH5EfAgO7bj+bLl45isoUCoWM7CBinLZLAsVvTTygalQ8VaIzvk3WsLosLyfSYrdcE9w
         gHPrwfMcFeaMNf9FeqfGukmMn05xgXMSIuBn1rCdHTsd2Qtf7Z3nH6/dkJp2sh38k46V
         rEusoNyooBhJqH1t1dOWxOk1SA2jl4MWwuuuVlgkka4Zu66oPjhsZvJywBJML4rB7g9F
         UiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRol4uoSy+6jVyYtVWBBIQQvR5DB2SHIyjOx9i5S/xaOuAZJ79dRIyZC7XJ/GWpo/TJawCG8S6kSrv2ZWUz3dJFLrT0xQ60XArHslY
X-Gm-Message-State: AOJu0YzIC30yvsB3Ek4J9AHv0rvutO5t1iq35TyEJuOaH2aKW0DKBYWI
	TkvXRAHQNlHIF1FjTpE/SFRKDFcaUE1KwifULLeYmd0SBxY/r1faMmQVB8btYCk=
X-Google-Smtp-Source: AGHT+IG8MX0IzqySjgg9OnwPx44Vzfw7g2WiJ8/t89Kc4UVleZmVjmIxCTB9X67dNCnWo287HiswDw==
X-Received: by 2002:a05:6808:a96:b0:3c5:f86f:a5e5 with SMTP id 5614622812f47-3c9970b95aamr13769982b6e.38.1715748762526;
        Tue, 14 May 2024 21:52:42 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:42 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/31] Staging: rtl8192e: Rename variable IsLegacyDataFrame
Date: Tue, 14 May 2024 21:52:08 -0700
Message-Id: <20240515045228.35928-12-tdavies@darkphysics.net>
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

Rename variable IsLegacyDataFrame to is_legacy_data_frame
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4645fe803a15..cdb3ebc77a53 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -339,7 +339,7 @@ enum rt_op_mode {
 
 #define	FC_QOS_BIT					BIT(7)
 #define IsDataFrame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
-#define	IsLegacyDataFrame(pdu)	(IsDataFrame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
+#define	is_legacy_data_frame(pdu)	(IsDataFrame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
 #define IsQoSDataFrame(pframe)			\
 	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
 	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ea8cab9707bc..24136bba64b6 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -882,7 +882,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 	if (!ieee->ht_info->cur_rx_reorder_enable ||
 		!ieee->current_network.qos_data.active ||
 		!IsDataFrame(skb->data) ||
-		IsLegacyDataFrame(skb->data)) {
+		is_legacy_data_frame(skb->data)) {
 		if (!ieee80211_is_beacon(hdr->frame_control)) {
 			if (is_duplicate_packet(ieee, hdr))
 				return -1;
-- 
2.30.2



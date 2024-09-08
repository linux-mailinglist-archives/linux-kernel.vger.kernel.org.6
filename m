Return-Path: <linux-kernel+bounces-320385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11397097E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DC21F212DF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B6188A3A;
	Sun,  8 Sep 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="fF+/CxoL"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8618785E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823610; cv=none; b=EXTdl/spCKUBZSVTA64LSsTsaqHWO3E78Df2+7ok2B+y7zAlVHteCHM3TDf4Fe+uhzRdfRHI6Yhz4pbv1o9kLFLdQM+GYHSYEEyQ2gLXrduLua4xjnehv0C9QQNCY/RfcZ0wKSaZO1yy2bcSV56GsthhNzRAgW9eXp+aLcV2er0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823610; c=relaxed/simple;
	bh=QOJK5XCFnUgF4GgLDRGGWmBcTIrKAWOlHImOERfob9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOMZgK8aBB4t7HaqDCjRiENjYL/pSDBDcLMdVdwHc4iB67BnElt8CQ1dzOCYIywIKGkANKmlkPk7ej09ELkSAyM95PfPShyWzrchPMhoQB1BZVMkl+yrfbvPN6NSdxDlBorSt9G2bWJ9z1aSpUE/mHtu5Lt7inRv7v3LeGiQwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=fF+/CxoL; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so2335609a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823608; x=1726428408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by6Pfc3Lz7+BT06vS7vmVqgE+mV643pZhMGdpE7msFg=;
        b=fF+/CxoL+BVDNTzHqE+8ybgirmed++Mf6twDK9Zkz4IqW5/nRDgTIPTq1CXCHA6NVJ
         ZkNpcIEkXtNsJ9yCr1vNvJHFfBcwGusEEWrKG2K0yAZz4iWzOonN+yJRAuzQ95cSjcFJ
         VpXQK7OT+ur8ucvV6h2QwClT+DGydHhmVmk2GEtJwos1owXWgVQBU2VmadZr3d4WhBAY
         4H3A6HXwia2RbhtJkXEOVrh9Vj9SwXoOVm9Xv0/HYcQGmI8xXTxoXcHllzNew+Wf5wCU
         e++TjXumf9Bt9HHKDTh0kyiyy8/RGiAIu9rm7PcKqVMaIjjIdFPEBcbtaVplc+Ca4BFy
         AZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823608; x=1726428408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by6Pfc3Lz7+BT06vS7vmVqgE+mV643pZhMGdpE7msFg=;
        b=VDn+lwAC2LIPB+7MPlQM21KWsTGkOSKCfgGpa3k6MfvwztB5APBE7cpTzxSdiaokBc
         2vv0KzmhmHryjiJwh6hz456ymZoF0Xv7ZsfHcNimzTRCu5E4tllSPL3d9jl1LBCdqqiV
         TN3jDb40xsCMIpOwBo5Rw5goCNk0lixvdS0W1vINUeeiHsgeQR4ntrJQ3OVUf4n1SuWv
         cltTHbwu/T8CE+kn/h9G4Pem1XO0IWo2gIRm+VBB1ecqrvu1hl0mog+5XLWXKUh2nljx
         COjnYSJZtTVgXcCqFOtLwopN3Ip9593KP4ut9irL2v8TjM9TMLbF0gPUiHIKbT3CllpL
         kDTA==
X-Forwarded-Encrypted: i=1; AJvYcCXtK5LYrD3rs73N2VgrMU2hYzVps+7gR7Gz4Js1WULsgfJS/lyFIUlCGoTX15sDymB17O4vOwA7w1RUOko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEvfr7S9ewFfRVKXi2KoU+EpULMmgscBaJDlOeQYgtUhVP6xX
	EJzSSlpyF4uUJA0/d7z9RcG57/MTPt1g8/SenTr0uaD2wNdg28vR3lN+zHK5DEg=
X-Google-Smtp-Source: AGHT+IF0GAwWiGPFMhHa4izSvBq9RDiVdKEosBub1bRKUBYV9DctApLpV695+6Qkw9GxW02kKEZhPg==
X-Received: by 2002:a05:6a20:d80a:b0:1cf:3245:5227 with SMTP id adf61e73a8af0-1cf324553d2mr3042023637.46.1725823608345;
        Sun, 08 Sep 2024 12:26:48 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:47 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/16] Staging: rtl8192e: Rename variable RxBufShift
Date: Sun,  8 Sep 2024 12:26:32 -0700
Message-Id: <20240908192633.94144-16-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable RxBufShift to rx_buf_shift
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index eab6bbf9f3bf..d25ac5adfc49 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1493,7 +1493,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 	u8 *tmp_buf;
 	u8 *praddr;
 
-	tmp_buf = skb->data + pstats->RxDrvInfoSize + pstats->RxBufShift;
+	tmp_buf = skb->data + pstats->RxDrvInfoSize + pstats->rx_buf_shift;
 
 	hdr = (struct ieee80211_hdr_3addr *)tmp_buf;
 	fc = le16_to_cpu(hdr->frame_control);
@@ -1640,10 +1640,10 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 		return false;
 
 	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
-	stats->RxBufShift = (pdesc->Shift) & 0x03;
+	stats->rx_buf_shift = (pdesc->Shift) & 0x03;
 	stats->decrypted = !pdesc->SWDec;
 
-	pDrvInfo = (struct rx_fwinfo *)(skb->data + stats->RxBufShift);
+	pDrvInfo = (struct rx_fwinfo *)(skb->data + stats->rx_buf_shift);
 
 	stats->rate = _rtl92e_rate_hw_to_mgn((bool)pDrvInfo->RxHT,
 					     pDrvInfo->RxRate);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 5a4113c97b1c..d43841a9b21b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1523,7 +1523,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 
 		skb_put(skb, pdesc->Length);
 		skb_reserve(skb, stats.RxDrvInfoSize +
-			stats.RxBufShift);
+			stats.rx_buf_shift);
 		skb_trim(skb, skb->len - S_CRC_LEN);
 		rtllib_hdr = (struct ieee80211_hdr *)skb->data;
 		if (!is_multicast_ether_addr(rtllib_hdr->addr1)) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d8155ea3a002..6cd374a9a955 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -475,7 +475,7 @@ struct rtllib_rx_stats {
 	u32 time_stamp_high;
 
 	u8    RxDrvInfoSize;
-	u8    RxBufShift;
+	u8    rx_buf_shift;
 	bool  bIsAMPDU;
 	bool  bFirstMPDU;
 	bool  contain_htc;
-- 
2.30.2



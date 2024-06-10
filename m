Return-Path: <linux-kernel+bounces-207681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06585901A70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96150282167
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D174BE4;
	Mon, 10 Jun 2024 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="glCM0VcR"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100926F305
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998552; cv=none; b=Qbf/b1P7SXda9JlRmCnWp7fu8HxR7fl0srqTgIcp8DyT21J+bnQ5w5ZP7kTUJBjxUxU7i6hbGiEtCSy3GHfypmDXi7nhj/q4YFKW0QCTOuLf4tk+guwS+X1/OekuMGefhSoF9sf1uGKQvnLOyrngmfdh64T7971+Px+MhJEFEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998552; c=relaxed/simple;
	bh=YVcm4XmaxKFLGsFGlnqdGs7uzUoAsX5VuGhTAIrezbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBvR3w7mRNS5mSv1fSZSWM30F7GauYPdEjf64DX2qrCdnwAexff3iHlOyZuTvaBGW1fCV621z4iVwhmR4iZg5GHG1z0B/4A5FxHSWC2nOhcSQuO2fLlus1ND8oJH8NPhAEq3YAegPGJOWp46fShFIcPY1FNVjZ8S7VNR81e2chw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=glCM0VcR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6fada63a6so8612505ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998550; x=1718603350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAYOYW/Y7+3GJ2/qy/cBWqG5HCUdZYjYD0EgoGUSzio=;
        b=glCM0VcRwBtboiXB65nnz67eKQ1OnoDChMOUcmJvtv/1YGXslYuSqLH/LnIxVVLKIU
         jpsyvSHV6NmpSTic9MdVwMYuOaU5yjN8yJcZm2A+yCve//frYKkjY10KPEGyLuAa3uUI
         a/qZRUeyWF0AG76TXIPh/MFIDDAc5OnORN3pJaftRR+7hgwaSx3K/UW2jbt0Cw1ynIlm
         vpYMEwamnZeXIVhrxyI0gQtgh0rz4m02o91zd3gmkC7J4m0bmzt1BNTp5We4A28irH0j
         b33oyM8SIEAZ49H+Xkx0lsAHGRPPhBF9Mqg6XNZgtO4/YS4f7BWkCL/2B8uVl23PmHZm
         Onlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998550; x=1718603350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAYOYW/Y7+3GJ2/qy/cBWqG5HCUdZYjYD0EgoGUSzio=;
        b=flHMfrwmgGaiVOkYQe6PylRkW4PaK9v9Loo6UcY13Yuh5SGhUAnOqRVpABkitd5JUh
         g1sCxFIEDT3Wk+APx+et9X2R6WvucJjqBpa1Xt4vRGfUycrR5Zui5cUJgBYYEbwlshq9
         8MiVexIL2od7QxYd84MaBurAYRmRVW5M25ge86MYEPfcRafyBWsdb5lr6uqtdtm/Hc5d
         2ag/bS4e1UKPmXjRZ+RQUa5AWMeAf21AINpO7IknJF6HLuLp8jHycb/w70W/KndSMB9a
         RbBJgSkDufcpxySu7PfpN9MOGJ6orHkcy6IJQa6oF0rIuH2VVUr1f0mYTF5oKh19RAs7
         o2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVsNZWa7qUHNhAZvtrsnbwb6eR/m+2l/Movyiu3AahlchBh+1nifNwA+T94Rvx9pg86+ELUHy+WaDFU7+ZchCPHfzdHRcYaxGX0RkOB
X-Gm-Message-State: AOJu0YyoxN32+oK4TAzVZIib0URRBx6HITV+tF3DQGYOzQRnzfcAx1wy
	0hAA+GWXPI1/xr2Y51STvN0baMBYDlRJWw2r1nODaWrOA/Gj9994zrK6UFGk1V0=
X-Google-Smtp-Source: AGHT+IGtrvu1a6LtbV/lfvwTRSUUSPdPNnanK5CdVgTmpwTeU4QSe/5G9DctAJxrzGYb40F4sCSsqg==
X-Received: by 2002:a17:903:2349:b0:1f7:13db:529e with SMTP id d9443c01a7336-1f713db52dcmr26400655ad.4.1717998550390;
        Sun, 09 Jun 2024 22:49:10 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:10 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 18/24] Staging: rtl8192e: Rename function rtllib_query_HTCapShortGI
Date: Sun,  9 Jun 2024 22:44:43 -0700
Message-Id: <20240610054449.71316-19-tdavies@darkphysics.net>
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

Rename function rtllib_query_HTCapShortGI to
rtllib_query_ht_cap_short_gi to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 97581cd58571..183a3897687e 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -330,7 +330,7 @@ static void rtllib_query_short_preamble_mode(struct rtllib_device *ieee,
 		tcb_desc->bUseShortPreamble = true;
 }
 
-static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
+static void rtllib_query_ht_cap_short_gi(struct rtllib_device *ieee,
 				      struct cb_desc *tcb_desc)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
@@ -871,7 +871,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			rtllib_query_short_preamble_mode(ieee, tcb_desc);
 			rtllib_tx_query_agg_cap(ieee, txb->fragments[0],
 						tcb_desc);
-			rtllib_query_HTCapShortGI(ieee, tcb_desc);
+			rtllib_query_ht_cap_short_gi(ieee, tcb_desc);
 			rtllib_query_bandwidth_mode(ieee, tcb_desc);
 			rtllib_query_protectionmode(ieee, tcb_desc,
 						    txb->fragments[0]);
-- 
2.30.2



Return-Path: <linux-kernel+bounces-207670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75C901A65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26211F21B13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802A3F9FB;
	Mon, 10 Jun 2024 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RlI+pyVf"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797B22619
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998545; cv=none; b=iF7iZ4ZLkFsoD1GiS/PevSyYoWWoB9H9jT/cbSw6+CMT8GrQ1hUCODw8pbeYgsNmnQtQq2XlcPlK3LwSacpJbp6iZyane220NuSwk6n1yZB5Sdgyyr8ynBY/UeFxTq/3s+f/ozGCIBdxclWei6wikccJarSWJP2XMdq4AB8jrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998545; c=relaxed/simple;
	bh=+g1s3fKgiuz8BQyPHgSzUFAdsHTRDc6WhvjqJjVn1mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nzfni9X5Fd/oILGSbiNs27yASKfeKHud/gE97OOZXC9q+YI4OlmmaTd5+p2KWaUpnEvZPCNKYtzWIwmH93jv31mX0UadCpwvlXt9/gNY70fA1DXDfxtXSJCEevWHFiK1m1CSP37QD4gFrQl1GivlTqKCkyK+9NKZxpPyQIDcCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=RlI+pyVf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7042ee09f04so1107504b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998544; x=1718603344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPdygZcOUupzqKLEFg5pCHVy6dyamPHzEutqCiiZtWE=;
        b=RlI+pyVfvBu5LU2n+tGyiKJGlxjeO2sKtzivAo2q0/lZ1mukgbIVy3I0xzS4YjTobF
         fNl67pX+cIQzRqdlNLfdQkMV0hPlWgPEIH6DSZ2huQWgFZ225S4a01f7CDGKzPXKmm3X
         52xwkZzNIVPT0FbjMzI1UG31gfM22JqPBg4VJN3uShCoFYrPLE9eWionQtKYlw36XJFg
         73kg5tltncEtRVXwHCpJBgxw1h/Gk2nAX6wqJ1OCMO5B7vyd/++csWViwOZMbFM2i7CK
         eOGuzMZIc0oLb+NqUbQjdWxKmVhS+ztndIbkIrU9/794SXuQK3hEgipG9Lc4tnovF5EB
         BUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998544; x=1718603344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPdygZcOUupzqKLEFg5pCHVy6dyamPHzEutqCiiZtWE=;
        b=pz1fDpp5Je1Pb1Ez4H6XjB962les/yHD+F15s+Ne37xB6V4pQfrj6ZPKi2Huh2BCEJ
         qbeCqm7JxvIZ1uVOagvjJHj/8HPcVpAg44SZfuGN1Ssp5sv05GzpSHaD3E1U2b+MAYnv
         3zMGjWvwqi1kBuhfEjSDIJTJPERT6vBGuwG9A3JVDSxUgBmXJddch1XihgXG3FZ3F8FP
         NgoPQ3XGvYOkXZ1MwNXaQpg2xyybi/pu/qc+4nBbrkHSLwwKdw//0/XF1D5CJlU6nGxP
         mIz+GQ3tfJfDqOCHFnaqvBzAeY9QKaKMawlGmj2eRujUoPwWOFwJ3r9n5ucNIJbQMZBG
         anTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbLvJ1Pgs2OVvBh+BXbTisIv+la9Pr0tH41Q/fTjH201dwOWdlzMA3oacRBB1lixLyhKmHhF1QUgAdED6cG89wzMzKeBnjtHWDga/b
X-Gm-Message-State: AOJu0YwuX2pCL8gz+gk9/fs8V+/sci0HJskMudULrwtDahvExMpXCr1Q
	EzT0R3GhWJKL1ZmdXmp7KDq81mgQMO/RDVWXXV/Jf4CvjYHpSRt8xGLUz3nP5m8=
X-Google-Smtp-Source: AGHT+IEhVE7YFbxlaAiOG1M2FQxuEuPvxdtHTifeQB5RuCxEKIryT3twaJ3ZnRA0vWWT8jbaGPesFw==
X-Received: by 2002:a05:6a20:1048:b0:1b2:5baa:7acb with SMTP id adf61e73a8af0-1b2f9699cd9mr8866497637.1.1717998543667;
        Sun, 09 Jun 2024 22:49:03 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:03 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/24] Staging: rtl8192e: Rename variable bRTSUseShortGI
Date: Sun,  9 Jun 2024 22:44:33 -0700
Message-Id: <20240610054449.71316-9-tdavies@darkphysics.net>
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

Rename variable bRTSUseShortGI to rts_use_short_gi
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 4117530f19b1..a52db6b1fdb5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -901,7 +901,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	pTxFwInfo->RtsSubcarrier = cb_desc->RTSSC;
 	pTxFwInfo->RtsShort = (pTxFwInfo->RtsHT == 0) ?
 			  (cb_desc->rts_use_short_preamble ? 1 : 0) :
-			  (cb_desc->bRTSUseShortGI ? 1 : 0);
+			  (cb_desc->rts_use_short_gi ? 1 : 0);
 	if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20_40) {
 		if (cb_desc->bPacketBW) {
 			pTxFwInfo->TxBandwidth = 1;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 2282c709654d..bd18d866ce22 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -122,7 +122,7 @@ struct cb_desc {
 	u8 rts_bw:1;
 	u8 bPacketBW:1;
 	u8 rts_use_short_preamble:1;
-	u8 bRTSUseShortGI:1;
+	u8 rts_use_short_gi:1;
 	u8 multicast:1;
 	u8 bBroadcast:1;
 	u8 drv_agg_enable:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index c0fe00d0df02..d376c35a5ad7 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -373,7 +373,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	struct rt_hi_throughput *ht_info;
 
 	tcb_desc->bRTSSTBC			= false;
-	tcb_desc->bRTSUseShortGI		= false;
+	tcb_desc->rts_use_short_gi		= false;
 	tcb_desc->cts_enable			= false;
 	tcb_desc->RTSSC				= 0;
 	tcb_desc->rts_bw			= false;
-- 
2.30.2



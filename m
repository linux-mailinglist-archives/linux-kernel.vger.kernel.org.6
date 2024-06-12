Return-Path: <linux-kernel+bounces-210879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2C7904999
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A5A1F23BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971A4839F3;
	Wed, 12 Jun 2024 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Jgc9GWOw"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F86823D0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162572; cv=none; b=eNu9f0SCF3vl83qfpDgkAh2bWcXq4cPzNMqQc8GDKgQsvL8MOHpmRFTH2X9SFUNR5S7Ze/Xq7jcrn2dI9WbQxMJDu4qIJyzIC0VsOOo5Q0nnR+eumSb95tZttRLGFx1xZZzfsjxwcT/dS6cV+UNXfr05uWhlZPQ7dcRVq8HWft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162572; c=relaxed/simple;
	bh=c8MR3plf46KFfyFHzwWDM6RMkQukkKt3JMAeSqgetE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEAxMNXN7UYtLumrLMUYtyfea5Odu5Gc2ST1TiGOpBKGwsjDkUdcrI5ZZpozhz1Scmy38G2O8OwNjmgSq5a9+RjdDQoLzs/5p2pT42g4b7Dec+N0KhISWBr5L/Tz1VDYICQvFt8yS32a/zYynFNJYDBA/2QSRwQIJrANQXjHiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Jgc9GWOw; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9d70d93dbso1094266b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162570; x=1718767370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlD23f+arzcg415XUQcgi2kkZZjdw3Csp3SRxDpwH5A=;
        b=Jgc9GWOwgK3BzR17S7a/7kPAAEYKK0+1oV7nqCYx/rKdkjPU/kYOhEwI9ozgEXLc33
         9u9mqiy9UZ6qj2bzSTJoBw8HzCAbBhvXxTZ/Vg7d2zALt8UDFmPiDlX6g3Om85iWT32b
         GdI1g0uYMxBjqzJ5Dlze5o20TvYr16FonI9Aowt2DHlji6hPJeU870AJgEBM6FMRNwYC
         NkBhHIc7g+u/794giREdFsTd/ACm4EJMVRkbDUgFc446X3XyXJNMAmQ4r0ck0KLO0NWy
         zy6HHt59IfPP17tz1m80NqaUt/gt9mG+/fZFFKRP/AeGjTRtiV2GhdKmTuvh3j3h15qV
         Sjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162570; x=1718767370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlD23f+arzcg415XUQcgi2kkZZjdw3Csp3SRxDpwH5A=;
        b=DaBlj9cU7jWTfyZ0jGEaObq5u5kP7L+3jRYQVI52bDsR9M3d63Th6jk4NY+OS1qo+d
         3rzX6OQibNrbAL7qnjHTgD4DSVmxYY+z8NTr2EGAkWo2zhWOHV/ORLOe/zEenndEWo2J
         8nQVlUji5aWpt7EKxDkpbZIm0yQd+auSFMDVQJPZQPc0phcnkYoyKIpriKzHml6XhgIq
         QpSZeMVnA8r0oId+5pyM735da6W6ya7GrVRQCtpknejfq+Usrcd2zMhKQCGik0aLTXph
         4H68dudx/Zpx9z7abn5c9h5Vsa5LI0E9WYt82sR9s8EHs76B09zBobLHXzbVHR2M6kK8
         2gYw==
X-Forwarded-Encrypted: i=1; AJvYcCVAjGRpf+SSI4odGoCGPchPzbxy+SQ5TCg+aTD9yyaxLlor3sM6tT2+01v433L1Wd1FyS4qpdVCJtTxsyaBWYVrFFqqoB/nQIZObGmA
X-Gm-Message-State: AOJu0Yy8HOFGShZe4jlwygMCgQ5eAlPHAbCOJT4mSu/7auKSy5CFpSkw
	aY+WbOTVce2F1KZ7/G/yz8yDQr0zGuyfm8NjurcIuUWrSj49inzpmizPpoIMKCI=
X-Google-Smtp-Source: AGHT+IHbieTndi1KMRbPXtZyNMt7QLIoX+75W/r+HgGQcQ8UzS+ezzdKinncxF4lvj+2qyjawM8FBg==
X-Received: by 2002:a05:6808:13c8:b0:3d2:243e:e4b7 with SMTP id 5614622812f47-3d23e04d2d4mr638193b6e.23.1718162570315;
        Tue, 11 Jun 2024 20:22:50 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:49 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 20/24] Staging: rtl8192e: Rename variable bRTSSTBC
Date: Tue, 11 Jun 2024 20:22:26 -0700
Message-Id: <20240612032230.9738-21-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bRTSSTBC to rtsstbc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 46e42fad5834..b3d4b3394284 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -894,7 +894,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 
 	pTxFwInfo->RtsEnable =	(cb_desc->rts_enable) ? 1 : 0;
 	pTxFwInfo->CtsEnable = (cb_desc->cts_enable) ? 1 : 0;
-	pTxFwInfo->RtsSTBC = (cb_desc->bRTSSTBC) ? 1 : 0;
+	pTxFwInfo->RtsSTBC = (cb_desc->rtsstbc) ? 1 : 0;
 	pTxFwInfo->RtsHT = (cb_desc->rts_rate & 0x80) ? 1 : 0;
 	pTxFwInfo->RtsRate = _rtl92e_rate_mgn_to_hw(cb_desc->rts_rate);
 	pTxFwInfo->RtsBandwidth = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 61d383a560f6..022851b7f1a9 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -116,7 +116,7 @@ struct cb_desc {
 	u8 use_short_preamble:1;
 	u8 tx_enable_fw_calc_dur:1;
 	u8 ampdu_enable:1;
-	u8 bRTSSTBC:1;
+	u8 rtsstbc:1;
 	u8 RTSSC:1;
 
 	u8 rts_bw:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1aad5253ae4e..b6bf10dc1772 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -372,7 +372,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info;
 
-	tcb_desc->bRTSSTBC			= false;
+	tcb_desc->rtsstbc			= false;
 	tcb_desc->rts_use_short_gi		= false;
 	tcb_desc->cts_enable			= false;
 	tcb_desc->RTSSC				= 0;
-- 
2.30.2



Return-Path: <linux-kernel+bounces-210867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE86390498A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2981C20D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927A4A9B0;
	Wed, 12 Jun 2024 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MZujluSK"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A3208D6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162561; cv=none; b=UP9h72cOi3ngpIvBCAu4PS7CgQn69Jnt6xsq0NsGFVYmclixyZhGi40BB1CB9YRMpg5N2/jy9u3fUaiG0S37FdL/aJlk5e6p6BNSgky5Xne4r8D2YEn+An7MX1Sj3TO7vLVNzOecIM6VdkxLYoNq5sdc/rI1Is5sbX/bQfuCPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162561; c=relaxed/simple;
	bh=pOnS++sX2eAGvOC3LVoYaJxWzWEYFDsnsJR5WVz99MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BouualOSb+c4PPwPSZBKSc3hf3EXTUVXrm1P5TpS6SfA5goUWZf2BXE9e1uHX/jlbIx5FgGzqJAnI+1lvChj64On+biytCEoLBG4yTxS7cNGmG6Imn8/BEEMBsc3q4ze14jj6qcStGt+T2Tzi9FY+EQXZI+C/Ztb/eiXrCyrkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=MZujluSK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70432d3406bso2743115b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162559; x=1718767359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPNFt3LcUqDEQ/+6JbVhxGeiAYv8XI9NoJl7wWcKnq8=;
        b=MZujluSKiwREEA3IB0m69rX4NhJkFzfiA5s17FLnVod5wKeSJpJe6esAZjMEn7qWeE
         GrCyZeqcdj/UjxkUMWrvTDLFPHX/N/yf/Myizkc3AzROJFRPlmLFqPwaX81cKCinRglG
         KLCzG0gneBVxTeWdDB0PcI1RhCqauhAm3OLaOsNuRBif4UcFT/Eb6Pt4qNZQsZ7nYnVs
         RGF8ZWIGYc/fVcqZkpRGVU73QdVbPJTQ+LjqUzgrovYNUmCxOUZdHQqkuSXVjs1AM7aB
         N2DyuaL5AqVuexzJwsZrekBR5rkku6l7+RNNEq2y7wRHWSkS/4lgkqxMmezhUTRIO7D2
         rRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162559; x=1718767359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPNFt3LcUqDEQ/+6JbVhxGeiAYv8XI9NoJl7wWcKnq8=;
        b=tYMCz5IzhyP9RiwSPEUaitzGMuwJ2e+elZDE/ceOqFrvzrEY5pcqYPqpMIsXSMVS9Q
         6OOM5S5LSDFWHfL4+v+DocxCGxg+cAhOQt+6pU8T6wNpgv2QcrBi//hVuHcTFkqSYdTw
         GCAZXhqMabFg9XkMELUMdsW5o4SMxbDRQZcDciQMZknM5SRYYq8Em5uTJYirvNXYolEu
         wVxe90lUZI6ky3d+lRyCbcdg7U9xNc67oI2+6vgnzhsH2kMcTNhJ5zR23V4z3KPhSDjC
         QPJsKVSKPwjezZwoOODE8LHxa303qTfxc4x35Mb5rGWChjc6sOQ9woz9Ag4Dd+9hWvk2
         9JXg==
X-Forwarded-Encrypted: i=1; AJvYcCXcpUxBna56nGbsXABiW08H+KKo71PW8dqbjyYDBsGvX55QYI5iGmFwraZHcjx51gEos43rJSk41/fFHoV7UuBAtCWZkcPlPhYPtzwg
X-Gm-Message-State: AOJu0YzDbQukEsT/Ccs0u6Ok01kV5J3Rxe9D2Rf+6TicSHaTiezOEwlj
	L4/uxXktu1wl7+IRuVS2XNqGB/aWceUQWOoAhSPHBFfbfZ3aRR6Eepf27XGT5us=
X-Google-Smtp-Source: AGHT+IEQJGR6U1fEbe28j7h6mSnmwjW4DcaEydeXJwwspteYCWurPxelf5gyminIUv8C58P8nHoXvg==
X-Received: by 2002:a05:6a20:daa6:b0:1b8:807a:49c2 with SMTP id adf61e73a8af0-1b8a9c85cfdmr910712637.50.1718162559553;
        Tue, 11 Jun 2024 20:22:39 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:39 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 08/24] Staging: rtl8192e: Rename variable bRTSUseShortGI
Date: Tue, 11 Jun 2024 20:22:14 -0700
Message-Id: <20240612032230.9738-9-tdavies@darkphysics.net>
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

Rename variable bRTSUseShortGI to rts_use_short_gi
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
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



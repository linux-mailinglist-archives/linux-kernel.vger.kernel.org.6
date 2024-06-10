Return-Path: <linux-kernel+bounces-207683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD17901A72
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746EF1C2166D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C92558B7;
	Mon, 10 Jun 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="I0BfrmRD"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FE7405C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998553; cv=none; b=dcFOR/UtW/YTDsuXyXLBj92wS2PH5q6r4CVp2rEY0vS7DZTVR3JH9FIswntY967KzvGx8AMgI1E+KmSWFRRfEUeC1zZoDpyoEgznaK6q6f/fkAy0jpD/Rj6yQef3yHquKgAIItpOcLjPW950yoLGfR/MRI2KosvxcKzw/1D3QVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998553; c=relaxed/simple;
	bh=5WjYKzyNdive4sa4vHuYC2Dqjq3HbPl37g+TtRrR/OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NApSnSrWMoTQlEcv8J9qM40q9ZN19KpVnKM0LHBYSf4Dk4qRqufBomQPSpwFr3Gdw4KZED6Gf2LnC33QNdwiLkHaG6PsXRAa+GYQUWTJqzRCM/1yqE431wPumiS6zeUVd+jtW/JgiGz5+G+Ofmn0rf4SwH6+6oM2kL5cQpxyBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=I0BfrmRD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f68834bfdfso29702525ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998551; x=1718603351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/ahLMxx6dJunJKkjljH/YoDaz/TFR0YL9Y5eJ6K8cc=;
        b=I0BfrmRDG3ulMIUsb+5r2fdtKLXEo388yN+Z3H2Y2XPN1HzFW/9V0aH9T5Pu7bJRtG
         sgLgV7SOltMVo/0P+cJMo9BhPdyam+LWRT+odoNmFB1Hra1wZU1RD9/MzzDj2vzWS3Vs
         PpQxu07LOjCRL0n7q1mfoNw1lM4otBf1b/XNcM8FDSJCobVFeKluesU6MklCxf3Xfa08
         gAR993EFy21sPYCzo9AFEj0947dhA3DtITq8yyUoEfse6KQY7N+0UTIo1HmskudUA2fU
         QnX9dIsJrk5OL76M23WfP1WwSEpOb0dQ8w9gQC7RYfE02nw51fnm2U7Vo6L37BM/Uwsi
         mQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998551; x=1718603351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/ahLMxx6dJunJKkjljH/YoDaz/TFR0YL9Y5eJ6K8cc=;
        b=aU/0ygjS9MazdM+ff8F/xGzHNKePOFfglEl48JWFsAIwi2m2THBHGxxh5iKCPf64jo
         1IvcPsEGYRgHnL+xLN15jID7TxeA65yeEK+ugIWnByckjoYSCj1mYlX/z7gT2lXv3GrD
         4ErZa1S99VC6YIz/1FU4Dy2gLFBr3zsuxmUkIVWiS4/uRpedfMlBSNCPVCGGEl5rz+pF
         9Lf44OGSIeZD93N9PG2HjkCCUj1Veyv7KzY8Sti4gvbvz7Fp8iKyqY8Yl0Frdcs87Nii
         0BdNYp01508lYmwqaiVDQb6oYjhidnmJTio18cazkUDEbOuNyxUmP926Xx3aadw+5Zvw
         7YXA==
X-Forwarded-Encrypted: i=1; AJvYcCUn2cYHDZm90nAXupLU8Bcpv9oHdmVHEAdWlesgQwqwZksjHMjHGeWk8H2J0k0kutyt64BxVBCfeMEMaUQscrk/ZerekGrppCpXG8It
X-Gm-Message-State: AOJu0Yz707CznB2KX29zWE9Qoc5XRSKJNGaLtoHZeb6IbA69+FWgd4r9
	C5UeTwX1pLmCaneYjAkhAooxeBYjvRFYUC4myRnljS1CfSUOeSc73G2aBNTfIto=
X-Google-Smtp-Source: AGHT+IF/bbFFnZTV4qHCeHwyWHQFb6vZmha/DloHQmcl6dunh9WsLzXdt0Ag/Kq11qK0akcKPDv6hg==
X-Received: by 2002:a17:903:187:b0:1f7:8a9:91c8 with SMTP id d9443c01a7336-1f708a9973cmr28920175ad.39.1717998551683;
        Sun, 09 Jun 2024 22:49:11 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:11 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 20/24] Staging: rtl8192e: Rename variable bRTSSTBC
Date: Sun,  9 Jun 2024 22:44:45 -0700
Message-Id: <20240610054449.71316-21-tdavies@darkphysics.net>
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

Rename variable bRTSSTBC to rtsstbc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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
index 7c010534af52..738db4d6180e 100644
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
index f6525256298a..841d9960385b 100644
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



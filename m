Return-Path: <linux-kernel+bounces-369416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C009A1D04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005622891D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0801D1CF7C7;
	Thu, 17 Oct 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="AcaCYQ5p"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910C42AB1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153293; cv=none; b=a3ZZTbPXOzs/DNuJpZbZobTs+lig8iBC3oVEGnI5bSJFN2R+GTaVAAW+ELLfYiewDcufSMilG4XKp/GT0pv3uzfCtrjrjZtRZLG/2LTnbc6Ni3EcHli9I04Yw1IMMr+NaHOAt7uRpf9LiMgtQ4r9f3HLDzGEXS66DxVNgZgGOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153293; c=relaxed/simple;
	bh=Qt71jqomeTiOsHtOT1TI7YwwvbCbhkMchZi7rxHHJeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdmSQhHaW9SMxJ0hCU9C9U50fffI7I2AacpF+Ko/g6R4gOd8UMV3cYkBbHAkRTbXMuDh6Q1MG9VsfvgjHzO0mqHMCr/Ns81D2gkp0ilJPiUXFytF3qJldBNzW9Xq5W2HuzVw6OT0Iyxmlp3ZoDDV1Ganue6vTU35RUm0PEX1fEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=AcaCYQ5p; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cbcd71012so6361185ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729153290; x=1729758090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21r4KjxS04aljSd/Fon09UcC72cpkOJeqlG20Lhe7Ck=;
        b=AcaCYQ5pNxcgSKRrkGU2n1XcDkwx+QwT8h9n/BWFSKEsWOMUsBAaEdg42J7gxHbys7
         tpGvXbBmyN9kDD1Q99YEzWlBcsztuN04V9hBDbiInEKBLqUPfhmojMK1eEj3BkBgv0XQ
         6TpMVm4IIMYh0nVVrFrSSNxpopyz4aPuyuyIlRL9H43J7CDY6yQcWDf9TL8BxwhhADbn
         qrJpl0c6sPdTGPDXjgeCE/o7e2ybxWRh7aIJhZfj5Ppy2d/ca9Lg5lxq4vi6Tsbf/RLK
         YRDXJESdoJudnOcH2vdWJOSA8k2YVI3qdtNm0mCugEx/qKo0i7tRHTC13VsPOgR7+q8h
         1Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153290; x=1729758090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21r4KjxS04aljSd/Fon09UcC72cpkOJeqlG20Lhe7Ck=;
        b=gp64X7xBI5f4Fx+hjtNhC6voSXm9Lp8PgriPGhzlB8IeVDiDgtKhwNYjb27h9V4apR
         cNxVipcTaDLDU63TxOIfXRLhI/XQGN3fSax6NKVa2pkAif+THNjvrmBH7XBnj1vCUvaz
         CHJQkwVy+rODSOOVaggLSMTgusTEPNoe709/EoDveWpTKVVW8ZDgMuEqKIrta/vRoyxF
         mBg8eJGqEQsz1imnkby2AkmzRCjGelrDjR4hnr/XgwtVLRX/784cThoFkYIFgtlA7vz+
         SbCZxzsfxzJLHE+akMsyEheFGA4LLjeao6uZAS5OMKwCnscqdhwEQlBIsMujhC2DfGja
         gZeg==
X-Forwarded-Encrypted: i=1; AJvYcCVYPoKSrQtkH76qS69ymhXa4+pIff0N0Rbk080EgvU84aEG99+74efNH9gaAvWHprmsd7F6MIHOZgXDcnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigP7im5t3sEG9z7gkIqhNCiHqXeoxfch7R+6VIydOmTb6cn9d
	sIVh4mTcIW1E+HOKhXsmx7Cihn1mnmgsdEJy/cPaHvLu2SCKho6whQRsF5y8ZVc=
X-Google-Smtp-Source: AGHT+IEuPQNkBkf35mPaDfmPHqCgle48oyoM55cMhfMh+5dWLMsLpkcpas8peZNquQZKLveCOM3Skg==
X-Received: by 2002:a17:902:e887:b0:20b:b40b:3454 with SMTP id d9443c01a7336-20cba9ebb29mr248199755ad.0.1729153289656;
        Thu, 17 Oct 2024 01:21:29 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.28])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d17f9e234sm39690655ad.114.2024.10.17.01.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:21:29 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: Change return type and error code of fluke_get_dma_residue
Date: Thu, 17 Oct 2024 02:20:22 -0600
Message-ID: <20241017082022.16874-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fluke_get_dma_residue() returns unsigned int with -1 as error code.
This error cannot be caught.
Fix this by changing the return type of the function to int and 
returning the error code, that was captured.

Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB driver")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/staging/gpib/eastwood/fluke_gpib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index f9f149db222d..54fdbef20d84 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -536,7 +536,7 @@ static int fluke_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length
 	return 0;
 }
 
-static unsigned int fluke_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
+static int fluke_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
 {
 	struct dma_tx_state state;
 	int result;
@@ -544,7 +544,7 @@ static unsigned int fluke_get_dma_residue(struct dma_chan *chan, dma_cookie_t co
 	result = dmaengine_pause(chan);
 	if (result < 0) {
 		pr_err("fluke_gpib: dma pause failed?\n");
-		return -1;
+		return result;
 	}
 	dmaengine_tx_status(chan, cookie, &state);
 	// hardware doesn't support resume, so dont call this
-- 
2.43.0



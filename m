Return-Path: <linux-kernel+bounces-393738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D63A9BA49E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C062D281526
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560D1632EC;
	Sun,  3 Nov 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVG4BueB"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27215AAD9
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621696; cv=none; b=ddmNQRdVTGKE2zratp3Jwq1s2JPE2noDQ87JggiWu4q1bEWjo8yeDB9QNcBtt2wOH6XGqfUOokY1xEmhk/NjvxQRFvZ5X7EkRvkn/Mx2cjmdfR0+b1PPAnIeF66/cVg42pWtDvsbsEENs1myRp0+APKeOCZofnksh20/NZavR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621696; c=relaxed/simple;
	bh=sJQBtHHCyUD4fx57VPvGK7t1PMtZgvKNa+0f3DpKnsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKN55XS5+h803kPZloemkLoUJod0Y9/uhUzFMLeqwG5/kZ9vVrws4aTqCf8oUJuXqwb0hPeZRHfd7nWB7r4dCS6a7hzZ+iCfsw8X0hNSGjQcvbnAlfV8qW4Fwng/JFeIgADG8dRG3wyPLLFVa/Y/gTVAjcBaiBIO/WaRRHeDBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVG4BueB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ced6a3f246so65795a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621693; x=1731226493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKRocKMvsGz4cOULrqNXkHoL0rqs+NrAAxU47zmH+UY=;
        b=SVG4BueBKTF+Pf0z3RfrfWDx10J9gM1ZPzJLTg9WxQiVS+Z13HjixJirTbU2LiHxwy
         TsJGdyQkqKkA2VkHdOOOGtGe6Cs73+jNWqRKhGj+LfwjVdIAIMWZFt4vQJf0QDRl9nIX
         RLKIeE6VFxsOwU8H95Et4F1LBI+69yNhlitU1aQBp/5gAwzEwkYF2yhQDxaRGx3RGr9K
         lQFUwA939vmgZtmGiNZ14aowocmKQ5VQ9BOn/kS7r+bwfqEkDRSXNRrzcdKWn4gvry39
         QPC69Ebrk/OBcQu7dSewpdXwvlMYH5lrW1kpTgwDKD5ToZUynTsDOvnMq4ZUl5AfVaqp
         YRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621693; x=1731226493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKRocKMvsGz4cOULrqNXkHoL0rqs+NrAAxU47zmH+UY=;
        b=gdGDfZ9mnubEjJkoHL24kTaKyqYQO+W4XU+l77uzK+lFbJz31YzP2JG6ClGGUe5RmC
         UVLGhkcyhypKj5lKfEuuvJRK1jiTts1dvMkBFnPCuB5IojHGIqgz6A5M3+bk2/ZeOt0Y
         jzFDe6FpcSzxBnMubTL2ZfKAk2zHNerPn+MgqP/PBJ7KcINpFi0frVeBOfOTmXjecgKW
         LfqZyy41Gd5GHTk+5Y19S/BGV1+mPHkZZx+O/siiyscZRRsUPrhlcGZfvzCNy0baGXGi
         oU1fA55+MUHC/sktcC1ACaVpDNci4TjE+c4vxcYPDRyRGR3V/4DDytSKcSTlEDNnTlIK
         47/A==
X-Forwarded-Encrypted: i=1; AJvYcCUUBZZPgou5AVpbNpHVj5xBe0NyXRbN1Pp1Mc3IeHtIA7jp1FSTtFfF4TwFxB4RMTRe7TXWo9m5WRubnK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkfdfE744vkkjke4ystvt+JKQ9lWvhkM6GeOrl31keUznUJC6k
	5gdTu1Y7CFd/wDHSo8pTWy9zJujEhEMfbe4Y0Nuss87bBFbTiRl7
X-Google-Smtp-Source: AGHT+IEUdwUv9MdZb3kct+QldHfpcsuY/9p0YeIRb0fwCu+mPP3498mIgN9ACUM2AetSDqcm1a3iow==
X-Received: by 2002:a05:6402:2114:b0:5ce:d028:e11 with SMTP id 4fb4d7f45d1cf-5ced0280e56mr2014148a12.17.1730621692863;
        Sun, 03 Nov 2024 01:14:52 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:52 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 02/13] staging: rtl8723bs: Remove #if 1 in function hal_EfusePartialWriteCheck
Date: Sun,  3 Nov 2024 09:14:23 +0100
Message-ID: <2eea90fbdc2ef0ef5c8a224330558ccdefdfdf5b.1730619982.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
References: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove #if 1 in function hal_EfusePartialWriteCheck to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 53 -------------------
 1 file changed, 53 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index be4cc8fc5696..2659999404a3 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1327,61 +1327,8 @@ static u8 hal_EfusePartialWriteCheck(
 		}
 
 		if (efuse_OneByteRead(padapter, startAddr, &efuse_data, bPseudoTest) && (efuse_data != 0xFF)) {
-#if 1
 			bRet = false;
 			break;
-#else
-			if (EXT_HEADER(efuse_data)) {
-				cur_header = efuse_data;
-				startAddr++;
-				efuse_OneByteRead(padapter, startAddr, &efuse_data, bPseudoTest);
-				if (ALL_WORDS_DISABLED(efuse_data)) {
-					bRet = false;
-					break;
-				} else {
-					curPkt.offset = ((cur_header & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
-					curPkt.word_en = efuse_data & 0x0F;
-				}
-			} else {
-				cur_header  =  efuse_data;
-				curPkt.offset = (cur_header>>4) & 0x0F;
-				curPkt.word_en = cur_header & 0x0F;
-			}
-
-			curPkt.word_cnts = Efuse_CalculateWordCnts(curPkt.word_en);
-			/*  if same header is found but no data followed */
-			/*  write some part of data followed by the header. */
-			if (
-				(curPkt.offset == pTargetPkt->offset) &&
-				(hal_EfuseCheckIfDatafollowed(padapter, curPkt.word_cnts, startAddr+1, bPseudoTest) == false) &&
-				wordEnMatched(pTargetPkt, &curPkt, &matched_wden) == true
-			) {
-				/*  Here to write partial data */
-				badworden = Efuse_WordEnableDataWrite(padapter, startAddr+1, matched_wden, pTargetPkt->data, bPseudoTest);
-				if (badworden != 0x0F) {
-					u32 PgWriteSuccess = 0;
-					/*  if write fail on some words, write these bad words again */
-					if (efuseType == EFUSE_WIFI)
-						PgWriteSuccess = Efuse_PgPacketWrite(padapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
-					else
-						PgWriteSuccess = Efuse_PgPacketWrite_BT(padapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
-
-					if (!PgWriteSuccess) {
-						bRet = false;	/*  write fail, return */
-						break;
-					}
-				}
-				/*  partial write ok, update the target packet for later use */
-				for (i = 0; i < 4; i++) {
-					if ((matched_wden & (0x1<<i)) == 0) { /*  this word has been written */
-						pTargetPkt->word_en |= (0x1<<i);	/*  disable the word */
-					}
-				}
-				pTargetPkt->word_cnts = Efuse_CalculateWordCnts(pTargetPkt->word_en);
-			}
-			/*  read from next header */
-			startAddr = startAddr + (curPkt.word_cnts*2) + 1;
-#endif
 		} else {
 			/*  not used header, 0xff */
 			*pAddr = startAddr;
-- 
2.43.0



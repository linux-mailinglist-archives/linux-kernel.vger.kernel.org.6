Return-Path: <linux-kernel+bounces-398745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F79BF55C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02541C23BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089FC20BB4C;
	Wed,  6 Nov 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoQqSek7"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2420A5F3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918045; cv=none; b=Yod/WmdRDT880A9lD9oPOJhAekEPYFnug6dj+Dtb/LZgZqNegcTQWN3q8vcedtfxYSgjV19AJbFUFwF/iIkpy8dyAiq0CNLWVtFtzbBStBzukKceLlEqBxpYDy88QRfRrby+cgfLBkiDAtgYKJIxBo1SziPsKPovzsEiYRax2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918045; c=relaxed/simple;
	bh=ny1IUjXEbFDtNqc0wWpdYefNkINbbN1F2HIJhO+MYzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQVdKQaHpjyRtHmA0F3PPc6XKm+gEjlh2jzZFqR22gwahJ9vQ6xwGAGq8bTM8a6DD1ZIxg6qDoq9dKwmmwW/B/rq4yY7q56+UeGt7CQPKc13iSRd47UTF64UjNSz00x2mz2w87E3r23ZJTyfxFWwMBX624+GBzDE4gyy7ulDMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoQqSek7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so55311a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918041; x=1731522841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3pzCEQrbiGJWQExVv2MGO23rU23gFTpZ/mle6QP108=;
        b=DoQqSek7ak1IgMPlKQ2EMtXxIvxp8UP53lwQSP1+qFFa66MMxtFpM5hUbBX9BydQyp
         cYyqCHo4nPS8FoEYUTiVATtlkx8pp8BTZVQjqL2YI5ALHkUpe+qDwjd8KYCKcvDDz0fp
         hh8donCuex0wiRw8GO+YelWh7DARjLeTT6Zrch5HOXyR7eun/S08/qeA/BPokHcKAplv
         JpC5F8e4y6WfGEyRkHcBggX8uH/ot3YLeeHWNY4KmzXKuO6nV603gzHtsmC99d0eC77i
         AqGaM1y54mHxtBkq1Zt/tObxHMB5Tf5kcdfet4iCpkbOJAcQSfUOts05OUwgXPiW6Ogo
         /YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918041; x=1731522841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3pzCEQrbiGJWQExVv2MGO23rU23gFTpZ/mle6QP108=;
        b=idfCxrdzOrHsS2DprRgz3uwPTo1srMHp64lX4G3sYnpic9M7r+KBI3f50KFntFLKVj
         Of6GJaqR7dyVslyHUW/ClZU2MYbIzdI2gN4DTUfL0MUO9aVA1S5rCPiNjCLODoANuFoz
         pM/P+MBzULt+9wYzDdtAOX+LNii+zR2fAmf5jabVNxWfw4s9/r2BcchSxRF7D4A888PU
         QlZUxzzXmZkhaHkJTJO/ey3ASlpcpvbom8WOa3YGmOEL+G9j0qmXedfVjFzNCpF5hOpe
         DX5eFt01e7Gm473lW185BLXEQlt1ATyRAKWTLIHeZ/VLkxMVslaGNWnfbZC6SKc5ImFz
         oGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAAO2csgz7iakRCRhZ63vWdBz5dsh2TVelXP6hy6nce1MjbcLf08f/GfiZsocOxyqNy66k4mYF7sIGbR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUifTW6X73MRpXfEWUwSh0HGYra7usIYUdzRXzb5y8BvmxqN1e
	WCyPMk4hyc7NmMZVyulrWpZ5/ql5aqZ27v7z7eJLnsVANbt4aBU1SvT25A==
X-Google-Smtp-Source: AGHT+IFAh3RBtPNKcN9/sNK0cNys4JGcj/3Rx35+A4EhhOmpgVoWubYQ22spneKC0iomtUT8jV2EKg==
X-Received: by 2002:a17:906:fe01:b0:a9a:6477:bd03 with SMTP id a640c23a62f3a-a9de5ff917amr4046905066b.38.1730918040971;
        Wed, 06 Nov 2024 10:34:00 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:34:00 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 11/16] staging: rtl8723bs: Remove unused function hal_EfuseConstructPGPkt
Date: Wed,  6 Nov 2024 19:33:40 +0100
Message-ID: <8625bceb13e5a319a1d0752bde79888fc8622ca0.1730916582.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
References: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function hal_EfuseConstructPGPkt to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index ceb234cdbd74..acd9c8128f94 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1168,20 +1168,6 @@ static u8 hal_EfusePgCheckAvailableAddr(
 	return true;
 }
 
-static void hal_EfuseConstructPGPkt(
-	u8 offset,
-	u8 word_en,
-	u8 *pData,
-	struct pgpkt_struct *pTargetPkt
-)
-{
-	memset(pTargetPkt->data, 0xFF, PGPKT_DATA_SIZE);
-	pTargetPkt->offset = offset;
-	pTargetPkt->word_en = word_en;
-	efuse_WordEnableDataRead(word_en, pData, pTargetPkt->data);
-	pTargetPkt->word_cnts = Efuse_CalculateWordCnts(pTargetPkt->word_en);
-}
-
 static u8 hal_EfusePgPacketWrite1ByteHeader(
 	struct adapter *padapter,
 	u8 efuseType,
-- 
2.43.0



Return-Path: <linux-kernel+bounces-398748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6D9BF55F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09C81C23B60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC9520C320;
	Wed,  6 Nov 2024 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrrRcLA2"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F320B1F3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918046; cv=none; b=DnPn0hVIhigfswikBU2Ytlmv2MrWSHXfSvYeenV45tPWh/pAn/0i7yaEL2buEFpklq4AbdOaBlWwWI9Evm24o/viX9XAxScUFOOjfoO5fiC9CHWRK4ZRWWNz7j59YrwYkqRZH3tfeQE3BxnPPilpi2wjXrL/fhISIB2DuxDVioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918046; c=relaxed/simple;
	bh=HdJm1Pu/7PlxrS/55iKeWlrx7bsSZesm+0zy53fLThk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iomzU9Kh4jl5TEgIxptPcpqCad8tky55LAyS5FDGeReWD6cmwohogAaj1xJ4VvJ6YIWh1V0NQREExlVruQ07AAh5hePxsPIAO16E2cg3Vq/Gc6dWgHxFftUxVBvJv7KZE7VxoQ5QGYlEK2c88X26tf8MrIz/5etuUmVV0JPXSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrrRcLA2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e44654ae3so8265766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918043; x=1731522843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhgbEz6h9Yba6sgpMI3GJizlUji0eMJyuR9wkNgDATk=;
        b=GrrRcLA2uJtgWinMqvDUJXnwlHPQOJqq8jg8WoKsZLK1WEaIo+NS8ZyMrkC5KkiqpY
         dpnX7krNhev8FazaSyydkbVU0WMRT3QIbyTKJ6G4vn+RAsO8vnQtcrmOI/fJyTvKCW93
         Os6s2H7DHGVOHPZYsbe7nFPJ52Cl6NAwPshBgkQY/KRhFBFx8FCVcPH6HV69ioweJi5E
         Ou72UuSvpFGyAgTT+kBhBBBTY/AdlTpwfNnXgt19ueHhxKOpvDuauZBG9/I5GDgPgvIE
         WQ9aoDkoaObppm0ceKMCfaivk5ekWA5rEcUvWpi5t0XAB9pS8FDYl57V6sqLn5b8gBKR
         a7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918043; x=1731522843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhgbEz6h9Yba6sgpMI3GJizlUji0eMJyuR9wkNgDATk=;
        b=bM/hIUVkrbsiHbIy+pUpLxgS18c7ftcvitGVxsQ8f5SsEdA4pNM6FgUYD4j+2Onpyw
         7BNXQGSbb9aPebpIXjyHllcxYbO0zkU7T6mIaqFMvV/FzMt9XBP+hUdnfx+CIENFLzx/
         AzNoltwl1vhMYMDx7e+BiIPDdEJFRCx7rdmfOmlekgHIM26oQChH71jvZRHvxb0mt24o
         KrHOHz1ldmP/SMm6PCtI3AmgG5SuWC0wmZBa/DvqztVuFR2us1Pz6aMpDexK2ve8pePc
         JR+6zh9rOtPJaGU3OMGHhUYBW6ItsTvZKmRwpBTU5cVb0GP6g1K28xCWbgBjcsLTBlyE
         5W5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVy4V7Dly5FU4T8TGCr2s6jV9mSYigUj8q3/XgUHzOOMWHgqh4fguFak/cyVIGYpp5lljASmjOuWPWn1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcO8cajg25Apx7Fyc7EyGJRQ8QohnuROwCiBcgG3gUXnkHY5t
	VcsYBpglIStd0FuW0bgQnY01HCqoCSftYF0fOZaRaMG97TPb/+7R5OekXw==
X-Google-Smtp-Source: AGHT+IG5AFRKgz+xdpjWoBvDFuQm1QIxrauaXKNygZ8gG7cjYrYhmAnbm6dscF5KQiQKPi/V2OGG7Q==
X-Received: by 2002:a17:906:c7cc:b0:a9e:c4df:e3c5 with SMTP id a640c23a62f3a-a9ec4dffc9bmr284337366b.54.1730918042801;
        Wed, 06 Nov 2024 10:34:02 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:34:02 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 14/16] staging: rtl8723bs: Remove function hal_EfusePgPacketWrite1ByteHeader
Date: Wed,  6 Nov 2024 19:33:43 +0100
Message-ID: <80b5cb563f5294b045b24266c5a99d1b4759c2b5.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function hal_EfusePgPacketWrite1ByteHeader to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 32 -------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index c6cd0f11cd91..e15ec6452fd0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1151,38 +1151,6 @@ static u8 Hal_EfuseWordEnableDataWrite(
 	return badworden;
 }
 
-static u8 hal_EfusePgPacketWrite1ByteHeader(
-	struct adapter *padapter,
-	u8 efuseType,
-	u16 *pAddr,
-	struct pgpkt_struct *pTargetPkt,
-	u8 bPseudoTest
-)
-{
-	u8 pg_header = 0, tmp_header = 0;
-	u16 efuse_addr = *pAddr;
-	u8 repeatcnt = 0;
-
-	pg_header = ((pTargetPkt->offset << 4) & 0xf0) | pTargetPkt->word_en;
-
-	do {
-		efuse_OneByteWrite(padapter, efuse_addr, pg_header, bPseudoTest);
-		efuse_OneByteRead(padapter, efuse_addr, &tmp_header, bPseudoTest);
-		if (tmp_header != 0xFF)
-			break;
-		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
-			return false;
-
-	} while (1);
-
-	if (tmp_header != pg_header)
-		return false;
-
-	*pAddr = efuse_addr;
-
-	return true;
-}
-
 static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 {
 	u32 value32;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-398741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D239BF558
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863CE2855E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CA020B1EB;
	Wed,  6 Nov 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsLWlQu/"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D38207A2C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918043; cv=none; b=VxSQ08IA6QaDVp3+ZNs7j/bmEkQnwk7AEoE3/7R85eRI5Ctdb24y/5Dp5/1NGLBXcqpRX46fkLQyd5rfiLCgFHrz56BEA3AaT8TwtttQVNnZoAm0uNpeXSv+BCHLCRgafZ5q9VnMxauGygTI2eIl19RgIASJIhIqHpCJfC+cZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918043; c=relaxed/simple;
	bh=OhYFXdOAT77f7RxU/LJANnpWsMNqUOrjLI6muVHXKQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmK2HvwLOyre8StX7h9K7tXgfLTUwf4E9LyG+x8FzWrh9rSg01sY0DdGCZnKTPt1owU7hISCtfFOxS4xWH7T0KFED8nt1XhGwFAxLDtb4MDE3tW30Tr8Arysymmd44NXTOEuteDqS9K6E1t5ijSZ5V/b8BjnFH3kcSds9IYnHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsLWlQu/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso7900566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918039; x=1731522839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crh/rfogPGMRViil37oWiT/zXqQHb+k4d9JTWemUdnk=;
        b=lsLWlQu/ONUTLtod8geTXkEpc7r0rUzGtZ41ZmD0Oaen1OYe6ASdrDtKr7W8VFtarh
         qcsogzZBWDkLBwmsATdibypK1lV15Io5nX5QD5UgfzNbAvPBQGBn7Q0ci9BuqLUN3qpv
         VZFD0LWVdHXbMEabTOx2ZJLi7uRgic/ao0R/vkNpPtJzKjVP3ZwXUs0jWtnNv6XxU5Wc
         e4bPfzeyId3qkyXsilP9p3BII2J/CUaDLUKJ0hchpBDDVFOPdzRyMQen+qEQ+2m3VoH9
         rAvFOtG/VEdRQBedKlPy7BydRtoEP2s/azszHPjenLLe1qeM+9t8Y7U44PCYLnri20Pc
         GRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918039; x=1731522839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crh/rfogPGMRViil37oWiT/zXqQHb+k4d9JTWemUdnk=;
        b=U305eJaX3rhVefdr4xDiK9aiwUc+rAYfwK1dQitr5OQx+qkRuMLqFmpsgCzsvDo8XK
         c81WyMI1e+ig/BG6U9OuLwnui8annsHkKcgSZ4zs3q4sws2F48jgI6kQ7YwokbG0Y1u6
         thyFFGm4t8L9ou7YB73QKo4XhyHW7V2yJhC9c5yBSJRk+/A6AWM5bAEX02Syhg6qRXhf
         qfyBe4OQWodnfHkjQ8y1DuWQRy8M0g0SQAAY7TyaLv2EudPARzWhxFcZiSZ1R6UyT5nM
         UJaebVCDqgWi/uMqblMrJyePZOb0NwRXHZxi7U7nn2nVFJfasDkzJbmDu2oKZQ8yMPIr
         jI7w==
X-Forwarded-Encrypted: i=1; AJvYcCW25iDNhCZqFF01thKeGe0/8x1TC3e2Eq6qmIUhvtafCCzCXR1EqnrXe/TOUZGIseBVyE5+e6nMpO8+yzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9WVPa47O/a1EqeN5HOT3a1/JUrpWpXgAMs+l1BLVFjhYHpKR
	fUwliFrgZYImt/Bx7xadifyXy4ZGJfOyrEL7qrktZUOIndMWkYp+
X-Google-Smtp-Source: AGHT+IEPXokTSPgcqGa7xl1tJ2Tp4hbyjMYSJoP2uyWX7NBDQbYUJ/iwOyyfZhKjlFg1LOysnIohhQ==
X-Received: by 2002:a17:906:c152:b0:a9a:154e:dd86 with SMTP id a640c23a62f3a-a9de5dc1890mr3774050766b.28.1730918039023;
        Wed, 06 Nov 2024 10:33:59 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:58 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 08/16] staging: rtl8723bs: Remove unused function hal_EfusePgPacketWriteData
Date: Wed,  6 Nov 2024 19:33:37 +0100
Message-ID: <ec6f2c62ce7a4a742360b81495afbc0755a5a703.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function hal_EfusePgPacketWriteData to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index fa6fbf0ddc23..ae909bd1366a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1345,26 +1345,6 @@ static u8 hal_EfusePgPacketWriteHeader(
 	return bRet;
 }
 
-static u8 hal_EfusePgPacketWriteData(
-	struct adapter *padapter,
-	u8 efuseType,
-	u16 *pAddr,
-	struct pgpkt_struct *pTargetPkt,
-	u8 bPseudoTest
-)
-{
-	u16 efuse_addr;
-	u8 badworden;
-
-
-	efuse_addr = *pAddr;
-	badworden = Efuse_WordEnableDataWrite(padapter, efuse_addr+1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
-	if (badworden != 0x0F)
-		return false;
-
-	return true;
-}
-
 static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 {
 	u32 value32;
-- 
2.43.0



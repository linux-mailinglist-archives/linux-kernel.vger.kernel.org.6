Return-Path: <linux-kernel+bounces-296297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC895A8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9AD1F2244C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBC6A932;
	Thu, 22 Aug 2024 00:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCDHGeDn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C24C8C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286333; cv=none; b=PsGmSIQKOyBvEUCTJoa2RjgrLvrGa9PCHskGSTFsYUPHA+IzOQ2Y+abpRPObyVUzR1T6nb3CqRF/DUenygFycGyfkgo6RF4gIZucl6scKN5MTTX7wkW/8+0jR0b3pDjkpeOJIGHmWhnMWVVrsMVBsSc3aoMfnmKn1MO2g2/V8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286333; c=relaxed/simple;
	bh=QzOtKAA0FeDdpIImmhCmZ1ahoJVp1wd6RSXq6J78zOY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=o2eqhqteY5K9kQp02PL/4Jo5vaJJiMgO0rf2LTNi/MgWB0s8Z14QJ5AaPbxFjdKYLuNeIWLky0ALW7KfJnDb0L6hCMIpvGh/ioCBzwooB6tslCxFLY2YH23bfwaHm1l7unR1c74L2DOGpZqlgA2G0nsez0lOVRJ6bNydiz6k4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCDHGeDn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20230059241so2121485ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286331; x=1724891131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mvCQ5CqSkFA92AZgqJWLa2tJed5PdJScQ7an8WkJIkc=;
        b=SCDHGeDnJrYZRFzjmYRJny8t97EzQp63ugen+Jd3IqZrFDFdBaz0eRx2QU6gP72K3k
         rCxJpz0Vt5S03nkZd9DtxBZV7KWOEmDB6yDhPsDHVohpmHFV8TOPtGt1gNWrEwKM5fZ4
         qKo4olZvCrU49DiwOPLrGC8ZhpaGzk0QIRw/EaLKp7DabLoKctiQEy5VkWZ9jbfz+kAB
         yzd1DBpX7uWczWs04Byaw9B6RKZGnbbTEs0euX7Cabh/W+wVg6tmG+Q/tsOmT2JVehH6
         hl3N0fgq5F+wCTduUKIV0qlIDNIQPaiXscmN8p7j6O54ejhQlwLyenwZnTIXcuLx6LJH
         1zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286331; x=1724891131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvCQ5CqSkFA92AZgqJWLa2tJed5PdJScQ7an8WkJIkc=;
        b=Vw4zemI4KQ4LGchNDKXFYz0E5sgB5RZFV0UQ7xRpZj117dQxNiIuRwcX22E6xA4X6X
         FwKrGfJCMc4dHFSoI+mSnvCpj7FHMMnhvN+3DNeSpvkyfAkM+6vlVcEtlRgIFwvcFH/S
         2qsjLx7cHvEPWPT+8vyh4fDxKTsOdXTB5DKkSm2Wz6OlYRab+iA9dI2qWMygVq1JmFjS
         9ofhNSmCcof+cPTXxS8G28pVsWhw0PjyYh5o8XKELGo1IVH7CMZMKnM1mAYDPACYt1tT
         ueh9ce12I7652SwuYPTzfR3PwrPGkK500XumU0yYRFFryyWU5djxsNet61gJhWT2qVFc
         0rcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVag2x2sP7zHTHIPIAijr9UkcHrgvL4ZT4PJOeCYTbzgvQgayX1urw55m5wejISLVxATGeVW/zCp0d1QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSW6Ck7qUqb7dWTVhegnjJ596HbrupdPPliL2u6KZuQBc//jf
	EeZNv/vSppIJ1kFqoj+rHk5Ea7fMierpuoxV6EFm5e5aSIYbjqOv
X-Google-Smtp-Source: AGHT+IFDShBAU/E7lr/xr7RCWzt+ZoZy+QBiogwLBYPDN8gHFssHRboTikHVQo59I5ataVhSsdl+rg==
X-Received: by 2002:a17:903:244d:b0:1fb:82f5:6641 with SMTP id d9443c01a7336-203882248femr4395965ad.23.1724286331116;
        Wed, 21 Aug 2024 17:25:31 -0700 (PDT)
Received: from RenanNotebook.unicamp.br ([2801:8a:c811:1:edc2:7c0d:751d:5088])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dd2d7sm1675695ad.169.2024.08.21.17.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:25:30 -0700 (PDT)
From: "Renan M. S. Florencio" <renanm.florencio@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix indentation in r8192E_dev.c
Date: Wed, 21 Aug 2024 21:25:26 -0300
Message-Id: <20240822002526.19757-1-renanm.florencio@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix indentation in r8192E_dev.c to silence checkpatch warnings:

CHECK: Alignment should match open parenthesis

Signed-off-by: Renan M. S. Florencio <renanm.florencio@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b3d4b3394284..ec867801bfbd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1741,7 +1741,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 	    ieee->ht_info->cur_short_gi_40mhz)
 		ratr_value |= 0x80000000;
 	else if (!ieee->ht_info->cur_tx_bw40mhz &&
-		  ieee->ht_info->cur_short_gi_20mhz)
+			ieee->ht_info->cur_short_gi_20mhz)
 		ratr_value |= 0x80000000;
 	rtl92e_writel(dev, RATR0 + rate_index * 4, ratr_value);
 	rtl92e_writeb(dev, UFWP, 1);
-- 
2.34.1



Return-Path: <linux-kernel+bounces-398743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B89BF559
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3002E285B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9AF20B200;
	Wed,  6 Nov 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7ehGoP+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A3209F3B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918043; cv=none; b=exQ2CKp4muDOBmU9xdZY/GxuwYY6T3v7qqbhlqSPOKPVv8dZBUeeakFHoEsvU+yFP6YWAcE0p6sLMmfn1Mfpt8nWBhStPRuQ21uWIDYDe+4pw8xPWy+PSydbpc3GL89rjR5KhzebjGiy7An18Z0jsUZLLSyD/6S4KWE+C3hMEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918043; c=relaxed/simple;
	bh=/OLpZDtALrTQzeYx2MmPGQ2pB2ywfY4H/jgQ2wGzKbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn3YI7bwaax01BYPwOWuYfTCMiMxlBNZ8fRYaB9rcY/9OCy2l3rg/9gQ6zINoZmNNxJWyBctLiGdhxTR03dVJjHpoSY3leOcIIMHYtS847kMkDKIMw54IZuYr31reWdAALG9+LatojJ73rrqhFbYIcFGit/E2vBQC+R2yp0BNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7ehGoP+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99eb8b607aso7651166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918040; x=1731522840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+wHKn8ywOfNHBd4UcX1XnLelRHkboaw+5QA8QhKjAQ=;
        b=N7ehGoP+m0U4kuNCUsCseVw+JyOgBP5lcf3hLVsdj4G1OsfA8GeVtR7vQYhF8vmuxo
         S4oU93PVK3NoBNKwdlDCSkLAYoXCOanfqiEgbUIA8FWPriJzTWwlLSsbUcI7EJdsJqNJ
         nPw+LjS+ign+BGj8R1yEbrg/P660hd9ZK9XeBvLi9RppyV9eXEgtPEbyTazStJGnp6X/
         itc9hIt4B8SWx+ZGUN993P3AQFHLLdr4eBZU6I8N7/YFHuGvNtA/3FIHYFvgmqRyBpEx
         tcjChx16aWvGeFYuHS2RgMat3REIBvZaBAk4PNR2KLXwlbjXHcWnXhpRUypciH2GwFrn
         SgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918040; x=1731522840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+wHKn8ywOfNHBd4UcX1XnLelRHkboaw+5QA8QhKjAQ=;
        b=J8m0lmuY/UQnHNpEOUJcTV3fhHyYaW1XnKNsRCKg/1vLtsHaMNvGzkLiLOxj/AKdYH
         +vTxZLeIjj/zlwEXpL8xdQYKw5K0UKexbr0XerYNMMB00k9jhuOqB2Nh2j7MNxlDuT8z
         OK57LzGAqw7g2abZk7gpkGk5eJWiLED6X6ZsKuCC0oTRHhcrl76uPDQGFh7TlGctpXn/
         nZPbf4tHH+3/LY+6WEVhLoE+ouVZIQIdn20xOy2mt26QD0VtGaC2o0fsZR4cNhbq2zHX
         3yKXxKetz3mlGVnaIoRCfYnm/XDK+EYzr9NXGpx1baP7nLphvjLzWbdzurnAcULCqqPZ
         VkGg==
X-Forwarded-Encrypted: i=1; AJvYcCXSbWbIhhxB4sanHJtYdh1bdQ5gnSES6rHGlGTpaxUgYWxat00fN3883opKYVDHuqqS/mYC+YvWu8CSh5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YymGw18jVmeXL7rMMKVw2CkbA+BNIA2vRFmWLU67QlVvQwAbD5E
	EoCEek4kBGl2jcHp8KLmQgxwqQ6DC7Ige/+1pQlpAwmdwfs/p69DoMEiFw==
X-Google-Smtp-Source: AGHT+IHEF4SIOE1ASmVZGbki4EiC4o+CiW9ngWGXnJO5DlPHyFeIAeZ7QQBHSztMRo2kIs3SVYdAuA==
X-Received: by 2002:a17:906:4789:b0:a99:fb75:3ed7 with SMTP id a640c23a62f3a-a9de5ecdff0mr4000776366b.17.1730918039607;
        Wed, 06 Nov 2024 10:33:59 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:59 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 09/16] staging: rtl8723bs: Remove unused function hal_EfusePgPacketWriteHeader
Date: Wed,  6 Nov 2024 19:33:38 +0100
Message-ID: <aade93afb9f2c6babbcc9c55bb35341cb8c9ff3f.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function hal_EfusePgPacketWriteHeader to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index ae909bd1366a..155987c417b4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1327,24 +1327,6 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 	return true;
 }
 
-static u8 hal_EfusePgPacketWriteHeader(
-	struct adapter *padapter,
-	u8 efuseType,
-	u16 *pAddr,
-	struct pgpkt_struct *pTargetPkt,
-	u8 bPseudoTest
-)
-{
-	u8 bRet = false;
-
-	if (pTargetPkt->offset >= EFUSE_MAX_SECTION_BASE)
-		bRet = hal_EfusePgPacketWrite2ByteHeader(padapter, efuseType, pAddr, pTargetPkt, bPseudoTest);
-	else
-		bRet = hal_EfusePgPacketWrite1ByteHeader(padapter, efuseType, pAddr, pTargetPkt, bPseudoTest);
-
-	return bRet;
-}
-
 static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 {
 	u32 value32;
-- 
2.43.0



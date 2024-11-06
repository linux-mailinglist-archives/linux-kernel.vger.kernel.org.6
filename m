Return-Path: <linux-kernel+bounces-398737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC269BF554
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368EBB21C26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32D20968D;
	Wed,  6 Nov 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhx6SSt9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756C208225
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918039; cv=none; b=PfXdHPS9FtLyUsajz3dO7d8QgvUc5V1D2ZO+736+dx1DuwnM9kzRo1M2X65zY6EEmVW00Y7uRC9dZ+xybiHjGVA6w10LF19uObEZlGpIHCpWOphtuoSaYKNIVj9yFFfLaNss6X6gsbEsa/VK+W7tGsFpl5hKi+uZdVB1K0rrJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918039; c=relaxed/simple;
	bh=g6sBLUYkzsyXOm9RoSLhLsHpH6Q1sdfSsuPbf0Xpnas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny8+yKPoOHkQPVGKRYhD3JVdAJ8howyElHiXLOiWzYrNg816TGyB/JcSzlKgNjeheuRF8TN6R62pX6L7mlqYZsLvWhPZmomCpRDqoR4yTun2oJyoMV/H0G8xoJ79YeFqxr4mghUga9gHyvPEfCyoPVNFEM5sRdiv10nHTMPJg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhx6SSt9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9eb3794a04so7780866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918036; x=1731522836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuJSNI4Y5QqkewpyI3LKafSzihDaZEXh1WGwp+tPk54=;
        b=Hhx6SSt9QZ4c7W/LY7RgF/Fq3VWGfn5evIJR6cmSWOEHwopSgNZcSD2W6Gv/Gcfw3i
         HqhqNwRE7+doGLGjHM/pCZBkXjDYBKJqAIem6RMzoDiceOaLTgo/Fe81Cf8TbO6hlRGr
         mSo1NmXNtcaJTk8UGYN9XejsU/b2Q+6VUlm8XhDe+q+FZzAdRMpTPxrB8WRAwd2TwSNh
         xJThPiDS3XsMDbLtw59reo4sdS452rX44U3K9TW3ulonIUcecXOL9pRp/gAxctUhVc5J
         9SGzKnpp1fTZGETE/muD6VIvqsuGLaso7BDKC6k9H86nz5RLZL/g/APRtBR1hrL768li
         lq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918036; x=1731522836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuJSNI4Y5QqkewpyI3LKafSzihDaZEXh1WGwp+tPk54=;
        b=T+c217BC2s8UD1T0Cf/QvYIxYUO3BmrkeBm1/fQQBzyi+mxDBskBAYHJbs0WaPGwx8
         A1h89/AoiKQEo2g0w07NuKcFPu6ooyl8dQrfgOndXJfjuRRLi0uYuDQOzFal9hgS4np8
         P5uedh1eJCPj43v+S65k88AL0C7CIhtcfj9QGYossRQEH9FMS1Y9TvcFtnHdwzCZL2+w
         iwHs76QggDscnoRgSGyueebsehnCxwoH9sYbDmKhnGQbJD+jfjnAGsL7gWmxj/l7pmRF
         glH9Yd4t8Bt0ujQIlUIhspTXtVCOO2PjhlMfFJbfXoMgARyWf1RZlzXis9dY2SpZSmZd
         chDg==
X-Forwarded-Encrypted: i=1; AJvYcCVUpC6MUe2g4i6HAPrieSmJ75jqxKwhcgeZPJaKCprQr+ERfsG5ysckxPwFEpBCgFYCc3bYW9q0Ncf2yYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTKSNtzlEzy3LYE7SUliM829wXaWubpOur/NTMO96semxj2c9
	/+I0EjEibE84fNd08z24IYagws4EQbV6uKgho+baAyl8cL3453iXtT0FwQ==
X-Google-Smtp-Source: AGHT+IGl7JHhLJizQ7k5GFivgEP2bu6Q1l8L0CokMFsELwyE66YWlPRM4HHeGC0NIcrCMLgBdxcbhA==
X-Received: by 2002:a17:907:3f29:b0:a9e:c430:7758 with SMTP id a640c23a62f3a-a9ec430787emr416682366b.10.1730918035949;
        Wed, 06 Nov 2024 10:33:55 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:55 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 03/16] staging: rtl8723bs: Remove unused function Efuse_PgPacketRead
Date: Wed,  6 Nov 2024 19:33:32 +0100
Message-ID: <83a819b953cca910c6236c1185d256abd21f2602.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function Efuse_PgPacketRead.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 10 ----------
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 8e6c294c168e..e83daeb9303d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -311,16 +311,6 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	return bResult;
 }
 
-int
-Efuse_PgPacketRead(struct adapter *padapter,
-				u8	offset,
-				u8	*data,
-				bool		bPseudoTest)
-{
-	return padapter->HalFunc.Efuse_PgPacketRead(padapter, offset, data,
-						    bPseudoTest);
-}
-
 int
 Efuse_PgPacketWrite(struct adapter *padapter,
 				u8	offset,
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 0cb8c6f6d34d..de4e5906ceb5 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -97,7 +97,6 @@ u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudo
 u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
 
 void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
-int	Efuse_PgPacketRead(struct adapter *padapter, u8 offset, u8 *data, bool bPseudoTest);
 int	Efuse_PgPacketWrite(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 u8 Efuse_WordEnableDataWrite(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-393740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B03399BA4A0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0FCB214B7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32741167271;
	Sun,  3 Nov 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDT80obb"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0C15C145
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621697; cv=none; b=tX1zf8psAfL5aBnVlrIC8X/wT0LKl7ZrnAJmNf3hYlHJSa6mbkk0cWyjvIRs2btbzdMQY1u+YaGIQGIYfpg5e821FAU5L3yMRwhn1XU2UmCKD4PxiclmXtvzsxsczr3yGc+i0pcQr22CV3Fi8va2B8UhSLHXkr981ZIgL/4bBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621697; c=relaxed/simple;
	bh=7sKe1Pl+7CwfWdmhfNJ2WxpGLVatbPVCfDOtU3av8aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qR++Sys8ZgTdUEDkVireftoiOEQ4tmx+YZGAaZSmVQXB/bXePkUS7rN8gfbdNLf9umZTSY1XTlvgbViDQCa8xpUf4LVXkfyY6PKcII/G8un6x3ThggXE4hMBDSFccJ21CF8ZHEkrXm1U3qiUJif+67pnvFY1FgfAXPQHTbpBQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDT80obb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso4005736a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621694; x=1731226494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9L6U0Gk8YZHjTkzBekNSagvpm2LJGcdztz/F1h/LBM=;
        b=bDT80obbw+yz64RXhI94we2DAARE5deDSotF4gbxjkTA3WUMTURhT9JyAIy97vj2zb
         VnfbPuvZptXUe+v4cZwVMfK6ZmNFWmQLhgG2yEz09KpCtfLwUZ+VoDTvB8wH/EYuXyps
         skQ70Kp9/xuKn7I2IGaJPzQXfXnEJBU+LhNWKxiYVNnXR8S6p7hKPCHsl9jvtPuWbz1L
         Xyqq5X75H++tydL8nP05uYHSbh6bJRbONTaAed45a19IeEm9Df9KYjzuVIvX60jY5Y+Q
         9II3vAghSQ35/TU52l26uIgH8gJeOwfAkwkz0LJLvF8vb6SinTmcug5LnZrJSZtEjSPn
         sV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621694; x=1731226494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9L6U0Gk8YZHjTkzBekNSagvpm2LJGcdztz/F1h/LBM=;
        b=alrE3T2ORSxmlru9LQQccfJNQtyb0kzWZ8Qo/VxGvZyv5bWEUtF1Uqw2RTs+f/Vzf7
         fmwzNjbpBbzYwZl08lMSuwqYB7HlN7ahRMIzdzA2byS9fM0eqjp9P/wAjfPu6EsgJYz7
         5Hp4B8GPHOcD0yaFU1pFkURiFHqcdKRcXAuTznd84PV/na/AQo4TWER2/oVMJmTXY18L
         Nef7sCjr9pZXZ7Dr9AjhCyTmLX2u39nhzxPHVuf3IvVX5S5Q2mWpZb8Y/sk4IeI+tDUj
         Z4TnkM3tRycFkuMukpFJabERwT5QOBmshz/yvDiHLAylfF7zymiy/gM774QQQiwYQKbP
         LooQ==
X-Forwarded-Encrypted: i=1; AJvYcCUShCtqPECqXfQe2jK/02yhl+IOXgm/qjFFxKfh3wc9Y5YaI/ySERAdK6/xDhLQc8x94q30Cm8RCc/YCCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZyLDjhrM63eixQ6CtOr2Bp0sC/VAd3i4kQxO4FCHVNib7K6u
	Ozr8qfPP/MW74vLELX53XlmbAUeMWa/pTMVoYFuuTVbmYFwAyNrV
X-Google-Smtp-Source: AGHT+IFP9igqQElEcdzfvpQCH6ScPEFlcCIEAR+RwKIMPWuu5+OsQEWo9ibchlb+P/6X2aqbLxooIw==
X-Received: by 2002:a50:ee98:0:b0:5ce:c8ee:7e41 with SMTP id 4fb4d7f45d1cf-5cec8ee80a3mr3127174a12.22.1730621694098;
        Sun, 03 Nov 2024 01:14:54 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:53 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 04/13] staging: rtl8723bs: Remove #if 1 in function ReadChipVersion8723B
Date: Sun,  3 Nov 2024 09:14:25 +0100
Message-ID: <637bc9cfb1188fd0112998aea5d22241e965a50e.1730619982.git.philipp.g.hortmann@gmail.com>
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

Remove #if 1 in function ReadChipVersion8723B as it is useless.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 49b6507f991c..c3fcadc634f9 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1523,9 +1523,9 @@ static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 	pHalData->MultiFunc |= ((value32 & BT_FUNC_EN) ? RT_MULTI_FUNC_BT : 0);
 	pHalData->MultiFunc |= ((value32 & GPS_FUNC_EN) ? RT_MULTI_FUNC_GPS : 0);
 	pHalData->PolarityCtl = ((value32 & WL_HWPDN_SL) ? RT_POLARITY_HIGH_ACT : RT_POLARITY_LOW_ACT);
-#if 1
+
 	dump_chip_info(ChipVersion);
-#endif
+
 	pHalData->VersionID = ChipVersion;
 
 	return ChipVersion;
-- 
2.43.0



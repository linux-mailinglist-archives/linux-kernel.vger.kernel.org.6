Return-Path: <linux-kernel+bounces-393991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC149BA850
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463331F212B0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB5192582;
	Sun,  3 Nov 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnoUU7/N"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A318D647
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669202; cv=none; b=tURwribnsTvGS5GRk8hGzL39duXOXZ8ecbKgGb8WzB6Qn/4GEvE63Qd9bdB8Q/12yYEdTnClsAo96kPE8cj6c0b7tuMQ02pkzmZz14ew8O7fVoIpWvP/oRAkQap5MuZyyRX03VVSARNb8NIucynVA1oR+XZZ9a8ETEAeUwbtwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669202; c=relaxed/simple;
	bh=tBW3esnZSM+5l0zHXX9xuAZ8mT7/nVdsRIt94p77xvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQSRTzYeGak6h3avoFppINZb++OU/cUrgiwjjwtMLkQw5tg84c0TyxT1uXjad78/vdfVTOjhC4ftEJf0iv1TefV/uM2Fbv9UJcJENg1rz1wWTi4EyGlUNLbxnXLhrzQFqsJH8zM2l9eBbEyjpTjZQ3CCeCtKIvBJHu2oprDnhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnoUU7/N; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so31540925e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669198; x=1731273998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hpb+hfuRWtk7Neut2FstHxoBo04AGr1EjSHYezAftH8=;
        b=gnoUU7/NfbT/4AHB9QqKOHOrOlMSVDYJSMxKI+UjM1RP7IPhA3oTCBX3BxeHYZqO9M
         E8nvO4RdchbOD9e+uuVeSFJcT0Y2icpXImLovDB2KfITSozLR9lpoCYVRJ4KGc30lrXd
         32hzzg03otQZZkrehxyA7i4NrPNUFDWRUfaQGZYW7njdPxRDxSSmvpiTnlJwDpbGVTd1
         xMRvBCpUzucvghWvCji1ay5udBQWoZD1jhQy3oC2hed+5nv16ZVhzW1vVbrtLBytkTd1
         aEmi4N1N3DJ8w9b1MyIcGzvOUEvZgGxYtW/YzJUL3sHotnuUqpgfA4E56c5EnDcx1WWH
         twfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669198; x=1731273998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hpb+hfuRWtk7Neut2FstHxoBo04AGr1EjSHYezAftH8=;
        b=BAfPX0adsylxFnhLctcAkcbMYvZ1C6SumgK3+54xOYT/HBL1ag7fwEOMyah+zVvwGs
         CmnerknD6Run62LGQN7r8G/Glvg2RjWqDPqA0RlBNhcKzlCA5ITbSHqt0HcIS6SRqYRv
         xah3tyo3OlNbol1BSnTR2rxggFk6wJdcblSYheeEY8mai9IpnofnLkvrPu8rSZr+XVAi
         q5PsFoBiIygWZbpRsZX1lvGcIaUYhkp4C9Ufa08jXkeLZfzT5oFMIowiNie/ZVS6vwzG
         kdNwCXk79CmofWh4xPG9iMmAveJfvs0q98WCzG0i1zJaGFmcBv0IKvlQvhYQcVwl6whM
         UmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/2zPjeKeH2m9CPLwaxynD9vYAZcIQoDLNLZ4Bzq5+6NJ8zSt/Lrcua4P+XecQICIHogB0BdLU8U6T7CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNejSPbZ8ccjAmPXGUcfm9l71Z5/P9k0kmNsw/GrjM0ltO1nbm
	Sp4RuZ3YqkCppT6CX2UJ1vEqf/CsqdfzGTZ2IonmNNhXfM12+I9bJ6S0XMdH
X-Google-Smtp-Source: AGHT+IGy1u7BxCdxtmIXoJggKM8bEb/ymRcUNlSCICeYKE//ibdTFgU8yKXD//l/uwT+jh0+jmccWg==
X-Received: by 2002:a5d:6d84:0:b0:37d:5129:f45e with SMTP id ffacd0b85a97d-381be7c8137mr12211534f8f.20.1730669197569;
        Sun, 03 Nov 2024 13:26:37 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:35 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 07/11] staging: gpib: Fix Kconfig
Date: Sun,  3 Nov 2024 22:26:13 +0100
Message-ID: <20241103212617.13076-8-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103212617.13076-1-dpenkler@gmail.com>
References: <20241103212617.13076-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NI_PCI_ISA driver also supports PCI and PCMCIA
Correct spelling error COMPIlE_TEST

Fixes: 2c9f5d8c6ece ("staging: gpib: add bus specific Kconfig dependencies")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 0ea9a276c389..95308d15a555 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -61,7 +61,7 @@ config GPIB_CEC_PCI
 
 config GPIB_NI_PCI_ISA
 	tristate "NI PCI/ISA compatible boards"
-	depends on ISA_BUS
+	depends on ISA_BUS || PCI || PCMCIA
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
@@ -138,7 +138,7 @@ config GPIB_FMH
 
 config GPIB_GPIO
        tristate "RPi GPIO bitbang"
-	depends on ARCH_BCM2835 || COMPIlE_TEST
+	depends on ARCH_BCM2835 || COMPILE_TEST
        select GPIB_COMMON
        help
          GPIB bitbang driver Raspberry Pi GPIO adapters
-- 
2.46.2



Return-Path: <linux-kernel+bounces-392658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F89B96BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9068928309F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3541CEACD;
	Fri,  1 Nov 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfyaKW79"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67D1CEAA7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483272; cv=none; b=oQMYK8dSigLgzYxLoLeIioCAK8U7h2GOGzkZYF7RMx1EKe6d9USQUz+UD3Fo4+s4aM/JTWYSOfeJPAkvX26qIOoQHf5y/RukmJ460JDLbjLOtCUl4t0I+k403a42FKBdjq9JWNwi1ZLtZdIlGxfsyvyUiEBHfd5KFuwUZ9altBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483272; c=relaxed/simple;
	bh=oa7FxakZaookSds0SFTFTDKYzsIa7xsMb5ayvu/2Js4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPrP1Zs8uHuFpRjq6FE5egqgeY7briPF7x88f5XcWzEpROo3IlGmmVGmhifm4vZiib9dbKdQO0PM18gP0eMfTYlYWQ7FkBCVY5QipXO6AJ8J/DynbBWp3qeJ2gZfFX/FQg70W+5a2dW0fAr7gqTjUiBTS3ROmgBr40ei0iazsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfyaKW79; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so18963545e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483269; x=1731088069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv3PqSzswe4Y5a8fVVX7vlIBbx348r3jo5xKs83X2jQ=;
        b=BfyaKW79+hRFsMrur/SMz52bK6Xf9kXmdpg3wIpQeWqGwdSFkSL3jDumepSgP17ykw
         +BHXCJ6ApxqF/8c5aFPwsubLLI+IA5EWLFzw8WLe3tgfFsnLlmCzJK/jM2Co84feCsAB
         J6I9wGw1NU0bbe60ZnAaOTlO3B1ws3zAChWBXwU7wXRQAJn1MAaWV7216oNThijL/OGd
         pk1EzpfYxuy285qdpVbVRWcJVNABsXaquFNpH2Uu2Ar0Mjp7hXGKQ30jalinJ1yI1gzB
         LVpTquKfIJJycsy3P8pfS/a8SaJzInv8hqMpL4suVFmO3IOu+TDxpgsWWEv2aRDXT7s0
         Lelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483269; x=1731088069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dv3PqSzswe4Y5a8fVVX7vlIBbx348r3jo5xKs83X2jQ=;
        b=iQoUrn+MiMwM/6Gp4bOOzBKNEX1sxfIhALd8dx6paWTaZjSw8BJKeyBDrIQNNj9HIB
         CCUSugOuCKQEA+oTjlulCLOQMfRviCZEUwVWJ9UTN5XvgElcaStts2DSR5HTPqpmj0DM
         w9p3yAX8tqoJtIUmT+cWYc32Ea60yeE19WyVrxiEBesSuuKQWrC4ey8Xg1U7iy6K/ZtI
         BZNFOSfY6yheRdaphq5JuEJzsZTSvlsV1nz658+xPMkS9PGFjxQ8xyENcE2rTyqWZbKs
         roFmoHoCA9/xD7N3Q2YMql+Fxb7MFWq9m9mvjd1HAArVSqUlXJkQq8kRCzcFwG1xAlmX
         /pTg==
X-Forwarded-Encrypted: i=1; AJvYcCUtDBj/xpc/kJwzXByC0ZnaXY/RYe/17viPDlAUVZR2VjcEYjIJh0JfrRkwPrWyvGjUcgy/c7Tur/njGms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+FoLXu0Vcz4yKiKL4eKbU37mesd/9D8HejU2nf1KXVr+HTfS
	txAyYXUQj2rJSoF6QknvtHNZrAOl6cTxkAznh2mDTSlFeQHHiKDnh4erZBwx
X-Google-Smtp-Source: AGHT+IE0O7ngfpdMaxPEYBKK5+0KGkwJ4Bru5OWs4wnoIv0xOr7IFO5MWtlBds+6seq0q6jQeLc8Kg==
X-Received: by 2002:a5d:6d8e:0:b0:37c:babe:2c49 with SMTP id ffacd0b85a97d-381c7a4c7d7mr3540674f8f.19.1730483269243;
        Fri, 01 Nov 2024 10:47:49 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm5732933f8f.112.2024.11.01.10.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:47:48 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 7/9] Fix Kconfig
Date: Fri,  1 Nov 2024 18:47:03 +0100
Message-ID: <20241101174705.12682-8-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101174705.12682-1-dpenkler@gmail.com>
References: <20241101174705.12682-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

   The NI_PCI_ISA driver also supports PCI and PCMCIA
   Correct spelling error COMPIlE_TEST

Fixes: 2c9f5d8c6ece91ecd33350749230494d224550f1
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



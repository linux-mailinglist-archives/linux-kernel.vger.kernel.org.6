Return-Path: <linux-kernel+bounces-258694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123D938BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8F02814AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF416A382;
	Mon, 22 Jul 2024 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HQ10Z+bS"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBB16B38B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639238; cv=none; b=FOxpTWFbB/P8Il8SHJv5sN4OGfsGjGKrzX229zImV1xt+JvIPXGL5e3OTkJZ7HCc3UocY4P3nr1DIRCBo+3MwciBP5Tkd++vo419WUJjYah4IRET/zCZ2uFbYsrtz/f5uQ/fGPqiCpY8xBFqp6tMvRWx+/Qqex8XFhxdco2tlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639238; c=relaxed/simple;
	bh=J9TwGknNWjs/N9deiPaq5k+uLL6PXCMwbiv/oe6XZ94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6EFw/SmpY6gvd1Hoqd/onFVMutoZUt1Fyfm32+5rxgyz38znwJUaKN1NeM0Jxorichjdl9cM5mJXBxkPOtm/T0QOPZSyoNR0WRgGIRdzNS2gjxCESp5h7csEpcNWRayGZXZY5C6+30QjpZMAsBq9YyKnq3/Jp+4rg3u6G1v9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HQ10Z+bS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eea8ea8c06so53078901fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721639233; x=1722244033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/F0ZmP17hObUGx93Q7otIls3wWDQaOtJ+irX03aguA=;
        b=HQ10Z+bSAbtFT8HdmzvO55SF5l1Z8FImaPwOkvWAp0fuUGZyJrCoPh/UAS3ddbrqks
         Ob9MxFSHD7y0wEvPO20Iq7SmYsd4m+LSqv74tJ7AjA3v1oSGSIC4FlmDCLQ7hyAVhAyI
         l0b0JnQZl0+eDnE1aJhZbcjJcQ0NkoQAFy45fIA0Rt4HSzxPJZnrYCE/C6BU0e6Ek7Zs
         J9CeOoOcLiTO3gT3DlFqYJGKwtZsf2WuIdbQOqYubBTjuuH5AnZCjxklL+TKSrOe5w83
         iSQoBR7YKhuXgFwPCBkpSO5v0m81jLdzshjBXoc1fSA/Q4lCLaYhCURTEoo9sM67O6dA
         9vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639233; x=1722244033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/F0ZmP17hObUGx93Q7otIls3wWDQaOtJ+irX03aguA=;
        b=M/5hs5VnEtouittN20oamVYCn9X8wbRAZO6wKD+qHHNDKHYj9pnmmJUMhA/LAJ5KjI
         qDsOeWafi6WxfsndzKITC/BifrMimYuuQcoD/X6YmuaVLDyE60IB3gX7pLwacDmle1/S
         f7xeJPu5lJKBff7QIX+ZDb8NUGYJ6twyXCdvJZUhtumfYxJfZc4vEMzqqP1orb/8mk3Q
         g+PtvVtNh1a8SOnDqeqzcXyFiCPrfy6Ioc3Ls+BVdAuuuHxuinOukfvJyVl5R/wnedln
         9mOwqPuKUI09cAxZgaAN+4sLMZxSRsR2vWRMMJLwLUOeZPP8YdmSFYLb1hkcWBbT/zL0
         lytw==
X-Forwarded-Encrypted: i=1; AJvYcCXKT7FXyM9BMdT1KaJLqH9KFY+WS22nU6t3tSHz1xzAkrMwtd7pdpIhjjcGUMNPDp21qTcE22rIwXsoNA5e3oAJDsTl1To+QlHrBAZi
X-Gm-Message-State: AOJu0YyAr6d7UXteKaCtk5O7PJ3EUk9Z81nKSk6xtr45T1bsTGdC7XEG
	P2/n4QYXQSfLjqh1dAIwys3NflHQSK7llsGSd97yU2Zsh2m6OrzcXuXOG8gaOu8=
X-Google-Smtp-Source: AGHT+IFCPNC5SoKT5EINogEfHSqyN/UbbcWJnoEmhmIjj22SyV1kqmShS7JNJ5O4PLkhW1QWWrFjrg==
X-Received: by 2002:a2e:8789:0:b0:2ef:2d8b:7cdb with SMTP id 38308e7fff4ca-2ef2d8b7ea9mr21511281fa.22.1721639233272;
        Mon, 22 Jul 2024 02:07:13 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7753abeasm7534290a91.48.2024.07.22.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:07:12 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 2/2] module: Clean up the description of MODULE_SIG_<type>
Date: Mon, 22 Jul 2024 11:06:22 +0200
Message-Id: <20240722090622.16524-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722090622.16524-1-petr.pavlu@suse.com>
References: <20240722090622.16524-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MODULE_SIG_<type> config choice has an inconsistent prompt styled as
a question and lengthy option names.

Simplify the prompt and option names to be consistent with other module
options.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index bb7f7930fef6..ccdbd1bc12aa 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -228,7 +228,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL
 
 choice
-	prompt "Which hash algorithm should modules be signed with?"
+	prompt "Hash algorithm to sign modules"
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	help
 	  This determines which sort of hashing algorithm will be used during
@@ -238,31 +238,31 @@ choice
 	  the signature on that module.
 
 config MODULE_SIG_SHA1
-	bool "Sign modules with SHA-1"
+	bool "SHA-1"
 	select CRYPTO_SHA1
 
 config MODULE_SIG_SHA256
-	bool "Sign modules with SHA-256"
+	bool "SHA-256"
 	select CRYPTO_SHA256
 
 config MODULE_SIG_SHA384
-	bool "Sign modules with SHA-384"
+	bool "SHA-384"
 	select CRYPTO_SHA512
 
 config MODULE_SIG_SHA512
-	bool "Sign modules with SHA-512"
+	bool "SHA-512"
 	select CRYPTO_SHA512
 
 config MODULE_SIG_SHA3_256
-	bool "Sign modules with SHA3-256"
+	bool "SHA3-256"
 	select CRYPTO_SHA3
 
 config MODULE_SIG_SHA3_384
-	bool "Sign modules with SHA3-384"
+	bool "SHA3-384"
 	select CRYPTO_SHA3
 
 config MODULE_SIG_SHA3_512
-	bool "Sign modules with SHA3-512"
+	bool "SHA3-512"
 	select CRYPTO_SHA3
 
 endchoice
-- 
2.35.3



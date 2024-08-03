Return-Path: <linux-kernel+bounces-273490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B69469E1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5BF281CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0183714EC41;
	Sat,  3 Aug 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f24SNGhe"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA11ABEA7
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722692279; cv=none; b=n9XZCm7DSF7wrfH8A5urEUOdJKqwQFkL8R7hAmQPsZNf6EcPz0MNnEA8lWEofgkwu9sggoz32BSzN4xZdKiVK9MHXSgqqqFZ7sB9xiOJEPW5tXRwXYA6ogTsvj3nM+H5p8X7/pE/BuCEn69Quf4HvNlQ7qXzOGLkMjaAC5k6SfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722692279; c=relaxed/simple;
	bh=3eobi2IwtvOki5drRqQ3fwX+2/8W/GuPR/3Aa8CVgXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvupJ1WQPRqcitXWKvEpd7jNpCAOK61r60/c5VZX13KKo2jJBVkxdGT+prVmfosj3kR4LOf6nz+sKtCYRLQgOjzmwSuSRfFlqae18lyWv2WLsNnAseP9+ZqBlaX8xJlDJOVNFJfjpKBPvfhXAYfJXUzxWfuBBpTWqoRfBhQQLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f24SNGhe; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-264545214efso5018419fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722692277; x=1723297077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3bgXFgypD/myAL9qkYZnwoJ5pcGO43srbDGKdmdiGw=;
        b=f24SNGheI8Drq32uQVUCjK9Pnpl4tFBgrDm7ldY5PYXRZlXJZoFggsXnUWMAfyn1SV
         EiKh5yhVstyMnYOvw9ESuiroYG3jrYsVVM/JmjXzSZ3CfMKGGUxqseeBuuRfrmvvk+uy
         M5Pbzj53Qw76bnhl9NYZU9rCAjzJIhlcEI2pBJbUJcOiZk5xTIQ/qN5QwCVVLvg+oxYu
         NvZkV9IxR9uh3VZmghG+n39WlD3LTQUuYG28MRrzS7ndBHQeO0nvLzet1EG6TFJLJl/1
         huPwLt6bV/kKdr6xAVtQnT5b62eXVP83LJEANNIkMbttvqQwU5MuA6qcZb8bflgG1tmF
         8JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722692277; x=1723297077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3bgXFgypD/myAL9qkYZnwoJ5pcGO43srbDGKdmdiGw=;
        b=Om6LIHScjv6xRYkrGSZsP57WxBh2Fb6DswslSa5GNdOMh0CNqXyjR1OaPzdKMSxqTJ
         bx41xlDT4OaH6ns3wZdEmb+6TxSe+Yut6dYZ60U9SoXjzrQIFguD9VSL2nSF1EtQou1L
         sJvwND9bhjphEPyXq8ShEJtb3Fx0qvS8TyCu626rRFufcPuSkabzzniyI5FdXK9zBoj0
         ljkbTtBnYJmyxrc9q/S0gfaflfwbT7S4sOd2UWWQV9ArGWxPTBZz9e9AzBdO3Wsrs+5G
         uUeRPl0ge4qAxeUPOHZXORixcpRCM8w/ybaZfx75iXXUImPiukoLT8CHaYq/bjMAng5T
         3oWg==
X-Gm-Message-State: AOJu0Yz5okhLeRNl5Fs9c2N68/p66BTi95IjZTxiFbFnzT8B44FooNQI
	Ajb6T5kxyTDsyM6foz+eF5fE5c36e1/oVuY2DMKJWVCnS2XnddR+FvOFueV8
X-Google-Smtp-Source: AGHT+IH3Cbh3UIMvUm9t9mnvk5o9GuciOig/1w9mBQ3dL2sk7xYJdtAEv5fr3tXRtLcdwHa6Wp4MYg==
X-Received: by 2002:a05:6870:860f:b0:24f:d178:d48d with SMTP id 586e51a60fabf-26891e930cfmr7414642fac.31.1722692276943;
        Sat, 03 Aug 2024 06:37:56 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f2acsm2355349a12.3.2024.08.03.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 06:37:56 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] uapi: enforce non-asm rule for 128-bit bitmasks macros
Date: Sat,  3 Aug 2024 06:37:52 -0700
Message-ID: <20240803133753.1598137-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros wouldn't work in all assembler flavors for reasons described
in the comments on top of declarations. Enforce it for more by adding
!__ASSEMBLY__ guard.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bits.h       | 2 ++
 include/uapi/linux/const.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index bf99feb5570e..60044b608817 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -36,6 +36,7 @@
 #define GENMASK_ULL(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
+#if !defined(__ASSEMBLY__)
 /*
  * Missing asm support
  *
@@ -48,5 +49,6 @@
  */
 #define GENMASK_U128(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
+#endif
 
 #endif	/* __LINUX_BITS_H */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index 5be12e8f8f9c..e16be0d37746 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,6 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
+#if !defined(__ASSEMBLY__)
 /*
  * Missing asm support
  *
@@ -42,6 +43,7 @@
  * GENMASK_U128() which would then start supporting asm code.
  */
 #define _BIT128(x)	((unsigned __int128)(1) << (x))
+#endif
 
 #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
-- 
2.43.0



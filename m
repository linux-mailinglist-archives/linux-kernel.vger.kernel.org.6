Return-Path: <linux-kernel+bounces-246825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0492C7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8C71C2204D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ECB4C6B;
	Wed, 10 Jul 2024 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CQrpebqv"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32217FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720571733; cv=none; b=s+HU3Mm+T0cHson+FkjwPodtpJUGL04PyZ0VBhzzIloIm37bhEkVsQkpuBcw5kvBHLMsxc8nTvDbh8oGNc//Yf2WrSFk6pJTChCwIgWUpmFIrg5OWtEQQkI9OeK4aPZFqv9NTV8i7Mc2RsS/QI1f1Ut/GTUzaCL5l/D7+dcOryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720571733; c=relaxed/simple;
	bh=I5lFfq0xuRErH6ax4FoTYom/NcQ0JeJ9kP64P+XV8vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SALA0YLdtZoTAaWYUohhfSd7Do/w16wtsaNW5xk0getblupOfeBihVo/0v8iO3AYFhmhkkzrqd33mx7Sw9Uxya7Hpr5/tbY/HqAj5ou+PNUbKAIqKlhtJr6yOZPI7+ZjWc4hD2J/dAzcjAx8xlv+mnZhKwFnbKoRP/gTCbakjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CQrpebqv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-59559ea9cfdso1375284a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720571730; x=1721176530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKwQ+Q+9TfT4z2bS61ufsxSCCuVOp72eGiupWLKWdwU=;
        b=CQrpebqv1J14/5dgY5qyrx9pHQJlR6Tq9HYJA7V6bOwfReZhlNTOdI6Ow3OWk9db+w
         d2nRl6Ih/UK2eerIULx/UjMMx7/wBuZkmumbW0vGuFus+iJHSeRNOBidQ032PyMBB7ux
         mybFipJn7l8OU9bxvrTeKnxurytksMWusbvGZSzPy8eOeVvGN4qUMVCde6D0w+UtdSp/
         ytmbfpV7nZ/4/2MRfzpWYHD1/ra6ZsPf/CgVq2pukZFxMX+y/dRO5PGiq4gvFMbxVz4X
         wtoCXQ6RYZRI/cE8Fo1ipjc4YpHAgvi1xsKVrTgb1vfNUsj8ZaGP/pII4MatuXA1A9wX
         IZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720571730; x=1721176530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKwQ+Q+9TfT4z2bS61ufsxSCCuVOp72eGiupWLKWdwU=;
        b=m9BeA2J+WC2PqTFKm54vXjiIqkO2B7kYRzOg32FA/ut9J+IlKBVnYX1BMCNE/jF4EO
         3ZzyCJha4fd2xzjE51JtNUFzJbCbB5PXWRDj8z+V8yMz8UeVR35VLD6STGQezIyYAkJR
         cZ26o72amk9vZ0WxDl+/zEDSba7MMiAVbrFBNvydAlfIA4auHB5EQKk0oShAA8fMdogA
         vuulRT/Cp7xrtScl+PE9Om+1yrN6W5fguTOnjERjJNtz0jPU7JNfOeZeXmWH12J8E5zo
         SjvF4KHCN3x4AlrChZgk2pEhJ6ZNloSrgGRjBHmXydUtmaglOidtwyEV9POfW/6k8A0E
         GBdg==
X-Forwarded-Encrypted: i=1; AJvYcCVEZQCO5SgQtdxZJJbisARiKAq/61Cdk66LUthe8HoxtiGIYukvz3t7nrJwoDYNIrwcTzXKjxMPXG1NUpgCIohK/VQ1GFIOSf1kIsag
X-Gm-Message-State: AOJu0Yy/TbEx/6ZZc7Ium0Kg5YmoS8l7n6WiR4E6B5lw0nXJIWxbE2oK
	TAteqC3fpIcR5nyA13UICJ4n/RjVCHvFo4Aav9luZTn4/WcZasVHVC/gA3L2g7s=
X-Google-Smtp-Source: AGHT+IHhpaDnL1YZjBNUtimpsh41l038gaeUBPyzyjosNpBFsZGA8LNBeDzo62/SybMsKoWjekyGlw==
X-Received: by 2002:a05:6402:4408:b0:58d:410a:32a9 with SMTP id 4fb4d7f45d1cf-594baf917ddmr3706850a12.15.1720571729587;
        Tue, 09 Jul 2024 17:35:29 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-224.dynamic.mnet-online.de. [82.135.80.224])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1absm1620928a12.77.2024.07.09.17.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 17:35:29 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] ARM: vfp: Improve data types in vfp_estimate_div128to64()
Date: Wed, 10 Jul 2024 02:34:46 +0200
Message-ID: <20240710003445.323418-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The divisors mh and ml can both be u32 instead of u64.

Since do_div() implicitly casts the divisors from u64 to u32, changing
their data types to u32 also removes the following Coccinelle warnings
reported by do_div.cocci:

  arch/arm/vfp/vfp.h:121:2-8: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
  arch/arm/vfp/vfp.h:135:2-8: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Use upper_32_bits() to compare 32-bit numbers instead of 64-bit numbers
and to prevent the warning:

  left shift count >= width of type [-Wshift-count-overflow]

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/arm/vfp/vfp.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/vfp/vfp.h b/arch/arm/vfp/vfp.h
index e43a630f8a16..29073d89ef00 100644
--- a/arch/arm/vfp/vfp.h
+++ b/arch/arm/vfp/vfp.h
@@ -109,12 +109,13 @@ static inline u64 vfp_hi64multiply64(u64 n, u64 m)
 
 static inline u64 vfp_estimate_div128to64(u64 nh, u64 nl, u64 m)
 {
-	u64 mh, ml, remh, reml, termh, terml, z;
+	u64 remh, reml, termh, terml, z;
+	u32 mh, ml;
 
 	if (nh >= m)
 		return ~0ULL;
 	mh = m >> 32;
-	if (mh << 32 <= nh) {
+	if (mh <= upper_32_bits(nh)) {
 		z = 0xffffffff00000000ULL;
 	} else {
 		z = nh;
@@ -129,7 +130,7 @@ static inline u64 vfp_estimate_div128to64(u64 nh, u64 nl, u64 m)
 		add128(&remh, &reml, remh, reml, mh, ml);
 	}
 	remh = (remh << 32) | (reml >> 32);
-	if (mh << 32 <= remh) {
+	if (mh <= upper_32_bits(remh)) {
 		z |= 0xffffffff;
 	} else {
 		do_div(remh, mh);
-- 
2.45.2



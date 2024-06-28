Return-Path: <linux-kernel+bounces-233394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27F91B672
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5CEB210AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4043398A;
	Fri, 28 Jun 2024 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="PhgwTWAh"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4F20319
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553552; cv=none; b=npC3majK8KKWxY3B+myvD09kFuY18RQjE1iFqeZU3VOWAvbtjAiKTjcTMaokPRYdG5b1XFebzaU3Ly15i+yqlT1tN53GhFzoltkSVWtkUkeSuc5Deco8IsKFJc499VDNAg1vi+34Qm7EQpO3T71sVmtQlErwGL4ytRvbFaw1ZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553552; c=relaxed/simple;
	bh=I5lFfq0xuRErH6ax4FoTYom/NcQ0JeJ9kP64P+XV8vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5Oaj/Ucb9S/wGhRO2vSOBMVpjexvwZSyPVrEOdCHfOmHlaDzsmLKtrF5VZAoaOns+kMdOsBuRC00Dfv2Q2tIJBMWtvOR7ox+hbVEDzZxk3BCMu3+EfdOAsBhQyaI5/+o0z+p3f5MYAVDGzxWDqTbXo7QAnYJCwKvh2VPMEpOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=PhgwTWAh; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c21a177affso106733eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719553550; x=1720158350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKwQ+Q+9TfT4z2bS61ufsxSCCuVOp72eGiupWLKWdwU=;
        b=PhgwTWAhDsP3lXX/55rJQbJKCbaksUqbtaQyy9h5HAlbOrmP9bwlmuPx9iF7WQWqY7
         AJCpYRana0p+OdZLQEx/sQJE9hfCXRoY/9yP0T1IqESF7fR4ZJ7SJ3kFhFcGfDCW4GXg
         H70EtadgUdshRvZsT8MiSEvyJ7NuztJxpq0lHj3WlDnZSDjh04+HLfUowmnso/pIupta
         Blz3590gZCMk2BEyjqVRZqBtAgFDZ2VTIj3wR93UvQr2/Gy/kXspeDnUWml3bFqnV5m8
         cWqKZtPwTaJ6G8PjmY1Zvg80Sw5R6J3ruGSASzLorDFRo7AGKpUWcfXVQlIgfA84XzTK
         6N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719553550; x=1720158350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKwQ+Q+9TfT4z2bS61ufsxSCCuVOp72eGiupWLKWdwU=;
        b=OzcJDvIj49pF8thKYin/kpURCpeeQx+imhv1BCZnWfwXsT1Ivo6zQ+HxOMJyD6BD5+
         ugmO5qFS/GP1pbbt4vS4uvIHkt6MrsZeGpnegB70CJTrTiBZ2DTLA9uBPs6gaj/DBkBw
         LhVauz0xK1qdQF/w3LCUd8dTk6u8SCGWs8Lx0BVjzUIhMEQ+BhceJhqplYyiXthpo83x
         CiKNnP5Uoz2bYScV2n2hfQ2bhUplMdqXu/96yeaTDGVF7oSKG23wQ1IbBSBp4oEp690C
         jxFU3W4KPELOBQNM0t/AQ6W0wUsQ466o2nIgnZ9zw3MAqqq3NduVa9h1gKz1bfmAo7Q3
         eCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZNONLek0r54a/4RCK5Juzd3FIIR4XfXM0sKI7XVJeqk88WY9Ho/XzcQapVdl+WTtH0l6G+3F6tTRxGOPXovFpnL3Zm0gHbiuZIaI2
X-Gm-Message-State: AOJu0YwajpY3L6ajW+KqHhm1ZksU1KtxBvXaHsyK54ehFBzg1Njp+o8x
	f3i1eCb/cLmtLVbZwSVWFQNKG3wl//6BBeZxH04q0hlf4BNm4WHZ0ucHzczfEWY=
X-Google-Smtp-Source: AGHT+IG6eP69dUZnkaDfPjRZYetEYIxPWuLgvgd/psEEELnjsa9q71KwZV7BrZKfjW1XpUxUR0Bc/A==
X-Received: by 2002:a05:6358:882:b0:1a6:904b:3d2a with SMTP id e5c5f4694b2df-1a6904b3f6emr62211255d.28.1719553550226;
        Thu, 27 Jun 2024 22:45:50 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b515f1sm598370a12.6.2024.06.27.22.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 22:45:49 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ARM: vfp: Improve data types for divisors mh and ml
Date: Fri, 28 Jun 2024 07:44:06 +0200
Message-ID: <20240628054405.317236-2-thorsten.blum@toblux.com>
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



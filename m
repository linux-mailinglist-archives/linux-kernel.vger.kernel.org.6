Return-Path: <linux-kernel+bounces-256873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7DA9371A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207FDB2084F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DBE20ED;
	Fri, 19 Jul 2024 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nr74qZPC"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A01362
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350298; cv=none; b=jNKDcNA1ODCocYAGYJ8rcQXuTUv/yXqB3JY5tyNuMnRvwdSOoA980bYMLNrUL/zIJzUMk7YwZ/fNtGz7R5Yk+dirmXmYSlod3lhliaMiY6Vs1y/O3GzfgD2ivHB+jv81e/ErNpDwn+63BbfEV1DOC5icYppwe/lkwV1lARbpnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350298; c=relaxed/simple;
	bh=FeisRwuZph9dsqVELybpXvsFp0hEbNQ9L1U0P9roCq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wbyh7t4C1usmkh4rrkph6JZH439+J4xIolvSnm0pAUuEsafIP+AUbWbNiUjOHfIJCbusNiVvyQXfoaIkVyddj2CkHLo8GFJbKVUMqqYRTc7RgMwIGkc3VmQzvBz43t+d/T1BpwnbLpy3/U0yrHxTptE38nbiHR4o3TUimOVBV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nr74qZPC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af3d9169bso324161b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721350295; x=1721955095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KruBUfG4EXE06kCHW9TtZ6QQTPJGRmAoTMKXZnLtXCU=;
        b=Nr74qZPC4Zx0EddOhaeRkk2pw7AJ48r3u48LqL54VtGW0CP28bFvGB6K5P0RZDynYB
         ZDBPB2gJ9DKzwORmhlo0WpbFkI64pV4YyU7elvJLL7KUZRyMlzU5Vl1k8z1ZUAyLAyur
         IPZ4cZR9/Xa5XC6a301teXKr6NGbGwcJmJN5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350295; x=1721955095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KruBUfG4EXE06kCHW9TtZ6QQTPJGRmAoTMKXZnLtXCU=;
        b=isC10yWCQyh8kc2aa/pJQJHDj4MWAxUOgbT8sGxEaHwqEge/pKU+WWUabNF9Ny6Opl
         CmY/1R36Mr9wFkAhPSLYZz2x7D3NY74TGdU0Yq7Pml4LIsP2My1bvT2XxrAR6DeI/ldr
         J4vq9avF00wYJAMdA3LsPeT0g+XM5Jq76l/xDSH6kzIffJxgCiCEGgP7wZ53Gqm9BnvE
         PKuWkhpJ7HStVHve5q83eA+5/PvFPb2OkgJZGBkrexGD2UE/+bebB6Q7QIO1dsCQhjnN
         e5fj5n9LbnFEO+5dR8lYQbaUsj7WgXJYgTUBu0SUvDRlUPrxt7htE68VT1UGkbD6bYWY
         IIZg==
X-Gm-Message-State: AOJu0YyOhEgyDpSuaPSOtvStJSVFk+h34X+DWUl+aACSQ56v44w3PyEZ
	VRsi7yXJonQ1GcitdNLOSe1LpKCHW24gN9uKkXJsv9YV3Arzx2P66juD2xKTnw==
X-Google-Smtp-Source: AGHT+IHlWInhZx75758Fxg94xf/sk3Liomtf1n6K/PVKk6RWxdNBsrOfpQfzHFBOkuhmTHmxjOmb6w==
X-Received: by 2002:a05:6a20:841e:b0:1c2:8c32:1392 with SMTP id adf61e73a8af0-1c3fdcf886emr9004244637.22.1721350294667;
        Thu, 18 Jul 2024 17:51:34 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:35aa:f87d:7549:3938])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2cb77540a84sm1385207a91.52.2024.07.18.17.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 17:51:34 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	llvm@lists.linux.dev,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Brian Norris <briannorris@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v3 1/4] find: Switch from inline to __always_inline
Date: Thu, 18 Jul 2024 17:50:37 -0700
Message-ID: <20240719005127.2449328-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov <yury.norov@gmail.com>

'inline' keyword is only a recommendation for compiler. If it decides to
not inline find_bit nodemask functions, the whole small_const_nbits()
machinery doesn't work.

This is how a standard GCC 11.3.0 does for my x86_64 build now. This patch
replaces 'inline' directive with unconditional '__always_inline' to make
sure that there's always a chance for compile-time optimization. It doesn't
change size of kernel image, according to bloat-o-meter.

[[ Brian: split out from:
      Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
      https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
   But rewritten, as there were too many conflicts. ]]

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---

Changes in v3:
 - newly split out in v3

 include/linux/find.h | 50 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5dfca4225fef..68685714bc18 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -52,7 +52,7 @@ unsigned long _find_next_bit_le(const unsigned long *addr, unsigned
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
@@ -81,7 +81,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -112,7 +112,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_andnot_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -142,7 +142,7 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_or_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -171,7 +171,7 @@ unsigned long find_next_or_bit(const unsigned long *addr1,
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
@@ -198,7 +198,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number of the first set bit.
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -224,7 +224,7 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
  * Returns the bit number of the N'th set bit.
  * If no such, returns >= @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
 {
 	if (n >= size)
@@ -249,7 +249,7 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
  * Returns the bit number of the N'th set bit.
  * If no such, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 				unsigned long size, unsigned long n)
 {
@@ -276,7 +276,7 @@ unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *
  * Returns the bit number of the N'th set bit.
  * If no such, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 				unsigned long size, unsigned long n)
 {
@@ -332,7 +332,7 @@ unsigned long find_nth_and_andnot_bit(const unsigned long *addr1,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_and_bit(const unsigned long *addr1,
 				 const unsigned long *addr2,
 				 unsigned long size)
@@ -357,7 +357,7 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
  * Returns the bit number for the first set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_and_and_bit(const unsigned long *addr1,
 				     const unsigned long *addr2,
 				     const unsigned long *addr3,
@@ -381,7 +381,7 @@ unsigned long find_first_and_and_bit(const unsigned long *addr1,
  * Returns the bit number of the first cleared bit.
  * If no bits are zero, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -402,7 +402,7 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
  *
  * Returns the bit number of the last set bit, or size.
  */
-static inline
+static __always_inline
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -425,7 +425,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
  * Returns the bit number for the next set bit, or first set bit up to @offset
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
 					const unsigned long *addr2,
 					unsigned long size, unsigned long offset)
@@ -448,7 +448,7 @@ unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
  * Returns the bit number for the next set bit, or first set bit up to @offset
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_bit_wrap(const unsigned long *addr,
 					unsigned long size, unsigned long offset)
 {
@@ -465,7 +465,7 @@ unsigned long find_next_bit_wrap(const unsigned long *addr,
  * Helper for for_each_set_bit_wrap(). Make sure you're doing right thing
  * before using it alone.
  */
-static inline
+static __always_inline
 unsigned long __for_each_wrap(const unsigned long *bitmap, unsigned long size,
 				 unsigned long start, unsigned long n)
 {
@@ -506,20 +506,20 @@ extern unsigned long find_next_clump8(unsigned long *clump,
 
 #if defined(__LITTLE_ENDIAN)
 
-static inline unsigned long find_next_zero_bit_le(const void *addr,
-		unsigned long size, unsigned long offset)
+static __always_inline
+unsigned long find_next_zero_bit_le(const void *addr, unsigned long size, unsigned long offset)
 {
 	return find_next_zero_bit(addr, size, offset);
 }
 
-static inline unsigned long find_next_bit_le(const void *addr,
-		unsigned long size, unsigned long offset)
+static __always_inline
+unsigned long find_next_bit_le(const void *addr, unsigned long size, unsigned long offset)
 {
 	return find_next_bit(addr, size, offset);
 }
 
-static inline unsigned long find_first_zero_bit_le(const void *addr,
-		unsigned long size)
+static __always_inline
+unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 {
 	return find_first_zero_bit(addr, size);
 }
@@ -527,7 +527,7 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
 #elif defined(__BIG_ENDIAN)
 
 #ifndef find_next_zero_bit_le
-static inline
+static __always_inline
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
@@ -546,7 +546,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 #endif
 
 #ifndef find_first_zero_bit_le
-static inline
+static __always_inline
 unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -560,7 +560,7 @@ unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 #endif
 
 #ifndef find_next_bit_le
-static inline
+static __always_inline
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
-- 
2.45.2.1089.g2a221341d9-goog



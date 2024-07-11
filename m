Return-Path: <linux-kernel+bounces-248454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470692DD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2621F238E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDC23CE;
	Thu, 11 Jul 2024 00:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ZK7DQ3Cr"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4D1C27
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720657346; cv=none; b=pCw9elkn7nl4tpx52O+4IJ8UIECfR6/CYS/CqGyrHCpO9t7RAjaliTLKDjFMp3s6lSESODCa2SaS9glij+pQOusCxBZICu2Fp0J4y+7J+gHNtZjm0OVY49twv6plYZ8yFIQTpjc9oIWSIaNPkWru0gjOvXm+jvOJ9HxADnfk6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720657346; c=relaxed/simple;
	bh=uM7smPu8AfGRj92cmn1JT/2eh3d2v25xWfIq0PU7kic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idSX30O2XK2TTKJ0kew48LKbnrOEKi9LPbzlEh9jz2wp5PZ8upmaJYlQ6+D9ciu23+PkNG39ZD+gB34UUvwrqnpD66SF9o/MYlVRmN3AFTILAq47Z2/XiULKdORYpKWzAAJalXgaSnkxOMys/w5KF2PU1rluV5KB1Z+x7nbcXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ZK7DQ3Cr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4267345e746so2113765e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720657343; x=1721262143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bywnTVppmfzQzszhkit49QhinE78akXE7sjmxioQWq4=;
        b=ZK7DQ3Cr2dG9Z75MnAUeZTt5RLBzqbxi9VtK0fna3RxHpnrN12DmgEdB0DFvHWNcv+
         lqwUy56JG/FrrpNPIEYKTxyU7CEtGykQdlHs0xpOrOTRza3JJ4nJVfu8+3Lu/hVRGLjA
         MgXbZpsJsIeuz2ilou174k6PaAHhzozAh1qcoYdmCG3vIt2hX9PCyxeogjVZxIQzp67q
         msXaHNMv9rIqE5uFYD6IIY34J4VwQcZqhIdj6J5L44CuIg3GQJ2gZjpNviEpj0Q+Meej
         4AyZ2Bq2FUDl+RMJElspDLp6xxcRAT/EQEgRqePOZlldKghReHMZPsQhDeMq4uv0DbjK
         QTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720657343; x=1721262143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bywnTVppmfzQzszhkit49QhinE78akXE7sjmxioQWq4=;
        b=lpyDlypnXMRmGHVhyuFQ3aPloIARlcjIsy60cHbqMP41JPi0yP6oQBokrRKD0Dd9Ty
         IZuZNBUQw0ZU6mFfgttwMNbz4TX3JBEi7KBzT4EoLHK1o15vxdpQUjHjWYK+XLM2qNJS
         01rDoo+41R3t1TI/QhaxUtM08rpSgm2bUN9PdyKuag7xyrV8n17iZH5lBPPQ1JMCyRF4
         9i8CQyegP6kni4ZBVXS/7oU8MBYAdK8L1ChhUKVstGA/fcvJFxOJzO5SSZ/Z9PFEPm/Z
         MA+O96x6PuamtUy1rRkq3KWPMeggtwA12UPCP7q5A6jDso/OpVm9kXJrbmbgc4nr59ct
         B5gA==
X-Gm-Message-State: AOJu0Yyu8qwjkmTTv/oCVoFzLWi18aIILZx6zcKbr7xML1p4HTCzHyOk
	gtE+f4Xnt55qMuCdKxxPE9SnzSBBydda+qevmGSTngsvM1CbPWI1piUAQbjVj8k=
X-Google-Smtp-Source: AGHT+IHqxrvLUW2J/54k8gQvzCID5HUCiDcf8dmMNnBG0HTWZkK2wt/V7dSoO2/ZLFTHC7bNTNgVAw==
X-Received: by 2002:a05:600c:11c8:b0:426:607c:1863 with SMTP id 5b1f17b1804b1-426707e365fmr43997305e9.21.1720657342591;
        Wed, 10 Jul 2024 17:22:22 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fca8bsm263977855e9.47.2024.07.10.17.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 17:22:22 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: akpm@linux-foundation.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bootconfig: Remove duplicate included header file linux/bootconfig.h
Date: Thu, 11 Jul 2024 02:21:53 +0200
Message-ID: <20240711002152.800028-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header file linux/bootconfig.h is included whether __KERNEL__ is
defined or not.

Include it only once before the #ifdef/#else/#endif preprocessor
directives and remove the following make includecheck warning:

  linux/bootconfig.h is included more than once

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 97f8911ea339..297871455db5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -4,8 +4,9 @@
  * Masami Hiramatsu <mhiramat@kernel.org>
  */
 
-#ifdef __KERNEL__
 #include <linux/bootconfig.h>
+
+#ifdef __KERNEL__
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
@@ -33,7 +34,6 @@ const char * __init xbc_get_embedded_bootconfig(size_t *size)
  * However, if you change this file, please make sure the tools/bootconfig
  * has no issue on building and running.
  */
-#include <linux/bootconfig.h>
 #endif
 
 /*
-- 
2.45.2



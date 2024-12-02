Return-Path: <linux-kernel+bounces-427953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6459F9E0884
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F91718FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39F4134AC;
	Mon,  2 Dec 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EWaRck6d"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C33FB3B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155348; cv=none; b=OlpaaD7gXoWQqF6RvhFhFWn1Vwlq4Hz0kT+Qzlx1LFRzTYTkyITntZMn3rUaQLm/xLl4CZc7/vpCkS6OH9p6OkIQEkC74gl4JI8iVyxodOGpFvEOCHCiaj3L9yTWbi9uVIijMqEUDpzySi7Nkyvba1Tw2Xa34UBQ1+yiuHFNFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155348; c=relaxed/simple;
	bh=fEMBj/cO5ZohaVdxPPTn3z/8EFB0HnPgOIUHdPDPIqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u54ZTchHQoUf/7huiNcTZKOeH9kpvrjlt+bG0dCCGyYl0GBxF1jwId0eRMJQ8uEDbwu0yY4MBIIqCA52FjSqonkjUDrc3OYP2cULDWII1suL68VI8Invq6+O1jA3Ui1R/W/oQo0PPzBr9DCMZqe/8mfem9ZVtDap/+wIT1ZKENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EWaRck6d; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29e2e768952so2083106fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733155344; x=1733760144; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwkq9B7tlCVoWp4VRCgQok6o7Mt1wW8UkSSb7Sc/dM0=;
        b=EWaRck6dE9PWOdP6QpE6RPDQqzvN29HHwiU/pMpzCOa8DymF68g4lEJ1ceuVrF0Rcr
         jlIEMzSfg76p7xyVL+UapjOZiUX1TdHbyQut2JGGZMWLE3qfnTqS4ML41nQlRd+eT5rb
         VpmTcTd63WNIdq7OaNDjjy6eTXV4HVulXpNyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733155344; x=1733760144;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rwkq9B7tlCVoWp4VRCgQok6o7Mt1wW8UkSSb7Sc/dM0=;
        b=vD1Tf33v40+bPYJZtjyorkmnfxb/HHwbCXJ/hDoHGdtl+TbeWA/WagrMC1HQfNAb37
         YFJounIaCv6bTLE9mYnRmQZRzJC3ep9WDl/uTjbqzoOUQq0uh7/k05QT+Px5wNess2nz
         mNYcRXvVqGm+PwT46LuGE+uVD+Xc56uTX9TXBdZOTvcXdG6BWv7JVBoBXrtB3WyoIiR1
         9DZrT95son6SY11HikdAoq/GeU4rxyqdQ9BpXu7gLPaNk4ZXkCERKMOp5TphhTERJ8xD
         miS1bNIpHJ7fWv8kvm9FQc/0mVwxSIPrF383Em9Q9RbvstCAtG1SCmz8eOxDeOuB2iOi
         WUXw==
X-Gm-Message-State: AOJu0YxPCq9AsMI/eb8Qizo8eRAxgWj3e1vXWdp07MaSxViuIvP6geC8
	mSS1V+JcxvwBOGCW5HkbQDa5b7jF2iF/0iOratTp5nRqLyo3oKl3H5I+ifnGDw==
X-Gm-Gg: ASbGnctDNiWQZRngm4gEcfK01d71gQ5LspQLMPEvcHBjO9eqsIRgUPq8I3Pl4IcETPz
	HEcW6q/rQ8kQgyl5wwWMN9jYVhnx+r0eJav15ed2akLM8Qlzbtmu76gDUFFB79Nmtj2LILrroSh
	doUTFx24Q24Uuanbds7YnlBbVntKdEesvNFn+9mRBYXCC+8X3DWcumrQcmQzDiu5xoIHQKAs2U3
	HQFiUOF0kAKmsU+haIh2YkQz764b5bwAiuC1XAGOnL7j7nOIgbV69fKWZfJiDA+yp5HpHQ2/Zpe
	8P7lIF+YfKTwUpmK1VhS/OIi
X-Google-Smtp-Source: AGHT+IFm9HDoaNmpX+KjTHl/oULOaZ2lR8+mNRWY1LpNbTFFxdF+4LSVSE8HYxT+AguPmFsJYFchyw==
X-Received: by 2002:a05:6359:7609:b0:1c6:1d01:9ffe with SMTP id e5c5f4694b2df-1cab15b6233mr895938155d.10.1733155343603;
        Mon, 02 Dec 2024 08:02:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af59164f4fsm1728306137.17.2024.12.02.08.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:02:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 16:02:19 +0000
Subject: [PATCH] mm: vmstat.h: Annotate operations between enums
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fix-vmstat-v1-1-c995585b7df5@chromium.org>
X-B4-Tracking: v=1; b=H4sIAAvaTWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIKGbllmhW5ZbXJJYomthYWlmkZScmGhpaqoE1FBQlAqUBRsWHVtbCwB
 fEgrXXAAAAA==
To: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Compiler is confused when we do arithmetic operations between two
different enum types.
In this case NR_VM_STAT_ITEMS and NR_LRU_BASE are not actual
enumerators, they are used to find the first and the count of the
enumerator.

Add a casting to int, to avoid the following llvm 9 warning:
./include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
  504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
      |                            ~~~~~~~~~~~~~~~~~~~~~ ^
  505 |                            item];
      |                            ~~~~
./include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
  511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
      |                            ~~~~~~~~~~~~~~~~~~~~~ ^
  512 |                            NR_VM_NUMA_EVENT_ITEMS +
      |                            ~~~~~~~~~~~~~~~~~~~~~~
./include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
  518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
      |                               ~~~~~~~~~~~ ^ ~~~
./include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
  524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
      |                            ~~~~~~~~~~~~~~~~~~~~~ ^
  525 |                            NR_VM_NUMA_EVENT_ITEMS +
      |                            ~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/vmstat.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index d2761bf8ff32..32c641d25bea 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -501,27 +501,26 @@ static inline const char *zone_stat_name(enum zone_stat_item item)
 #ifdef CONFIG_NUMA
 static inline const char *numa_stat_name(enum numa_stat_item item)
 {
-	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   item];
+	return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS + item];
 }
 #endif /* CONFIG_NUMA */
 
 static inline const char *node_stat_name(enum node_stat_item item)
 {
-	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
+	return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS +
 			   NR_VM_NUMA_EVENT_ITEMS +
 			   item];
 }
 
 static inline const char *lru_list_name(enum lru_list lru)
 {
-	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
+	return node_stat_name((int)NR_LRU_BASE + lru) + 3; // skip "nr_"
 }
 
 #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 static inline const char *vm_event_name(enum vm_event_item item)
 {
-	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
+	return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS +
 			   NR_VM_NUMA_EVENT_ITEMS +
 			   NR_VM_NODE_STAT_ITEMS +
 			   NR_VM_STAT_ITEMS +

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-fix-vmstat-88968bcaa955

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



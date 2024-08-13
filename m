Return-Path: <linux-kernel+bounces-285262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F5950B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D05B2241D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5B1A08D1;
	Tue, 13 Aug 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsGyk2GG"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC380170A18
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569955; cv=none; b=DyBbfgNQ5/X/CC+ZRDLGn0zHelTNi2fcUsBxwe3K3Tve8DN1z00kKsUPhyUb0R5iCeriyZ8w1LZwF8cr2ydFWlM9Nfugzdx7l012ZP+MGn3I0ChcwsAm/wMFIE6TWqNHUTb0BHCrOM+mXt1AcpAuafqeGdZkwSnJrltvea76xA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569955; c=relaxed/simple;
	bh=dJORAOHGUlnmVGD2a9fmQmnPdnSjKv/SmlgbwUlwyLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdL8lHOi8UU4TGJHoKRZk3S1FT1kRacxaLoFfHvWRiPbcVG+/vQWz4nDEOl/83qAjXpZzI0uv0kw4YYTsJ7Y0WUdBw8ODKIhj2/eDMCfyAXT/aKqmNCP088yoLOnPFAzX+5Y8NL8MhbTWF/yd89Lq0mZDY2VGgwlT3lsxsmB+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsGyk2GG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso62256841fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723569952; x=1724174752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bckSAEjpJ5PpYoR7hQwJ/XriJMBaeLy4LvLcHeVeksk=;
        b=TsGyk2GGTPkzcKu6u/Waabp3ri1GSFTOuTzAp3SLqDecx2/gEiHSoUyRnGZ4qB6KQy
         rvjtX+EJrXuPGcIMDAe8XXyP1wrZUdYz4rPj4UfsUGECq7Y2sNOSiIUdzvF/y4GhCWCX
         Ee25K4EjX6epQWiNyeGZTPHo07s3BR5FGPv8Q4Fzqg4tLLfrIzHGWR9x2sXM7Th9rO4I
         pCr8H+0XXycHScT5Mco+3aY60iHD3pjWvFLsHBHUfDBp9TWM0pNV8aNerpzwDLnuCsC7
         XquX2yfl7C6iOo7WB5aKjYa1B4FxmuReDOLhg6XqIXh/hb+GoemVQP7bE41zNGrTM8HP
         abWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569952; x=1724174752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bckSAEjpJ5PpYoR7hQwJ/XriJMBaeLy4LvLcHeVeksk=;
        b=rJvgNpiizFuBYqfE8n9rUXnMU7JPc/i6pXZoQ84lVuimYh+RKWjTBM8r0xItRoo/1q
         bOf3UqoEcuMjD5hmlNQ3ysWpvxz9B/0EqVM641M3dwSUNRGmfIA8rnzxhmUNgnuQJPMR
         qsJcJOtJJ5kAi4K70BnyoqsgF4sHuZ7Gn+HgreQ8ZLzja5fuOvQkkn1G6ABzrmAQta+r
         KTQqDC0LL81dTZcFPJXZvVdXgRF8iGxRMNWb/T4E3YLLMF2dhWQKYMphh+LiuXkBuxKA
         jBXzMqEddjiiB8iAbOW2epdrw0VfpFnznteK29KadO4ICeJxJElC5x0OGN9TrLRTe+Km
         0NOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0HMnVtid5FtU3M0Q9uYOEyTBmcFvXqrp68l9cbR0b2OQ22xnnZNzCh42SeJGJua6QFAZdSlLILr2RuLEY9OdSdC3rYa48Uy/bLonX
X-Gm-Message-State: AOJu0Yx1L2576/Zonx+4byJNickdrABBZ/s/e/ho+jhiumFS7h8/pieT
	aJYVrqLbJCSUdtfK0ODTxzmKmsaaGjOq1irPxJa+k4nggQJSJt0H
X-Google-Smtp-Source: AGHT+IEtrrEbrFUqyvWsVDYn/i0zD/QmSZriq6+kJDYHGaNkWu/OFzS6zY1GHBxy1gwb8T33T63Vgw==
X-Received: by 2002:a05:651c:b10:b0:2f1:a7f8:810c with SMTP id 38308e7fff4ca-2f3aa2fcd35mr577901fa.33.1723569951313;
        Tue, 13 Aug 2024 10:25:51 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f33cfsm3048343a12.5.2024.08.13.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:25:50 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] err.h: Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and IS_ERR_PCPU() functions
Date: Tue, 13 Aug 2024 19:25:10 +0200
Message-ID: <20240813172543.38411-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and IS_ERR_PCPU() functions that
operate on pointers in the percpu address space.

These functions remove the need for (__force void *) function
argument casts (to avoid sparse -Wcast-from-as warnings).

The patch will also avoid future build errors due to pointer address
space mismatch with enabled strict percpu address space checks.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/err.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index b5d9bb2a2349..997fd6fe1d0c 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 #include <asm/errno.h>
+#include <asm/percpu.h>
 
 /*
  * Kernel pointers have redundant information, so we can use a
@@ -41,6 +42,22 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
+/**
+ * ERR_PTR_PCPU - Create an error pointer in the percpu address space.
+ * @error: A negative error code.
+ *
+ * Encodes @error into a pointer value in the percpu address space.
+ * Users should consider the result opaque and not assume anything
+ * about how the error is encoded.
+ *
+ * Return: A pointer in the percpu address space with @error encoded
+ *	   within its value.
+ */
+static inline void __percpu * __must_check ERR_PTR_PCPU(long error)
+{
+	return (void __percpu *) error;
+}
+
 /**
  * PTR_ERR - Extract the error code from an error pointer.
  * @ptr: An error pointer.
@@ -51,6 +68,17 @@ static inline long __must_check PTR_ERR(__force const void *ptr)
 	return (long) ptr;
 }
 
+/**
+ * PTR_ERR_PCPU - Extract the error code from an error pointer in the
+ *		  percpu address space.
+ * @ptr: An error pointer in the percpu address space.
+ * Return: The error code within @ptr.
+ */
+static inline long __must_check PTR_ERR_PCPU(const void __percpu *ptr)
+{
+	return (__force long) ptr;
+}
+
 /**
  * IS_ERR - Detect an error pointer.
  * @ptr: The pointer to check.
@@ -61,6 +89,16 @@ static inline bool __must_check IS_ERR(__force const void *ptr)
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
+/**
+ * IS_ERR_PCPU - Detect an error pointer in the percpu address space.
+ * @ptr: The pointer in the percpu address space to check.
+ * Return: true if @ptr is an error pointer, false otherwise.
+ */
+static inline bool __must_check IS_ERR_PCPU(const void __percpu *ptr)
+{
+	return IS_ERR_VALUE((__force unsigned long)ptr);
+}
+
 /**
  * IS_ERR_OR_NULL - Detect an error pointer or a null pointer.
  * @ptr: The pointer to check.
-- 
2.42.0



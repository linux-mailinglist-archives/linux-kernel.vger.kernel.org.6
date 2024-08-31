Return-Path: <linux-kernel+bounces-309969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E6C96729B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BBD1C2135A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103746522;
	Sat, 31 Aug 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRBhpm+I"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB91EB5B
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725120576; cv=none; b=VzQcw0ToxDhSA18urlQJquXq4bermb6j82YNLSeneS2x7YSfIWcN/fCOINT/a/qVIvEdceoWNna+2hqnIlMftrzadP1uaTu3ujZ4dN3Su7PfhQ+nlcEAsJTLz79cqVk06FJrleyvFEYsai5mJd/VhB5Epu0NpPnlF8yHSd2ZsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725120576; c=relaxed/simple;
	bh=MIfzWCzlDWzowm5RJozGkGCRRfMuyGxPtxZJ8z4WCIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7fb0UGlD8/j1bUS4MLLT1C9DhoV8QL6O4UoMcGbeLcEfBuA8y1X6dsS3/O123jdNjF5muYvmc1wZkFD63MZ55EziTtsweGYsxgNNsKpf96bGkKJPukRbCamk4j3HS383pJjR/h6vMbLbG4PW6cCGhIPrsjQPG9gpv1fZItzvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRBhpm+I; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d889ba25f7so764161a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725120574; x=1725725374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlL7w0NtM/rJvQ/HuhfgzNbJdMaXdH0yf2/UCZXnlmE=;
        b=cRBhpm+IZAYv8QsV23Q64hEVchULbn/ghcC/zuMi3FxFVle/GEj7DHGHtGosdtMT0z
         PlwEe+1dlfoJ9d3aH6K+mk807qEXBq+Fu156bGaVZ7kgwCL2B13i40mEA9LRF//0Wcd/
         r7coSz6EdkGr1PuSmEUGCNw7p3j6iiMT8bUuFaXeVisSeV1MFlkEzSwcDoczWRuijTTa
         Q93B6dlUpVwQDBoZoZnmrUlHiS3CeXIMm35CYjBqAaoNB82aEOJFQdfXFdb7EkEhfyFO
         QXmkxaurxSuPszdd2mObM96oJQJaJl0AqGjp1tkMSs8OfInAs9Hdx9MQj2N2QlfiHyRJ
         00JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725120574; x=1725725374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlL7w0NtM/rJvQ/HuhfgzNbJdMaXdH0yf2/UCZXnlmE=;
        b=lpWUDc5xMfRPRaYQOxBSJblu0Auy6qBu3dkAInh1Vg6xHrfwxina5j392Dfm3W0k7t
         7jnD6DZKweoEx9Me2SASve18WY/TLnwf11EJchaxud1H9IkoswcOjhwQUbj9HCqSGFnJ
         7yR53ifht81lVa9jtCEgMLsdTeVZPzJ6tD7cDQ5pxo7cCmmvHDcyRSAO5S/jNQiT3Gq7
         JeqglK4lABBjRRtHJQERFJNIElrzxeT3Jp77GtN0OPqaa8J8g2B2Tt1VweStKks3J/sA
         ut28VhdiGA9g/uVIMBcf6bm8UXMl/bGvPrEaSQ4JHoBYgMJkKPmioTRh65GmvIgiWgAi
         xxSA==
X-Gm-Message-State: AOJu0YxmS8Ys7fmlyXv89HgdFIdzFV2EEmIDwPCSYUexiXsO74juSfpu
	7u1dDw4i7i7j9XYvaic4P5A2zIMLS/W3wumAJSEo0enYO9hCtVQrspi53v2G
X-Google-Smtp-Source: AGHT+IGSn/PKLfzVWa/o1n9313A4D6309v/GqggvVlNQn0aPRH6SHf4V909kOzWvwPtIghDKfIF8og==
X-Received: by 2002:a17:90b:4fc4:b0:2d3:d8ae:67e1 with SMTP id 98e67ed59e1d1-2d89739d3d7mr1920697a91.26.1725120574186;
        Sat, 31 Aug 2024 09:09:34 -0700 (PDT)
Received: from fedora.. ([106.219.166.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b3b5c30sm5912487a91.48.2024.08.31.09.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 09:09:33 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: rtl8192e: Constify struct pci_device_id
Date: Sat, 31 Aug 2024 21:38:31 +0530
Message-ID: <20240831160831.121720-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

static variable struct pci_device_id rtl8192_pci_id_tbl is not modified
in file rtl_core.c.

Constifying this structure moves some data to a read-only section, so
increase overall security.

Before
======
   text	   data	    bss	    dec	    hex	filename
  17838	    893	      1	  18732	   492c	drivers/staging/rtl8192e/rtl8192e/rtl_core.o

After
=====
  text	   data	    bss	    dec	    hex	filename
  18006	    725	      1	  18732	   492c	drivers/staging/rtl8192e/rtl8192e/rtl_core.o

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
Compile tested only
--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ad21263e725f..22a203d01b8a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -25,7 +25,7 @@
 int hwwep = 1;
 static char *ifname = "wlan%d";
 
-static struct pci_device_id rtl8192_pci_id_tbl[] = {
+static const struct pci_device_id rtl8192_pci_id_tbl[] = {
 	{PCI_DEVICE(0x10ec, 0x8192)},
 	{PCI_DEVICE(0x07aa, 0x0044)},
 	{PCI_DEVICE(0x07aa, 0x0047)},
-- 
2.46.0



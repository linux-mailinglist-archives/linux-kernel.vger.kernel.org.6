Return-Path: <linux-kernel+bounces-220766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD88B90E6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA30F1C21897
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFCC80BFF;
	Wed, 19 Jun 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OckpXEAV"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0C13D530
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788680; cv=none; b=Sr/3JP5qyLPrXWJkx+jj230Q2m6TqHvFYQSwxrvJ4kG/5a9o737TngjupXD3CpRvi0c22t45phTGExxeYgPX5shKN7MpWZokuAp3tjHFdvMG6/vGvv67CkgWsIMKHy5SouNiqHdFkEtXXmolPJvy7zyhl7OBimdq0cLaJC2efus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788680; c=relaxed/simple;
	bh=6UzgLIUe6O/xs/jPdvGJJ+faNEedd7qkf6B6VnZnaMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCs9oeaxDZKdj7nsa7sSebtOoTVdzVerG8gHhLNK+Gp2B8jf3kKDS8KFPtMx46HXvDokMklNhY+fOIPW+ZPnmNOxrPsaSW0+vCb2T9Cbk5/e4vyfDm7MdnVeCid/PVdBry7Wn04q03kRMBKBTZMrKJUmV8n3DOoLYibulk14dQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OckpXEAV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so7355147a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718788677; x=1719393477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPjk/SGA+ZcN/4o+MHQo/WGtXiJoQP9htaHUILinkME=;
        b=OckpXEAVUPNjQrBySN9Vc9ogZ/RzkOsKMNUn8vhy2rmv5L/bL1+2u99tbBSztH2VJU
         ZdaVS4FTKGQ/E2BN086KvERoGYcW4StekdCaw4um0hE5CXMyAYih4ck/mWNo6syjBvE+
         jku2egksZbiBEZoNuPXmuSiUwZbIfu1OUfWDlz9D0/LFlhKN9gX7hf2OYhtq3xVRugt2
         RLmlSL9W2u83OUnGYj8Ltjg2i2X7ZolqCqXdTI/xTtkU+CUhNX72cKpTkGUp0B4Y7o0P
         vqwue2qibV+F0rA+618+iEPrA4+sWApbgxLEa2HLHJzEEjcM2iYOqdrPTmYFiod5nKUW
         zhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788677; x=1719393477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPjk/SGA+ZcN/4o+MHQo/WGtXiJoQP9htaHUILinkME=;
        b=LNx6OgScAfrPo1QOmklw6Xabodf19QxMCYLSi2Ip0TtlD1wsMpH005fdNn7x6K3Ogm
         AINfj8cFnCRbaySlVJ5nBDk+MLpeVCFZWaU3a9yOO2/9oczyUirMY1Yr5XjXM86Y2qxh
         3L3Lug2k+Dg06AyrC2AeyAnz3g0HKXN7Iz+dYhGwmezBTcUJ/ATziyUdSSkKlTuvpo9z
         T/HNKakgr/TGOeeXTnhIam7E7SaEseASl/zLzieOgOjKSy69ue0mFIdulaRUnu3OCKrp
         ip0zXkPimIlrbcBBvbQEgJJDBZDWRJ9assuXPl3oyRUEz8ZcXPL/cayBke4ddV8hZvNj
         /9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUgnPUzBSyHN5zCZQwp6PkqYqlUlgVwLn5u+mQMPz841RKPYP5rYJvEMr5IhxrRvw/1I4e29GVJmmzT7EblXI1OgrP14PehLd5hgOdX
X-Gm-Message-State: AOJu0YzncDAxX2xBStljzkVSESdPHv1ESVKmepDVnIQbW9Ioi6b/8OD7
	Uy7ZegegXGCtiQgjgZKTYfu9p1o5wSMJFMHFY0lIhTW91HNmOAh8
X-Google-Smtp-Source: AGHT+IHQhFY66fdqc5NDEVC0x8QMNLjL1+OzzoH1l3jp37dPjCvEv5i0s+oqLbjEpDVFCk1Qa/qiWw==
X-Received: by 2002:a50:8d58:0:b0:57c:5fcf:b570 with SMTP id 4fb4d7f45d1cf-57d07ed4c40mr845595a12.32.1718788676813;
        Wed, 19 Jun 2024 02:17:56 -0700 (PDT)
Received: from avengers.. (217-133-54-93.static.clienti.tiscali.it. [217.133.54.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3632d8562a1sm1993532f8f.2.2024.06.19.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:17:56 -0700 (PDT)
From: Alberto Secondi <albertosecondi@gmail.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alberto.secondi@abinsula.com,
	Davide Salaris <davide.salaris@abinsula.com>
Subject: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
Date: Wed, 19 Jun 2024 11:17:37 +0200
Message-Id: <20240619091737.669040-1-albertosecondi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alberto Secondi <alberto.secondi@abinsula.com>

The kernel assumes that 64-bit systems have 64-bit DMA support through
CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, several
iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit support.
This results in several drivers requesting DMA_BIT_MASK(64), which causes
malfunctions, particularly when systems have more than 3GB of DRAM (verified
with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, a new
config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems with 32-bit
DMA, which adjusts DMA_BIT_MASK(n) accordingly.

Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
---
 include/linux/dma-mapping.h | 4 ++++
 kernel/dma/Kconfig          | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f693aafe221f..629220a777e3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -74,7 +74,11 @@
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
+#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
+#define DMA_BIT_MASK(n)	(((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL<<(n))-1))
+#else
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+#endif
 
 #ifdef CONFIG_DMA_API_DEBUG
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c06e56be0ca1..0a27eafed808 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
 config ARCH_DMA_ADDR_T_64BIT
 	def_bool 64BIT || PHYS_ADDR_T_64BIT
 
+config ARCH_64BIT_HAS_DMA32_ONLY
+        bool "64bit System has DMA32 only"
+        depends on ARCH_DMA_ADDR_T_64BIT
+        default n
+	help
+	  This enables forcing the maximum DMA_BIT_MASK to 32 bits for
+	  64-bit systems that have DMA support limited to 32 bits.
+
 config ARCH_HAS_DMA_SET_MASK
 	bool
 
-- 
2.34.1



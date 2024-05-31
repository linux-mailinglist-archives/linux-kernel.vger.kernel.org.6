Return-Path: <linux-kernel+bounces-197608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CC8D6D06
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1144C2861F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA5212FB34;
	Fri, 31 May 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="W/NKUwPr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0779DC7
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199533; cv=none; b=o2HNdo3Vn6AtTW7kEEhjq2hOqThRpx+sM5dAIGdG9SLSkZJ3+fT+IO2W1hEQ9xr2+N0E98gC5cZVz0cvwU4NHon4EHwZEG8GInkG1k5waHbP9cc4K4WiC5nPEzGUKfHGXMrV9p13F8d1Tqc9Tg+NHiQJJFmeU3TDnsTtk1BTeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199533; c=relaxed/simple;
	bh=ZmsfPMM9uOGyUAO76Ls6fr5SxZ5hReAihaGJqwMyKIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5jWsB4qc5NzrljOYV2xJKV+wHcTGSpSv/jyv7UY3m3RjjOz+JHYp+Tn7VBgknLtpymthqpY/6Vl9TAz1NM3sV+D29etsAB1Bxa+R/RlGc8jvNnSVZvERwYyM6jS4O5Ke6+yaJap6nG8gX5kVl4QO9FfRjI2rTtrxfHBsa+dVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=W/NKUwPr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso35216111fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717199529; x=1717804329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tfv/vnmuw2YufZGBKZOJtjIGxgQZexP+H8Zy3MNYB2Q=;
        b=W/NKUwPrj21LIGBdjBn4CeP9MbrpMRX39ByWVXTGLY5hHdoSHGexTclVwDeNYHlI0/
         BX1X+U3Ow5cMDF5oRX1D0iq10jGnYtSEtymZnPsqqYoA/EZz8bhYCqhoce075WIfQTD4
         v+zyvcI8qKCI8k8P9updtEb2oHCaD/Ay/iJqwtTbO22zEFO3/sj1PP2oS1BRgrUMbpkE
         fYlRFge2SrbAg5rPxX44dQ8m0YUSw1QkPor7ZQzE/bwoZckt0/czxTslFOKbI2KfIznI
         yuphxT4jKhMz8B2wKdVvqh2W/3pVH7knk2oXUmWsyXdMUAcVrShrd/hggenSo/78cPXJ
         2xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717199529; x=1717804329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tfv/vnmuw2YufZGBKZOJtjIGxgQZexP+H8Zy3MNYB2Q=;
        b=xQxDFoqM0eG0s1D9AsetyW1wgheVExKHgPtov2UD7qpJ0WgPOolr4n4gCaKCqhk8Bk
         Q/CR1OIuSzz5XmA76Se0mhMmXRwwkPHFSOeNFsmF77AyCF5Ws2qQBEI433NTa4wxNCnI
         FWV6xg4T0BW4AewLS8RNN/PfCXLld1Z85AF+ouo2oeQ0LB731HLxYluYN5hqc4XAhOMV
         Pf3iCUkn+8UNhcWjuTZIaXnPuORZ/Fr/oMglP1MPHgoaXIlHUN60FOGoa0XE3KWctcsY
         i3Y4qDVjUrvAyCnm+R6bkl2PV4G5454QHPjuHwenUtiwKrQbQh92AtCSx4WK+Qm25a0a
         ZdEA==
X-Forwarded-Encrypted: i=1; AJvYcCVKZhNiZiC0QvD77XWWNXJNFqG6W93OULF111Y/roRjt8UQrf4fYF2XFIjBZbln3mW1QN+E38vHDN1s2ZRYjrBqpJSwvyvDNJhfw7s0
X-Gm-Message-State: AOJu0YwspUxBjYhy8FPFyYu3Aj2jaOxQj4JE9eHU8SMUAytSWbg0K68A
	kRVGTojaQsHJUwp7N1NRru3S1fqYQnALdkN4p73UjGlrOtyOKfOZc6L9HtIvc9E=
X-Google-Smtp-Source: AGHT+IFuJQrPAsydUXf78vOkTA58ZN5pXm2unppiD/h4cuYDM2wW7UzBxxe+BskawQvwfKbbBCmuFw==
X-Received: by 2002:a2e:96d6:0:b0:2ea:906e:6ac7 with SMTP id 38308e7fff4ca-2ea9516109bmr27097691fa.22.1717199528652;
        Fri, 31 May 2024 16:52:08 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9ea4bsm1492064a12.97.2024.05.31.16.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:52:08 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] Bluetooth: btintel_pcie: Remove unnecessary memset(0) calls
Date: Sat,  1 Jun 2024 01:51:33 +0200
Message-ID: <20240531235132.664665-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove memset(0) after dma_alloc_coherent(), which already zeroes out
the memory, and fix the following two Coccinelle/coccicheck warnings
reported by zalloc-simple.cocci:

btintel_pcie.c:837:19-37: WARNING: dma_alloc_coherent used in

	/* Allocate full chunk of data buffer for DMA first and do indexing and
	 * initialization next, so it can be freed easily
	 */
	rxq->buf_v_addr   already zeroes out memory, so memset is not needed

btintel_pcie.c:792:19-37: WARNING: dma_alloc_coherent used in

	/* Allocate full chunk of data buffer for DMA first and do indexing and
	 * initialization next, so it can be freed easily
	 */
	txq->buf_v_addr   already zeroes out memory, so memset is not needed

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 5b6805d87fcf..237d4b27f5d8 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -797,7 +797,6 @@ static int btintel_pcie_setup_txq_bufs(struct btintel_pcie_data *data,
 		kfree(txq->bufs);
 		return -ENOMEM;
 	}
-	memset(txq->buf_v_addr, 0, txq->count * BTINTEL_PCIE_BUFFER_SIZE);
 
 	/* Setup the allocated DMA buffer to bufs. Each data_buf should
 	 * have virtual address and physical address
@@ -842,7 +841,6 @@ static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
 		kfree(rxq->bufs);
 		return -ENOMEM;
 	}
-	memset(rxq->buf_v_addr, 0, rxq->count * BTINTEL_PCIE_BUFFER_SIZE);
 
 	/* Setup the allocated DMA buffer to bufs. Each data_buf should
 	 * have virtual address and physical address
-- 
2.45.1



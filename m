Return-Path: <linux-kernel+bounces-249276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE27E92E92D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F451F24377
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13C15ECD2;
	Thu, 11 Jul 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="D2mA1RMZ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DED15B153
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704017; cv=none; b=tJcwwi1c3KpQxSvM4CaHtJdLloAgfER+5JXPElSoXX4haUnK8ISnowWlD6+PLouK24boElHEv0x2bUA4X9ErfT1r2qeE7QeZjytmlIf+Nuvd8/u3xP3jrdhlxzHPejKbhDjQF5o/Ms2HTBT33CZcwB7KapPF8ETzyJBEAjnghV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704017; c=relaxed/simple;
	bh=5SS6Gig9JOcYP1tR9qy0HzJLtPdDcsxtsaoCT8N8pvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPmM8HNwNfn2zFXILA9oHrw0DOOp+95nrKG3fezPCy4xH2kXK3/R4HnsatuHNdVR1b7BfLmw1s6Fba+tq4cFjowUzH7lfT1MIusFrcGg6r0849fyw04C0QJ4WhBz2kLprWZjfoOmLeS0XmziIhekcrBgX4R0MwzC7kZRACK2H0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=D2mA1RMZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42565670e20so11919655e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720704014; x=1721308814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym2mv6R1wISSehFAd6D4uPYCq8YgxL980mxPOz0BbwY=;
        b=D2mA1RMZE9YuEs/r7M/E8aHSmCzlLDGJ3SrL6cO9ZNGe4sGmyDThTfiml7kqDERQOv
         m83GSrOLw16TUU/l7ek2XKNloeNAHxJwGnbRsCYDD1DGyph9ezAfGG3Jrlr34r/HIE7F
         Y4sUgFHjMYwCVI7q97VQyP9e5khZL5UxpplSbFzl3Kn3wAtxssRu7dG29QJ+YAFYRF1Z
         MMgkjbsRT72iIsGqyUlYecX+kUztnXLkmqqYdGD0lbdsAOIwfjfthXInAxqALkZx57Bv
         hYeLa5P/2o4KezGfnEOC0t42UmbwDd6Xs2hZ2ReHEn5hX9QMgyuuBwPItrjQJgijEXfA
         jyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720704014; x=1721308814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ym2mv6R1wISSehFAd6D4uPYCq8YgxL980mxPOz0BbwY=;
        b=K3eII8CObypZgCtxB3BGxK7CYaC839WciRWJ4cTPIdFNeudeg/aIe4rafMtBIjYYcK
         WQFrGTWI93Oj6SqEsd5NrCDXhXWrjJCoIreNZAlzdlS1jqmNOSp5H7ugHorI66kQXm5p
         cPVmCk84xovTRRFpJzyjCi2xY8yBjVEEX3iH376XzAsfA9zXEoDkFME1JIL22lFTt5bw
         J/T7B4XxzEWoeakEeoMWCN7yG7vcYq79qLSbri6ZR9xxeLVt1Z1/crxn9Kv7XK07mVHW
         F/bYRtdXm4dZQcrj/byohsKrRBTWCqc9HtWdr37Ox5WMHH/gFoYDTK2JxTG4Tl+K4Buu
         QA5g==
X-Forwarded-Encrypted: i=1; AJvYcCUPz6NHiQTxhYDR5YF9kLFgekC2m5bh3dQl5vwvHw/hDa+wa27HNTlcVfdRjhOyPhaYwgfXTgVDtUUsb9RBmtIoTrMCXZxxaqFdn30W
X-Gm-Message-State: AOJu0Yx+poZemuCfO3N0RVy0dWIKUVbPebLwWqfQItplNBimDy1GckCd
	EyTICNXXrkFsbu71SVP7GJ5c1HSCh4iJIUmA86+8FJLLLSbyKyE++MYfYCe/TmI=
X-Google-Smtp-Source: AGHT+IHDlGShq8OX6brCIrvM/SSvzZHCPM5f95IdzjifVjJpmMGv26lmBMO1Glf+xHPW9s2m+p7h6A==
X-Received: by 2002:a7b:c4c7:0:b0:426:6fb1:6b64 with SMTP id 5b1f17b1804b1-427981b7727mr24132235e9.7.1720704014338;
        Thu, 11 Jul 2024 06:20:14 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279731a60dsm44652145e9.40.2024.07.11.06.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:20:13 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] dmaengine: dmatest: Explicitly cast divisor to u32
Date: Thu, 11 Jul 2024 15:20:01 +0200
Message-Id: <20240711132001.92157-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the comment explains, the while loop ensures that runtime fits into
32 bits. Since do_div() casts the divisor to u32 anyway, explicitly cast
runtime to u32 to remove the following Coccinelle/coccicheck warning
reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/dma/dmatest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 1f201a542b37..91b2fbc0b864 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -500,7 +500,7 @@ static unsigned long long dmatest_persec(s64 runtime, unsigned int val)
 
 	per_sec *= val;
 	per_sec = INT_TO_FIXPT(per_sec);
-	do_div(per_sec, runtime);
+	do_div(per_sec, (u32)runtime);
 
 	return per_sec;
 }
-- 
2.39.2



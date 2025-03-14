Return-Path: <linux-kernel+bounces-562272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CFA6211D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A51F8839B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137B1C6FE4;
	Fri, 14 Mar 2025 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3BLIzwk"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BAE1F92E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993284; cv=none; b=A4WiaHSKZw3LN90P/A2IbyPKMdo60FNoliBOZEvXpBjTWLtFpeNNUPtgwieHYKjlubb8ze7eP6MrbEw3uQ++oxiVm/KBV6sSQP0mGSj+Ue9t9Qb6WGwcXn6EBfhAX5C2n2aj5ma/BxUyQi8nPUHfyndPNl8tpX9rs+I/d22UkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993284; c=relaxed/simple;
	bh=Xq8Gl7p54Zigri2Bds+cKPnITS0YnyYVHvHKq98ZbDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOEnlER+91ZgK6hJ7nDCZ1mMFbWWg9AwvEf9g6NGEBDjJeA9iBS7kQsdZyzaMIUN8reGnsqRRGzOuEJYk8jLdyLCOyjwmGzGTp34zhgPu6UNn9fR+LNckWWKDIT8/fO/BOSCWkJTWPZDaV6i4YxmNRg24fwHNx2KcqnQgm22k4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3BLIzwk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso1656035e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741993281; x=1742598081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRtPg6oACw1hvTRmuv/RSNk9va89gmS+OSMNWv2jX3U=;
        b=S3BLIzwkUu6sbrXUFirkZXi5a11fqGUblQ06ebe0Kn9jo/DURHe6/UPAc0nOo+KEFk
         JEBima2DQx+yKoCVGS1YCeGrZtKLaMuqCMiKYlWePYWAdZz8ff5Q6ZmO5X3fSpXdDcqw
         61UkMpwbVaHxMvN5xD4KCVhrOVkV2Cqp7DTyyYtatC9A2mlYGGXYhN+Uwm2gkA3+bCrK
         /T0HDYkRFGb1smmRLTIl2BiWBPgYV3SwNVujufXrvyaSQkRWzXxN8L7tOYsfOQjF+SNf
         3x7t3kNG8hM0Up1mL3x+MaLMf6kRc3l80Mro4nlTxc6wvtfwiSuPBJ8fahA0Li6vApwv
         XLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741993281; x=1742598081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRtPg6oACw1hvTRmuv/RSNk9va89gmS+OSMNWv2jX3U=;
        b=K+l52v7Jm8xCbGvR3blsdqKGgPmLczQukMbHStYmwA+NWTnlC/Ck5VYeqrNFndrcLi
         16Vf0gnKy4U5h2aP2yvThiNAL/2XXF3IsCsRTDwH3zX+DXj5QENU34Sz30y1Jw64dqqV
         cAXOog+4aZPkFiRrfZCAQg6YiMbFF2K3PVvz6NaGCQ49h5mhC2fqx3TQYiW4TOYCcwnP
         Ry4ioP/QlXdju9+NbG6zdhuvzVtQnrrArbVTPKbMvdlLQLo9g5hKUDhPHQAGEA358eOo
         ncmGHbNp7XAZyKJ2nPauKyZcHv9Of4anWAUGHKE6wjHO8o2jJyIKxwYHQEQP/K7n5NsW
         dLDA==
X-Forwarded-Encrypted: i=1; AJvYcCWrQX5ehWw34vnYSJDZDwwDAoVDtbwePeGqdMQ1Obh4kE6JrSLHLpxsdl1O0XFDM89LOLsvHJWCWqR/2u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRIswz9soOBhfqLDrNvTFYkKa4maNpMnA9Gzr8hfBU/iFUeQc
	fLQR2Qwn8baAW5lrp5grxwwpAnDpQ2j3QgFxoV9Y4GBG2dB7Hbwj
X-Gm-Gg: ASbGncsteHqS/fZxEuVB130WcKXOt0EKkqkHCRSK+dCkggEEnMBJfZ7zwgL3Oyxkw2i
	WtcK/vqnibaB0yeru5TDsv4NdodB/KO6XuH/UAj/bqS7+D25gXl7NAl8n9wq/8Nc6fd07L3F6dO
	PWyq3grkeNZENMjl1k4+LM5sy11oeFIEqHn0PM/aqB9nJH/YH657q5iNQ2V+eAZM3euaO1bBszl
	0GUlvD4wfKjytPH9xnuOQRpLBLbzbSrb774517YRaHcGO+a3KgtZiR9DkGVfoQ8hF4XV2lDCUHR
	tS5LVj8zOGEqFhiPeHPMGw+ZnWx6zIc+AKFSaznJY7Ts
X-Google-Smtp-Source: AGHT+IE0pax4j7XCryEzABptGEHj97UrueRJkeMrjB7rZqxeTR5+yJpR9Dcqmq7/m6LJKVapTevhJg==
X-Received: by 2002:a05:600c:198c:b0:43d:10c:2f60 with SMTP id 5b1f17b1804b1-43d1ed00016mr53261805e9.24.1741993280384;
        Fri, 14 Mar 2025 16:01:20 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:15a:24b1:8146:1068])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe2927fsm30441345e9.18.2025.03.14.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 16:01:19 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: marcan@marcan.st,
	fnkl.kernel@gmail.com,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: apple-dart: fix potential null pointer deref
Date: Fri, 14 Mar 2025 23:01:02 +0000
Message-Id: <20250314230102.11008-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kzalloc() fails, accessing cfg->supports_bypass causes a null pointer dereference. 

Fix by checking for NULL immediately after allocation and returning -ENOMEM.

Fixes: 3bc0102835f6 ("iommu: apple-dart: Allow mismatched bypass support")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/iommu/apple-dart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 13ccb801f52a..e13501541fdd 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -797,12 +797,11 @@ static int apple_dart_of_xlate(struct device *dev,
 
 	if (!cfg) {
 		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-
+		if (!cfg)
+			return -ENOMEM;
 		/* Will be ANDed with DART capabilities */
 		cfg->supports_bypass = true;
 	}
-	if (!cfg)
-		return -ENOMEM;
 	dev_iommu_priv_set(dev, cfg);
 
 	cfg_dart = cfg->stream_maps[0].dart;
-- 
2.39.5



Return-Path: <linux-kernel+bounces-347160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464BE98CEC7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C1E282434
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C2195385;
	Wed,  2 Oct 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkITLLRq"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244101420D0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857915; cv=none; b=uLHLbdrn3lwula4G0P6jcd/NIY+0EtSEKq/X+8FwPCITmCAdO7WeD9OnNWsAQpS38Rx+f8eGx+FhymemeEBZHt/d06Lj/gn27hepVno7GcZ5XRG1hOp9n4LuMsmiv9UyQ1fqCfZMYZMdchmHDodPMtmAq2sAlj3iubawup9v60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857915; c=relaxed/simple;
	bh=dz3TnnmaHxX4rTHrBk2jsLW01eIFWKsYTonE725bpLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVBRF9zKej6dgPGZA2CUz7FqM1BkejcUnnUUQi78NrQEYraV5NrVmANHtp3i5hlaY0K3FMiT/Ml5TTChzSUIyUnPDcsXia1ATvSTYE1Fk+ZcjSgHDH+xeevBzCaYx4128yY/CifgYyRyvjfOdh3SlGOsA4rKtISkJP2OJ6OC6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkITLLRq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53959a88668so6028041e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727857911; x=1728462711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3i6810UFJIFlcsBbgqFL1M8gMfdIH9tr27N9SErNn3U=;
        b=mkITLLRqfJijQYxJQIWEtPNiV2v8Dg2XHUGEV1x5PFvj7onitYQqcHET91zsGqEx54
         PY9FRg+mebPx2mU8H0G9C+Q42U+NSvaw06EDPO1hvfAJ5D58zMa6aCVyrEBMiL5bxdYh
         oHtGgY0GWNo/NssdA8xdV/JbiA/pJ4gurk3pJ5FDXKPdGy5BStXengA75dlG2XaWevwM
         2U67v7MAgEyIhdixQKcsT46kRvdJ3T4IChkW1hsCJflXeqhXonhIyNIESfKq0xIQn6bY
         BYfDu3IEPOlpJgrerKRkgRjJ6Cau/j6Uu6SVrEUT7XETEfAXfbWoKLr14PQQ5ZFLV+kf
         DY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727857911; x=1728462711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3i6810UFJIFlcsBbgqFL1M8gMfdIH9tr27N9SErNn3U=;
        b=SiXAsSObI+u/82BoUhcnrEEA27Yiv4nabP0ZEGv0JsbUJv+t6HcSyxwWupYqxFryjr
         oGNZNubJtdDqLdjW1s+gVMvqX4oYv61mj7S1bpdpJZUmsg0K7XD+DEfW3l0SAoknMllB
         G9648pru/AFzltxARA8IEEig4NpVmfrHA/E9YEzKUewITVtsBAd7X7DkRerrhTqRWv+X
         b4eqNETJrfn9WrZMw2xyLwZgOHQVtaWfIWoKVCVeGCtNU3WrvUmL95/ziBV8aBh3Kl5C
         sxmkDfQG6N3O5V2H+hV81pQwwsjjdtO98UhvGH8tgwkzdMRSvnSpYAFxX57UFN5Zt/bE
         QSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa3WXYUY15rqshpoZkJVYTb1rwSWuDUWxdIR8v1/vMSPP6eTMq1yZKWqyVTv/aKUVAAhx9ef5Hn9fjMQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54tt8pTsDwI7aWqs0MJ2XdLapDU59xG2AGKjrF2+5j2RcVPeV
	Sw7AxViCYMFWtEbUUixxWk9JSTdoQ9jLyWx9jepeR/XYcRDNWSs0
X-Google-Smtp-Source: AGHT+IGo1JGO44BEKQ2Q+d1hBGSQ3FoIslb7AYw7iBhDsII9i7GgOdct7cze006dHJSfBSyzDTRPpw==
X-Received: by 2002:a05:6512:31ce:b0:539:8f3c:457c with SMTP id 2adb3069b0e04-539a07a9ed3mr1280515e87.53.1727857910987;
        Wed, 02 Oct 2024 01:31:50 -0700 (PDT)
Received: from localhost.localdomain ([37.161.243.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245ea1dsm7257716a12.53.2024.10.02.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:31:50 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] iommu/dma: Potential uninitialized variable in iommu_dma_unmap_sg
Date: Wed,  2 Oct 2024 10:31:28 +0200
Message-ID: <20241002083131.18135-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fix the possibility to have the variable 'start'
not initialized.

Smatch tool raises the error:
drivers/iommu/dma-iommu.c:1510
iommu_dma_unmap_sg() error: uninitialized symbol 'start'.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..5b2596f4b24f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1496,7 +1496,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t end = 0, start;
+	dma_addr_t end = 0, start = 0;
 	struct scatterlist *tmp;
 	int i;
 
-- 
2.43.0



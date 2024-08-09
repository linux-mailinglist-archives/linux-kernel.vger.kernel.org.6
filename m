Return-Path: <linux-kernel+bounces-280579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078F94CC61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1710D1F23E31
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A018E05C;
	Fri,  9 Aug 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gem0dXXL"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0118E77E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192566; cv=none; b=g91fKrFu3Yf6ty4xdeUQwAYwf3/k2L1Ufa9L4wu5egY47TPN5S5HaGxLpxAmhHXiTHIvMOjlvQWRuF+DYLCMVFhAhM7tCerrbxsXj5DQYZSGkCrKPM5lYDOItkN+M8rGFrG4HXA8cxlLHhe/u5BKdoDcpmta6mzjAMQ5/trKzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192566; c=relaxed/simple;
	bh=GKQQtsFL2PgY3xuVgpyzjfrC0VvamH3LJrB71twQ2Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QM+ZbAx0tr546QPmsYBiwRWJxDLDSt8QPHlTVTaGPTysN5/p4uf1IuWft0nKxVTAwQgl5Sq5uR5nH/9qntOOStbsArccOF6Pq9XOoKQkTtlp1QwS8oqKPUsZKrwlcC+9rHZObhIBkyFAkQb2xOQ0EFpWU39/5D1QstNALcFQtZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gem0dXXL; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db1956643bso1306161b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723192563; x=1723797363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80oxDpYXT5yDEJcp87RTrO4EEEJMglSs2GHmb0pGD5M=;
        b=gem0dXXLHTOAShyIkK8aCuG0v1NvFkjdzqw88FSXwLVjnrEo0nXRFA+PnZiU9HcEo1
         skXcdPf7mEagnkZmm7pkka6sMqXnnnKSOIww8FwxpMyoWE4kK46+335rluRwSx5x7vgk
         frVk95d4fV9X0s4LzyMmr1XOSeUdTQQLsqWCWkQEOU6hgeABLJqbqrdYCVksS8YqfJrW
         0UXNfcbsHfhy4mt0PF8PrJiOBxqyvdMFTDC4gsf3GsdB7RuPd7Oz2yV7gp5otoykvWU6
         Mrm2P5VztOlhD94elgoKtE8Q1ignH3nTF7peATAa9BzQL2Pv8gNtXAr5LeNvwniRT1yq
         jMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192563; x=1723797363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80oxDpYXT5yDEJcp87RTrO4EEEJMglSs2GHmb0pGD5M=;
        b=I5MBuLcAg2x11gCHIgugB8/W5la1mh55u/UMZXq2GkOkJZQXp71XmvDtHdvT1pnVV+
         7xGm2s5JrLujVNxsHpYuGOkVEPfQY54pLBc3YCB5u4Wq8Wchis3SuFL1SWQQkh6o+THc
         AoAHge/VEFxRDqXHf4oDzCkumMknctMHrhU93Q/ovzC8zRwuefHoQXTqvoyBofpbfre4
         OgeyCeUy602y3zQgvs5aIc0GD60jS4fIunq1l9JrKr9E2/jV4Ie6GIofQtirNmW6IMgz
         PsYD5Ktw1SL1cVBEYIYDQWYCTE3l6F3yPuIAq4Mg6Jw2ej6XYnEGtYzUudQpLyx+SUyC
         INGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGhtYHUaHUR8ZgN5LKNTYmHQe3LmYy3H7tnTKa2ohdNAgMBkxNHqQOkbQtclDOHQC1+MFUFelu7bOaW/aZqNfoc+fvl5TppbdWfxXS
X-Gm-Message-State: AOJu0YyYy/maqu1k+hRPigSAU4x3AVH9sLUdloxJRO0nfZZ+IzJEaBD1
	Q7mcsOYDRzzivGb3JNVTvuXm+f1k8YoedPf15uLXRO5xUXjXnNSESsxJK3Gyhg==
X-Google-Smtp-Source: AGHT+IGAjkW+uKRVgS0A2qZjCMrQlVacvJIMwL58pCLnbX91NVR6ty16gaYboymknPlamERU+ctmYQ==
X-Received: by 2002:a05:6808:4497:b0:3d9:28d0:fcd4 with SMTP id 5614622812f47-3dc4166b455mr748264b6e.5.1723192563482;
        Fri, 09 Aug 2024 01:36:03 -0700 (PDT)
Received: from localhost.localdomain ([117.213.100.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb22971fsm2207254b3a.51.2024.08.09.01.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:36:03 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] virtio: Remove redundant 'virtio:' prefix in error messages
Date: Fri,  9 Aug 2024 14:05:47 +0530
Message-Id: <20240809083549.14772-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_err() already prefixes the virtio device name which is enough for users
to know that the error is coming from the virtio driver. Adding one more
'virtio:' prefix is redundant. It results in error logs as below:

virtio_net virtio0: virtio: device uses modern interface but does not have
VIRTIO_F_VERSION_1

So remove the 'virtio:' prefix which is redundant.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/virtio/virtio.c            | 3 +--
 drivers/virtio/virtio_pci_modern.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b968b2aa5f4d..0e06aae8071b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -194,8 +194,7 @@ static int virtio_features_ok(struct virtio_device *dev)
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
 	status = dev->config->get_status(dev);
 	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
-		dev_err(&dev->dev, "virtio: device refuses features: %x\n",
-			status);
+		dev_err(&dev->dev, "device refuses features: %x\n", status);
 		return -ENODEV;
 	}
 	return 0;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f62b530aa3b5..e34ed4870af4 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -237,7 +237,7 @@ static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fb
 		return 0;
 
 	dev_err(&vdev->dev,
-		"virtio: common cfg size(%zu) does not match the feature %s\n",
+		"common cfg size(%zu) does not match the feature %s\n",
 		vp_dev->mdev.common_len, fname);
 
 	return -EINVAL;
@@ -274,7 +274,7 @@ static int vp_finalize_features(struct virtio_device *vdev)
 	vp_transport_features(vdev, features);
 
 	if (!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
-		dev_err(&vdev->dev, "virtio: device uses modern interface "
+		dev_err(&vdev->dev, "device uses modern interface "
 			"but does not have VIRTIO_F_VERSION_1\n");
 		return -EINVAL;
 	}
-- 
2.25.1



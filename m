Return-Path: <linux-kernel+bounces-280580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067B94CC63
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FB61C22BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E019148D;
	Fri,  9 Aug 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNiB1tl9"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E1190470
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192569; cv=none; b=h5ojOPJSI9U2UVBc0o0LPxZrLEs3AR05l4FeBXAzdfn+yaPkwsEaxAEZ7KMNki6bygy5jGJpuAQgrrQiMnGV8vTHxhEtxax7zijRhQCMLKn9M+WOGKrR28Wl0yGMyknNnRgUtfnueDBJWeieQ70Er8C6kgNifAipJaC6vd715ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192569; c=relaxed/simple;
	bh=fxzAAnyjhajstMY7ILsQe6gw/ivTul+Ck8i7HDnuODs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onNDJLJGLLVLPntWbCo+JOZbhnhfD8+5ngIN9/9EI1Sz+9syaB1pX325pylgZf0ckOtv2eSx/uWHEMPPhQvcb2E8grqnRgDrg3MvoK/eLNNhmvXtzC5i20b2cFLFXS5YQL1/P09Yf/+q2JN+flLwYBhCFqigUq0QwARPkSivSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNiB1tl9; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db23a60850so1245763b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723192566; x=1723797366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX0owJGjTUZGW1ZSw8u/h2+6HycvjGlnJbGmlknVqK8=;
        b=MNiB1tl9FO7ZjzZSkeNjUE4l8OF3gMmfz2XbGdKzQ4skNo0BLqtc7IMOOBm5LuBHXL
         4YE1f9Jzsv51wSi4oIZi4ufnwnr7PWvN42uYxYyD1tEt7/C7Cu07UDI4K4mFMwkZ01iT
         48gy8KY6by2PTskBmGXlaKIhKzksUU0u0YbJsthIsXxtJebxR3fhUI8bCnSXF9S/EYOH
         ufDWy50D9cBU5kBnR+TfQJzGObowDrMkZ+hAbMp2u1fNBiazJoncRYzSX6U9bsPs/qMV
         +8eRebqWs0wW+WFcvwicd4vbt5pXsq3KZ5imwGXAkAST20gpMOBTqr8Spel3q3AoCtJO
         Ge2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192566; x=1723797366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YX0owJGjTUZGW1ZSw8u/h2+6HycvjGlnJbGmlknVqK8=;
        b=nhgx6Vzr6JFFHnxG8Y8hrM4kFQFxSiH+c3jq/3bTNabjlOCfRbp+h4wlrrCRJbr6Yn
         wOINvqv6zOYQY2Wo86DL6X2bOwG5QPhPqM09F/AD7wcZTWvtaUScjqZCChCpojclrMbP
         H2toMcoeIrNt3JS+P18iRpauJJyRKxuA7V6adZk3GBjc2LpY2/zyjluVruO6eAczUtTU
         EkNc5A/Y5kTM0F/jF7EbgWr2h/DUlbw0eHtYQTpHMHM1BTLlsdEn8dwZwFWEmCubTCiR
         uXDcac19OGyKB2lUx3VSPqNtWl5eYTSePPEgiqs7tHWgAcMCatoSmFlkAix61kWAEAXR
         B2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUymahySysZID7Tgl27zZdBNBjvnN10PL9FEzyfZtTGHQJy/OKbK+M+Vlp+8snvArg6yx6iSSPeMfKY7Zl2qY3xUf/KsWHFVb48Z4oF
X-Gm-Message-State: AOJu0Yyg0hcNnGR0X/hhJX1BC6NCs/kYBxFnrKhpsmRBMd7m9z0uJ0BW
	KhJfEY3vrQG1K6z0/si7H/O5CH/SooLQs4GwTBT1YLBApA6xQAK0qny+6DHpFA==
X-Google-Smtp-Source: AGHT+IFQVkg6ZtSfIaU+uod33S25nOMqpwS+RsKZODiyjnqKnTlSOE1Vz+YL/yyYCs3UpYV31uiAqQ==
X-Received: by 2002:a05:6808:38c5:b0:3d9:3a00:cc8f with SMTP id 5614622812f47-3dc41676675mr728490b6e.7.1723192566111;
        Fri, 09 Aug 2024 01:36:06 -0700 (PDT)
Received: from localhost.localdomain ([117.213.100.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb22971fsm2207254b3a.51.2024.08.09.01.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:36:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] virtio-pci: Do not break the error message for VIRTIO_F_VERSION_1
Date: Fri,  9 Aug 2024 14:05:48 +0530
Message-Id: <20240809083549.14772-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809083549.14772-1-manivannan.sadhasivam@linaro.org>
References: <20240809083549.14772-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Breaking the error message will make it harder to grep for it in the
driver. So let's put the error message in a single line.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/virtio/virtio_pci_modern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e34ed4870af4..1bb55a3167a5 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -274,8 +274,8 @@ static int vp_finalize_features(struct virtio_device *vdev)
 	vp_transport_features(vdev, features);
 
 	if (!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
-		dev_err(&vdev->dev, "device uses modern interface "
-			"but does not have VIRTIO_F_VERSION_1\n");
+		dev_err(&vdev->dev,
+			"device uses modern interface but does not have VIRTIO_F_VERSION_1\n");
 		return -EINVAL;
 	}
 
-- 
2.25.1



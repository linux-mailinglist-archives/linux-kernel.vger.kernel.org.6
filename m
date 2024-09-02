Return-Path: <linux-kernel+bounces-311510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5199689F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AB62837EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C003121C17B;
	Mon,  2 Sep 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdN2w5zx"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B82139CF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287410; cv=none; b=ptCphaqAWRgWK4CzK9MAxKQIBSUrPAa2qL0SWNsxfMOSxe8e1cLKmPmfZP4TfgevhzkGxT0hCIk31bxGFh/RWoeXUrk9eS7qSpBuAIpiuUDoeh9/VeRWqwRZiiMkqvljI620n0WEOsFYGvKa8D1HlhwdMsOIJdrELTJ2ksnhUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287410; c=relaxed/simple;
	bh=DrbltgSq/rTLLH5kyWpJoPU/fmW8V9hVLeqYU0dOEo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgiCz3ILVx4zkyesA+IsWVA6Z2+Du2VywfqsMiDYw0k8mhrBN6h5Lgh/d94dQ9QtI0SXdgqGlsnR3EdIMdFgNXdIcMz4W+qe/nxZDMrG69sgqWFzu1SX3OFpF6f5DLn1hihrKN86UzpglaHh7w/KVuYZRbnX/s1Kma1ptT/xRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zdN2w5zx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83597ce5beso691364966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287407; x=1725892207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRIDB5vApTt95UCZmlOxg+E68fkDjw1Y/7g1DeaN39Y=;
        b=zdN2w5zxnTGMB1pJluqPSomE1WG6Ldx2AxrXA18Ga+hYqvfzlEFwWQvGPQDZLnSOpj
         /YA7X2RX25e/HTx5xQBeOKp2+BNhF1JIsxulCNdMh6ZL6AyTdWcpZ8HD1KrJX1xuMdrZ
         kEEraOhME+KQP8vYerO7SToXRwLxiYBxaPOay1+bvxeIvqvUR8ZnvPW90p8WKqTJff7W
         OflUWdlIqDOTjK8hW40HOh2HAL7oVxbeGP6laruB3LIFYeHMai7EqUv+npiys1JbrgKO
         9i65oF6p4mtA8TacnDu1uRFbJuLvkA4NZbE7tW27lgEKSr5KhFKg8ZgMDRqnXrGOxGSp
         XS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287407; x=1725892207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRIDB5vApTt95UCZmlOxg+E68fkDjw1Y/7g1DeaN39Y=;
        b=pJmuPbpYxn3F60CP9+Enpe1iEUp9nAZqoOqbO88WuizzsWYdP76BF+PVwOPRAOKrIQ
         //fK1FNzXYI/9aSQt9n7b85C4LbWX8/mX7wHYRqc+qw/hcHM0mOoNxP6GRbj8wlIeqoS
         ZSckivfoGZhBtsCiK1gigtXNYzNhrtkEpey1wuyCkpGRZ8EBoqhicAXWS4YutSZbujST
         TRvyqaiTtDgKavgKv+6n4Rk9YuQWajI6HVK4cKxIXj3SjH2JzG+3J2K283EI3IwGoi0n
         tzK7xZlF2eWNz1WS5NGZksXx/AMPjrjg23lb+ZntY3xFbkF3rKZc2IPmndgFDhyH3zvg
         ZLCg==
X-Gm-Message-State: AOJu0YyG03H8HWTHK5gbW8+flA+AHwqe9xZZB21VYDKDiFZEATy8qaoP
	9Lq/O4SHcY6S4NAJMtjHptAYOggQsAfTNnxeiCUKMqZTZ33yAob8zlZKB1o5tB8b+OBcQEW+nXp
	X
X-Google-Smtp-Source: AGHT+IGK5tu2NdNCddZ2ZpAvt/t+RuJFf8MekXeRmKmCbJnSLni+rTHwH9kY5hZbSebkBnSvdTPYRw==
X-Received: by 2002:a17:907:e209:b0:a7d:2772:6d5f with SMTP id a640c23a62f3a-a89a2924aa8mr1000777366b.23.1725287406967;
        Mon, 02 Sep 2024 07:30:06 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:06 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/9] MAINTAINERS: Update path for U-Boot environment variables YAML
Date: Mon,  2 Sep 2024 15:29:48 +0100
Message-Id: <20240902142952.71639-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This file was moved to the layouts/ subdirectory.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25fe91a49314..fb25e47adda4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23341,7 +23341,7 @@ F:	drivers/media/pci/tw686x/
 U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
-F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
 F:	drivers/nvmem/layouts/u-boot-env.c
 F:	drivers/nvmem/u-boot-env.c
 
-- 
2.25.1



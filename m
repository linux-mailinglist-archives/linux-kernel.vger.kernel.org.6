Return-Path: <linux-kernel+bounces-203204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636C8FD7D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B45F1C21B72
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449715FA67;
	Wed,  5 Jun 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flWc1qKl"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823D157A41;
	Wed,  5 Jun 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620737; cv=none; b=fPDuo7YD64JZVI/VRObDNSX/Lo59hRpE0u383QqRkqG/ardcJG1H5vNEfAAjKKNre8qDP8XqvGPwfYpfbI4Hf+KEqasWTxOo0QgKV9EuE3uveVLrl/wkW3v3OWFs5pMs4wjLnTuCRt0mMzd8OlcNFco6WB9Ho9e8ENki0s3Ii78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620737; c=relaxed/simple;
	bh=by1GsYCIe+rl1n6QK7VRgyg7zYyTWVt/pjwSdMKSz+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfTSrNbobapK3PDfKz/7f/O+ImTMEb3Sj7g72eMIgDJpcuaGYK4f85qrKFVUjmOhUEb4exrWXkxehnU5v05u64c9Q9ZVdXv6slfA5c+DcaLJLFtAcuilRCKE1n5caaVvTPEXwW8Hksh4K7XYosnvNl+zIACwFh8bIefhe+aGwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flWc1qKl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso250560f8f.0;
        Wed, 05 Jun 2024 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620734; x=1718225534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv2MjK1b3RmQFqpYtvaVw+b1geYBojSDIiV6z6FsDD4=;
        b=flWc1qKlgShTxP7l3NrZ0mLTr7Kj2EbqgpfCVOrVHSSa2rxIq7n5zW9tEdLkVShPLR
         e+sfVugIPUd+7j2g1tqyCpJslG4wt94cst9MWo7wn3BKLGh5Ge/Wasf2ZzlZnu2skyMy
         SuG3HbsjrLqCpfnP+jXNai3HsN+lhEPwtccCSPRLAMAy7neEXQNh9Wqy6JJ8BMdKFHrr
         WZhsy1IsFSGerJN7yfT2T+G56dwv724bl7LldZy3eElYK+9snSrR5Kck28VV6iHTLlyg
         lj5cctLDuTIrbE/5YbVX+HdQ1TfXGTRF00nfyhaVefNK/I5RsxcHvugWaUjRopoX7664
         UsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620734; x=1718225534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bv2MjK1b3RmQFqpYtvaVw+b1geYBojSDIiV6z6FsDD4=;
        b=YjRl7ZF93S+IHRc5xTcmBj+HnMo46j36drBF016Rj9dprqCr54nWHVUYftf5+MQXt6
         LlEzLXYOTOfeGjCqhyHZl9YpSjY2Rao7mL79hw/G5sNYy8J64S4kFKYgcQIrvzsnQH27
         L22/+mIexJelXDMauewtTK+jgWquSjL25xcJu6b/sOqq9mL7RoOCk5AT7vTSaL2MNiVv
         3hJlORUbhg9QLrsCUvofRMHevjBPrnSZ/WyJ9lEi0vQ5F8qxxxEz6ZsRiLq/bEWw3AVq
         y9EH5giwTzfDhowp+9RaTTaAE1+vJMZIJE8G95eSKe/YnmPN5NVv53ul5AJprkXvG9D8
         LSmg==
X-Forwarded-Encrypted: i=1; AJvYcCV7hZS3jsC45nXgT9pUc89QmWn7VH6juDl8WDnr0p6BnNlYDMzoVaxV4Bsb5UdmfPtZTmNdYy3GbxSWor70BdJJkLrNVRIsEWCNAabfhFiC+RDf38HlHttzYmGTbAKYpxk6gNpdLM1XnR76TeiNgfzLNDzkfWkytDLuWUBheFmN2gZVDw==
X-Gm-Message-State: AOJu0YwOrTQliRscRAZbLrBOfxco2P1En8bTLSbgh6QSyk6tkP7x5vTr
	b35bckHI9RXuYBy5N/4i5KJBu/zv3DTjWn5Nr0DC6AYOFr8xlAE=
X-Google-Smtp-Source: AGHT+IEdu7DZ/9OzmqugpPTGdnR+0jSWZhYN2028kVpeF4tyO0nXwrIm165+21c8BBaDKxmAhsDWEA==
X-Received: by 2002:a05:6000:1048:b0:35e:5b9a:2ce8 with SMTP id ffacd0b85a97d-35e8ef7ea0cmr2749551f8f.51.1717620733690;
        Wed, 05 Jun 2024 13:52:13 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:13 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 3/5] dt-bindings: clock: rk3128: Add HCLK_SFC
Date: Wed,  5 Jun 2024 22:52:01 +0200
Message-ID: <20240605205209.232005-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a clock id for SFC's AHB clock.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 include/dt-bindings/clock/rk3128-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 420984fc2285..d731c3ffbe1e 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -144,6 +144,7 @@
 #define HCLK_TSP		475
 #define HCLK_CRYPTO		476
 #define HCLK_PERI		478
+#define HCLK_SFC		479
 
 
 /* soft-reset indices */
-- 
2.45.2



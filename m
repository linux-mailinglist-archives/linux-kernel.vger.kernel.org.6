Return-Path: <linux-kernel+bounces-306853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0B96449F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EC91C248C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2841AD9DE;
	Thu, 29 Aug 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P9nU2OEB"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF561AD5E6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934805; cv=none; b=ZYvIs1p7fMCKYJMIE/EEjINWpHQfBhKkYzHMGwEaDG6EhZ5XTnpxvXEydgMs2d9sKW+mwWuQnaTYxEZxTjNh9jWd0UJduR4xlkop9lBHz2JBreZ2KfFzcZc9UuV14gPVk9L+GrLrSdDIzMhnoK3VHTpJpqjU8vl9vnB+VNG131s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934805; c=relaxed/simple;
	bh=2seSKUbP20B+v4Da+nrC0RJo+JYqN7HNRn8x6mQUcuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mg0mvPm37D561uIebCMw2uQ+RsOL6UTFBAGeaF7SCiRsiBbahQfh7dP0rpFtwv2fdJ4NdgRBEU6D1m2pVMQ7vsWXEFGCRJjnvwC8FCH4oPUxz3sv8EeYj1MjHrCfmB0KeMllWtgRHHeAonnAOTERr7kljTozKhrdazlA/fezQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P9nU2OEB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371b098e699so507880f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724934801; x=1725539601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5VzDkyGIipqeKFQeDDBEiAGYXukKHwmPdzrDO5GWeU=;
        b=P9nU2OEBgnzrZJGljOiBgOrUSLhSpbwndKa7eustG4XfEWFzoQ4UN25pNDuUiiJ1/S
         xcN2e0nUYgsjlmiw/ovM2ejuZpnZVCGj8uI/2zlvaayRwqkmWbthonT3e1NRC9MmZOVR
         x5g24S0gDrBGwWaTi3os1k/LEYBE3J1No/01ykWkWIKmlckwHYCgBjJgH3FO08IeFeYi
         A49SeD1LRsYr74XW6xF5dYW5kDBhPv6h5/DfIxKYKMfTNj8HOTKf5DjzhuzV6e9Q/HX3
         yrfG0rwHP9kKwpv8njArh/2utnjuD2Aiq9nfGawKSoYuQm+I3OXGOf5u72b3W5f54Yrq
         hl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934801; x=1725539601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5VzDkyGIipqeKFQeDDBEiAGYXukKHwmPdzrDO5GWeU=;
        b=Zm5fbyC3ywTLoj1jZeMtLlEGl7yJbM2Fi1jnzEhIWD3Yw3jymdadvRP/qgP4OFRTLf
         Bls6OlYIQKPIog38FiDYwY/VpyfuEANggOnnuBx5XwbCP/YmPuJ9gLasXOZYOKTjtAJL
         CrTWgPkH2UA0PmCEXwjWb/Qs66eBFFVa3YHQ0qXSMLFEFDDR5/4+QRMrZza9i9bi7UCe
         GkjHpX9KQgOVt90P/7rDi+uoSt/cC9OPBrmEfBfeBcclVdjJDnDt1Q66YAxskjMWMLQL
         bpXTSLs0qa0BHAgKtWLuzsvENqGicRIZp9f0gUMH0XvAE6uB5Ls7RGX2V4F9V2+o+RKz
         Mt4g==
X-Forwarded-Encrypted: i=1; AJvYcCXRMvlTdKCXlh1lLXTrXq2vrEsRQT2Wn9v+U/NfiLrrm/VQ/YZAWsm9/zUgdOprHZ+7xdMhIhozAPS5mrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrJab5ouP6aa+x3dx/QTwVA5uKpGSbYoy6CDJQEWEpFvF+EMP
	eZzPgwZSh7TYB89NCrBpbwddtkq3J2oqI8RvNmbpxlFDpqFKWAzryb29sthsXI8UC+EHORAj+9F
	2
X-Google-Smtp-Source: AGHT+IEUn+XUGbwbcc82Z4ruGRiXJAYhB/DLqIvI8zIDgN4867faLz+fysRvLFTbaujzVS8Mo0daOw==
X-Received: by 2002:a05:6000:cc1:b0:366:f04d:676f with SMTP id ffacd0b85a97d-3749b526222mr2464717f8f.12.1724934801188;
        Thu, 29 Aug 2024 05:33:21 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9978bsm1315042f8f.49.2024.08.29.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:20 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 Aug 2024 14:32:02 +0200
Subject: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add bus property.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
index a55e9bfc66d7..a7ce72e1cd81 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
@@ -38,6 +38,15 @@ properties:
   clocks:
     maxItems: 1
 
+  bus-type:
+    maxItems: 1
+    description: |
+      Configure bus type:
+        - 0: none
+        - 1: qspi
+    enum: [0, 1]
+    default: 0
+
   '#io-backend-cells':
     const: 0
 

-- 
2.45.0.rc1



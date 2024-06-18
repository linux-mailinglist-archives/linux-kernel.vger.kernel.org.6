Return-Path: <linux-kernel+bounces-219570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D875B90D4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C781C233F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA501AB900;
	Tue, 18 Jun 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vypcjnui"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0316DC20
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719359; cv=none; b=uXcn8oZEb5LYzoI95kh1OvBbgjmAMFI2zxw1Xr/fWix4z+j4nKtieW4s9Jy3qDSTDXOtKPzPbNWJyGLsy7qeoHaC7KXrlPX5LQ5hXCCddpKtVHHwTfQKK0tzo6KxMxqCMdUwcaUPo25A+pa7QMp8AqjyR/hlsdPpqeN4KKq0ODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719359; c=relaxed/simple;
	bh=PLtj7bSe++tHU1muE0ellbCUBsOVwaNLui/U8TXTses=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrLv0HIR1+xb731nZV0MmTH0hRwOxZ2osDkuOwN5PSmrXyRu2KfE3qM5ymANFmy1O3m6T8DwN1GY7Znd6KkDK3vGJBabmGG4571uiv40prHw1g8z/kG2ZJB6+CFHHV/QgrjuZxhwGPz71/M3EF/D95/DDc8CtrqLw0W9439A6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vypcjnui; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f14af40c2so4574740f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719355; x=1719324155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJg4U+PW9Snx8tG5VLs4l5kg/oNVaqq+3EVHHkcbQfc=;
        b=vypcjnuiJke07aPcLopSP2JneN2mnNHmsXw7xgLzXa8jq9pBV2NnxEs9W+AMySMcgx
         FPkt95Cny9Mdqq2ai6lF+rlm1p1WW9eVGUSCXhQT3AM3GENw2atiJQXAW2GK+o4WOtZZ
         Q7oJWFTF6MilkHHPKrpD90AS2Dvl/4qG9RHqvCkun8W36XnGuCK2WEz0fL7QFdPUXWp0
         rkKohkFRmS5HFQbKZsS7dFJI7iM5uv5J9+Nw5F/qasNfFHJS/vDk5zMpZE6cO0FT1m58
         Z27OzAdR0/8QGEE+zIwpmy8iGhrz982wj7bLXgayPypcH9dCwNfb+z42JC1jhOQwIYFw
         IM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719355; x=1719324155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJg4U+PW9Snx8tG5VLs4l5kg/oNVaqq+3EVHHkcbQfc=;
        b=p8LDhnV/sksBQWdccDzu+6a/TSNs+d4KDviizb8AqDdW7HRkU7R8kEPR6mNAAgNRs0
         X3Y8RdHXXMo1T4f+3Y6bNBk7Ov6XNFksV9cHg7oe600vKl81e9L5olouH2RzrH6qU1kd
         OE5sqj8MRz79ZB8I59zCr6o/Jd+WTgckxLRnAibK+BIJN/mHPvZEXgZyHY+b/ZwBRh4K
         mbsBHDOQxYzOVuxqSc6QfhgOVnVTtERUAS6bHAcA0dRNhBRnKsZNE+8DKwfPZBllehZL
         ivCJAwkOMU1T3bur9Wgq6+naU2d1jMw89vv/nF0bvR1Bet32ZkwXZXCVz1Ql8drf0kmp
         AYzw==
X-Forwarded-Encrypted: i=1; AJvYcCXcDWLq/j/puRdpYE1r92XLwTJEAktQxS7WzScau6yfk/gFcOGCrAuwn8wILOun+BAIWioPKAJQgN0DEGZzQKkJhWRoOm+t5satFlPh
X-Gm-Message-State: AOJu0Yxe7pQuJkxpaqP7XwvndG+QifJLpt5bBKM9wQyyB4R0P9k0gEqd
	6BBdS9sKL4b+qLJpnj1Jp07UVRPmEUpWVvE29rpFolfXrhjW+qP4R3fkfw6W5Bk=
X-Google-Smtp-Source: AGHT+IEpUUcK2t2NT0uyE9LsIkX7F9ePlZPM6Wgs49S7h0PwgLnOw5XdUvtGqV7G0aa932wJUiWaZg==
X-Received: by 2002:a5d:5607:0:b0:362:ea80:db0d with SMTP id ffacd0b85a97d-362ea80dc64mr155775f8f.11.1718719354954;
        Tue, 18 Jun 2024 07:02:34 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:34 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:33 +0000
Subject: [PATCH 1/9] dt-bindings: iio: adc: adi,ad7606: add missing
 datasheet link
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-1-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

Add AD7606-5 datasheet link.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 7fa46df1f4fb..d55c58400df5 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 description: |
   Analog Devices AD7606 Simultaneous Sampling ADC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7605-4.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf

-- 
2.34.1



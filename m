Return-Path: <linux-kernel+bounces-333324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C77897C6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1E1C20B40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504B19B3DA;
	Thu, 19 Sep 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GruvSxtG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7319995E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737701; cv=none; b=mnUoprObSss0FkfD9FyJ9cL1qtoNdtkyTeCcMUn0YNLoDSojX2J0c731c7m2wu1gbezUAa+6RCLsxTlDms336uGXiQnUKyUux3wSzmCgD3wDpIoEBH0BVT7DjM9njD7sKfp4FAjiKnPelMiYsu9uDu1n0MQ5icxdYiJBY9qf6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737701; c=relaxed/simple;
	bh=i5PZepG1aoFBTCiFDPOYVCA2IFjIkELc4/8zmw5imSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLtX7NRY4ZvrVekWc/yhFU+oNElevLYA/P3LFTkCwaME7Rfkv3pqYrKOIjD2tLNLOV+b9JOYOOuIilTNRnaWbi1q2y/tkP6ZG09vMOqpdYRoJitRaWG+bohGkiICltULxgmMindV5gG4mx9fIZCeVJSiy0VU9tUFAqZ6GadkMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GruvSxtG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so4783155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737698; x=1727342498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMa/yQ2Im0//zhcPUCeMNBxbg9N98XT4Go0CFqsD1eY=;
        b=GruvSxtGn9TXNzz/DRl1ik8zufhfSeZzIUD1oo/6oGTLyz+0Amwpy6h19B8ylUbj/u
         UOj2km66k6zmq3DpW7vbx7gYYnble0ojqbn+2huTythr84vx44PmoxLps4Q/8na1umR3
         lKXxd04oBz1tKUzKf9d2cyF/iPEWbghnkLdsHPxLEM+8Lzilvi66lYYH+p1E+ZFNEODu
         fz7g8EtlgAPUQ9m7NQ98aBbCDxsnIt3mdXsAWWXrrs0v0yXsHAJLt6AXvXfg/n3Szn1c
         etrEjxtVkOZVB9RfCcBhZBuhxcuFRKKBGCxBIkRDOg/EkmKSvYjWxwBN45p8yht9E3KB
         0Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737698; x=1727342498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMa/yQ2Im0//zhcPUCeMNBxbg9N98XT4Go0CFqsD1eY=;
        b=fbuU8WbW4yZvdgHlAsVpUmwgcsczQESTWSkxv4OQx/HdBYj4mn76uVWx7frGw62Nmx
         YT8HXMV+qGPWVGIp8E1gzlwMyBwb+zvBWS1hCgAEjO0ZiVpC/0Y7o7Yvbk51IwTT4ABJ
         4XCkV61gjDgt/4xt9A3jPYzPXAH0LMThSrLG3fF76X48SULFAUl5jDC2UUkS9WTk+aFO
         a/qbftckIzbSeQSuEtKvQrUeEQK45S03d7F+lFopiX29Ot4tsgGTeohuavrMowZzA1jY
         JHRvEh6FcqFmlbz+6TCupWhVsDrIL2IRDXB6yhhN2m/qBR1Gft94eh+t5j7Ha8pyG9g2
         9jQw==
X-Forwarded-Encrypted: i=1; AJvYcCWHM2CzUeaxboih8og595VbnQj/89BF7WpT74JrXiNyBkc+klGueWXepanR1IWXdASKIADbgvzckP3UVsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZPsBU5adAJzelOYOwpReJjRQhQkEqn9QP5hXsGsgufPGm3IT
	i+rziQmAXEuz6i9g64WRKmQYFZBcMniNi2NTo/LR/9hBtuqSl9AvktvBKXL2SzY=
X-Google-Smtp-Source: AGHT+IFzaSnso6ocrF9emwd2RsWQlvTAmzurK9UZ8AOuiIHpVPVrYdehMMnowjm9qAv3d8lc18uSxQ==
X-Received: by 2002:a05:600c:4e8a:b0:427:abed:3602 with SMTP id 5b1f17b1804b1-42cdb5675f3mr190980895e9.24.1726737698218;
        Thu, 19 Sep 2024 02:21:38 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:37 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 19 Sep 2024 11:19:59 +0200
Subject: [PATCH v3 03/10] dt-bindings: iio: dac: ad3552r: fix maximum spi
 speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-3-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix maximum SPI clock speed, as per datasheet (Rev. B, page 6).

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index fc8b97f82077..41fe00034742 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -30,7 +30,7 @@ properties:
     maxItems: 1
 
   spi-max-frequency:
-    maximum: 30000000
+    maximum: 66000000
 
   reset-gpios:
     maxItems: 1

-- 
2.45.0.rc1



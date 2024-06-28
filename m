Return-Path: <linux-kernel+bounces-234055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3FA91C186
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C302285C08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440631C233D;
	Fri, 28 Jun 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rQDJLkCf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CEF1C007E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586123; cv=none; b=hKbk5y3o+X1GRBeQZfGmDe20c0beexwTk3NYTLPsz4PVacLdf4MsWmUcAjXncpLHzm09We9+GF9+R0WNeLWcdsGeW85b4FzmVosI3cI8puvl7/VphjS0olzKKDAFjatZLz93lBLJzrNZeie5+0Nxly8OWr3VRmLXwjvKBM06Dlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586123; c=relaxed/simple;
	bh=fMDqf1KM7W/RA77rezMz3nE602KNHtmJiEMO09XyypI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GqSZDQo2v7XFiWDLtikTUl5YjCt+ulqyHIPTDqflNvCCqr74vM4NZt1rVAmq8mmMztiMaxotbSrg4A3R5bEzFdFAUq/vQX37YdMfZ6TXYRxLXTPeepHtEui/T+iqodW22t2t01FBHFT0pD67VAvpWnMNBZRUoRAhoCGhFJ+9T6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rQDJLkCf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424adaa6ceeso4874065e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586119; x=1720190919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PSO/1gMPYozHX3dfKEvclJiI5tF+MksrCbjn3VycYQ=;
        b=rQDJLkCfkKgZBhUyezQ/lYW8Bm2E98zhIHYDXpcmGmzwuGPkPKPrDNV0K2EFopvKN8
         Dh6qbxDhP1CY1qZqDJpfGEIwiVeLM+OyL883tBiWGCDkjPpfoa/Zhf9B2KGoCgcsjtQT
         AONy8QGXS5M6RdwtTXqO/ixoTFKDrna/+/I0Z+RzpJTrAkVUbFKVdNv7AABjWSPXNkiX
         tuw/cbaM2EgkTQgkaQx1LMx7UyVH46WsKBPZKRTxcB4LTEfMCXahdUjkAbLCWAlC0UvP
         sx3r8Va61F5qhYEG29cy799StWXiIdtBzKcZRAMsGgoOrVN5vEX2j+6DNEsIlIAD3uFX
         fmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586119; x=1720190919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PSO/1gMPYozHX3dfKEvclJiI5tF+MksrCbjn3VycYQ=;
        b=poB8ze1kezr6dd+wwv7c2a8naIgk2jp/qXM/bI7Gf2/tiHw474XOvXjwtdHEj6YL3s
         un++OOZVCYgp6zveDRV7zoP//Z9qhPwf5eXR0mHWcZTIEjFFMhXobXiA21OrbneQzyVr
         5wxVm7GrFIsjHOSjpUHMH6UB8A06mv+H64aHXp2KzqVv+8zii6M87fbsCpXdn5qmweTQ
         87Ys56CoEwT9wT/CXZ9KZzpV/wHlyUiIRFqCJql/w1/0/pL95eragq/s4+Eh1YeEguZg
         t3p/XhuVOnzXl50D//Ec1jIZUA58aT2izXJCS1nXOsXQK9OSpSkTAfo9tGCgFxIBXliy
         Ge1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZJYoP8830oHoYdjjztbgN74toqD4fJJzlIlTxo2DEYW+nzPKdwH2ss3y9czvwt87RSZLWZ8A4wxLb+oPsGx/KGlDcswevp3YFYZ27
X-Gm-Message-State: AOJu0YzUh51t0CZTrr2diI/ZZOvk0jmpkXxZZ1uHiRoPreEu76SVVK2N
	rqIZn5ov9eUCP3kTISvU08Ha7o/xJQmRugXosk0Pfic89L2E2ddbh/B4tLu44NwYmd4dFIOyxuR
	o
X-Google-Smtp-Source: AGHT+IFAh8zWamkAmBF1B+P2cbfd5WXLJvJUkgL28xwo0GsXojl2TjxPdeR9K2+uX0bS9r7zxwwE2Q==
X-Received: by 2002:a05:600c:438a:b0:425:5fa2:60a8 with SMTP id 5b1f17b1804b1-4255fa261c1mr53186065e9.24.1719586118790;
        Fri, 28 Jun 2024 07:48:38 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:38 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:20 +0000
Subject: [PATCH v2 02/10] dt-bindings: iio: adc: adi,ad7606: comment and
 sort the compatible names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-2-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
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

AD7606-8 is referred to as AD7606 by Analog Devices. This comment aims
to avoid confusion. Also the compatible names were not sorted by
alphabetical order.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index d55c58400df5..00fdaed11cbd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -20,9 +20,9 @@ properties:
   compatible:
     enum:
       - adi,ad7605-4
-      - adi,ad7606-8
-      - adi,ad7606-6
       - adi,ad7606-4
+      - adi,ad7606-6
+      - adi,ad7606-8  # Referred to as AD7606 (without -8) in the datasheet
       - adi,ad7606b
       - adi,ad7616
 

-- 
2.34.1



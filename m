Return-Path: <linux-kernel+bounces-219569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF990D4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CC71C233AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98B1AB8F3;
	Tue, 18 Jun 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d/AcZIk2"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186AE16DEAE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719359; cv=none; b=aBRW8UcAGiDK11ftXZVOz5FXsiGc95vcevoPPYKcQKYs+0XGPSN1I550eZZTW9G859P8gb7725BctG9BxqqiHEyV8MV0uSEwRPl6Bj1lMXDOkYoY6Cf8AVPfzcBu04cmXj8fJx1lXAvjWHn4CAMsFXNkXoowQTS9yD8YlZE9wB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719359; c=relaxed/simple;
	bh=fMDqf1KM7W/RA77rezMz3nE602KNHtmJiEMO09XyypI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mutdELBoTBpmmvvjX7TYuhuRVJye9muGUs8q3Birl1dLHkPb6XV18rs7a8ykG5L7ZRgQheI7hiBHDDQId0wgwMHvd6+3Ky9Ao8FIsHmd7u/h+5ruUEW7FDJVvjG/EeVCtA3zLIAxLEWcrVuTy4pWDo5jzkiMigZxzMBDTwtQJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d/AcZIk2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424720e73e0so5084885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719355; x=1719324155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PSO/1gMPYozHX3dfKEvclJiI5tF+MksrCbjn3VycYQ=;
        b=d/AcZIk2YDa3WRl/UOV0NtQC1qvlNk/wSJ34sT7HxPqQ6sXVSTyEHoYUf5jEaH8YDZ
         +Fe5FZs6ukS+12f9wYiXAejs2Jj5ESgMLYnGNvo8VjgeAMSNub4AQNh22cWafWxWlFq7
         u2jHnoQi4OwtvBVVRcPVEgB5IQWNEjL0kHb5oojRfyFf06hKgBsN5jOZ7q0lb+U268iv
         dqLPP7tFBGI8kZSvDR/Z5qLNsg5yw/uo5dkraEHIrXOtIAlj95ry4zgTiyLCA7yHkYOO
         Bq0Fu/o1Ao9ux4Ugwaaf3obZJt0Lnys70HoVqgNLkNjusTe1UZnu/rD2qb6A38beUKoH
         5STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719355; x=1719324155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PSO/1gMPYozHX3dfKEvclJiI5tF+MksrCbjn3VycYQ=;
        b=ZQskY2aKxMcoq43yOZHKxZLC0AvqdvndBCLTNDgHMLq6ZB2vkX++Lqa5o5t7mrAdef
         wZk2aKYXCGB0gfD8XlOr+NovLsTaptayDir+7DjlDymKNFlZS9ec5s008xesYjXuR3O7
         pyoGIGHxr/6OQlhgQGMVegS8Yv6eXemq4XZRIZnk4vZVrEE3SSv17RQAWysVFwVbbckf
         lx+VTAwQqu+wWAaPLqLFO04/TEIKwFwZMKQPFAaZle5j8aIs9DpZrOvkLCRnQk4sig7F
         9SDTXgkSRXtZGCS64OjQKNrwf3hbLqsWUXkEJzFllIDhvw9T58mx6EBxHIAp8j2O5s/Q
         Yo9A==
X-Forwarded-Encrypted: i=1; AJvYcCXa1jYSqS8qFPhT9B6Xq5Zb6oP0cm+rd6ukqppTTj18gWrpkcRnLzrLcJJYR5XQxIbIxpO52oVPuslm4GZA1s12Q3Zjlgccn7LvAFsH
X-Gm-Message-State: AOJu0YwhtXYnBxjq9Z/R3OS65VVOABvZ6qurO32aL4wNxOX/PuPAy0Z3
	W4q3oY+g4sWtUtBPBBMldM4bxcCyW7UIPWzo7gPdkteeQ8R21P9W2rRHhjCS4QI=
X-Google-Smtp-Source: AGHT+IFhaLPzqepPaG30Gpc5wKJD8gFH+IxtsauFUs+mCd/Kver+eAIQm2Ywl7oZ1ItrgT/c7vP4Wg==
X-Received: by 2002:a5d:6192:0:b0:362:6e61:a342 with SMTP id ffacd0b85a97d-3626e61a39bmr1041071f8f.36.1718719355495;
        Tue, 18 Jun 2024 07:02:35 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:35 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:34 +0000
Subject: [PATCH 2/9] dt-bindings: iio: adc: adi,ad7606: comment and sort
 the compatible names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-2-f1854d5c779d@baylibre.com>
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



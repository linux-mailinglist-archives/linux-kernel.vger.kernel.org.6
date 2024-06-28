Return-Path: <linux-kernel+bounces-234058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A191C198
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9922E286B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF4D1C9ECA;
	Fri, 28 Jun 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rxFGujD1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D11C230A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586124; cv=none; b=bDJCnylzaetTfzkePs7ujgwE50VsF80OhYw+4dfEEHQM24pcp+f5BdB6y0tRgCtkzpv3A4SLvhVgYYBB1uDhivKMyIQbuuswp/BC01RXkM0syHv6eJsQzA2EA3wpn7padOcN4y0O4kWOQ25pQhulO16gPvqVAiykMPc848CAd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586124; c=relaxed/simple;
	bh=KG+zFgPhZKlTNWnyTH8PVKe53m37TBYEzUhO1FprBcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMtIpWePCacATRvGrJP5EUV/VCl2QNrk9MSUeggeHJew5HbpNrkGNWMAW0meK7xoYpzg5DH4Yb+yrCrsbEE0+TavFkNz0xJ9W9YQtPKO8LUqfLsOvtOiJvoPDyqbrzXsqXc6xQAGcF0WmNsCiUNtqiEvwP589G7IhyLezYkvCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rxFGujD1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42565670e20so11362405e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586121; x=1720190921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXCtOPPk0mXR2hghTWte0gDiaQ2iQV0q2v+Lpx73cVI=;
        b=rxFGujD15SqFodEFf7DGkR11ptD6VzTmG28EzJm4fxXmLwU/zM4kxOADRkka3ms0Wz
         j31PbaZ8Qpq08F/njmc40JoF1tGOBCwntP02BlaNR42nO2FY4aGLIl8yRT6MMbKQTsbl
         1ThIQGZn+/MDrAFbvZijM+9tIw58puuySbTk/YJdn3KhgXQzIa74+fwN5ieqmSPNRG/o
         YYCYPYwmHnJ2ihQgrZqNOYs+qOOgMXmtSOkOcAuW1v2nc5blGGioOsM51jjV9IgyeW6D
         ZI5kb6InPQeBlLKAuhKiLtu4JYSYhVkpJO2V9+bcAlccsklyMrsYdiUMtl8vic7Xm5br
         3t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586121; x=1720190921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXCtOPPk0mXR2hghTWte0gDiaQ2iQV0q2v+Lpx73cVI=;
        b=Sdo8E970CP6zzrhPOKYm8rqvNVa0L/6zC60eD/bP6X7G1JdsiFe6A+5bcci9CAl/LE
         3PYsLdSBXn+o7UHWOQLxOURDqlsakOteJNaiHuWlCnCiF7M9oA9dSFKMkZ+uvdWJe30N
         q4Fghh2yCuiluEGIJtLyT7FuY+NILeaowgO0h9/FQdNjPqZyEZp9qC980BZoGpH+nFTy
         0663NhwgW3QfPlDXXSaBcSTgpprhAFIlCNwe5WTyWGFdOgF45GZCvfVOJf5AnH0NTmb0
         NnavGX2bOBvZ1z88rQUHrZkiOVr0pB/gQ+1yhKV5pN+FhL4Zj1GWBIbLFW7kpvppGtFD
         2ddQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmLfuZYwQuEMgnFh1chDAg27/0mbouf9BAQmU3M4oUeagVb8V4jOZwlD7Eqds059z1udBvyNC1jhwVr9oag3tIL+DmkVZ/pqGlCXIg
X-Gm-Message-State: AOJu0YxReE/bShOdV8rlzeZSTeEVyi5dEJrTacFEy7YQY5S+Enz2lyiB
	77IT5VgUnVmF0WScnL+kpRrylvmVwad6j/PvEh6B6DoM11aFRuZnyXJO0N+Bwgw=
X-Google-Smtp-Source: AGHT+IFUYH7Uc5K7rfzXLLQxOm6u8Fd/5RQ2WkQVjaTjQbpyYS7AwTX5otCgN3NSe8nB8PBMHiSj7Q==
X-Received: by 2002:a05:600c:2489:b0:424:aa73:83e3 with SMTP id 5b1f17b1804b1-4256d53df10mr18738915e9.18.1719586121172;
        Fri, 28 Jun 2024 07:48:41 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:40 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:24 +0000
Subject: [PATCH v2 06/10] dt-bindings: iio: adc: adi,ad7606: fix example
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-6-96e02f90256d@baylibre.com>
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

Example uses adi,ad7606-8 as compatible, but adi,sw-mode is not
available for it. So remove this property from example.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index a1c38a5812f7..626782ea00b3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -153,7 +153,6 @@ examples:
                                            <&gpio 23 GPIO_ACTIVE_HIGH>,
                                            <&gpio 26 GPIO_ACTIVE_HIGH>;
             standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
-            adi,sw-mode;
         };
     };
 ...

-- 
2.34.1



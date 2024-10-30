Return-Path: <linux-kernel+bounces-389048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825A99B67E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F4C1C21CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11A02141A2;
	Wed, 30 Oct 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWo1ZbUT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE011E5726
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302232; cv=none; b=TgwamKy+JUq2aorZEj4EhFwSjpCYmVtXnOBWPEX1kzEFTbzYj2drKElRJDPgUUSdthlNxW0lcxGRFCA8tfy88wwunWx13FvIY03jGlxjSOTjR1U/WcN+AzTEIuBVOI4jFBH5pODiLQrCGjiIi+8W2LNP77UXlcfCZakYiPe0BsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302232; c=relaxed/simple;
	bh=AXp9R9SIchOWcn52tYxCXMRJHbP1cxB3uaJJrIOcnfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHWB0Wyujfcsu2JlFXIowfbVXaungsK2Tg8laP80+yTPOvwzhqos+7qS9zT37DguUXWGxz+HTUfuU/0QS2ewSz7ktOTdEYGQKII76Cco68S3f2T7+kjSzNAENv/muccH4kZKBYBUOtY7SoxB7i+4e93zwnHpMHamWO5f2RyGObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZWo1ZbUT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so4519f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730302228; x=1730907028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRMi/UaCb3Fk6BdW82ihmAT7XSEnqkfXgGS7TLc7snw=;
        b=ZWo1ZbUT85ZHDoJYncj6d3A9Gr//peFQr9lHTiOX7TnyVQBi/OAbuu0NdTj9e79P32
         bHhgbzCq4lfCTZDLZ3IiFqvv3IiKBGjuH1qAu9EL1NAqdpq3ukv2qXMqg0o/WDIwPb8c
         QzvF1C5gC8AhxLjWBVd3BbJz+GWMTgHRXz0/mN7+rL/R/gtYnT6ifPvV6Q/HOT5ChT5w
         U3Nzoa/fE9iQWXCSFRGagSzYLNBuoRaV1IcloenWjMUzY/qCfPNTUnKrKVIUl7aRWJ7w
         kNtWX61Or2I7tg1htecYJ58J0j/K0dg1ozFNF5EUm6KA3SGG3uIEe5yYDPCMpyS7JaqM
         yiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302228; x=1730907028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRMi/UaCb3Fk6BdW82ihmAT7XSEnqkfXgGS7TLc7snw=;
        b=E7JsaX/XiYgDPMhVLg1Kwq0xDPltbu62dfI/8FbdPiE/o9N5+MZfLErq6upuPBivcU
         VYdU8IsoRbO2mjrcHnTSIV9MVMF6mUSPwE9uvLKAKEMRBQaVJrQ8phQYzOsyIX1e1chT
         nhadl2B2kQ1IC3d6xdJj7nx92ZAIvVqBTyWyDkB/Ulc74F45rC1kKK/WyTtblxGrM2lE
         Sm1ner1/oV4bvikT7qM2QgerjuV6xbvNYBT9P/GjVzQnp+GlEhuZvR70tW64UXcKe8vz
         52GkeCYmntJ/grqUl9LM3F9tcJqS83EUZfANzGh1/T2+fO+3FydQIkvSAaHD3/w4SfUs
         2XcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAjZtLMwgWGjBuA6era8yC+tmdhksro54Rx8/+m8JYZaIzGGOppWDgY4ECsbOugqBOlMSZ+bUzoqRK9ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Q5JQZuyoJ7lSBh9xhSFQvnAeihqLDfxP1FFcuzlGcA/GrdmK
	MzDRq6nUOWxFE0kN4yzbxasCE9zq5jsQHWiIImdciLLDyiIoxZd+4YtHTBrfu98y3GTX6iL5kaJ
	SjDU=
X-Google-Smtp-Source: AGHT+IHoRp+AdkV7muEM98FjpmsQbqUcxsFuiT8bojj04qgoJZnxfDR3JyQ/xauio6JUyi0Vrf9CtQ==
X-Received: by 2002:a5d:59a2:0:b0:37d:5129:f454 with SMTP id ffacd0b85a97d-381be776c81mr12116f8f.15.1730302228060;
        Wed, 30 Oct 2024 08:30:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c236sm15604040f8f.35.2024.10.30.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:30:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 30 Oct 2024 16:30:22 +0100
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add Allegro
 MicroSystems, Inc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-topic-input-upstream-als31300-v4-1-494297c9e50a@linaro.org>
References: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
In-Reply-To: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AXp9R9SIchOWcn52tYxCXMRJHbP1cxB3uaJJrIOcnfc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnIlERgWKlWKr/QYDLiS94tIIuQ28hSEKf/QKE4h+o
 ljU27P+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZyJREQAKCRB33NvayMhJ0fsUD/
 9NlYyVfmCDfpCI+AViO8eI3UNt/HOm7t3yz2OZ/HVqdJq4YRcCYtmeOucCLpW2mIxarptNqaqUEQUZ
 QTHE/J3S1WEh/oUtrsExS9V5phxjyBdLu0VKWZFT5Ru+GWiS1vv8GKFVAHxOTYXfETCfhp57ZhPByl
 pyKahQapTopn4gurnbn9WKc9X/VPyJ7lN6PJBm8ftwWhMoLzaxtJNttO8CbRTv8aUwxdsjYfAMgrhv
 qlB0yBj8iFpugYYscZ6TjnUTmHUF7Gpb6J8dJorjIPjSbDVgOL5bA73WMHbRsm8JTNmWGdo6GRPRV5
 OQZCuMHTk6uuVlqsZFQO6S2ZT7izcbWnQkKUhsAlekOVdQK5EIGcquZjJTnIYpJH2wnF0IgaM0yvGa
 Ifr3Pmn+NaMc0m1EjdNUYbevnFDPcCKajahGBgTLoASld7D9Cb6fOvj56ij61+/fIgPSDt4H238kuz
 r7gdCU0D0P3xQuS3sa8f+hAhYGi3AhQVoZWCjPxakXAybdaJx89CJprke7qucoeV9HE07rIgxg8Wwl
 LM15BFsM5nQr9e4AKlbCgGeftmp2Ikek8NoplvWbpI85AAmvO467C9KkAROt5LO1UpI/S8qAIUqaat
 RYlM+qaoLK+kGG0IAPNzjIQ2Vixkq5PyuUMKbRqRj429AUS8BNA+W+BQ52ig==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Link: https://www.allegromicro.com/en/about-allegro
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 15877574a4172cbd9395bed531555cfb009ff010..b90355c2b45ada6e20335cd5bb2aace9410e4d3a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -83,6 +83,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^allegro,.*":
     description: Allegro DVT
+  "^allegromicro,.*":
+    description: Allegro MicroSystems, Inc.
   "^alliedvision,.*":
     description: Allied Vision Technologies GmbH
   "^allo,.*":

-- 
2.34.1



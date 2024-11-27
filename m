Return-Path: <linux-kernel+bounces-423371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1139DA67A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC70B2B5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627841EBFF3;
	Wed, 27 Nov 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNx8a5+B"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385EF1E5711
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705305; cv=none; b=L4fDcPI764D1OBA39y4ldRMw20UwwH0KY5DhglCBE9wzVExjxFMrUFdJd7BFbaebULfLzVFK5SF4VAgfdEYpN1PXqmbLqZq1WGVGMGrNHoH5lW9Nb0+zJfqNfdVqFdy69biIbZS/9+tlJz8qG0tdpim3QdX1yWvoeCmN6Q4P6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705305; c=relaxed/simple;
	bh=hOCe6cJ0obVm8UjxsiUQNLMPtCy8NJeg3v7RzQ3z6+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKb97LJM8DIIQO28d9utFDTi/3GhxFGU+CsTctQBOr/Fy55x3CKbpQA0mleQjev+LbdOqnRc09hc6BLE9ziElH22M77omTGOzFU6+R2GAVRoiR9szpvL7VLIw0p+767bsRr4xbgQ5bCaKqOOSqQUwx/Rv97oFt2DIRCdzpIaYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xNx8a5+B; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfabc686c8so7685322a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705301; x=1733310101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwFISXzC5YdjT7nYyo3FK0ynEMcXmWD+620yv0Db3ss=;
        b=xNx8a5+B8CdcMO3gctLMUXALIZb4dMFTo/pN/AH0HMm+ge4EWsvZApqW26HOrfX8V4
         AlIQKQECgGIdyQhHNNAIBQ17GB4rvpEhktqearre1KAa4nWgXwc+ZaLA9YyfOk+Qu7uP
         QwmIbk1TcosBLoxPS2j12an5rqeCcz9iX9G/uJw/Ho8Kv252a6Eynjaa6echUkV1EIQH
         OP8CJvNOVHDaiiQ28DxgX/zV0YFoMECK2LHo9MJ7gquqKmnfALH6Pg4/oDYVNVSW9Nmy
         duu4Kg/Prl1oVOnxzHAgeNnlXfsUwD4PYcZG/bMPhrDgfncdSm6VQQA7IYQIjhT7M2f1
         tqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705301; x=1733310101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwFISXzC5YdjT7nYyo3FK0ynEMcXmWD+620yv0Db3ss=;
        b=Dl3B41grNhTbjhRmaRNibfNu4+KnXJOpHvkwC0iAGlDZgTfTFejyYN1+MF+mvplHnV
         aF2whQsGB9gNCd3+rnwT1yiwoaZRnhQM22wfQD/FiCaDJ/m7s2o2y8fk8As1CD9HbUeJ
         mRF89A7GE+5Jb00sfw2pV9CXs9V6ethogadEakwVWMH4jwSP1UMjO72xMY+RbBNpOH4m
         1dEHovHz7pkHJP4kw+af+72W3GQZ6KNsVbdw2OkxsB9mbn4MnkWYRGsFcUvUBm1aEKNn
         C8C4KjIuA+wd8+3SticVIW4bEiq1qfg7OOBERFCuzGbfyyn/jMihb31YAn1d+/HOw7ng
         q/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV+laURE5ytBC1cAjg59IFr+/jg3izbheN4vXBM62d8R9nCXrC0nnAw9Q8X5d2UgrhA15xD9pJpieMP1us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCQG2FruE/v7/NQzT3KnVA9TA2fZhNuFf2UVx2WppNa9h+xko
	JaYj4CRpQF6sbwovv4Jb97XdbJ+Eu0uGbveD70ZAwnLQ+Pzyz1T0ept/BunYtdU=
X-Gm-Gg: ASbGncvHIKPjGV+sNiD7j7TKy33ygscczJ4p6eGm3VWxtBpoo2P/CjtTMo+tCfNnGgz
	A3x1EEP0XYHTbg/Qkgm5XFr+Yt91Moui+04ved7yErFFCxZ4o7g5W7CdyQymJwTzE9P49+45m93
	//yt5Zv+eOPikRcokJyk/3wsNUKRwGDDnet1hMsjOTGTJh61Pr5CM7SNQMHILRKJSD7QjIwb310
	xtn/dT1n6POMpnzvbver99knHij8mt/+KJRpljLNdvAZ9wm/w0pi6GmcLiSmhn1Bn61GvxK5VQM
	RQu4Vy9f7M0rXK6GtV3ND7hM0+FkPzs7CA==
X-Google-Smtp-Source: AGHT+IE4cyy/cDmo8WquVmKFdo7zSy462eB6By+Kdq+zP9Q+Ss+y6AajJ7PIBc5sONgo2uDxTZPy4A==
X-Received: by 2002:a17:906:2922:b0:aa5:639d:7cdb with SMTP id a640c23a62f3a-aa580f0ddfcmr151648066b.22.1732705301452;
        Wed, 27 Nov 2024 03:01:41 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b339612sm693762966b.84.2024.11.27.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:01:40 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 11:01:40 +0000
Subject: [PATCH 2/6] dt-bindings: usb: max33359: add max77759 flavor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-dts-v1-2-5222d8508b71@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

On the surface, Maxim's max77759 appears identical to max33359. It
should still have a dedicated compatible, though, as it is a different
IC. This will allow for handling differences in case they are
discovered in the future.

max77759 is used on Google Pixel 6 and Pixel 6 Pro.

Add a dedicated compatible to allow for potential differences in the
future.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 20b62228371b..e11ede3684d4 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -13,8 +13,12 @@ description: Maxim TCPCI Type-C PD controller
 
 properties:
   compatible:
-    enum:
-      - maxim,max33359
+    oneOf:
+      - enum:
+          - maxim,max33359
+      - items:
+          - const: maxim,max77759
+          - const: maxim,max33359
 
   reg:
     maxItems: 1

-- 
2.47.0.338.g60cca15819-goog



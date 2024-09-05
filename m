Return-Path: <linux-kernel+bounces-317415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3AA96DDD5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B201BB2582E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52821A00D3;
	Thu,  5 Sep 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OG90m6Ec"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2E19EEC8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549542; cv=none; b=uvpL0kBAZeFp1XMFpJhOU2suqwmocgAZedwhwRuc92PsrjAY7BjLYuwGS4Fh4Myykiv0JQ5OHlQAp+Y3J6XG/pfudFRbHEe0LRUoCBqbELgjZ02WUTYHTXll1aQZtcZgwoHeMBA6W5i+JzBXA0K6ut/9K5SuVYgeywS8Pru4F3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549542; c=relaxed/simple;
	bh=+u+kBqfT5sVB+pgsFs493wfhD6zF/8fwgOOVhk+vQOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYHPH1LL9h18Bhxum9NX6G87+KOnXO5WNNBkKJsQVqJJlSF5djBzEsI/zoocw8CkqcoBc0i8Knn0eM6I79Lmg9hGYX3hL7SAMwoirxvOzMcxCMiagsg1kec5gF2PYuduxHmpF/8lmP+TrOB8658Pfw34TJS9wFLA5grjslzpHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OG90m6Ec; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42c94eb9822so7541725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725549539; x=1726154339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugfbUTgXER9ktB6DH95mWqrkHVrS6OETUlZJp5IMaqg=;
        b=OG90m6EckykyxpfIygSNoioRBx0sZo+ytJ1w4LE13WrmFna9pgOC2Q28H+M03cSwk8
         bkx3V0jCFMvJi4VwQ7+Jez6KuYqNBn7xjxU97uPpRreoGDe1dqrubboeLXX6TLoLjNzj
         oBSvkMcZwFEfS4JBZEGkEpuO1WBSlW0MiCczuxpohkq7OEIATluSfozs7JHx5wy0/w/h
         5bEjF9LF0QdZPoAAIMXeCYdAkkAUlZdPNVDZ3lkXDCFZjn9Zc8gRyg/GkB/8k1Od1ALa
         6v8ZwRBUprrfeIyfWSw0ZMKay5DjF/PQoNdenjKYCJqqd/pQ2CyiTe7nQrhrYNbNJfkO
         FPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549539; x=1726154339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugfbUTgXER9ktB6DH95mWqrkHVrS6OETUlZJp5IMaqg=;
        b=ZnrcMN9xZKtWk5MIXaI3R59kMZBrWrENajHzbg0AEJgeCRvFKFWTP+ZuZaz6ICNzD6
         Lgo8w7LT34iqEz/KyFWKEWy3Akb9+8GY9wsSDiBfa5qUUuqo/PZsMy99zA5CaOHy3h+T
         Lcc+kIR6UdHr9wUzuaCkebKRklHJT+VRzkT4Y+Aob5mew7cIF4rOHiAK3BBKEQjDTY1H
         pdjCRvhCZTciOEpdrBTVfydLU/ie9JDvc257bu6Fbt8elbuCdC9r2n2deFKqkC3xIfOj
         j9Y06ZE8PYKucFxp6lSWPT06Wf1fOyQzEuC65RA2gZZdu2ZdF5ymF9qpeSEnMxc1r83Y
         JtEg==
X-Forwarded-Encrypted: i=1; AJvYcCXWXkagJP+7XKYgwe1MNPiSUC2h35DgsE7VYy2sN8bRdn6lqvCTNz+9KsIrl49OS4rmvzlEC5bq0vEAPlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QP/L2fc98YXOanLang4bUm5JNmgsKxS6hdwtxBX0Uo21yMpj
	KCvRcRcAzdy8bqzXlOKNlbJVYcgHdxaocYw/GO9Voqkl2//lbHrD//PKLpyP5zI=
X-Google-Smtp-Source: AGHT+IHTvRUw/LubhoyB2Z9CNuafV/MrTgCADVJk/19v/j2hC2bB+gVGpGuNn3EZdHWvkvbBzx4dzA==
X-Received: by 2002:a05:600c:1c0d:b0:429:994:41ae with SMTP id 5b1f17b1804b1-42c7b59e84cmr109958235e9.2.1725549538880;
        Thu, 05 Sep 2024 08:18:58 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1de81b2sm14031076f8f.30.2024.09.05.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:18:57 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 05 Sep 2024 17:17:35 +0200
Subject: [PATCH v2 5/9] dt-bindings: iio: dac: add ad3552r axi-dac
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add a new compatible for the ad3552r variant of the generic DAC IP.

The ad3552r DAC IP variant is very similar to the generic DAC IP,
register map is the same, but some register fields are specific to
this IP, and also, a DDR QSPI bus has been included in the IP.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
index a55e9bfc66d7..c0cccb7a99a4 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - adi,axi-dac-9.1.b
+      - adi,axi-dac-ad3552r
 
   reg:
     maxItems: 1

-- 
2.45.0.rc1



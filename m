Return-Path: <linux-kernel+bounces-197579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D366B8D6CB0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A231C256C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25312F5A0;
	Fri, 31 May 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BddmrbTd"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD106824BD;
	Fri, 31 May 2024 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196765; cv=none; b=YzFijysqpXhlecwPWHZ/Yv7JGbXE6n68jJK7HxIJlwYcAKZQEudRxHxONN2fFC7qxTlmNW4MWcGd++tmtvmU3Qd8QTFSMIQHs1VM91l7e/ltFp3I9U64wmBj/Wfdp6xL8Mgo3FcSP7E7GjiCu0ffOGxVJDEGQb0lTDE75glZQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196765; c=relaxed/simple;
	bh=O35Z+GxicxEFnCVSzyl7cYoaf/7XaXGGKvt/g+NqZLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdkCyXv93raYLwCjZhWbXC7HfmUxfLirJMpRPovVzfDkz5e51RrEJfXTtKh1sSlIDC2e4Pi22tKfFLbi3mCn4jxVrBfwgWdOZTR7T8rXwI0hh88U3/EJguc6eDQvkMVLywrj9zvNnXFnTati28hIcXaBAc7UZ1Sf/EjVySVXXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BddmrbTd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70109d34a16so2400900b3a.2;
        Fri, 31 May 2024 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717196763; x=1717801563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/1/w+2qvpM05PxKueeUmEk2b81CeESoYWlX6Sv0NZ8=;
        b=BddmrbTd97+TeKlCESgP6FoJ839XPf/w5BY+vwW/EYNLj+B2HfNcuoFAu4yB0cmUrN
         RLCJ6buvcLKUVPs9+I0yBOQMYrseliGQLspDvPOPIFOBBzGIlPvMzrnkb46Z+tZZhRKt
         V7w4I3LUjk9BnIqvd7s5Ej0x0GwDhAZwZ8RMr1lqnzZ1ZYI4spJc16HYq1DWeDXTiV1L
         Ecs1UEYNy6WOUEswDD/Rvcj9/+5YLWQHiPBsUP99K5UP1ZEs+3V5xhrEi5g1LPLQZ6do
         PipYN2709cA73OtAo4vSoNxI5X+0w9cZzmqgs8tbfiu99YFe8x5V/L3odyjL55mE6y4n
         GOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717196763; x=1717801563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/1/w+2qvpM05PxKueeUmEk2b81CeESoYWlX6Sv0NZ8=;
        b=YcSuaQO7BoAFfEjnybwgA2p7gTsHDKl6b3UXWbw3HOyk/avCL6xyC5H+bBrbweK62b
         8EVKuyD6jAtj+qkaObxvx/ke8fVQN/5OBE7JnKr0Xb7cyTWk3mw4fhZxUcgoRn/+o8en
         BFB/whrm7WlvNnMVu8HX0uoRPRDd7uW/je2xoinFyPLtfrxwVbD3WrnV+H0h5p9MLVHh
         nNBGDYGa3y9J1/GDS4MY4TeRM87hxJxxTjHOa456Q8MAZp5h/Oq1QlEvrltkKnqro5wV
         tOzsK9wafbpInxTvIP+wljWbvfxw8ppnlOIYa2gELvijm7rA9HjQox/VgZuKEhJ+hD9+
         2RQw==
X-Forwarded-Encrypted: i=1; AJvYcCXZSKWbNIK9k4wPwowLS4be2H6PrJ4f3vODjoj70W+P0AkU8h0jraAZYWDRdTQoQWVVGNUoTkzODKry5WpOYu5IRWi7PzU5fqE2kJAN
X-Gm-Message-State: AOJu0YwrtgfcHWbK5p1zi5kazf3s90wlcnDWzBi00TIom+RY3XOK4Imh
	c3KAnjhnKcxyt91EzideSXw/nqGsL2IAjQSaMFnvEa5f9bfRM/fr7SjkGw==
X-Google-Smtp-Source: AGHT+IGmPkGewLx6fr/GPQQDemgJ9DbOHn0kMGdSyhINfj77xWhPsbH6v8h6A1CCP4gKxT87R1B63g==
X-Received: by 2002:a05:6a20:7284:b0:1b2:1de2:7dfa with SMTP id adf61e73a8af0-1b26f1b5be1mr3894641637.22.1717196762565;
        Fri, 31 May 2024 16:06:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423da731sm1871863b3a.61.2024.05.31.16.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:06:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 1/4] dt-bindings: trivial-devices: Add jedec,spd5118
Date: Fri, 31 May 2024 16:05:53 -0700
Message-Id: <20240531230556.1409532-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531230556.1409532-1-linux@roeck-us.net>
References: <20240531230556.1409532-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the SPD hub present in DDR5 modules.
(https://www.jedec.org/standards-documents/docs/jesd300-5b01).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Drop explicit bindings file; add binding to trivial devices
    instead

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 0a419453d183..1d19e67de2a1 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -168,6 +168,8 @@ properties:
           - isil,isl69269
             # Intersil ISL76682 Ambient Light Sensor
           - isil,isl76682
+            # JEDEC JESD300 (SPD5118) Hub and Serial Presence Detect
+          - jedec,spd5118
             # Linear Technology LTC2488
           - lineartechnology,ltc2488
             # 5 Bit Programmable, Pulse-Width Modulator
-- 
2.39.2



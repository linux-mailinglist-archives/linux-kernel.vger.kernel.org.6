Return-Path: <linux-kernel+bounces-226209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D44913B84
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127682815DA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3CB181BA2;
	Sun, 23 Jun 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIn7UbF+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47E181BA3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150372; cv=none; b=P9uRHJ9FnWvJMOrX0Y6ugcVrQFBwQnsO3NMRLYLCcwFU2nVk/QkLUuB2enAFBYBusQCws6jcOhX5bmaw5oF48pGrIa1qAfu9UiqpGzk0I3yeZOVdFFxCmr1N0jz1IYR1kClnr5t72ZYJRn0iYWLR4vZLxz2GQy5qDlsNj17TeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150372; c=relaxed/simple;
	bh=NYqg6/3P+7TddVSLmRW717IRWw7xTL+pnvhbB1g79h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qCbifsAE5lcRXNS53diMYJoe4fnuAQa7fForkEAf9ryyHXHpxwz/gFZttz0E3B5kLJNPbAdTiLO7yUd27LoWYv0tkHKvGRyM9L2mwiUZJDl7K+C0ROaR/hbMTf8A1iQ2J8s5kW6y1rUYvEi052aNufIGJwYi09TSxSS/kaJV3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIn7UbF+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421757d217aso38407175e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719150369; x=1719755169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFXh0T8jmdpMCtUnFf8OeqyPvo1UBrQ0gh/tN+ebFm8=;
        b=lIn7UbF+J789wzpMv4uNozDlwiIlFjBUfdiuH0hv647B5C9plh/3lCWQlt74tivDXd
         UVQLj0cZjd24fPRKBMH2FKDuYCBN1FhGZsietwi+dHJM1+4VjD6rqXrEFvm0J4xIQM78
         f5GKZHFQqOEaG4ShQOyh8PzSkJyPncQFzqaIzfdTsV9Pl1KctE0+KbtmaUVr7DeOYJBB
         MZ4hVa7azzjxrOQV9cn8dfbNwdBYJuWEdehOdxXbyABBIzmBmffnji8vEUrCOmcP+p+w
         +2XJ3br3SFMRpXYT3XWmsc94cb1QqCsBg7aLuwxOs7WRl4CQrxeZBbGSwtJpylYKnvNh
         vyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719150369; x=1719755169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFXh0T8jmdpMCtUnFf8OeqyPvo1UBrQ0gh/tN+ebFm8=;
        b=DNA7KBojz7LPU2maoI3188iCdNxNYGPm4Ym9uuuSfr8fAZyEHwzpraYMC0Z6FyTh4q
         8BCKhn8gijogYJSbj9WO6aNfIG5h7gW5ejYYzji3LX8UAIsrZpPc66yqkfLDAgK1QkzT
         pzVVHEACzAtnNsT1SAbS4Ig6gUUNsfK8q8baPqoBB2xgFRH8566PInACXVAr7/B/GSf4
         cImsHdsgBES6klKlUxl0sCYb6Tp4cQgPv58gktgttoi6elwlmG1xoGRVaxHKHCLD5MzR
         sXR3F2tDJnAdEb1/+khux9+4wbVMJGncygqpDU/ChoGikOsuXV4k6H3MBJkKLnIZvmAS
         T1KA==
X-Forwarded-Encrypted: i=1; AJvYcCXTXfIu3VGZLl9Otky+GEKc2gi43VVjeOqSDfmZ0taF+KGATX3XLGYUTMrJyxewOKUAA6dK8Mk3sPhm09b4ZN10C7/zbHAjlXA9RXVs
X-Gm-Message-State: AOJu0YybHtbw2ZbpbjYz7UwoJ0ymqBA+KViOCWSZF+fbbTy5Yv7ZF4x3
	My9SIx49BROiBFVHEoo1FSc28xPbwwEhd+dvY9GVMbuPWGrQvx3986jYWftv0YJkQu1zypZq4YX
	M
X-Google-Smtp-Source: AGHT+IFXPXNEANDdbhYMOtmHaRS+0tLkBiktJ1CuW6IKDL0N9pV3MUwOuYnxjF+iR0ugRvpLfGZMsg==
X-Received: by 2002:a05:600c:158c:b0:424:860a:d062 with SMTP id 5b1f17b1804b1-4248cc2720cmr16344625e9.14.1719150368774;
        Sun, 23 Jun 2024 06:46:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be9fasm141769465e9.16.2024.06.23.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 06:46:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] dt-bindings: mfd: Explain lack of child dependency in simple-mfd
Date: Sun, 23 Jun 2024 15:46:00 +0200
Message-ID: <20240623134600.115098-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Common mistake of usage of 'simple-mfd' compatible is a dependency of
children on resources acquired and managed by the parent, e.g. clocks.
Extend the simple-mfd documentation to cover this case.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
1. Rephrase the paragraph, as discussed with Lee.
2. Add Rb tag.
---
 Documentation/devicetree/bindings/mfd/mfd.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mfd.txt b/Documentation/devicetree/bindings/mfd/mfd.txt
index 336c0495c8a3..b938fa26d2ce 100644
--- a/Documentation/devicetree/bindings/mfd/mfd.txt
+++ b/Documentation/devicetree/bindings/mfd/mfd.txt
@@ -17,13 +17,14 @@ A typical MFD can be:
 
 Optional properties:
 
-- compatible : "simple-mfd" - this signifies that the operating system should
-  consider all subnodes of the MFD device as separate devices akin to how
-  "simple-bus" indicates when to see subnodes as children for a simple
-  memory-mapped bus. For more complex devices, when the nexus driver has to
-  probe registers to figure out what child devices exist etc, this should not
-  be used. In the latter case the child devices will be determined by the
-  operating system.
+- compatible : "simple-mfd" - this signifies that the operating system
+  should consider all subnodes of the MFD device as separate and independent
+  devices, so not needing any resources to be provided by the parent device.
+  Similarly to how "simple-bus" indicates when to see subnodes as children for
+  a simple memory-mapped bus.
+  For more complex devices, when the nexus driver has to probe registers to
+  figure out what child devices exist etc, this should not be used. In the
+  latter case the child devices will be determined by the operating system.
 
 - ranges: Describes the address mapping relationship to the parent. Should set
   the child's base address to 0, the physical address within parent's address
-- 
2.43.0



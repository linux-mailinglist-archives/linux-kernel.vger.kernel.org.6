Return-Path: <linux-kernel+bounces-236073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06491DD1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95228281A48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7912E1EE;
	Mon,  1 Jul 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRMqjdbV"
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC112C489;
	Mon,  1 Jul 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831185; cv=none; b=Nx720qsD/g3waTGDMm+3sMQRRe8Z1TYjAZG4y4EUZqDbymqJyAVkc1ilSQWB6gDwBW1JqRzDFJy3OA7KXmgyaCZXs0LAM2GQwnjQxflNxAkOxEOiiq2q/c/NwbR63RsGxUz5pyuZvvD6RQRzxJELlgQcSeHappoICwtTvTn4jxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831185; c=relaxed/simple;
	bh=h3FI4DdMzWtTJ4t/eAqQVFN6vogQHs/KHZtAjpX0j6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rUWyb/YET5Jww8zP1TgQzu+/X3RkeWjSb0dXfNOWXuD0J7YQ2QRmY9F4rx5bcurXYKLEORmWgqGwxTYwiZstOMvmmT5DuDntBAJvGn0Dzs2E1xI5P4lMon99ZnEOUYjULD6wKCdtso9D+MjrlOkBvYIE9pnKaDQ23mEIP2AHnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRMqjdbV; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3c9cc681ee4so1930041b6e.0;
        Mon, 01 Jul 2024 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831183; x=1720435983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njCe6+CvWxlUBbdA/hjLIinZuACUMkq7YSRJUSzqvbg=;
        b=mRMqjdbVjZNMwr6nfzxyMP416F7+zN55ERA1wQhOVb4g/z5419MZQ4c925XVfULM3t
         5pmbn2FPGO0jH3vklDzij6ltgP5Oyb9M1YsnEEDg0g8hWCC754euhg0JH5pL4s48CsSo
         bxV/1ZA+Ic0wGF2MgGhWYBgUsw9Bxhrb4yZa8zrsdZJWDaAomtaiFcaRJ+x3eawG/4UO
         ChDuCeLBHLE4mEao/XAh1HBlbchMxMQJy6UcSN1t2ABcc3nrOHvGnrsXnW3fZ8eNpfvO
         Kf31+RM8+yLLdElC57gqs9AdscuFK4P6+GB9UFaJUae0ndOGXd9/XYLlFlg5XJltdmG3
         kdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831183; x=1720435983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njCe6+CvWxlUBbdA/hjLIinZuACUMkq7YSRJUSzqvbg=;
        b=IhkPvpX8qK6sMMc67p/ebCa+ALtqNjAo4pqJkjgugvjlEz16KVc955GFTohfyfp8/M
         4PcYcbWjSUMv4NEZwZitJOJy5JkhqIArkRxPYSyGPvEHMU/FU2n29J9xYdLKlrQfrMeW
         cXruh4gydYT7KBvx0VCpw3kvmOkhRQYwGljfMInGZPjsZZeEuae4YKTOnh3O/KMKeigD
         txxVUYZ/tDdQP5SFQN6aS9SEpp3PA6OxeLjQSGZR/eT9O/DDlxeDGTl8KH2MeHxNEDJF
         HhvCO/knwe5fldtSlNjPniYbYoN9OQewuyeKwAB5NoKno5A8tR1Ogl+T5RTnFiKzQwsP
         VK2g==
X-Forwarded-Encrypted: i=1; AJvYcCXsAepic9siaDUwGBdC4vPlKr9d6Egt/X0Eo6ekdHgq0L5fihSN9sF4FCclaElMj1mXIkgSrqw26bgLZycH7+tjVKK0TKQKMjNxg9il
X-Gm-Message-State: AOJu0YzkFinbMlOkKZj9A/Ozzm3dRQqVvAX4wAUM95Q248G8SJS70Ij6
	TSeJZca2lcltc9m85VRzKkrDK0w0LmmIsnt9PDZdb+yyESCBQRA0DVQJb0avAtE=
X-Google-Smtp-Source: AGHT+IG4c+IvrNyBN5N9rJ7s8WprtnzHujQLxXzxZpJmwSaQVdM0WGsZ2i1kl1zTbLXjd2sxrnmEDg==
X-Received: by 2002:a05:6808:1393:b0:3d5:63c2:17c1 with SMTP id 5614622812f47-3d6b2c1ebb3mr7720558b6e.8.1719831182871;
        Mon, 01 Jul 2024 03:53:02 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802564236sm6185399b3a.48.2024.07.01.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:53:02 -0700 (PDT)
From: George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@ieisystem.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Subject: [PATCH v1 1/3] dt-bindings: vendor-prefixes: Add prefix for ieisystems
Date: Mon,  1 Jul 2024 18:52:57 +0800
Message-Id: <20240701105259.972135-1-liuxiwei@ieisystem.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a vendor prefix entry for ieisystems

Signed-off-by: George Liu <liuxiwei@ieisystem.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..0ffa8d06aea9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -609,6 +609,8 @@ patternProperties:
     description: IC Plus Corp.
   "^idt,.*":
     description: Integrated Device Technologies, Inc.
+  "^ieit,.*":
+    description: IEIT SYSTEMS Co.，Ltd.
   "^ifi,.*":
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
-- 
2.34.1



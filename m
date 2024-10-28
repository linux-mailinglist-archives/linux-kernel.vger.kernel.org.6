Return-Path: <linux-kernel+bounces-384453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B499B2A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568FF1C21653
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761A192B94;
	Mon, 28 Oct 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="nrl8l10x"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A3191F90
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104098; cv=none; b=B51SyTrvRrLdQqBNAwtwbZrziX/msc/GXHwpS0tS2LZdl8BMs4lLYwvgCcHHqBSAopiYj0nCrYUHu85RdZbkqp6rjuizIJOEzwnP4TvX7JGWwd5Hl1JRpvseAyU9tOMVJHNzsUgHedsJr49ClaQEtpwTQWGjzcw/KI7ALI2DW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104098; c=relaxed/simple;
	bh=0pfJecxT1M0oO1SppP48VH3pXQdKQ2tBolbB4llt/iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLfntQZQl6Py+2PIgwnrnZI2odHJpjTWl4k9ESNpDQlROnW1YQK9OQDdZK6ivM+7OaGU8Gb7E1cUhyxzmRyBwe3tG/T9FWKEYtX1cj1TU5uneOsLkzffGn4vdCVziymVouehQwIJ/YA+mjSb7EZbOGv11YtenbQyQdHIAVQ3eIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=nrl8l10x; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72061bfec2dso1519930b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730104095; x=1730708895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqXCN/PxPQRRYnCXep+m11qCzkhu9vZNihUxCEwHTfg=;
        b=nrl8l10xCePPHGK7aVKUvrQSzTa57nMNiB/pqakWZDF6v/Qf3SQGsS5cwbgHwldbgx
         US3Q+iW3MBgwaw2aT/j1zqNj5tQZAx4ccoBK5hZxFLP3l5G/B7/l/uFvZfx700v3zUL7
         rtNk3rxX3IV1ClmPmpzp3LHLRYAuV9aGF6rn9v558PXH/hG1ba1RBjkiruEZRd44gJKF
         X2670mZpDlibtcb0mWQpCwkSy84qjSr1x+pgcxthUgG6H/ARKGyNavYot1vHSgDbtITn
         TfO0QWcTf1ws58aoYqPBlUflAnjn5RjHymzEphvDkHjOf/+H/5bTajqU5KcRGE/MRXD7
         XO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730104095; x=1730708895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqXCN/PxPQRRYnCXep+m11qCzkhu9vZNihUxCEwHTfg=;
        b=i5ImiUd7xknjQKExW59xuGNBuvdRGo0h5SlMZ/0LKZYIXBukQvurlgr8OvXdF/Dw/7
         1ryvvwAoCSrPDrFZ0nNwE/a9+AfauHe7LDvzpJ567GPe5l6sMegW3NUuK5pidd4u3mvp
         87qIacP8r9C2dS3lvu8ZNe/HkjLXv0dr5sTUUi7Q3HT6hvcHGeCNobScOe3AhnnR7bZB
         cLH82t9281VU+FErr1txvUuPTOHOk9v9ayOs9SfEV5BVFF6lHRgml/mdLLkbrnaPwy/p
         2/ViyUnluJiNJnJ6bIi/MXswQzVp2Ad4Cn1vctf3QOJCwbZSNn8WbPe6eoL3WXtdZvj+
         nYYw==
X-Forwarded-Encrypted: i=1; AJvYcCUtfqaV8n3M8V+lJN921179YOKvogZ4P/OQxFh8voO6+RKcjF+opYRiiCSJyHGGOJVvlAYumN3bpsBEDTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3pOPoXDTUQ1QaD3C3691t6mFdnwyHUk1qegi0SSzLuO+k+qh
	HzHlhTVvUjnSo/qlQ4/wLZeU8WExhnZVZmxPUSjbflT2MXoe/mUaOaKOGTfOgsU=
X-Google-Smtp-Source: AGHT+IHZq0hWR04lWWSn4VEvShFoeXQ4WUdujwmai4DH9ODyeYFBL8qZVtGaYzDQnQwGj4MtLa5Yhw==
X-Received: by 2002:a05:6a00:84a:b0:71e:3eed:95c9 with SMTP id d2e1a72fcca58-7206306d443mr9996199b3a.22.1730104095411;
        Mon, 28 Oct 2024 01:28:15 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e451sm5195419b3a.24.2024.10.28.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:28:15 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v7 3/5] dt-bindings: vendor: add deepcomputing
Date: Mon, 28 Oct 2024 16:25:51 +0800
Message-Id: <20241028082553.1989797-4-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028082553.1989797-1-guodong@riscstar.com>
References: <20241028082553.1989797-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sandie Cao <sandie.cao@deepcomputing.io>

Add "deepcomputing" to the Devicetree Vendor Prefix Registry.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
[elder@riscstar.com: revised the description]
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v7: No change
v6: No change
v5: Removed extra "From:" line in the commit message
v4: Updated description
v3: Add Krzysztof's Ack
v2: Add deepcomputing into Vendor Prefix Registery

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe..f8bb3df65797 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -356,6 +356,8 @@ patternProperties:
     description: DataImage, Inc.
   "^davicom,.*":
     description: DAVICOM Semiconductor, Inc.
+  "^deepcomputing,.*":
+    description: DeepComputing (HK) Limited
   "^dell,.*":
     description: Dell Inc.
   "^delta,.*":
-- 
2.34.1



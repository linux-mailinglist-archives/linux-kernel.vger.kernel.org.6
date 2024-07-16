Return-Path: <linux-kernel+bounces-253818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D1932771
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5644728257A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64919AD58;
	Tue, 16 Jul 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0kHqhkH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2C19AD4F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136455; cv=none; b=qF/rYntoEkD68CBZCanrKo716KMUdIRs/FIExS1L0VSAE1mO9pBVkUVKmIhW0xVzTckF11RMg2zfmhm83+cC4CVZIGgHWxme9LSFp7YAfYgaJ/4HWpcJcD+Foy86B0w80kqqzKXEGC6BuF9+ikTI3d0YfG6Z3uAGk9BFLsgBWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136455; c=relaxed/simple;
	bh=L4q/f/OtWa5M69YBoQW2fcIKupxqZNLZsMK3IgdJdtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q734FtXzhkdn9eFPt22SUPMjQpFYUaKqUbvHkVQvxk4/cq1ML83R3FAlDbLs/z/6KZYWqSG48fS5tRKydi6ZZ5yXEGr16XE1xNnHhTYiNGGhXiozNQiWjt+m1vvZ2UtnEFe6gN0+9jCQqmYB6o3rjW7aSixpV+i3nQjBWGdBvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y0kHqhkH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so35329005e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721136451; x=1721741251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8nnUYNlwO0k6ZBjwD5Erccb4E+P924xRgxG4C0KqEnM=;
        b=Y0kHqhkHJN2Ib3B04DpFvaK+tBDfaTUazQrgEW5O0Q338nbodwMT5MyObQeenFtca9
         HdvTbXsbxCYzC+yVeTmJmFYBprsBFWEwrrI32wfehQe5iiEHz6KND7Hi7zhsr97koO/N
         FH1Tx6fbdz/vnYQitxM2gGIOW1hefV9EYjJ5oEBVkElMNsPLeY2P1TKu9qyydzHBP7+y
         T6cFjV6nJWdh8DnQ2mlHLp/cLvwZ2owyvmj5xOQCag9UcPglrUnXAC7jGGagTM6XvgTD
         HE71gjWuO5tW9q12FHF8HR5zRM+Iovr8/lOoAn5+GrCIg8+5+noi3EgfVKFUB6Qk8FiV
         a84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136451; x=1721741251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nnUYNlwO0k6ZBjwD5Erccb4E+P924xRgxG4C0KqEnM=;
        b=A57uOrVh3ZCmfV2EhYRQvV56c2V//H3T79glKKQ2eWzWDBUVj7U59wm274CRN233dg
         mY4fZM2zkJuIFeX3bcgo5lGMjd1+4ELYOW2fUKXbW+Vm73itz+H3lGdqmRdt4lRw8s94
         xtZYKsGdPIeAPcbuQi1Fg6G1BY8Iy8BvQ/N+ABJmsHl2BM+Cf8RUamsdg2cG1405+jKg
         ZMB249n7y2vUne9g+/4ypuf9eqgkyDygRfNJ5DQB+cJQE4fOL0UFR3KXABXBWU4ma3fs
         7M5BCMYiptuA+w5r0V1LzVnxanznteky+E49rY9jPgP/uAvArx2s9DkcbIFS6cCPjH1V
         uDLg==
X-Forwarded-Encrypted: i=1; AJvYcCVgoeUVrJMo3kofkVo43AQYPd3vBRnWoO6GBzFQRaqkDyPa6HtVl8rYsWAesVsjusTZM5xus3hI3E9pvXpbQUjhHcPx8MMydNuQ20EY
X-Gm-Message-State: AOJu0YxvqAWAD8oYtVTLNdAKp4dzdEHUOnnr/khUDz8ufnmYB91EW18Y
	2qPuvtyJfc3dhnAatd/WITloOhVR1kUD7mhruD133kiaFJlJt/T+MyZj7+L3R8E=
X-Google-Smtp-Source: AGHT+IGhqCHFIX7TkLPtIRTTvgB7kbFHYhFo3zMfT1v/DCloAtgq+4vAX8iGpdJXs9kK8D9hqV8L0Q==
X-Received: by 2002:a05:600c:5127:b0:426:6099:6eaa with SMTP id 5b1f17b1804b1-427ba6dbd32mr13126415e9.26.1721136451525;
        Tue, 16 Jul 2024 06:27:31 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc2efsm163985725e9.36.2024.07.16.06.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:27:31 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: magnetometer: bmc150: Document mount-matrix
Date: Tue, 16 Jul 2024 14:25:09 +0100
Message-ID: <20240716132512.80337-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the mount-matrix property, which is used in device trees such
as msm8916-samsung-fortuna-common.dtsi, and supported by the driver.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 .../bindings/iio/magnetometer/bosch,bmc150_magn.yaml           | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
index 2867ab6bf9b0..a3838ab0c524 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
@@ -36,6 +36,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
 additionalProperties: false
 
 required:
-- 
2.45.2



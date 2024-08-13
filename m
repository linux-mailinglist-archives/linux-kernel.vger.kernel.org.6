Return-Path: <linux-kernel+bounces-285370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73432950CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEEA284D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F31A4F0E;
	Tue, 13 Aug 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RX3y3c9C"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBB1A3BDD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575519; cv=none; b=dnyxCZ21oD1RPuDyvqCIO4rhSwooQzjt8q/hCIWOwe3pl9XNd9z2Zm5OKbR4EfSbwIH5dLNi3FpRcz1qEwzUBlZCZzMyVP0fjtUkBPK7lrdfhpDfNRUC+asg+FYwz4ZKu/NxBJy/fMGhYZ7qh4vv8Q0MohRHIdiYq7TD0exm8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575519; c=relaxed/simple;
	bh=VjVpCXhdprY8yAPr5q1xpO89FnUJgWu9bWelY/MfREs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNuMwBhEC7nduyUaOtuVe95xbH1uqb5sOPDlEI4wcOPIgEfNLjlh+dRn13d8u1dTlHoSP7m/QcbPwHkuqdhFow8X+5beC99c9GBgVXezrCyB2I77mp7hJ75A0tKAUSwemZbQIZQKiQdOwSVuKGjD7bV7dLsP1MfW4dFq89tRfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RX3y3c9C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42803bbf842so57923175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723575515; x=1724180315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=etIaN+U0WiI8zpIpI/yy1cpDhwtG331HdZOmJAhsY+4=;
        b=RX3y3c9CC7MM3b8yE7dP3UM+1EXDjXChm8geasOX1oOvPdYRIzeBEasfHPS69VrwST
         2iBu6+Uq7MsqaD8KI44SI3/MtXH4JXaTL2wfyM/j4Bqey8tIHDQ8CtsF+mE1coxdqimR
         4gVAKgGUQc+CpXIjqv11OEzuVCar1I3YlbyVWELt+yW23x5nTTmvepqRP50bsrGsreFW
         rxbsmffGh1Rvwfb3jlHqOcBJYXElgsZ0KLwk7SEsAh3FHTB/RCWlKTFI8v1EjyE+Y/aK
         vBM56Q64dGjNo8hki/mbtPpDNrXIZe8AfPFQrXtRnsraI1C+OiTQRKFU+dd5YuLiGLFn
         QIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575515; x=1724180315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etIaN+U0WiI8zpIpI/yy1cpDhwtG331HdZOmJAhsY+4=;
        b=l/GobkyS6eJntrvnrdP/I6Mh0/nKxt3kJPut7VNMheiiPwieQsyjflC/lGZGHcVvou
         WXnp3WYfQPXHUTb2yJimjPDvezdxR8zmWwbt5rDc2SEw59qme6X1WS8a0awl9yz9GY6+
         9MtYPdjU4Mm+ZfkZ3zz/5d0hFd/w6NjZLvs8dLuZHn0TmHoi1aUXO4ThgCX/68noNkJf
         YD62PRznumkb0kqTUI5tOrE7F1wqsiFUvD+cfnlALcCO6zAF/JfE+Jx1OEGHncUgTlvU
         BJyU5v2VTfEJZk0Q0fl8SvSh9YjrgAAUW9zLc+lCOE+28MsZ0IAFoeZalFEbaE+HUd8J
         HaCw==
X-Forwarded-Encrypted: i=1; AJvYcCXN3SSt/RN1g+R9hVIG4xJOh1Wk31etj2mgJ7XtmsF5k8lRjpogtzN4Agh4ilHh7uOgg2ShpL1wM5cHNnJ8DIjw5GVV6QsgdzM2RQbJ
X-Gm-Message-State: AOJu0YzQVipmZ2yxyupuv1+Rd+GoXa9WbiGy89gXY6ZHFDsozIVgByBt
	4YJ46ffIHgpRiNewpetUN1oTcGTKHN0fMlOc959mNHUakVWoX9tNZmPggGDrrig=
X-Google-Smtp-Source: AGHT+IEy/ZjbXzN9pK5GQhzOFuJMOZ1u7SAEu8Uz+qQh0Yk2W331GPyCG+wCDY1nhz007Yqf/Ab8Nw==
X-Received: by 2002:a05:600c:4706:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-429dd2365c1mr3967065e9.11.1723575514278;
        Tue, 13 Aug 2024 11:58:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c509sm151208145e9.44.2024.08.13.11.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:58:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] regulator: dt-bindings: qcom,qca6390-pmu: fix the description for bt-enable-gpios
Date: Tue, 13 Aug 2024 20:58:25 +0200
Message-ID: <20240813185827.154779-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The Bluetooth module is obviously not an ath11k so drop the word.

Fixes: b5cb34c93bd4 ("regulator: dt-bindings: describe the PMU module of the QCA6390 package")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,qca6390-pmu.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 3aaa9653419a..ce7771f9fa36 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -65,7 +65,7 @@ properties:
 
   bt-enable-gpios:
     maxItems: 1
-    description: GPIO line enabling the ATH11K Bluetooth module supplied by the PMU
+    description: GPIO line enabling the Bluetooth module supplied by the PMU
 
   clocks:
     maxItems: 1
-- 
2.43.0



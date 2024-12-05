Return-Path: <linux-kernel+bounces-433822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45C9E5D85
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A23B2855BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAC7229B16;
	Thu,  5 Dec 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoCyBSCU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCA226EFF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420506; cv=none; b=CUyrPM9pg8y+nR/UbaTkQIAyX/1kh7cBkXMhJQnECves4kYT7azGD6osGa9jb/N5JGNQIpiwsVJ/65EulBRaumRz4YOo9rpMiOq7srsxbXInMbWn4WslvIXWwvtYJuss+HIJwwBh8ooXaK5gtazW29oFyQAGTnvjbRnjuDRPBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420506; c=relaxed/simple;
	bh=xXPiygVHodTqiKWiUOsE0uULVZtvJJ1/Xa366WcUIss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAH57PSLLK/NwS6xPRZb8fO8DZNhHt/3LMF5N2UtaP1dwSDKiEyo0Odeh+1VNL8eKjEfISqbDaYXylJ4uTEIBNvM0SLVGoxUeIIV1YIllIiMkPWFwL5wW8bigNKkcx6G+8BbyhnMOoMOCw0WwAS6xyq53imyMC+OhX5PJnCLACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hoCyBSCU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349fb56260so8531625e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733420503; x=1734025303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKhrlzK7pKMmsPY9TXNGvHHUZJEtDgIZ1kDt6TVOg0Y=;
        b=hoCyBSCUaa7B5i+frE52rQ8fgIzcpSk8Koqxe5fuGzIXJBy1emI+qFfO+8l3dS4i1A
         HeJSYgZ/RP8ibDf4Qrjn+8tQ3IKCc92UQqk1XwMGT5KBcXt2n7fL/txkL4Y8+xDi2825
         hi5ElMVngRN9O8TgOEq+S68vSSchHUiwO/Mry9A6q4+ztnki3sl7o2e3t6g4dQnPEokG
         XrxfAkxpzxaycP5G3bD9pUqYAXJDVYW5Jsf4XzXuZt9/vYFEBwdak42HVeu7q/TRRquE
         /zJ+hxLR9ZzVmQX2J0zdB2Tk1CqwZuZ5eOMW6h1lKGWCzFrwQa8l8d3Txl/xYAhVyguU
         uB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420503; x=1734025303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKhrlzK7pKMmsPY9TXNGvHHUZJEtDgIZ1kDt6TVOg0Y=;
        b=BCCFwDeKLrdg233jXy0GgiZaQydY3eZ1+qJW4/FCp5BQugr+j5OTlTLwLjSTsKdxEu
         d6c1jYkOp5HzgK/jHfg0NsigaNmUJ2wQf1uwUAdsfMIq9bsLfCHCkHF4KQsT88HBnlya
         U76fG95jSP9lDEqBMqF89i8T6qpy16gvRDzgc0W6ZuJrrksk2l+EHrUPu19R/hSlJDgO
         5Wa2NJHqAbEW6OGGBGCLzhHdjAZ7NbxfrlJZ82EWRmyqnuFH1nDIZGSFKbK3ClMrXLpE
         xkU71gAf9ahIGkoGMEl+fSOhhKxXb0VxB9EpLpGejFynS34wo4TB7nnSAtX9gsVA6FRo
         5kIw==
X-Gm-Message-State: AOJu0Yw3xbXodhoLdXK9az/IuHTUG5bJozT/MtGC174aOgzjtlyYVvbw
	WFgzfuAnocq4n6xabz21UqDTw3zx2qaIm+Nk3Flgj2EVhg1Ev7JBadnhoO/doRw=
X-Gm-Gg: ASbGncu+SmJPVzZTmGd5stnqbiHFl8V22qdUykcmG02xRKTCxZKf8wkSduVhkxQSb9S
	FDNIAxbtlHFNi+W6Y6e2rmN80v9UxiUlVQsVVZPeWUujC5TN5JBGn2rwrGivtCF0KVctYaMWjnJ
	Ru2gfxiC90loBx4pV9POvwVZ0HkT9Rmu05Ttn3knYpVmCkJpmMcEYt7PSkPN6g413WqAGurI8i4
	Y+e8ikY+0v1+HGDrnQCZyYKYno4NWOSoP0ydJEzmGrkJp0uaQK4Kt/z+J99rqGfvyARmDOTdWWD
	3LOvDp40+aVxb76Q9f6dnYrPs8gNjQkw
X-Google-Smtp-Source: AGHT+IETTIMwCAt1THUCSfAIoi1qf9ZFSIPgjGWfgvAXtjPszoHVRLgp6w2ts+qYW08bZrcEVzFXEQ==
X-Received: by 2002:a05:600c:350a:b0:434:a7e3:db66 with SMTP id 5b1f17b1804b1-434ddecfe72mr1375775e9.26.1733420502746;
        Thu, 05 Dec 2024 09:41:42 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d6961sm30318525e9.12.2024.12.05.09.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:41:42 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: jassisinghbrar@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for samsung exynos mailbox driver
Date: Thu,  5 Dec 2024 17:41:37 +0000
Message-ID: <20241205174137.190545-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205174137.190545-1-tudor.ambarus@linaro.org>
References: <20241205174137.190545-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add entry for the samsung exynos mailbox driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..41a29d1d6e4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3023,6 +3023,7 @@ F:	drivers/*/*s3c24*
 F:	drivers/*/*s3c64xx*
 F:	drivers/*/*s5pv210*
 F:	drivers/clocksource/samsung_pwm_timer.c
+F:	drivers/mailbox/exynos-mailbox.c
 F:	drivers/memory/samsung/
 F:	drivers/pwm/pwm-samsung.c
 F:	drivers/soc/samsung/
@@ -20712,6 +20713,14 @@ F:	arch/arm64/boot/dts/exynos/exynos850*
 F:	drivers/clk/samsung/clk-exynos850.c
 F:	include/dt-bindings/clock/exynos850.h
 
+SAMSUNG EXYNOS MAILBOX DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/mailbox/samsung,exynos.yaml
+F:	drivers/mailbox/exynos-mailbox.c
+
 SAMSUNG EXYNOS PSEUDO RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-crypto@vger.kernel.org
-- 
2.47.0.338.g60cca15819-goog



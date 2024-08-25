Return-Path: <linux-kernel+bounces-300366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C095E2D5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 11:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B70282265
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074B6FE16;
	Sun, 25 Aug 2024 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9JhP8FM"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF24F602
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724576460; cv=none; b=iW9sjFoBbexHsb5HVH/YZ9i84+XVV6znC1RVSbC+ZkvNpuG6NeKZxz61qAU0LSIiS5kPvMj9kXw4Z78EawvOwLuSw1DQYqkPvyKJKEwaiKHLSi6bOkE3+x90E/GAYjRQbF/T1HVAr2TjmJ/deG+At6qJdWGYUbObqI05KzafFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724576460; c=relaxed/simple;
	bh=zPtjJAHCcjLGpjo3WyxKQTDsk06tKU7xrLNNHU1rVLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drgapkiis19UTg4CirlTdDtiLdnNV6vSG8AxanjtbR0Vw9MIL7e9nKOJFZtn6/hwkqQB9iLTu6VXDGnDY1bLQvNv9en1LBC8NHSAg9BvoHt9r/LGIxFfp4cIQJHnxnJ5xRAlvlJ0VOwyU1Ee6UBqkDeiqKngPITp1sXAJ6x55hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M9JhP8FM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368633ca4ffso508753f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724576456; x=1725181256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3n4NDcotA3y63waYC9ChSZVHTLNYfnqOEMaVdu0sMbA=;
        b=M9JhP8FMjlF2apUeaNN8juMH9Cf7KhlaebXoQygh6FNjJb1K60K5K5rJ74QFxC6cwy
         h8YsYlfwb+b93D6/ikPxXLqtSyu1HBrQhOx8sAWBXVnfNHzNH1bhlYzWjvh/+amvU1NC
         ieFPqwhOzsYZtfRuuYcxuhUQx+OHNaWZNKwe8rYwa8ghzn35GTSNIUt5BUHfNAkFsA4A
         SI8xQUJiBYb++Y2AJuVa9y7GESdPbivJxCEIYNmyNz/TIxoIQERxksY5RD21hJWoKb8O
         sRGEiOZkTzNoddVTN3+MLsv6ND4iyQbiTSN6IQmL8zUZ0m+HB24rSG4t0hFXDC+MtcdU
         lEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576456; x=1725181256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n4NDcotA3y63waYC9ChSZVHTLNYfnqOEMaVdu0sMbA=;
        b=eHS5XTg6jQGK2pDEosPMb+bOOX8ND/aKy8A2B/HPBsvGw6dISYjZqTmrIZu1cYUBXY
         9NFC5A+S905VzRdAssNLdXneFau+1E52GdTcYgsOz9KRCSPigp9g5F/cclfR/7iXlHDo
         MFmnt0TQz6fIpautOfcl4rYZf8sDHJx+EeJe2WDtxzSX1xsmX0aUPV84rp2IFcpByXmG
         8J+xNaHDtKAXM0Q9ZBGI2qh2RstCHWfTBPw1kxfqG+72WnHVJ0kilp7w4j5xJKE8fAE+
         x+OHWAqtbtEl1JhJ3KXWdxkMOr2bSHTJv84dnZ1lpxjv413BNTG1pLOlzE8x/jErvnLX
         LJug==
X-Forwarded-Encrypted: i=1; AJvYcCUqFRZmNVs//AqyBDkJQONFzQrnSH1Ke6Wbp1+FzRwSO1a0dVoDU4WbKTGCOvv/cs/v7JXvhRamjBCQ+Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFw11Hx1O5m1rvLSM9xJnUXru8qC8FJVQjAY6v3x9htHepKr9
	7qNtz7v1PqVmAqOy3wqgusj+7+Kc2TuZhs0dx+TijAFU44rj0VL112vTgkLd9Tw=
X-Google-Smtp-Source: AGHT+IFM5MEyUzYaYhlWSvMHBGsJqUVqINFe9O3P8umMlD6v8D2dpc5UOtJx+T8nsUJsdyoIoUZK5w==
X-Received: by 2002:a05:6000:154f:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-3731191d5c5mr2656753f8f.8.1724576456307;
        Sun, 25 Aug 2024 02:00:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308160586sm8237298f8f.58.2024.08.25.02.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 02:00:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: MAINTAINERS: drop stale exynos file pattern
Date: Sun, 25 Aug 2024 11:00:52 +0200
Message-ID: <20240825090052.22135-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With last TXT binding converted to DT schema, all Samsung Exynos display
bindings are in "samsung" directory, already present in maintainers
entry.  Drop old "exynos" directory to fix get_maintainers.pl self-test
warning:

  ./MAINTAINERS:7539: warning: no file matches	F:	Documentation/devicetree/bindings/display/exynos/

Fixes: ad6d17e10306 ("dt-bindings: display: samsung,exynos5-dp: convert to DT Schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 028186bb4e8d..c75918994a53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7536,7 +7536,6 @@ M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git
-F:	Documentation/devicetree/bindings/display/exynos/
 F:	Documentation/devicetree/bindings/display/samsung/
 F:	drivers/gpu/drm/exynos/
 F:	include/uapi/drm/exynos_drm.h
-- 
2.43.0



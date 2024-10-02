Return-Path: <linux-kernel+bounces-348199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180398E404
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8C1B242A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F834216A20;
	Wed,  2 Oct 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y88Q97yT"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B7194ACD
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900176; cv=none; b=RDLqLboibDUzlkv4jJHpxH/CdBcdTcEAgmWmcVqzcsAU73qp0s730piyHX4AUALxhRYUwk03bj+w0TA5r7d9SyNoP+C8WM5q4lqgC3UUKAWYaFZFsFjokE19E9RQ/uoKwbcNF/Qa3FJyJGrYEGF038dzZf5ymkGerfx5RNZGxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900176; c=relaxed/simple;
	bh=sx3hF4SKRW9J0+Hapfp4C+o1lNWniAwqrM7MUiYK3nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMI+sOlAInACO1p471BwHXrIcwNJstQAvHrDHPOuFpXah7SzZZdBNg0uTY07jzBDmvFFIRxIC+cL8+SyvsDRL98so0o/hkYWatsd1T6CKom7jgj9bczWTGmb/2j9gteKbnDvMXRRtjFwXiMqdpQOEZHVYWF/GH4lJa1qfz/eyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y88Q97yT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so153125f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727900172; x=1728504972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2gY7cgnLDjYMtByivBu9ewLraOBL1gPfpCgKRNDFNVo=;
        b=y88Q97yTCYWD6YGrGHaHB9BKvdlHLy4bsw9SDSZbZnC2uPYAw3aSW8AJRCrPNsJ7at
         cjqkouAbdGoXz7EY6fGX+SXgdzrDbQJ+xDGAdBieLL77Uu2PKMFvZq5I6rPnOZrWHOfv
         UI3SBT+XFg+F2OYUavyuEVuzWCb3D8vUmfbkjVj5M2QHlXtk2BTIB9KS9Ktq7Ck5d07s
         h+IhJS4yO2PNzuF1sK3PK9cp3P8bRxrXg+H/1fmrAr++v0DCV226KNxx3WoQ74y+n2ae
         M5K3RKsv9ARFT0LPpMAEz3jDG+VfT1Z5EJ5uY58Z3BmpziHB1rv+i7QtWSw/m/gW3Cd6
         MF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900172; x=1728504972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gY7cgnLDjYMtByivBu9ewLraOBL1gPfpCgKRNDFNVo=;
        b=bmHQ9QX75beHHJidig3w/PF+iB0gwkLapI/55NSI5ks9AFr/AhRiAyqPk5HZuNv6KT
         gRfzuyCHZJ8t+M4PNWumpofmPTfX/hy+Hku/Yb7t4q7JfjEUnfU0b5PyCneX+IuLhgKm
         jxJ/NCAkjuijpU/CXkKdqaFIWzUloDMZdy9meeZVUPdQA/bejaCVAz/ByzgaL+qq8/Ho
         J9jD/gmLnsyAfcOkOFf7GIWfHlFMiT7flrcwDUYi+ooLmDSTNuY6YsLXn2ymQ9bXmzNS
         mUYARJi8V1gad2Mno1fEJTe8iIrM68innRSjBuqr/CfMkdSLAaQvJjTYAxoEIY3MRMTg
         yNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZvlqrkL1kDR5gEoCZmO0KGgX+DYySzXk/UkYBcST6ezFI1JdvFQLYlF7OHsv4DPz9MaIOu0gQ2VzPy0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21ZHL+p+vQ/PdXcb3GDL1xw957iy4YbuYx4NcZPAw+LewPEob
	kaLz0b7nGE0OWEIAbL5CkM/9Iybb3geOkmEd0RpCRL5HJyX9xo0W9gajKHwJVaE=
X-Google-Smtp-Source: AGHT+IGhYj/A27bQGsUEOm42j2NO+1J21Z92LR4K77UI/ry3eizF8aKxTBJVM0F6v5v89gUQbiJYYA==
X-Received: by 2002:a5d:4603:0:b0:374:c3cd:73de with SMTP id ffacd0b85a97d-37cfb9d4418mr3809189f8f.35.1727900171931;
        Wed, 02 Oct 2024 13:16:11 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.66.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d2e8sm14850600f8f.18.2024.10.02.13.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 13:16:11 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: vkoul@kernel.org,
	kishon@kernel.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com
Cc: tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 0/3]  Add phy support for hibern8 enter & exit on gs101
Date: Wed,  2 Oct 2024 21:15:52 +0100
Message-ID: <20241002201555.3332138-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vinod,

This series adds two new phy modes to support UFS HIBERN8_ENTER and
HIBERN8_EXIT.

This is used for UFS phys that need to program specific values when entering
and exiting from ufs hibern8 state. Once such platform that needs to do this is
gs101 SoC found on Pixel 6.

phy-gs101-ufs is also updated to include these hibern8 enter/exit specific tuning
values.

Note: a separate series will be sent for ufs-exynos driver that makes use of
this new UFS phy functionality.

regards,

Peter

Peter Griffin (3):
  phy: Add UFS phy hibernate modes
  phy: samsung-ufs: add support for HIBERN8_ENTER and HIBERN8_EXIT
  phy: samsung: gs101-ufs: Add hibern8 enter and exit specific tuning
    values

 drivers/phy/samsung/phy-gs101-ufs.c   | 31 ++++++++++++++++++++++++---
 drivers/phy/samsung/phy-samsung-ufs.c | 18 ++++++++++++++--
 drivers/phy/samsung/phy-samsung-ufs.h |  2 ++
 include/linux/phy/phy.h               |  4 +++-
 4 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog



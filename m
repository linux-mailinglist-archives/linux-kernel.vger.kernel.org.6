Return-Path: <linux-kernel+bounces-239044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9548925560
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0041F238E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6256E13B5A6;
	Wed,  3 Jul 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yak2zSTk"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2221B2629C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995452; cv=none; b=IpipHPX4ToLHtKAr6tqymme6TBwPjr6BflHIsNgT1OXgsLG2zdLfgCQs5OTS8w7u/SV6wN4qEBvKolX4TlMS2I7zAwu8SddCqn41n3z+XnNUwwS2D7TVtrajdkq8sh5MbMzQV4H8Sfqc0GXfUbQiAs8LYveebl42vpHMfPeV89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995452; c=relaxed/simple;
	bh=YCkB2dsIQT9Mudg5Bi946hYIraOO22Qh7YEirjNCxZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBx4HGJMgZxkA03csFq+9gQivEo2uBP9dcBjcOK+LzleXFd9OtmAmcxCZdoIO/PiZFpxf4dfnKI1CISJvtMjf8BIYEpwsH1K7g2Q1J9abzGE/Vpx9ye4/x+sw1aLlNcG/zB8U02GPMhdkIhtelcgHNyXLfVvoD0ZJlPGL+DnGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yak2zSTk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36740e64749so3116780f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719995449; x=1720600249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J3Shn5KUyZXIeL5OTQ6GxMPgh/rauLT5ymDaJi6mGg=;
        b=yak2zSTk8d3cgvenqLFke++LshGRiNTIZj+oXpx2dnBspjjKY8hrKVhCLRbyKcyBtE
         +2V6TwGmbQI3qRbZ9mgK+7k2Rwl6px8Ca7l0k+ANkISNDDKdT2kbGj1j4j247oq3Ta5B
         DhzcHunWIy/2sKtJvUpFjQvTmM4rkEV3zPDdJgwUfhE7TB3dJmlrVgNf8UqjIthre6o6
         BKt8ipE7kqMvrjoBxZm35zXdJSYj9YhA3q67y2iELwiKTrgH/VD8iv4dMFMYw05ws2vs
         9l+2zrOCnzBO0xnZSD4vAt0CSSggVVpWNMXXwRahOJgRO3RMMc0Nqb8lgz3cZGBGOkba
         NCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995449; x=1720600249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J3Shn5KUyZXIeL5OTQ6GxMPgh/rauLT5ymDaJi6mGg=;
        b=G2VbHK3KVVYEYyDo2Kid4XLaK6vt85EqJmxH9cOnIFxKV057+xzE4goKA7E/7khrsb
         WnR9wcFP2UwM+9kESPimZDbAVb48EnxnZo63pg/1lgjyxHFv9ECw0HSvcZCBKXrmBexq
         iHKm0xnF7N9KNHYO6Am4MXoze12Kp/UlG7QwDGUR2YfaozrpkwcnzH32krrPVZtyUcrd
         CKnv8HaPoff9eDp6H4eHhcNfnutxehjod30q1IvQPN+N9cUy9lksQ1LQafuo/iinbiLJ
         3yL8h2m96+diDNuqTCwNaQsF+lI+bQQ3jPRl6rl9It+h1D5m0Lx1U7U8jRiZFpOb8pg2
         lgvw==
X-Forwarded-Encrypted: i=1; AJvYcCU686Nhkwf69intkzUPI/ZrZfhSIVk0+N36U6dB4r8wMBBk9S/mNL0TF/b9OJ7bolRb3GPVJjRtyOs2ZDYnoIIdOO+hBfZlwxhGfGaW
X-Gm-Message-State: AOJu0YzGrgd6mXfXmeR5NfTabL+fVhnbamYzzxh4xXYsZVSzztquF1lh
	/QCkmalARzKPOmCxywYZ1nLeVnWGSuxbEUzgXkM6LX69jUozM216SVyON52MG38=
X-Google-Smtp-Source: AGHT+IHer7ee56Fmd869NcOdtgPYFnjBCVgs6cGvJocrrFO7JUrE7QjB3F7bv8jEaMcSiAAloCBkXA==
X-Received: by 2002:a05:6000:1fa8:b0:366:e9b8:784f with SMTP id ffacd0b85a97d-367756c6fabmr7767670f8f.32.1719995449539;
        Wed, 03 Jul 2024 01:30:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36794e6863dsm814652f8f.50.2024.07.03.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:30:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] firmware: qcom: tzmem: simplify returning pointer without cleanup
Date: Wed,  3 Jul 2024 10:30:46 +0200
Message-ID: <20240703083046.95811-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'return_ptr' helper for returning a pointer without cleanup for
shorter code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/qcom/qcom_tzmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 5d526753183d..ab156ab3a6b4 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -242,7 +242,7 @@ qcom_tzmem_pool_new(const struct qcom_tzmem_pool_config *config)
 		}
 	}
 
-	return no_free_ptr(pool);
+	return_ptr(pool);
 }
 EXPORT_SYMBOL_GPL(qcom_tzmem_pool_new);
 
-- 
2.43.0



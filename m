Return-Path: <linux-kernel+bounces-301836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B295F64C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C12B20DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB59194ACD;
	Mon, 26 Aug 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpGKZ71G"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93002194A6C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689137; cv=none; b=eQ1j9N4Kz9+8uKTXQONkWBGK8mPrqyi/2FzGLQ74TT7kJO3QfmwHLSGpdbym1AyQ+U8jqBbOeF16RdbDHBJdm19v97CfdISc7SQPoaijOxyKACDLnpvkKVFmSucJqrDzCXhaNWnxETpVYdqGrwjPKiyQLljOX4bFrsuUSG5nN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689137; c=relaxed/simple;
	bh=qDC390bCNSJIhRfsWLE0LOccZRGOiv+AJDEaZGB6mzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAg2NtnwNNsdE3e6MG8xMJsxFKPJgjPGyBNqqhhgSnETitvUdlYQq8D3zgTN/32xouCK6isd3vzNXrxH1stZjHz/TYYL1pLuy69HJKevZxlhaqEgTSJ/8LFxf9nT1oFSoLCeTTD2n2vOVS45XzVhU1X30Wi2VHZXmsQjaWcaFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpGKZ71G; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371a939dab9so553260f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724689134; x=1725293934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thAMzPWe3GOIIK6BaNzqQ9nzGU0UzdwEDyQShp+gYiA=;
        b=fpGKZ71GJBwEyWF8DD4QKnvoMmKa3LaXAaNBVQlRl3HrinfVByFDhADOTMr+Eg2Oik
         uY5G2Q1gv6KU/qJFMUxb5AW97HT1z47HS1aY8ty4rm2qLcHeSaOaiYa81cw+sv90u2Jd
         EdLqSo1N8Tu1l79GMgI1KuEwgNaWdrGu4BKWYFP/X5btjqfVzGb7Br7PqRQM+WO8BMi8
         zrCBoBLiPEcjCFLY2Q8NmoMpEwoFDTZ3M/1XaM9pWv1Nsb83g5XdOFD2g92cjBqALB1E
         lXfPbQstkSPi7udpWieRb6teNpC3oOVDXdrV5Acwo/v5FqyK8JnabDn9Sq8jvQkna+Bp
         0DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689134; x=1725293934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thAMzPWe3GOIIK6BaNzqQ9nzGU0UzdwEDyQShp+gYiA=;
        b=ma2FiU6AP3SHsWHSXGYzhLPS78+NUET47s2YiakrW5rGgmKn3B0SOtpOtSPW/a9kXs
         1m5SSzDoI46efZEIkM4xfBA9FKngS01YRGVah78BQzfdCJYt0wAXpZlxCCsmDxlGzt6Z
         4Ndx45XrhQaga0nsqU5Lj5tcji4ouh5dxeTrs5FOXDFff3k+ccJ2hEDOyCPREZDFkO9y
         Cmtycam+3gbg9OBwegXV+VUSHYUfy8bONkg6uUFpU9n/ePwBR84IQCDUCAwLqchClYka
         AdrncK+V5MtAQTHTjihZ0gFfRAYHfnw6wvfVg3MB6m0+j5jwbLj1WrQoyZ6zxKTLZudM
         SkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoSx7ew/UQpW7znsgtP/O1OkcJvsPxETYLyD1pdKh156sK4qRlTqc60V77YpECMGdZ63rhn/7OgSDsQLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHH6YmZ0W9sd0c4jaiJENZzybih0TxasNL0NDqUGGBgk2aXMd
	KIKBaELr2jUBKQM7CHxUbuUudCWcJEM4X6kX2NzqVpuqkv81NdBCWsQXrXJUD80=
X-Google-Smtp-Source: AGHT+IG6yyYlNT9PwtS/u4zRyTAnpTgCPff3pX7qqpX1bUBS/93bzpOzeXEaMUmjlbTHHDazjgdbDg==
X-Received: by 2002:a05:6000:154f:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-3731191d5c5mr4107077f8f.8.1724689133822;
        Mon, 26 Aug 2024 09:18:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c459sm10983794f8f.27.2024.08.26.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:18:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] gpio: kerneldoc fixes for excess members
Date: Mon, 26 Aug 2024 18:18:50 +0200
Message-ID: <20240826161850.74447-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop kerneldoc descriptions of struct members which do not exist to fix
W=1 warnings:

  drivers/gpio/gpio-pch.c:101: warning: Excess struct member 'lock' description in 'pch_gpio'
  drivers/gpio/gpio-syscon.c:46: warning: Excess struct member 'compatible' description in 'syscon_gpio_data'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-pch.c    | 1 -
 drivers/gpio/gpio-syscon.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
index ee37ecb615cb..63f25c72eac2 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -84,7 +84,6 @@ struct pch_gpio_reg_data {
  * @gpio:			Data for GPIO infrastructure.
  * @pch_gpio_reg:		Memory mapped Register data is saved here
  *				when suspend.
- * @lock:			Used for register access protection
  * @irq_base:		Save base of IRQ number for interrupt
  * @ioh:		IOH ID
  * @spinlock:		Used for register access protection
diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 3a90a3a1caea..5ab394ec81e6 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -23,7 +23,6 @@
 
 /**
  * struct syscon_gpio_data - Configuration for the device.
- * @compatible:		SYSCON driver compatible string.
  * @flags:		Set of GPIO_SYSCON_FEAT_ flags:
  *			GPIO_SYSCON_FEAT_IN:	GPIOs supports input,
  *			GPIO_SYSCON_FEAT_OUT:	GPIOs supports output,
-- 
2.43.0



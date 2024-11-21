Return-Path: <linux-kernel+bounces-416811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0928E9D4AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E41F2280F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD01D173F;
	Thu, 21 Nov 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CE5VMrST"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D22309B6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184312; cv=none; b=Qgc8N7YbYsdF1R4igetOqhmzx0/0tzqgS6+Vjhb6q0HPOqR6ICRSeQQUknkc8K9VufGyrevFz6zxTiIC62wo+6TQFMSXJbT63LpRVplsGZ89SP5ubaTSxFrNd5dlWzUr1cOBHIEacZT+N9NneLzIwTRWecRfMgiT2j/74LebFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184312; c=relaxed/simple;
	bh=50fDtCwdlLAXgTUvQCXPWs2a7JSngg3l2XnXQKureNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ok+p6vVpj58moa+kDUiu3//IMDF+gOCfKEJqgyNstPsaPf0k5TkDzJFPAeD+7BV4P7EPH/MB78+n9rmtBSc9hVYopxIO5cnADu2JvtHBfwlSlEuhT/bKacPoRM5Pv0ZGN2uYh8HUPkKb8vZrKTuh8In1ctZN8htSm55Qaeynl9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CE5VMrST; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382378f359dso495771f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732184306; x=1732789106; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vhg//+9gK9skfAKoRMQAk1PtzxhM2yRzEZGGXcWEoo=;
        b=CE5VMrSTG+/uUm/xP0LY+WJDCS1LCVDE+uMoYJCL8rHtaPXp5S0qIajHKxyn5YyQqS
         /nsnKgPz0jv7S6Ya0PZilsHGBCA5Esuz8NRYGBu4+7+UIdBZDWQcwxyxRPj4cVGjcMCA
         033eZDdHiam9gshJu8r1qhpzTRTno1wLxKq061lIIUaGNx8/A5tNEX5vN4Sm3O6eYSSD
         UbCVEC0TAUBi/+EbFU5uyw769y62d0MXiUpuSz9zXvqYS8ZuKRrgUNgryr419iB5mjEq
         H8rB7nUYv6cTdgN5lZjZoq/mxHE7jQtgFBK5/DSBjQtIjzx/UIkIcOjzTd8Pm6NZMXIh
         sFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184306; x=1732789106;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vhg//+9gK9skfAKoRMQAk1PtzxhM2yRzEZGGXcWEoo=;
        b=nqPXhPS1WDuengR+bNm6YPoxuq6VZWHD68r3F5K7BE6e3jEqdZVljqUpsvEdUC1E0m
         DwLwlJgF8DcRSTKDexh4IuwKzExsk9vW4oTUjIoA+/aXXZz8IvfmLC0FqY/StR11J39K
         /RvOhEdZJiS15CO4grO2nwK6ZxZDNMIgtilviBToSLsvt2J5VC1CeNf4mBpNJ37KFkRW
         1YE2Pn69dC+ZNtMdNCO6Z7tQPWqdfLT361+rDoepCBvQkvRj/BESXypFCjnLjShoTFn4
         4JJscyEYDZyOuk0oFD3l33QVGApbrKhZyIfB0MIWbqA+hPPnWyHtjIah8ZYMZLj+RxuF
         k4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUGyaJ3TYYsBFeVllKHGwMk+TvJsZAJr3TYv54x7eU8ijIWawrZogukvAgFcCshX46qAgO7HJuNXxG+q9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIZlzZTg2vcyMvycyzT00in6/7sUQfgQHx/wjgMzXjYsUYc1X
	Rsd1aNz47jwVALmNLDCHoZqvH6pOK4k3FgXwpgMQvTYvYe7r9lkvsiSMf3RGtmyyYdpZ8wfoSyl
	p
X-Google-Smtp-Source: AGHT+IGBW7L660mzuPSTV297VS/czb6kj0Q0yR8PtJ9nj19x1enKRAJUUVHucWAHQnMBQx+HVW4jjQ==
X-Received: by 2002:a05:6000:796:b0:382:372a:5722 with SMTP id ffacd0b85a97d-38254b0e452mr4741387f8f.37.1732184305578;
        Thu, 21 Nov 2024 02:18:25 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm4598065f8f.47.2024.11.21.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:18:25 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH 0/9] Add support for Software mode on AD7606's iio backend
 driver
Date: Thu, 21 Nov 2024 10:18:22 +0000
Message-Id: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO4IP2cC/yWNyw6DIBAAf8XsuTQIFqO/0hiC7NJuGsWCfSTGf
 y+px5nDzAaZElOGvtog0Zszx7lAfarA3918I8FYGJRUTS1lJxy2RhrrEC1ztKPzD5rR5hjWj0t
 kp4gkLqbFzutOqUZDSS2JAn//m+twcKLnq9zWQ8LoMgkfp4nXviphEWIS5lzrEYZ9/wEgiwSDp
 wAAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732184304; l=1846;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=50fDtCwdlLAXgTUvQCXPWs2a7JSngg3l2XnXQKureNw=;
 b=JtEIB3cy6xUpkjoNi88WS64a1EN36dL1aR81+1h2XpI2/dFQNvx51GRJLAOVh3RlKZkDoO4P7
 H9PblPCK032BEA1KIvh7ou+qvGBbf6Sm5uPKkUqAz87McSJ/eyzkQtw
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This series adds the support for software mode when the ADC is used in
iio_backend mode.
The bus access is based on Angelo's ad3552 implementation, that is we
have a particular compatible for the backend (here axi-adc) version
supporting the ad7606's register writing, and the ad7606 is defined as a
child node of the backend in the devicetree.
Small changes are added to make the code a bit more straightforward to
understand, and more compact.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
Guillaume Stols (9):
      iio: adc: ad7606: Fix hardcoded offset in the ADC channels
      dt-bindings: iio: dac: adi-axi-adc: Add ad7606 variant
      iio:adc: ad7606: Move the software mode configuration
      iio: adc: ad7606: Move software functions into common file
      iio: adc: adi-axi-adc: Add platform children support
      iio: adc: adi-axi-adc: Add support for AD7606 register writing
      iio: adc: ad7606: change r/w_register signature
      iio: adc: ad7606: Simplify channel macros
      iio: adc: ad7606: Add support for writing registers when using backend

 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   7 +
 drivers/iio/adc/ad7606.c                           | 202 +++++++++++++++++----
 drivers/iio/adc/ad7606.h                           | 113 ++++++++----
 drivers/iio/adc/ad7606_bi.h                        |  16 ++
 drivers/iio/adc/ad7606_par.c                       |  58 +++++-
 drivers/iio/adc/ad7606_spi.c                       | 141 +-------------
 drivers/iio/adc/adi-axi-adc.c                      | 178 +++++++++++++++++-
 7 files changed, 500 insertions(+), 215 deletions(-)
---
base-commit: 33d38f912d5ca05501c9bbfe14e0150da9ca85b6
change-id: 20241009-ad7606_add_iio_backend_software_mode-567d9c392243

Best regards,
--
Guillaume Stols <gstols@baylibre.com>



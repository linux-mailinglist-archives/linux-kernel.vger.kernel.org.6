Return-Path: <linux-kernel+bounces-534166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70393A463B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD213B69B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14072222AC;
	Wed, 26 Feb 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jtp8KYmC"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776F221DA6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581427; cv=none; b=BO9jPv7wzMo8bunRS4zb4qdwHwyRx8GSm2FNh1e/2u+8tk7WG2ESxCn1ewQSYcYcYpR5DQ37FGTxRLRgdtC7SA1yKb9XiYjIjbUwcatbaHDXxhhabrciy5ddQWQwLLj38ZtKdWPJEktWE3zSvxUVSJez4TMNWXUgb+kJZAu9Flc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581427; c=relaxed/simple;
	bh=EQukQFpoy1bCTquTWJ0f97VwpieDtmlOfkC2xmR08G0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P1ZIPPEsRZ869o2Nq8U7db9TUnKETpOIv5xbQaXRZFLYX3Qs3dEMpNVbzbQNa7dNZo7t7KUx1dtQ86xVvmKjW0UCKepvMjwkZck+KXe70KB9oaDYxZLdambiFzQWXodTxBfoXhoPYUDdBTNKsc+7hytTeO0TlurAtqYbykuj+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jtp8KYmC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f286b5281so3563747f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740581422; x=1741186222; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0cS3BjCebiH0oU2houUoLjoPQfGa9B9aygJMIYRWyk=;
        b=jtp8KYmCWn3mlTrZGmz3vgEnsu4A5ytnbT6sGZ+i0gGbtbH9P5b/eNBe07als1yGcb
         CGTEl/PqKl4qEN6ogsM2oUdrZSkQItlaCe5U2XcFLTgxelNzTxLP9h6JJ+brKoLK1YX7
         CFbS4xoeXaedKKNcovarRIfmaRhPmYcMk0pLI2VqUZFgYn9pYSeybkPgg5Xp7LBgCZod
         3rEAImEMtmj4KA4NaNzgrR0cPiDwRvwZh+6Dzep8WHn9yvQeVPdCj8w5TH27QZ2yQ8Vc
         XwWlDsLLXXBZUW8/XKCZDAhMnNqunlSIQ+HU9Up6MGJB7FODq9q2spQDjpEBDx8mRHu8
         rUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581422; x=1741186222;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0cS3BjCebiH0oU2houUoLjoPQfGa9B9aygJMIYRWyk=;
        b=LyD8ApJcNU2mlhMo/Grciaj28jxFaHq4H/pA6/lVp1VLPuwSE/G9vtRmkX2fvyqz9F
         YW6IVavRDVyt47bhIONYHMoA/rtp/BS5ZhVoKPaQihcQh6yGXyndyIXaKASg9VdNDDn9
         uEx4Rsi4zoYnOYefA9RAneQfHOQ5HcBhqVevqqMVIKiTH2obehUSjoKG71BnrqDTtrlb
         OvhGJtY7rJidW64MeQGpbONq2Eal8z8FVxHni/q478zhBffPeTdu+CJoZgLOAl5+g9NC
         nP9ahayM68i+uxuEzx/23IrC4Tcstxg+yZtiSxmKmY6qXhEdh3VyWNvCf2MRI5NgPKdv
         TXYA==
X-Forwarded-Encrypted: i=1; AJvYcCXS6I69JaawJh8M6TxNVdR9/zjHDjk12ZBZBvx/vZ1X6YleLCuNvnZIUVC6AQE5/Q0RaOvjz0BChcq0p7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5HmW7TZXqKRODIuFzy64xX4O/V68zULtA1ROViIyFsCxZ9j3
	huwXy8AsZopWiYV1N43cyfxYADtVcFGHR7RmO2aMGtf8/DpbkAny/NE8BX3qsQ8=
X-Gm-Gg: ASbGncujfrSaILEqWey2l6qIwz74Bn8nSJ+eziuyurBpw4L9cGYjkzltoHY1tYyyl1F
	BfbPTTNqL6+Q4VvchuT8KHEewkefSs4irSaDbqVQ8XZvzePuCTphFCgGkAItCvYwHWf3ktdxZFZ
	31Ea6yY+ROe0QX3SXxEEYwy6QXJ2YTeZCDNOmg+ho7zAP3e8PdzvLqnqRnV8mVcHTI1EbNSMJOU
	Vxf3cFDZXkOM9RCzZGh9k7BQGGW57Js9Zeu+GDDotQdFmXarwicOdBavqLWxJUnf4grDgE+3WBF
	hw90SrsAg2v5xTCnYvu4IgKwSLRzspb5ql8dL52SfJw/lXBGFfl7k+D6QtKr+oMLkRK17HvlSkN
	5CHv4D+fkbCAPR5wkK57FGjA=
X-Google-Smtp-Source: AGHT+IEJjM76VpVo0v7/LMiu5gepvuHca6Q+JK6FVucSfxbZMKesqh+xseFSt6OsHtbewKkv0+M5Vg==
X-Received: by 2002:a5d:4bc7:0:b0:38f:338e:3cf0 with SMTP id ffacd0b85a97d-38f707aa445mr11160894f8f.32.1740581421934;
        Wed, 26 Feb 2025 06:50:21 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba549d6asm23747965e9.36.2025.02.26.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:50:21 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/3] ad7380: add adaq4381-4 support
Date: Wed, 26 Feb 2025 15:50:02 +0100
Message-Id: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoqv2cC/x2MQQqDMBAAvyJ77kKyWhP6leIhJqvuRdOkFUH8u
 0sPwzCXOaFyEa7wak4ovEuVbdWwjwbiEtaZUZI2kKGnIeoxJNd6o0pK+HStt9hh/eW8lS96S26
 KLoxj7EEfufAkx///Hq7rBlprY3dvAAAA
X-Change-ID: 20250226-ad7380-add-adaq4381-4-support-8127fc7abbc6
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

ADAQ4381-4 is the 14 bits version of the ADAQ4380-4. It is compatible
with the ad7380 driver, so add its support and documentation, in driver,
doc, and bindings.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (3):
      iio: adc: ad7380: add adaq4381-4 support
      dt-bindings: iio: adc: ad7380: add adaq4381-4 compatible parts
      docs: iio: ad7380: add adaq4381-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml         |  4 ++++
 Documentation/iio/ad7380.rst                            |  5 +++--
 drivers/iio/adc/ad7380.c                                | 17 +++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: faeaa1ec6c63b6676679f321601471772f2a0c9b
change-id: 20250226-ad7380-add-adaq4381-4-support-8127fc7abbc6

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>



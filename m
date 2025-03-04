Return-Path: <linux-kernel+bounces-543714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0EA4D8E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627211888DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33F1FECD8;
	Tue,  4 Mar 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vE7b76Iv"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F21FECAA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081180; cv=none; b=itw3d04PalnHILup7tdgfwpc50tWpICe9bo0QQyyZPbSeKCnQ10LtZ9hpMs1ILtoKH+btrzZatw/OFfOGw/qtUly0k5sSlSxcXYZoo+HN860SoLtl30eohQiE/lz7HpdAfT14B9TcoPNAS0lj+82XfQA8t8u1Lx0mSCpMHqi2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081180; c=relaxed/simple;
	bh=aOGadUaD55/7NjVi9olJnWxHY2EQr81G0BMQB3FqhzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sq1FALWj44HkY67aWolQGgMJziF5ekgukm7cBQzzLF/RdbmEeppOhNuaj3LkxyXPYXc/cdHm/A1J4gg0XzMsSg/HW3+eZejEuri+0VkbV2VMNMh6ZlT1tZFGkVtvsYbyIW4CheWgwJMY55d0QHW9/m4CIIMqY7WoAEJYAZwFlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vE7b76Iv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bcc04d4fcso2827955e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741081176; x=1741685976; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzSd2WWwaJ30wmCeIbpT1A/lGBwbvt5bCwq5/4oCS6I=;
        b=vE7b76IvIy0hog7qW6HDTGl/PAw6bW7Adl2xf6+9tIfZ0V50hZffFnsnv3IKp9F1mz
         8UVjdEGN0AndDgYH6sDggkyf9ppbwh1pp+84q7VBgmQ7nKzOZp7kBlXeXwDgfMysCooL
         D5TbwBfv1W4OhSczgB58nzWukuQvKbLF4AytutKvRrvLuf7jzTfG28MsS6oG9gOJ3HT4
         xiM7R3oz7ybaIGUfrX5vZmRgWOlYFjvzssNOPlXCSFrKgcACWKxPH9rvXE2ULmhgEpbS
         Fxuj5KlTtYLw7vWj1+Fot5QLKFSS7+k6SjSg6FtT8o9QET42BZMBxkYUKeSdFuO2ushN
         HGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081176; x=1741685976;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzSd2WWwaJ30wmCeIbpT1A/lGBwbvt5bCwq5/4oCS6I=;
        b=hqVKlsUH/9PEVcvZXoE91k1v1CsdAIT9b83tC803tAwo3CyO0xkVmviJbIzYDJMbwa
         0OzKfeJe5JDgIJiZIko5UamTnZmcPXN7KdKLdk+LZGS7Me9SdX7kcmWJQ+8oVdIzBIO+
         2OpfSPIW01i8cc8d8luGUq31jlOSNIsyBCFAeOPRli971xWKi5UHNcnjMgYSdkcmmwSV
         G+QG+IX48V4y+rXN7+DfUrq0HLl8rCN+s1ckiF4lBXihJiX14N+zFatvhy+5nfIOAdnc
         t3YuEO7bn1IQNCpfTgX2BUnMj7ECg8AcA2xiAz6LrliPyQwp8D9A9XIWCLAuTXDKdRyY
         VB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKkaaZXTGz4SIrZ++AvXhOsqpVLVfgxX/UeBdo7PwWk4rYkdjsqQCkdhwD+dQDyxkGzc1sTtnTao8fSow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Hm3e7f87j0o6wqky9Te1oKBcdga4urcOhieev0f1lkH/+DS/
	tfidITp+rlo7N3USencuIQo1BctJlVS9gMEkH39K9Tgn/OSxd+mHQ6J+vMwDH5s=
X-Gm-Gg: ASbGncvfInl2Sx0N9lZdOv4zKy18Ub3n6MevULlwdj79DcdIXeBdJYvrsvevTyzgIdj
	N7cf26wTO2/1s76KUeIl7Jr+3ThLoVua/LveptiVHLBOJZSEzoD22WOhl8uWPkR4nJOiTNNJp5b
	W5A9UV/Y3QPN50WtnrDx2FX3TzHK9gV5GN9ZEgJzB5MqlPLOo08CWIykqgf9V45ulEkSqPbOHv0
	X5cdOMQXQx9ouzEnUfO9t7ue1NyTIOALqwujcagj421c6Slq5QlWMqqQbBOLtxrSNEWIBVhabX0
	tHUH80A5ST2+a84BkEQ4Vx2MUgUbBzhBi4TbVufEE4bep3bf6bHwlKFXpt3p08LLVoR56ROaMtu
	NEpOZGQQLceg2wyW797EflUU+UTlcrYjVZQ==
X-Google-Smtp-Source: AGHT+IHj42i+Jh0hoXFnYJNDz31oiilscLISu0w5fjYK90iskecg4D7mRgp2rynwPpr1wC+EJx98Hw==
X-Received: by 2002:a5d:6d89:0:b0:390:f815:78ca with SMTP id ffacd0b85a97d-390f8157bf2mr8815914f8f.30.1741081176166;
        Tue, 04 Mar 2025 01:39:36 -0800 (PST)
Received: from [10.2.5.157] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7ddesm17307844f8f.57.2025.03.04.01.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:39:35 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v2 0/2] iio: ad7380: add SPI offload support
Date: Tue, 04 Mar 2025 10:37:49 +0100
Message-Id: <20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3JxmcC/x2MQQqEMAwAvyI5Gyhxu4pfEQ/VJhoQW1pQofj3L
 Xsa5jBTIHNSzjA2BRJfmjWcVahtYN3duTGqrw5kyJrOfPDWiMuBOSoGkSM4j8733WAqvr0VciR
 2hdrHxKLP/z3N7/sD6aD5zWsAAAA=
X-Change-ID: 20250304-wip-bl-spi-offload-ad7380-ad675f2a2f5c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

Add SPI offload support for the ad7380 ADC. 

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes for v2:
- fix return value on offload probe,
- add documentation patch 2/2.

---
Angelo Dureghello (2):
      iio: ad7380: add support for SPI offload
      docs: iio: ad7380: add SPI offload support

 Documentation/iio/ad7380.rst |  54 ++++-
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ad7380.c     | 509 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 518 insertions(+), 47 deletions(-)
---
base-commit: b7508a5a672275694c2a1b09a5f491ca2a56bbcf
change-id: 20250304-wip-bl-spi-offload-ad7380-ad675f2a2f5c

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>



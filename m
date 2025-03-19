Return-Path: <linux-kernel+bounces-568453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02EAA695B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B0517E0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BEF1E1E0C;
	Wed, 19 Mar 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FnstrJYj"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1371B4140;
	Wed, 19 Mar 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403767; cv=none; b=QO985K/4w7xF4wUqPXQJTle0pVuH35cGAm80fmp2DC4RnD5JMriQQJwqNRWab1pcDfFFJGSB680Rvpjng6O3aSAinDRk8QyHIxHTrUdrziuVDd9RknsBG17vX5yqNNCUpZlWcl1UeoL+80zF23F2CqxgEzL+iWjWYzpWgFc75F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403767; c=relaxed/simple;
	bh=GLuo+U2x55gQyUdk6YrmiE4u1WnOL4qCb3BnZbIW31U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8/Gha04HFwMTq6T01GivBGLXTOh3AWNMAkJHuAwGgOShRcNADggnMc8ZlDqnlEF0yHvkzzEcsq9ZvJxc8cm4MAkhvxIcaBiqNVMw9QPazB8S9jWId57u87LfbA8Ya6uJqyYErhTAGagbJdw205/bC0uQ8kQRAG77gllFFQtsCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FnstrJYj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so160533666b.1;
        Wed, 19 Mar 2025 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742403763; x=1743008563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BbuJseVPxwQi7Obc3hDJCXXvtVI/HaIv75L/ZC8hdI=;
        b=FnstrJYjgz0OpTuZJFHt81MG8EHWK+qOwpB7I30/p8bpkBcJ6kk0rj1gMfVQoKrTD5
         juLUSaLCJTT/AofSvUjfhe+45MFomBi05zHCW88OEx19eIeLyY0vWKSh6VvPrP39/bDe
         YYm0KF+VzqqJSBfe50AFAstsmeXPC7EqpikUahlfrJZ2Z9Mvd9FLh8pLiMYBl2vMie6J
         DQWq5IEf5dlknvHj5T71vVTE01hOsZ2vZEvMplk0ux7zSPXbA/ypJlvExwWUwe0ccXrB
         V8MV1dOZMP0YAG6uWuN31qeodnXSApA9ieoT7KULM1N6JWM7yIL99HWOy5Os7PW9TIbu
         W7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403763; x=1743008563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BbuJseVPxwQi7Obc3hDJCXXvtVI/HaIv75L/ZC8hdI=;
        b=nisgiFdcdn9RVdDHL6aDB1mbFnBeyaUvVMCRxMXGj5OCUmLuEbJdNvThJ8nK9y3yyc
         m2hBviadObHfYjAVPGeyBc7SZoC81328obqHX+6YHNBINosulOoeoUZnnM9j39y0S8Aa
         LcVByuuNrmkvKuGMitw7nsbjBKsct36OmvHx9x0fIfaUD4Lhe6hWHKdvwwUmXi5SWCPF
         KLJKxrJGS20OLQ3slwM++KayxiGRIWurJvohQAQXuYTtEkDNJoiiMUFuNZM/lQDlcaLz
         I2b/obtQre0K6hyPehRXwPt4Zr8BE4mx+e97KazYzxomoEI6JXdfqlyUo+14Opro0xSG
         5R+g==
X-Forwarded-Encrypted: i=1; AJvYcCU8a+goToNgSRaImrwFZPXY0ZNs1Cz3PpFdTzzIefEXzrZoUo+cKDe9HjiZj2AsfxRFH6BtYDF3r4J7@vger.kernel.org, AJvYcCUcagQg5piG9pN5iUcoFQf4L/Q8DaG3QadkiiFYbugC1ICiZr1/zT2ncZYmPauP5l+WI/9th8myXrvXpRo=@vger.kernel.org, AJvYcCUo9KJhim1drVGnwIm6VjTuW3SbCMfea7GHbuBgDjLUU7qPsgne2cQ9QblJ98ptouJ2YB9SkLlLMwWVvkEQ@vger.kernel.org, AJvYcCX2iDoF6BbQO6hYOYMMId26UualjcJGm8o3qv1JHL9tK/aHfAvnoxP+EI2EvoFEQAZIIwtHzi5HljYo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Tco2P9yYLvNeAZK7xeSaJdFtj5DFK6xXBOCxfSJ7a7XuPeGF
	gp97ojUfLiItd8dlsRsjDAj6WZVdHq/oI+lIAbtTTeMv40uEXMVB
X-Gm-Gg: ASbGncui+FPBplgJ2LWduCjmVLxzywic1WlNwWQMvU7uPDxc69Je6mCTuBVf0h81Xa6
	I6gLXusXAkhbjyWbMU/sXadVlWg9mPVCs5RWVW95ymkl6NvvJbnb60S4hVhUqguiFgeYhr6Bs3f
	BACDvxSN/cIGmukkjBcSJGQg79hgfHEmSXXa8/usaP26hsALMdlhpL1x5eM1kNeCWCnooMBy4yy
	goMS3KZZmA1dhO78L2Bj+IIIJEoYdK/Oa1pxOOJH7n5lSyDZCN723ZO0WtSg+q10N2qdphkAqvu
	kEGL4uAj/mql5AZfebdyNIwW/kRqOWAJEWpg5ilp5j7Y7dOZi41O6Bb4DiGC
X-Google-Smtp-Source: AGHT+IH5Z1KGEoI3eiCEX0Cg4+cgyl5EMRCB30vRsGgsY4BEhk3ajxrP6vH2Xxan2xP/QubzaS9ICg==
X-Received: by 2002:a17:907:d1f:b0:ac2:9d15:2ec0 with SMTP id a640c23a62f3a-ac3b7dd75d7mr425026466b.27.1742403762322;
        Wed, 19 Mar 2025 10:02:42 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.67.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3143653a7sm1034235866b.0.2025.03.19.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:02:41 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@googlemail.com>
X-Google-Original-From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: 
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] hwmon: Add support for TI TPS389008
Date: Wed, 19 Mar 2025 19:02:27 +0200
Message-ID: <20250319170234.63723-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support and documentation for the TI TPS389008,
TPS389006 and TPS389004 voltage monitor IC's.

This I2C device provides 8 bit ADC conversion result for all
input channels.

The proposed driver implements the logic to perform the ADC read.

The features this driver does not support (alarms and thresholds
for the alarms) have been documented in the "Known Issues" section.

The complete supported functionality has been tested with a TPS389008
and TPS389006 voltage monitors connected to a Raspberry Pi 4.
Different device tree node definitions have been tested with success.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>

Flaviu Nistor (2):
  hwmon: Add support for TI TPS389008
  dt-bindings: hwmon: Add TI TPS389008

 .../bindings/hwmon/ti,tps389008.yaml          | 140 ++++++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/tps389008.rst             |  56 +++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tps389008.c                     | 466 ++++++++++++++++++
 7 files changed, 682 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps389008.yaml
 create mode 100644 Documentation/hwmon/tps389008.rst
 create mode 100644 drivers/hwmon/tps389008.c

-- 
2.43.0



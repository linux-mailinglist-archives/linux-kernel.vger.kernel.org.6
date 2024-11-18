Return-Path: <linux-kernel+bounces-413110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420D9D1417
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95DFB29E73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E61ADFE4;
	Mon, 18 Nov 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="YM7I9hXY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986F1A9B4E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941699; cv=none; b=OPh2K6IwJpbGoRZYVVpeweQ/4kN6zyA9ojpQ6S1rApekN5y17otCUcGrUGyT3Vj4akU0k33bS2XCvpF3lcvnqQRBglTliJKRAGZrq2075uhA9quK3tPPyuV+1PccXO+c180Z4XjTO7ppMvz9pLsI8ahx/Fgd7YmKlrCJzcWe7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941699; c=relaxed/simple;
	bh=pX/kmk4dMi+me3Tj39icaG8AADaQ/icrVmhqYu7ELFQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EkVUVVnEJ7r1ws6Miiv2sTdALD6lK87qZIIFPy17NzAd3jYRUOPorCBdJ4hdTC9Xv0J5Ou6ANZyDr4X/6X37QrAmk4CLFNmtgo5LVtJpuzFS9GndiJBXKtdGcEvTVzChSZz2kllDyppBh64tW1JtS0O1rXBaxY2PmPylZaxLC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=YM7I9hXY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed49edd41so762285566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1731941695; x=1732546495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsuZnZU2NXOf5EqgKE4593+R4sGiA8pml1jXet44X9M=;
        b=YM7I9hXYSM0PPXUdSDRpu4tk9bs+YUTh3O3xq5ICnq917dEAa5QBAS+1hRMOSQdOQI
         X4c4qf/0lBhn1UXs1Zb0ayhu8vx55G2o4zpTy290KoNDbsU4/V0uOyoVcetHnNsDjkmR
         AjIkCzRhoM1yvq9o1TMshBbjoqfXYj+FvyWRuc24PvBiLRHQbpv/t1kGZEiG0Vzb9DYU
         PPso4cSItSyA91wX4TDYtR1o77IkjpgUNwpis79GU+jKgvVYqYAk8kkLWb2RoBvn8H1y
         kiWenoAZ4SL/30RPK4Qw5IpTZ2br/dLkTZ0kNV589qqgWK4ri2lnufz80wnbXj9lVFyr
         Ph6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941695; x=1732546495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsuZnZU2NXOf5EqgKE4593+R4sGiA8pml1jXet44X9M=;
        b=ledMa+wlRKl8qZSOCdKLn9vbsFm5BdgNSMKa/QCPYPIzvlH8TkO5aWPF7uimCUrS/P
         Yl3gZ4pljby3YS0k+QFJTEBInF9IFwrYx1g+dN3PqCtCAar5JhX6CIaNHVrzvjHyQHtF
         i/nuqxYTrg8ZTz2e921KZpE6+3SLRX1m1OFkgiil2GSMP4aObiQCVsK6QwImeXkNCdml
         n+i3BQAt+6pLmVzqkGICyh6EUPcxnOEgTx6LNol6uwFvIoH0+uTGmkx0dJjO27ospBYw
         Zg90Dc1fwKEkQBlBVRhQVY67Tn+8UmXc36/ZqFgZK6bXpF9YfF1Szex6tSHm87hSSiZ1
         l1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVJNt/8ooJloL5UdprEK40b8R/9LIX7t5ajfqu+yxlnyrh/LRj727fxWlrFuxZqNFQaGbfx6+xnY3g1W9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLsWONavINKDhLjYtaNdOk8ktjnnPzmz9cSla3Ldb+jZ7qC0x
	F0bOjCpET6jE6oYKAVMo89eOVT1saHzrpa0go2gVckRT+eWJ1H6Ju1eLEpSCL7LuVdyPW/TqiXj
	ZGBzS30DgvhpDi4yMR4CkTYSuW7gz2YwxOllhuCHTNQqxaYLZi8DE9shmA57hpDnrgh+Uz6XrP/
	YydeyBAQoHNAxF8GjuFs1+DurwY2E=
X-Google-Smtp-Source: AGHT+IHCB4Wc32uEHZri4oww6OJhPXtytvSqmqVrU9ZKviS0h48ZGxo+7ifzbJmdixx5PpIWTHmi3w==
X-Received: by 2002:a17:906:dc8c:b0:a9e:c460:ef4e with SMTP id a640c23a62f3a-aa4834824b1mr1321963666b.32.1731941694872;
        Mon, 18 Nov 2024 06:54:54 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df1b642sm546125666b.40.2024.11.18.06.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:54:54 -0800 (PST)
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 0/3] Add LED1202 LED Controller
Date: Mon, 18 Nov 2024 14:54:42 +0000
Message-Id: <20241118145449.7370-1-vicentiu.galanopulo@remote-tech.co.uk>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED1202 is a 12-channel low quiescent current LED driver with:
  * Supply range from 2.6 V to 5 V
  * 20 mA current capability per channel
  * 1.8 V compatible I2C control interface
  * 8-bit analog dimming individual control
  * 12-bit local PWM resolution
  * 8 programmable patterns

Internal volatile memory allows the user to store up to 8 different patterns,
each pattern is a particular output configuration in terms of PWM
duty-cycle (on 4096 steps). Analog dimming (on 256 steps) is per channel but
common to all patterns. Each device tree LED node will have a corresponding
entry in /sys/class/leds with the label name. The brightness property
corresponds to the per channel analog dimming, while the patterns[1-8] to the
PWM dimming control.  

Vicentiu Galanopulo (3):
  Documentation:leds: Add leds-st1202.rst
  dt-bindings: leds: Add LED1202 LED Controller
  leds: Add LED1202 I2C driver

 .../devicetree/bindings/leds/st,led1202.yaml  | 132 +++++
 Documentation/leds/index.rst                  |   1 +
 Documentation/leds/leds-st1202.rst            |  36 ++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-st1202.c                    | 510 ++++++++++++++++++
 6 files changed, 691 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/st,led1202.yaml
 create mode 100644 Documentation/leds/leds-st1202.rst
 create mode 100644 drivers/leds/leds-st1202.c

-- 
2.39.3 (Apple Git-145)



Return-Path: <linux-kernel+bounces-417240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57869D5113
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C591F26B39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C51BD4EB;
	Thu, 21 Nov 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="LNZ+IUTU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6B1B5829
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208318; cv=none; b=KlInSTb29NkoT+e7LDovnkZs3rDE2hjHC36/vl+Dn6ATuU2WnC52Z3vBqMSQnRkycUhWLdtarZfwwPdUVBfaV8ebXgkrqZJl7q75h2FjPAtIwklureAAlXzOhjM7kur3EiIkboE+acMQLxaWrvBvGKsqXwK3zYbtvfnZl8qjqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208318; c=relaxed/simple;
	bh=abhX0e8c7pOXK+VqgphQUVBQ5sBLa4mph2cyW0j392o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ueU9cVOzmP2L3SNrY2+fy4BASj08R0Vhntr2btbSEP6AMXqb7q3CdvBFHwADn9elapcwxQYi1rf4czF0vj/zBGB9qVCGCCh5r9qbfMSr8zekfHCc5NlSGCHdgTgJ7qzcHoBUlBfgj+6mtvjsXS2e22gTBeDcNU3g8Q1bpdVH++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=LNZ+IUTU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa1f73966a5so190565366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1732208314; x=1732813114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv4wgISV7HkP4RZ5WKLIykwWASiXxKHjaIhIuwDJQRM=;
        b=LNZ+IUTUmCoCGKr065Iy/UutFnhkel56puHGON44iSiDL6obq9SkM30Hq8Tww20FHW
         QWcMELGfb2gi0QWuxbF98nChXWWgHG7zzNgtOXcWe9OxSdLJ02QiQeNX/50bRK4Y8UND
         al4kJP8YZgwVhqVGp237WW4ZqA5KOW/wbfX5reixyeYa2q5LkkRhqlw19L6Yrbkoj9Ij
         HWOQkqi3XAN0AEjmij4xid14kXpTw0ILDwXl72Zk9eBBLkt17iqbgfDe5mW4svpZj7DU
         Ax+7eDIhC1HP4dc+Mcj8aavXFdU/pfxZHM6OsoaUsJYRTFs7zymUuILlCl/dxtksMwx2
         PuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732208314; x=1732813114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv4wgISV7HkP4RZ5WKLIykwWASiXxKHjaIhIuwDJQRM=;
        b=SIZ5Qx6rHLRAl5YEbXZZOiUfbBNvpi1FkJmq6ePegEsLwelkzuNwe2PIeWc7Q1SqGf
         HLDocvW5RQB6e9L158WJZgASidcIwXiNZv38E9vlAEQSSGl9Ie42tTAAXmHg6Il5N1fm
         qmaboLtFOmujRcJOuwuWj7JRf+DiKJEJU54xfZAq/Qvjfl82EKSzvATtLMuveWC50Xx6
         mS1X19LwI6uUqq/1cICTY+QJzmWxu12TIiNtmLed5TaaCjxw8SMmUxXCWx5k1kZ4T0kb
         7nl+yQag074Sf/xnEqdRRJH2hMOm63bBalpQbEboWUZRdGRmN5aMeBbi+tacfxbDwlRW
         A2+w==
X-Forwarded-Encrypted: i=1; AJvYcCUHKSMb5kpOrTAvzhQCpLe3Zah4+VkcHf3mtKnKMby1eic2x0hzfQHPtzcNzuqUw7L12/STar+CuB0amn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxocM2imwqiLL9RidrKpY0kFqYMOomdKKPmmF7M7vrRnALtxEYW
	tlhkBgsDnQA+661tFIpQh8y9SxmLoKajb3DXuM1wCVICqRnTCqNfwcoPkoF9BYZHfAI0YqMzjz6
	ZG0H78F7YjZ/e7Clp1qjoaADvjSJE4eBgnKKDnO4Fr/HMqOtF7nrKMBzn9xC3ES8nK1gUrrHzCi
	pcd3Oostkn8QUXQaCcq89DTn3NI2I=
X-Gm-Gg: ASbGncu1YJb5G1QdG/8wTV0UfOVK8oDFwzR08pZacXGr3KvzxX2i+/9AL5AAUuyBlDG
	AQhxCUR42/GCDZgrbKH9lj5leo5OSuW7F9vMC/pRhZiCtrUahvZ69M9xTwIAbVDm2JQexsiDgAM
	592MZ+uCFqvwt4FsaB+3x1M2Y9UiKWa33/qzj/CPPpQPBuKHyq9hNmors/7LJJufMrEAtBL5TUx
	+LL52Xp62hjTG0J+QHYJgj+xTf3y3JAZE9ZphOkJ+ioWed72b9tK4NKktseFqPHwJRenvHpnXBh
	JjeZ81Ta+UFfTZ3Y4nPL
X-Google-Smtp-Source: AGHT+IG8qI4Ldy/CPpK41Muah+dnkVTCgnCKbuDjqWU0JiNZ4vuj5vyaOAZBfib8+IrwqlaHQZFVtA==
X-Received: by 2002:a17:906:6a08:b0:aa4:9ab1:1982 with SMTP id a640c23a62f3a-aa4dd548167mr672887466b.4.1732208314370;
        Thu, 21 Nov 2024 08:58:34 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f41536d3sm101502766b.24.2024.11.21.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:58:33 -0800 (PST)
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
Subject: [PATCH v9 0/3] Add LED1202 LED Controller
Date: Thu, 21 Nov 2024 16:58:22 +0000
Message-Id: <20241121165829.8210-1-vicentiu.galanopulo@remote-tech.co.uk>
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
Changes in v8:
  - Add change version history for patches

2.39.3 (Apple Git-145)



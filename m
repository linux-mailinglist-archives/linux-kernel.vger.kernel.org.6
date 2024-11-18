Return-Path: <linux-kernel+bounces-413145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400519D141E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06385283A83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909311AF0A5;
	Mon, 18 Nov 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="YfUeZ2P5"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8021ABEBA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942773; cv=none; b=NZayJncxtMuWZQBsfSaG6JYYDDGNI91eq4h7w9+sZX3fHpYZGihB5DHuUS87XopAPDedLsuTedi5kFqi4MH7WtlgMwXXRQf3kSwtGB+AmSbOogVq2fnlCX0jADEROT864jahlT7elZpMAWDita53DOmYMgT1wMrDpPwilDgO04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942773; c=relaxed/simple;
	bh=abhX0e8c7pOXK+VqgphQUVBQ5sBLa4mph2cyW0j392o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OqubEX1028I9ovxAB0PfcwxA3Pn0J/msgcO8BTRwd5UAVP9E2HwWOnrOXh68HCfjZVDP2UIOH7H6v2bmqopgU1Ya1FSAc220/Y4aMgdJuS6BID2t1DQnZi1iChKHpfaNqn37baWLbV6Bbbr6KGwjWDk0GMVxkm/jhphzt+xMQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=YfUeZ2P5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso5213835a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1731942770; x=1732547570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv4wgISV7HkP4RZ5WKLIykwWASiXxKHjaIhIuwDJQRM=;
        b=YfUeZ2P5ucb1jQGZw2n1Js5S95flnPM3kKiwvB+5+1yaSafH2k3P9zB1LGroO/lHeR
         Cbd/12Ldkyp2k4+uExiHmxTkEtUqcA5iNRbBMPpe9BiMfUXw12Mce82EoviFao2/Gggj
         TS02UTglSBOiZnbIJwELiy4UGdcLIhNyFCVeb98Q41Q4hz4No0n+k6OU3/VHlEJICF2G
         GAA+wRX2f75e0YwOjKpN6ILTNYtSuCV9RxudEfVNZhuqQJGNoAzMm1vM0KfXVYfH/Ts5
         VN0TiKz9xdvCBct85PdWwbnKlWAg4lCj3QJtXSzjprpYYo/Xe1CyteZi0EtCrk0CdAP5
         xf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731942770; x=1732547570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv4wgISV7HkP4RZ5WKLIykwWASiXxKHjaIhIuwDJQRM=;
        b=OEz7FCMBnJp2RtRIEFCxj5jxQPlYn2Ye1VVRtp6vSC0b38H+uBN7Pa6IH7uBLXBBcN
         HRgSn7vKvx2wnGC84Ne4VrwzbS3qnDbmsQbU9FCmo8jRN2kSy8kjc/fl0lzLeCOrxQN1
         Xd91/s7Lq8PLkiYptvP4xVU6TuA8VgP+2DspZC3BhgV/Q/d7MTzT+glzm3pALGTSq+GN
         TOdwkNgrT3kCGaE098IumdZovxkjd5WrKTHdhUwc57Wxnfe8c0MpMp0u+ZcEw8zsQu9F
         9yq0pGICD/52PqXif+oszESEdP9fK8hk6rx6DbzCEvbeFrW2HmFZOhDJqUVqjBlFnPIM
         Qc7w==
X-Forwarded-Encrypted: i=1; AJvYcCUqZFcywmj+dfRzmH/v2XtdNWGgjL9vZU27Dk7tZAJxryKzwJFPUgUpCN7QUR16VsHyA+8oPFGtr0+/PSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+w0HEMRbJvncgUlHqzFFraLhh4TSZ+wyGfzsEqfu863VV5bx
	94rORuDb3QauercXNNJmX1IOWh3CWSO6sM870ttwcXjkaDLEBwB26TbX52mMPauVZwsp7ZZ8ppK
	6n9CFnnsD36vumNaAKREEc8T8mci4m5A15kMJEjx8IpcK/Dflgfx6SiiYkcboRxoNCnhS0Ht5Xi
	b3jYuahd12ZB/gG3BF5DQFQj0dcUE=
X-Google-Smtp-Source: AGHT+IF6Rm8MuxsPIjT0zsN40PTQnBeCMXAycI3c/kSxHlnk0GoDUdvZkXlmrMv+2NqSQA5xVb14Pw==
X-Received: by 2002:a17:907:3f04:b0:a9e:e1a9:8ddf with SMTP id a640c23a62f3a-aa483476164mr1190902366b.29.1731942769788;
        Mon, 18 Nov 2024 07:12:49 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd7e7sm548980366b.119.2024.11.18.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:12:48 -0800 (PST)
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
Subject: [PATCH v8 0/3] Add LED1202 LED Controller
Date: Mon, 18 Nov 2024 15:12:40 +0000
Message-Id: <20241118151246.7471-1-vicentiu.galanopulo@remote-tech.co.uk>
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



Return-Path: <linux-kernel+bounces-377748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191D9AC3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6312D1C2123D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFEF19EEA1;
	Wed, 23 Oct 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tHG9gSsz"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4A15C13F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675186; cv=none; b=gq8/vFR2Pjq7BFKVeEwsTRX0R0l3lzoV/HBOOHUpsXowtcN1HX7lXdguHB+WtpRwCE8KOgkCsMnAmf3+TflWQnbbCq10SvGSq8KPAQVByWkK0sdU7ymQbnfnQzFZMYM6l245WB0riloCgjgSvVTpqD3OCOWBW9EGoo4flkMx5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675186; c=relaxed/simple;
	bh=BdfWbCaw9dl2XW0U+tiiv8QYh2zros/EPRH9N3CaDNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y3DxcQv9XFXiCKl7MYRJbwwa4vQ4P2WuZ+jIa3AvQgUwe21fZQ985iPtzhnfvUPQ8FA2R6Cso4nnUy1lYYDrir767Bt4cCTuQsrNde832cC1bzn1uJev7QMWNoK0/qAqNsZDHX3WVWks83/hW/F/NkmeUq5/8UQvmyeTM7jwKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tHG9gSsz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43169902057so41861505e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729675182; x=1730279982; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whOZh3OaEYNB1ifC1fGYleloMAZdgj5A+SfyxxABc6M=;
        b=tHG9gSszJROK/PCDrtHvCKAK9kUremr3bxxaI1moT4aYJtdcIn3cE5hVwte7mbKsbw
         0eYtgkPAjbKu/n0cbBL3s+IkE7xpVz4FDJjj42fxrHKLKGeTApLOehbRkbQxCZTgIy0K
         m2yBt8css0Q7JfVAZSMEXCyS+Au9GTb+kRtLp61FwOB3WDlp+avmVFNm8VawbEM93Fav
         wo+2oY4orBskVQIzhfIpNLBDoEChbv5iMAc8KRXl8IW2B4Sk6pd/J40nA9pvrsJsiQDh
         YAfKwHpJSh9hTPKWVi9OytR9wOEBxBmwPSOHz65IOE5m2lVToCDXjvae8ydBOkhYuvSz
         bS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675182; x=1730279982;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whOZh3OaEYNB1ifC1fGYleloMAZdgj5A+SfyxxABc6M=;
        b=GYiQfvV3YpEA5cF8A0xiVFsVfAZxOqlw6yAQwjbOYVVfd3/WxG4wbs/6DPQSPksvhW
         VfT50Vy7nHoReVxqMAsCtUGNyatvO1POpBMZ454cSExcuBQA2+4IE4Ostj8U0QtDgg7K
         mSX50kTg5D2rFk8LiCjOxQVMy317H0h+qp9b/f+gfGaSNYXoHwyyCvXwSKknHRhNb68S
         AZ0iCXZ6V/cApjMzYt8EVL3kFyLj02PNphLG+NX+U3h3jq7GgX3VQ0MIi2+ufeRgyuQp
         pqjjHOXpAFwwwExiXzg7dxLMzGCKA59dpyFRDNqcEH1ytz9g0PxK7XZBq7DA6mFkq/AF
         Kq6A==
X-Forwarded-Encrypted: i=1; AJvYcCWmvj6L9kQ7oPWGxlGGi580BFoGo+oqoA23A8xtAYdafjHjdiaVKMoIfWXUb6HvTX1t5nywX7N3BD2zTRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzpr40eXjW32wHuwt2JxdhMoKj62yETbYdscW+c4LKOJ7D412h
	DjEY2AbcnChLf/h84YlekaTmCFkJHz/X/IMJd2dylsrk/Qv1myN/Bxrgjtlb8Gc=
X-Google-Smtp-Source: AGHT+IHccO5uMEXbEwf90dp28rRacXB6W5xVZIJgnOL2Zbamy56vq3VWhyAeKkQjdkPvxbcgsaQ+tQ==
X-Received: by 2002:adf:e40b:0:b0:37c:d23a:1e4 with SMTP id ffacd0b85a97d-37efcf1adb7mr1132526f8f.30.1729675182026;
        Wed, 23 Oct 2024 02:19:42 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8515796f8f.73.2024.10.23.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:19:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/4] ad7380: add adaq4370-4 and adaq4380-4 support
Date: Wed, 23 Oct 2024 11:19:32 +0200
Message-Id: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKS/GGcC/42Pu27DMAxFf8XQXBV6Roqn/keRgZKoRkASO5JjN
 Aj872UUFOjYgSAOh8tzH6xhLdjYODxYxbW0Ml0I1NvA4hEuX8hLImZKKCOFtByS017QSjRwNU8
 wvN3meaoLlyZF6TAKofaMMuaKuXz3/M/Diyteb/RmeR1ZgIY8TudzWcbBBwTtnQdppQwRIUWVQ
 1beBCFCjBYUEiX2V49su5wwv3L0shudqBnXO+f0zsbsAcZVs6fGsbRlqvfeepXd458FV8kFTwo
 l7G0OyviPAPdTCRXfqQQ7bNv2A/ItZLhUAQAA
X-Change-ID: 20241015-ad7380-add-adaq4380-4-support-14dc17ec0029
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Hello,

This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
which are quad-channel precision data acquisition signal chain μModule
solutions compatible with the ad738x family, with the following differences:

- pin selectable gain in front of each 4 adc
- internal reference is 3V derived from refin-supply (5V)
- additional supplies

This series depends on [1] which fix several supplies issues

[1]: https://lore.kernel.org/all/20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- fix commit messages and documentation about the gain: pin selectable
  gain instead of configurable gain
- add the enum of available gains inthe binding and array of available
  gains in the driver as ad4000 series
- in the bindings, remove item from channel reg property
- in the bindings, merge additional supplies and channel properties inside
  the same if branch for adaq devices
- fix comment as suggested by Jonathan in the driver

- Link to v1: https://lore.kernel.org/r/20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com

---
Julien Stephan (4):
      dt-bindings: iio: adc: ad7380: add adaq4370-4 and adaq4380-4 compatible parts
      iio: adc: ad7380: fix oversampling formula
      iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4
      docs: iio: ad7380: add adaq4370-4 and adaq4380-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 121 +++++++++++++++++
 Documentation/iio/ad7380.rst                       |  18 +++
 drivers/iio/adc/ad7380.c                           | 149 +++++++++++++++++++--
 3 files changed, 279 insertions(+), 9 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20241015-ad7380-add-adaq4380-4-support-14dc17ec0029
prerequisite-change-id: 20241004-ad7380-fix-supplies-3677365cf8aa:v3
prerequisite-patch-id: 6127a52d3b14e82d1a6081c7e504d0e4eb323089
prerequisite-patch-id: 7dee57142d0d12682b0be3b62f1c16851aeac069
prerequisite-patch-id: f737e56a372cd91e5fac651a2063b06827f9aa21
prerequisite-patch-id: 7c8d5fbde82810057630b95e12bb2f6576da6980
prerequisite-patch-id: 972bdbf06bafa7c56f604dbe8eb7d236aadaad99

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>



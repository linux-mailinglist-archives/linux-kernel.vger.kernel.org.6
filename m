Return-Path: <linux-kernel+bounces-577336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445BA71BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC4E3B8885
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A921F63E8;
	Wed, 26 Mar 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="aaQ1J2Xv"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF81F4E2F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006233; cv=none; b=pCF83ug5CPDRZmZfJmpDmSkEDI4K58zG3VZVilzORLG7twcZY59fXAqkOrv6JKXUf0KsQDMvM7ZCw6VoZUrW9dnlvQ9g65pllQHF1jI/mYoplkF9d1o9+v4n/J2883x4wxsJq9OB6l8d7UsshIdZ7aSr+Yy9gPjT6U1AgWqmrns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006233; c=relaxed/simple;
	bh=O/r8gbGACCdKsQpd9YaJGrSlEj//D5Z8hvnF0c8Mbxo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YZJFUscgudV+bX3uXYjL3D18Wm55ThGT+xeGgV5A3MhjAx9h2MEZRHE0CXQwdVLmZJvdYsIE39YxTN6zcYEqIRD2JtCu8pVbekvk52ffSPxxYCQzfKia+MiC0OCFb7C7jI8mOxy0qimAkY1mJDz4HxqqFgdjfxbPx5SLEb67Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=aaQ1J2Xv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso12760609a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1743006229; x=1743611029; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKYanQIfYCncszgpyLAY2Jfcp3L50T71jyYK0/4Yps0=;
        b=aaQ1J2Xv/kKn9m8lRKyeMZvTwyLiN0Fc61PmVzA9H4mufDlqqtGz5IwOxqRILCrI9+
         amfw4dS3kGaMPBJwKnr20qI1rdaeULirbqG7KU01UMTGINRYhRf9RZ5Nzm8YXEkhHK06
         I6UTvp5sxlmkPPcpz2JYfaH5at0NxcsxMiFyo6VuqymDPonhj8uKYh7aHQfpGXIdImjs
         O27PwlMjAoZEj7cBBM5NHnWk6f9hgO8pFsqtBkdy0MuIq9iWRpZLhwCRkn3Ep8S2EzGU
         +51K7FZRqoVdAjWYxZbQBCOkGtNMGk/1rgsF1tCSZ+Qo1L9FWEn8btuPYhq8oiqs4ZGa
         YKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006229; x=1743611029;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKYanQIfYCncszgpyLAY2Jfcp3L50T71jyYK0/4Yps0=;
        b=ihJ0ECm8Uh8GTKCTFADiFvgUybGY2F3vbRb39RBjJRI0+E0oPW+GesID5bMVKNiBm5
         SZvndqiATuxzJfxEl7frmNPdrG99YNhsXW/moqlf+96D1EEzNdXJfTAdVKF/r/uYxkxC
         50axE3JujbpJwwRKA8lsvp7HZbyZeBZW4RGk8VDbrJ0C0wCkkdM8sgRiGRbwaX4GmU+9
         AfvvRM6IUjK1aakz8nB3q0dW9QNkiUDu+BT9cyFSREvpqhNgR0EW2AzaQDkc863Ug/q6
         cyUhOovELzfRfiOPDYLYkW5xvHwC2qoMh5PS2th8H7QqPb5Br1X3jSCuFXkH0beaUY33
         WF3g==
X-Forwarded-Encrypted: i=1; AJvYcCXZJGVG0bMVEj+QCyVslt9gEnXrzOezDSSmgfHoWdYT1KcvlOT6jbgMOZfGp8BEkXe6RVs50XU1qecCC7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CYCNTxOXkqX8tT2QoRw8eIHUcCtbxyE69CgzFxoRJv1mwfBn
	MYEQL4AFV6cxXADOYRWFJ7sPSxjD1KRQWuFj2seOdVmcc0fYl0sZoWo1Rf/EzB0=
X-Gm-Gg: ASbGncvZrDSETvrP1rAYN0VKREaY63mT6ARNuibHk3kmEz0wSWNAstgvfqchJREIIvo
	+saFQ+7c9p/9NHDiCaOYN8l6c6jLFoa6qQAqi7omgCC8zmLFpu0S7AhdpW9k/f/cf9nsotz74CL
	bxEKEYx0/eyBxdxX8r9KqBKjbkEkgrBOvav/xWdRS2iLENrwdGChArhh0kAaCOj4LQlkUkYb1+G
	PEKpYXqqx3hIV3GQ05042gBkLHa01LoaOE2+rQ+q9sG2eR5d/MRfzRJYKAcM5EMFI4QkMhWG8RG
	Pm0qImRJfTewmMND3oe+OCmbJ7Ap4aaXZzGTksfBK0Vt01HhcKxpwgMdKg==
X-Google-Smtp-Source: AGHT+IHTxPRGm5mNkyz/LXIEUO2w8nqKfRSkk2yHl8zPEU3IqZLbPjnGdEzUK5cPc1Bb6wHgkTIrlA==
X-Received: by 2002:a17:906:7949:b0:abf:3cb2:1c04 with SMTP id a640c23a62f3a-ac6fae428c5mr5377966b.9.1743006229345;
        Wed, 26 Mar 2025 09:23:49 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0f498ecsm76678866b.135.2025.03.26.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:23:49 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH 0/5] Fix onboard USB hub instability on RK3399 Puma SoM
Date: Wed, 26 Mar 2025 17:22:55 +0100
Message-Id: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8p5GcC/x3MQQqAIBBA0avIrBPUsKKrRMSUU81GY6QIorsnL
 d/i/wcyCVOGXj0gdHHmFAtspWDZMW6kORSDM86b2jU6xTmhhOnM8xTo0tgupqmxQ289lOoQWvn
 +j8P4vh/3hyZEYQAAAA==
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 quentin.schulz@cherry.de, stable@vger.kernel.org
X-Mailer: b4 0.13.0

The RK3399 Puma SoM contains the internal Cypress CYUSB3304 USB
hub, that shows instability due to improper reset pin configuration.
Currently reset pin is modeled as a vcc5v0_host regulator, that
might result in too short reset pulse duration.
Starting with the v6.6, the Onboard USB hub driver (later renamed
to Onboard USB dev) contains support for Cypress HX3 hub family.
It can be now used to correctly model the RK3399 Puma SoM hardware.

The first commits in this series fix the onboard USB dev driver to
support all HX3 hub variants, including the CYUSB3304 found in
the RK3399 Puma SoM. 
This allows to introduce fix for internal USB hub instability on
RK3399 Puma, by replacing the vcc5v0_host regulator with
cy3304_reset, used inside the hub node.
Please be aware that the patch that fixes USB hub instability in
arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi can me merged only
after updating the Onboard USB dev driver, otherwise the hub
will not work. 

Two last commits in the series disable unrouted USB controllers
and PHYs on RK3399 Puma SOM and Haikou carrier board, with no
intended functional changes.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
Lukasz Czechowski (3):
      usb: misc: onboard_usb_dev: fix support for Cypress HX3 hubs
      dt-bindings: usb: cypress,hx3: Add support for all variants
      arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma

Quentin Schulz (2):
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou

 .../devicetree/bindings/usb/cypress,hx3.yaml       |  6 +++
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  8 ----
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 43 ++++++++++------------
 drivers/usb/misc/onboard_usb_dev.c                 | 10 ++++-
 drivers/usb/misc/onboard_usb_dev.h                 |  6 +++
 5 files changed, 39 insertions(+), 34 deletions(-)
---
base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
change-id: 20250326-onboard_usb_dev-a7c063a8a515

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>



Return-Path: <linux-kernel+bounces-312148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC49692B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D79D1C21A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5F71CDFD8;
	Tue,  3 Sep 2024 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="hIEeypua"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D82207A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336535; cv=none; b=ujMm2EstgyoeoOagGI8j79kW3Yf0CWJKAfCO7TLr/3ktnkl1xFGbMYOqlhjhqf95DJxzilgsxZ21zxbtj24ZMvulHnyP5btbkv86Bsnzpee6S+mfcGQcLk5psrNqkJx2sMiYCXFIkjP/ieRvVV99c6EcyT2/AR9ImhHL76nWlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336535; c=relaxed/simple;
	bh=M4J8L8ff+8tFh+4/qcPKgXiSOM4cfJjfyjH6TWevvZ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qSSv0hxJy67AQn3W7l4QXk8oA9PGMuhVoRKKixvzDtJfXGH3Y5Rn2jGEMOA40av1JtsvNK9CtdCyq5nejMpus5WHRwZEkECn03YThRi4mEFyOJ3F1S/9r3ozy/y91ugN14KssCAy0yEF3dYDBVwJxAqW1R1GbpirSL0C0zJpMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=hIEeypua; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71423704ef3so3618304b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1725336532; x=1725941332; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmICGzKUGxFewRbRgKis5bG9OZnH3qQ0GE51JyFBQto=;
        b=hIEeypuaaXosRJieKzTAy1UK2WQUJK8ASO2rePC3AM1Wjj1rlvvWZxuoFEM8H0YhRb
         dWbDzY4YBBFUq8FJSjpcbdamnpkfu7CfmBIUvBjC50gZBPqLeIKY+HazBXwak0tWwHUC
         LPvwSzimzLsprFLNW/bMERpP8psfri8kNeLv5Z5HBD9+YXLk8r/y+G46U+y6R9UG0Wi1
         lWmhhWaVv76nymMnxRXExlStTtGwZEoJhkt5Gi/eMmSIAWmFIsOVztFnbuE5zB9DzZMR
         BJ5qdP9n60SsDhajRN/28TJ//vVVS0l30yfyRKfr6ehD/3wIpH+sIBJSeU8UV4GRNXCK
         TC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336532; x=1725941332;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmICGzKUGxFewRbRgKis5bG9OZnH3qQ0GE51JyFBQto=;
        b=EdYjtOa7x1ILFjPt3/PM+WblT9QBrAc8pQI0ma+2UCvxB24iWPHi4GDA+sAv1nyeHD
         09JElpoU3UiHIonDiss05GW9eP1WDhOvKW7qDC+WY60Cjl5cx2X3GRJDOiGNLTM+u1Av
         2EamGowRj50bsAEWckV5+fAm7GYF5KxQHYLqW2Qj7E15OG9oaVqXdQBSvz635/0ouWII
         rmobcgWdyPyChs+yjnYU4+0NpiZKykuRd79LmsSxhPtBw9xSY55RBgpWHtulhUiqIrrv
         fWamG6YmzL+2QI7Yg//4rar8coR2KUxrsWZF1XloTog9Imh0PsjlSVhjQoABs2i3fpVs
         0dWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ08JCK6D7iT1cMy9/kby3FkpFcAEBNCFCVQhN7eWeMxvJGsZwbzWIJSpeujK10uwG2yezviNt2kAblv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SNwi//C4MdJwrZPI4cNfL1d++lw2ZI3P1tUHFQvvRXJliETa
	G+BALZVAdAQtvMnQXAMJtV8YmRQBDWbYNtMWjw40vP3BX7xRNQTXxvwbZia47F0=
X-Google-Smtp-Source: AGHT+IF2i9f+kgKGcCcui5eYYnCDwVFRlNfytXr32+QhP8AaKvue5vdZwiryaEdnfKIENqx33uI1rQ==
X-Received: by 2002:a05:6a00:915c:b0:714:25aa:e56b with SMTP id d2e1a72fcca58-7173b5c8644mr10432960b3a.8.1725336531789;
        Mon, 02 Sep 2024 21:08:51 -0700 (PDT)
Received: from [127.0.1.1] (75-164-215-68.ptld.qwest.net. [75.164.215.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569ef39sm7532701b3a.122.2024.09.02.21.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:08:51 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH 0/8] pinctrl: Add T-Head TH1520 SoC pin controllers
Date: Mon, 02 Sep 2024 21:06:53 -0700
Message-Id: <20240902-th1520-pinctrl-v1-0-639bf83ef50a@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2L1mYC/x3MQQqAIBBA0avErBNUzKirRAvRKQfCRCUC8e5Jy
 7f4v0LGRJhhHSokfCjTHTrEOID1JpzIyHWD5FLxhUtWvJgkZ5GCLelibhYOlTLWag09igkPev/
 htrf2AWjSjWVgAAAA
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

This adds a pin control driver created by Emil for the T-Head TH1520
RISC-V SoC used on the Lichee Pi 4A and BeagleV Ahead boards and
updates the device trees to make use of it.

Emil's series from January used separate compatibles for each pin
controller instance. Rob did not think this was appropriate because the
programming model is the same for each instance.

This series takes a different approach. There is now only a single
compatible for all pin controller instances. The pinctrl driver checks
the unit address to identity which pin controller instance is being
probed.

Link: https://lore.kernel.org/lkml/20240103132852.298964-1-emil.renner.berthing@canonical.com/

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
Emil Renner Berthing (8):
      dt-bindings: pinctrl: Add thead,th1520-pinctrl bindings
      pinctrl: Add driver for the T-Head TH1520 SoC
      riscv: dts: thead: Add TH1520 pin control nodes
      riscv: dts: thead: Add TH1520 GPIO ranges
      riscv: dts: thead: Adjust TH1520 GPIO labels
      riscv: dts: thead: Add Lichee Pi 4M GPIO line names
      riscv: dts: thead: Add TH1520 pinctrl settings for UART0
      riscv: dtb: thead: Add BeagleV Ahead LEDs

 .../bindings/pinctrl/thead,th1520-pinctrl.yaml     | 165 ++++
 MAINTAINERS                                        |   2 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  87 ++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  43 +
 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts  |  28 +
 arch/riscv/boot/dts/thead/th1520.dtsi              |  62 +-
 drivers/pinctrl/Kconfig                            |  13 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-th1520.c                   | 906 +++++++++++++++++++++
 9 files changed, 1291 insertions(+), 16 deletions(-)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240902-th1520-pinctrl-d71de44acc66

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>



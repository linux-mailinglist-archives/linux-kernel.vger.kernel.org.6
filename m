Return-Path: <linux-kernel+bounces-575500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AE1A70345
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7199162C72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE7259C97;
	Tue, 25 Mar 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EIKhy1Om"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F744258CFF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911999; cv=none; b=czD6/T4lEUWwN1itN1w68x25qUThFEn0dpI20C4kE3Wsd3rH0fWiaBUtr0WlW9A1r+4q5n/o4pEokPYNi8VrtWnwrMV60wrS340hIcPzxoYzoaairGklO2ORB8M+U22vgOybtK0EFsQLw9ei2Xrb5S9Ya3uAiJV4iZsqJhOdc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911999; c=relaxed/simple;
	bh=otuC/CFv+EroRezJqWlsIO+RTb56ZCo/gwA9TYGTy4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGwXCnDfeK7ODYbi2HOmX8rStyGlvCeqUy/RgaW2jNHNFGO/fnya2j/V8xbB7XUa+zGEvQb4pNxPQU7tbful7su/7UPx2Lo9axo+F4a5+wYOa5yNaP/dJbVNjVcu8CIIiNZSdfIwh++137dvwdxAjv/Czm4+WDmpqhs+2mpqD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EIKhy1Om; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BC5203F474
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742911994;
	bh=JaLEOuspohf9X4xUwz7GRTfjgrM6e47VPxpoP7GA8+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=EIKhy1OmEbtnp3UYG+TjyDyiYHO5sHQSvhVlJYlw3lnXLo/xYpwNttMkQ7/v2Tjfr
	 RghPR70OMK7PVhBpedHWcsJ7dHbqpULfEQGyRjvTEHXfpmz/bx/JQmiEeC9oKJI24P
	 cafkGSad2uuqw3WVbLK96bNE6MYB3C0BgLl+RGLk2HEmEeZoBWXKyjKQklRPfc71GX
	 RDu87ArERxUPb2KBHdgrABC1X6fAcE+DLkdmz0tM+fRpM9B0giccl9BzYwe3uszdjL
	 2vyml5vEo4BDkOqUxQ7y+2hoXKi/UGz1ANjE6pfkdCxqBpa3EviQbtb74k6ZrEN2JK
	 xi/X2iZf5ODEA==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3978ef9a284so2198195f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911994; x=1743516794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaLEOuspohf9X4xUwz7GRTfjgrM6e47VPxpoP7GA8+I=;
        b=EQiP3zY4u9Cv+nuHDf33XjvoGXObqJiR6K1CI7hICFVuV+ivSKYNXlbYt6uRGfzpam
         vckQw72WKZiWKyJsErWelFVomeHfxsrobrHMwGDZo0G9zmu3ngfM/IRqM1Iha3ywMGnq
         6Irtt6/gzuggPUpnBS8Uac6HF5UggrC5JyAjKA9zDjGwgbkvqrwko1U+7I7ztDD+neZa
         +nyBHtW0tb436gdNYKQPg5RjFWvWY+Pnj/gy35kHNRbYvuzkfdGbpuN7jqZi0WGN1vfT
         R7DCz6skXwFHAwTdHu2GFhma5f8fqohlp24SH14y7KBDFmzQo5rqePCDkMFNt25PfKTL
         VB/g==
X-Forwarded-Encrypted: i=1; AJvYcCVjmVDqlA9+9yxZ8LTjpKWRPL7CkJNgzjcK1LWhheTtKdrmWtnEPdS0fcvBPzKsPhi0MhdRHMoI58q4IeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhOlUDd0uSYyKEiNoIUmDhS6CAD875CdZGUF5X/azsmwRgsI8
	Zbi4Jyx8cVTvYPItMlAq9G3RQUsQtUDdGn9Rkpql/1lGaPMldRimuTBpGcSWe6NmTrBTLmks3/1
	cEZWwImLwsOkIjmEmdkWqQvGdo9PtZ/+NXnviSaeejmzfHtitAQ5+tdDQIufaHsjaUuuTLRhP/P
	Ab2A==
X-Gm-Gg: ASbGnctnYfNyIX/mL5gaqK4P88KGWv2BtoZhriI/AEBOJMYb5aNEW5tGCiGL6mKXXBm
	5sOFqlUemngtkxcliQr9ZU/ZvjGTMfxoxfa3Gvz/GCuhTYXcNvqyagJ0rcmIJoa0nfher58yEuz
	b5Col0M7tjxVWPVQ9kaS+ZwubuoaYVWmA87pHoEbUzQAaJMxQG5n6DNlkjlY33JG1E9HVq3oj6C
	1IYg7WQAiftmP4xSMyTp7OJpdI/VXA/AIHNpbJEZoyib9vGU2qzdFaMdd2sTHvbXy8Iks02yGfn
	nFfh5sLPxGykuY0y/itFLW0CnqSwrw==
X-Received: by 2002:a05:6000:2808:b0:39a:ca0c:fb0c with SMTP id ffacd0b85a97d-39aca0cfb21mr1504921f8f.28.1742911994023;
        Tue, 25 Mar 2025 07:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9gu1kOTO2EMBz8bV0KvUy/lftump2d38xUsNj4Qewh4mTh1y9N8aE976C4YFTsdPfqCBOMQ==
X-Received: by 2002:a05:6000:2808:b0:39a:ca0c:fb0c with SMTP id ffacd0b85a97d-39aca0cfb21mr1504872f8f.28.1742911993506;
        Tue, 25 Mar 2025 07:13:13 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13532091f8f.29.2025.03.25.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:13:13 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Min Lin <linmin@eswincomputing.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [RFC PATCH 0/4] ESWIN EIC7700 pinctrl driver
Date: Tue, 25 Mar 2025 15:13:02 +0100
Message-ID: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pinkesh et. al

It's great to see you've begun upstreaming support for the EIC7700. I
read some of the data sheet for the SoC and noticed the pinctrl is quite
simple and could benefit from using the same model as the TH1520 pinctrl
driver. This version should do the same as the vendor driver, but in
less than 2/3 the code.

I hope you'll consider switching to this version once the basic
support[1] lands. This patchset also depends on that series.

[1]: https://lore.kernel.org/all/20250320105449.2094192-1-pinkesh.vaghela@einfochips.com/

Emil Renner Berthing (4):
  dt-bindings: pinctrl: Add eswin,eic7700-pinctrl binding
  pinctrl: Add driver for the ESWIN EIC7700 RISC-V SoC
  riscv: dts: Add EIC7700 pin controller node
  riscv: dts: eswin: Add HiFive Premier UART pin control

 .../pinctrl/eswin,eic7700-pinctrl.yaml        | 141 +++
 .../dts/eswin/eic7700-hifive-premier-p550.dts |  46 +
 arch/riscv/boot/dts/eswin/eic7700.dtsi        |  17 +
 drivers/pinctrl/Kconfig                       |  14 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-eic7700.c             | 802 ++++++++++++++++++
 6 files changed, 1021 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/eswin,eic7700-pinctrl.yaml
 create mode 100644 drivers/pinctrl/pinctrl-eic7700.c


base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
prerequisite-patch-id: 2e5cc67f66a8cfe463ec73b98cd17130d4094a86
prerequisite-patch-id: e39d6867f89c605fd1e3621937c8c91a6cfbe7c8
prerequisite-patch-id: 5d2232bb3ce3d7d4e23477c2ad3db30424fee33c
prerequisite-patch-id: 946719f43a0cc23ffe82e996e076de2221dcd8db
prerequisite-patch-id: c2c2bc1b676b1e15165e107515b380318e9ca941
prerequisite-patch-id: aa4a955dd99d0796973fedb78bea269ebab73b6b
prerequisite-patch-id: 1cd27ddae721cc1e6c52723f8b360b09b5e712c7
prerequisite-patch-id: 237813218e54e0c7cbed8d72e30eb649ffd9ecd4
prerequisite-patch-id: 8e687755e898e71c80b0294b90deac71fe05c421
prerequisite-patch-id: 05622d10a27ba9cba36b3d194e51a2d8d7b7b783
-- 
2.43.0



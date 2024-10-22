Return-Path: <linux-kernel+bounces-375566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6099A9763
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F6E2817B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467E7E59A;
	Tue, 22 Oct 2024 04:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY/019Aa"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD0819;
	Tue, 22 Oct 2024 04:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569761; cv=none; b=gr8lfRgPd+bj00wloW+G8w8ELaEgP3IoqO4ow2p3BJ5X2LKc6OWZVagrfYnEPcDiZXbx++DtJLA2vjCv9y0D2fdKhfo7Gmos+0xYkSs9eCQVVSH0X7ucQpXautVYKXcgj5BBoM3eNi0C6+bjDKhHgZQszXMjhNvZmoO+qDArLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569761; c=relaxed/simple;
	bh=OLZSz05aFhIwQ8zpiShDL0i7xibm/hFNh153LOz7+vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LA4Jce8EIO73VX4HWFaeSXsaBL3PsUTcn+qqsxYDhM3smnf1k1WkD3eHc6bXw3Utr1Bb/jBkM89le062g6RKIy6KPx57HrSaJ++GX3h911egUuWMX7VWz+cmCp8gqaIS8B6uNWQu1BKfGgMZTWjWscewUsR3VgsCPMYxGp2Y5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY/019Aa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e467c3996so3308276b3a.2;
        Mon, 21 Oct 2024 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729569759; x=1730174559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nea/uoG8iPW4a7XYpG+H39uNOfUSPgNFFD6MagPMBtI=;
        b=XY/019AaOLmZ9FyxsGlSGIS7uB0yzJmCQs59CTCM4Pn0+82Y078DoShQwpMTZo98sb
         9bIoP+Vcm0LQqe3kgm9Ht0y+H9uHsyHgrE6C5MtqSVEyJtggsRO7tMu4elhKm05WBkWU
         N53TvkE6BaP1h1LEP/k+TPkzlc2VGw1SicZFkfrdIUvy6cJ4U3SLDXWuZOsY36ytLuA2
         W1OgNU9SyyWTYM1EiclJQ0z+CFnpCI+1p2ZtSQl6rZ3cOifqrqcac9Te9Is7wcYidABK
         HL2EqvIH+fj85JPd6z0WbCKiBnmvMgL/Kdl8WTjaiXPOZKRlbD6n6lW0QBtGqijeml0y
         fO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729569759; x=1730174559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nea/uoG8iPW4a7XYpG+H39uNOfUSPgNFFD6MagPMBtI=;
        b=OIf3F4V9btOFeHse9G+EuyHZmocO0dLkwpIvoKeZ6s5sstkucUsy/F+hliLNYdMN+S
         DV4TIbrsmRzX2iLJOWp9oIPlCR+uQdTitkDKTZjTJMnlFWDapWQBrWhlas8wDF1yqbN6
         ERaC5rdnbZRTAooQshyj2b5zLbdB3gVLXENvOz/g/t0UOFjdKsvNaeTJNeI3kExCi3Zf
         0RxgFzg8NGVr4F7Fqddlai1cQYDIT8+/V4YspQ1Bvw4tlb+5gqxf5Eu5CIBASBJjNDi4
         b0CGWjpvfXprBF1fg1OMkdU8iKInzxzc7d/46fkwh5xAi+oOaC1+tTkmwwhzQooGbVl3
         qrEg==
X-Forwarded-Encrypted: i=1; AJvYcCUujKkmv7uNyGdukZxa0akOJuq0XPbGMhL/dlhduJiaop9RVJYoUTgI3r010bgbuL5eISLdRc0pjTB4@vger.kernel.org, AJvYcCXFekB9nE+6zTdZHUqBVmfx9VNgRJmsU3ujhme0ucPM66MSe89U8PdJ0PTxUlyLXKgDH7VBswwyfbRi/FBq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2S2io29eV1IU2Zo7fy8PmuESxV96B7A/RNDWZ9CCZfBiPnJYX
	kVX5bnqJd3TF2O7wx4bLzaYyl/YFUxMbuohPlA3d2andeW8Xuk7m
X-Google-Smtp-Source: AGHT+IHNtZXGUiNVcCrwfzac/NGxd/pCUL64tbYSFBn9zGC3zRO1Pl8NFNRTEdokdy8Jo0pfuy/WvA==
X-Received: by 2002:a05:6a00:1acd:b0:71e:74bf:6b1a with SMTP id d2e1a72fcca58-71ea32d4226mr19927835b3a.16.1729569759299;
        Mon, 21 Oct 2024 21:02:39 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d7478sm3713087b3a.128.2024.10.21.21.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 21:02:38 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/3] riscv: interrupt-controller: Add T-HEAD C900 ACLINT SSWI
Date: Tue, 22 Oct 2024 12:02:14 +0800
Message-ID: <20241022040218.450573-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New version of T-HEAD C920 implement a fully featured ACLINT[1] device
(This core is used by Sophgo SG2044). This ACLINT device provides a
SSWI field to support fast S-mode IPI. This SSWI device is like the
MSWI device in CLINT/ACLINT, but for S-mode. The only thing is different
from the draft is that the T-HEAD version SSWI needs to write 0 on the
SSWI address to clear the IPI.

Add full support for T-HEAD C900 SSWI device.

[1] https://github.com/riscv/riscv-aclint

Changed from v1:
1. patch 2: use computed reg offset to avoid uncessary reg additions
   when setting/clearing irq.
2. patch 2: fix mulitple format issues and improve some comments.
3. patch 2: disable cpu irq when CPU is stopped.

Changed from v2:
1. patch 2: add SXSTATUS.CLINTEE check for T-HEAD cores.
2. patch 2: add select GENERIC_IRQ_IPI_MUX in Kconfig

Changed from v3:
2. patch 2: add SMP depends in Kconfig

Inochi Amaoto (3):
  dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
  irqchip: add T-HEAD C900 ACLINT SSWI driver
  riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers

 .../thead,c900-aclint-sswi.yaml               |  58 ++++++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/irqchip/Kconfig                       |  12 ++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-thead-c900-aclint-sswi.c  | 176 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 6 files changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
 create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

--
2.47.0



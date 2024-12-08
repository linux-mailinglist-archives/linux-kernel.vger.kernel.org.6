Return-Path: <linux-kernel+bounces-436424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB3B9E85B5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D837728163B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1612D758;
	Sun,  8 Dec 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YJyGvwrf"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5A817BA5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670445; cv=none; b=EmnRlZgkLgENr3SlxMyg2relSQhuCajGZB0kjN+MlAiLTuwJeufkIRSBzNj1ciIor1q/xn11rjm4hXfuAO9Jsh4aqkL4P4EoH0MYQdVMDTIlJwM9Y8N2CcD5eCYG9V1cMlr8c8C+JuIay8MHQoqdQjWcBK7ec2lMHmwrW4gxpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670445; c=relaxed/simple;
	bh=4kGHNi5zhuCfHWfD6ETa3uawIdxtgj743lywS4/nwEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLIRgDL0upQfBYckdNXZv7rWPJjYOaLhO1MaZgLbUN6noB16G6IsZguhNCQ8VcceYYv93A6CP3/8SapkCuAAsXlDmCgfdi962qvGNE4Kp/14nsexH/yeYAwlBhDaR8Fq7HF+BQ+qv28OyfUFQRIO1myFBzOeeCAzftaB6rUyI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YJyGvwrf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215ac560292so34762705ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733670443; x=1734275243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1Ymbf7OkgbozNLV0biXsSYspAvpz9yJ0j5pghYtlNA=;
        b=YJyGvwrf8ZOhgGfVZVIuySU7vA5oOyjOJDmCR2VsnTN3kmf4HkeX3gPpD9RaZ4Wvkw
         qfZ6DVrlZcF1QsV/pt93fZpSmfN0khc6MqRVBu5Ut7RyegX9vNb0DEBOoV9r96I8dZQP
         WTep5eoAk3LBl4GJ4EA1PTWRBg4CN972uUYWuPkMl0LZ1WEUKCDLh+RDEM+K5jMsCb5y
         ypUMNGmr5DJSen2MdYnKHx66ArqYM+wVn1gwqbZLrbrCrwenWjVT2GukhP2QBK3HXrCx
         U07nFw38+5wJYZZ+97IrW9gSXOLjL700H6fUSoGCoF6qNEs3Xjw2NMW6ib9kk02NyTC5
         Fvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733670443; x=1734275243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1Ymbf7OkgbozNLV0biXsSYspAvpz9yJ0j5pghYtlNA=;
        b=c9JKxRjbkjTZNei2nV44s2Rrm2WNvdy/AtFTBK7FOulDeilT75pB/ctcHsyr2M1ZQm
         R1QPqxjKJ+it81VWvL48WRR5PTWVNKFkhcbXBA/UMW+a0BhHGDlM4lTvnD+QSfOlImpe
         AiEdiNETJsFONh0tyraGu0w+O8k/yDhzLNpzuYkG7//FvewyYrk/HSO97aqFS4vv09JK
         Vh+lO77AMRyTrA52WsVbundyjzrkgbjBgsqFqVsD9u4YoSsHv+R/itfRkmMbdUoj7VXm
         Wq3jpfLMvCWr4AjtXP06YpNhl7kcGAquSWO0CmJSlHpHLMJyDgN+hEiBjP6+bwcxj8nq
         6Qjg==
X-Forwarded-Encrypted: i=1; AJvYcCWN38NuB2W21KD5C2snydqnliwKnk2yOThNfVP7ANLFxQsANxSAkEkA5niLSCdLLpsfmhF6n5tC9qi4rmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIQ1NuXRNxmMtw6HdymMICvr6Mts2G1RO9sN1pjdbeMPB3RfW
	VxFKBOmf9OwdksrP7I+UELcJ+4nsd2q5/rtWoj/QV8T614llbYYI7+hcDtW981Y=
X-Gm-Gg: ASbGncufQkzyMS3M+4gWIdDk4KOrpr+wN3+3ebjGoYqaMiRGdSOIWds5YxrRbntyIN3
	V6c4zYpLimoVtFMfORRf3QW/V57dhYs+fNSpCKM9UqG4wL0HE5tyPLnp1QYVw5Qv/EcXKEud0Oy
	bfOHa8/TALYeBsoKnDJJSsw6X7eML02wYJ6B7KAYKlWLnQ19V7iO8beACEeC8boz+UUUK53X5sm
	SLmvFzenktq3foYq4c5514Jt0ESbdKk6wDrhxIn1AbC3cCzUK71GWC2NMiuWomC5OTw8ZQw27LA
	0bw8I0nO/jVXWN4=
X-Google-Smtp-Source: AGHT+IHVg6kIJU/hjxCaltB8c3VofoPFS72J5bvbHqE3/3XeAkWqN7rWQDnyGstJdvLaD8pQZcM2/w==
X-Received: by 2002:a17:903:24e:b0:215:9d29:9724 with SMTP id d9443c01a7336-21614dc51d0mr152817175ad.38.1733670442680;
        Sun, 08 Dec 2024 07:07:22 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([223.185.130.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216412293d2sm10274515ad.237.2024.12.08.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:07:22 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/4] Move RISC-V IMSIC driver to the common MSI lib
Date: Sun,  8 Dec 2024 20:37:07 +0530
Message-ID: <20241208150711.297624-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is based on recent discussion on LKML:
https://lore.kernel.org/lkml/20241114161845.502027-18-ajones@ventanamicro.com/

It primarily focuses on moving RISC-V IMSIC driver to the common MSI lib.

PATCH1: Fix for handling non-atomic MSI updates
PATCH2 & PATCH3: Preparatory patches
PATCH4: Main patch which updates IMSIC driver to use MSI lib

These patches can also be found in the riscv_imsic_imp_v1 branch at:
https://github.com/avpatel/linux.git

Andrew Jones (1):
  irqchip/riscv-imsic: Set irq_set_affinity for IMSIC base

Anup Patel (1):
  irqchip/riscv-imsic: Handle non-atomic MSI updates for device

Thomas Gleixner (2):
  irqchip/irq-msi-lib: Optionally set default irq_eoi/irq_ack
  irqchip/riscv-imsic: Move to common MSI lib

 drivers/irqchip/Kconfig                    |   8 +-
 drivers/irqchip/irq-gic-v2m.c              |   1 +
 drivers/irqchip/irq-imx-mu-msi.c           |   1 +
 drivers/irqchip/irq-msi-lib.c              |  11 +-
 drivers/irqchip/irq-mvebu-gicp.c           |   1 +
 drivers/irqchip/irq-mvebu-odmi.c           |   1 +
 drivers/irqchip/irq-mvebu-sei.c            |   1 +
 drivers/irqchip/irq-riscv-imsic-platform.c | 155 ++++++---------------
 drivers/irqchip/irq-riscv-imsic-state.c    |  27 +++-
 include/linux/msi.h                        |  11 ++
 10 files changed, 87 insertions(+), 130 deletions(-)

-- 
2.43.0



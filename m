Return-Path: <linux-kernel+bounces-532849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7627A452F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41713B0AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D5217705;
	Wed, 26 Feb 2025 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8SBGMKM"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C8217671;
	Wed, 26 Feb 2025 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536078; cv=none; b=UO+SbFS1yONUNwUe/CkexIE8vxl3Cf384kEvIMg0v2C01o4CNMXKIM5L5x3jVpzDyHEcKATvTlUIT1RcXb3PrfXZDHSdE595agILq8ZeJW97hw7llYgt1xeVlCiBCw4IljZaOcsWOtc2hWEvh80h0BUcADUYEJcDkfEaCCyZMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536078; c=relaxed/simple;
	bh=5uqXaEk+IpsKXRqu3IBaXsheADHvz8Ev3MCwYfOyebU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=U8k8EbyTamBo6AHAYObyH5/uyl1nPvKKEg3NSlAIrfU/ZC4Bv+lQEAssUXx/3KzQ/RA+d3v/ncecb2gOSd6ZulpzWNYuzio8udMJynNMz+xAaZw4EHcCaV8gKnytnIerx6x3IYn5ZC/cHtgFVEy4/TxBNeb9SFF9jMkiuQ8mcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8SBGMKM; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71fbb0d035dso3736586a34.2;
        Tue, 25 Feb 2025 18:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740536076; x=1741140876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ce/2iYbpTG5UcLrAgQquEoIlxzVy1ifFMugXMkqkJRo=;
        b=c8SBGMKMWA4o0zmImZYSgEmAGPvfurBuopOahQdtlyKrS6E056Cooioqupiadzg0TA
         Tu2rWPua0yg65IUTC3ZMOyT7epPwxCx/zeL+do+xBmiNlNCObi4TzWSUL3sxUpyK8Y11
         9ajq/dtJPUZTS7jiPntNaOEebAwRA4CWrNUhlHfEr6kFb4OdnTcdHQolvjB4R/5yXkYQ
         agEgWHcTqiBjoqNZVAVjcXjsRJI8E6qThZVAH98LEExgAG6ESXV/MPTGTHKY1MuB2ED5
         DR2BKNE5e9yG89HZllBqaLTKJ33EzI6Fmpq+Cg2dOFuagkYYquhBfu43sirOtLqIL0Zo
         IIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740536076; x=1741140876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ce/2iYbpTG5UcLrAgQquEoIlxzVy1ifFMugXMkqkJRo=;
        b=GJnXnfQvrUgHkHhudUEBYKuqZMUMzi+Yvvw+WxPuycVZCdnAAXOovqpm0Gy32kfJw0
         S0tjpLN+6SLiQDvwK7IMMc6D1Zv8oY7obR7bIXDBWRk2o2dcc6lqEYe4AUz2Aw5FCxWs
         NeLVed9m19IdRukvg3AV3pGziGpaPzZ9xT57TsumLEcYlI9UWE0jL93qjGsCawCnDYGs
         pje0f1Wm8Ojgv7piNrLC6jbBu84TQgX8Lf1J58NM+uVMsme0LcjU8jpzeScchxQA/XeW
         /e3vBS6PGYQsSjpgg9rXa5iFaSQFbIworVfT2JBsongM2EdWtzr87CPDgl6PEXTiUHxC
         /YOg==
X-Forwarded-Encrypted: i=1; AJvYcCUbB6aT/VnkvzMwPjeSxPPapZqIC73iw58wbNCB7UJxwNukme0TWWBeCsdzP2C9dZOF9ivsD9g8eAkcbdCf@vger.kernel.org, AJvYcCXBxDanubl+MHcTIqpWAhU1oG04+O63YtDq17/WUNqkYPcPfKD4ut4CJsJrkL4AQQwWI+Q18jdyDLpG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2phWbg+ZAu2u2qgxRj17ZOJdMOdquBRcnbrEAlun5lxPccdow
	vopHjhZtMDuaTw3W5OFBkxxlSQP1wUxm8DIf0sdqtw55tWXNoGSD
X-Gm-Gg: ASbGncs6zW3WH6wpg38zdoVVQEfxtCGkH1EBcb1xLnazKLGCxdO/4mQIelQ6FhPKkr1
	IEHZSaff7IGYOPh57a1e/+LjzFXVKuNdlMvFhlW2S17Fz5QH8PeftCB1w8lRdkvGs+/A8nZa+ly
	7ydQUpnnM7IkRj0mDCPEvXVbs9vKiacNFyeCH6YaF6oMNJHAL59M5JJkzX64IsQZf++TfPCe4Tf
	v9BGE76HEEv3Gzh8zfXqPbf2CadKsrXah1JBeaPfkPmMq6kJKL0x4TEQLRdwrJQXuqx53J2nkF4
	pjd0dx1prvqIkVuRrWTgbdWdAwZVEz5dEjSp
X-Google-Smtp-Source: AGHT+IFOiWy5c9aRJlo48U+AxlgoisXf/mCQB2vOucCr0Uu56NK3CF2uZpGGkC+NWk7CxG+H2wQ0hw==
X-Received: by 2002:a05:6830:628a:b0:727:2740:eecf with SMTP id 46e09a7af769-7289d0e367dmr3920392a34.3.1740536075919;
        Tue, 25 Feb 2025 18:14:35 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289dee9c6fsm539210a34.32.2025.02.25.18.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:14:35 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH v5 0/3] irqchip: Add Sophgo SG2042 MSI controller
Date: Wed, 26 Feb 2025 10:14:26 +0800
Message-Id: <cover.1740535748.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

This controller is on the Sophgo SG2042 SoC to transform interrupts from
PCIe MSI to PLIC interrupts.

Thanks,
Chen

---

Changes in v5:
  The patch series is based on v6.14-rc4. 

  Improved driver code to directly get PLIC node from args.fwnode as per
  comments from Inochi Amaoto, thanks.

Changes in v4:
  The patch series is based on v6.14-rc1. You can simply review or test the
  patches at the link [4].

  Fixed following issues as per comments from Inochi Amaoto, Rob Herring, thanks.

  - bindings:
    - Update sequence of "reg-names".
    - Remove reference to/schemas/interrupts.yaml
    - Add "#msi-cells".
  - Improve driver code:
    - Use fwnode_* instead of of_*.
    - Some other coding style improvements.

Changes in v3:
  The patch series is based on v6.13-rc7. You can simply review or test the
  patches at the link [3].

  Fixed following issues as per comments from Krzysztof Kozlowski, Samuel Holland,
  Christophe JAILLET, Inochi Amaoto, thanks.

  - bindings: use reg for doorbell, fixed wrong usage of additionalProperties
    and misc. 
  - Improve driver code:
    - Fixed potentional memory leak issues.
    - Fixed some build warnings reported by test robot.
    - Optimize and simplify the code when allocating hwirq.
    - Use DECLARE_BITMAP instead of kzalloc.
    - Some other coding style improvements.

Changes in v2:
  The patch series is based on v6.13-rc2. You can simply review or test the
  patches at the link [2].

  Fixed following issues as per comments from Rob Herring, Thomas Gleixner, thanks.

  - Improve driver binding description, use msi-ranges instread.
  - Improve driver code:
    - Improve coding style.
    - Fixed bug that possible memory leak of bitmap when sg2042_msi_init_domains returns error.
    - Use guard(mutex).
    - Use the MSI parent model.

Changes in v1:
  The patch series is based on v6.12-rc7. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1731296803.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1733726057.git.unicorn_wang@outlook.com/ [2]
Link: https://lore.kernel.org/linux-riscv/cover.1736921549.git.unicorn_wang@outlook.com/ [3]
Link: https://lore.kernel.org/linux-riscv/cover.1740116190.git.unicorn_wang@outlook.com/ [4]
---

Chen Wang (3):
  dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
  irqchip: Add the Sophgo SG2042 MSI interrupt controller
  riscv: sophgo: dts: add msi controller for SG2042

 .../sophgo,sg2042-msi.yaml                    |  61 +++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  10 +
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sg2042-msi.c              | 258 ++++++++++++++++++
 5 files changed, 342 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.34.1



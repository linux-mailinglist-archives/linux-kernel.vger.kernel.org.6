Return-Path: <linux-kernel+bounces-525200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB395A3EC55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A194917FD99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B831FBEA6;
	Fri, 21 Feb 2025 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njcfaLPw"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902B18D65E;
	Fri, 21 Feb 2025 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116988; cv=none; b=D6AN225jOKbKs32OWALoG+wCrGpWvdHhHFPeZhoq8xmwBMdl7+i/IJAXI5sgkvFQPYNlejpWrud93YrCnzTAbibt87+sr4MyPri3BGllmcWhJPniPJj0KHPCecNKD84ZGZnE1oT2lYK62Iw6J0CyLTzzWEhA2KgRGyj3nmcPSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116988; c=relaxed/simple;
	bh=zc+ftY8SvwgAh4E7WyCK0+I4n9rRDrbuKpBxlRiF8vA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Qc5L+ZvC7T0cXfCg2lCVq1UJcFhj5KoXNr9tOxyTdHVxGej0u/y9RNaLechk3F9zZndvnwj94vEhgpOnTzbfE8nRHJDWlbbYAS+j0yvCSfFo8/9J2NpgNwsVk7Hg50bY8dGhOJ2vOECznJMZBfXG3aYjUs2EJko+EkvIxoSh+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njcfaLPw; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7272dae0604so872637a34.1;
        Thu, 20 Feb 2025 21:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740116986; x=1740721786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BCavblbMoHmD+OWEl2E4UCrJ0dCMxRnLcf2xtCAUbD0=;
        b=njcfaLPwpHOzDJV6bW67FhS4jyzvL+ZrAsH1CZlKS3fPekDmSm9ezVcd+c3P6NrnL3
         gopFzD984C/8ZOIws7YFLkJh/c9o4ZbqNhosh2u2hJnLZG81cwHpaI4TeHts/GgbNr/v
         oXdI5Ul7hlL9DVq9K7q3ytCnigyxzY2t9bjriZ3r2VQZXYtO/xU4D8r3pHjsyko874Eu
         RA/hLnZLr+626aSEZBUL5GYiNd+D6A70y7Ww4Ru6fzBPO+IloYHBM1MV50Q83IrlBj6I
         kqaFwz9JwLxUHn2LW+ngTRBFlOMMp2ln/9D/uTNaxGV6IB77784pqG3poY64GsD/FDLO
         iQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740116986; x=1740721786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCavblbMoHmD+OWEl2E4UCrJ0dCMxRnLcf2xtCAUbD0=;
        b=kFU35cB/zR0pzZBVsG3DQVYygvvo/7zavWToVMsecW5JiKopuNsM8S6BVnPiwyUnHU
         aBWU2t/keEM2t7MAP3+R2z3qk4V1ewT/GWqPBOk7WXC0HoG1+avy4BYY89OgDtmSlkGu
         mmJyXxdIbx5f5qYdwezTxUze36j89gNUL3nmG3VrBhDdBiaG5t6qXZkXP430Fuoq0DTL
         XGjpItZ8sYCdRGBu2XOVpsF0hwBeDZP9hXgnUOWTL/4+aQBAeeYe6wNgEo1I43GwgvAj
         2NH/g4wGWO+HD/Wiz0H5do3xW0zHjhFu70yoROM4NoeehOanbeHZ972fmCrRIj8xdQ/n
         mWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoAKwIIvObqOPFHTBieNG2Mavl4fkRuNvVnJHbRPbaBM/U93gFrJc+9zNVkM4wc+3D0GVKXGByDq4y@vger.kernel.org, AJvYcCW/JG0h1RnXrtNluVsHaJ2ohJrS8c1OzORhKlWpAC6U4E8IJ6+sT/dBFj6GQ5zFlT2anSx6HuQyvQ36iL+T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3v2p6urib2HUJpNAhNO/lcz31StrD861rx4zGEBNcdhpM/vs
	4o2wHIi1HEq0MTcQZYZh9Ei+xdALuKDB4wvmWXnwJrJKcZ/jBF1r
X-Gm-Gg: ASbGncuEZYA9MfG5b5jV75WT9w/8VADjseapb56HYWRkmSK/c5Clp2uMrD3BBJKXShN
	jAnshksB5FARWIvnmGRCcxSUnrR2R6obbzPf4NRVstlMMdz0Pwnt+/FfR9orB5s779++L5TnDU3
	9vREFd5gCpJg7HRWU7X9zG/rHNnMbtsAG4dAytqPv/OYbOreA1w8n/2gEmEXrr0SWQ0+q3IuPMj
	6U/V68Lspk/76CwAq9yMkYqUJp1X2CbOqnRjBHDZuYjet9jvGarGmL60fWZs3dU3F/ncOMX7xEn
	dA0NXoLLL6tQBqaBy0G9j63kFhaLxiVzTJal
X-Google-Smtp-Source: AGHT+IEIbRjoWeNHOm3Cl1YrZmaUoHwxP+dMPkuDZtG4zQ0e4sUMxBmAIIJDZYUwNMixpn2BSGXgGw==
X-Received: by 2002:a05:6830:925:b0:727:413b:ea73 with SMTP id 46e09a7af769-7274c4a23c6mr1244314a34.3.1740116985578;
        Thu, 20 Feb 2025 21:49:45 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fd0645aadasm889207eaf.6.2025.02.20.21.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:49:44 -0800 (PST)
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
Subject: [PATCH v4 0/3] irqchip: Add Sophgo SG2042 MSI controller
Date: Fri, 21 Feb 2025 13:49:29 +0800
Message-Id: <cover.1740116190.git.unicorn_wang@outlook.com>
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

Changes in v4:
  The patch series is based on v6.14-rc1.

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
---

Chen Wang (3):
  dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
  irqchip: Add the Sophgo SG2042 MSI interrupt controller
  riscv: sophgo: dts: add msi controller for SG2042

 .../sophgo,sg2042-msi.yaml                    |  61 ++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  10 +
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sg2042-msi.c              | 264 ++++++++++++++++++
 5 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.34.1



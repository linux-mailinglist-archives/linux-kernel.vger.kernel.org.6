Return-Path: <linux-kernel+bounces-357971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F79978A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B2B1F23C42
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9461E32A4;
	Wed,  9 Oct 2024 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKPGgvcN"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94015D5D9;
	Wed,  9 Oct 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513871; cv=none; b=ctASOsFOXlvKO8mKlM45L7fD+DCAlqIphClWHFgKC1VZGAv3MIrSylD/Hu73pw1t2q4pxMB6LcH9SYVREFQ5Kw/FYo9om+rSTnD2ewdEmJY/t2jEayUhyL5rd9jXL44YCZR54x3Sl5A3myQk5MkYhHVn4beaCBC5hfXs5x/yFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513871; c=relaxed/simple;
	bh=csKy60WFknYDFdbcOrNDM229xILpnCaxCTHpQ08ujTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWmY9AmWI1VCjhKZGXlod8merQljotpbCWNdQ77T61moeONVqa/vDyDFwCk3ClTVjGI+Xo10OiKZOe+kAXGJiIBf6HKy23B8ioo/McxwXyjSeMpG8MP0kA9nlSfPHu8vQFUPGPUqCMw955mlPTFJpeL2spuNwPbvGXdJHghYGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKPGgvcN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso239349a12.1;
        Wed, 09 Oct 2024 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728513869; x=1729118669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAqV1+XKBU0ibZzTqowSJdJy95bA/qKE5pksfpbym7M=;
        b=aKPGgvcNf0KzLyuaa0NR4741jkpLL4N1J41WkpFWGMK7I+2gM2mNqhNiDqo7qJ3JlM
         vYKyQZm3VjMt9hLk7p9AU4WP6Y1WNnGHB0RqaIOqFb9qw/fYMsbIf1bWBCmEdjXol2yU
         BGjCQH4YTjty4p+UpyyRTLoGoiRnqh6TnV2wGmwtadga4vRUa9IeZ1iKFlUza5BVgQ/e
         ztdgS08TkIRe1e17fK0SOL4uYhjRuZvTSJI8fvxCoQ3o44LiI/igaSzua7x1OdyndlOE
         cNGOT5DIKW+FZndnLuIfcksJ/mWZIAId+4q704VYHW4DDvaHMxkaHzPgbz0DXzLb61NP
         08yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728513869; x=1729118669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAqV1+XKBU0ibZzTqowSJdJy95bA/qKE5pksfpbym7M=;
        b=PdLbiRvlQ6S063h5CFYj4vIJYG5HZURTUy9/zdSf6hBrUjMiYFBgNPHpsJpdPgbPAU
         B01pJKSL7FCKbJx5Z/ua//Jd9pdIF3FA+Zu3+mqyHjKA5uMHR4yBWKyBo0waQUP1Td+Z
         XGpds9vsagF10AsbqORF80G1HAfiMHdo93+Ff4VvZNfnMig0T/Zm8+OBO50tJBgK7KVJ
         Bc9FHh77ck4cQsCjeYbsYlduUVL20eJs89vIV4uBRTubLxkfexWPR4KycxpW9Q33v9aO
         vDlIVuPEORakgZ8DNZClzKNm33+zuoOWy6ybJTHbBuK0VLUbYGYmkAmNa6KrOvG8roNc
         Uw4A==
X-Forwarded-Encrypted: i=1; AJvYcCX4Q8HbRYfPg9PVkPsHsv/EO43SZG+KcRecLEws66yN+iLbD8lHbz97ZdUElWE3M7gU/Zkwpkk6itJG@vger.kernel.org, AJvYcCXtaGgnPRsJGj4FiMAs8Wq8rMpKRuALBUNOi0QofxmrcF3JK0IEOs4hpiFhYN0jmn+yuNYCugPeku1NE0Y+@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1BhQAzYdrGvZi/h02wnaDZHLxVKfkBlkJczNW7qp0w21ysbN
	nN1FYrFUH7kc6v6bNhcPjeapDkUIlo8w/emm/QuIMlZAlh4nt5tn
X-Google-Smtp-Source: AGHT+IFatcjWm8UlaGOqXGTu48oCcmbyCPQ+LLWHuq02vQyWPDOIHrcrLuyoAOJ4nSZV/zbICyHHwg==
X-Received: by 2002:a05:6a21:3482:b0:1d8:a1dc:b43 with SMTP id adf61e73a8af0-1d8a3c1e436mr6326797637.24.1728513869388;
        Wed, 09 Oct 2024 15:44:29 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47edfsm8237666b3a.128.2024.10.09.15.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:44:29 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] riscv: interrupt-controller: Add T-HEAD C900 ACLINT SSWI
Date: Thu, 10 Oct 2024 06:44:06 +0800
Message-ID: <20241009224410.53188-1-inochiama@gmail.com>
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

Change from v1:
1. patch 2: use computed reg offset to avoid uncessary reg additions
   when setting/clearing irq.
2. patch 2: fix mulitple format issues and improve some comments.
3. patch 2: disable cpu irq when CPU is stopped.

Inochi Amaoto (3):
  dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
  irqchip: add T-HEAD C900 ACLINT SSWI driver
  riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers

 .../thead,c900-aclint-sswi.yaml               |  58 ++++++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/irqchip/Kconfig                       |  10 ++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-thead-c900-aclint-sswi.c  | 166 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 6 files changed, 237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
 create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

--
2.47.0



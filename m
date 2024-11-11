Return-Path: <linux-kernel+bounces-403561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445C9C3739
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B541C1C2106C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024D148838;
	Mon, 11 Nov 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXqI5LVR"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B02595;
	Mon, 11 Nov 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297686; cv=none; b=OpFEsho89Njzszvo/vFw4kmlVq4ZOdjQjIWavYKBqjxYqAePz9AauUy0n8pyDNeDhNtAPWT3XIq6H2+W8TXtLugDVhD+54ddDd+EbNSMk1z/3gulDJrPLVs2BWLVJ5CZXZu98/w0LFAIe+jLCGNN6JRkHCDPmWeXEdErB4mSksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297686; c=relaxed/simple;
	bh=l44EnT1b015bbMDywEHP9XMBLv3778FsGTDMvcCV9zc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=WUiShi4TqCpz8+ecDX7l01wh3hbPM1stCW4Do0GLznSeYRGMAIdUC/LMQu2t2zXhNL5aBMskpNOnH1u9bBvhK31QMkR2B/jjgI+imdSLG0311PTf/IxQMKPHy+UIbteR3hX8a15zxqwJT6+28tGprcNsF5xRYBq8Rbx6BYiDKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXqI5LVR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-715716974baso2593431a34.1;
        Sun, 10 Nov 2024 20:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731297684; x=1731902484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hy8jT9Ue/QY/D9ejeEuTCpC9OQ+qg6j+m/BJDWm3iVw=;
        b=TXqI5LVRwtGYAcU1xvv8rWmYI56HdnG6oVi+v6IAgBG0Zf9CTsn5WazO9H8EnTpw7+
         2V6F91gE1Fh9znQ/ZxNYK5XISlwQVLYQNX49ZASbPe8z2u/U68GNwP2JeFMSPK3LsCD1
         fe/xop0GdZnLAPdctfuw8QuPm5Ch3oh+WoVWNYDkscxfYxk9spj1YX+5Xd5ffk/a04AA
         bwPR9B6bcgfSROP3zfqaMn6ogltn2n9AF4h/899YBxPzmZzXMs0+FecTgHiPnXu7PUj7
         8IqGZWzAJEC3rSVyfTw3jkREr0658cMtXGIzew/zrOzjtG6RRYZkBUk37HN03kooXxf4
         4UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731297684; x=1731902484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy8jT9Ue/QY/D9ejeEuTCpC9OQ+qg6j+m/BJDWm3iVw=;
        b=vsvAqLwSjEfFVnqaxvQUhQCP34CmzQ+GCCtmVxDQ/ieJc5mORzciSo95pEhMd849zF
         snkzmfQRAz81AcJ0HH9ymWp5pD5a67nkL6zZgFsXB/plGayKyfJ0CFnBIMKE9vOxFMgI
         yblfU21U4CTMJJJ5xdqNQMi7QCVgBScbexzCO3loXvSueuu0N7UU+fIkbJXtYtumoNTx
         Fw0ueP5Mnwtprmu3r7PQlOgkk4C+Lv3JfL8YTO8T+oWNHOhJ+/7M9sKo2NjfaHkKk9sF
         8bjgte+kGhzX0qwy4Z1Wxvo7+jRgbmnphCemyKh73Sfxt+8WKzLcmXhQbcnc0sm61WL3
         1Cng==
X-Forwarded-Encrypted: i=1; AJvYcCUC8GzwB3264DWUb5CYpJixxQIodh2I0OgjSJ50GTrMJZJMqqBsG5MXdTFFlK0eFY+FCUh8kpn7o3jpPZvY@vger.kernel.org, AJvYcCV/+7et/Fa2BOqLEUG9TVXPxsjaTFz4xRFsXrXLFa4ba8YjlmRqmnloFz+X/NR5PGwbnFSiU2nRCCMK@vger.kernel.org
X-Gm-Message-State: AOJu0YzZZkWaOXMvTSd2dBDH8x1kFl8YUomUAGHp9nYGuXbGep6BNVYq
	9g9u8pacdWZR1MSYDM4pY2/vFWwv55NgNfkdFAg9zI9XXA4oiTea
X-Google-Smtp-Source: AGHT+IEU0F2CPMWmhtTpRyOGW29QngOAi4sHzqAOqOtg2OfvHnGdY/3OvOLJcSlVD7vH7oOQ1i8hMw==
X-Received: by 2002:a05:6830:600d:b0:718:99a0:2168 with SMTP id 46e09a7af769-71a1c1de347mr8513477a34.4.1731297684455;
        Sun, 10 Nov 2024 20:01:24 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a109210d7sm2107427a34.60.2024.11.10.20.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:01:23 -0800 (PST)
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
Subject: [PATCH 0/3] irqchip: Add Sophgo SG2042 MSI controller
Date: Mon, 11 Nov 2024 12:01:13 +0800
Message-Id: <cover.1731296803.git.unicorn_wang@outlook.com>
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

Chen Wang (3):
  dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
  irqchip: Add the Sophgo SG2042 MSI interrupt controller
  riscv: sophgo: dts: add msi controller for SG2042

 .../sophgo,sg2042-msi.yaml                    |  78 ++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  13 +
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sg2042-msi.c              | 255 ++++++++++++++++++
 5 files changed, 355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.34.1



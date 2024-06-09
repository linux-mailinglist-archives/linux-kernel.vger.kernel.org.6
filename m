Return-Path: <linux-kernel+bounces-207314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8A6901578
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 12:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACD11F2145E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B2208A0;
	Sun,  9 Jun 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvoD8d9a"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3250E57D;
	Sun,  9 Jun 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717927647; cv=none; b=Tk5Y2gWBR9CouLu+Vb3TasQEAje3TYGEQxfKLj4ta6VABkR972FUlR6rvjLpyoG5vArtWo0GeNDY32HqImYBaKZBqwOnexf5HQBfOfZdO/S7js3YWqQrz4nIZfKKonVue+E4A+KlKh2zJ3zjc8yKzTUeljwI7WvOHtoeauE75bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717927647; c=relaxed/simple;
	bh=7ZEIkaa3ksksA6ZUHuB9fHe3Wm9FOY1xVq03Fjce+hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJSLjN2kLp6pI8r6Oh0u66jg1SssPJSMUiFK38jBInvrXSoY4pBZUle/PSD/vpfnFzO2Mb3aV+VOIMp5Poz4ftRGOW8fYTD1mBzQZD7jhPze1OJnID+OgVrZJ/8yvUayV/1Kx7vEcmuXbxjcdWbfrGE0iP+4yZNwWekPVBfFLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvoD8d9a; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70421e78edcso1051853b3a.3;
        Sun, 09 Jun 2024 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717927645; x=1718532445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1KQmgUjsSgxrwDmRsB1VpB7+C1g/y/pi7A9G0zDFo4=;
        b=LvoD8d9aYBS57+eDx9B6Gi4hrBADB2yhB3wDytzYzt+epFUX/GJ1vsOp+Mz3GW1/sp
         j5+V/wwImS2ohRzuK/yzt4hAxTRJbcEEJYBg2s/XWzb2Pt4KibXza2qv03+7mU1CqUHz
         bvmwfCsQAEo6NqoBmu5P8mcnJcfGfJF58DG+pKmx2ODLaNqfFyBIaMO7ZhWwZogD5x37
         Yxk13+SbM5cNd6fxlXxmMCF3FkKhImRiQvNeTpZCuV03obM6YxJzFCWl4wJBiXjI6hDK
         zldJBeOM7OFB9gudv4muWIna0S4A0qc9paRQ0tPg0Jj5rN5d4Acsjs92gIfkd07p8KkI
         tAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717927645; x=1718532445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1KQmgUjsSgxrwDmRsB1VpB7+C1g/y/pi7A9G0zDFo4=;
        b=pkE/EnCqIAz+ZJuhigzPRDRRbYr6CaWzgvO2YzNwg61jrdY3xPcyhagaSsD9ly7SsZ
         /RbIUn0NMPzP8y0heY73dSPl9GqbkjnS/G260Lird3OBAmgxRmK85kwRIuERcVil0gnc
         8NFPrwPdQp9nRe/SFZZ8cGWqjS1z6P87Nu8pAObdiqmE3UtehXLdUs0Lf1zlRNkIxhvN
         cosVGfUtrUY8v9kcjIq1AJur6vfIeLSeHW0S/iKvdXEoqfOBeqExJpsxaJ/E92TzKvyx
         eeUBZUXXqDijHM1+WlyAOM1tYtKPBH+W4sX/JEXwNE24UXTamoAMkgLZEpALi40TvE/3
         q/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVaWJekW6d4z4KQ7/ZV2nDU8unaptqPAS6mbBJvo+6/3lx8l7G1PY/xh6sz48+uyABS5HHZff2uqsZ/cvb6CQYpMmZqpsUgzL+j8hBbVoTyWVDvel8uOz6AEPt+vWHv8lFr8+cwFLtstA==
X-Gm-Message-State: AOJu0YzFn1scUR3R5Q0lrAY+uE2/NQitsAct8a5JhxUGxLf3SVBO+pEF
	CAc3sAlhZL/Rxd7/Logur4rytSvn4rYKhWXxPTt90z+0Ez0iP4N9
X-Google-Smtp-Source: AGHT+IFnXhyUdifmCAO15Ff3pBz2EwzIgiSNqt12ifD8++2AaleAJtT7cLIo4Ej82lah3QaAY6MQ2A==
X-Received: by 2002:a05:6a00:1409:b0:6ea:b818:f499 with SMTP id d2e1a72fcca58-7040c6a58a6mr8264994b3a.19.1717927644931;
        Sun, 09 Jun 2024 03:07:24 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1cc9:92b2:ce0f:ca96:5cb0:62e5])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041c78ac20sm2817534b3a.154.2024.06.09.03.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:07:24 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: kanakshilledar111@protonmail.com,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc
Date: Sun,  9 Jun 2024 15:37:06 +0530
Message-ID: <20240609100710.85055-1-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches converts the RISC-V CPU interrupt controller to
the newer dt-schema binding.

Patch 1:
This patch is currently at v4 as it has been previously rolled out.
Contains the bindings for the interrupt controller.

Patch 2:
This patch is currently at v4.
Contains the reference to the above interrupt controller. Thus, making
all the RISC-V interrupt controller bindings in a centralized place.

These patches are interdependent.
Fixed the patch address mismatch error by changing DCO to @gmail.com

Note: I am sending this patch from a newly cloned kernel source.

Kanak Shilledar (2):
  dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
  dt-bindings: riscv: cpus: add ref to interrupt-controller

 .../interrupt-controller/riscv,cpu-intc.txt   | 52 -------------
 .../interrupt-controller/riscv,cpu-intc.yaml  | 73 +++++++++++++++++++
 .../devicetree/bindings/riscv/cpus.yaml       | 21 +-----
 3 files changed, 74 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml


base-commit: 771ed66105de9106a6f3e4311e06451881cdac5e
-- 
2.45.2



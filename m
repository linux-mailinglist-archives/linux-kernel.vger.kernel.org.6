Return-Path: <linux-kernel+bounces-350005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998DF98FE98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191C51F24EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4D13CFA5;
	Fri,  4 Oct 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQcUlWWG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA841386B3;
	Fri,  4 Oct 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029176; cv=none; b=nVe+HZUOXxokCsf1nDULBz5bNoOoTzgGzy3j3rZcu/HKJhPoPSE0E/9GBWqoAP7vOI+GzgrIL5U+m19618oV1dSDfU4sFQoxtF7MtguNNg+YzafEzDzwXqfMX/r/HkaVZ+4nCIUqq91K/8pnltLhZQrIasbPqT1naOZfEPSzZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029176; c=relaxed/simple;
	bh=0HjU+ifdPcwtuKUfJST6QYBiE/jCS2KLfph7v3/0kg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWlVzhF0k5lKLM00uNw6Hh2oFtMtwRTf61gJtJZINL9rhMhcaFv12jW0PYmslSz3X3P0tOpqYfgwCr3NdEH4NTfYu975y/KQ+c+peylTBXmTl2qsoLjcWuqnP5SinGm9zKDQMJtJ1m5u+t0BGP98BGWGzBglWRRjlH5bnDTVzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQcUlWWG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d704704aso1727137b3a.3;
        Fri, 04 Oct 2024 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728029174; x=1728633974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIVOVxu9XfMaLlpy1+QMdcSq5GsuEzAvbsSA/qxcZ88=;
        b=VQcUlWWGwN0dirdb1qZp/DuGnh8gGYPyjLkZMypJgEQWmv60v7GP1+CjryVw1A1YVU
         8w1Dq79UraweHzSm9A56O96MKrNVFGXv4xvDn37I5WE25K68y+jjn9ghvrNb7l7ELwpc
         LQv5/ohXX6eJHodxbMVjaTKP9cjt+vNhySyC5MXby2lEnDnoCPzo3GTFBSi1MKOxJyMj
         IXoytt3pe8yGgmmebzejJlN+Cj8LnEPhsyxTjKim8p1UI0FN7svkoT4dTqXJcl4CxA8O
         Wjd92/K+TDmcw3VuL9yQ9J4lHC45nEGYZOHgPhzvdwhX4bRweIprWltz+pdGm1WSSipJ
         VEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029174; x=1728633974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIVOVxu9XfMaLlpy1+QMdcSq5GsuEzAvbsSA/qxcZ88=;
        b=vpNAinGugkOiEyxlNaM/jfmMUo9C9MgjZzLu+vEx/TQnHflXn2cpRVYPKbBrGLwGNg
         pr/00likRsWGb9+x9oXDaWRLNNHyYrE7ka1Zae7/fR8Wi869lA8HfPSuhs1niKUzZNTR
         1fGrkT2fgxOE1VYQDKJ6pIUduPOhru2g7ju/TSOLBjEgl/JzWgyFEiH4Wqm0O4wcNkvZ
         WirX0fLJ3b7U+872K5YvLF7WfrKldvVT5gjfNfGvMslhAsD/ADfV+n/k42QSZ9xTJuo4
         XWPoZccVLawMXNDusoAsuiBGVs9rPXjCMfwgcQnRnHOj7TFsopfxBjLRj0qyyLkMXQeY
         H9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5e8gNGEJQzjHB7CImHsSSs9Na+CdSCzI0vFTl+whGgYTCfIsy8h7hNIWKf5hoZl3+Jst48VkO1xk@vger.kernel.org, AJvYcCXynCxkfIOL9tkmfKTkaQo0rmuyJPWsWn1EDv8eu1FdvSPdWo1PcOt23YoTslS08rP1CeYCz9yhzTlcLbcy@vger.kernel.org
X-Gm-Message-State: AOJu0YyiBsYHLj5JLRXSuPImZ9Zo54JAxxP2kslc/8xxQhe0vWM/lJlH
	1EVh3EkyiGsyfeZL1Jv6HGwAE4CUqBHoFv6yxYwVeve83ru4fUFW
X-Google-Smtp-Source: AGHT+IFD93Hx9WdYcsinPCBU7f7jsifCqWXaRlWgBVZX2Aq7Tsr0QLF6mfhgNojtgp0wn4ICIS6pww==
X-Received: by 2002:a05:6a00:124a:b0:70d:33b3:2d7f with SMTP id d2e1a72fcca58-71de245f650mr2912648b3a.26.1728029174386;
        Fri, 04 Oct 2024 01:06:14 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb138besm1940795a12.37.2024.10.04.01.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:06:14 -0700 (PDT)
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
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/3] riscv: interrupt-controller: Add T-HEAD C900 ACLINT SSWI
Date: Fri,  4 Oct 2024 16:05:54 +0800
Message-ID: <20241004080557.2262872-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.46.2
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

Inochi Amaoto (3):
  dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
  irqchip: add T-HEAD C900 ACLINT SSWI driver
  riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers

 .../thead,c900-aclint-sswi.yaml               |  58 ++++++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/irqchip/Kconfig                       |  10 ++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-thead-c900-aclint-sswi.c  | 169 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 6 files changed, 240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
 create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

--
2.46.2



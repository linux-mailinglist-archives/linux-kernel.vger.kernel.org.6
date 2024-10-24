Return-Path: <linux-kernel+bounces-379856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959519AE4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5571E282C42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED901D5AB2;
	Thu, 24 Oct 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uonhDsAx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260D1D357A;
	Thu, 24 Oct 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773277; cv=none; b=BeIyvbPTIMeCj0xOXK2EJdStjap4oyCvLmuhwtO7kU6q16uS33XYrUPvuFknAytAVxprsuiN6z23I7CzZiFAcCn0Nsxau3b7P3L3k8GOUsMAZeSdkldiRusCid3idpxzUtBTvfTrRYQUk8lt7wyO2Upp3oEClZFslwp4yMtxDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773277; c=relaxed/simple;
	bh=3ygEjG6hTS+s76bWt2IvYPg8yyhSvz+WHj+DxEVzQJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kM4IqnoU0DnmOLsgmoAAToV2FwC3j8YZXugk9ZU0YpKcB7HJc2ktdvqOgJ0KDXnRs00VIVPAlyHFUu+KqC8QZSVZKKHoxLtGI2zhW65jx8gtgNNGfeftCz0ovOndyicBXaYlJ2OfxZ4tgcAOsEJ1fxAHn5xK3495aHqpz6Dhu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uonhDsAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89700C4CEC7;
	Thu, 24 Oct 2024 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773276;
	bh=3ygEjG6hTS+s76bWt2IvYPg8yyhSvz+WHj+DxEVzQJY=;
	h=From:To:Cc:Subject:Date:From;
	b=uonhDsAxDtqHpYTOwA0RL5u/lqune/NxVAhq2wVRAgjNeuH3v8KhBLVMCZJImrKIi
	 E0kvBrkUcshfxQXg0K4JFuvrk+GM3j47hylwCwddJmO27BWldvg9kEQrG7xnX63he9
	 O5/yasof/iY3fMmtYFUgWv4s/L0V4dndgQjnkQXwbpvILjrWdc6oN75ejBQQ42iuCG
	 LbPUpRQ6kAXix5qmxfe4LfTeQg6fFWRMJVbZZAx2GPDWzRJ9fyTCCfl+8FZTKCwHUf
	 vUUkdNSifGBg5hqNsIr9HBl6FP1Pmo1b5/LwPmfMaZ9MYH2UUgM1bbURcnXJEys6DT
	 7qE0Xku+zq4kg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add some validation for vector, vector crypto and fp stuff
Date: Thu, 24 Oct 2024 13:34:28 +0100
Message-ID: <20241024-fanning-enrage-bcc39f8ed47d@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=rFKvUC5WbGtzbbJAD2E+rOogADPDAQJQjX4YNpHNNNs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlSdlcDu+QXPLh8ReufWddjnuVnZ7a/l1bOe7nIcMcN+ VvVvC07OkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRHTUM/zPNewu1Sp/UNPFt nz/93d3+BUw8a5hDlDIK5Zb/W9Fz8zYjQ3vYSXt1ofrkqa7T0qOu+dSJ/J9qzliou0340o5n63a +YQcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Yo,

This series is partly leveraging Clement's work adding a validate
callback in the extension detection code so that things like checking
for whether a vector crypto extension is usable can be done like:
	has_extension(<vector crypto>)
rather than
	has_vector() && has_extension(<vector crypto>)
which Eric pointed out was a poor design some months ago.

The rest of this is adding some requirements to the bindings that
prevent combinations of extensions disallowed by the ISA.

Cheers,
Conor.

v2:
- Fix an inverted clause Clément pointed out
- Add Zvbb validation, that I had missed accidentally
- Drop the todo about checking the number of validation rounds,
  I tried in w/ qemu's max cpu and things looked right

CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: "Clément Léger" <cleger@rivosinc.com>
CC: Andy Chiu <andybnac@gmail.com>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (5):
  RISC-V: add vector crypto extension validation checks
  RISC-V: add f & d extension validation checks
  dt-bindings: riscv: d requires f
  dt-bindings: riscv: add vector sub-extension dependencies
  dt-bindings: riscv: document vector crypto requirements

 .../devicetree/bindings/riscv/extensions.yaml |  84 ++++++++++
 arch/riscv/include/asm/cpufeature.h           |   3 +
 arch/riscv/kernel/cpufeature.c                | 148 ++++++++++++------
 3 files changed, 185 insertions(+), 50 deletions(-)

-- 
2.45.2



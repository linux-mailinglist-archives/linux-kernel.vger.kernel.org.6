Return-Path: <linux-kernel+bounces-347920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F4698E044
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9525A1C23085
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1C1D0E1D;
	Wed,  2 Oct 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL3bTYKw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8A1940B0;
	Wed,  2 Oct 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885514; cv=none; b=K0NAQ1Pz/6ltlh4as68x3cAyGrMzNTLu7ZflSZOSRzQidynPMnzB8lCK+9dAPsBO7FAtrE197K0WpokJ6Xg58tzNeoz0gCNxMDsVVK0RXFqOciTD5uuKe/10TW3LK0vWWdlFEb3xc00WvnAxhO94Jv395WnlM/cK0Pdq3vHhVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885514; c=relaxed/simple;
	bh=z4NrtfuoKFkUV7gw60/XOVCDu2x+hP12xwDRpwJUw9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gS4ssYNxCOMzteepoBdSa1Znuw5crtQy0guZVrIcn25vsWzocsP7gPKuj909RV7VDRfG8Ux6kS11wE923m4303t2+ymNOtaSqLgbuJAQzeW8mdTY32oDRdS8vjxn83Z8OP02l2L7k3GWpkrO9BfpWn+TeKKVZ6iTAzoM+Z7deH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL3bTYKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E83C4CECD;
	Wed,  2 Oct 2024 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727885514;
	bh=z4NrtfuoKFkUV7gw60/XOVCDu2x+hP12xwDRpwJUw9M=;
	h=From:To:Cc:Subject:Date:From;
	b=YL3bTYKwUaF/fTBfzLN0gLhOXBR1HldxOaE6syA6L+SOQE5zN9YdMshH/H4HOUfBl
	 Oo7gDhg/5moCjyim+RGM1EDflJ1wE/NMicxokN81mbiLgV8qzYlrTitrL9BEjFYigO
	 yUKxS/LZtnhrpn73EL5mJQjQ7VwIkd7JE1+R98/RvIYDmmpIgWTGF+UcDjGwlfr2SR
	 1uE3nz+DYqMbXA3nMGB0Q+taxa70bV9lkvj8a5DDItrINHjlM5AmvpAuCPe/iJyD5H
	 wBdosYhmj8nhJ0yBqoQXLlDwEBpqHE23ysQwKN2Lmpfo+e2yIDYSfhDe+nb94P47Nn
	 TBu667nl7Kf+g==
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
Subject: [RFC v1 0/5] Add some validation for vector, vector crypto and fp stuff
Date: Wed,  2 Oct 2024 17:10:53 +0100
Message-ID: <20241002-defeat-pavestone-73d712895f0b@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=VtP66jynw+1DhNCd6kcn7svr44Hq2u2DpQ/VRxE2T40=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/C/pzm5esbdlj9+4lV8fr001Tp38K50iUOPZIYVOnw ytelec2HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIWSYjw9T1sf4RbTOEZ294 un6yqap2+Y6XjluOWu5eftDQOV75YArDP3WfpIiUbRM3zLCZ+qRu0fYa3Zk6EtdfHmj7aBAY8uq VOw8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Yo,

Kinda RFC as I want to see what people think of this.

This series is partly leveraging Clement's work adding a validate
callback in the extension detection code so that things like checking
for whether a vector crypto extension is usable can be done like:
	has_extension(<vector crypto>)
rather than
	has_vector() && has_extension(<vector crypto>)
which Eric pointed out was a poor design some months ago.

The rest of this is adding some requirements to the bindings that
prevent combinations of extensions disallowed by the ISA. I might have
gotten them wrong, but I have cited the bits in the documentation I used
for reference - so double checking shouldn't be /too/ difficult.

Cheers,
Conor.

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
 arch/riscv/kernel/cpufeature.c                | 147 ++++++++++++------
 3 files changed, 185 insertions(+), 49 deletions(-)

-- 
2.45.2



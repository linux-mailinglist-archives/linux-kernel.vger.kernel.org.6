Return-Path: <linux-kernel+bounces-555195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E60A5A6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B23D166ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D01E833D;
	Mon, 10 Mar 2025 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIwkxpXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F161DF72D;
	Mon, 10 Mar 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644481; cv=none; b=uahWeToBIVM2uoDhKtgSfjnX0U9j8QU1D1BLZuVMN7BAlpd9gDhD7HUiMoMRj4VTLOfG+Y9ovq5p997Pl22BIJDv/w5+1dYh4pr3UuWJoegL4kRflpBT9SiyjcrYcn+kbIqFZZ2FqQyuh64gFOGpeJOXQlk3OWmcRoTrD+2e5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644481; c=relaxed/simple;
	bh=4NH90Cs04TqlOhUoz/iIw6tRYGsatu8fWNgt044t36M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dzk1nPb+UcpvxP7CLIbga5NJWHOklTgiXg3sEcPJzxX9fqCOfw2vXekuPGU1Z4noYHSINv0E+p/pXmCszp6ioJLcsGS8r8ycT04AFMOJjYUzAQ7Dg4bBrstu0XPI/DmVpOuFCX89zb1zDq0KPXoxQROx0pN4OHDwGN/LkGawEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIwkxpXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DD8BC4CEE5;
	Mon, 10 Mar 2025 22:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741644480;
	bh=4NH90Cs04TqlOhUoz/iIw6tRYGsatu8fWNgt044t36M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JIwkxpXTq/hqnVz9dSP6RI4Jmyb7693CWCXpJM+qFms3Jspu4Y3OrPrxhHae7OYfn
	 UCKXxm5Z3kPaEusKVorAlLhBOuRSuo/Xe9lqhda6CPcgkBG8QAQMq4W8gvnyFJLyXi
	 DsaxCcUTZ75dDYOozAIIXJm7mqxSgJcw9e1HQ4HiLCPJ4O2qCgFlBm3CfqTr4frKtG
	 08c/q5Atp9mjXqPmb9n9jHuIRmt3VJ8Yv9nvlY50+8k8FgzXe7QQ6AkSupz40QGyaM
	 6DtzTRKf0ib9C8T27kfgdn5FELUxarbjBa0k3GAAQ944fg9iHQXSr6D+n2E3TGDgVN
	 /c+VnSGsaVqVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D12EC282DE;
	Mon, 10 Mar 2025 22:08:00 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] Driver for the Apple SPMI controller
Date: Mon, 10 Mar 2025 23:07:57 +0100
Message-Id: <20250310-spmi-v3-0-92a82e7d9f0d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL1iz2cC/02MyQrCMBRFf6W8tZEMHUxX/oe4SNKkfWAHEglKy
 b+bVoUuz+Wes0KwHm2AtljB24gB5ymDOBVgBjX1lmCXGTjlFRW0JGEZkdSdMLzUkvJGQb4u3jp
 87ZnbPfOA4Tn7916NbFv/geobiIxQYuTFVTVzSkp37UeFj7OZR9gCkR+l5ifxLFljOk1r5bSUR
 yml9AH68rAFzQAAAA==
X-Change-ID: 20250304-spmi-6d3c24b9027a
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, 
 Jean-Francois Bortolotti <jeff@borto.fr>, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741644479; l=1465;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=4NH90Cs04TqlOhUoz/iIw6tRYGsatu8fWNgt044t36M=;
 b=g8CnRI6E0LKqOAOS/T7gnJRQIpwR+RGZtCOByjaUTDPnkY/76IvmqdKFQH66bpW46p5MmnOXm
 cbATFvvfMoqBVkC6MTfJwMvVEb2+tmF81rCQYQLPCjubErPipZ6zuYG
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

Hi.

This patch series adds support for the SPMI controller persent in most
Apple SoCs. The drivers for the attached PMU and subdevices will be in
further patch series.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
Changes in v3:
- Inlined helpers, dropped unneccesary error prefixes
- Link to v2: https://lore.kernel.org/r/20250307-spmi-v2-0-eccdb06afb99@gmail.com

Changes in v2:
- Removed redundant error prints
- Various style fixes
- Better explanation of why the driver is needed
- Link to v1: https://lore.kernel.org/r/20250305-spmi-v1-0-c98f561fa99f@gmail.com

---
Jean-Francois Bortolotti (1):
      spmi: add a spmi driver for Apple SoC

Sasha Finkelstein (2):
      dt-bindings: spmi: Add Apple SPMI controller
      arm64: dts: apple: Add SPMI controller nodes

 .../devicetree/bindings/spmi/apple,spmi.yaml       |  49 ++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |   7 +
 arch/arm64/boot/dts/apple/t8103.dtsi               |   8 +
 arch/arm64/boot/dts/apple/t8112.dtsi               |   7 +
 drivers/spmi/Kconfig                               |   8 +
 drivers/spmi/Makefile                              |   1 +
 drivers/spmi/spmi-apple-controller.c               | 168 +++++++++++++++++++++
 8 files changed, 250 insertions(+)
---
base-commit: 48a5eed9ad584315c30ed35204510536235ce402
change-id: 20250304-spmi-6d3c24b9027a




Return-Path: <linux-kernel+bounces-551900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E5A572BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712B916EED4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CF2566EE;
	Fri,  7 Mar 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaZfOA1s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF036254AFD;
	Fri,  7 Mar 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378141; cv=none; b=Xf8oIkWOiSNd6PSn70S6v+QIGzLJr2nzQghbIzMJy+KYLZVBzCaIpsxr3gFHDQOeyvsDMEatQXygOnnMKwrlnjl2kKoMZuEe/P/nh4qltjeTn8v9NkTlKSk7w0H/EYOfdGtL/Wcl53Jb+EvNkoNyI1lO4bGKJfmhxK5YK5vnmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378141; c=relaxed/simple;
	bh=DSewne/+knY+TMcgAfoQ8NfYE734FckrFWzIFoRfRT8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pxF3XYzTJntR9KoHTPm1iEtb8jPWhtP9s+R3JEjpoN3LZIN1VKdeTpxLjrGLyTTPPKn7KgOVy/xKKYUE0tf4hThlnsAcjBsuohNrDtsnv8HpF17IvWcDe0IWLbGudk8pOsw3dC7+0WhcMN+pc9czicxa8U5Rx/OcWqnL2ouSDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaZfOA1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47474C4CED1;
	Fri,  7 Mar 2025 20:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741378141;
	bh=DSewne/+knY+TMcgAfoQ8NfYE734FckrFWzIFoRfRT8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oaZfOA1saAwNtpvwrriZDOItHNIelASijxAaEKGCW4c8ztl5dA4I1LzCIgRGpK+Pw
	 VYeQkIktaZyHhEcZ/DZZh3MNQVzaUJ7nUtncX23TjTDrF7GVvLpEsidqboYXQnAUTw
	 v2OHxw8QQ90Wwcnnb2dyJQR7voC81quz7iFi3RARai7CepO6BYDqU/LSYaKY+JQRSm
	 X/TIsT3kIXimWeEq4ueEmOIjlGyu15ce6y9weMofKTNtrikn7JKKX8bCJJq5TPPzMH
	 xV4ZS8cqS5qDVvUq6fkn/ok/m/j6K61KAZwIWx5h9ndR2xFuXMN7Nqq8MLiVjOuemC
	 1V5xNu27MA0gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A1C28B23;
	Fri,  7 Mar 2025 20:09:01 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] Driver for the Apple SPMI controller
Date: Fri, 07 Mar 2025 21:08:58 +0100
Message-Id: <20250307-spmi-v2-0-eccdb06afb99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpSy2cC/zXMQQ7CIBCF4as0sxYz0FLFlfcwXSCFdhIpDRiia
 bi7WOPyf3n5Nkg2kk1waTaINlOisNQQhwbMrJfJMhprg0AhscWOpdUT68fWiO6uUJw01OsaraP
 XztyG2jOlZ4jvXc38u/4B+QMyZ8iMOjvZc6eVctfJa3ocTfAwlFI+MGHpcpgAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741378140; l=1309;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=DSewne/+knY+TMcgAfoQ8NfYE734FckrFWzIFoRfRT8=;
 b=ZuJIMgk3Tp5NZsN5L8gVH2bMl8CdDnA3XDCtr9+Lez5tfbuwwKqRP9YqQVjOubumjPPttNy5I
 rsrw5smJggjA3cF4u9rrGXG2MXyD4UHIxRQQyB6mtGVDFvR4uBfDjtS
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
 drivers/spmi/spmi-apple-controller.c               | 178 +++++++++++++++++++++
 8 files changed, 260 insertions(+)
---
base-commit: 48a5eed9ad584315c30ed35204510536235ce402
change-id: 20250304-spmi-6d3c24b9027a




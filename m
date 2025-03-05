Return-Path: <linux-kernel+bounces-547695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F188BA50C77
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BDC189059E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD1256C72;
	Wed,  5 Mar 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKfLCn6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10EF255E3D;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206406; cv=none; b=rJxYsHFiz/iXIUKdEuQ9EiYCYjHBDr4EjBHrAv7GdzEqAyqFywOv219NtUVfYXeZC9STFo27We0HD3wgiH1A1GSoTpaSE2+gkWLVHgynlOzGwhNsHm/5lMYcO94WdR74kg/cFwpZCoVJr7qvhEtqbCLaAWHGFOXHVlZ6gbGty4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206406; c=relaxed/simple;
	bh=8E+3xH59dDROB5c3GU/aubd3iREoSWnjGigCSx4ihgE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TzHI3FZTEy91GB6s0mg0ZgyOadn4wCCiI/9TuWmKc+piiQa1tlfgPLq8tShAZftnrAKK5bE0AojTBXgC2AZgM2/ujWDkI4PL4M41qZmWVSD9gx3IfqkjZ1nav3dFUrEMBwZ06S9D50pVifK9VjCGCy6O2KVqSoyHEh1wPDG9uzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKfLCn6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D6E3C4CED1;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741206405;
	bh=8E+3xH59dDROB5c3GU/aubd3iREoSWnjGigCSx4ihgE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VKfLCn6L35d6obE04hcyNUYD1d0aHnyfGf1dD8AGlfrjr3H2KtjPJW+GqJc4Y92HP
	 abGidKCSR0VbLg92GWvcEGsRj82iQ0f06yv3WTZPkTke8rkgP1ZBWR9yJ2iKUlB79u
	 RJ0HUWkF17Bb7V/d+fArlIv8BuSLRr8ZpZb2R5FpvZXizK/6y2LJVJ06hL9B45wWFV
	 fzh4NjqmewJHm113rnjfRkq1DmjN5Elx9YDBn5Ss4J3nCjk7ijjvXqbvhFpYQVH/Ga
	 MtTC+KjgfjkLZC8B6DSXz8vzu+VgtD+/e0KY5CbxgeahgIyXGAwdzXMEwUVlw1ImrD
	 fDdkYLlKMlO2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BAAC19F32;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH 0/3] Driver for Apple SPMI controller
Date: Wed, 05 Mar 2025 21:26:38 +0100
Message-Id: <20250305-spmi-v1-0-c98f561fa99f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6zyGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMT3eKC3ExdsxTjZCOTJEsDI/NEJaDSgqLUtMwKsDHRsbW1ALrV2CV
 WAAAA
X-Change-ID: 20250304-spmi-6d3c24b9027a
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, 
 Jean-Francois Bortolotti <jeff@borto.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741206403; l=1097;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=8E+3xH59dDROB5c3GU/aubd3iREoSWnjGigCSx4ihgE=;
 b=PmX2ocAv2/wmZWwOa7PoAda03TXHEAuwalZF0jKdkBwLtysNdwYu6vpAOeJoqo6qSgKCsiyFu
 dL5biE8Eb4kDz8D6c/YaFIvRRJxlrmw76vbnrwiBSysdEqu9kqEX0k2
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
Jean-Francois Bortolotti (1):
      spmi: add a spmi driver for Apple SoC

Sasha Finkelstein (2):
      dt-bindings: spmi: Add Apple SPMI controller
      arm64: dts: apple: Add SPMI controller nodes

 .../devicetree/bindings/spmi/apple,spmi.yaml       |  56 +++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |   7 +
 arch/arm64/boot/dts/apple/t8103.dtsi               |   8 +
 arch/arm64/boot/dts/apple/t8112.dtsi               |   8 +
 drivers/spmi/Kconfig                               |   8 +
 drivers/spmi/Makefile                              |   1 +
 drivers/spmi/spmi-apple-controller.c               | 176 +++++++++++++++++++++
 8 files changed, 266 insertions(+)
---
base-commit: 48a5eed9ad584315c30ed35204510536235ce402
change-id: 20250304-spmi-6d3c24b9027a




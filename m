Return-Path: <linux-kernel+bounces-557774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83920A5DD81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD357A3A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A4245013;
	Wed, 12 Mar 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn7H+CKu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6E23A9AE;
	Wed, 12 Mar 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785153; cv=none; b=nvHVWnKRBF/ifqWD+bMQv4gseRwbA95y6iMyVXltbljsh94yi0SjhwHwKxmQj9EuD3EL6SGuJWFuhX9IakdNSo4jo/ha2fW+z8rXFR4xrbTTIQqoDfMUnzh39bcX61hc2X4M1xuGTjB1ZHlkNEOXTv32q+Gj05GLQY7erPdYGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785153; c=relaxed/simple;
	bh=Nb2EwrGaRlhLj2cZ1F+XA6Qs+Czq/zIJZZeXSvObuTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EQ0b3FlBWCghJgpyfm5pk6y7bfuUObNMwK+X4FsIVg4Rb/mUFx6Ibvzd68kjsYmkduXzMaRH0MhqMx4Bz8yS4xA/MXOGnluQ61BkClvVoE1ORsTWaios1zjJDys4mOI47hmjif0mxk+BYZLyaQAre7LshdV7tMe2c45f7/gx9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn7H+CKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DC2C4CEE3;
	Wed, 12 Mar 2025 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785152;
	bh=Nb2EwrGaRlhLj2cZ1F+XA6Qs+Czq/zIJZZeXSvObuTE=;
	h=From:To:Cc:Subject:Date:From;
	b=Wn7H+CKup/hxhFVUW8COsYMrIGFjrC5FGpDmyoRDZpoMK27/PtgGWIYsYsf4gBdbb
	 H124ET3VmW2meXGlgvtdyiSjejGD23jmdGTOueWHwbFX13y9pkalTKjZRX8yoh6hUw
	 FsV6dlYMoR2v2xjSok3U21FGK387nbA9yLkr0yzqr04ns++R39fubbWItiPdtXYS9W
	 xOZU2lQj+gO806dVOV54yYZfru96MrkKQsnO/FjxSCT5teVumv6XB76deSzhmxELaA
	 FJ/vD4SkDJHSQACp9YhyiL2xiVnRCGZmPTkt3Tc1bnq8/FA0eOlcTanFeWn7RLWoZn
	 pn/Bf4uET5mYQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] Add some validation for vector, vector crypto and fp stuff
Date: Wed, 12 Mar 2025 13:11:43 +0000
Message-ID: <20250312-abide-pancreas-3576b8c44d2c@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=8zYh8ffrjif+99QfRpKCRW9tNgdzrhSzvyJS1+s7Es8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkXO4R8W8+/35Gj1p/BVV2o+yBzXYHg5KucBUFrIi9/+ yJTXnK4o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPx2cbw31NHfMFEganTes+7 7tpSlFoasTTJJo89UbDz6imuXWxBNxgZ3p95/3b7St4tU1vKWUVb9DJOz/W7afB+U847/TNRTsx beQE=
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

There's a bunch of over-long lines in here, but I thought that the
over-long lines were clearer than breaking them up.

Cheers,
Conor.

(I've been unintentionally sitting on this for a month, hope I
haven't omitted anything as a result)

v4:
- Zvbb -> vector_crypto_validate()
- remove copy-pasta section of commit messages
- Add commentary justifying !EPROBE_DEFER cases
- EPROBE_DEFER where possible (one instance, zve32x check)

v3:
- rebase on v6.14-rc1
- split vector crypto validation patch into vector validation and vector
  crypto validation
- fix zve64x requiring extension list to match Eric's PR

v2:
- Fix an inverted clause Clément pointed out
- Add Zvbb validation, that I had missed accidentally
- Drop the todo about checking the number of validation rounds,
  I tried in w/ qemu's max cpu and things looked right

CC: Eric Biggers <ebiggers@kernel.org>
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

Conor Dooley (6):
  RISC-V: add vector extension validation checks
  RISC-V: add vector crypto extension validation checks
  RISC-V: add f & d extension validation checks
  dt-bindings: riscv: d requires f
  dt-bindings: riscv: add vector sub-extension dependencies
  dt-bindings: riscv: document vector crypto requirements

 .../devicetree/bindings/riscv/extensions.yaml |  85 +++++++++++
 arch/riscv/include/asm/cpufeature.h           |   3 +
 arch/riscv/kernel/cpufeature.c                | 140 +++++++++++++-----
 3 files changed, 190 insertions(+), 38 deletions(-)

-- 
2.45.2



Return-Path: <linux-kernel+bounces-541689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76952A4C02E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DC4188F2B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029C20F091;
	Mon,  3 Mar 2025 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="EdBJtbbg"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A31F0E3D;
	Mon,  3 Mar 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004491; cv=pass; b=e6dGlvLVmIFjZ6bsrTTcdGb6BheqGPt63wiWALHnTYZ7e+f47XInbrOGGoLD6v8xx9Lg5L86ov1RGWf++QeJFe95FUN6mPrenCoY+Eq24nfe5yTFAyYS4OZsUKfsxMDmGM6L4y+M7g/mmiQQBct7eAG0JLKXn2aZNKHNjd7KwsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004491; c=relaxed/simple;
	bh=volc7wpEytp1a1Qi/JANVrvsyBKoBmzJJEJNLozwvIU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H2/o4rA7DkkON6EuuOr5tN8VA7+Axo+2Meq8AspRpGulZtl9hsWYlcx03waETYKkc/K13qpoFXFcMUavvI+Io8XCWD6WLHXZ5NZ9LMb3jJpy7qXF74P+8FZJvi+Jc659fFZZTBRF2XyigetFFGZdQ/HksQA9IbOl3Ji1EkRkHeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=EdBJtbbg; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1741004471; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cNoqCE84Lj/LK0jWFjUNzzlRm+/GkYA81ChiRnkKZJRcGs2VpgP7B/UJIlprEXWsGOjxs9Bhhp6MtEFRQ62XBbnL9glKIx5uhRdjD2zrUERPgK6dq/+bXYwkVW1ulca5kTrTOX5l6wZevyE6woAaPxMm53Ku+72qmE5c9b15P48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741004471; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K/QOC2qh7IZvAZiuNVR0WUquzApIsQsNg8wTJwm843Q=; 
	b=Fu+wA9fKHI50RYfa6l3yUGb5WkZqt8V3akUPp/uJquSCrS9GB0KwD+dyfwfYD2C1fWAQ3AA0tYVCEINSngC6CW9sZT5alWjoqWi/5zvNFmDKcr9zLlQdQzkTa3T3Mci5YHCESIxGoL5YC6cNnBZeVre603Dh6okumJq0D/FHuNc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741004471;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=K/QOC2qh7IZvAZiuNVR0WUquzApIsQsNg8wTJwm843Q=;
	b=EdBJtbbgDKepHLvkqdgGyBm24c87ivKwfFIEAuMczCre9TiNvGPepi88uOoV3Jul
	M9TsQEeHOYQ5gPK5GcuU4QdgXG/3H7FFjhUCc+V/gwyv7PsdC3xrR8N/wS+LBQgUcdN
	y7soF2HIpDDlkmJQnGl1zGOKDZ77I/Oi4cqkFPgY=
Received: by mx.zohomail.com with SMTPS id 1741004468938559.7940562973238;
	Mon, 3 Mar 2025 04:21:08 -0800 (PST)
From: Xukai Wang <kingxukai@zohomail.com>
Subject: [PATCH v5 0/3] riscv: canaan: Add support for K230-Canmv clock
Date: Mon, 03 Mar 2025 20:20:36 +0800
Message-Id: <20250303-b4-k230-clk-v5-0-748d121283e3@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSexWcC/3XQwU7DMAwG4FepcqYocZI62Yn3QBxSx6HR2Aptq
 YBp7066gbSykVMc6bN/5yBGHjKPYlMdxMBzHnO/L4W9qwR1Yf/MdY6lFiDBKJBN3Zp6C1rW9LK
 tPdikdeLYEIgiXgdO+ePU7fHpXA/89l6aTudH0YaRa+p3uzxtKskcvEPpXACIqKNT7BsXGbVBi
 oRsvUl4bh0m6kqWTRU5Bk0GIclyUopGUowRKTVRt5ZLpxgwklgSdHmc+uHztN6sTxF+NsHVJrO
 uy6VV6K1yjhEfvvqu34X8cl/SLgEKs1IBXLM2JbQ2kKdEtxlIfc10A4RegbEIa7YEn81FWGXW3
 BSuSHoKTauNC/9MVXjNbPA2aGNd49WNqepiKvg1V4UDqOAVspMcb3D45eWrpFtzWDi2WgagYOE
 vPx6P3yDhpuqNAgAA
X-Change-ID: 20241206-b4-k230-clk-925f33fed6c2
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
Feedback-ID: rr08011227ec6b7bdb78d015905e8a5b7800006b6c3e9f124e09cc2749c9387639307a802e9dac3f53e8f8d7:zu08011227834022bfad283179f557eec2000073ae6186d4c306b7ac224e2623b7a8ddc8d1e60a8ca9a28e03:rf0801122c69cf2ce71ba0d4a64bafba3000007b90b30649d48280376ff6c27451711db85aa7d804be149836bdeef4867b:ZohoMail
X-ZohoMailClient: External

This patch series adds clock controller support for the Canaan Kendryte
K230 SoC. The K230 SoC includes an external 24MHz OSC and 4 internal
PLLs, with the controller managing these sources and their derived clocks.

The clock tree and hardware-specific definition can be found in the
vendor's DTS [1],
and this series is based on the K230 initial series [2].

Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/linux/arch/riscv/boot/dts/kendryte/clock_provider.dtsi [1]
Link: https://lore.kernel.org/linux-clk/tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com/ [2]

Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>

---
Changes in v5:
- Fix incorrect base-commit and add prerequisite-patch-id.
- Replace dummy apb_clk with real ones for UARTs.
- Add IDs of UARTs clock and DMA clocks in the binding header.
- Replace k230_clk_cfgs[] array with corresponding named variables.
- Remove some redundant checks in clk_ops.
- Drop the unnecessary parenthesis and type casts.
- Modify return value handling in probe path to avoid redundant print.
- Link to v4: https://lore.kernel.org/r/20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com

Changes in v4:
- Remove redundant onecell_get callback and add_provider function
for pll_divs.
- Modify the base-commit in cover letter.
- Link to v3: https://lore.kernel.org/r/20250203-b4-k230-clk-v3-0-362c79124572@zohomail.com

Changes in v3:
- Reorder the defination and declaration in drivers code.
- Reorder the properties in dts node.
- Replace global variable `k230_sysclk` with dynamic memory allocation.
- Rename the macro K230_NUM_CLKS to K230_CLK_NUM.
- Use dev_err_probe for error handling.
- Remove unused includes.
- Link to v2: https://lore.kernel.org/r/20250108-b4-k230-clk-v2-0-27b30a2ca52d@zohomail.com

Changes in v2:
- Add items and description.
- Rename k230-clk.h to canaan,k230-clk.h
- Link to v1: https://lore.kernel.org/r/20241229-b4-k230-clk-v1-0-221a917e80ed@zohomail.com

---
Xukai Wang (3):
      dt-bindings: clock: Add bindings for Canaan K230 clock controller
      clk: canaan: Add clock driver for Canaan K230
      riscv: dts: canaan: Add clock definition for K230

 .../devicetree/bindings/clock/canaan,k230-clk.yaml |   43 +
 arch/riscv/boot/dts/canaan/k230.dtsi               |   25 +-
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-k230.c                             | 1717 ++++++++++++++++++++
 include/dt-bindings/clock/canaan,k230-clk.h        |   69 +
 6 files changed, 1853 insertions(+), 8 deletions(-)
---
base-commit: 0eea987088a22d73d81e968de7347cdc7e594f72
change-id: 20241206-b4-k230-clk-925f33fed6c2
prerequisite-patch-id: deda3c472f0000ffd40cddd7cf6d3b5e2d7da7dc

Best regards,
-- 
Xukai Wang <kingxukai@zohomail.com>



Return-Path: <linux-kernel+bounces-216082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39850909B28
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723A0B21B89
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B11667C9;
	Sun, 16 Jun 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="C3BWyRuc"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C026288
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718502924; cv=none; b=LtD9Limnt6EabvHnt3jjVjbtzOAK9Af0Ltc1tePTElG/Hp9qsWTuNJRri2GRrSjdpNDF7OKWcv2y15BqdB/KulEFGxrMxiv1U/PVRyO6SCedw5vacl1+LtghGBOOYgVQ8LsaN/f2+CUf92mO0fN5zEMkv/hGLHQy1c+bsEtPnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718502924; c=relaxed/simple;
	bh=oiQ2U4RKb1Iv2Gx0d/RSo2VuGdZEH1NgOZ9G/UGU3Zs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hPTMLvU/QCLTVJvtA/QiENgwKKa4fuqtVKWtUiRV2jSQOrVCWb0+j2nA8P1p0uMFrnf4VkU9QkMjGHQ7bEbeRIvOgw3Y6txjfaBhd7RD1Onv7dPMkAdrxwggDv/TgO4akNVEyc1RMs3PrpDAYF9PUClu7+IeLbi0OCUc3iDEys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=C3BWyRuc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so2197560a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718502920; x=1719107720; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vvNH5iGqBZh76l6k5VqaC65fZKHfbumS1HMa6kMl+Ww=;
        b=C3BWyRucrGFtMrqAXJAkYaqg/nDxuoH6VfunhmOc0wqLfcXmMOp2i3FmK8fUMOE84S
         Q2mptahdtlnnY7PT0VqBydlJ4hAMCB4vMyFkuLx808K/cId0GnI0jqY+kqYvddY1FV/7
         BEjMF8N5YM0M6M9n3VsADUqBGQaxWPX3uBaW0NxsgQ3cJ4Dk9Hlptx2uNLoj4sChql2i
         KgGg2Tuv6OPPqLcpWAkT62x+eu9fchr4tvU7x5fcfEznTKiK/WFYXqz08vzh1knyF1jb
         mdud0JjuV39Ve6pnDYaS1tdcJheC4l+m/FKipkBJWQsMTY9Fp/AnN4+gEHAbdkiF2VLY
         SAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718502920; x=1719107720;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvNH5iGqBZh76l6k5VqaC65fZKHfbumS1HMa6kMl+Ww=;
        b=BVshZIg0ksSKJaMUSJ/x4imZL0lJxpo2pSmXAwhSbC4D9wRMK/OwqRiRk1aomituua
         +nyeOO+rdIFEtJEdr2VC/X/3onAv4f7w9QKti/OHG4uA/Hx5f9KMeTO1DVSs3Q/U5W1n
         9LkwZRb95SlX9cuhWvUvoalEUwf26M6fG9x/L2dG96lHjG4Dd+8Wld6sPWOWJuHXFTe3
         eSTtopO0c6K5+L+e3QgETKDRKZD9U6ZplsSai71OhXacxMuXhxYZxlRwe012ImCJiVau
         ByTLv2vqdhG/yLjkf5Zzh9pb6v+ddfj5AU2Q9JqdO99y1EBDiJpse4yztSZuxhh3r5R+
         KwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGfUtU3Zs3lBJMa7+NS6m7ic1hG/sho+b1wGS7Iuvtd8+x8mZvxB11LR1MdrQxcqGyUQi8HCl5qLsjuCtw+Txd5+E8tzbo+2q7yw8t
X-Gm-Message-State: AOJu0YwXHNiaQnJb8UUCnRyccDUie59d83dR6iXLlmZeVR33J/YjLMnl
	s7To7e3jMIcdiMOxMdyC81dL41D9MKkdM2d16CgMKA9PuAVI6pVYNDSXemW5xIM=
X-Google-Smtp-Source: AGHT+IEm1y8qyu8PaaBUYkyOQbpK7u3h9Hx5y/jGO03i4VxxXa+YdnnEPwOPo/FGFhAGJrxSUEuU/w==
X-Received: by 2002:a05:6a20:6a0d:b0:1b6:15b2:822 with SMTP id adf61e73a8af0-1bae7f01befmr6559414637.27.1718502920190;
        Sat, 15 Jun 2024 18:55:20 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:1cea:28dd:2ee0:e8e5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769aedbsm8751201a91.43.2024.06.15.18.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 18:55:19 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH 0/6] clk: thead: Add support for TH1520 AP_SUBSYS clock
 controller
Date: Sat, 15 Jun 2024 18:54:29 -0700
Message-Id: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVFbmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MT3ZIMQ1MjA93knGzd5BRTC9NEC1ODFLNkJaCGgqLUtMwKsGHRsbW
 1AF6JvIFcAAAA
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.12.3

This series adds support for the AP sub-system clock controller in the
T-Head TH1520 [1]. Yangtao Li originally submitted this series in May
2023 [2]. Jisheng made additional improvements and then passed on the
work in progress to me.

Changes in v1:
 - Split th1520_clks into groups for gate, mux, div, pll
 - Convert gate clocks to devm_clk_hw_register_gate_parent_data()
 - Convert mux clocks to devm_clk_hw_register_mux_parent_data_table()
 - Split the PLL recalculation into th1520_pll_vco_recalc_rate() and
   th1520_pll_postdiv_recalc_rate(). Based on Emil's comments in v1,
   add logic to handle the fractional portion of feedback divide value
   when the delta-sigma modulator (DSM) is active.
 - Drop clock-names from the binding per Stephan to avoid relying on
   anything other than the cell index when describing clk_parent_data
   (note: I dropped Rob's Rb because I changed the binding patch)
 - Rename reg/reg2 to cfg0/cfg1 to match the SoC documentation
 - Rename struct for pll clocks from ccu_mdiv to ccu_pll
 - Rebase on v6.10-rc3, remove the dts node reordering patch from v3
   now that it is in mainline

Changes in RFC v3 [3]:
 - Drop redundant new line and unused clk label from the dts example in
   the DT binding which I failed to fix in v2.
 - Add patch [4] from Thomas Bonnefille that fixes dts node ordering in
   th1520.dtsi. Conor has already merged it into riscv-dt-for-next so
   the dts patches in this series are based on top of that.
 - Remove fixed uart clock and converted uart DT nodes to use clocks
   from the clock controller.
 - Remove fixed apb clock and converted the dma controller and timer DT
   nodes to use a clock from the clock controller.
 - Made ccu_disable_helper() and ccu_enable_helper() to static functions
 - Follow the advice from Stephen Boyd in Yangtao's original series to
   not use strings for clk tree topology. Created clk_parent_data arrays
   to be used with CLK_HW_INIT_PARENTS_DATA instead of parent strings.
 - Rebase on top of v6.9-rc7

Changes in RFC v2 [5]:
 - squash the header file patch into the DT schema patch
 - describe the changes I made to original series in the cover letter
   instead of the individual patches
 - fix my typo in my email address

Changes in RFC v1 [6] from the original series:
 - corrected the npu_clk enable bit
 - deduplicated CLK_NPU and CLK_NPU_AXI number in header
 - fixed c910_i0_clk reg typo
 - fixed checkpatch and dt_binding_check warnings
 - rebased on v6.9-rc5
 - revised commit descriptions

Thank you,
Drew

[1] https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
[2] https://lore.kernel.org/all/20230515054402.27633-1-frank.li@vivo.com/
[3] https://lore.kernel.org/all/20240506-th1520-clk-v3-0-085a18a23a7f@tenstorrent.com/
[4] https://lore.kernel.org/all/20240425082138.374445-1-thomas.bonnefille@bootlin.com/
[5] https://lore.kernel.org/all/20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com/
[6] https://lore.kernel.org/all/20240110-clk-th1520-v1-0-8b0682567984@tenstorrent.com/

To: Jisheng Zhang <jszhang@kernel.org>
To: Guo Ren <guoren@kernel.org>
To: Fu Wei <wefu@redhat.com>
To: Yangtao Li <frank.li@vivo.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
Drew Fustini (6):
      dt-bindings: clock: Document T-Head TH1520 AP_SUBSYS controller
      clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks
      riscv: dts: thead: Add TH1520 AP_SUBSYS clock controller
      riscv: dts: thead: change TH1520 uart nodes to use clock controller
      riscv: dts: thead: change TH1520 mmc nodes to use clock controller
      riscv: dts: thead: update TH1520 dma and timer nodes to use clock controller

 .../bindings/clock/thead,th1520-clk-ap.yaml        |   58 ++
 MAINTAINERS                                        |    3 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |   12 -
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |   12 -
 arch/riscv/boot/dts/thead/th1520.dtsi              |   69 +-
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/thead/Kconfig                          |   12 +
 drivers/clk/thead/Makefile                         |    2 +
 drivers/clk/thead/clk-th1520-ap.c                  | 1086 ++++++++++++++++++++
 include/dt-bindings/clock/thead,th1520-clk-ap.h    |   96 ++
 11 files changed, 1291 insertions(+), 61 deletions(-)
---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240614-th1520-clk-cd585a850d6c

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>



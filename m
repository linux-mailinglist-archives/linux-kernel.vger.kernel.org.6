Return-Path: <linux-kernel+bounces-249554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F6192ED37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B241F2358A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD15816DEA4;
	Thu, 11 Jul 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="EXI+/dSs"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D916D9A7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716990; cv=none; b=cWbG1wMBKSuh0XoigItCVbjrOFPh64p1kLp6W88YgtKkP2qeuqYkOvQWqtf081IybIw1Eo4fQQfRR4PlgoWt2yNZiV3DMvejbLevOq14jl4VIh09yTuw8j2dhoosFaAD5dMqZYFdz2Mt6+VpIe0QKAVU9VN9cQ2ub/LCF3tq74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716990; c=relaxed/simple;
	bh=1pS4EYjsNn3BXZfRuGoxZnqmwVe33N0u3aWOchDQoRA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aJrg4cH7F+Z7YLce/jS5F9TT74ECWRbadbsKAVlseE2AYbzRi59/JGISl+hIg6xFUPp35IXNEDdhdNrVyZ2HtJOOsEzGCGVvQ/FzLpVCuspnHqnP50VI8h6A2rBpKt1UxfRpQpOASietmE+FhnXe60MO0SMwi4VPLYUuEwJ65Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=EXI+/dSs; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e3b8637c9so549271fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1720716986; x=1721321786; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhr3664pgzsPVbVM9TMlydj6PeeipJCxcTuOvriuu8Y=;
        b=EXI+/dSsqIiCM+fOLkXUYhjI/bqGxiTHfV+4Wj7SxBsiA/guwzXQbbXMppRsYZH/Bx
         epqq+Grv5EUGMKMdbzffbel2w9P6+wEPu/NUM9CfM6NDwgpLkB4Qb3YBo4QemLOVbSJ8
         BlsKHrR8YJYwHOWNYj0QrJXTTeR0GSXT0w18jJfFEEjBviraib+c8wVYIWEoJ+Le1PY7
         y9+By28DTu5yKfCsRXWUrYnT5Ln2DS/ZbM1nMwf6t9ToJOAUSKTokDv8s7ewfHLeRALW
         jVxP3wUPCoIBZYwOdaOfjQZzCSk+8Qaf6OnJgY5oULLyzbWL4pKi30VD9vNmtTJUvzY8
         h7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716986; x=1721321786;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uhr3664pgzsPVbVM9TMlydj6PeeipJCxcTuOvriuu8Y=;
        b=fPXNIq0b0F8P3cQGxh0Q1EdzixWhLm8Zav2GAFNLp3yy0JW3ml1IltdK2QWZwAcC/N
         tf/AagzG8zu6HsxnkxkyoraqhECXNnDlz5XfvoW3E80J3CZj8xbGATCloxJXmJWd5FxZ
         2eAK799fcMA4bSXEMWGounHH/2CNZWZn/enOWyj37tXeT7CzQxBTVjaoKqyQ1x0AbOls
         sYU2P6kydrcPo6QZq09oSJq8IxlX8OPgemwDdVVsLJinDFoUTxRP20KoUWnlVXxYuI7y
         T/WG8f8uwHl2Sf6OWDg4PUXueYmStG4A3SnzLnWCgtNsBuxYi67aOXlSltjZi4B0bNeN
         98Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX3AVi+zXJ8zRUzFX18AUxAquTGI1iBt+XOefsWefqOeRgnYdjD3t9KIK3TFt5MKlVRfIdOPe14yV9jrXA/g7b0Jjtm/dLKf+5E9wig
X-Gm-Message-State: AOJu0Yz1TFez1DFTjMgkQ3iPWpOLLyR3lHMoumRWd+/vttn6pbWK2Fv6
	8OJoE+at4D3O1i9/RjAnulBg8+i4KXAfL0JOmQTXLrP0D9yiP5Mq0r4BR5KwIVU=
X-Google-Smtp-Source: AGHT+IE43ZJH2LFhQTINfIakZgTQfA50ql3uXt7MpIZiMFSUweWWsVGkY82v2L0BWYAP0CjJVvhIyA==
X-Received: by 2002:a05:6870:c34c:b0:254:96ec:bc44 with SMTP id 586e51a60fabf-25eae88a6d3mr7072740fac.28.1720716986246;
        Thu, 11 Jul 2024 09:56:26 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:5ee9:fea0:d9de:cee8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-787089bc5f6sm1360038a12.92.2024.07.11.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:56:25 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH v3 0/7] clk: thead: Add support for TH1520 AP_SUBSYS clock
 controller
Date: Thu, 11 Jul 2024 09:56:18 -0700
Message-Id: <20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIOkGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3ZIMQ1MjA93knGxdg8QUS3OzVKNEE6NUJaCGgqLUtMwKsGHRsbW
 1AH6BLJBcAAAA
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720716985; l=5438;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=1pS4EYjsNn3BXZfRuGoxZnqmwVe33N0u3aWOchDQoRA=;
 b=uEAXxeZVrDYQjqzTdPCnXigOhQhfpt9gooEApJADDF3FW5O8a32yNOYGEDqxwPmfWFi+XpfXd
 aobxfmzc/KlABCFDshVCbYzVR+vHfZrdao9pTTGxtkUuNPVtDLJqQMr
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

This series adds support for the AP sub-system clock controller in the
T-Head TH1520 [1]. Yangtao Li originally submitted this series in May
2023 [2]. Jisheng made additional improvements and then passed on the
work in progress to me.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]
Link: https://lore.kernel.org/all/20230515054402.27633-1-frank.li@vivo.com/ [2]

Changes in v3:
 - dt-binding patch has been applied to clk-next by Stephen but I'm
   keeping it in the series for completeness.
 - move dt-bindings include after linux includes in driver
 - change rate to u64 in th1520_pll_vco_recalc_rate()
 - replace do_div() with normal division operation in both
   th1520_pll_vco_recalc_rate() and th1520_pll_postdiv_recalc_rate()
 - add static to ccu_mux structs: c910_i0_clk, c910_clk, uart_sclk

Changes in v2: 
 - Add clock property to the gpio nodes after Conor asked why they were
   missing. These clock gates correspond to enable bits in PERI_CLK_CFG.
 - Drop 2 cell address and size properties from the binding example per
   Conor and add Reviewed-by from from Conor.
 - Link: https://lore.kernel.org/linux-riscv/20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com/ 

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
 - Link: https://lore.kernel.org/linux-riscv/20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com/

Changes in RFC v3:
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
 - Link: https://lore.kernel.org/all/20240506-th1520-clk-v3-0-085a18a23a7f@tenstorrent.com/

Changes in RFC v2:
 - squash the header file patch into the DT schema patch
 - describe the changes I made to original series in the cover letter
   instead of the individual patches
 - fix my typo in my email address
 - Link: https://lore.kernel.org/all/20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com/

Changes in RFC v1 compared to the original series:
 - corrected the npu_clk enable bit
 - deduplicated CLK_NPU and CLK_NPU_AXI number in header
 - fixed c910_i0_clk reg typo
 - fixed checkpatch and dt_binding_check warnings
 - rebased on v6.9-rc5
 - revised commit descriptions
 - Link: https://lore.kernel.org/all/20240110-clk-th1520-v1-0-8b0682567984@tenstorrent.com/

Thank you,
Drew

---
Drew Fustini (7):
      dt-bindings: clock: Document T-Head TH1520 AP_SUBSYS controller
      clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks
      riscv: dts: thead: Add TH1520 AP_SUBSYS clock controller
      riscv: dts: thead: change TH1520 uart nodes to use clock controller
      riscv: dts: thead: change TH1520 mmc nodes to use clock controller
      riscv: dts: thead: update TH1520 dma and timer nodes to use clock controller
      riscv: dts: thead: add clock to TH1520 gpio nodes

 .../bindings/clock/thead,th1520-clk-ap.yaml        |   53 +
 MAINTAINERS                                        |    3 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |   12 -
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |   12 -
 arch/riscv/boot/dts/thead/th1520.dtsi              |   73 +-
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/thead/Kconfig                          |   12 +
 drivers/clk/thead/Makefile                         |    2 +
 drivers/clk/thead/clk-th1520-ap.c                  | 1089 ++++++++++++++++++++
 include/dt-bindings/clock/thead,th1520-clk-ap.h    |   96 ++
 11 files changed, 1293 insertions(+), 61 deletions(-)
---
base-commit: 256abd8e550ce977b728be79a74e1729438b4948
change-id: 20240710-th1520-clk-0ad976e2a42e

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>



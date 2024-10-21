Return-Path: <linux-kernel+bounces-373567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3049A58EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EA51F216E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89133FB8B;
	Mon, 21 Oct 2024 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="M6x1Z6w6"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6C71799F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478217; cv=none; b=s6CFXLrGB6VcqY2nVGPxzbypziiN+2JxFPQRny4QECAN4jRkprH6pz4WDSQyvVzKPTh2qcE5Hb1H2gCNU57JccU9B9oFnW7QfyJX6WTIjBpDWd+/tASIsvkzl1nx/En/2omtKzCjcCqpJqQaW77JqZd86U0eXUAJXSC8phiyqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478217; c=relaxed/simple;
	bh=IMv+8kaxUbMYvC8HOO5mh+5DjzytaU+n4JEK4BQ8a0E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J12Rb39+oJHTvitrNSn/88eaVCk9m7urEDSeXQleS+uvyjb8LyWQk5vMeNMwc0JS55L8pjbOGkd0dfl/cEOegbxpLhnQOfRZIKvKRigVE6qzjyhfHComJv8p4QxBSF1D+f5ZjQjZirTsk/Jai1awJnpeSxTQPBHkFQgqYs9e+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=M6x1Z6w6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso3473120a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1729478214; x=1730083014; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDwVvRsmB8PgMAF9NalbRCBobUSoLoKxM6gCOMAKho0=;
        b=M6x1Z6w6kv5+8FVrzLNOfawuJogBwQRpOe3YY9wu77+oLe0wKtf7ypkTF7LxdaAXYh
         +YXzUSTMcTus7kvAk1vYLJUAl+onF/koyWGPBztq2dEv2VOPpsOrbRw/q4Ijpfn2jkc1
         QAp6LiWipR3iOwtyyAEQ+TNixdsqBOPWgUMSXUmRa72Vql+/5bjPDFR6cJwkNl66siQy
         NWYgc0QBNYoK0H/8gRCRiaithRNBdCpBhGg7WGkMhFKfh4zBppNk7MA5YTvuL3Eb40Yy
         L3dMoFv2UNdgWxptqfVli+zo0pJLZbQOAMZgZO27FenYmS/lr4VjdnX4UlrNuhgGfirb
         SsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729478214; x=1730083014;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDwVvRsmB8PgMAF9NalbRCBobUSoLoKxM6gCOMAKho0=;
        b=QoOcADnJ/iJ+/gMx49O8vCvsvycQr81ybMeCL6LXBjWqlDjjbgIWnLhF2OMav7jbDd
         8fIjYypv33PvARxO4mWDZauxw0zX97zOr5hs5EVpLtG8kSCzFXNGJWRwyD8wTHZ9bjXd
         KcOdIxt9jfD11dstTrYknqIiLXa8KluH+EZMC8LUyMqslfFv7Ll4TwbpcFyt6UJLGZyv
         QJLIiJTqCqpQX9idx8iUo6aEl0sLZTwXBh6VxoOJij/rD437G7GVVx/EhKdR18njrRqc
         QS8dfOlWGL9OptQ6mAWLlEw2s5GvWZQTj0aWlxdIfBhxktLh96b7lgl/iBR83vsUAUND
         VmPA==
X-Forwarded-Encrypted: i=1; AJvYcCXemQj8AMi6mU0DJLumVpunIgzXDnQp18bSJspoobBZ1wKJvd2O/zMX/OzDVQUr0qaGF0o0AfWiV8NUD0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IWjnWXrQhBVxYmiyCcF1MKu56g8royoSL3CPUHJktiImj9CQ
	v6LjcL8egnFOuVlezVCqkdtaSISiVbmODvTK7PvXWTxW1OmqZs3v4pNd8nidPIc=
X-Google-Smtp-Source: AGHT+IGNXTzbHIjYscMQc1FyHJL74YRfT9c4LzptWN49IdWjspBw/dUxnVD8S9MWaYzR1JmG3gfNjA==
X-Received: by 2002:a17:90a:bc9:b0:2d8:7a63:f9c8 with SMTP id 98e67ed59e1d1-2e3dc2d22f0mr20946491a91.14.1729478213703;
        Sun, 20 Oct 2024 19:36:53 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad355bebsm2337008a91.7.2024.10.20.19.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 19:36:53 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH net-next v4 0/3] Add the dwmac driver support for T-HEAD
 TH1520 SoC
Date: Sun, 20 Oct 2024 19:35:59 -0700
Message-Id: <20241020-th1520-dwmac-v4-0-c77acd33ccef@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA++FWcC/x2MQQqAIBAAvyJ7TlAxkr4SHUq33EMWKiWEf086D
 XOYeSFhJEwwshci3pToDE10x8D6JezIyTUHJZSWQgmevewb3HMslqPU1prNaDWs0JIr4kbl300
 QMPOAJcNc6wd0tB++aAAAAA==
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.1

This series adds support for dwmac gigabit ethernet in the T-Head TH1520
RISC-V SoC along with dts patches to enable the ethernet ports on the
BeagleV Ahead and the LicheePi 4A.

The pinctrl-th1520 driver, pinctrl binding, and related dts patches are
in linux-next so there are no longer any prerequisite series that need
to be applied first.

Changes in v4:
 - Rebase on next for pinctrl dependency
 - Add 'net-next' prefix to subject per maintainer-netdev.rst
 - Add clocks, clock-names, interrupts and interrupt-names to binding
 - Simplify driver code by switching from regmap to regualar mmio

Changes in v3:
 - Rebase on v6.12-rc1
 - Remove thead,rx-internal-delay and thead,tx-internal-delay properties
 - Remove unneeded call to thead_dwmac_fix_speed() during probe
 - Fix filename for the yaml file in MAINTAINERS patch
 - Link: https://lore.kernel.org/linux-riscv/20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com/

Changes in v2:
 - Drop the first patch as it is no longer needed due to upstream commit
   d01e0e98de31 ("dt-bindings: net: dwmac: Validate PBL for all IP-cores")
 - Rename compatible from "thead,th1520-dwmac" to "thead,th1520-gmac"
 - Add thead,rx-internal-delay and thead,tx-internal-delay properties
   and check that it does not exceed the maximum value
 - Convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe() and
   delete the .remove_new hook as it is no longer needed
 - Handle return value of regmap_write() in case it fails
 - Add phy reset delay properties to the BeagleV Ahead device tree
 - Link: https://lore.kernel.org/linux-riscv/20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com/

Changes in v1:
 - remove thead,gmacapb that references syscon for APB registers
 - add a second memory region to gmac nodes for the APB registers
 - Link: https://lore.kernel.org/all/20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com/

---
Emil Renner Berthing (1):
      riscv: dts: thead: Add TH1520 ethernet nodes

Jisheng Zhang (2):
      dt-bindings: net: Add T-HEAD dwmac support
      net: stmmac: Add glue layer for T-HEAD TH1520 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml | 115 +++++++++
 MAINTAINERS                                        |   2 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  91 +++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 119 +++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi              |  50 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  10 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 268 +++++++++++++++++++++
 9 files changed, 657 insertions(+)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241020-th1520-dwmac-e14cc8f8427b

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>



Return-Path: <linux-kernel+bounces-345292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B617598B437
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3641C23124
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E7B1BC06B;
	Tue,  1 Oct 2024 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="GJnz73YO"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2CA1BBBD6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727763827; cv=none; b=gW6MDexNGbP/DE5jBd93K96IDmp5i/UaGW3XL87ywkeRH1by8DURAyeWl97V3lSeqNyp84kzQjCBZXNplYIeFU30RuAxKAxpywGsgSOTLWlWoLHIDVFTgxdO3K98lxFHBvg7rFcX8tQSN9qLoeSBJNu2cv4r5udthXxCFKtgZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727763827; c=relaxed/simple;
	bh=wJuKxhE+CbOst/5fBpiq+Ys9KTnzHitn8o0kkwpLeSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ouJgGGFx75HXqMi4ich12o8903sGZM32m/tF3qZlSs6NI8TreS+InxEMBVdHYdErgEaDofTh1VarPH4F4yQNxi/Y5wGFzQFVSwRz0EmRBM0uxSBBI6ggxmoERF/1OEJhmEuYwTm4QdvIuDXaBDve2NCmEDIymZ4SJTUXk5cNR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=GJnz73YO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso3791058a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727763825; x=1728368625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+q1bYkfaGa893H/27+8NsQZ36xTulPFgzj3nN7/MB8=;
        b=GJnz73YOMUIHcbJaGKFmqYgHpJSoFwhtqCGsQb+ePSrKh5GuATyAgOg6KITt87sROq
         zfLymsnc9J2PDj9TDTZkCB4CJGbdndkna6z0dSngb+eeJ9WLAj1ovlw4An/ahFhqF3MG
         VKM1kueSyQvd8KGbqEf80rOHSC7CVXn/xsXNhmN+gVz2eVxxk/JXb17++JUamzXT79WZ
         v/SvrPhJch/BGD5hhehHqg3+OJYYZ7a25+FRAEjoG72E5NlmWvlDX0O965YEUX5shpn3
         fm8hr0cGXAoxX3LxSUmgFDqGrqO8g8Pg9sPeKO1F7f/r+eNAguFRiwmSr0NRvVgoFw4h
         ScHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727763825; x=1728368625;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+q1bYkfaGa893H/27+8NsQZ36xTulPFgzj3nN7/MB8=;
        b=g+WHpkaAohxMTi7DO7n59qP/fHGnGe+flPNwrv6iTn6a5uXKFVGc8419i59GOdQx09
         7P8+L7ab2p0V7Jm1TUCcAPQQnsxt1f8e+XUDRMlrzlXDfsdrnoJIFYnptjlqMcn0AtB+
         beTmCS9ZS+7soYV7XBa+M7CQopEWe9frFwjGEQT+vHuP8nJPTl+33oiHV8hSNqKDbJ8s
         DJFDApcNOlPrmlAud/MptqUAZ9KQAP66QaPNZrJdqStilhZNYqlmkeLPeMGaZQaLVHDq
         p3KKQymZ3yyA9effeJfJKO+BPZAOh2vT/FWHPDmDGFr9JBu+kW4ZENwvl2icQiN5K1F8
         AxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAnE1vBBePfjI2zK1y4JmLXS+sL2WbuD0/EgtE4WICBnM42ebYwqwnLNbgBFF7KUBI/wwv1QnAkgkoiNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEOMDGZC916ur/EmWbMYKpZ52AmhYp8Uq9DFRDry7Otwxoe52
	kqMBEKuw7MdW5Ws5rVQZHlQ8fhOb5EcNh4I7dq/5mhmFf7cNalqCPxkU5AZI4/Y=
X-Google-Smtp-Source: AGHT+IEkhgSmX+RGtd3vmzudwdHgedS3ETir5Ngx2WIar+CdDO/B+TgTsD/9vvMbqKQfM2/28VijBQ==
X-Received: by 2002:a05:6a20:9f90:b0:1cf:3885:b9d8 with SMTP id adf61e73a8af0-1d4fa6cfd38mr19206388637.27.1727763824817;
        Mon, 30 Sep 2024 23:23:44 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264ba68dsm7267804b3a.57.2024.09.30.23.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:23:44 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH v3 0/3] Add the dwmac driver support for T-HEAD TH1520 SoC
Date: Mon, 30 Sep 2024 23:23:23 -0700
Message-Id: <20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFuV+2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS2MD3ZIMQ1MjA92U8tzEZF1jkzTTlBSD5OTkNAsloJaCotS0zAqwcdG
 xtbUAVYXE4l4AAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Drew Fustini <dfustini@tenstorrent.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org
X-Mailer: b4 0.14.1

This series is based on 6.12-rc1 and depends on this pinctrl series:

 20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com

I have a branch with this series and the dependencies:

 https://github.com/pdp7/linux/tree/b4/th1520-dwmac

Regarding clocks, the gmac nodes in th1520.dtsi have the "stmmac_clk"
clock set to CLK_GMAC_AXI in the AP_SUBSYS clock controller. This
corresponds to the enable bit for the GMAC axi4_clk gate which is
handled by the clk-th1520-ap driver. thead_dwmac_fix_speed() does not
modify anything in the AP_SUBSYS clock controller. It only writes to
GMAC APB registers. It seems unnecessary to create a new clock driver
just for the GMAC APB registers. Refer to section 1.6.2 in the TH1520
Peripheral Interface User Manual [1].

I've removed the properties that I added in v2: thead,rx-internal-delay
and thead,tx-internal-delay. The units for the delay field in the rgmii
delay control registers are not documented. Andrew Lunn suggested I
just hard code the delay field to 0 since I don't know the units and
the boards work with the hardware reset value of 0.

[1] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs

Changes in v3:
 - Rebase on v6.12-rc1
 - Remove thead,rx-internal-delay and thead,tx-internal-delay properties
 - Remove unneeded call to thead_dwmac_fix_speed() during probe
 - Fix filename for the yaml file in MAINTAINERS patch

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
 .../devicetree/bindings/net/thead,th1520-gmac.yaml |  97 +++++++
 MAINTAINERS                                        |   2 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  91 +++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 129 +++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi              |  50 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 291 +++++++++++++++++++++
 9 files changed, 673 insertions(+)
---
base-commit: 6b16e599500bd0002164d9edcb8bf7652d9888fa
change-id: 20240930-th1520-dwmac-34f5dd0cccf8

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>



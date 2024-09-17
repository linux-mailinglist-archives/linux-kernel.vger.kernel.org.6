Return-Path: <linux-kernel+bounces-331729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E697B08C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051C41F23C72
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28632171E6E;
	Tue, 17 Sep 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="YGoFlGKf"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC81CAB8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578273; cv=none; b=lRQf9jiT3B0blzgJ5wU53pCahNKhvE+FevLxv5AB75hW1VaXNwL3zbCUtxVvZxtr/zPkr5gbOtJDc3/K3m8uivcPxxEO2Ag8/A93huEjyToJPf/Ow5takOK2jRSDgadnA+vpAvfQtvz95ZrlugrjmuCINy2pCC61Ql/wlQ+jnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578273; c=relaxed/simple;
	bh=2amREECiuWPtLoFri60bme/WheSMSQNmC+FaNhqC314=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=P6GsEJKIXbG4qVSWpoJl913NHlcMEvbi3192+y1VawGtqFc7PvwTqrconddrR4FWrf46vifmIH7ofTxRgJWnfdWMew+2y4Yrkk8oKqalNvliJu5aH9usiyLdpDz5Ns9vCWgwsgtEh3kiKljE4rBFCFmVC5NmgFLqBlO+UTUuZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=YGoFlGKf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71957eb256bso1964327b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726578271; x=1727183071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fC01ApAI2xiRo01+6ZsMz3W1Z0be43G8VgU22JuKOg=;
        b=YGoFlGKfhwDk3loEIPCIX3TBhJj8nTacii2ETW9WCCqmghdnEvN3hXov28I+9E4K02
         aQubAQRDLlXbKf4FczcHV3i7wUayBiF1XutaD2GsoYlqWZSWaTrKq0Gt/gV5Ohk6i75n
         RnlwA8TO0M+X43SIHepfXhwvrT9mCsIqH0Qb0n0qJyOkjxUhlbHkqyzi8clMtCTUmnKe
         FWFDzS9jsHNlkoXb7bxMxYCMZqVxuVAFZyCEnxDzv6Hjs+jYKj9cCjww/fw1IuegFiv8
         Sx12XDwCaZbk+gzYcrje7exCdErjdDznIJqrb39c8srZyIJ7Oc79iT1pRS+Csa69j0wf
         fAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726578271; x=1727183071;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fC01ApAI2xiRo01+6ZsMz3W1Z0be43G8VgU22JuKOg=;
        b=DYjIEqH+JBehySv5RZc5wM2nb7vDCmJNTMQPE6RnU/f2yBB9keqLsIuajML4p90vca
         XrYigneXNX3UolSPpTqc1bLMWhXukMN1n/QrCIoV4NaomkelNe4z0TWluFccH1983yrS
         HhRMdpCAzy5eOZSN3Lzw1KccPpOxqaJBMPi6Dlqh136BAQwjLAsrWb7968DF37NRjYUU
         ewyb4i/ok80St21+mPTHaAdp/foDZpRtZdlYmBcwxFkwqErcPcSL54toTxojABF88z2y
         6xonE18R2SE7XjnwFkBZCk31ruwU+mUEobbQ74nJMVtSYzW2yv8EHTL2Jj5JeUngrgfW
         utmA==
X-Forwarded-Encrypted: i=1; AJvYcCXJR++0ndCjEIPoxqeYnH6wB8rSkz1cHrLiIz8zPL6xZ15+21kaXtjfRRRkqc/USXEoKUS6XQ/LYkaAh6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFrQHzT5UfucwcR2W6/46BcWc1yj/iv7hOc2QJrOeMJ54RZgj
	3ivYuuVymoYTaXy0nODRuzKZ8sR9q4PTc1SRRkhnhtKu3k9v7/QB44KndsDhu48=
X-Google-Smtp-Source: AGHT+IEJWwmnIQGoJxuHkNWb54HgOHUJ5HPr7nQy44p04MsUVikXslcg4GRjyMp4pqihjfW9E+yrbg==
X-Received: by 2002:a05:6a20:43a0:b0:1cf:4679:9b97 with SMTP id adf61e73a8af0-1d112e8beffmr22291992637.37.1726578270424;
        Tue, 17 Sep 2024 06:04:30 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b329sm5151248b3a.136.2024.09.17.06.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:04:29 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:04:29 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Sep 2024 06:04:20 PDT (-0700)
Subject:     Re: [PATCH v5 00/10] riscv: add initial support for SpacemiT K1
In-Reply-To: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
CC: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, cyy@cyyself.name, dlan@gentoo.org,
  daniel.lezcano@linaro.org, tglx@linutronix.de, samuel.holland@sifive.com, anup@brainfault.org,
  Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org, lkundrak@v3.sk, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
  jesse@rivosinc.com, jszhang@kernel.org, inochiama@outlook.com, uwu@icenowy.me,
  zhangmeng.kevin@spacemit.com, kevin.z.m@hotmail.com, Conor Dooley <conor.dooley@microchip.com>,
  matthias.bgg@kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: dlan@gentoo.org
Message-ID: <mhng-5bc45db9-5deb-4db6-8733-561768b2968c@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 17:28:03 PDT (-0700), dlan@gentoo.org wrote:
> SpacemiT K1 is an ideal chip for some new extension such as RISC-V Vector
> 1.0 and Zicond evaluation now. Add initial support for it to allow more
> people to participate in building drivers to mainline for it.
>
> This kernel has been tested upon Banana Pi BPI-F3 board on vendor U-Boot
> bootflow generated by Armbian SDK[1] and patched OpenSBI[2] to enable
> Zicboz, which does not in the vendor dts on its U-Boot. Then successfully
> booted to busybox on initrd with this log[3].
>
> As previous discussion in patch v1[4], maintainer expect more basic drivers
> ready before really merging it, which would be fine. For other follow-up patches,
> that are clk, pinctrl/gpio, reset.. My current goal would target at a headless
> system including SD card, emmc, and ethernet.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if you guys want to take this through some SOC tree.  I'm not really 
sure what the bar is for SOC support to get merged, but I'd be happy to 
just see this booting at all -- we've got a bunch of them floating 
around and the vendor kernels are pretty crusty, so anything's an 
improvement on my end.

> In this series, the uart node has no 'fifo-size', 'tx-threshold' property populated,
> will add them once this patch is resolved, see thread [5]
>
> P.S: talked to Yangyu, I will help and take care of this patch series, thanks
>
> ---
> Changes in v5:
> - fix cache-sets in dts
> - collect Rob's Ack
> - rebase to 6.11-rc1
> - Link to v4: https://lore.kernel.org/r/20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org
>
> Changes in v4:
>  - add i/d-cache, l2-cache info
>  - squash uart1 dts node
>  - update tags
>  - Link to v3: https://lore.kernel.org/r/20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org
>
> Changes in v3:
>  - fix dt_binding_check error
>  - fix plic compatible
>  - fix uart node name
>  - add uart1 dts node
>  - collect tags
>  - Link to v2: https://lore.kernel.org/r/20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org
>
> Changes in v2:
>  - fix timebase-frequency according to current setting
>  - add other uart dt nodes, fix input frequency
>  - introduce new uart compatible for K1 SoC
>  - add 'k1' prefix to bananapi-f3.dts
>  - fix k1-clint compatible
>  - fix some typos
>  - Link to v1: https://lore.kernel.org/r/tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com
>
> Link: https://github.com/BPI-SINOVOIP/armbian-build/tree/v24.04.30 [1]
> Link: https://gist.github.com/cyyself/a07096e6e99c949ed13f8fa16d884402 [2]
> Link: https://gist.github.com/cyyself/a2201c01f5c8955a119641f97b7d0280 [3]
> Link: https://lore.kernel.org/r/20240618-hardwood-footrest-ab5ec5bce3cf@wendy [4]
> Link: https://lore.kernel.org/linux-riscv/20240706082928.2238-1-jszhang@kernel.org/ [5]
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
>
> ---
> Yangyu Chen (9):
>       dt-bindings: vendor-prefixes: add spacemit
>       dt-bindings: riscv: Add SpacemiT X60 compatibles
>       dt-bindings: riscv: add SpacemiT K1 bindings
>       dt-bindings: timer: Add SpacemiT K1 CLINT
>       dt-bindings: interrupt-controller: Add SpacemiT K1 PLIC
>       riscv: add SpacemiT SoC family Kconfig support
>       riscv: dts: add initial SpacemiT K1 SoC device tree
>       riscv: dts: spacemit: add Banana Pi BPI-F3 board device tree
>       riscv: defconfig: enable SpacemiT SoC
>
> Yixun Lan (1):
>       dt-bindings: serial: 8250: Add SpacemiT K1 uart compatible
>
>  .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
>  Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
>  .../devicetree/bindings/riscv/spacemit.yaml        |  28 ++
>  Documentation/devicetree/bindings/serial/8250.yaml |   4 +-
>  .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  arch/riscv/Kconfig.socs                            |   5 +
>  arch/riscv/boot/dts/Makefile                       |   1 +
>  arch/riscv/boot/dts/spacemit/Makefile              |   2 +
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  19 +
>  arch/riscv/boot/dts/spacemit/k1.dtsi               | 459 +++++++++++++++++++++
>  arch/riscv/configs/defconfig                       |   1 +
>  12 files changed, 523 insertions(+), 1 deletion(-)
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240626-k1-01-basic-dt-1aa31eeebcd2
>
> Best regards,


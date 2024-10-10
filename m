Return-Path: <linux-kernel+bounces-358911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B83998534
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592EC1C23728
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD91C8FCA;
	Thu, 10 Oct 2024 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdcMt+w3"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379861C8FB2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560325; cv=none; b=kb4IAlJDVaW3GVveMz51DwMndR/ysMnlXe66DfKbW3VgfBLwr7fqTKuq5BI1RotAo4gEfeDFur1Zq2ZpJUE8SBIlpfBcx23mliRdMcHBghCRydectGugDv+TzXko3VH2JCu47JpXsA5IVAgTa/D5ppBQOV2JslInjloY1xCtudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560325; c=relaxed/simple;
	bh=J3aYFpPrC50CllHr4Hn3VV8ClY8F7L0X2pqY6hrEHkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geNTg4MnsHy52BRJQtW8GuU0twp1NPl02E7rbHCMx9Lc3WvWVmkcK/v0srbaTpHNSx06AsgaStqFhVSsEFz+4SJvQm+XUPWZWrrTDYlvFVYn0ITaWvFyuGkKByYUOgxNR7NsUsxu5JvQ7vm+8lBQ9s2+SrCtyNRSx7rhqnWHiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sdcMt+w3; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so638704276.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560322; x=1729165122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWKAy3syWeqfyDajdP61GxAc3COo467zM9mfdJaAXd8=;
        b=sdcMt+w3EngWhB8NAPYoLO0QJdOXt8i39OaTy1lK6DIMchdia9ySCJl1ssvx1QXdDQ
         WcumZfcgicHl7JERPFsuzgsIfTEVDEVyZpgeUxvjSB46IGLJIQm1jmh/Swxw+7DZWbXl
         eCIb4y05C0CXtaT/lhwXxc2nwM9+GU4bDCizUNXlKUvTefvD0PHbEEmYhVYPPcFarS0W
         g5GG943x/TDIpeSBYqPb/fnJtOOu/rNG8Zqpes8y0n0W8jXjWnM89uH673MtDc84FwHD
         esM6eJl1/E8uKv/QxPc6hWNKEwtUNU7zHBQDMrVt/Y9/m9WbstYcciK0tm1vwUr5YEOv
         51zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560322; x=1729165122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWKAy3syWeqfyDajdP61GxAc3COo467zM9mfdJaAXd8=;
        b=PhbcgfBNUEBOVmdQVHFdtqHhnE3TUA8DU8X0LxfWNhAwLRl0pY6uTqjkOnA1AeQYa5
         DPlYHEXy7w/2467Cj2rFIL8X9y7WFeLR5ynaRm3W5so5oMSSrO1k8HI+OFn0M88Mwmb2
         YVHWm2x4z/W2rmQ8CjYLyVs+Ba9RukoQoFW7t6ILz+dW3xyKsGeUb4G7LQVyRgpIoNrQ
         VV+m/DnJa2ipubAqkU/kMVD71EltG0QGPl84YZoEMHNep4olgJsRGe7eZTYqeptHUd56
         rfISaGDKgm3kXxmsUlgU1HfbHtBSSpMR0OMn9IaXC94ea0lF+zBN2ruHfxRIDpydG2+m
         t8FA==
X-Forwarded-Encrypted: i=1; AJvYcCU/yqxtHmtYKKBmxhykTgWij5qe3slYwatFLGLlwGg2C0OnhtZNFMWsL9z7XIoFU5Yenkzwl0BexBeWK9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYp1ltd8yo2BelyD5GwZ5DPZO+YnVOI5zFOIlHUfaON/Z7AZj
	SbukD6HGTi48dSgtgOqTRqtLvVxBbHstn+YJDqslg/nLyjzigbUqrWn1NkZ3LNRjyYp6K9cH0Br
	lSvILR0M8Egv5nB1mGOq81LrJbEoSy+i5fEB86A==
X-Google-Smtp-Source: AGHT+IGsDOFFVam6JAIJEMARKuCkSZlVAWXosNzehP9/3intrl55jugGbN70+7bRrhPtvnHvy1Ow9aegOnplHDlyGNg=
X-Received: by 2002:a05:6902:c03:b0:e1d:44e9:a8fa with SMTP id
 3f1490d57ef6-e28fe40ff41mr5210305276.46.1728560322138; Thu, 10 Oct 2024
 04:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241008100332eucas1p12e84a156c835e719e6916331762c74b0@eucas1p1.samsung.com>
 <20241008100327.4108895-1-m.wilczynski@samsung.com>
In-Reply-To: <20241008100327.4108895-1-m.wilczynski@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Oct 2024 13:38:05 +0200
Message-ID: <CAPDyKFodeBUaZwAguAS-=t1tgmo=_mbm+v4JkGOXRON+hDuTVQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Prevent stale command interrupt handling
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: adrian.hunter@intel.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 12:03, Michal Wilczynski <m.wilczynski@samsung.com> wrote:
>
> While working with the T-Head 1520 LicheePi4A SoC, certain conditions
> arose that allowed me to reproduce a race issue in the sdhci code.
>
> To reproduce the bug, you need to enable the sdio1 controller in the
> device tree file
> `arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi` as follows:
>
> &sdio1 {
>         bus-width = <4>;
>         max-frequency = <100000000>;
>         no-sd;
>         no-mmc;
>         broken-cd;
>         cap-sd-highspeed;
>         post-power-on-delay-ms = <50>;
>         status = "okay";
>         wakeup-source;
>         keep-power-in-suspend;
> };
>
> When resetting the SoC using the reset button, the following messages
> appear in the dmesg log:
>
> [    8.164898] mmc2: Got command interrupt 0x00000001 even though no
> command operation was in progress.
> [    8.174054] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    8.180503] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
> [    8.186950] mmc2: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> [    8.193395] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> [    8.199841] mmc2: sdhci: Present:   0x03da0000 | Host ctl: 0x00000000
> [    8.206287] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [    8.212733] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x0000decf
> [    8.219178] mmc2: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> [    8.225622] mmc2: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
> [    8.232068] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [    8.238513] mmc2: sdhci: Caps:      0x3f69c881 | Caps_1:   0x08008177
> [    8.244959] mmc2: sdhci: Cmd:       0x00000502 | Max curr: 0x00191919
> [    8.254115] mmc2: sdhci: Resp[0]:   0x00001009 | Resp[1]:  0x00000000
> [    8.260561] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [    8.267005] mmc2: sdhci: Host ctl2: 0x00001000
> [    8.271453] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> 0x0000000000000000
> [    8.278594] mmc2: sdhci: ============================================
>
> I also enabled some traces to better understand the problem:
>
>      kworker/3:1-62      [003] .....     8.163538: mmc_request_start:
> mmc2: start struct mmc_request[000000000d30cc0c]: cmd_opcode=5
> cmd_arg=0x0 cmd_flags=0x2e1 cmd_retries=0 stop_opcode=0 stop_arg=0x0
> stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0 sbc_flags=0x0
> sbc_retires=0 blocks=0 block_size=0 blk_addr=0 data_flags=0x0 tag=0
> can_retune=0 doing_retune=0 retune_now=0 need_retune=0 hold_retune=1
> retune_period=0
>           <idle>-0       [000] d.h2.     8.164816: sdhci_cmd_irq:
> hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x10000
> intmask_p=0x18000
>      irq/24-mmc2-96      [000] .....     8.164840: sdhci_thread_irq:
> msg=
>      irq/24-mmc2-96      [000] d.h2.     8.164896: sdhci_cmd_irq:
> hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x1
> intmask_p=0x1
>      irq/24-mmc2-96      [000] .....     8.285142: mmc_request_done:
> mmc2: end struct mmc_request[000000000d30cc0c]: cmd_opcode=5
> cmd_err=-110 cmd_resp=0x0 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0 need_retune=0
> hold_retune=1 retune_period=0
>
> Here's what happens: the __mmc_start_request function is called with
> opcode 5. Since the power to the Wi-Fi card, which resides on this SDIO
> bus, is initially off after the reset, an interrupt SDHCI_INT_TIMEOUT is
> triggered. Immediately after that, a second interrupt SDHCI_INT_RESPONSE
> is triggered. Depending on the exact timing, these conditions can
> trigger the following race problem:
>
> 1) The sdhci_cmd_irq top half handles the command as an error. It sets
>    host->cmd to NULL and host->pending_reset to true.
> 2) The sdhci_thread_irq bottom half is scheduled next and executes faster
>    than the second interrupt handler for SDHCI_INT_RESPONSE. It clears
>    host->pending_reset before the SDHCI_INT_RESPONSE handler runs.
> 3) The pending interrupt SDHCI_INT_RESPONSE handler gets called, triggering
>    a code path that prints: "mmc2: Got command interrupt 0x00000001 even
>    though no command operation was in progress."
>
> To solve this issue, we need to clear pending interrupts when resetting
> host->pending_reset. This ensures that after sdhci_threaded_irq restores
> interrupts, there are no pending stale interrupts.
>
> The behavior observed here is non-compliant with the SDHCI standard.
> Place the code in the sdhci-of-dwcmshc driver to account for a
> hardware-specific quirk instead of the core SDHCI code.
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Applied for fixes and by adding a stable+fixes tag, thanks!

Kind regards
Uffe


> ---
> v2:
>  - instead of modifying SDHCI core code, only modify th1520 specific
>    reset
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 8999b97263af..8fd80dac11bf 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -852,6 +852,14 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
>
>         sdhci_reset(host, mask);
>
> +       /* The T-Head 1520 SoC does not comply with the SDHCI specification
> +        * regarding the "Software Reset for CMD line should clear 'Command
> +        * Complete' in the Normal Interrupt Status Register." Clear the bit
> +        * here to compensate for this quirk.
> +        */
> +       if (mask & SDHCI_RESET_CMD)
> +               sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +
>         if (priv->flags & FLAG_IO_FIXED_1V8) {
>                 ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>                 if (!(ctrl_2 & SDHCI_CTRL_VDD_180)) {
> --
> 2.34.1
>


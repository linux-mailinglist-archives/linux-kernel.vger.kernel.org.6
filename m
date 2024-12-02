Return-Path: <linux-kernel+bounces-427969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835439E0817
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F0D285738
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B516DC28;
	Mon,  2 Dec 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMpAj4ci"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827016EBE9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155968; cv=none; b=oDB1tWM3+9hrt4OCS/WTtHGtYmHwK2pf2BTlb9cczOSxsCL8oSF+xHh4fVH9IcH1GdAsnrhF77R1sR1zBsW/SvIHWFtWJyIqTBgnpkz4J5l6gqsCtmpth559OjE7yHHqWrftTjN4LmZyKw8fOGX1MQoOh+1WDb8HTZY59URbJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155968; c=relaxed/simple;
	bh=XLKlaA22370vq2g3K3tte2gx1v7huvhbQMtU+YATtrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpvXC+1G479rFQS4CxDMjxTHPEcDyZVz4+bgJdlrwB/e8AQxfT/z/dHtsn5Wo0qQ8bZLmo262agMM8THFLFntlp1UkOMfLvbxmJa+VqaFSn0dyh5YaOvtaoDTr18vhTlR0KGMGLz1I4K9dFHfsQCjgGgzHC41z/Os4MmmLbJ90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMpAj4ci; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef402e4589so41394477b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733155966; x=1733760766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uSc4oaHdwRNziEqNhHrjMgTiwYs2HHk19dmenoRtAWk=;
        b=pMpAj4ciRcHeYSzYUIHALw3lRfF/TciuNOc7zwDE4KYcr3x3BBcMLPM/i8gX4YVsE3
         enWW4nhR43A5APYJMrmcbwVkamTkoBaaCy1EHBhmltMLujbnefTi+tIUnozColtCi3+W
         bjmXauDP1nTDPagZtjfKCttfYF9fMrkVnx7HE1uPBSRL+Ka2JzO1054e73nSQMqYrRC9
         QWOdgv13E1YAX0ptWZZJHGr8CCbLETae61aOvWs9prZnr4VLeb+OA7rMrenb193RYOXE
         FUWVPNnVLdAyTL5GEMNKpf7Zbd64wohheugPqjqq3JDRb7kT0KHeXcoqJ2vh4nJXgFWM
         bPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733155966; x=1733760766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSc4oaHdwRNziEqNhHrjMgTiwYs2HHk19dmenoRtAWk=;
        b=lMzRmn7IsvogHBE3jrV4M+9sNfikWbPwtjPxiK8feNdJjqdwBq/+4t40CSgQZv9DJl
         jkDZJhhwn+1ODZJ8IFyNks0R+j/vNqr7lmQa2vtDfj9pqN5XYeGmDN6jU23+eOHwwRpN
         O2eVpQH4HP8Vx8Qewug9gq6acqlgupSaLjrzRL4iaiFxIUIinRWA+4RONLQJCo8SWddO
         g5YrRopGlqdEXGb5jHv646J4J33ruJiP5nNcPoYkoQ/PI7O9ZCSjj7M7pVNloRuCIGzc
         riGVGNeG4kueopP/FuIyECY5jsMHHD4fG0jnn8XbVbGCpyPxJr7WwgLQgklI3B2ydIuk
         vMgA==
X-Forwarded-Encrypted: i=1; AJvYcCUA3f4JlbuBB1mIEnzWi7ar+YylOD0SgiBzFtYcDw5YNMO9oUJMbuchcZisae9J7Se4v7r0tlYPo4v5Tlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2SD3e1Kmxw87wuG4wbZlbLw9d+lhHS7aG3+ffAPcMzQc+4Hn
	ZNpQonGZKF5dA4RSTS61AnQPyfuNA+3uIi8tiD/cDYA+3+jAOXIBRP2qdHbqm2PU9VCxhkUVvd6
	92go/xkhHpGP0yvW9QHHJlaIgsrdfKxYZCJAbmA==
X-Gm-Gg: ASbGnctwPnMw6l56+av5Sao0xO1yfoKzwRrRbnNp1YoEbGviKbIu9IYOx/Jxjb0JkLs
	QEKlr1/LcbXO75c/6iVDoHa3zvDHNIzcY
X-Google-Smtp-Source: AGHT+IHONp0dk8Yoe87v3UNeSPiKD8c6OQO1yBQtzwhyjC1T8YXjuupz6BUT7dFNeVR/yJzTpI+zO7gY+3/7XDn2iJM=
X-Received: by 2002:a05:6902:e13:b0:e38:b34d:121a with SMTP id
 3f1490d57ef6-e395b8af561mr22234937276.20.1733155965799; Mon, 02 Dec 2024
 08:12:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121075231.3910922-1-shengjiu.wang@nxp.com>
In-Reply-To: <20241121075231.3910922-1-shengjiu.wang@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 17:12:10 +0100
Message-ID: <CAPDyKFrm8wv7uFAumx5d6uMhr=LLUT8_RsQhNMF4DyOUe7uMFg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpcv2: Adjust delay after power up handshake
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	shengjiu.wang@gmail.com, francesco@dolcini.it
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 08:53, Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The udelay(5) is not enough, sometimes below kernel panic
> still be triggered:
>
> [    4.012973] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    4.012976] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not tainted 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> [    4.012982] Hardware name: Toradex Verdin iMX8M Plus WB on Dahlia Board (DT)
> [    4.012985] Call trace:
> [...]
> [    4.013029]  arm64_serror_panic+0x64/0x70
> [    4.013034]  do_serror+0x3c/0x70
> [    4.013039]  el1h_64_error_handler+0x30/0x54
> [    4.013046]  el1h_64_error+0x64/0x68
> [    4.013050]  clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> [    4.013059]  __genpd_runtime_resume+0x30/0x80
> [    4.013066]  genpd_runtime_resume+0x114/0x29c
> [    4.013073]  __rpm_callback+0x48/0x1e0
> [    4.013079]  rpm_callback+0x68/0x80
> [    4.013084]  rpm_resume+0x3bc/0x6a0
> [    4.013089]  __pm_runtime_resume+0x50/0x9c
> [    4.013095]  pm_runtime_get_suppliers+0x60/0x8c
> [    4.013101]  __driver_probe_device+0x4c/0x14c
> [    4.013108]  driver_probe_device+0x3c/0x120
> [    4.013114]  __driver_attach+0xc4/0x200
> [    4.013119]  bus_for_each_dev+0x7c/0xe0
> [    4.013125]  driver_attach+0x24/0x30
> [    4.013130]  bus_add_driver+0x110/0x240
> [    4.013135]  driver_register+0x68/0x124
> [    4.013142]  __platform_driver_register+0x24/0x30
> [    4.013149]  sdma_driver_init+0x20/0x1000 [imx_sdma]
> [    4.013163]  do_one_initcall+0x60/0x1e0
> [    4.013168]  do_init_module+0x5c/0x21c
> [    4.013175]  load_module+0x1a98/0x205c
> [    4.013181]  init_module_from_file+0x88/0xd4
> [    4.013187]  __arm64_sys_finit_module+0x258/0x350
> [    4.013194]  invoke_syscall.constprop.0+0x50/0xe0
> [    4.013202]  do_el0_svc+0xa8/0xe0
> [    4.013208]  el0_svc+0x3c/0x140
> [    4.013215]  el0t_64_sync_handler+0x120/0x12c
> [    4.013222]  el0t_64_sync+0x190/0x194
> [    4.013228] SMP: stopping secondary CPUs
>
> The correct way is to wait handshake, but it needs BUS clock of
> BLK-CTL be enabled, which is in separate driver. So delay is the
> only option here. The udelay(10) is a data got by experiment.
>
> Fixes: e8dc41afca16 ("pmdomain: imx: gpcv2: Add delay after power up handshake")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/lkml/20241007132555.GA53279@francesco-nb/
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpcv2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index 6e6ecbf2e152..760301ad8e39 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -403,7 +403,7 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>                  * already reaches target before udelay()
>                  */
>                 regmap_read_bypassed(domain->regmap, domain->regs->hsk, &reg_val);
> -               udelay(5);
> +               udelay(10);
>         }
>
>         /* Disable reset clocks for all devices in the domain */
> --
> 2.34.1
>


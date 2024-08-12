Return-Path: <linux-kernel+bounces-282887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F66C94EA18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02142812E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D3D16DC29;
	Mon, 12 Aug 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYTGu7Fq"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4816132B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455627; cv=none; b=Hba4KzF7wrN5NifhzzenOF7wkya1vj3n1ud9SAO8RhSSQDhDbXf/UlOJB07OqCJwZ23/4/avd43U1E2YW8kRdX1Zn005eGttPDQ7FxMzRjIhgblzR5k7PODxIr+OGX8zRrdZ2YBgkQk7wP8iNF5hyGuUroUArbGN76uShrGBKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455627; c=relaxed/simple;
	bh=UxtazfqpXDeqlFz/0CJQTYOiDqi7EIoHLyXZ2TczuF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbjhFlHM2q513FwcdnNR8Rqr8FIZRCEbkug6bA4kJ+banZk0qGjZDQVW8FKCblBwWP7Jq4iU8PRs9WJF+XlvLZSWJzckwN3I2/Xap6OjW341iGjCsZqUPTrM1rMUwCr/vjw0D8sfEypOWsNdVLXUAixxnnFIVKU4zX5XIzG8RDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OYTGu7Fq; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-821b8d887b8so1121122241.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723455624; x=1724060424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVjhFE1LXg8vxrprP/WgbdJUQCPXYg8soperG0HDucw=;
        b=OYTGu7Fq9oPRmEd9wWGgU8NmFa/U0/Dg98EUx06ZA6CzcbWwAwbKncnwpToozpmp5u
         3SznHygJeeMczPi1dCbyKIoP1rxO3Xsn/Grt3rxoY3Lbnnx5NiKI0D8OnyE9RHvpxED1
         LMkkaTRfnU5Znm0jKQ4uF17O1jD0DOM3fiuD5AHImI9cXi1+FU8/9GOOZuyQEAXZzuG5
         iJwDkq2NYlXslUV7VWXi7ZQCjClPprh4XgSAMdaOOJpBo9GMr7owJiDfbvRhrTTZFI5H
         IzVL2DQJA8lAvfsZ7THnKuoh68TE7AOYGW+ijB0B5pqbq7OZf3rCagjq9nW4q3o/TGzK
         Jr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723455624; x=1724060424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVjhFE1LXg8vxrprP/WgbdJUQCPXYg8soperG0HDucw=;
        b=ax0E4dLFOhKrWT8/emWFCs6MXuARtn1EKBGnlUp9T5REi0iSsW9tX9vEw9QVduWzkw
         fZcOnlXvZH9VOTexWUtFjxM/uq7icQHcctwdCWIi2UQ/gjpC8FhnuywOm+mClicjfvnC
         x3DvDV4BMUy/gngKtIM0YGSK+xfJicLxh21esc5vDRaUJWWgFigyIc3BMfNMMmwu+gc7
         ex/RGVkMzUPLr4naM7pe0RvAaFH780I0ReQWvK+kafvz3DHGe/T7ojbOJAu6LvKqFyvR
         BxIRAftFATk/rt8flOlsrESAE0x5zqL7EhtRDv+sxz/n+u7a80UwCLKWUKiv225gJGVG
         0EBA==
X-Forwarded-Encrypted: i=1; AJvYcCV6LfnIuMB1un2wiJco7X2hLW8uKxkyxv1LQqQwgxFGmiWhczOZ2m71gQbVk1Ss7SLNrh/aMsFJUEw9R/VBUqwIITLKk3Dno9baFvIy
X-Gm-Message-State: AOJu0YzMmERjwuZz5PUipSEOxMj58vuoozHfH5+/5svG9H8Am+oUfU/d
	556zIPGZ6YAdQbOGfAloX7dC6ahdm3Fic9XBZThkA60kd7NlHYswcyEz/xKLQRJseFUIqvHqguc
	eZSJDc7GK9TwcAOZM+12QzKdn/elyanOpuJHZdA==
X-Google-Smtp-Source: AGHT+IGwywSQL2NMVexUKa3WkjoHdNjxA9OJ7LzmouqDA0MzAclMGZ8r1ys42xoldkQbCVAM2hu9PwS2QEWQ4mbjqw0=
X-Received: by 2002:a05:6122:4598:b0:4f6:ca2:ad0 with SMTP id
 71dfb90a1353d-4f912bd958cmr5563996e0c.1.1723455624114; Mon, 12 Aug 2024
 02:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502224703.103150-1-swboyd@chromium.org> <CAE-0n50VDgsg-4QnynvLOzykr3KP5JsnHqeFPA=uRT3EfgL19g@mail.gmail.com>
 <CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com>
 <CAE-0n53X1Gv9nnyDfeivYd7n5W6D1WFkO0tCvYc9drb0+4hQbw@mail.gmail.com>
 <CAMi1Hd2_a7TjA7J9ShrAbNOd_CoZ3D87twmO5t+nZxC9sX18tA@mail.gmail.com> <CAE-0n52JgfCBWiFQyQWPji8cq_rCsviBpW-m72YitgNfdaEhQg@mail.gmail.com>
In-Reply-To: <CAE-0n52JgfCBWiFQyQWPji8cq_rCsviBpW-m72YitgNfdaEhQg@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 12 Aug 2024 15:09:47 +0530
Message-ID: <CAMi1Hd2drhMGTsvnX1aqwpDTOkK_+n2OKMYY1Y9ONHyYiFLTSQ@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Park shared RCGs upon registration
To: Stephen Boyd <swboyd@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Laura Nao <laura.nao@collabora.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Douglas Anderson <dianders@chromium.org>, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 03:07, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Pundir (2024-08-05 03:43:14)
> > On Sat, 3 Aug 2024 at 06:29, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Also please send back the dmesg so we can see what clks are configured
> > > for at boot time. If they're using TCXO source at boot then they're not
> > > going to be broken. In which case those clks can keep using the old clk
> > > ops and we can focus on the ones that aren't sourcing from TCXO.
> >
> > Thank your for this debug patch. I thought I narrowed down the
> > breakage to the clks in drivers/clk/qcom/gcc-sm8550.c, until I ran
> > into the following kernel panic in ucsi_glink driver in later test
> > runs.
>
> Thanks for the info. These are the clks that aren't sourcing from XO
> at registration time:
>
>   gcc_qupv3_wrap1_s7_clk_src with cfg 0x102601 -> parent is gpll0_out_even
>   gcc_ufs_phy_axi_clk_src with cfg 0x103 -> parent is gpll0_out_main
>   gcc_ufs_phy_ice_core_clk_src with cfg 0x503 -> parent is gpll4_out_main
>   gcc_ufs_phy_unipro_core_clk_src with cfg 0x103 -> parent is gpll0_out_main
>   gcc_usb30_prim_master_clk_src with cfg 0x105 -> parent is gpll0_out_main
>
> The original patch is going to inform the clk framework that the parent
> of these clks aren't XO but something like gpll0_out_even, whatever the
> hardware is configured for. That may cause these PLLs to be turned off
> earlier than before if, for example, gcc_ufs_phy_axi_clk_src is turned
> off by a consumer and gcc_usb30_prim_master_clk_src is left enabled at
> boot. That's why we force park clks at registration time, so that they
> can't have their parent clk get turned off by some other clk consumer
> enabling and then disabling a clk that's also parented to the same
> parent.
>
> This same problem exists for RCGs that aren't shared too, but it's
> particularly bad for shared RCGs because the parent PLLs aren't turned
> on automatically by the hardware when things like the GDSC do their
> housekeeping. At least when software is in control we can enable the
> parent PLL and unstick the RCG that was previously cut off.

Thank you Stephen for the detailed explanation. Really appreciate this
knowledge dump.

>
> Can you narrow down the list above to the clk that matters? I guess if
> USB isn't working then gcc_usb30_prim_master_clk_src is the one that
> should be changed and nothing else. Although, I noticed that in the
> first dmesg log you sent the serial console had garbage, and that's
> likely because the rate changed while the clk was registered. I don't
> know why the gcc_qupv3_wrap1_s7_clk_src is marked with the shared clk
> ops. That's confusing to me as I don't expect that to need to be parked
> for any reasons. Maybe qcom folks can comment there but I'd expect plain
> rcg2_ops to be used for those clks. Anyway, if you can narrow down to
> which clk needs to be left untouched it would be helpful.

gcc_qupv3_wrap1_s7_clk_src and gcc_usb30_prim_master_clk_src need to
be left untouched to fix the Audio codec and USB-C host mode breakages
respectively. It seem to have fixed the serial console garbage dump
issue as well.

UFS on SM8550-HDK has it's own issues when booting AOSP from it, so I
couldn't test/verify if the reported gcc_ufs_phy_*_clk_src clk changes
make any difference. But I'll bookmark this change for future
reference if I run into any relevant UFS probe deferrals once we fix
the existing/on-going issues.

>
> >
> > [    7.882923][    T1] init: Loading module /lib/modules/ucsi_glink.ko
> > with args ''
> > [    7.892929][   T92] Unable to handle kernel NULL pointer
> > dereference at virtual address 0000000000000010
> > [    7.894935][    T1] init: Loaded kernel module /lib/modules/ucsi_glink.ko
> > [    7.902670][   T92] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000886218000
> > [    7.902674][   T92] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > [    7.993995][   T64] qcom_pmic_glink pmic-glink: Failed to create
> > device link (0x180) with a600000.usb
> > [    8.078673][   T92] CPU: 7 UID: 0 PID: 92 Comm: kworker/7:2
> > Tainted: G S          E      6.11.0-rc2-mainline-00001-g4153d980358d
> > #6
> > [    8.078676][   T92] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
> > [    8.078677][   T92] Hardware name: Qualcomm Technologies, Inc.
> > SM8550 HDK (DT)
> > [    8.078679][   T92] Workqueue: events pmic_glink_ucsi_register [ucsi_glink]
> > [    8.078682][   T92] pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT
> > -SSBS BTYPE=--)
> > [    8.078684][   T92] pc : pmic_glink_send+0x10/0x2c [pmic_glink]
> > [    8.078685][   T92] lr : pmic_glink_ucsi_read+0x84/0x14c [ucsi_glink]
> > [    8.078704][   T92] Call trace:
> > [    8.078705][   T92]  pmic_glink_send+0x10/0x2c [pmic_glink]
> > [    8.078706][   T92]  pmic_glink_ucsi_read+0x84/0x14c [ucsi_glink]
> > [    8.078707][   T92]  pmic_glink_ucsi_read_version+0x20/0x30 [ucsi_glink]
> > [    8.078708][   T92]  ucsi_register+0x28/0x70
> > [    8.078717][   T92]  pmic_glink_ucsi_register+0x18/0x28 [ucsi_glink]
> > [    8.078718][   T92]  process_one_work+0x184/0x2e8
> > [    8.078723][   T92]  worker_thread+0x2f0/0x404
> > [    8.078725][   T92]  kthread+0x114/0x118
> > [    8.078728][   T92]  ret_from_fork+0x10/0x20
> > [    8.078732][   T92] ---[ end trace 0000000000000000 ]---
> > [    8.078734][   T92] Kernel panic - not syncing: Oops: Fatal exception
> > [    8.078735][   T92] SMP: stopping secondary CPUs
> > [    8.279136][   T92] Kernel Offset: 0x14d9480000 from 0xffffffc080000000
> > [    8.279141][   T92] PHYS_OFFSET: 0x80000000
> > [    8.279143][   T92] CPU features: 0x18,004e0003,80113128,564676af
> > [    8.279148][   T92] Memory Limit: none
>
> That looks like 'client' is NULL in pmic_glink_send(). The VA of 0x10 is
> the offset of 'pg' in struct pmic_glink_client. I don't know much about
> that driver but I'd guess that ucsi_glink has some race condition
> assigning the client pointer?
>
> Oh actually, I see the problem. devm_pmic_glink_register_client()
> returns a struct pmic_glink_client pointer that's assigned to
> 'ucsi->client'. And pmic_glink_ucsi_read() uses 'ucsi->client' to call
> pmic_glink_send(). That pointer is NULL because the workqueue that runs
> pmic_glink_ucsi_register() must run before
> devm_pmic_glink_register_client() returns and assigns the client pointer
> to 'ucsi->client'. This is simply a race.
>
>  CPU0                                        CPU1
>  ----                                        ----
>  ucsi->client = NULL;
>  devm_pmic_glink_register_client()
>   client->pdr_notify(client->priv, pg->client_state)
>    pmic_glink_ucsi_pdr_notify()
>     schedule_work(&ucsi->register_work)
>     <schedule away>
>                                              pmic_glink_ucsi_register()
>                                               ucsi_register()
>                                                pmic_glink_ucsi_read_version()
>                                                 pmic_glink_ucsi_read()
>                                                  pmic_glink_ucsi_read()
>                                                   pmic_glink_send(ucsi->client)
>                                                   <client is NULL BAD>
>  ucsi->client = client // Too late!
>
> >
> > I couldn't reproduce this kernel panic on vanilla v6.11-rc2 in 50+
> > test runs after that. So I'm assuming that this debug patch may have
> > triggered it.
> > Attaching the crashing and working dmesg logs with the debug patch applied.
> >
>
> Sounds like you just need to reboot a bunch! Or add an msleep() in
> devm_pmic_glink_register_client() after the notify call to open the race
> window and let the workqueue run.

Thank you for diagnosing this race in ucsi_glink. I needed to run an
overnight reboot test to reproduce this crash, and could reproduce it
on ~380th reboot. I'll check if it has already been reported or fixed
on linux-next.

Regards,
Amit Pundir


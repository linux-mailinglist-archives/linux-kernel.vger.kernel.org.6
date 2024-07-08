Return-Path: <linux-kernel+bounces-244756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DB92A8FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B734FB2155C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C90114C58E;
	Mon,  8 Jul 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THvo8Mbu"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAD14659F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463584; cv=none; b=ZsLpvrCYQ24LA1lhTRkD9IObF2JR12DumLJQuqEogc4ILbCYCdvhhXtOUb/CLACK6WWoXvVlXmGSnP9Zn1ilzn833dRDkS4JRPx4UJMPsA1WhLyj7CdQm8KfJoUryxtbnQ6QRL5ACDjyMUq+AyVGl4t9FZW9cHen38FqHSL/u5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463584; c=relaxed/simple;
	bh=racoVu8wvI3u4YHbVDYj7tnLktr57XtYlHbUHDEyExs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHqWbafhGxQCbpNrwt0rQ5EYG2cd9GfoPL2TQ1Yd3mbCNEZ9JlFvkgPqooSfKWqY7es4gkWWPaJe6XKYvy6gNHfSoxRMaEE39M5tBNz1w59ony8SKXsKsFVayACcoKpl8Nf09FKnzgWVdPdgz+uDFLX3UNdtRlAHUQwdoW7uvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=THvo8Mbu; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfef5980a69so4483610276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720463581; x=1721068381; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cMC60Geoh5176BV6Q5Os4Z08hEawC59RT0dOm40lzQ=;
        b=THvo8MbuL5v/Zag0jSDy4FkAnAGDo91SWGd9Vm3V2G7Sfnxcpy/0J13RW4k7rvDZUH
         tCrAWaJq2TfXBGqYLgZGGAjSVxp9bq2DzyhVgR6RSZE6J0k90DFr8GtKVFVLQRFku6Kj
         6noeH+KCG1BC5TB4lHbuL5U6STRlgEr6ppOiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720463581; x=1721068381;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cMC60Geoh5176BV6Q5Os4Z08hEawC59RT0dOm40lzQ=;
        b=JZlkbQrCDm7Gt5ySrHQj7mu3R2H8ZLhsK42YElIclETjB/5NmAaKT1aKUrBkLseoGX
         E87BwS9R18mdsiYImHy+7o53QG1/XSYgHronK6lSEJtl+jbysaDDiDJlZhcEn6sv6QHZ
         7D3eEEMhtSvsz73d+3+Fg/hFYFGd2EdTYBNJE+IGLOhNXLFkKDt1/G4pZjBXFLz9IKix
         7mXSf16lKB5Etyh1sjgLTkfHGK78Yw/djdP6funOTnCxBrm5f7qwnwTPtIVcVCmzlkUm
         JkjDzNoMSHgYXxSULyQdahqAMIZdN+OCnLGMm9T24IHua9DSLZ5jFAOmFYvQMDtNHVmJ
         GZag==
X-Gm-Message-State: AOJu0YwmQ1S008a3ER8Vz034iHX+jtBeLZvocp6Z/rfPLmJSs4PE643C
	2utU81lmXvrncdnbKZXaEAOKMZlkPbwFrJ84cyEc8lnzYLYt9sRPk3dy5osQCJNu7pNdZUUibwW
	zR0ygTuoEGMZddPRAWhUTw4+39HgDAXXpmyxi
X-Google-Smtp-Source: AGHT+IEdTAs/YLtvGK0YDwMjZ3/VoIAOUXcikoEz26MPVTMxLpQ8Rgbwryb1DM7iWFz6lFTgeH96Dz1mspG4lvZTHrA=
X-Received: by 2002:a25:aba3:0:b0:e03:605b:ecaa with SMTP id
 3f1490d57ef6-e041b22d697mr552851276.61.1720463580761; Mon, 08 Jul 2024
 11:33:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 11:32:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240502224703.103150-1-swboyd@chromium.org>
References: <20240502224703.103150-1-swboyd@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 8 Jul 2024 11:32:59 -0700
Message-ID: <CAE-0n50VDgsg-4QnynvLOzykr3KP5JsnHqeFPA=uRT3EfgL19g@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Park shared RCGs upon registration
To: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Laura Nao <laura.nao@collabora.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Douglas Anderson <dianders@chromium.org>, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Stephen Boyd (2024-05-02 15:47:02)
> There's two problems with shared RCGs.
>
> The first problem is that they incorrectly report the parent after
> commit 703db1f5da1e ("clk: qcom: rcg2: Cache CFG register updates for
> parked RCGs"). That's because the cached CFG register value needs to be
> populated when the clk is registered. clk_rcg2_shared_enable() writes
> the cached CFG register value 'parked_cfg'. This value is initially zero
> due to static initializers. If a driver calls clk_enable() before
> setting a rate or parent, it will set the parent to '0' which is
> (almost?) always XO, and may not reflect the parent at registration. In
> the worst case, this switches the RCG from sourcing a fast PLL to the
> slow crystal speed.
>
> The second problem is that the force enable bit isn't cleared. The force
> enable bit is only used during parking and unparking of shared RCGs.
> Otherwise it shouldn't be set because it keeps the RCG enabled even when
> all the branches on the output of the RCG are disabled (the hardware has
> a feedback mechanism so that any child branches keep the RCG enabled
> when the branch enable bit is set). This problem wastes power if the clk
> is unused, and is harmful in the case that the clk framework disables
> the parent of the force enabled RCG. In the latter case, the GDSC the
> shared RCG is associated with will get wedged if the RCG's source clk is
> disabled and the GDSC tries to enable the RCG to do "housekeeping" while
> powering on.
>
> Both of these problems combined with incorrect runtime PM usage in the
> display driver lead to a black screen on Qualcomm sc7180 Trogdor
> chromebooks. What happens is that the bootloader leaves the
> 'disp_cc_mdss_rot_clk' enabled and the 'disp_cc_mdss_rot_clk_src' force
> enabled and parented to 'disp_cc_pll0'. The mdss driver probes and
> runtime suspends, disabling the mdss_gdsc which uses the
> 'disp_cc_mdss_rot_clk_src' for "housekeeping". The
> 'disp_cc_mdss_rot_clk' is disabled during late init because the clk is
> unused, but the parent 'disp_cc_mdss_rot_clk_src' is still force enabled
> because the force enable bit was never cleared. Then 'disp_cc_pll0' is
> disabled because it is also unused. That's because the clk framework
> believes the parent of the RCG is XO when it isn't. A child device of
> the mdss device (e.g. DSI) runtime resumes mdss which powers on the
> mdss_gdsc. This wedges the GDSC because 'disp_cc_mdss_rot_clk_src' is
> parented to 'disp_cc_pll0' and that PLL is off. With the GDSC wedged,
> mdss_runtime_resume() tries to enable 'disp_cc_mdss_mdp_clk' but it
> can't because the GDSC has wedged all the clks associated with the GDSC
> causing clks to stay stuck off.
>
> This leads to the following warning seen at boot and a black screen
> because the display driver fails to probe.
>
>  disp_cc_mdss_mdp_clk status stuck at 'off'
>  WARNING: CPU: 1 PID: 81 at drivers/clk/qcom/clk-branch.c:87 clk_branch_toggle+0x114/0x168
>  Modules linked in:
>  CPU: 1 PID: 81 Comm: kworker/u16:4 Not tainted 6.7.0-g0dd3ee311255 #1 f5757d475795053fd2ad52247a070cd50dd046f2
>  Hardware name: Google Lazor (rev1 - 2) with LTE (DT)
>  Workqueue: events_unbound deferred_probe_work_func
>  pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : clk_branch_toggle+0x114/0x168
>  lr : clk_branch_toggle+0x110/0x168
>  sp : ffffffc08084b670
>  pmr_save: 00000060
>  x29: ffffffc08084b680 x28: ffffff808006de00 x27: 0000000000000001
>  x26: ffffff8080dbd4f4 x25: 0000000000000000 x24: 0000000000000000
>  x23: 0000000000000000 x22: ffffffd838461198 x21: ffffffd838007997
>  x20: ffffffd837541d5c x19: 0000000000000001 x18: 0000000000000004
>  x17: 0000000000000000 x16: 0000000000000010 x15: ffffffd837070fac
>  x14: 0000000000000003 x13: 0000000000000004 x12: 0000000000000001
>  x11: c0000000ffffdfff x10: ffffffd838347aa0 x9 : 08dadf92e516c000
>  x8 : 08dadf92e516c000 x7 : 0000000000000000 x6 : 0000000000000027
>  x5 : ffffffd8385a61f2 x4 : 0000000000000000 x3 : ffffffc08084b398
>  x2 : ffffffc08084b3a0 x1 : 00000000ffffdfff x0 : 00000000fffffff0
>  Call trace:
>   clk_branch_toggle+0x114/0x168
>   clk_branch2_enable+0x24/0x30
>   clk_core_enable+0x5c/0x1c8
>   clk_enable+0x38/0x58
>   clk_bulk_enable+0x40/0xb0
>   mdss_runtime_resume+0x68/0x258
>   pm_generic_runtime_resume+0x30/0x44
>   __genpd_runtime_resume+0x30/0x80
>   genpd_runtime_resume+0x124/0x214
>   __rpm_callback+0x7c/0x15c
>   rpm_callback+0x30/0x88
>   rpm_resume+0x390/0x4d8
>   rpm_resume+0x43c/0x4d8
>   __pm_runtime_resume+0x54/0x98
>   __device_attach+0xe0/0x170
>   device_initial_probe+0x1c/0x28
>   bus_probe_device+0x48/0xa4
>   device_add+0x52c/0x6fc
>   mipi_dsi_device_register_full+0x104/0x1a8
>   devm_mipi_dsi_device_register_full+0x28/0x78
>   ti_sn_bridge_probe+0x1dc/0x2bc
>   auxiliary_bus_probe+0x4c/0x94
>   really_probe+0xf8/0x270
>   __driver_probe_device+0xa8/0x130
>   driver_probe_device+0x44/0x104
>   __device_attach_driver+0xa4/0xcc
>   bus_for_each_drv+0x94/0xe8
>   __device_attach+0xf8/0x170
>   device_initial_probe+0x1c/0x28
>   bus_probe_device+0x48/0xa4
>   deferred_probe_work_func+0x9c/0xd8
>
> Fix these problems by parking shared RCGs at boot. This will properly
> initialize the parked_cfg struct member so that the parent is reported
> properly and ensure that the clk won't get stuck on or off because the
> RCG is parented to the safe source (XO).
>
> Fixes: 703db1f5da1e ("clk: qcom: rcg2: Cache CFG register updates for parked RCGs")
> Reported-by: Stephen Boyd <sboyd@kernel.org>
> Closes: https://lore.kernel.org/r/1290a5a0f7f584fcce722eeb2a1fd898.sboyd@kernel.org
> Closes: https://issuetracker.google.com/319956935
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Closes: https://lore.kernel.org/r/20231218091806.7155-1-laura.nao@collabora.com
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Applied to clk-next


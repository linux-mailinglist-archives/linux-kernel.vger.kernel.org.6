Return-Path: <linux-kernel+bounces-355170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B56994917
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0911C2253C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07251DEFE5;
	Tue,  8 Oct 2024 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQOVeAYX"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F81DED79;
	Tue,  8 Oct 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389971; cv=none; b=DG2qvl6QeuF7QfAzNWzjVj4BlsPALSeiBUBgIKzrTThYakO7hiXm9AjrlITYnxhgeUDCqayb5kVITalkjwuLKNpecH8qNxIMr6qUbkEvcg2GjjJjMs1Ap45gRpaa6PDlbwOuWI7VO8X2i54jshNSi58iEv8iDO9+cfiE2qpYuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389971; c=relaxed/simple;
	bh=Uw4dzTmVENShSMMqucDbgPz8pkSnOLY/jsoubkZkZ/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYsW6Qj8mAxD9ablaE9LbslmEmoJThHzy/IQA8CME1L/dAFCJ6NRUgkLeY/zu/cR+XCFymmh1eQ3yOTZ2xKI3ykR+cjlXra2E6zItHrmA4iLegchj7W/Zea36+M7rcq62Vo6bz3vwSvZFs6GE/Hszykv+/3QeG4wYXj9wNqyLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQOVeAYX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e29522f0f1so94616a91.0;
        Tue, 08 Oct 2024 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728389969; x=1728994769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQdTwVLISuxQ026dh7noBg5OAHYhExXify6BxUSEIb8=;
        b=iQOVeAYX/M2Nc2RJ8A6wR9fV+eQ3oZTkgfbBoRwsbXtgZfuajvVWrpZX3rJxMIgjnh
         9vu02aaee/+7CzBidSZfd7/TMeikNsoEQXetoUEn6SI/OsH0f+g8pwMGTc459hrMjwBS
         0ZZ6nuEEKGCyFWp2XrKEABezbhdxH+MPHIWnZXvVnsw/w6fW90cKfJlKXAe87On50whQ
         0O0qEBqu0eu94xZkgRhZakFYTZ8YewgWLMPqu2Jy3vowxBNkGAECF3E+LgvLg8LTjzsu
         i6jzGFnh82sCEZK3CcbnvPq0QeXnefd3ou3lFYWuRK/BSACjfPtIA5xwWS3zDCZQsQ5n
         WDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389969; x=1728994769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQdTwVLISuxQ026dh7noBg5OAHYhExXify6BxUSEIb8=;
        b=xF7USZK7/+E5aJ3X/yAMcTzVo8zSzYybbwz67iqJVnbJTcaVCU/x/9t1ZVS1DRqo/p
         8N1aq0VU9VmqodZXxJIVUibshvIery6fhXM4gX937aiXW/lczo/h+/nUX6BYjoEVg/eR
         LxmyNOLAiYkGXi08ZWLyp1mZLsL0gMNbqUNxMK76q6rYdNi7ETtWQW2j+wW/J/Nwp8Ao
         P/JNyi4/UpIygrQAZQ8uAY/CHghEAR3MZsYBssIXn9PLJ3gfSjkxLB+uSwlEls5cvuPA
         ScM4HAeso5UssONPUO63VTplmaWwhMkf/gnlhewwFeFGYfVjlzxgeZTeQxMIhD3VH1UU
         Xe+w==
X-Forwarded-Encrypted: i=1; AJvYcCW8CM1IZWgpuEqKy3T7xQ0aknw/R+cOYaSKX1S9+YlP1Josc5U4jcwlKhATRt9CgI6aFjaifAX3dKy88+s5@vger.kernel.org, AJvYcCXEIXhy8vrPePT2fIbOK5gM7+IXXOWXUBzul2FVgRjl4AY6CugdMelxyhjiheJVkEVDVk1QQ1jyfAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+xpd6L+h3vaG0rKeXnV86kjRS9ot1u6BpAKFu6eRtx9p/0/e
	AXsr8LQaxXpcetckaZe5x8qME667tnZm7+wBMInPzR8Hw+EIH5EAbvdDEvgVPxrl6LBmgyxmcWr
	CYe0E6SWHNSZdO6qvFOhciV68El4=
X-Google-Smtp-Source: AGHT+IGaascgSJ4sxny2mNYDiWLUEeHMIw4kXi/HuNGX5ddTIEdo3ya8zf1Aytc4EHlwRwMJMw1L6M1mlldErYSVDBw=
X-Received: by 2002:a17:90b:33cc:b0:2d8:53f8:77c0 with SMTP id
 98e67ed59e1d1-2e1e620dc45mr18482390a91.7.1728389968507; Tue, 08 Oct 2024
 05:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007132555.GA53279@francesco-nb> <PAXPR04MB84596824B2DFDF20E005F173887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB845980EE67F1B99C9AC9D0DF887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB845980EE67F1B99C9AC9D0DF887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 8 Oct 2024 07:19:15 -0500
Message-ID: <CAHCN7xLzYVBB=+EkD14xYqGJDR6BRUO7hxBZGOtvzCFLp_kXdg@mail.gmail.com>
Subject: Re: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on v6.12
To: Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, "S.J. Wang" <shengjiu.wang@nxp.com>, 
	"abelvesa@kernel.org" <abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, 
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, 
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Mark Brown <broonie@kernel.org>, 
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:51=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: RE: clk_imx8mp_audiomix_runtime_resume Kernel panic
> > regression on v6.12
> >
> > > Subject: clk_imx8mp_audiomix_runtime_resume Kernel panic
> > regression on
> > > v6.12
> > >
> > >
> > > Is it now back?
> >
> > With tag: next-20240930, I need see this issue on i.MX8MP-EVK board.
>
> Sorry, typo. I not see issue on my board.

I tested RC1 on the Beacon board and didn't see any issues, but I can
try testing linux-next when I have some time.

adam
>
> Regards,
> Peng.
>
> >
> > Regards,
> > Peng.
> >
> > >
> > > [    4.012850] SError Interrupt on CPU2, code 0x00000000bf000002 -
> > -
> > > SError
> > > [    4.012862] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not
> > tainted
> > > 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> > > [    4.012869] Hardware name: Toradex Verdin iMX8M Plus WB on
> > > Dahlia Board (DT)
> > > [    4.012872] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -
> > SSBS
> > > BTYPE=3D--)
> > > [    4.012877] pc :
> > clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> > > [    4.012891] lr : pm_generic_runtime_resume+0x2c/0x44
> > > [    4.012897] sp : ffff8000821cb740
> > > [    4.012899] x29: ffff8000821cb740 x28: ffff8000793c48d8 x27:
> > > ffff8000793c48c0
> > > [    4.012908] x26: ffff0000c0ec90f4 x25: 0000000000000000 x24:
> > > 0000000000000000
> > > [    4.012916] x23: 0000000000000000 x22: ffff0000c1bef180 x21:
> > > 0000000000000000
> > > [    4.012923] x20: ffff0000c0a73000 x19: ffff0000c0ecbc10 x18:
> > > ffffffffffffffff
> > > [    4.012930] x17: 3030303064623033 x16: 2f7375622e303030 x15:
> > > 756e285472656c6c
> > > [    4.012937] x14: ffff800081267458 x13: 6d692c6c73664361 x12:
> > > 0000000000000000
> > > [    4.012944] x11: 00353333333d4d55 x10: ffff8000818020ae x9 :
> > > 0000000000000008
> > > [    4.012951] x8 : 0000000000000008 x7 : 0000000000000000 x6 :
> > > ffff0000c5bf2080
> > > [    4.012958] x5 : ffff800081f10000 x4 : ffff800080c182e8 x3 :
> > > ffff0000c0ee7088
> > > [    4.012965] x2 : 0000000000000000 x1 : 0000000000000004 x0 :
> > > ffff800081f10300
> > > [    4.012973] Kernel panic - not syncing: Asynchronous SError
> > Interrupt
> > > [    4.012976] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not
> > tainted
> > > 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> > > [    4.012982] Hardware name: Toradex Verdin iMX8M Plus WB on
> > > Dahlia Board (DT)
> > > [    4.012985] Call trace:
> > > [    4.012988]  dump_backtrace+0xd0/0x120
> > > [    4.012998]  show_stack+0x18/0x24
> > > [    4.013005]  dump_stack_lvl+0x60/0x80
> > > [    4.013013]  dump_stack+0x18/0x24
> > > [    4.013019]  panic+0x168/0x350
> > > [    4.013025]  add_taint+0x0/0xbc
> > > [    4.013029]  arm64_serror_panic+0x64/0x70
> > > [    4.013034]  do_serror+0x3c/0x70
> > > [    4.013039]  el1h_64_error_handler+0x30/0x54
> > > [    4.013046]  el1h_64_error+0x64/0x68
> > > [    4.013050]  clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> > > [    4.013059]  __genpd_runtime_resume+0x30/0x80
> > > [    4.013066]  genpd_runtime_resume+0x114/0x29c
> > > [    4.013073]  __rpm_callback+0x48/0x1e0
> > > [    4.013079]  rpm_callback+0x68/0x80
> > > [    4.013084]  rpm_resume+0x3bc/0x6a0
> > > [    4.013089]  __pm_runtime_resume+0x50/0x9c
> > > [    4.013095]  pm_runtime_get_suppliers+0x60/0x8c
> > > [    4.013101]  __driver_probe_device+0x4c/0x14c
> > > [    4.013108]  driver_probe_device+0x3c/0x120
> > > [    4.013114]  __driver_attach+0xc4/0x200
> > > [    4.013119]  bus_for_each_dev+0x7c/0xe0
> > > [    4.013125]  driver_attach+0x24/0x30
> > > [    4.013130]  bus_add_driver+0x110/0x240
> > > [    4.013135]  driver_register+0x68/0x124
> > > [    4.013142]  __platform_driver_register+0x24/0x30
> > > [    4.013149]  sdma_driver_init+0x20/0x1000 [imx_sdma]
> > > [    4.013163]  do_one_initcall+0x60/0x1e0
> > > [    4.013168]  do_init_module+0x5c/0x21c
> > > [    4.013175]  load_module+0x1a98/0x205c
> > > [    4.013181]  init_module_from_file+0x88/0xd4
> > > [    4.013187]  __arm64_sys_finit_module+0x258/0x350
> > > [    4.013194]  invoke_syscall.constprop.0+0x50/0xe0
> > > [    4.013202]  do_el0_svc+0xa8/0xe0
> > > [    4.013208]  el0_svc+0x3c/0x140
> > > [    4.013215]  el0t_64_sync_handler+0x120/0x12c
> > > [    4.013222]  el0t_64_sync+0x190/0x194
> > > [    4.013228] SMP: stopping secondary CPUs
> > > [    4.013237] Kernel Offset: disabled
> > > [    4.013239] CPU features: 0x00,00000000,00200000,4200420b
> > > [    4.013243] Memory Limit: none
> > > [    4.316721] ---[ end Kernel panic - not syncing: Asynchronous SErr=
or
> > > Interrupt ]---
> > >
> > >
> > > Francesco
>


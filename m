Return-Path: <linux-kernel+bounces-363054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD099BD61
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4731F2123F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB0A17BD5;
	Mon, 14 Oct 2024 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR0u2wzK"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00B33C9;
	Mon, 14 Oct 2024 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869834; cv=none; b=rMK+xahOAivQthB9QSQbc3/N9D8Cqf5QUOpZEQEykxGnYMh49DXaLp3/aBGCRatPjKg05GdMDCJFKOgss4JkGd+1+LSQmaMTpUcAybT6ylev07IW040qlPl7fWplJFyugHJBkFHwTlNAE9rnjdgFXgdQ4KD4ASSzaxLak1EowwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869834; c=relaxed/simple;
	bh=uaYVtxQFcA1m+X3UEVbIcKzVIIUzx0cpCm0w65H4N/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/onWfaoup29yca5tUB7m65MaqOwjowHVx3zlUUolJehB9rBHEg0WlwqNG8q+TIAA/FNmosfgT6RcmMrxeVgou8ky2i3VRnYh9gXJHvi6QbYu2TorEiUPIrzsN14eIDjBH3DIdA2oFhUsL8r4gYjpmd0KGqQ6fZWJuYXCo0Gxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR0u2wzK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db54269325so3369596a12.2;
        Sun, 13 Oct 2024 18:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728869832; x=1729474632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OddeQUriMs/pngcQmPeii+lJ9EjgT3djJMTGA3J41c=;
        b=dR0u2wzKjOMpIhOhzgoO9JBqglHZX2spuyePAhoEV8DM6KqK5xzxpmr5J+x1HjlV6r
         cbFHiZvgojq5iFrIcYQsHGkXx4e0/nyt/2SQO7GktP+jhln9jFCvtivxyqASKtl8NK6c
         4GTtEGaSBqx4/XMMJT5KS5bPt1PmdANTqenNHH82e3s5NmT7Orc4xTn1hMBV5nFeo0uI
         JotoEa4z+sAQWbKKxvtEIlIdQNw6EGAORUqDgpaNs+/a2sN/o8v8xmdtmOCRwbB/VoPu
         4SKfTX7+nF4KlYWpxYEa79Ix59USr4qAO7vsFTECb2M9H+5azNpDRzwB4LIr4Uzo94ET
         6Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728869832; x=1729474632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OddeQUriMs/pngcQmPeii+lJ9EjgT3djJMTGA3J41c=;
        b=cGsyjieZL9C4e4MgDh5xb1PkT6DuSnUNFOnqY0Fangu8t0oVe+5R9szbEpTTeWNvT/
         PfRc7T5kJVNpdpdb+rnKcArLRRWCIqAS5ZFf0/7TQxa85udVQJ7VbBPHwv3O8EVBYY1m
         iYLqsuVjjX+C1k0diBA03u+A97xiMksmuTRh2GRvB//xhlVetoRGFx1ypXv2UL2XBsvR
         WfU2tFIVx1VW4zjOvD8oUd5sVlfJbk+XGGCLYry/emWg+g+c8lNmbpwQgygtJvy2Eh2T
         L5tz6v+9Q3nb1CpxeiK0okKL3/WtXzVg1ykJHIuuw2FWPiYwwjnnNnYhLJ7cPYixG5jY
         1YHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSe02o//xsp1YSPVFSDes26m9R+3Iot1DQKIyulqElG4gCq+LxV4ogyEJoTQQ9/6FyW6lmhgicFux9oUy7@vger.kernel.org, AJvYcCUz+rXFiwC2LISWEPPxW0YB1ctRTY4jG+N2PEBXzF92MQBSBkU6hC3bxtjTjZ4wc9VZgcMpS/7C8Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4S/WmWIUK2CSlXOy62Yl7HArQHAVQ6waxfW7ndfs+BkAMByBX
	CxIF5tLcyShsFqu0Tso99EiwceECoFsjsOtiDeEeo0REdSJ6LlHUgssbX2pDSF9it2Mm8hCfBEq
	GGF7sX2o7LK3q/7kayObZYpp9iQwNsA==
X-Google-Smtp-Source: AGHT+IEb+pfq2b2/iZWj2STWjPYUga1d5731DPFAc0MU2ISKAqOp/IWmSZuTUIxd4Gg/U4/YujfXxouayoZftRN3CIk=
X-Received: by 2002:a05:6a20:d501:b0:1d2:ea38:39bc with SMTP id
 adf61e73a8af0-1d8c9594e7dmr10212139637.11.1728869832160; Sun, 13 Oct 2024
 18:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007132555.GA53279@francesco-nb> <PAXPR04MB84596824B2DFDF20E005F173887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB845980EE67F1B99C9AC9D0DF887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAHCN7xLzYVBB=+EkD14xYqGJDR6BRUO7hxBZGOtvzCFLp_kXdg@mail.gmail.com> <84371A37-9C3D-44AF-8796-7427B39DC3D4@dolcini.it>
In-Reply-To: <84371A37-9C3D-44AF-8796-7427B39DC3D4@dolcini.it>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 13 Oct 2024 20:37:00 -0500
Message-ID: <CAHCN7xKmrAYad2Mc29cUvDovbP7Hhv0sOFaNtjpdVWZeET-egQ@mail.gmail.com>
Subject: Re: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on v6.12
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Peng Fan <peng.fan@nxp.com>, "S.J. Wang" <shengjiu.wang@nxp.com>, 
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

On Tue, Oct 8, 2024 at 7:24=E2=80=AFAM Francesco Dolcini <francesco@dolcini=
.it> wrote:
>
> Il 8 ottobre 2024 14:19:15 CEST, Adam Ford <aford173@gmail.com> ha scritt=
o:
> >On Tue, Oct 8, 2024 at 3:51=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote=
:
> >>
> >> > Subject: RE: clk_imx8mp_audiomix_runtime_resume Kernel panic
> >> > regression on v6.12
> >> >
> >> > > Subject: clk_imx8mp_audiomix_runtime_resume Kernel panic
> >> > regression on
> >> > > v6.12
> >> > >
> >> > >
> >> > > Is it now back?
> >> >
> >> > With tag: next-20240930, I need see this issue on i.MX8MP-EVK board.
> >>
> >> Sorry, typo. I not see issue on my board.
> >
> >I tested RC1 on the Beacon board and didn't see any issues, but I can
> >try testing linux-next when I have some time.
> >
>
> I forgot to mention that the issue is not systematic as it was in the ori=
ginal report.
>
> And it was reproduced on v6.12-rc2, not with -next.

I tested RC3, and I cannot replicate it.  Are you still having issues?


adam
>
> Francesco
>
>
> >adam
> >>
> >> Regards,
> >> Peng.
> >>
> >> >
> >> > Regards,
> >> > Peng.
> >> >
> >> > >
> >> > > [    4.012850] SError Interrupt on CPU2, code 0x00000000bf000002 -
> >> > -
> >> > > SError
> >> > > [    4.012862] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not
> >> > tainted
> >> > > 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> >> > > [    4.012869] Hardware name: Toradex Verdin iMX8M Plus WB on
> >> > > Dahlia Board (DT)
> >> > > [    4.012872] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -
> >> > SSBS
> >> > > BTYPE=3D--)
> >> > > [    4.012877] pc :
> >> > clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> >> > > [    4.012891] lr : pm_generic_runtime_resume+0x2c/0x44
> >> > > [    4.012897] sp : ffff8000821cb740
> >> > > [    4.012899] x29: ffff8000821cb740 x28: ffff8000793c48d8 x27:
> >> > > ffff8000793c48c0
> >> > > [    4.012908] x26: ffff0000c0ec90f4 x25: 0000000000000000 x24:
> >> > > 0000000000000000
> >> > > [    4.012916] x23: 0000000000000000 x22: ffff0000c1bef180 x21:
> >> > > 0000000000000000
> >> > > [    4.012923] x20: ffff0000c0a73000 x19: ffff0000c0ecbc10 x18:
> >> > > ffffffffffffffff
> >> > > [    4.012930] x17: 3030303064623033 x16: 2f7375622e303030 x15:
> >> > > 756e285472656c6c
> >> > > [    4.012937] x14: ffff800081267458 x13: 6d692c6c73664361 x12:
> >> > > 0000000000000000
> >> > > [    4.012944] x11: 00353333333d4d55 x10: ffff8000818020ae x9 :
> >> > > 0000000000000008
> >> > > [    4.012951] x8 : 0000000000000008 x7 : 0000000000000000 x6 :
> >> > > ffff0000c5bf2080
> >> > > [    4.012958] x5 : ffff800081f10000 x4 : ffff800080c182e8 x3 :
> >> > > ffff0000c0ee7088
> >> > > [    4.012965] x2 : 0000000000000000 x1 : 0000000000000004 x0 :
> >> > > ffff800081f10300
> >> > > [    4.012973] Kernel panic - not syncing: Asynchronous SError
> >> > Interrupt
> >> > > [    4.012976] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not
> >> > tainted
> >> > > 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> >> > > [    4.012982] Hardware name: Toradex Verdin iMX8M Plus WB on
> >> > > Dahlia Board (DT)
> >> > > [    4.012985] Call trace:
> >> > > [    4.012988]  dump_backtrace+0xd0/0x120
> >> > > [    4.012998]  show_stack+0x18/0x24
> >> > > [    4.013005]  dump_stack_lvl+0x60/0x80
> >> > > [    4.013013]  dump_stack+0x18/0x24
> >> > > [    4.013019]  panic+0x168/0x350
> >> > > [    4.013025]  add_taint+0x0/0xbc
> >> > > [    4.013029]  arm64_serror_panic+0x64/0x70
> >> > > [    4.013034]  do_serror+0x3c/0x70
> >> > > [    4.013039]  el1h_64_error_handler+0x30/0x54
> >> > > [    4.013046]  el1h_64_error+0x64/0x68
> >> > > [    4.013050]  clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> >> > > [    4.013059]  __genpd_runtime_resume+0x30/0x80
> >> > > [    4.013066]  genpd_runtime_resume+0x114/0x29c
> >> > > [    4.013073]  __rpm_callback+0x48/0x1e0
> >> > > [    4.013079]  rpm_callback+0x68/0x80
> >> > > [    4.013084]  rpm_resume+0x3bc/0x6a0
> >> > > [    4.013089]  __pm_runtime_resume+0x50/0x9c
> >> > > [    4.013095]  pm_runtime_get_suppliers+0x60/0x8c
> >> > > [    4.013101]  __driver_probe_device+0x4c/0x14c
> >> > > [    4.013108]  driver_probe_device+0x3c/0x120
> >> > > [    4.013114]  __driver_attach+0xc4/0x200
> >> > > [    4.013119]  bus_for_each_dev+0x7c/0xe0
> >> > > [    4.013125]  driver_attach+0x24/0x30
> >> > > [    4.013130]  bus_add_driver+0x110/0x240
> >> > > [    4.013135]  driver_register+0x68/0x124
> >> > > [    4.013142]  __platform_driver_register+0x24/0x30
> >> > > [    4.013149]  sdma_driver_init+0x20/0x1000 [imx_sdma]
> >> > > [    4.013163]  do_one_initcall+0x60/0x1e0
> >> > > [    4.013168]  do_init_module+0x5c/0x21c
> >> > > [    4.013175]  load_module+0x1a98/0x205c
> >> > > [    4.013181]  init_module_from_file+0x88/0xd4
> >> > > [    4.013187]  __arm64_sys_finit_module+0x258/0x350
> >> > > [    4.013194]  invoke_syscall.constprop.0+0x50/0xe0
> >> > > [    4.013202]  do_el0_svc+0xa8/0xe0
> >> > > [    4.013208]  el0_svc+0x3c/0x140
> >> > > [    4.013215]  el0t_64_sync_handler+0x120/0x12c
> >> > > [    4.013222]  el0t_64_sync+0x190/0x194
> >> > > [    4.013228] SMP: stopping secondary CPUs
> >> > > [    4.013237] Kernel Offset: disabled
> >> > > [    4.013239] CPU features: 0x00,00000000,00200000,4200420b
> >> > > [    4.013243] Memory Limit: none
> >> > > [    4.316721] ---[ end Kernel panic - not syncing: Asynchronous S=
Error
> >> > > Interrupt ]---
> >> > >
> >> > >
> >> > > Francesco
> >>
>
> Hello,


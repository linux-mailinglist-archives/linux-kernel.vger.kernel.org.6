Return-Path: <linux-kernel+bounces-288650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78814953CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1F41F21E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4041547C3;
	Thu, 15 Aug 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AOANX+xY"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2215380B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758988; cv=none; b=KV/aXWnUeWFXMCxDEgrB862OGXMGiGHimEaVVZSq0JduvhKHAQm8EIWGjUj5dyLDpCeOl6qAOHdoBa0q6g/z2ZFyNlWcR6AN3PjXG5ScWifPY48T/rtuPk1L36hv6zzlBOhdiY9wC4/iUI4X+iJCgPgLSMq5oMLSWaDe65woyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758988; c=relaxed/simple;
	bh=IgPKsVh3JtWk4AcJCxs5wVIE9DaPfv626k+/CXZ2pX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DctAHioIFPY3dhzj3KPOAKTBGFUpQ6E2xrzbgBuQx5cKR/Fsge/wnt3Wci8k08Fp5HPV/LoEw0iJJg4D4QHyoikzImQBSz6leL/jojDbszsPq7a7UGKSVotsqCjrHk83b7rVU6I6SrHcLXs1Nr6TcKrK2YToZfb7w/fZg5Eh9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=AOANX+xY; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a94aa5080so163215666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723758984; x=1724363784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAdfL8Zwf2SSUsMr74WKW/aZ3QoDz4/GWIUqVkzjEpc=;
        b=AOANX+xYX6uTCxor1mfjbTk4xRRu/33kNVqykZmnnY4HWq2UT/DtFF5k7+guIRUM7l
         auG97qWIUFIS4kc0Slxz1m0w9bHA8Ls9zdSovPwn+nlKzWlQ9E0tLypgkLOdP1IXjqiJ
         mWr3z4kuVKggctONAdEVei/iFJm3DriCge+qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758984; x=1724363784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAdfL8Zwf2SSUsMr74WKW/aZ3QoDz4/GWIUqVkzjEpc=;
        b=vn7mHSQbO/IdYW1hiJXXkDXhnSITclahwpCanHIjmjGRsiSYkJ0uEwsrJbteTs882N
         rJQa1RKblNod623AeKjsyxOlNNycOyeAR2DkJzzp+AeMWBST/ADmmFFyTlMzVkxN0qbr
         weE47tl3wE32PCmmK8wIg6E0XtlmO3r8QQ3hW1TYHXNO037f/ChSiuLSZsKz3/gLSkGV
         eMn9PicFVP8x0n/zWN7YresjJpCksAXoYfly7QvHFY/hTr6wZeBPaDOTtFtmEQwFff70
         p9/arukUcKfI6ba7LTzDNWX97b+OK8LQDG8TDvnxB6F1gN6nXMzbrsCubYKl6oKQDH8n
         h/Yg==
X-Gm-Message-State: AOJu0Yw13XZMIwGJotpzUVp/fvqsB0mgp8Qzd3ElpGo8i3hW4+ftAqG5
	DqCmD+09hxk+0kJOiDxYpGpXb6a+Sxakz64YNwzvIFCbQmv/KCKmLUcIhkQ3GXnmvJx4xl/Sauk
	QQrq2u6Na8Z8x79tSpktScj/xn2pHSEHM/PMyJcv0LsBHDsk7+gk=
X-Google-Smtp-Source: AGHT+IF4lAPCmVIRDzW8etOvgjsqCmiUTX4U/MC4phyOG3G/Qlwrok2tWvPPBKWTQQwaJoykyaBsPHM7LxdMk4NmhnA=
X-Received: by 2002:a17:907:f1c1:b0:a7a:b070:92d1 with SMTP id
 a640c23a62f3a-a83929f1235mr62150266b.46.1723758983581; Thu, 15 Aug 2024
 14:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOf5uw=r_eZs6d93bqposDfgcBvax+ZUC865g-H2BwC5g3Hdxw@mail.gmail.com>
 <PAXPR04MB84598DA8723E1F167435F81D88852@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOf5uwkJ9p=WywtsyhWk+x=7M_AodmAjg6mV2_-AeTjmJFUGAQ@mail.gmail.com> <CAOf5uwkG5oj-GXbwbe1MK2x9UnURtQHN6UrgQWTTiUxcA7h9WA@mail.gmail.com>
In-Reply-To: <CAOf5uwkG5oj-GXbwbe1MK2x9UnURtQHN6UrgQWTTiUxcA7h9WA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 15 Aug 2024 23:56:11 +0200
Message-ID: <CAOf5uwn5pTaZW7DY0DmcKrN1rJqhhDHOjdWyp8OHBET=ompUZA@mail.gmail.com>
Subject: cpufreq//voltage at boot (WAS Re: imx6q random crashing using 4 cpus)
To: Peng Fan <peng.fan@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng

I have more information now, apart from my board problems. Follow my commen=
ts

On Wed, Aug 14, 2024 at 6:19=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Peng
>
> I have a follow up
>
> On Mon, Aug 12, 2024 at 10:45=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Peng
> >
> > On Mon, Aug 12, 2024 at 10:33=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wr=
ote:
> > >
> > > Hi,
> > > > Subject: imx6q random crashing using 4 cpus
> > > >
> > > > Hi all
> > > >
> > > > I'm getting random crashes including segmentation fault of service =
if I
> > > > boot a custom imx6q design with all the cpus (nr_cpus=3D3 works). I=
 did
> > > > not find anyone that were raising this problem in the past but I wo=
uld
> > > > like to know if you get this in your experience. The revision silic=
on is
> > > > 1.6 for imx6q
> > > >
> > > > I have tested
> > > >
> > > > 6.10.3
> > >
> > > Upstream kernel?
> > >
> >
> > This is upstream kernel
> >
>
> I have increased the internal LDO of the imx6q. Seems that bypass mode
> is not possible to activate
> in mainline and more seems that reduce the lifetime of the device
> according to some application note.
> Anyway I move the voltage to bigger values and now core seems more
> stable. So those are the minor issues on mainline
>

If we start with uboot and we have boot target frequency, uboot set
only the core and soc
voltage value (anatop), this means that the pmic stays on boot
voltage. The cpufreq driver as
far as I understand if we boot on performance it does not change the
voltage of the regulator
so does not recalculate the pmic value according to frequency. If we
have an industrial
cpu where the max freq is 800Mhz, this means that pmic starts at 1375
mv (pfuze100( and not the
reg_arm + 125 mV as it should and then kernel anyway is not able to
fix it up unless you
change governor and then go back to performance. Now I don't know if
the problem sits
on the bootloader or kernel or just in both because the kernel must
anyway to not depend
on the bootloader. uboot implement anatop regulator but at the end the
pmic is not calcualte
according to booting frequency.

Michael

> 1) if we start with performance governor, the voltage are change are
> not applied to the core if the booting frequency is the same
> of the performance once. This means that if the bootloader set a
> voltage this can not be fixed by the kernel
> 2) bypass-mode of the regulator does not activate the anatop bypass mode
>
> Michael
>
>
>
> > > > 6.6
> > >
> >
> > 6.6-fslc but I have tested on 6.6 lts too, same instability
> >
> > > This is upstream kernel or NXP released 6.6 kernel?
> > >
> > > Does older version kernel works well?
> > >
> >
> > What revision do you suggest? I can test easily them all
> >
> > > >
> > > > I have tested to remove idle state, increase the voltage core etc.
> > >
> > > cpuidle.off=3D1 does not help, right?
> > >
> >
> > I have got rid of cpuidle init in mach-imx6q end tested cpuidle.off=3D1=
 too.
> >
> > > I could not recall clear about LDO, I remember there is LDO enabled
> > > and LDO disabled. Have you checked LDO?
> >
> > I can try to not use LDO from pmic and use the internal one
> >
> > >
> > > > Those cpus are industrial
> > > > grade and they can run up to 800Mhz
> > > >
> > > > All kernels look ok if I reduce the number of cpus. Some of the
> > > > backtrace for instance
> > > >
> > > > [  OK  ] Stopped target Preparation for Network.
> > > > [  134.671302] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > > > [  134.677247] rcu:     2-...0: (1 GPs behind) idle=3D3c74/1/0x4000=
0000
> > > > softirq=3D1197/1201 fqs=3D421
> > >
> > > CPU 2 seems stuck.
> >
> > I have seen but I don't have stuck with 3 cpus. I have seen the power s=
upply is
> > 0-1 group and 2-3 group. Is it possible that it's something connected
> > to power supply
> > or anything that makes the core unstable?
> >
> > >
> > > > [  134.685445] rcu:     (detected by 0, t=3D2106 jiffies, g=3D1449,=
 q=3D175
> > > > ncpus=3D4)
> > > > [  134.692158] Sending NMI from CPU 0 to CPUs 2:
> > > > [  144.696530] rcu: rcu_sched kthread starved for 995 jiffies! g144=
9
> > > > f0x0 RCU_GP_DOING_FQS(6) ->state=3D0x0 ->cpu=3D1
> > > > [  144.706543] rcu:     Unless rcu_sched kthread gets sufficient CP=
U
> > > > time, OOM is now expected behavior.
> > > > [  144.715506] rcu: RCU grace-period kthread stack dump:
> > > > [  144.720563] task:rcu_sched       state:I stack:0     pid:14
> > > > tgid:14    ppid:2      flags:0x00000000
> > > > [  144.729890] Call trace:
> > > > [  144.729902]  __schedule from schedule+0x24/0x90 [  144.737008]
> > > > schedule from schedule_timeout+0x88/0x100 [  144.742175]
> > > > schedule_timeout from rcu_gp_fqs_loop+0xec/0x4c4 [  144.747955]
> > > > rcu_gp_fqs_loop from rcu_gp_kthread+0xc4/0x154 [  144.753556]
> > > > rcu_gp_kthread from kthread+0xdc/0xfc [  144.758381]  kthread from
> > > > ret_from_fork+0x14/0x20 [  144.763108] Exception stack(0xf0875fb0
> > > > to 0xf0875ff8)
> > > > [  144.768172] 5fa0:                                     00000000
> > > > 00000000 00000000 00000000
> > > > [  144.776360] 5fc0: 00000000 00000000 00000000 00000000
> > > > 00000000
> > > > 00000000 00000000 00000000
> > > > [  144.784546] 5fe0: 00000000 00000000 00000000 00000000
> > > > 00000013 00000000 [  144.791169] rcu: Stack dump where RCU GP
> > > > kthread last ran:
> > > > [  144.796659] Sending NMI from CPU 0 to CPUs 1:
> > > > [  144.801027] NMI backtrace for cpu 1 skipped: idling at
> > > > default_idle_call+0x28/0x3c [  144.809643] sysrq: This sysrq operat=
ion
> > > > is disabled.
> > >
> > > Have you ever tried use jtag to see cpu status?
> > > cpu in idle loop?
> > > cpu runs in invalid address and hang?
> >
> > Need to check
> >
> > Michael
> >
> > >
> > > Regards,
> > > Peng.
> > >
> > > >
> > > > What I'm trying to figure out what could be the problem but I don't
> > > > have similar reference
> > > >
> > > > Michael
> > > >
> > > > --
> > > > Michael Nazzareno Trimarchi
> > > > Co-Founder & Chief Executive Officer
> > > > M. +39 347 913 2170
> > > > michael@amarulasolutions.com
> > > > __________________________________
> > > >
> > > > Amarula Solutions BV
> > > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172
> > > > info@amarulasolutions.com
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> > > > www.amarulasolutions.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.
> > > > com%7C0cfef2a8598047ed1e1808dcbaa62d0d%7C686ea1d3bc2b4c6f
> > > > a92cd99c5c301635%7C0%7C0%7C638590470075161250%7CUnknow
> > > > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > > > 6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D9wzW6km41s
> > > > pIH2J4DjAVZFtW%2FGjIDWeEB%2FJkL74477o%3D&reserved=3D0
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com


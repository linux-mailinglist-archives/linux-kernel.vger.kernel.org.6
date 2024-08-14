Return-Path: <linux-kernel+bounces-286849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A3951FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270E01C21660
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76821B8EA0;
	Wed, 14 Aug 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K4qP0Na/"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E51B9B38
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652372; cv=none; b=hNOcXepzSZwpMuiV0hB0XaQkQM5/i4ReOcg0FjnpKvU6fs5sLwWhfQTt2jDWfRSUok3meZvd5Um5fwnLwNSxs4/SSsR6D8N7TXAhAXlKrUoqvweYgWhx2IZUu51wZW4vnt8eQAZNMdtP71ghbqEq1Qe0EBhtu0MkG2ZiQ2ReNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652372; c=relaxed/simple;
	bh=qO9mQiKrw42PacsolHXif6CBO3sM847wIsqfbawWS1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkWAn/NlXaJmv5Ox7dIKzDE5h7Y3GOE9ebimYOMxfLbs3FlZOmYeaIIl+1NPOxtWQMuQqEyAKqtS1+LHPTjgpyKcPv1yODKNUTwFqj2Hr9j9aI59uZZUorIiYVlmMoW1tcfw8uO7ZfkFblaZVRMAz6WDaYWvaeUfuEjrHvxQ4fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=K4qP0Na/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso892111fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723652369; x=1724257169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9bYe08zohvlv3Ag7Tr+1bJAOCHzj1BmY8rJcktOJCE=;
        b=K4qP0Na/4RlF6WASsFiES0EFI+RfeqYHfUuvdkVqvygSGYWdCbFBcujjnSqmxy8VZi
         ejqDz1dFT5hoEteY+hsga2J790JT5elL+PPK7v6VximoCt26Kc6i0wFybQt8WHfR4pWw
         pDPMf26nfoOjh00eGu4GUOwZmDOELq0mjr0bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652369; x=1724257169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9bYe08zohvlv3Ag7Tr+1bJAOCHzj1BmY8rJcktOJCE=;
        b=hXl3ccQq7sxi2AcfU9i+Er8IoIhzjkSZ4zfniW8I2OXuD2Z9o1FfrRXYgY50xQK3VG
         vA3JBz/N2szBXxnszUvW9drp5oyigKNLTTZq3svBgcK3EL+8HO7pMh7xKW94AkOtMwlZ
         dlTqftqpfRq9K5QpAMiVgjpw1XO6kN24glHjpMh/NEzrSSwjFB+Mec+sSP00wuzzK8hx
         YsJSeodQLjOvn+5S1Bk9Owp2d6QSVuDfoKBrbmZc2LWx/Kb3dWIBJxhCpcJOrBtHmSQe
         JAuxFbrT/3Q8nT6I7rlx8RXTPj0IVsEnEZDPkjhugIuHug7anhCfA1qhPUjtXMHe0jlq
         zl3g==
X-Gm-Message-State: AOJu0YymawmTqeXgf1z9g7Ax5Mu9IF1ux6TD2wFpLQNrQ60S9f1sf6Jz
	IJ5tL8hzLXU5LqDc9IjdlPW+iCXBeU87/w5OXvVR8AGbpvLJ58h2MB8qp4qf/kJdkbDX3ZoFI4m
	uJM+j+TrTITARWNiXe34oLwwHtCkNOxy35wxRbg==
X-Google-Smtp-Source: AGHT+IEvAXwfmpRhWzsV5otc7NbqOxVZF44J6FM4SSPY5YwhjLeFPJfVjPDpmiR1eV8cR1xsPT5GJG1MIYZq3d6ufLg=
X-Received: by 2002:a2e:9d8e:0:b0:2f0:27da:6864 with SMTP id
 38308e7fff4ca-2f3aa1e5e96mr26632541fa.17.1723652368420; Wed, 14 Aug 2024
 09:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOf5uw=r_eZs6d93bqposDfgcBvax+ZUC865g-H2BwC5g3Hdxw@mail.gmail.com>
 <PAXPR04MB84598DA8723E1F167435F81D88852@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOf5uwkJ9p=WywtsyhWk+x=7M_AodmAjg6mV2_-AeTjmJFUGAQ@mail.gmail.com>
In-Reply-To: <CAOf5uwkJ9p=WywtsyhWk+x=7M_AodmAjg6mV2_-AeTjmJFUGAQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 14 Aug 2024 18:19:17 +0200
Message-ID: <CAOf5uwkG5oj-GXbwbe1MK2x9UnURtQHN6UrgQWTTiUxcA7h9WA@mail.gmail.com>
Subject: Re: imx6q random crashing using 4 cpus
To: Peng Fan <peng.fan@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng

I have a follow up

On Mon, Aug 12, 2024 at 10:45=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Peng
>
> On Mon, Aug 12, 2024 at 10:33=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrot=
e:
> >
> > Hi,
> > > Subject: imx6q random crashing using 4 cpus
> > >
> > > Hi all
> > >
> > > I'm getting random crashes including segmentation fault of service if=
 I
> > > boot a custom imx6q design with all the cpus (nr_cpus=3D3 works). I d=
id
> > > not find anyone that were raising this problem in the past but I woul=
d
> > > like to know if you get this in your experience. The revision silicon=
 is
> > > 1.6 for imx6q
> > >
> > > I have tested
> > >
> > > 6.10.3
> >
> > Upstream kernel?
> >
>
> This is upstream kernel
>

I have increased the internal LDO of the imx6q. Seems that bypass mode
is not possible to activate
in mainline and more seems that reduce the lifetime of the device
according to some application note.
Anyway I move the voltage to bigger values and now core seems more
stable. So those are the minor issues on mainline

1) if we start with performance governor, the voltage are change are
not applied to the core if the booting frequency is the same
of the performance once. This means that if the bootloader set a
voltage this can not be fixed by the kernel
2) bypass-mode of the regulator does not activate the anatop bypass mode

Michael



> > > 6.6
> >
>
> 6.6-fslc but I have tested on 6.6 lts too, same instability
>
> > This is upstream kernel or NXP released 6.6 kernel?
> >
> > Does older version kernel works well?
> >
>
> What revision do you suggest? I can test easily them all
>
> > >
> > > I have tested to remove idle state, increase the voltage core etc.
> >
> > cpuidle.off=3D1 does not help, right?
> >
>
> I have got rid of cpuidle init in mach-imx6q end tested cpuidle.off=3D1 t=
oo.
>
> > I could not recall clear about LDO, I remember there is LDO enabled
> > and LDO disabled. Have you checked LDO?
>
> I can try to not use LDO from pmic and use the internal one
>
> >
> > > Those cpus are industrial
> > > grade and they can run up to 800Mhz
> > >
> > > All kernels look ok if I reduce the number of cpus. Some of the
> > > backtrace for instance
> > >
> > > [  OK  ] Stopped target Preparation for Network.
> > > [  134.671302] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > > [  134.677247] rcu:     2-...0: (1 GPs behind) idle=3D3c74/1/0x400000=
00
> > > softirq=3D1197/1201 fqs=3D421
> >
> > CPU 2 seems stuck.
>
> I have seen but I don't have stuck with 3 cpus. I have seen the power sup=
ply is
> 0-1 group and 2-3 group. Is it possible that it's something connected
> to power supply
> or anything that makes the core unstable?
>
> >
> > > [  134.685445] rcu:     (detected by 0, t=3D2106 jiffies, g=3D1449, q=
=3D175
> > > ncpus=3D4)
> > > [  134.692158] Sending NMI from CPU 0 to CPUs 2:
> > > [  144.696530] rcu: rcu_sched kthread starved for 995 jiffies! g1449
> > > f0x0 RCU_GP_DOING_FQS(6) ->state=3D0x0 ->cpu=3D1
> > > [  144.706543] rcu:     Unless rcu_sched kthread gets sufficient CPU
> > > time, OOM is now expected behavior.
> > > [  144.715506] rcu: RCU grace-period kthread stack dump:
> > > [  144.720563] task:rcu_sched       state:I stack:0     pid:14
> > > tgid:14    ppid:2      flags:0x00000000
> > > [  144.729890] Call trace:
> > > [  144.729902]  __schedule from schedule+0x24/0x90 [  144.737008]
> > > schedule from schedule_timeout+0x88/0x100 [  144.742175]
> > > schedule_timeout from rcu_gp_fqs_loop+0xec/0x4c4 [  144.747955]
> > > rcu_gp_fqs_loop from rcu_gp_kthread+0xc4/0x154 [  144.753556]
> > > rcu_gp_kthread from kthread+0xdc/0xfc [  144.758381]  kthread from
> > > ret_from_fork+0x14/0x20 [  144.763108] Exception stack(0xf0875fb0
> > > to 0xf0875ff8)
> > > [  144.768172] 5fa0:                                     00000000
> > > 00000000 00000000 00000000
> > > [  144.776360] 5fc0: 00000000 00000000 00000000 00000000
> > > 00000000
> > > 00000000 00000000 00000000
> > > [  144.784546] 5fe0: 00000000 00000000 00000000 00000000
> > > 00000013 00000000 [  144.791169] rcu: Stack dump where RCU GP
> > > kthread last ran:
> > > [  144.796659] Sending NMI from CPU 0 to CPUs 1:
> > > [  144.801027] NMI backtrace for cpu 1 skipped: idling at
> > > default_idle_call+0x28/0x3c [  144.809643] sysrq: This sysrq operatio=
n
> > > is disabled.
> >
> > Have you ever tried use jtag to see cpu status?
> > cpu in idle loop?
> > cpu runs in invalid address and hang?
>
> Need to check
>
> Michael
>
> >
> > Regards,
> > Peng.
> >
> > >
> > > What I'm trying to figure out what could be the problem but I don't
> > > have similar reference
> > >
> > > Michael
> > >
> > > --
> > > Michael Nazzareno Trimarchi
> > > Co-Founder & Chief Executive Officer
> > > M. +39 347 913 2170
> > > michael@amarulasolutions.com
> > > __________________________________
> > >
> > > Amarula Solutions BV
> > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172
> > > info@amarulasolutions.com
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> > > www.amarulasolutions.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.
> > > com%7C0cfef2a8598047ed1e1808dcbaa62d0d%7C686ea1d3bc2b4c6f
> > > a92cd99c5c301635%7C0%7C0%7C638590470075161250%7CUnknow
> > > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > > 6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D9wzW6km41s
> > > pIH2J4DjAVZFtW%2FGjIDWeEB%2FJkL74477o%3D&reserved=3D0
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


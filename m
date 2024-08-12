Return-Path: <linux-kernel+bounces-282803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A194E8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90E71F22A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8115572D;
	Mon, 12 Aug 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M7ddMvQQ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A23A55
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452320; cv=none; b=C2fJPcXKEvMXR+4LUftw4R0VttLDlZgp7IB/KOAO6gtX6qSNq6P2MGK+SDkyAYtNYMKzQ1m0lxo3SVTJxnOUOysvjzI3BSgmMwgurUsqaWFnw1IEd1NHYz6Qehz+dkmBgcxXmrfImbFSs8dE2xd4GR4zZ80K56xSn5dy8G2UU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452320; c=relaxed/simple;
	bh=yykJAas42+OuAGT3NIKTODOKAOa3giu58f70iws0de0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGhoFRwgTfvq6FHjkfl+0oNY2VAYGn5k+/4+lSqD7LSIugmGvmjGU9uY9NTypAHsnEbkOY0cmV4sFs3MFshUNsB6n031vm+BLNUgtTPJVgY1iG01+soN8KfxC9o1PiMis5SdXAjDKA2SQx0F9GvqT2WJhnEhSgXv0qJcEmMXCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=M7ddMvQQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so507399366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723452317; x=1724057117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lDQF0iMIvX0PF0vu+axHZ+zSRtVRPwWy7YNZTzaR8Y=;
        b=M7ddMvQQ4fx+aY57vxMK19sWBF34Y4yjI+EOyd82E0j8MS5uusctfFu7TUf7NpO3En
         AVVgRgzKHW8Q3uR+SRjIh4cS28ptRDEOmCy/VT4bz8WHgWr5XkFfFc07jrXwk2H7DIB9
         EYOefdhN2rBsm1XHafrKhnNXUK+j+azg/DSF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452317; x=1724057117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lDQF0iMIvX0PF0vu+axHZ+zSRtVRPwWy7YNZTzaR8Y=;
        b=LwSGNRV+CmXgQJdqrC0muAd98GaKC+k2lWscUUA+H2OKb1KwND8Hy3IqM0BkVllyCd
         Cf74Y3DtYiQ4/2XzmICdhuUJYE2c8F+F3vqXtMzNAnyOPPeXkOriVAXVvgclxcKm/zFz
         hL5te0sADbh82RLOQEl6xvK0v0FwfxtbEgjUDiicM/y7PPLZJJrvdlftrWH9Lo3kv/Zh
         70C3nFKQV531QKCsvRPMsYQxcCAtNfKtx85XVuiN4rPq1herFp/PBdOLMOa6YJGyiNMf
         7yjjWw14LP5G42YyRJrzh7lPoR3IWTKBVCsPrOJBHs6i5yPKLHah/TxgEEgjpOIpQoGX
         jvBA==
X-Gm-Message-State: AOJu0YxzRu+pEtfQ/vdnyDCwD6ap+dpyFMvKbriV9TNPeA6ap4lJmTnr
	Ud0GT3hwMj7HABmBGvQmdQTXIha6duJklkK3xeQY+jEV6kAIZy+Ijs7eHlO/RWUaVpPc3TZWd3v
	neo80LFG+PTcIyU6R2P/vNuyOUUDYm9Bf9K33Hg==
X-Google-Smtp-Source: AGHT+IGa61KNtvaMggapEttSOU3Kl9WNw9J8xJxHyLwaQ2DIAUux4voEuXqZRvMFTSgYdrc51+KH/x/ijAdvaWIuhy0=
X-Received: by 2002:a17:907:d85a:b0:a7d:a031:7bb8 with SMTP id
 a640c23a62f3a-a80aa596a09mr650461666b.20.1723452316306; Mon, 12 Aug 2024
 01:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOf5uw=r_eZs6d93bqposDfgcBvax+ZUC865g-H2BwC5g3Hdxw@mail.gmail.com>
 <PAXPR04MB84598DA8723E1F167435F81D88852@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84598DA8723E1F167435F81D88852@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 12 Aug 2024 10:45:05 +0200
Message-ID: <CAOf5uwkJ9p=WywtsyhWk+x=7M_AodmAjg6mV2_-AeTjmJFUGAQ@mail.gmail.com>
Subject: Re: imx6q random crashing using 4 cpus
To: Peng Fan <peng.fan@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng

On Mon, Aug 12, 2024 at 10:33=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi,
> > Subject: imx6q random crashing using 4 cpus
> >
> > Hi all
> >
> > I'm getting random crashes including segmentation fault of service if I
> > boot a custom imx6q design with all the cpus (nr_cpus=3D3 works). I did
> > not find anyone that were raising this problem in the past but I would
> > like to know if you get this in your experience. The revision silicon i=
s
> > 1.6 for imx6q
> >
> > I have tested
> >
> > 6.10.3
>
> Upstream kernel?
>

This is upstream kernel

> > 6.6
>

6.6-fslc but I have tested on 6.6 lts too, same instability

> This is upstream kernel or NXP released 6.6 kernel?
>
> Does older version kernel works well?
>

What revision do you suggest? I can test easily them all

> >
> > I have tested to remove idle state, increase the voltage core etc.
>
> cpuidle.off=3D1 does not help, right?
>

I have got rid of cpuidle init in mach-imx6q end tested cpuidle.off=3D1 too=
.

> I could not recall clear about LDO, I remember there is LDO enabled
> and LDO disabled. Have you checked LDO?

I can try to not use LDO from pmic and use the internal one

>
> > Those cpus are industrial
> > grade and they can run up to 800Mhz
> >
> > All kernels look ok if I reduce the number of cpus. Some of the
> > backtrace for instance
> >
> > [  OK  ] Stopped target Preparation for Network.
> > [  134.671302] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > [  134.677247] rcu:     2-...0: (1 GPs behind) idle=3D3c74/1/0x40000000
> > softirq=3D1197/1201 fqs=3D421
>
> CPU 2 seems stuck.

I have seen but I don't have stuck with 3 cpus. I have seen the power suppl=
y is
0-1 group and 2-3 group. Is it possible that it's something connected
to power supply
or anything that makes the core unstable?

>
> > [  134.685445] rcu:     (detected by 0, t=3D2106 jiffies, g=3D1449, q=
=3D175
> > ncpus=3D4)
> > [  134.692158] Sending NMI from CPU 0 to CPUs 2:
> > [  144.696530] rcu: rcu_sched kthread starved for 995 jiffies! g1449
> > f0x0 RCU_GP_DOING_FQS(6) ->state=3D0x0 ->cpu=3D1
> > [  144.706543] rcu:     Unless rcu_sched kthread gets sufficient CPU
> > time, OOM is now expected behavior.
> > [  144.715506] rcu: RCU grace-period kthread stack dump:
> > [  144.720563] task:rcu_sched       state:I stack:0     pid:14
> > tgid:14    ppid:2      flags:0x00000000
> > [  144.729890] Call trace:
> > [  144.729902]  __schedule from schedule+0x24/0x90 [  144.737008]
> > schedule from schedule_timeout+0x88/0x100 [  144.742175]
> > schedule_timeout from rcu_gp_fqs_loop+0xec/0x4c4 [  144.747955]
> > rcu_gp_fqs_loop from rcu_gp_kthread+0xc4/0x154 [  144.753556]
> > rcu_gp_kthread from kthread+0xdc/0xfc [  144.758381]  kthread from
> > ret_from_fork+0x14/0x20 [  144.763108] Exception stack(0xf0875fb0
> > to 0xf0875ff8)
> > [  144.768172] 5fa0:                                     00000000
> > 00000000 00000000 00000000
> > [  144.776360] 5fc0: 00000000 00000000 00000000 00000000
> > 00000000
> > 00000000 00000000 00000000
> > [  144.784546] 5fe0: 00000000 00000000 00000000 00000000
> > 00000013 00000000 [  144.791169] rcu: Stack dump where RCU GP
> > kthread last ran:
> > [  144.796659] Sending NMI from CPU 0 to CPUs 1:
> > [  144.801027] NMI backtrace for cpu 1 skipped: idling at
> > default_idle_call+0x28/0x3c [  144.809643] sysrq: This sysrq operation
> > is disabled.
>
> Have you ever tried use jtag to see cpu status?
> cpu in idle loop?
> cpu runs in invalid address and hang?

Need to check

Michael

>
> Regards,
> Peng.
>
> >
> > What I'm trying to figure out what could be the problem but I don't
> > have similar reference
> >
> > Michael
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> > www.amarulasolutions.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.
> > com%7C0cfef2a8598047ed1e1808dcbaa62d0d%7C686ea1d3bc2b4c6f
> > a92cd99c5c301635%7C0%7C0%7C638590470075161250%7CUnknow
> > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D9wzW6km41s
> > pIH2J4DjAVZFtW%2FGjIDWeEB%2FJkL74477o%3D&reserved=3D0



--
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


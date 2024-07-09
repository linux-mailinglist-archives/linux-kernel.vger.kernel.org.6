Return-Path: <linux-kernel+bounces-246713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE092C5A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEA28396E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1C18562E;
	Tue,  9 Jul 2024 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="TYSl66hW"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20B185606
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561433; cv=none; b=q4097ik5xS4jpUs9rGE1Moz+0BRy231fFl0VW3nxq4eWGEq7EHTTMENqCcRsCjKl7PaRt6U756KWnnCnlKoiA3yWnzgeYQe+/pnfAYHdSNSPh7+nGIceRanEA54eKravIY3lpm/cfAPiKFUvleRzwIG3zwQIGWzybUWsuieagKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561433; c=relaxed/simple;
	bh=6ULYN40JM8MFFmy/0XJYLMk/LpUlIpN70B7hLlkakaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIaHGXOw67haM6EmFhSkFjeELzZV8W64mDzHYlQGtD3QOY3b22Ey6/dEHilbLMiEiUHPPB3DhqVJkFgEL0jTbdknj9Jcf+Om+Rt0CM3T4GzRM+sOpSbVaPGSH6pFQxpFDOhjwlCm9c7zpv6ckpe3/BfcBx1PVwWX+PJnnF226lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=TYSl66hW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e9f863c46so6076118e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1720561429; x=1721166229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9KDmmsWhRFdstXTLMKyGmo701itOW7xttxQmh/Uk4w=;
        b=TYSl66hWPJmKcwOVFrvaErYmO1Q53H/ER39oEKKhA4nU+0815dcNtAXNCAVdCNiDeH
         08OGQCxlDoOXx2r0lQScWAZabvr8JD550YuCq99N5m49XHylk8iBKjVTaJqslHPfHIe8
         UOHDsoTJvYBW7D4XAuMTQ2iBMl/Qoowcnrlzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720561429; x=1721166229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9KDmmsWhRFdstXTLMKyGmo701itOW7xttxQmh/Uk4w=;
        b=SwoZCrzvSLSxYVvAUCwj7r/0BlJY+uzeUpk2X0J+yyUWhD9ObtKhMRlKUcRCOFv/MQ
         OlNiF224mw5oZ1+cSe2Fg6wSoFfmhQBAe3r8HgtU+oVPxbxgQhsWb60Y637ShMtc+cPT
         B9BitKW4Qq91F5nu81CWx7VedabPnzRjsjt9p2VbmP6I2QLSMr+bu5aViZ5EWney3fn4
         S9uz6mkE9RxNfn5F/zuvXJwHGco8ZtFH9VWrzrKfvSMRh2fNNW0nChcAS7nY3Eh557v5
         X7yqesHdkphT8zx1GvY0jNFiEJHDMS1Ze1E41ebUFCyY+QFsKIt2urQgR2rmKSxje1iC
         vomg==
X-Forwarded-Encrypted: i=1; AJvYcCVdIH/bARg6Yo+hUkLOenk1QWHYKEi9JK5PLmywOUNulT/qb1lRtzRQKn0caW+mT8ZNHTxYnhaMI85++AG1ojCExf1E6FKDYi1XtgrA
X-Gm-Message-State: AOJu0Ywk3/Wq892OCaJcA7/A+zJdfmXMKIs/QfWTEcS4IVkktxqCLYBt
	9y19W60bju0lhqvJTSZgAg4HS36yB/Oqwd16GhCJO6fZPhIUDwQxBBWRbL5vYTJBACcoiVzq7CE
	B95Rbxb6INbQxHBI9xBponndqGJSHPZW993Nn
X-Google-Smtp-Source: AGHT+IEdSu2Z8+Igotjd337CZpmBMypgM+FA2pSw0xGsQbhyzXqlnF45xvhplFvdJXGPyLzA6YQDGuV6Dtl3aFywxhQ=
X-Received: by 2002:a05:6512:a8d:b0:52e:74d5:4bf9 with SMTP id
 2adb3069b0e04-52eb99d15a4mr2148639e87.54.1720561428757; Tue, 09 Jul 2024
 14:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708121224.1148154-1-xiao.w.wang@intel.com>
 <20240708-wildcard-denim-12de7fae795b@spud> <Zo2dtuv0quQ7FwtK@ghost>
 <20240709-unengaged-handgrip-56a5c7b3e1d1@spud> <Zo2kSxsJkdkBdBEW@ghost> <20240709-fame-uptown-c936014cd66a@spud>
In-Reply-To: <20240709-fame-uptown-c936014cd66a@spud>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 9 Jul 2024 14:43:37 -0700
Message-ID: <CAOnJCULo2gwLYCPdMppwhZekbuLh7FydjO7T1ZvJ0C8VG559YQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant macro check
To: Conor Dooley <conor@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, anup@brainfault.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 2:05=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Tue, Jul 09, 2024 at 01:57:47PM -0700, Charlie Jenkins wrote:
> > On Tue, Jul 09, 2024 at 09:44:17PM +0100, Conor Dooley wrote:
> > > On Tue, Jul 09, 2024 at 01:29:42PM -0700, Charlie Jenkins wrote:
> > > > On Mon, Jul 08, 2024 at 01:22:11PM +0100, Conor Dooley wrote:
> > > > > On Mon, Jul 08, 2024 at 08:12:24PM +0800, Xiao Wang wrote:
> > > > > > The macro CONFIG_RISCV_PMU must have been defined when riscv_pm=
u.c gets
> > > > > > compiled, so this patch removes the redundant check.
> > > > >
> > > > > Did you investigate why this define was added? Why do you think t=
hat it
> > > > > is redundant, rather than checking the incorrect config option?
> > > >
> > > > This file is only compiled with CONFIG_RISCV_PMU:
> > >
> > > I might be ill, but I can still read. I was not disagreeing with Xiao
> > > that the condition is redundant as written - I want to know whether t=
hey
> > > made sure that this check was intentionally using CONFIG_RISCV_PMU in=
 the
> > > first place, or if another option should have been here instead.
> >
> > Makes sense! Looking through the lists I see this RFC from Atish where
> > he introduced a different config option for this
> > "CONFIG_RISCV_PMU_COMMON"[1]. I wonder if something got confused in the
> > development of these two patches.
>

Nope. That's not related as the above series is a complete revamp of
PMU infrastructure
and far from being merged.

> Perhaps.. What I was worried about was the wrong option being here
> (maybe that it should have been RISCV_PMU_SBI or similar) and depending
> on how the kernel is configured, userspace would get the wrong info
> here. But maybe it is innocuous your theory would suggest, and there's
> nothing to worry about. But that's for someone with a functioning brain
> to figure out ;)
>
This macro has been there since v3 of the original series.
https://lore.kernel.org/lkml/20230802080328.1213905-8-alexghiti@rivosinc.co=
m/

Ideally, this should have been RISCV_PMU_SBI as ctr_get_width was not
defined earlier for legacy.
However, that was fixed here
https://lore.kernel.org/lkml/20240227170002.188671-3-vadim.shakirov@syntaco=
re.com/

So we can remove the macro check here.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

> Cheers,
> Conor.
>
> >
> > Link:
> > https://lore.kernel.org/lkml/20240217005738.3744121-12-atishp@rivosinc.=
com/
> > [1]
> >
> > > > # drivers/perf/Makefile
> > > > obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
> > > >
> > > > So having this check does seem redundant. I am copying Alex as it l=
ooks
> > > > like he wrote this.
> > > >
> > > > > >
> > > > > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > > > > ---
> > > > > >  drivers/perf/riscv_pmu.c | 2 --
> > > > > >  1 file changed, 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.=
c
> > > > > > index 0a02e85a8951..7644147d50b4 100644
> > > > > > --- a/drivers/perf/riscv_pmu.c
> > > > > > +++ b/drivers/perf/riscv_pmu.c
> > > > > > @@ -39,7 +39,6 @@ void arch_perf_update_userpage(struct perf_ev=
ent *event,
> > > > > >       userpg->cap_user_time_short =3D 0;
> > > > > >       userpg->cap_user_rdpmc =3D riscv_perf_user_access(event);
> > > > > >
> > > > > > -#ifdef CONFIG_RISCV_PMU
> > > > > >       /*
> > > > > >        * The counters are 64-bit but the priv spec doesn't mand=
ate all the
> > > > > >        * bits to be implemented: that's why, counter width can =
vary based on
> > > > > > @@ -47,7 +46,6 @@ void arch_perf_update_userpage(struct perf_ev=
ent *event,
> > > > > >        */
> > > > > >       if (userpg->cap_user_rdpmc)
> > > > > >               userpg->pmc_width =3D to_riscv_pmu(event->pmu)->c=
tr_get_width(event->hw.idx) + 1;
> > > > > > -#endif
> > > > > >
> > > > > >       do {
> > > > > >               rd =3D sched_clock_read_begin(&seq);
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > > >
> > > > > > _______________________________________________
> > > > > > linux-riscv mailing list
> > > > > > linux-riscv@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >
> >
> >



--=20
Regards,
Atish


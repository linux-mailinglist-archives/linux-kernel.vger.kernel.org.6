Return-Path: <linux-kernel+bounces-180615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C858C70D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885711C212DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29444A2C;
	Thu, 16 May 2024 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i7pafl0W"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26824688
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715832605; cv=none; b=qHETYHwMnPISUv9SRVgZgjZY8nXqZj4t3NA2QtPgrwCAdXjJH3xEPRC50Zuhfwmc7u7X6Jt7Ofaok6AbJBRJ8bhWfrRtN5UZpAoLWnBW+FomhuffzbqrVU3Aq1C/ooxpdsbP1WbKF1mA7VP5d4O7p4u+R2B5Obvmgd9xCbmO8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715832605; c=relaxed/simple;
	bh=c1j0wXz3522Y57qEplsyQOhz+FYX8Kznq+LiDDoyDnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iq91qpFb8x55/jhnJh5cC1EJ3FInFPgODxZqr62F2tfEfJwgivutzlrhlTjpz5z2ftN8f9tEDa/COwq06rX46QOmoQ8B9+Jp8UN8BF9YXtxAH8rDXUp13yzRfHxaLZeDzwbgvOFZwnNiYtxwga84mXRjzkg9GRKZNxUR0eapx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=i7pafl0W; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2451da9b4feso145691fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715832603; x=1716437403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFrog2h5nAkzpq5WoUadeeUmrdg//eB0XW+3OoY88O0=;
        b=i7pafl0WO2AxPLdD0GRqa0HmJx2uhXkS58pCsBy3LG3uSTQnurntnyGxrR9kBIxMe7
         McqzdkvMTgNCjjXpuNxR96nZf8kYAeWi/5TUvaFHsXdr6WczIE/jWHYSO/r5qpcDCLDt
         WarxKCJKE8LR0LTuydy9xt5XspOe/owzIHqEg5HKcxbn9NPYuKKaTU1MIkwcAxvLRHOu
         TmAEwUZsSHBDfBMlRu5P8iCfM2dTMLXjY+hOfBrhLa3/+6I6zRESyTNO+FKdq1X50AXp
         XSZvTDrrvUTC6cw9gX5+4vFTl3mtdV0ZmaU7GtbCyDGyp4NWW0i/ObaHN1qvS6cTUgUw
         EPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715832603; x=1716437403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFrog2h5nAkzpq5WoUadeeUmrdg//eB0XW+3OoY88O0=;
        b=iXfRykGsm35DWlyN5wJx1R6H9A56xDqLpq4M9gap8JVR8VFGUl7qjPA8k8wW0HXZAS
         TAlqBmUyg6Km6D1N3UudKgoQ4uHP+mPW2bWRLCKolCJa8r6Mnnp8jlVsB1oMTUaDC77m
         rCg76ny+lWZGDShu0Klg5jPlZaaU1gnJVOAs0URKh08zNyaRmEFlMBk3DexgUCRVL95i
         ah0OJemFkK0dU1ZUndWkPsUMY3k6sGeVeaPC0StxIrRrLjEbVFD9dAnyVxIYKzbnkQuR
         2kpQrH/KqXZPxN3faZku+uZri3RMs8h0181W8KyPSR/fdtrojn3aN4lyAOtBibfsK58t
         mTsw==
X-Forwarded-Encrypted: i=1; AJvYcCW68jW+4pbSmGcMg0xFyK+gJM44pqFGf6aw6lBk6HNyq9yWXpHl1oNWTvj96AnoU4EB54MxwhYA/28nD6CeetKDBAqAvG/V1jjWpS09
X-Gm-Message-State: AOJu0YwPzmjCh/M9q2o8EgX3S8VAIDxmARI+2hAVgdvHJHlG2KLPaLPu
	wLuSiKKtM0KcuRCPJ/6nEqIKteFkbji0WA3QA0E+WUdjKmTfLsLGimBxymVPRiZRnEjsFgcCfFX
	wch8llSLrGgI5dHWGkWTPsZjKo+nCgmlsH5YF3A==
X-Google-Smtp-Source: AGHT+IEZwOTguoznC6GO7B8DWo9mKJcJa+X8xXJwVFs0MwvGABgNROFhXX+idM0oJv5WOU5cfX3Gc8V5kZLRXZTdZrY=
X-Received: by 2002:a05:6870:d106:b0:23c:cab7:1310 with SMTP id
 586e51a60fabf-241730dc0edmr24147517fac.56.1715832602830; Wed, 15 May 2024
 21:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
 <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
 <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com>
 <CAPDyKFr_M0NDH0gaunBpybnALOFfz4LpX4_JW2GCUxjwGzdZsg@mail.gmail.com>
 <CAKddAkC5CRX+ZTh=MgzPYU72SY13+AQYhknhV_CC+=XX9=DKyg@mail.gmail.com>
 <CAAhSdy1SDd=VUqDQA0T5n9LwHo=3uGzFq1dUcbDFcB3aBdaioA@mail.gmail.com>
 <CAAhSdy33DcNw+pbDRrR=hBH86kwvu3xZbomQby8XhRXcc-exqQ@mail.gmail.com>
 <CAKddAkBrP2iQBC+aY1Xw5pssBpiQZe4V-6ww5m8hbKP6V0jzLg@mail.gmail.com> <CAAhSdy12-_Hdb-WVrs8kyfCy_OQA0p27DS6TOV87dh9HODrU_Q@mail.gmail.com>
In-Reply-To: <CAAhSdy12-_Hdb-WVrs8kyfCy_OQA0p27DS6TOV87dh9HODrU_Q@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 16 May 2024 12:09:52 +0800
Message-ID: <CAKddAkCQOvnci-bzKx1pBUJh5t1uPT-wNXGH1WyqDyb5qR_Scg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Anup Patel <anup@brainfault.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, palmer@dabbelt.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup

On Wed, May 15, 2024 at 9:46=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> Hi Nick,
>
> On Wed, May 15, 2024 at 5:45=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Hi Anup,
> >
> > Thank you for your guidance.
> > After enabling the debug message, we found a way to solve the problem
> > by the following steps:
> > 1. Add a compatible string in 'power-domains' node otherwise it won't
> > be the supplier of the consumers. (See of_link_to_phandle())
>
> Hmm, requiring a compatible string is odd. Where should we document
> this compatible string ?
>
Sorry, this is my fault. I didn't include some updates in
of_link_to_phandle(). This led some misunderstandings here.
You are right, we don't need it.
The supplier will be linked to the CLUSTER_PD node.

> > 2. Move the 'power-domains' node outside the 'cpus' node otherwise it
> > won't be added to the device hierarchy by device_add().
> > 3. Update the cpuidle-riscv-sbi driver to get the pds_node from
> > '/power-domains'.
>
> By adding a compatible string and moving the "power-domains" node
> outside, you are simply forcing the OF framework to populate devices.
>
> How about manually creating platform_device for each power-domain
> DT node using of_platform_device_create() in sbi_pd_init() ?
>
Thanks for the suggestion! We have test the solution and it could work.
We was wondering if it's feasible for us to relocate the
'power-domains' node outside of the /cpus? The CLUSTER_PD might
encompass not only the CPUs but also other components within the
cluster.

We also look at cpuidle_psci_domain driver and it seems Arm doesn't
create the devices for each subnode of psci domain.
Is there any reason that they don't need it?

> >
> > So the DTS will be like:
> > cpus {
> >     ...
> >      domain-idle-states {
> >            CLUSTER_SLEEP:cluster-sleep {
> >                         compatible =3D "domain-idle-state";
> >                         ...
> >             }
> >      }
> > }
> > power-domains {
> >             compatible =3D "riscv,sbi-power-domains"
> >             ...
> >             ...
> >             CLUSTER_PD: clusterpd {
> >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> >             };
> > }
> > soc {
> >       deviceA@xxx{
> >              ...
> >              power-domains =3D <&CLUSTER_PD>;
> >              ...
> >       }
> > }
>
> Regards,
> Anup
>
> >
> > Regards,
> > Nick
> >
> > On Tue, May 14, 2024 at 10:54=E2=80=AFPM Anup Patel <anup@brainfault.or=
g> wrote:
> > >
> > > On Tue, May 14, 2024 at 7:53=E2=80=AFPM Anup Patel <anup@brainfault.o=
rg> wrote:
> > > >
> > > > Hi Nick,
> > > >
> > > > On Tue, May 14, 2024 at 3:20=E2=80=AFPM Nick Hu <nick.hu@sifive.com=
> wrote:
> > > > >
> > > > > Hi Ulf,
> > > > >
> > > > > Thank you for your valuable suggestion.
> > > > > I sincerely apologize for the delay in responding to your message=
 We
> > > > > have diligently worked on experimenting with the suggestion you
> > > > > provided.
> > > > >
> > > > > As per your recommendation, we have incorporated the "power-domai=
ns=3D<>
> > > > > property" into the consumer's node, resulting in modifications to=
 the
> > > > > DTS as illustrated below:
> > > > >
> > > > > cpus {
> > > > >     ...
> > > > >      domain-idle-states {
> > > > >            CLUSTER_SLEEP:cluster-sleep {
> > > > >                         compatible =3D "domain-idle-state";
> > > > >                         ...
> > > > >             }
> > > > >      }
> > > > >      power-domains {
> > > > >             ...
> > > > >             ...
> > > > >             CLUSTER_PD: clusterpd {
> > > > >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> > > > >             };
> > > > >      }
> > > > > }
> > > > > soc {
> > > > >       deviceA@xxx{
> > > > >              ...
> > > > >              power-domains =3D <&CLUSTER_PD>;
> > > > >              ...
> > > > >       }
> > > > > }
> > > > >
> > > > > However, this adjustment has led to an issue where the probe for
> > > > > 'deviceA' is deferred by 'device_links_check_suppliers()' within
> > > > > 'really_probe()'. In an attempt to mitigate this issue, we
> > > > > experimented with a workaround by adding the attribute
> > > > > "status=3D"disabled"" to the 'CLUSTER_PD' node. This action aimed=
 to
> > > > > prevent the creation of a device link between 'deviceA' and
> > > > > 'CLUSTER_PD'. Nevertheless, we remain uncertain about the
> > > > > appropriateness of this solution.
> > > > >
> > > > > Do you have suggestions on how to effectively address this issue?
> > > >
> > > > I totally missed this email since I was not CC'ed sorry about that.=
 Please
> > > > use get_maintainers.pl when sending patches.
> > >
> > > I stand corrected. This patch had landed in the "spam" folder. I don'=
t know why.
> > >
> > > Regards,
> > > Anup
> > >
> > > >
> > > > The genpd_add_provider() (called by of_genpd_add_provider_simple())
> > > > does mark the power-domain DT node as initialized (fwnode_dev_initi=
alized())
> > > > so after the cpuidle-riscv-sbi driver is probed the 'deviceA' depen=
dency is
> > > > resolved and 'deviceA' should be probed unless there are other unme=
t
> > > > dependencies.
> > > >
> > > > Try adding "#define DEBUG" before all includes in drivers/core/base=
c
> > > > and add "loglevel=3D8" in kernel parameters, this will print produc=
er-consumer
> > > > linkage of all devices.
> > > >
> > > > Marking the power-domain DT node as "disabled" is certainly not the
> > > > right way.
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > > >
> > > > > Regards,
> > > > > Nick
> > > > >
> > > > > On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > >
> > > > > > On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wrot=
e:
> > > > > > >
> > > > > > > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sif=
ive.com> wrote:
> > > > > > > >
> > > > > > > > Hi Ulf
> > > > > > > >
> > > > > > > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.h=
ansson@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > When the cpus in the same cluster are all in the idle s=
tate, the kernel
> > > > > > > > > > might put the cluster into a deeper low power state. Ca=
ll the
> > > > > > > > > > cluster_pm_enter() before entering the low power state =
and call the
> > > > > > > > > > cluster_pm_exit() after the cluster woken up.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > > > > >
> > > > > > > > > I was not cced this patch, but noticed that this patch go=
t queued up
> > > > > > > > > recently. Sorry for not noticing earlier.
> > > > > > > > >
> > > > > > > > > If not too late, can you please drop/revert it? We should=
 really move
> > > > > > > > > away from the CPU cluster notifiers. See more information=
 below.
> > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++=
+++++++++--
> > > > > > > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/driv=
ers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > > > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off=
(struct generic_pm_domain *pd)
> > > > > > > > > >  {
> > > > > > > > > >         struct genpd_power_state *state =3D &pd->states=
[pd->state_idx];
> > > > > > > > > >         u32 *pd_state;
> > > > > > > > > > +       int ret;
> > > > > > > > > >
> > > > > > > > > >         if (!state->data)
> > > > > > > > > >                 return 0;
> > > > > > > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_of=
f(struct generic_pm_domain *pd)
> > > > > > > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > > > > > > >                 return -EBUSY;
> > > > > > > > > >
> > > > > > > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > > > > > > +       if (ret)
> > > > > > > > > > +               return ret;
> > > > > > > > >
> > > > > > > > > Rather than using the CPU cluster notifiers, consumers of=
 the genpd
> > > > > > > > > can register themselves to receive genpd on/off notifiers=
.
> > > > > > > > >
> > > > > > > > > In other words, none of this should be needed, right?
> > > > > > > > >
> > > > > > > > Thanks for the feedback!
> > > > > > > > Maybe I miss something, I'm wondering about a case like bel=
ow:
> > > > > > > > If we have a shared L2 cache controller inside the cpu clus=
ter power
> > > > > > > > domain and we add this controller to be a consumer of the p=
ower
> > > > > > > > domain, Shouldn't the genpd invoke the domain idle only aft=
er the
> > > > > > > > shared L2 cache controller is suspended?
> > > > > > > > Is there a way that we can put the L2 cache down while all =
cpus in the
> > > > > > > > same cluster are idle?
> > > > > > > > > [...]
> > > > > > > Sorry, I made some mistake in my second question.
> > > > > > > Update the question here:
> > > > > > > Is there a way that we can save the L2 cache states while all=
 cpus in the
> > > > > > > same cluster are idle and the cluster could be powered down?
> > > > > >
> > > > > > If the L2 cache is a consumer of the cluster, the consumer driv=
er for
> > > > > > the L2 cache should register for genpd on/off notifiers.
> > > > > >
> > > > > > The device representing the L2 cache needs to be enabled for ru=
ntime
> > > > > > PM, to be taken into account correctly by the cluster genpd. In=
 this
> > > > > > case, the device should most likely remain runtime suspended, b=
ut
> > > > > > instead rely on the genpd on/off notifiers to understand when
> > > > > > save/restore of the cache states should be done.
> > > > > >
> > > > > > Kind regards
> > > > > > Uffe


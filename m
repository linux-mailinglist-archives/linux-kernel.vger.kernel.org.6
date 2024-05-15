Return-Path: <linux-kernel+bounces-179837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6706E8C6636
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A181F21EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FBC745D6;
	Wed, 15 May 2024 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KE9q6xzQ"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8714AB4
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775338; cv=none; b=tMmSN1ocqfuwQb8edhLTSom4pAij+OVIryl8ls9SpP8Dnvt/8sdVhCB5rSArECfHHC7ZMOTa166KN4MXoQhvf2nj6wfDi5b86DNudQix1FnVvJjHOleTZ0LmHEP9oCKwklcQkI/A6wS0VbLngnbEa3Ds6r98adp5J3eP6dTBQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775338; c=relaxed/simple;
	bh=yPuAnX7AeqdHJVpDRwteZLmZrILjc1lx/Elu4Cs5CBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wztf+JjBb8z4yM/xxFwD2xKAkR8rEWz3SnpM2V8EgQ8YCt/D6Szng7Z6NNyKhJVO5KhJi8MrK1TdF18QS6auc98ipgbBx1HtsIY765Ij761GpozVTLKp/u/1Wix8FCthLxriI6Gnbto8CY2Ga9AfT4GpE2clDiDXBKRCVm6/jJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KE9q6xzQ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23dd4dca5dbso2087903fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715775335; x=1716380135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F6+ibZcVnKBu4wxTZ3B0lxkRxQFr/PcoYillE1OJG8=;
        b=KE9q6xzQqTAm7Q63wP4tyRYhUQZmYBuJCwYN9VmRIDb9mmLtTU3wcK8DzmRkKn6LSC
         rUOrgZOfy6ICLjeu5QsQsl4HbsBGoL8H/q+0BAoH7oWeTGxW2RStN7gUqecyu+sl/i57
         yif+CR6y9A9GmKJipcLMiD6Qxtb7Y+iXiQqvJDpss+DKE6eWVu+Ddm7aWWBOAlVdMrxt
         bI6e8wdrS0L5hCdjIdhrntsZkuhUJGo5rcNh6jvMyIqJigTwr8apjZDu6JUsZ9YENE6h
         c/Ef4obAbG+StgUT4FCOtLe1hbc6cMTg1S7mVV0DbyIPh0nW0GJXvx5f78hH0eg0IWXp
         TdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715775335; x=1716380135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8F6+ibZcVnKBu4wxTZ3B0lxkRxQFr/PcoYillE1OJG8=;
        b=SmQa4UlA4cUczhCs3j9/amjr6o18o9L5TulM/JgdApjxLeBTHcurI8tgq+8LyV24tQ
         e/sJQvJbzor5nHpPLt8Vun48JvVXZmDFnBh/8YC0tktEdcP0ZQtiAV1Z+lhIw7IjGxxg
         8hZ7AECS8cdhEmJ1Jomg+euwPRC1RZi8n9iB+NI1Ld/KOWgkhTHLMGY1eKFPmU9U/qQn
         s6z/g286a49YTrf+pq09KSvTDOcwz9/BPA42NkFsFYCbIuyDuXbAXKkFBY3tk2f8yA32
         et/s3TqbW+zhgML5GiEGP8byc9faxYhlRg2x14cmgMHEFx79LVfjBZFxdv83cO7M7dtT
         CNTA==
X-Forwarded-Encrypted: i=1; AJvYcCUwwHakrs3aD8FA3Oec4iRxj0+LnMqj8fyBouDjZTHdW68lRUB1kDlxys/y+gWtf1W1UgmgZ85WD1/Ik/lyCGD62oX0P5KD6y0jXY/h
X-Gm-Message-State: AOJu0YzEcc3BF8hg5/jb/SfCKu4L3hBr2cjgckSR0pT6LeeJJII0g31v
	/M3FlUNT9i+Suplsw4lEiDcUz96VON5Kf3y7+/MtZOjVKuTkn37QMWDU/71uZ7CPkZkXapOZoPS
	jheuR8Y2PbRLuGdMUiJeMLigxTvzQIHS7A8Z/pQ==
X-Google-Smtp-Source: AGHT+IGKXhERaCRJklTbeBzryhZdK9AxRKMCakf5KMzPJs2c9yJWuAw/fGyB8CT3vTI9GrJaodxC8vlr8+td8jZyj0s=
X-Received: by 2002:a05:6870:a9a8:b0:23d:221c:aacf with SMTP id
 586e51a60fabf-24111c66e1cmr8414210fac.10.1715775335087; Wed, 15 May 2024
 05:15:35 -0700 (PDT)
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
 <CAAhSdy1SDd=VUqDQA0T5n9LwHo=3uGzFq1dUcbDFcB3aBdaioA@mail.gmail.com> <CAAhSdy33DcNw+pbDRrR=hBH86kwvu3xZbomQby8XhRXcc-exqQ@mail.gmail.com>
In-Reply-To: <CAAhSdy33DcNw+pbDRrR=hBH86kwvu3xZbomQby8XhRXcc-exqQ@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Wed, 15 May 2024 20:15:24 +0800
Message-ID: <CAKddAkBrP2iQBC+aY1Xw5pssBpiQZe4V-6ww5m8hbKP6V0jzLg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Anup Patel <anup@brainfault.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, palmer@dabbelt.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

Thank you for your guidance.
After enabling the debug message, we found a way to solve the problem
by the following steps:
1. Add a compatible string in 'power-domains' node otherwise it won't
be the supplier of the consumers. (See of_link_to_phandle())
2. Move the 'power-domains' node outside the 'cpus' node otherwise it
won't be added to the device hierarchy by device_add().
3. Update the cpuidle-riscv-sbi driver to get the pds_node from
'/power-domains'.

So the DTS will be like:
cpus {
    ...
     domain-idle-states {
           CLUSTER_SLEEP:cluster-sleep {
                        compatible =3D "domain-idle-state";
                        ...
            }
     }
}
power-domains {
            compatible =3D "riscv,sbi-power-domains"
            ...
            ...
            CLUSTER_PD: clusterpd {
                    domain-idle-states =3D <&CLUSTER_SLEEP>;
            };
}
soc {
      deviceA@xxx{
             ...
             power-domains =3D <&CLUSTER_PD>;
             ...
      }
}

Regards,
Nick

On Tue, May 14, 2024 at 10:54=E2=80=AFPM Anup Patel <anup@brainfault.org> w=
rote:
>
> On Tue, May 14, 2024 at 7:53=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > Hi Nick,
> >
> > On Tue, May 14, 2024 at 3:20=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wr=
ote:
> > >
> > > Hi Ulf,
> > >
> > > Thank you for your valuable suggestion.
> > > I sincerely apologize for the delay in responding to your message. We
> > > have diligently worked on experimenting with the suggestion you
> > > provided.
> > >
> > > As per your recommendation, we have incorporated the "power-domains=
=3D<>
> > > property" into the consumer's node, resulting in modifications to the
> > > DTS as illustrated below:
> > >
> > > cpus {
> > >     ...
> > >      domain-idle-states {
> > >            CLUSTER_SLEEP:cluster-sleep {
> > >                         compatible =3D "domain-idle-state";
> > >                         ...
> > >             }
> > >      }
> > >      power-domains {
> > >             ...
> > >             ...
> > >             CLUSTER_PD: clusterpd {
> > >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> > >             };
> > >      }
> > > }
> > > soc {
> > >       deviceA@xxx{
> > >              ...
> > >              power-domains =3D <&CLUSTER_PD>;
> > >              ...
> > >       }
> > > }
> > >
> > > However, this adjustment has led to an issue where the probe for
> > > 'deviceA' is deferred by 'device_links_check_suppliers()' within
> > > 'really_probe()'. In an attempt to mitigate this issue, we
> > > experimented with a workaround by adding the attribute
> > > "status=3D"disabled"" to the 'CLUSTER_PD' node. This action aimed to
> > > prevent the creation of a device link between 'deviceA' and
> > > 'CLUSTER_PD'. Nevertheless, we remain uncertain about the
> > > appropriateness of this solution.
> > >
> > > Do you have suggestions on how to effectively address this issue?
> >
> > I totally missed this email since I was not CC'ed sorry about that. Ple=
ase
> > use get_maintainers.pl when sending patches.
>
> I stand corrected. This patch had landed in the "spam" folder. I don't kn=
ow why.
>
> Regards,
> Anup
>
> >
> > The genpd_add_provider() (called by of_genpd_add_provider_simple())
> > does mark the power-domain DT node as initialized (fwnode_dev_initializ=
ed())
> > so after the cpuidle-riscv-sbi driver is probed the 'deviceA' dependenc=
y is
> > resolved and 'deviceA' should be probed unless there are other unmet
> > dependencies.
> >
> > Try adding "#define DEBUG" before all includes in drivers/core/base.c
> > and add "loglevel=3D8" in kernel parameters, this will print producer-c=
onsumer
> > linkage of all devices.
> >
> > Marking the power-domain DT node as "disabled" is certainly not the
> > right way.
> >
> > Regards,
> > Anup
> >
> > >
> > > Regards,
> > > Nick
> > >
> > > On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wrote:
> > > > >
> > > > > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sifive.=
com> wrote:
> > > > > >
> > > > > > Hi Ulf
> > > > > >
> > > > > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.hanss=
on@linaro.org> wrote:
> > > > > > >
> > > > > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wr=
ote:
> > > > > > > >
> > > > > > > > When the cpus in the same cluster are all in the idle state=
, the kernel
> > > > > > > > might put the cluster into a deeper low power state. Call t=
he
> > > > > > > > cluster_pm_enter() before entering the low power state and =
call the
> > > > > > > > cluster_pm_exit() after the cluster woken up.
> > > > > > > >
> > > > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > > >
> > > > > > > I was not cced this patch, but noticed that this patch got qu=
eued up
> > > > > > > recently. Sorry for not noticing earlier.
> > > > > > >
> > > > > > > If not too late, can you please drop/revert it? We should rea=
lly move
> > > > > > > away from the CPU cluster notifiers. See more information bel=
ow.
> > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++++++=
+++++--
> > > > > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/=
cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(str=
uct generic_pm_domain *pd)
> > > > > > > >  {
> > > > > > > >         struct genpd_power_state *state =3D &pd->states[pd-=
>state_idx];
> > > > > > > >         u32 *pd_state;
> > > > > > > > +       int ret;
> > > > > > > >
> > > > > > > >         if (!state->data)
> > > > > > > >                 return 0;
> > > > > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(st=
ruct generic_pm_domain *pd)
> > > > > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > > > > >                 return -EBUSY;
> > > > > > > >
> > > > > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > > > > +       if (ret)
> > > > > > > > +               return ret;
> > > > > > >
> > > > > > > Rather than using the CPU cluster notifiers, consumers of the=
 genpd
> > > > > > > can register themselves to receive genpd on/off notifiers.
> > > > > > >
> > > > > > > In other words, none of this should be needed, right?
> > > > > > >
> > > > > > Thanks for the feedback!
> > > > > > Maybe I miss something, I'm wondering about a case like below:
> > > > > > If we have a shared L2 cache controller inside the cpu cluster =
power
> > > > > > domain and we add this controller to be a consumer of the power
> > > > > > domain, Shouldn't the genpd invoke the domain idle only after t=
he
> > > > > > shared L2 cache controller is suspended?
> > > > > > Is there a way that we can put the L2 cache down while all cpus=
 in the
> > > > > > same cluster are idle?
> > > > > > > [...]
> > > > > Sorry, I made some mistake in my second question.
> > > > > Update the question here:
> > > > > Is there a way that we can save the L2 cache states while all cpu=
s in the
> > > > > same cluster are idle and the cluster could be powered down?
> > > >
> > > > If the L2 cache is a consumer of the cluster, the consumer driver f=
or
> > > > the L2 cache should register for genpd on/off notifiers.
> > > >
> > > > The device representing the L2 cache needs to be enabled for runtim=
e
> > > > PM, to be taken into account correctly by the cluster genpd. In thi=
s
> > > > case, the device should most likely remain runtime suspended, but
> > > > instead rely on the genpd on/off notifiers to understand when
> > > > save/restore of the cache states should be done.
> > > >
> > > > Kind regards
> > > > Uffe


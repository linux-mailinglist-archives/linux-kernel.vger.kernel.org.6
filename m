Return-Path: <linux-kernel+bounces-186955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035888CCB24
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E26282E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF213AD3E;
	Thu, 23 May 2024 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Pw/PW1/U"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1ED433A2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434812; cv=none; b=BN9JhN4gFZBlP+XrJ13dE5k3gZg6R3pALZ9p38AqMNo5GegnusgQmDe9t0ktIDFM1Koa0onHy/63a31bEZt/JVSyKzX14rd7c52j9uDsEBUDRHTTFPZg/Bi27arFMioENr3zh2m/ZcpbRSq/oGqo/lvaPLvw1qPi3k0uKgP+cXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434812; c=relaxed/simple;
	bh=kOSJ5343ZgD6KXVJTDj3JIky3M/+oxREycPHACuh6ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+yg+wkj08aCfCSK8Rh+e3i0U27UM3YD3+Wl2CCQQ9nlnYh5R9wt2z3Yt/ZvvP0UwREaRejI3HdXUVXmCXmAiI8YBqmY8rF+rK52J32fCbN+N4mKYoW0o+fMKoP6ADRBidrtPXS7URxmA9S4ubugNfuosyhI+wg6EDe5z3lyXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Pw/PW1/U; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b295d6b7fbso3274133eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1716434809; x=1717039609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7zTuP2XgCofoIWKacpr34bMlGlhPX3lpxrhBKwjHqo=;
        b=Pw/PW1/UJKe5HYwiCzPETJv+yNRutwa/nB+YBS8rni2AhlrKOv18GoFbzsVoBEduCO
         gP8eC15FNJ6T31rCr7QrPZMRlEKOd83DsbHqEmRQFnmj1P2FnRXGfrD6LeCTNLf9FeVw
         qi4JraER+4g4CksWgpRpb7tX508byqMtqEfXi1qf+xJ1z2jTeB33W9TqiBzJ+6iOyalH
         kLzsDiWs5Po4C/4JBzZ1Z6pS1FgswHOz1aK9IPsW3Cw+PrrVPgDeOnBpgjPUg2U6CWpj
         BSsRkr6ywwWVwROStRjymcHSkT1YZ6QFlOn9oRuRWIYmS8GcZvTOHgpSVUVG6/C2QPul
         4l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716434809; x=1717039609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7zTuP2XgCofoIWKacpr34bMlGlhPX3lpxrhBKwjHqo=;
        b=uDjy2ZNYTCMsZyV1xbFsJO+QxLkVYAkY4oxBmW9A8NYpgZQrOH0U4moxK/+gkHsWrr
         IJindxvBPt5VU+9+oWxEIGkE+xJGq9lpnI28CEbpywuSwtauVUF25RcSwF0LdvermC4q
         NHMlDifZuoM24tTNFiQL8UJ0vjBE24AFHr1WKBDcRBCVNXvvILQnF1tBAnycNZcXzI4j
         ayMMoxGDohN1GUmJNOqFxISIwUt44psRFJ6wNknJ0dn0uFSzD2dJvUk+jZCDGoCfRmtc
         BULxul68UtqHAfl/1y4LCOQ0Ujop+nrnKBenvH/eBRC6MeeNH1cI4PoUiNAIKhDOm1ap
         1sPw==
X-Forwarded-Encrypted: i=1; AJvYcCVFdxa8fO7m3ouOS9ptQxT6yX52rzXC+HxLD/H+ArBb6VCTqiRFuuMo5wrx3YljbBoJeRX8ij4eI/OgFjnmPUFhHaHvuqowBaZuOSpt
X-Gm-Message-State: AOJu0YzvD1mg2Sjx0DOICO7MNNgL9oJialPE6QXv5w7eiFABy3qihT2d
	4S8JkZbrl9jmUfZdonJFrY0mhygpg/ZMTTeZRTfgzTRYWuJVRuPcy8QAXWe7P3zW7EfqfwS7Jd8
	a3HOxgORA6OAdEb5IQ0ADqQbjhMrzBL4w+s1Fsw==
X-Google-Smtp-Source: AGHT+IGGpf1SUcygd521wlQp1GkYsu1Ml5R8D8AIaZD4u1+YTualMlPhYztsm7Qk6u1pKSqTcEtgsPAy5CbvGXxqUPA=
X-Received: by 2002:a05:6820:821:b0:5b2:3f04:8d03 with SMTP id
 006d021491bc7-5b6a4123352mr3639833eaf.7.1716434809075; Wed, 22 May 2024
 20:26:49 -0700 (PDT)
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
 <CAKddAkBrP2iQBC+aY1Xw5pssBpiQZe4V-6ww5m8hbKP6V0jzLg@mail.gmail.com>
 <CAAhSdy12-_Hdb-WVrs8kyfCy_OQA0p27DS6TOV87dh9HODrU_Q@mail.gmail.com>
 <CAKddAkCQOvnci-bzKx1pBUJh5t1uPT-wNXGH1WyqDyb5qR_Scg@mail.gmail.com> <CAK9=C2V2xYwi4wK2+e=z7NF8Ph7+LxvWh4J4TmQrbVfSfpO-Ag@mail.gmail.com>
In-Reply-To: <CAK9=C2V2xYwi4wK2+e=z7NF8Ph7+LxvWh4J4TmQrbVfSfpO-Ag@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 23 May 2024 11:26:38 +0800
Message-ID: <CAKddAkA6ghz3LmVwkdCJ8n+JeF-67pZi07NuPWfron46NLpKoQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Anup Patel <apatel@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Ulf Hansson <ulf.hansson@linaro.org>, palmer@dabbelt.com, 
	rafael@kernel.org, daniel.lezcano@linaro.org, paul.walmsley@sifive.com, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, 
	Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

On Fri, May 17, 2024 at 12:39=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> On Thu, May 16, 2024 at 9:40=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Hi Anup
> >
> > On Wed, May 15, 2024 at 9:46=E2=80=AFPM Anup Patel <anup@brainfault.org=
> wrote:
> > >
> > > Hi Nick,
> > >
> > > On Wed, May 15, 2024 at 5:45=E2=80=AFPM Nick Hu <nick.hu@sifive.com> =
wrote:
> > > >
> > > > Hi Anup,
> > > >
> > > > Thank you for your guidance.
> > > > After enabling the debug message, we found a way to solve the probl=
em
> > > > by the following steps:
> > > > 1. Add a compatible string in 'power-domains' node otherwise it won=
't
> > > > be the supplier of the consumers. (See of_link_to_phandle())
> > >
> > > Hmm, requiring a compatible string is odd. Where should we document
> > > this compatible string ?
> > >
> > Sorry, this is my fault. I didn't include some updates in
> > of_link_to_phandle(). This led some misunderstandings here.
> > You are right, we don't need it.
> > The supplier will be linked to the CLUSTER_PD node.
> >
> > > > 2. Move the 'power-domains' node outside the 'cpus' node otherwise =
it
> > > > won't be added to the device hierarchy by device_add().
> > > > 3. Update the cpuidle-riscv-sbi driver to get the pds_node from
> > > > '/power-domains'.
> > >
> > > By adding a compatible string and moving the "power-domains" node
> > > outside, you are simply forcing the OF framework to populate devices.
> > >
> > > How about manually creating platform_device for each power-domain
> > > DT node using of_platform_device_create() in sbi_pd_init() ?
> > >
> > Thanks for the suggestion! We have test the solution and it could work.
> > We was wondering if it's feasible for us to relocate the
> > 'power-domains' node outside of the /cpus? The CLUSTER_PD might
> > encompass not only the CPUs but also other components within the
> > cluster.
>
> The cpuidle-riscv-sbi driver expects "power-domains" DT node
> under "/cpus" DT node because this driver only deals with power
> domains related to CPU cluster or CPU cache-hierarchy. It does
> make sense to define L2/L3 power domains under
> "/cpus/power-domain" since these are related to CPUs.
>
> Moving the CPU "power-domains" DT node directly under "/" or
> somewhere else would mean that it covers system-wide power
> domains which is not true.
>
> I suggest we continue using "/cpus/power-domains" DT node
> only for power domains related to CPU clusters or CPU
> cache-hierarchy.
>
> For system wide power domains of SoC devices, we can either:
> 1) Use device power domains through the SBI MPXY extension
>     via different driver
> 2) Use a platform specific driver
>
Thank you for your valuable feedback. We will continue to use the
"/cpus/power-domains".

> >
> > We also look at cpuidle_psci_domain driver and it seems Arm doesn't
> > create the devices for each subnode of psci domain.
> > Is there any reason that they don't need it?
>
> Existing ARM DTS files under arch/arm64/boot/dts, use device
> power domains through SCMI (or platform specific mechanism)
> which are already populated as devices by Linux DD framework.
>
> Regards,
> Anup
>
Thank you for the explanation!

Regards,
Nick


> >
> > > >
> > > > So the DTS will be like:
> > > > cpus {
> > > >     ...
> > > >      domain-idle-states {
> > > >            CLUSTER_SLEEP:cluster-sleep {
> > > >                         compatible =3D "domain-idle-state";
> > > >                         ...
> > > >             }
> > > >      }
> > > > }
> > > > power-domains {
> > > >             compatible =3D "riscv,sbi-power-domains"
> > > >             ...
> > > >             ...
> > > >             CLUSTER_PD: clusterpd {
> > > >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> > > >             };
> > > > }
> > > > soc {
> > > >       deviceA@xxx{
> > > >              ...
> > > >              power-domains =3D <&CLUSTER_PD>;
> > > >              ...
> > > >       }
> > > > }
> > >
> > > Regards,
> > > Anup
> > >
> > > >
> > > > Regards,
> > > > Nick
> > > >
> > > > On Tue, May 14, 2024 at 10:54=E2=80=AFPM Anup Patel <anup@brainfaul=
t.org> wrote:
> > > > >
> > > > > On Tue, May 14, 2024 at 7:53=E2=80=AFPM Anup Patel <anup@brainfau=
lt.org> wrote:
> > > > > >
> > > > > > Hi Nick,
> > > > > >
> > > > > > On Tue, May 14, 2024 at 3:20=E2=80=AFPM Nick Hu <nick.hu@sifive=
com> wrote:
> > > > > > >
> > > > > > > Hi Ulf,
> > > > > > >
> > > > > > > Thank you for your valuable suggestion.
> > > > > > > I sincerely apologize for the delay in responding to your mes=
sage We
> > > > > > > have diligently worked on experimenting with the suggestion y=
ou
> > > > > > > provided.
> > > > > > >
> > > > > > > As per your recommendation, we have incorporated the "power-d=
omains=3D<>
> > > > > > > property" into the consumer's node, resulting in modification=
s to the
> > > > > > > DTS as illustrated below:
> > > > > > >
> > > > > > > cpus {
> > > > > > >     ...
> > > > > > >      domain-idle-states {
> > > > > > >            CLUSTER_SLEEP:cluster-sleep {
> > > > > > >                         compatible =3D "domain-idle-state";
> > > > > > >                         ...
> > > > > > >             }
> > > > > > >      }
> > > > > > >      power-domains {
> > > > > > >             ...
> > > > > > >             ...
> > > > > > >             CLUSTER_PD: clusterpd {
> > > > > > >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> > > > > > >             };
> > > > > > >      }
> > > > > > > }
> > > > > > > soc {
> > > > > > >       deviceA@xxx{
> > > > > > >              ...
> > > > > > >              power-domains =3D <&CLUSTER_PD>;
> > > > > > >              ...
> > > > > > >       }
> > > > > > > }
> > > > > > >
> > > > > > > However, this adjustment has led to an issue where the probe =
for
> > > > > > > 'deviceA' is deferred by 'device_links_check_suppliers()' wit=
hin
> > > > > > > 'really_probe()'. In an attempt to mitigate this issue, we
> > > > > > > experimented with a workaround by adding the attribute
> > > > > > > "status=3D"disabled"" to the 'CLUSTER_PD' node. This action a=
imed to
> > > > > > > prevent the creation of a device link between 'deviceA' and
> > > > > > > 'CLUSTER_PD'. Nevertheless, we remain uncertain about the
> > > > > > > appropriateness of this solution.
> > > > > > >
> > > > > > > Do you have suggestions on how to effectively address this is=
sue?
> > > > > >
> > > > > > I totally missed this email since I was not CC'ed sorry about t=
hat. Please
> > > > > > use get_maintainers.pl when sending patches.
> > > > >
> > > > > I stand corrected. This patch had landed in the "spam" folder. I =
don't know why.
> > > > >
> > > > > Regards,
> > > > > Anup
> > > > >
> > > > > >
> > > > > > The genpd_add_provider() (called by of_genpd_add_provider_simpl=
e())
> > > > > > does mark the power-domain DT node as initialized (fwnode_dev_i=
nitialized())
> > > > > > so after the cpuidle-riscv-sbi driver is probed the 'deviceA' d=
ependency is
> > > > > > resolved and 'deviceA' should be probed unless there are other =
unmet
> > > > > > dependencies.
> > > > > >
> > > > > > Try adding "#define DEBUG" before all includes in drivers/core/=
basec
> > > > > > and add "loglevel=3D8" in kernel parameters, this will print pr=
oducer-consumer
> > > > > > linkage of all devices.
> > > > > >
> > > > > > Marking the power-domain DT node as "disabled" is certainly not=
 the
> > > > > > right way.
> > > > > >
> > > > > > Regards,
> > > > > > Anup
> > > > > >
> > > > > > >
> > > > > > > Regards,
> > > > > > > Nick
> > > > > > >
> > > > > > > On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hans=
son@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> =
wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu=
@sifive.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Ulf
> > > > > > > > > >
> > > > > > > > > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <u=
lf.hansson@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive=
com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > When the cpus in the same cluster are all in the id=
le state, the kernel
> > > > > > > > > > > > might put the cluster into a deeper low power state=
 Call the
> > > > > > > > > > > > cluster_pm_enter() before entering the low power st=
ate and call the
> > > > > > > > > > > > cluster_pm_exit() after the cluster woken up.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > > > > > > >
> > > > > > > > > > > I was not cced this patch, but noticed that this patc=
h got queued up
> > > > > > > > > > > recently. Sorry for not noticing earlier.
> > > > > > > > > > >
> > > > > > > > > > > If not too late, can you please drop/revert it? We sh=
ould really move
> > > > > > > > > > > away from the CPU cluster notifiers. See more informa=
tion below.
> > > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++=
+++++++++++++--
> > > > > > > > > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/=
drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > > > > > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power=
_off(struct generic_pm_domain *pd)
> > > > > > > > > > > >  {
> > > > > > > > > > > >         struct genpd_power_state *state =3D &pd->st=
ates[pd->state_idx];
> > > > > > > > > > > >         u32 *pd_state;
> > > > > > > > > > > > +       int ret;
> > > > > > > > > > > >
> > > > > > > > > > > >         if (!state->data)
> > > > > > > > > > > >                 return 0;
> > > > > > > > > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_powe=
r_off(struct generic_pm_domain *pd)
> > > > > > > > > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > > > > > > > > >                 return -EBUSY;
> > > > > > > > > > > >
> > > > > > > > > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > > > > > > > > +       if (ret)
> > > > > > > > > > > > +               return ret;
> > > > > > > > > > >
> > > > > > > > > > > Rather than using the CPU cluster notifiers, consumer=
s of the genpd
> > > > > > > > > > > can register themselves to receive genpd on/off notif=
iers.
> > > > > > > > > > >
> > > > > > > > > > > In other words, none of this should be needed, right?
> > > > > > > > > > >
> > > > > > > > > > Thanks for the feedback!
> > > > > > > > > > Maybe I miss something, I'm wondering about a case like=
 below:
> > > > > > > > > > If we have a shared L2 cache controller inside the cpu =
cluster power
> > > > > > > > > > domain and we add this controller to be a consumer of t=
he power
> > > > > > > > > > domain, Shouldn't the genpd invoke the domain idle only=
 after the
> > > > > > > > > > shared L2 cache controller is suspended?
> > > > > > > > > > Is there a way that we can put the L2 cache down while =
all cpus in the
> > > > > > > > > > same cluster are idle?
> > > > > > > > > > > [...]
> > > > > > > > > Sorry, I made some mistake in my second question.
> > > > > > > > > Update the question here:
> > > > > > > > > Is there a way that we can save the L2 cache states while=
 all cpus in the
> > > > > > > > > same cluster are idle and the cluster could be powered do=
wn?
> > > > > > > >
> > > > > > > > If the L2 cache is a consumer of the cluster, the consumer =
driver for
> > > > > > > > the L2 cache should register for genpd on/off notifiers.
> > > > > > > >
> > > > > > > > The device representing the L2 cache needs to be enabled fo=
r runtime
> > > > > > > > PM, to be taken into account correctly by the cluster genpd=
 In this
> > > > > > > > case, the device should most likely remain runtime suspende=
d, but
> > > > > > > > instead rely on the genpd on/off notifiers to understand wh=
en
> > > > > > > > save/restore of the cache states should be done.
> > > > > > > >
> > > > > > > > Kind regards
> > > > > > > > Uffe
> >


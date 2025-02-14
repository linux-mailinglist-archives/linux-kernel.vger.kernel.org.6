Return-Path: <linux-kernel+bounces-514732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C56A35AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B288C3A9028
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A9524BBEC;
	Fri, 14 Feb 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAMitlet"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA624A05E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526952; cv=none; b=J2hxUlg5NpqxxqBUU5f/F0/mjbI+WNkGXCbAxYa27tfxXNgiW50w19+18FVi2IrZY5l+p7Wed6P1aCSXjxESyG7YDtRABQdD00XCFlMZFxwcFhO/XLHKuDFGRA8iXDmrrDawSS8zPRjFcgItqRncVmYpG2adZtfIAJhSkYERVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526952; c=relaxed/simple;
	bh=uxAtWO05EGa8aC1ao3a9gQsD1RrFdajH15jQAUQtA1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b94MG76yRonUwStlabY0KuEDy4DXqbheuVim8YGQPCS6Ts+uRq/3oSwWl2ADW4an2oz6tiheTeTQOTUz285LdlU6Zov2uLOZRabvWLThehIyFuFYMld+16hg18QhRf9fdn5ESJCHQ6cQqYCUmc6AIFmDbkBD+nm8CrbVRYCITtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GAMitlet; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so1529449276.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739526949; x=1740131749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHsP8X2X7jaxDhy6OFn2jLfrDmR/kZsEjxuZAwMGCbo=;
        b=GAMitlet4y/98uLPzRSo0y+Vp4/vh/W2NKAa8g7rI9Anf6Y2EQv59C+AYHMBWrM+Dj
         OGrkVqYEMCLpgLTP3JiVoAmbFRs1rJn1j4QNCnW8BFnc+nRDTE07Wb83z/Ev0pB8dAnV
         QUVj3TRP827vNwAXrMCLxSAl850OLUIY1Dh1oaOO7VtWPqcNjJLV3Tg3e+Lj9hAs/8WV
         ubzp6uNMUUb7C2prbLCYWlzNLi96JWt1X+BGGBpdV8+7AApc739mmOhyk4RhyMEWju5N
         hxzakxwMGspMFDdID3Nc6uUM1yjbI3jdRE22q56xOUw5sRz4fCjwPKQnHlxriA1No+RA
         CnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526949; x=1740131749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHsP8X2X7jaxDhy6OFn2jLfrDmR/kZsEjxuZAwMGCbo=;
        b=HQdtx53U7sMdKSQyCL/5mteVaqLUXua5Jg3rxTGR0fhR7xTX5HScmnYPiOjW9ji5JO
         XktXbVMMBERl2wj6aQEpenjov9RsOSV3jdyXn0qy+oZICU2U3wxFHSxoVUW7jGDWpcZt
         8l5XD1HjvBrgQrgvH8WyNXh2/KK2ki/Y09Q4YOYjErc1+4QRRa6ter2r9mFaQIqnrttY
         UvRblCyjZFo/WNZ+gSRe9L2Kt1jQ3Lnwuw163i1fttQ9KAXbMGHZSdLydZ1Kr34asURu
         rPFLuoKNzviAdj6d+R8j41D9IBa5/Fb1of7tIJB8Is9dRX43gcAlTyu+eRgYx/Q3x3rT
         JTZw==
X-Forwarded-Encrypted: i=1; AJvYcCXP9nu087OoL65xs8drD9bizTrn0il+1n6LW94AwpN2t6zk9Y9awrfkncqCC8UJC4m87jZfNLIymyziTFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KjMHHv6FmckDPt9VkV4o8Lhklfu8+ZZdWBeG4QOxNHRb6DqR
	cK0HMffewe2jC5L8viIGUIECR6Q+hu2MwO9QU7NaRQC0EcDgj3uwbM/jq2S6AUU3y740f2m/Ebv
	jULL7gxTZpktcmcg+/pROaTuERatrUqtKgTRQYQ==
X-Gm-Gg: ASbGncuFxzZCWMiehYxo3Shq68K19msOsQgG9sNKq10536f4mXphzT5u9DL1QCGDDS9
	KbCfBEPuE+tdHJFXCO9zzICm5YjBSBnwj6zk+bQbScCmaloTk020BGZ8+v4HBDaQRZvvdlH1Uew
	==
X-Google-Smtp-Source: AGHT+IHnU3g+4VFrMIuTaBKNiKoG/6GBU+8YBPMP0iEURnOhpmzOeuZNYQQJZSCbmNvd3epYamuBoq4t/FaX4F03hpQ=
X-Received: by 2002:a05:6902:188e:b0:e58:173e:abcc with SMTP id
 3f1490d57ef6-e5da8102d3fmr7048536276.8.1739526948841; Fri, 14 Feb 2025
 01:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
 <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
 <CAPDyKFq91JnCFhEuitOJPZtq78-Y3CUy4p0bNE1wK+eYCste6g@mail.gmail.com>
 <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
 <CAPDyKFr1LmYji1Yh=mrx03eeW8ukFr9rE0hk277iam174TjGig@mail.gmail.com> <CAJZ5v0hsEg7eFRg2Q2sbn0DkUoBu0F08B+0yVGAicKyQ91NKuA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hsEg7eFRg2Q2sbn0DkUoBu0F08B+0yVGAicKyQ91NKuA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 14 Feb 2025 10:55:11 +0100
X-Gm-Features: AWEUYZkW-11H_rTBPK3HNWKRPiypMysMvAsIOXQmAKSrs8FEjM403k7y4lA-22g
Message-ID: <CAPDyKFoLM-sW8SfcZa2v-ruFYYxz3ZR7oXw_G+SCwvcZoEPEKA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 at 21:17, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 13, 2025 at 2:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 12 Feb 2025 at 18:05, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Wed, Feb 12, 2025 at 4:15=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Wed, 12 Feb 2025 at 12:33, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafae=
l@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hanss=
on@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> > > > > > > >
> > > > > > > > Hi Everyone,
> > > > > > > >
> > > > > > > > This series is a result of the discussion on a recently rep=
orted issue
> > > > > > > > with device runtime PM status propagation during system res=
ume and
> > > > > > > > the resulting patches:
> > > > > > > >
> > > > > > > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwyso=
cki.net/
> > > > > > > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysoc=
ki.net/
> > > > > > > >
> > > > > > > > Overall, due to restrictions related to pm_runtime_force_su=
spend() and
> > > > > > > > pm_runtime_force_resume(), it was necessary to limit the RP=
M_ACTIVE
> > > > > > > > setting propagation to the parent of the first device in a =
dependency
> > > > > > > > chain that turned out to have to be resumed during system r=
esume even
> > > > > > > > though it was runtime-suspended before system suspend.
> > > > > > > >
> > > > > > > > Those restrictions are that (1) pm_runtime_force_suspend() =
attempts to
> > > > > > > > suspend devices that have never had runtime PM enabled if t=
heir runtime
> > > > > > > > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_=
resume()
> > > > > > > > will skip device whose runtime PM status is currently RPM_A=
CTIVE.
> > > > > > > >
> > > > > > > > The purpose of this series is to eliminate the above restri=
ctions and
> > > > > > > > get pm_runtime_force_suspend() and pm_runtime_force_resume(=
) to agree
> > > > > > > > more with what the core does.
> > > > > > >
> > > > > > > For my understanding, would you mind elaborating a bit more a=
round the
> > > > > > > end-goal with this?
> > > > > >
> > > > > > The end goal is, of course, full integration of runtime PM with=
 system
> > > > > > sleep for all devices.  Eventually.
> > > > > >
> > > > > > And it is necessary to make the core and
> > > > > > pm_runtime_force_suspend|resume() work together better for this
> > > > > > purpose.
> > > > > >
> > > > > > > Are you trying to make adaptations for
> > > > > > > pm_runtime_force_suspend|resume() and the PM core, such that =
drivers
> > > > > > > that uses pm_runtime_force_suspend|resume() should be able to=
 cope
> > > > > > > with other drivers for child-devices that make use of
> > > > > > > DPM_FLAG_SMART_SUSPEND?
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > This is a more general case, though, when a device that was
> > > > > > runtime-suspended before system suspend and is left in suspend =
during
> > > > > > it, needs to be resumed during the system resume that follows.
> > > > > >
> > > > > > Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes an=
d it
> > > > > > cannot happen otherwise, but I think that it is a generally val=
id
> > > > > > case.
> > > > > >
> > > > > > > If we can make this work, it would enable the propagation of
> > > > > > > RPM_ACTIVE in the PM core for more devices, but still not for=
 all,
> > > > > > > right?
> > > > > >
> > > > > > It is all until there is a known case in which it isn't.  So ei=
ther
> > > > > > you know a specific case in which it doesn't work, or I don't s=
ee a
> > > > > > reason for avoiding it.
> > > > > >
> > > > > > ATM the only specific case in which it doesn't work is when
> > > > > > pm_runtime_force_suspend|resume() are used.
> > > > > >
> > > > > > > The point is, the other bigger issue that I pointed out in ou=
r earlier
> > > > > > > discussions; all those devices where their drivers/buses don'=
t cope
> > > > > > > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will p=
revent
> > > > > > > the PM core from *unconditionally* propagating the RPM_ACTIVE=
 to
> > > > > > > parents. I guess this is the best we can do then?
> > > > > >
> > > > > > OK, what are they?
> > > > > >
> > > > > > You keep saying that they exist without giving any examples.
> > > > >
> > > > > To put it more bluntly, I'm not aware of any place other than
> > > > > pm_runtime_force_suspend|resume() that can be confused by changin=
g the
> > > > > runtime PM status of a device with runtime PM disabled (either
> > > > > permanently, or transiently during a system suspend-resume cycle)=
 to
> > > > > RPM_ACTIVE, so if there are any such places, I would appreciate
> > > > > letting me know what they are.
> > > >
> > > > Well, sorry I thought you were aware. Anyway, I believe you need to=
 do
> > > > your own investigation as it's simply too time consuming for me to
> > > > find them all. The problem is that it's not just a simple pattern t=
o
> > > > search for, so we would need some clever scripting to move forward =
to
> > > > find them.
> > > >
> > > > To start with, we should look for drivers that enable runtime PM, b=
y
> > > > calling pm_runtime_enable().
> > > >
> > > > Additionally, in their system suspend callback they should typicall=
y
> > > > *not* use pm_runtime_suspended(), pm_runtime_status_suspended() or
> > > > pm_runtime_active() as that is usually (but no always) indicating t=
hat
> > > > they got it right. Then there are those that don't have system
> > > > suspend/resume callbacks assigned at all (or uses some other subsys=
tem
> > > > specific callback for this), but only uses runtime PM.
> > > >
> > > > On top of that, drivers that makes use of
> > > > pm_runtime_force_suspend|resume() should be disregarded, which has
> > > > reached beyond 300 as this point.
> > > >
> > > > Anyway, here is just one example that I found from a quick search.
> > > > drivers/i2c/busses/i2c-qcom-geni.c
> > >
> > > OK, I see.
> > >
> > > It sets the status to RPM_SUSPENDED in geni_i2c_suspend_noirq(), if
> > > not suspended already, and assumes it to stay this way across
> > > geni_i2c_resume_noirq() until someone resumes it via runtime PM.
> > >
> > > Fair enough, but somebody should tell them that they don't need to us=
e
> > > pm_runtime_disable/enable() in _noirq.
> > >
> > > > >
> > > > > Note that rpm_active() could start producing confusing results if=
 the
> > > > > runtime PM status of a device with runtime PM disabled is changed=
 from
> > > > > RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
> > > > > -EACCES instead of 1, but changing the status to RPM_ACTIVE will =
not
> > > > > confuse it the same way.
> > > >
> > > > Trust me, it will cause problems.
> > > >
> > > > Drivers may call pm_runtime_get_sync() to turn on the resources for
> > > > the device after the system has resumed, when runtime PM has been
> > > > re-enabled for the device by the PM core.
> > > >
> > > > Those calls to pm_runtime_get_sync() will then not end up invoking =
any
> > > > if ->runtime_resume() callbacks for the device since its state is
> > > > already RPM_ACTIVE. Hence, the device will remain in a low power st=
ate
> > > > even if the driver believes it has been powered on. In many cases,
> > > > accessing the device (like reading/writing a register) will often j=
ust
> > > > just hang in these cases, but in worst cases we could end up gettin=
g
> > > > even more difficult bugs to debug.
> > >
> > > Sure, that would be a problem.
> > >
> > > I think I need to find a different way to address the problem I'm
> > > seeing, that is to resume devices that were runtime-suspended before
> > > system suspend along with their superiors.
> > >
> > > One way to do it would be to just defer their resume to the point whe=
n
> > > the core has enabled runtime PM for them, which means that it has als=
o
> > > enabled runtime PM for all of their superiors, and then call
> > > pm_runtime_resume().
> > >
> > > This should work unless one of the superiors has runtime PM disabled
> > > at that point, of course.
> >
> > Right, so typically users of pm_runtime_force_suspend|resume() from
> > the regular ->suspend|resume() callbacks would not work, because they
> > disable/enable runtime PM. Although, we could probably fix this quite
> > easily by making some adaptations in
> > pm_runtime_force_suspend|resume().
> >
> > I am not sure if this approach would have any other issue though, but
> > it seems like it could make sense to explore this approach. In general
> > drivers should cope with their devices being runtime resumed if
> > runtime PM is enabled, right!?
> >
> > If this works, it seems like a generic and a good solution to me.
>
> For PCI ports, though, it would require some tuning of
> ->runtime_resume(), so it is not as simple as it would seem to be in
> the end.

Okay. Perhaps it would be worth it to try this out anyway, as it would
allow us to keep the PM core as simple as possible?

Kind regards
Uffe


Return-Path: <linux-kernel+bounces-547055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1CEA50273
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B661888464
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649724C69D;
	Wed,  5 Mar 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAtL3BUc"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AA24113C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185564; cv=none; b=imkJXIknXggf538gHumlFiJAxP5Pgt3/eWP+UT+nVg8RCDtJUZj2NMxxpWUAUdeItnPOUUHDlhoL+FEpTzfxZaif7LQq0NC4tuFmos2nQ9CWBDPPQnld6woCXNfjsnFMSv+Yt3PrnC5eWEKSF+Clf4Kvc2jFpUlSBLi28j8tgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185564; c=relaxed/simple;
	bh=Q8EVwk/RdVtR+7cca/9HKQShD9VFWugF0+G+Od0NHiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7C5eMfbHpEln0bhBSD2f+CmV6br5RJZv1ymFjFojZdQoldB7dx1/T9yfXNQ1f8JKuy/8e0k3+1Z3hui9C7WQS2CFk2wFch87DxeUKKA8vRxRWgJRVH/vFR7w12Zp5Ex9ixHK9t/7QX1Gz56kYBUv9E95955xcYSy5wHyf+ApfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAtL3BUc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so5837464276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741185561; x=1741790361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FARqH4c3VuakwMcl+bQVVD0q8gZRfwBwOycvP+E3uAU=;
        b=DAtL3BUcXtoWIE+O5KAQ5GX5AEAOHjf6TVyw3TuxIU4Zu4Bv4JazANaS0rtrqJW1sF
         TDSJOHGdDCWhA7dpf0lp/JjhKLVcQrPQN9tynpKPIhAIPjtWwCwxLXP0IzBaGogGhu+/
         7/slWqX0OCYI5jQ2T1E+FQrEX3teUsZy+bSYQUM60O139UlP5JZRWd6Qgoj3OOkm1tHH
         65wcgB1WnTHiK+OBtR8F9qEiczUlBXNr1K3UicGJvqMdsVYOI0xWGiruFkVXFmBGgRtJ
         JLPjxHDZS5RSxm23DcBvlYOzj+oqhgUa7JADe7qHlsTvO4BHddD1r3Yh3wzCyCK0sGjL
         LJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185561; x=1741790361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FARqH4c3VuakwMcl+bQVVD0q8gZRfwBwOycvP+E3uAU=;
        b=P9VREj0WBfes4jrzB1ZpaP3CrSuL57CbRJM0Ip7wxDwW1+OIeoSW6J4NUu7yjJGAOq
         bt8dZaC+uHi6PLMi2Mzz/vK7a7BLtQYgyb9VXJEVPmIh/BVOK/5pGACMuVLlE4o3g7ft
         LclKSUgvVZFIHgKJ4hSPdhtHGzM8HP0j+wH05Jce+t3W1KCIZQ5GoqmJDsK7I20nlUGb
         Jxhs6i6T7t6jbGeg+Z6zQE/ijO6mFOFikknKe/iYIE5MKDgktcam4c7Jp3WWLhcAhT/F
         h6eHnj+LKvk3lgE+76nOwc4VpNcCF9koD8eqm5i9XsaQXeWC78QAhteUEdc92pmPapWw
         ySBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU77gJgsCbgP3Ch0hhQTxbfqRSCYJ6n4jZ/eSFxAMwRsn6jCs1xsZF/2BoK+Ratt4R9HhDkyxad3Ua7Dvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LFSyuxUNwMjoODOImWPYsvu8rp9dun8CX5RlFruv75DuAZtu
	Cx0TaowucVY7D9MTcgePqMg8qu/0ZFjQrQqWGYdrFsPTwi64X/HT3/irA60/84g3fvsW01UlgZa
	N3av6TumS7ftXyJn2xJnzldHKdQj69tn7fVVHew==
X-Gm-Gg: ASbGnctTfB9uFlsnO5222wQYYzKzLeN+dAzbiX3AHfz9bFKCaqLqVkdnFRnPAM0jQKK
	iL6t9GRwyN0JvdE6k+X3A4qir0ELcZpCwHeSY/1YvOUtCnUjEjUKTqQ2HYA2b+28Qf2hCx011Ca
	4jGYcxOH8m11cD4+k5qCazV1bdsqw=
X-Google-Smtp-Source: AGHT+IGxFWKBrtrswW7PmMjdfaPHQhW8zbbgO+/z9D6PCpHJ1NQ7HPKfA2lMgc5p/ObvEkcHD2GUvA9EgRpokB4qo9s=
X-Received: by 2002:a05:690c:8f:b0:6fb:4c11:61cf with SMTP id
 00721157ae682-6fda2f6c858mr46861727b3.19.1741185560985; Wed, 05 Mar 2025
 06:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-pm-debug-v1-1-e5bd815f7ca4@ti.com> <CAPDyKFr+P9oi-ofXOkfoBHSCLaCAREW_efjJ6TctTeo_AVCzDA@mail.gmail.com>
 <20250303095809.x2mmd52znicl7roy@lcpd911>
In-Reply-To: <20250303095809.x2mmd52znicl7roy@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Mar 2025 15:38:45 +0100
X-Gm-Features: AQ5f1JoOG0zuwA2fm-NdaH5A5zyKiFIkaC1fpWTjXskmDe1p18Ve0YXrRybLQfw
Message-ID: <CAPDyKFrfZnO45rhLsRFeiNBCbhTYsM=v2kR0QCHDeVCtgQ0D5Q@mail.gmail.com>
Subject: Re: [PATCH RFC] pmdomain: core: add support for writeble power domain state
To: Dhruva Gole <d-gole@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, vigneshr@ti.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"

+ Sudeep, Cristian

On Mon, 3 Mar 2025 at 10:58, Dhruva Gole <d-gole@ti.com> wrote:
>
> Ulf,
>
> On Feb 28, 2025 at 13:39:44 +0100, Ulf Hansson wrote:
> > On Fri, 21 Feb 2025 at 14:48, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
> > >
> > > Add support for writeable power domain states from debugfs.
> > >
> > > Defining GENPD_ALLOW_WRITE_DEBUGFS will enable writeable pd_state
> > > node in debugfs.
> > >
> > > Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> > > ---
> > > This has turn out to be really helpful when debugging SCMI protocol
> > > for power domain management.
> > >
> > > Reference has been taken from clock framework which provides similar
> > > CLOCK_ALLOW_WRITE_DEBUGFS, which helps to test clocks from debugfs.
> > > ---
> > >  drivers/pmdomain/core.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 77 insertions(+)
> > >
> > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > index 9b2f28b34bb5..6aba0c672da0 100644
> > > --- a/drivers/pmdomain/core.c
> > > +++ b/drivers/pmdomain/core.c
> > > @@ -1298,6 +1298,60 @@ late_initcall_sync(genpd_power_off_unused);
> > >
> > >  #ifdef CONFIG_PM_SLEEP
> > >
> > > +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> > > +/*
> > > + * This can be dangerous, therefore don't provide any real compile time
> > > + * configuration option for this feature.
> > > + * People who want to use this will need to modify the source code directly.
> > > + */
> > > +static int genpd_state_set(void *data, u64 val)
> > > +{
> > > +
> > > +       struct generic_pm_domain *genpd = data;
> > > +       int ret = 0;
> > > +
> > > +       ret = genpd_lock_interruptible(genpd);
> > > +       if (ret)
> > > +               return -ERESTARTSYS;
> > > +
> > > +       if (val == 1) {
> > > +               genpd->power_on(genpd);
> > > +               genpd->status = GENPD_STATE_ON;
> > > +       } else if (val == 0) {
> > > +               genpd->power_off(genpd);
> > > +               genpd->status = GENPD_STATE_OFF;
> > > +       }
> > > +
> > > +       genpd_unlock(genpd);
> > > +       return 0;
> >
> > This makes the behaviour in genpd inconsistent and I am worried about
> > that, even if it's for debugging/development.
> >
> > For example, what if there is a device hooked up to the genpd which
> > requires its PM domain to stay on? And what about child domains?
>
> Thanks for taking a look.
>
> Agreed that there maybe some paths in genpd that this patch maybe
> ignoring and thus could break something fundamental while debugging.
>
> Perhaps we can split this patch up and remove the state_set part till we
> figure out the right way of doing it without breaking genPD
>
> BUT, as I said in my previous response I feel that if one is enabling
> DEBUG config then anyway they are literally aware of the risk that they
> are taking, by exposing raw PD on/off operations from user space.
> Perhaps we can continue our debate on the reply I gave earlier on this
> thread...

Sure!

[...]

> >
> > When working with genpd and SCMI PM domains, a more robust way to
> > debug things would be to implement a slim skeleton driver for a
> > consumer device. In principle it just needs some basic runtime PM
> > support and the corresponding device hooked up to the SCMI PM domain
> > in DT. In this way, we can use the existing sysfs interface for
>
> But this will just be a per-device limited solution right? It still
> won't allow us a generic way of dealing with all possible scmi IDs  without
> having to rebuild the system... Or maybe I am misunderstanding/ missing
> something...
>
> > runtime PM, to control and debug the behaviour of the genpd/SCMI PM
> > domain.
>
> If I were to come from a user's perspective, then they will want to be able
> to get a full view of the system's power status at a glance. Today, I am
> not aware of a way how we can do that from genpd. This makes debugging
> what is _actually_ ON/OFF in the system a bit tricky..

There are debugfs support for genpd. It should give you just this.

>
> Users may not even care much for example about the kernel drivers for
> certain controllers but still want to ensure that those controller's registers are
> accessible to them to use via something like devmem2.
> Another application for the get_status part of this patch is for
> studying the overall power draw of the system by judging which all IDs
> are on/off at a glance.
>
> Hence, if you feel that for now the state_get part of this patch makes
> sense it will still help users query the status of all the pd id's in
> the system.
>
> Thinking of it... What if we modify the existing status_show() itself
> with another column that shows current status similar to runtime status?
> status_show today only does a print based off of genpd->status ... and
> never really goes and queries the firmware again if by any chance some
> other event or activity in the system may have turned ON the device.
>
> For eg. if we have another remote processor request a resource
> but genPD was unaware of this request so it just assumes that resource is still
> off-0... That's just wrong IMO.

I see. So in principle you want a way to ask the SCMI FW about it's
current state - without involving the view Linux/genpd has.

>
> What I am proposing is can we have a get_state callback in genPD which
> would be = something like power_ops->state_get in scmi pmdomains
> today.
> This will help the core pmdomains get an up-to-date view of the system
> in the debugFS. Whether genPD decides to update it's internal
> genpd->status based on the query is another issue.
> But from what it looks like, we definitely have a requirement here to
> make sure pm_genpd_summary shows a true-to life status of the power
> domains. Not just rely on linux runtime pm or assume that linux is the
> only real software who knows and does it all.

Well, I am not sure I agree, but maybe I don't have the complete picture.

To me, this sounds like an SCMI specific debug thing. Don't we have
something like that already?

I have looped in Sudeep and Cristian to comment too.

>
> >
> > I have a bunch of local code/drivers for this already. Even for
> > testing the SCMI perf domain with OPPs. I can share them with you, if
> > you are interested?
>
> Yes, please do share. We would love to see your ideas on this so we can
> come up with a better solutions together.
>

The below is from an old optee tree and its build git. There is a DTS
file added for QEMU in one commit and another commit that adds SCMI
power/perf domains, along with other added test devices for a PM
domain driver and a PM test driver:
git.linaro.org/people/ulf.hansson/optee_build.git qemu_v8_scmi

I have also published my PM test drivers at the git below. One
platform driver adds/manages PM domains. Another one, is a simple
platform driver, that has PM and OPP support along with some debugfs
things that has been useful  for me.
git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git debug_pm

Kind regards
Uffe


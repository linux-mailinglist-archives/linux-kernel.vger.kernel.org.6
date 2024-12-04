Return-Path: <linux-kernel+bounces-430433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B79E30D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA19B284173
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357FF507;
	Wed,  4 Dec 2024 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ky2dgD8H"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1220DF4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276353; cv=none; b=eVjH7+T6izqjYxntUdUUyBtBTtawERatC3ff1t+Kcq+fWd0ipKh7XHOiHFJB+mOGzQf2HNP0yhgGSlh5+bqdN0gG6077RzAsAzji/euOdfgHKHtIjWBWtvQBdwgR7aeCcBeBTZcisyjCu/JNuRRAKrgaIP8r6g1lB9SVppoNvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276353; c=relaxed/simple;
	bh=hygQY0yKQ7ebOPH3ZBiF/8PChlQAh2LojF0r9bBmdmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYLh4wb6ni89C31Ug4x+Gd/1hNnAio0X9LGcziaTYk4yBkZQfDepXZ/c0DsMU5vU1zkzincaL1U3RvBQLblwd2P0nyA7LW7FgbxIblBuKEo0bYllFznaET5N7G08jUXj/ZIZmLbjnrUcchTXUG0DBIQdM6m9i+ot/hY8TBJoleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ky2dgD8H; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so432864e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733276349; x=1733881149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5142+FxMWvJf+y1zYJc4iuIT592XegYtM+E1mlyFIrI=;
        b=Ky2dgD8HjVGlwDF0Zc06Q/ffmu/NySVwfIeGn30+2La9WHr85eIvQF1jqy0d/2AtiW
         7jrugJTVl3J9DTnuUAgV1kpWcqQwVkL125Iwh8HFTPB1DjaDUv7wNz+RtXQ5fkjsRgRq
         Pb1TeqaKJ7pnZtOsrz0HNqwFueDQBaT9rVOz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733276349; x=1733881149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5142+FxMWvJf+y1zYJc4iuIT592XegYtM+E1mlyFIrI=;
        b=H9rXiBEBzh31/VTRiH0/85l+SoqKpTW22O0iJFIzvLAsyjJBFd32d1HX1DiInwZ/Nh
         5TmVU8mHPMjdg52T/Z3uhDtSu7l5JRXRAApVVuudVIS1r4MLxY96vv8B5C+LQE2b2OmG
         /wiMHRHhXS/7AyjvPqZITNNo7kmNTki5SZuqX6pQTmLH+Kc03emn+uWnQf4k20GWJVSI
         mWl2zKbluCAGnTA+VolSFvkaoW7OuCfwk9BJW8QNga5yrPAPrrQE7aBesek/Z3Xs7p7N
         36kGH3ArjcjmvWoDMnsTZ8JKe0q77u3/c3QlkderGZYYwt2AWpasonB771XqwQKM5Xl9
         BULg==
X-Forwarded-Encrypted: i=1; AJvYcCV0sSQhtzTeOGWNDUb9iAkIiMZVe+K4o8FBPi+G98NJAq9Wx9G0+DgvPcQkVotSR7Sax2Cvs4mB48pN3c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2kCzTljTlDI7BWCxoIusL97E+JDYrGBudg5eafwY6UXa+jkP
	+OcreRSGUUdb7bVPtZGLuV9w5CuI2EKZMmIBH4VG1SKuygxzNuv/OK0S0RkZXQTvtrcalRrvXhi
	Ceg==
X-Gm-Gg: ASbGncumAUzGpK8JhtFWIfGFcBoKHvYjKhrs4Dg4t4w6PY9E/Xx/yFyw88fcVhhJjnp
	I3QeOC4dVzb9Dsts0Zwm3WfgsonooFo9wYlePUL+fMrNasx47Hx7RYZqjpOFAFKzD5J+VlMjMjK
	XFCddyQmQAbIdmWTkBtnWqFqLqL6x0NieCphEJ/8mwg6+CF60aQcI93kq3Krscx34PYP4rA6/Sr
	7gZQrqg5MbtDoQRDx7E2Shr36eSHdFHwVJJTJek35y2vxBoDyBkPEISUv0fCBizVBFC9STkcFFM
	2Y9pS5hQk4Z0RA==
X-Google-Smtp-Source: AGHT+IG/CWNveOw84/xTYkBvHnobw5TsGXcciVIYZK3fAQoQZ+nsuW3Mn/+I3L70RYHCb0kj6VpBXA==
X-Received: by 2002:a05:6512:3c8f:b0:53b:1526:3a63 with SMTP id 2adb3069b0e04-53e12a35229mr2963493e87.56.1733276348780;
        Tue, 03 Dec 2024 17:39:08 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1c849090sm78968e87.227.2024.12.03.17.39.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:39:07 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so432854e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:39:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkYVHnu1Yr9erlyHCOvQqo5XsSr6xZVrmxOMaDRhZX8exDRszdUXMScHsbdsSpsSKXfn3FZuxWy1xchDc=@vger.kernel.org
X-Received: by 2002:a05:6512:1256:b0:539:d10b:e38b with SMTP id
 2adb3069b0e04-53e12a2613dmr2674454e87.39.1733276347121; Tue, 03 Dec 2024
 17:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com> <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
In-Reply-To: <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 3 Dec 2024 17:38:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
Message-ID: <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Brian Norris <briannorris@chromium.org>
Cc: Pin-yen Lin <treapking@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 3, 2024 at 3:05=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> Hi,
>
> On Wed, Nov 27, 2024 at 7:44=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> > On Wed, Nov 27, 2024 at 2:58=E2=80=AFAM Pin-yen Lin <treapking@chromium=
.org> wrote:
> > > In commit 52250cbee7f6 ("mwifiex: use timeout variant for
> > > wait_event_interruptible") it was noted that sometimes we seemed
> > > to miss the signal that our host sleep settings took effect. A
> > > 10 second timeout was added to the code to make sure we didn't
> > > hang forever waiting. It appears that this problem still exists
> > > and we hit the timeout sometimes for Chromebooks in the field.
> > >
> > > Recently on ChromeOS we've started setting the DPM watchdog
> > > to trip if full system suspend takes over 10 seconds. Given
> > > the timeout in the original patch, obviously we're hitting
> > > the DPM watchdog before mwifiex gets a chance to timeout.
>
> The Kconfig default is 120 seconds, and it's hidden under
> CONFIG_EXPERT. What makes you think 10 is a good value? (It sounds
> pretty small for triggering panics.) The smallest I can see outside of
> ChromeOS is 12 seconds, although 60 seconds is much more common. I
> also happen to see other WiFi drivers have hit similar problems, but
> they settled on 20 seconds (assuming a 60s timeout on other distros):
> https://lore.kernel.org/linux-wireless/20230329162038.8637-1-kvalo@kernel=
.org/
> https://git.kernel.org/linus/cf5fa3ca0552f1b7ba8490de40700bbfb6979b17
>
> Technically, this Kconfig lets you set a value as small as 1 second. I
> don't think we should work at reducing all timeouts to fit that
> target.
>
> I could maybe approve lowering this one, but I'd also recommend
> reconsidering your timeout value. And more questions below.

That's fair. I guess having a 10 second timeout for full system
suspend didn't seem totally crazy to me. If a system is taking more
than 10 seconds to do a full system suspend then that seems like
something is pretty broken. I guess it's somewhat like the same
argument that the WiFi driver had for picking 10 seconds but applied
to the whole system level, and I guess that's where we get into
trouble. That made me think that even 5 seconds seems a bit long for
any given driver to suspend. ...but yeah, it's squishy.

Maybe the ChromeOS should change to 15 seconds for the DPM Watchdog
timer and that's a better solution and leave the WiFi driver how it
is?

Another thought: I wonder if it's possible to be dynamic and somehow
set the timeout as "max(10, dpm_watchdog_timeout / 2)". Not that I've
checked to see if the mwifiex can actually query the DPM watchdog
timeout... ;-)

...also, it sure seems like if we're going to choose a value so low
that we shouldn't panic. All of our other watchdogs that panic aren't
so short, so probably this one shouldn't be either. Maybe we could
submit a patch to make the DPM watchdog just abort the suspend if
that's not too hard (and if the power people accept it).


> > > While we could increase the DPM watchdog in ChromeOS to avoid
> > > this problem, it's probably better to simply decrease the
> > > timeout. Any time we're waiting several seconds for the
> > > firmware to respond it's likely that the firmware won't ever
> > > respond. With that in mind, decrease the timeout in mwifiex
> > > from 10 seconds to 5 seconds.
> > >
> > > Suggested-by: Doug Anderson <dianders@chromium.org>
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > ---
> > >
> > >  drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I believe Brian Norris is still anointed as the personally nominally
> > in charge of mwifiex upstream (get_maintainer labels him as "odd"
> > fixer, which seems awfully judgemental), so he should be CCed on
> > fixes. Added him.
>
> I tend to see mwifiex patches even if I don't get CC'd, but thanks. I
> wonder why get_maintainer(?) picked up Francesco properly but not me.
> *shrug*
>
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drive=
rs/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > index e06a0622973e..f79589cafe57 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > @@ -545,7 +545,7 @@ int mwifiex_enable_hs(struct mwifiex_adapter *ada=
pter)
> > >
> > >         if (wait_event_interruptible_timeout(adapter->hs_activate_wai=
t_q,
> > >                                              adapter->hs_activate_wai=
t_q_woken,
> > > -                                            (10 * HZ)) <=3D 0) {
> > > +                                            (5 * HZ)) <=3D 0) {
> >
> > Given that I suggested this fix, it should be no surprise:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > Upon sleeping on the idea, the only slight concern I have here is
> > whether we'll trigger this timeout if we try to suspend while WiFi
> > scanning is in progress. I don't have any actual evidence supporting
> > this concern, but I remember many years ago when I used to deal with
> > the WiFi drivers more often there were cases where suspend could be
> > delayed if it happened while a scan was in progress. Maybe/hopefully
> > that's fixed now, but I figured I'd at least bring it up in case it
> > tickled anything in someone's mind...
>
> Scans should essentially have been canceled by now, but IIUC, the
> driver doesn't really force the card to stop if it's in the middle of
> a scan (I'm not 100% sure if it's possible). So it's possible that
> pending scans could delay this step.
>
> I wonder what the distribution of (successful) timing is today. I'd
> assume this typically take on the order of milliseconds, but do we
> commonly see outliers? What if a system is fully loaded while
> suspending?

I would hope this doesn't affect things from the DPM watchdog, but I
haven't researched. Hopefully the DPM watchdog starts after userspace
is frozen so the system being fully loaded shouldn't matter?

Things I could believe mattering are things like:

* If memory is full and something in the suspend patch allocates a big
chunk of memory then maybe (??) that could slow things down?

* If lots of USB devices are connected that could slow things down.

* If there are a large number of WiFi networks or APs or Bluetooth
devices I could believe that could cause suspend problems.


>  Can you try testing (and gather timing numbers) when
> suspending soon after initiating scans? It's hard to judge what the
> lower limit of this timeout should really be without any numbers, just
> like it's hard to judge whether your 10 second watchdog is reasonable.

Pin-yen: is this something you could gather?


> Also, for the record, since we might have to field regression reports
> for other systems: what hardware (chip variant, FW version) are you
> seeing problems on?

Pin-yen: I'm assuming you'll provide this.

-Doug


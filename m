Return-Path: <linux-kernel+bounces-383753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23A9B1FD6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C404281378
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0555174EE4;
	Sun, 27 Oct 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0GALc0b"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9941DFE8;
	Sun, 27 Oct 2024 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730056223; cv=none; b=tVFquNRqV9niGwh6ltrxcm8B7QgWksdKO7H2KINwRqdFmKIdoeSi/rNvnZb/tjDU7N6KvDiwfeSLHSUvaTCrbkAirAbPGu5OcQKkxbyFt/7AkX8AsbKRhAQ/+FJQ8O09nlmpYPX6ggY0CUOBRXlNDoBGeIe36o3Oe9cZgYnyNNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730056223; c=relaxed/simple;
	bh=4EX4EEa36vKMQUHCe6nAMbxnToUD+i5IdQA+kQF8bhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiCEn2GuyTOwrVl5QaoEGUz1y59yVjl7rcJAfI37BkDccJGD7pXwazMnxzMwnNPrrSyg+CiqhVZldbnfSjWRvII11vcS4pEeVX+fueWKWEGD4WZgZQuwjjVuiEp7UgW3z4GxiQv/fsNA5VikrdsmLVhMoKKq+/k9Rag/OorUSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0GALc0b; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb97afcec9so24280066d6.2;
        Sun, 27 Oct 2024 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730056220; x=1730661020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqdDm/i5lvd7jJxbn7EBNh5JPItu9vVJWBakKKnAF44=;
        b=b0GALc0buH6anuQwtdYJepYlxq+8Nb/WULzGHAZJIIV1lUy5NFwiOK4yfHNygEVNBX
         swKOhPIqgpq0eWmCPc6PTbZWXkhK7qrHl4G9yihnE/cb0tujt3OceLKgXJ3Og8jJT3zd
         k+2I20xQxR+8bBMpZ9d8XoK0qa9oDvwozAsQcP/9kCjk9ZR6l/8JvPhw+7DlH7xD+Od7
         5KPTkspQkMZjqioFgKaRdw2zlY7wt1T20RDvaFEL2xDun6D4eLdMP1PTf7zZob//t2ps
         DNVRlzgBk3Q8l4omniTdlwDZ8QibXlNP/ZzuNlbOZl6WN0lPOmsH5MBz9ZqiDMxm0uAg
         yHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730056220; x=1730661020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqdDm/i5lvd7jJxbn7EBNh5JPItu9vVJWBakKKnAF44=;
        b=q466Mv1Le2pIbyDkzGfAT0IsqIRc8SmJTILhYd1uhpxySGYPvzHMua1TKBHb61JBIn
         CEXqRKp8Dd/zzsxk2MWv5AJxMl/ZfHSePhZOfIeT1S4vRQIi9PTOu/ORgVfAsKYNdiY3
         kHpuvdsHiTx7IhIeDClod9kg4mY7XMqGjPBHX7GnBMAoV5OYId3cHXFbm9bi+a8CPNWl
         GTi28zBIQ3pE/BUhL0xqokJPYUYrXfBcgomJjCgA+IdVLbSKXd9f6cjK3y+OwfLWM/Ga
         8CBpr6ZqKAe6EVfFrOhVXr92Jgwux4Cwe9iH7hAnKQusLyWetdlmvVepljHJ6/J3VROa
         iFMw==
X-Forwarded-Encrypted: i=1; AJvYcCW7+ZosA2REKb7wNBGQohYWqpAhi7xtxsxpSzMZ6pBozyIu+0ytjU4yCIGlqZnSt9nd2+hogjVJZQN1d2P7@vger.kernel.org, AJvYcCXAM+I0Pp4+XK9Zv11K59WSr3hARWLCFlAjheCOoEhaAykJNdiUqL/YM+azM6C1siYFsnAaYVEvJBrOIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ki/iOhBQTVKMhUc9vyi07XdRttIFyzIOYNEl7binpJ7s6uGP
	84LfDROBbbiWOm7t3mRwRSUNqY3zefFAFAxfPi0nQtgYOHFusAwOUYR4aWpC9piNCwmGlSumFyQ
	pVQ9zpmFjBt8gSWocpeE639tWO8s=
X-Google-Smtp-Source: AGHT+IFKS/M7T/Z2iII2ira3RjRR33Yao0/tDdyX85cfvC7P47gKLONDA9Tjxwe+DmC5NBMh/6VEaq0eZegy7AXK+1E=
X-Received: by 2002:a05:6214:588b:b0:6cc:1f0:d382 with SMTP id
 6a1803df08f44-6d185672a8amr90243596d6.8.1730056218276; Sun, 27 Oct 2024
 12:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027174836.8588-1-derekjohn.clark@gmail.com>
 <24dc65c2-b6c9-4909-a784-fb81d9299f1c@roeck-us.net> <CAFqHKTmEauJ4RQUrn6pjX-hgLGZLNE8gaD5S41Uy0L0cNB4+mA@mail.gmail.com>
 <715afccb-56a5-4e8a-b7fd-e6151f241535@roeck-us.net>
In-Reply-To: <715afccb-56a5-4e8a-b7fd-e6151f241535@roeck-us.net>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sun, 27 Oct 2024 12:10:07 -0700
Message-ID: <CAFqHKTmhfYOAu9t6oZBQqQ1227Ot=Q4G_13-FHb=DmvACB+Xqg@mail.gmail.com>
Subject: Re: [RFC] hwmon: pwm_enable clarification
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Cryolita PukNgae <cryolitia@gmail.com>, linux-hwmon@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 11:59=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 10/27/24 11:29, Derek John Clark wrote:
> > On Sun, Oct 27, 2024 at 11:16=E2=80=AFAM Guenter Roeck <linux@roeck-us.=
net> wrote:
> >>
> >> On 10/27/24 10:48, Derek J. Clark wrote:
> >>> Greetings all,
> >>>
> >>> I am working with Cryolita to fix up the GPD driver she submitted rec=
ently:
> >>> https://lore.kernel.org/all/20240718-gpd_fan-v4-0-116e5431a9fe@gmail.=
com/
> >>>
> >>> We are currently having a discussion about the meaning of this part o=
f the
> >>> documentation and are seeking some guidance from upstream.
> >>>   >> pwm[1-*]_enable
> >>>>               Fan speed control method:
> >>>>               0: no fan speed control (i.e. fan at full speed)
> >>>>               1: manual fan speed control enabled (using pwm[1-*])
> >>>>               2+: automatic fan speed control enabled
> >>>>               Check individual chip documentation files for automati=
c mode
> >>>>               details.
> >>>>               RW
> >>>
> >>> In oxp-sensors we took 0 to mean "no kernel control" so a setting of =
0 is
> >>> technically "automatic" but fully controlled by the hardware with no
> >>> interaction from the driver. In her original driver draft she had tak=
en this
> >>
> >> That is wrong. It should be (or have been) 2 or higher. Ah yes, I can =
see that
> >> the code sets fan control to automatic when oxp_pwm_disable() is calle=
d.
> >> Again, that is wrong. Congratulations to the submitters, you sneaked t=
hat by
> >> my review. That doesn't make it better. It is still wrong, and I call =
it "sneaky"
> >> because the function is not called "oxp_pwm_automatic()" or similar, i=
t is
> >> called "oxp_pwm_disable(). Setting fan control to automatic does not d=
isable
> >> fan control.
> >>
> >> My bad, I should have paid closer attention, and/or maybe not have tru=
sted
> >> the submitters as much as I did. I guess I'll have to pay closer atten=
tion
> >> in the future.
> >>
> >>> literally to have the driver set the fan speed to 100% on this settin=
g rather
> >>> then give back control to the hardware. My question is simply what is=
 the
> >>> correct interpretation here? Ideally I would like to see this interfa=
ce match
> >>
> >> It seems to me that the above text is well defined.
> >>
> >>> as existing userspace software is expecting 0 as hardware controlled =
and 1 as
> >>> manually controlled, but we also want to ensure this is correct befor=
e we
> >>> submit a v5.
> >>>
> >>
> >> Any such userspace expectations are simply wrong. The ABI definition i=
s above
> >> and, again, it is well defined.
> >>
> >>          0: no fan speed control (i.e. fan at full speed)
> >>
> >> I don't really see any ambiguity in this text. This isn't about kernel=
 control,
> >> it is an absolute statement. There is no "kernel" in "no fan speed con=
trol".
> >> "fan at full speed" should make this even more obvious.
> >>
> >> Guenter
> >
> > Guenter,
> >
> > I'll keep this in mind in the future, and I will send a patch soon to f=
ix the
> > oxp_sensors driver. One final question, is a "0" setting mandatory?
> >
>
> No, if the hardware can not support it it doesn't make sense to mandate i=
t.
> If the hardware does not support disabling fan control, one option would =
be to
> set it to manual and set the fan speed to 100%, but that isn't mandatory.

Okay, thanks for the insight.

> Note though that people can now argue that fixing the driver would be an =
ABI
> violation in itself, because after all there is some userspace code which=
 assumes
> that setting pwm_enable to 0 fro this driver would enable automatic mode =
(while
> other more generic applications reasonably expect fan control to be disab=
led if
> the value is set to 0). In other words, fixing one ABI violation creates =
another.
> That is why I am really unhappy about this.
>
> Guenter

Understandable, and I apologize for not understanding during the initial dr=
iver
development. Joaqu=C3=ADn maintains the most prominent userspace applicatio=
n to use
this interface and I'm in contact with the two other developers who
use it as well.
We can certainly correct this oversight and get everyone on-board with
the correct
ABI, unless you prefer we keep it as is.

Derek


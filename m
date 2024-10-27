Return-Path: <linux-kernel+bounces-383739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14669B1FB5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03A12817F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1217BB35;
	Sun, 27 Oct 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3L3sDLE"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4416ABC6;
	Sun, 27 Oct 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730053798; cv=none; b=OIP4LsvzmU28PLASXnsOP3Qvyq+UgxOIGW7qNZ8lzdFCfek/3wQilJ9bn0O5liztafSSOaUweZ1r2mu8PZw88IcXsZfvCv13Y1AmeX/AcQjnZk+V7i1tho1uwtcLRUJge0FsOes9mGSWiXJPcocUV54qu/GvNlIfNsaRdAKjqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730053798; c=relaxed/simple;
	bh=RWPvgK6oqORIrZGEDDkmHoNUXpJG2FxwoWGO0fiGPR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnKds8Qshk9RV5EEa0UaV8pGGfOb2jq8KulSjEk3tE8OCrdslChOLB2aQIq67RKAnXFhRn/3TLULXNDASjZjRenTsknqv7wJUXnwbT/k+g6THSkDA7GKNIQJcAm3Ec191VW3Tmn3DBwbrqmp2sISFIuJPE9F31cHyaynZus6lIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3L3sDLE; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso18075066d6.1;
        Sun, 27 Oct 2024 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730053795; x=1730658595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylECE2zEuNqtiXNvplMAJctSOQtfxMBeffxsBMJW/LE=;
        b=G3L3sDLEsy8W1XITqeiDcIYt6KdtrpzC/3yYKyWWYpEHy4p5wAXLku53NRK13zjM+1
         CwP/TNMyvEr9LdLdKnu50JmxXRBD5xqCeS72ilho9xWwdbJCytUwSZdU7Dv5buqjHEIZ
         oeZOSzMsviROnmoNOuMZKGXUd+4MjE7B1WKuH78eM0fjbIc5MwbvHJq04+McyS0PYLIn
         JwQ2XNQC0o4gAigAz6lgIV1tloBGeWp5ZUs4LWJcjFFPxrckWlrtXQ6BPPpZvVHo2RVs
         BqGoRlHcatqZODhOoKvq/4ba9QfJduF92D7mnSQHkLD4GIIdS0Fni2ob1OgqSn7PJ1iZ
         8w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730053795; x=1730658595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylECE2zEuNqtiXNvplMAJctSOQtfxMBeffxsBMJW/LE=;
        b=sHDermCgbruk9XXUv0/vsTJblCncrl2KhfXvu6yGmAKR6nf7icdLpznEz49K+BAD76
         FLKsGe6tkJcSlZ1GzWx94GGMHQ94u+E8VMvH06woltd2dUaEbSzqMjuoImVIuLUMV92C
         KKSc99e75N+QEoF7S1Xbb795muJuEZDmaro5gOKvjHDEgbLoXdnyQB368iPgEhIQvgYC
         hPq8DSSw9teodEP1He9Ai8UuQ9UUKaetbzezqWJ9IuygcxlCaPRR7rS4Bip0FrXThNGL
         J3EJvVnK6spzu5tz+gwO0jYxo1TbHSToFRep+I3Vh0Q9CU6QZOuOWvuhVzHCxeYd6yR3
         rGjA==
X-Forwarded-Encrypted: i=1; AJvYcCUzOY5u70SL2AJwAfXCtJoUCDQVaxSpWks7sn1yDqy/kI57Zu2M3JDr6I8QZ3cSLAa4MedXe0p10Oiy0g==@vger.kernel.org, AJvYcCWflKefv1I5nU/BpvYtrxAnwwC4N7rSHJWBCe4najfnkrEaG9Apy/9oqYXQXHOyjGjJNKtiXoVIhY7N3eEz@vger.kernel.org
X-Gm-Message-State: AOJu0YxciPSG+LdtCVI3I9QOX9OdW6B2ONOPAlxwCUY0k77zJqARM7J2
	zpa5tAlc+SGh5Nj5tYYrQztfpeVTp0ZIRTT60qGsuNgSQFSjhSvLJKNsHYrMlIXqL6qqX1Iupfc
	cryCfqpF6mSfl9Rcal5h4UXNPs9dEXPSP1hY=
X-Google-Smtp-Source: AGHT+IFLaSlEeUs3VzjQt9tbbFlo4sUAXdSeMbM5hLfsCWvUNXkYs4aURay4tubeXysw/BKUsLHhB+xCgDye14JL5PQ=
X-Received: by 2002:a05:6214:3186:b0:6cc:3a:a7f0 with SMTP id
 6a1803df08f44-6d185857230mr118923196d6.44.1730053794188; Sun, 27 Oct 2024
 11:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027174836.8588-1-derekjohn.clark@gmail.com> <24dc65c2-b6c9-4909-a784-fb81d9299f1c@roeck-us.net>
In-Reply-To: <24dc65c2-b6c9-4909-a784-fb81d9299f1c@roeck-us.net>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sun, 27 Oct 2024 11:29:43 -0700
Message-ID: <CAFqHKTmEauJ4RQUrn6pjX-hgLGZLNE8gaD5S41Uy0L0cNB4+mA@mail.gmail.com>
Subject: Re: [RFC] hwmon: pwm_enable clarification
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Cryolita PukNgae <cryolitia@gmail.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 11:16=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 10/27/24 10:48, Derek J. Clark wrote:
> > Greetings all,
> >
> > I am working with Cryolita to fix up the GPD driver she submitted recen=
tly:
> > https://lore.kernel.org/all/20240718-gpd_fan-v4-0-116e5431a9fe@gmail.co=
m/
> >
> > We are currently having a discussion about the meaning of this part of =
the
> > documentation and are seeking some guidance from upstream.
> >  >> pwm[1-*]_enable
> >>              Fan speed control method:
> >>              0: no fan speed control (i.e. fan at full speed)
> >>              1: manual fan speed control enabled (using pwm[1-*])
> >>              2+: automatic fan speed control enabled
> >>              Check individual chip documentation files for automatic m=
ode
> >>              details.
> >>              RW
> >
> > In oxp-sensors we took 0 to mean "no kernel control" so a setting of 0 =
is
> > technically "automatic" but fully controlled by the hardware with no
> > interaction from the driver. In her original driver draft she had taken=
 this
>
> That is wrong. It should be (or have been) 2 or higher. Ah yes, I can see=
 that
> the code sets fan control to automatic when oxp_pwm_disable() is called.
> Again, that is wrong. Congratulations to the submitters, you sneaked that=
 by
> my review. That doesn't make it better. It is still wrong, and I call it =
"sneaky"
> because the function is not called "oxp_pwm_automatic()" or similar, it i=
s
> called "oxp_pwm_disable(). Setting fan control to automatic does not disa=
ble
> fan control.
>
> My bad, I should have paid closer attention, and/or maybe not have truste=
d
> the submitters as much as I did. I guess I'll have to pay closer attentio=
n
> in the future.
>
> > literally to have the driver set the fan speed to 100% on this setting =
rather
> > then give back control to the hardware. My question is simply what is t=
he
> > correct interpretation here? Ideally I would like to see this interface=
 match
>
> It seems to me that the above text is well defined.
>
> > as existing userspace software is expecting 0 as hardware controlled an=
d 1 as
> > manually controlled, but we also want to ensure this is correct before =
we
> > submit a v5.
> >
>
> Any such userspace expectations are simply wrong. The ABI definition is a=
bove
> and, again, it is well defined.
>
>         0: no fan speed control (i.e. fan at full speed)
>
> I don't really see any ambiguity in this text. This isn't about kernel co=
ntrol,
> it is an absolute statement. There is no "kernel" in "no fan speed contro=
l".
> "fan at full speed" should make this even more obvious.
>
> Guenter

Guenter,

I'll keep this in mind in the future, and I will send a patch soon to fix t=
he
oxp_sensors driver. One final question, is a "0" setting mandatory?

Thanks for the quick reply.

Derek


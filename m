Return-Path: <linux-kernel+bounces-573768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECFDA6DBFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6485F3AE72E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824719C569;
	Mon, 24 Mar 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORr2+tuV"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64212FC0A;
	Mon, 24 Mar 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824092; cv=none; b=EcbUVI9xnvI/CNhWW+7/Fzvl2o7qry7No5CFBt1qXXXToSDjtbkvkOVPcU1VDJlZS5Zq3o4QB3NjBlxPojqgTGNBWLXrnwpbcIoiAoPQ7MbatIpAi3wg98aLM/eS+RFJ5SX0PDIoZdLwvT9CF722tvUOOgPADsI6NFQwpZVmLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824092; c=relaxed/simple;
	bh=xlJYEsG/YxZpSX5fkvrHQUPL6adkhPa0PcpWMKkszuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BY3vazZwKRFGukLi7ArFmIjlw+nuF0Ok+95XsY7SFVl/rpjzphflsQaT7fkyQr3VYgWtU7D8W7LAkefrbj6zn+wzHXq03lj+YsBUXQawnOi76CCmpVt/OW0Vm1BjvH69atr1Q3QrRYglfL5WH8Uv3wZubiRLZr7VQEUZ8zwM8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORr2+tuV; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c1c4e364c8so1490933fac.1;
        Mon, 24 Mar 2025 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742824089; x=1743428889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8qRncFe1dnLfI3S8hPEYswLDq6RLhZSuYf8HCQ7pgs=;
        b=ORr2+tuVkLB8r5wa5nxva/NujK1qGWKYT+ghk9CjaXYTJbMBMzaIN8K2PrKoqKwaev
         o2a3fDbmcAoymHVCazcTGZnYEUJLdGvDVESFHY0xDAwdKCGYoRhIMvW3y/9eMSjmkhLh
         gBHuXvgZz7x5fecuUxCV455JkXQ72f/sl7hahCKDDBJOe4LZrYuzRgdFkG12SE8wUE4B
         Zd8/yCxgP0CIOs7Cr6Yov7k4HL+2RFqESxKJZUghl6hD+4Ww2OIbCO8YrVwl2erUG6pr
         ml0yQAnMvynAhxiR5pUWX9v9Per3ulA/UoOiAncHhSoohZ3PBd/FsMPrMu3M1oaQXFDt
         cg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824089; x=1743428889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8qRncFe1dnLfI3S8hPEYswLDq6RLhZSuYf8HCQ7pgs=;
        b=O3w4Yu4c3rWVTkwrNEx1HCLu03gwufTBBAMB6cTTtiumpuiLCAvlPEicrpDBI58v7m
         MRL0bBWj9nOIEcuyIM0UJv+fKNZcUmmTperoFJRDA+QsqKFXrrxCtR1S3lKQ7Ego3fxV
         Edee9iyj6dO4yCRy7ZG5wwCXEtoS8bv6rgl34/+QW2H7sgNTfadRkevm/zeT5xHJT3Vq
         C7irsrgkc83NMMC94MHcEvWi4SMdVl43f3w3nQgRZpQGLkJQ4e+1XU5ZWGRI6ysFnL0A
         LQSsdE0dtlYumh3d+i5jRyrsp1kgEFO99HeO1oVcc39Tv4F8DpB3ay3mndzBh8UXAtMW
         mPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIGbsue72rsiuwYNAVx6q7XNtJXiJ76NYulF71phCdSSy74r4zwIZwVZB0jS7C/RYkLIH44tQZsOEd//Y=@vger.kernel.org, AJvYcCXngYWDj64pf+v0nSUUDn+F8UVvcNTCtiDu0Y2O3zNwnI2l8sjlulZVtv9sVz0Z7aeNaUn/P650DhTmmhBJOsSuhkPjgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Fkdh8fLUfz0Vybw5y1EWqS4tls5cjZWcjZtVcvh7YOXH3VQz
	4irPs2Upqv6/QussHAg9cJQMefgJIOl8StpCOKAJ9ORfi5z39PzBtb2eHiq5qeuDV4039KPa56l
	sQsyHSF7Ep+8/XO/O+xo4kfihQc0=
X-Gm-Gg: ASbGncu1QBDnfn8tT41GiuLe1Eu8uwjn91bRtyijucsGBdkNcW9T573Hbr1A2HCKwtH
	Bug1nKpVkUKF+oeceMrEmMLerbZfINdqEvw3wYSMIgdYrj0rhvBubNofCe/VI26Oo4R5HSArzr2
	XjT2D4xaAC1P0Y5CQbiG+wYMFdh/EX/pCidPmq5A==
X-Google-Smtp-Source: AGHT+IFIZFQN+bdrDeNdd5pkzb/e6pLvUv+qITaW+VrDqM52pDdwBLl2nhWweBesXNrc1E9qJUYut0xwTq4ZknWRNiA=
X-Received: by 2002:a05:6871:2309:b0:2b1:db0e:e22d with SMTP id
 586e51a60fabf-2c7606453fdmr11163028fac.0.1742824089067; Mon, 24 Mar 2025
 06:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321083003.84661-1-gasper.nemgar@gmail.com>
 <ce934c71-2220-c8f9-ff3a-5633360a8935@linux.intel.com> <CAKi4K-jVGw58nbxdWKizaNJRzPc3izE9ipZUOwUq=v-hAAjd8w@mail.gmail.com>
 <35969669-48b6-469e-9cd2-26929fb33e5f@redhat.com>
In-Reply-To: <35969669-48b6-469e-9cd2-26929fb33e5f@redhat.com>
From: =?UTF-8?Q?Ga=C5=A1per_Nemgar?= <gasper.nemgar@gmail.com>
Date: Mon, 24 Mar 2025 14:47:42 +0100
X-Gm-Features: AQ5f1Jq7Tdh_8RKZ9lznJjZOQ1vjW2CzTC94xLd-UFf7LVANbU2QzwIpbmHANDE
Message-ID: <CAKi4K-i809rcJqZTiRejG6c5Vu7OeFMEri42jBgOOpagcx-bWA@mail.gmail.com>
Subject: Re: [PATCH] Added support for a some new buttons in ideapad-laptop
 driver Added entries to unsuported wmi codes in ideapad_keymap[] and one
 check in wmi_nofify in order to get wmi code 0x13d to trigger platform_profile_cycle
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	ikepanhc@gmail.com, LKML <linux-kernel@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
noted. About the performance button, under windows id does toggle the
performance mode, I would much rather have a assignable key, but will
bind it to platform_profile_cycle().
Thanks,
Ga=C5=A1per

On Mon, 24 Mar 2025 at 13:23, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 21-Mar-25 15:47, Ga=C5=A1per Nemgar wrote:
> > Hello, yes I have noticed it messed up the title and will change it,
>
>
> > I just have a question about the performance button aka WMI code 0x13d,=
 is it smart to hardwire it into platorm_profile_cycle() or is it better to=
 leave it as KEY_PROG4 keycode. Thanks
>
> That depends on what the key does under Windows, if it cycles through per=
formance
> settings under Windows then calling platorm_profile_cycle() is the right =
thing to do.
>
> If it opens some sort of performance settings dialog / Windows then a fre=
e KEY_PROG#
> would be better.
>
> Regards,
>
> Hans
>
>
>
> >
> >
> > On Fri, 21 Mar 2025 at 15:17, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.i=
ntel.com <mailto:ilpo.jarvinen@linux.intel.com>> wrote:
> >
> >     On Fri, 21 Mar 2025, Ga=C5=A1per Nemgar wrote:
> >
> >     Hi Gasper,
> >
> >     Thanks for the patch. I think the changelog text got messed up duri=
ng send
> >     as it should here, not in the subject.
> >
> >     Also please change "Added support" to "Add support", add the correc=
t
> >     prefix into the shortlog (the line in Subject), and add parenthesis=
 after
> >     functions in the description.
> >
> >     --
> >      i.
> >
> >     > Signed-off-by: Ga=C5=A1per Nemgar <gasper.nemgar@gmail.com <mailt=
o:gasper.nemgar@gmail.com>>"
> >     > ---
> >     >  drivers/platform/x86/ideapad-laptop.c | 16 ++++++++++++++++
> >     >  1 file changed, 16 insertions(+)
> >     >
> >     > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/plat=
form/x86/ideapad-laptop.c
> >     > index 30bd366d7..a03377d87 100644
> >     > --- a/drivers/platform/x86/ideapad-laptop.c
> >     > +++ b/drivers/platform/x86/ideapad-laptop.c
> >     > @@ -1308,6 +1308,16 @@ static const struct key_entry ideapad_keym=
ap[] =3D {
> >     >       /* Specific to some newer models */
> >     >       { KE_KEY,       0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
> >     >       { KE_KEY,       0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> >     > +     /* Star- (User Asignable Key) */
> >     > +     { KE_KEY,       0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
> >     > +     /* Eye */
> >     > +     { KE_KEY,       0x45 | IDEAPAD_WMI_KEY, { KEY_BRIGHTNESS_CY=
CLE } },
> >     > +     /* Performance toggle also Fn+Q */
> >     > +     { KE_KEY,       0x3d | IDEAPAD_WMI_KEY, { KEY_PROG4 } },
> >     > +     /* shift + prtsc */
> >     > +     { KE_KEY,   0x2d | IDEAPAD_WMI_KEY, { KEY_CUT } },
> >     > +     { KE_KEY,   0x29 | IDEAPAD_WMI_KEY, { KEY_TOUCHPAD_TOGGLE }=
 },
> >     > +     { KE_KEY,   0x2a | IDEAPAD_WMI_KEY, { KEY_ROOT_MENU } },
> >     >
> >     >       { KE_END },
> >     >  };
> >     > @@ -2093,6 +2103,12 @@ static void ideapad_wmi_notify(struct wmi_=
device *wdev, union acpi_object *data)
> >     >
> >     >               dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
> >     >                       data->integer.value);
> >     > +
> >     > +             /* performance button triggered by  ...  */
> >     > +             if ((data->integer.value | IDEAPAD_WMI_KEY) =3D=3D =
0x13d ) {
> >     > +                     platform_profile_cycle();
> >     > +                     break;
> >     > +             }
> >     >
> >     >               /* 0x02 FnLock, 0x03 Esc */
> >     >               if (data->integer.value =3D=3D 0x02 || data->intege=
r.value =3D=3D 0x03)
> >     >
> >
>


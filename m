Return-Path: <linux-kernel+bounces-281147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F97194D3A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1201F2284F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5C1991A0;
	Fri,  9 Aug 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DuQ5IuJH"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322D198A2F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217750; cv=none; b=Rsr0aNOoXW+4Y6QVuGo0cAylUBmGBmGAg7XCCN9wpnDc3MBEjzzL865Fux+yeMfX+/BqoCiMtDUzW30b/Vy9Wij9p4pEQJocM8PQmAPGdYbCZmF1J2wiXIuusnqrMqlLbSanYIzoWnsJtJj48Tx1Cn7uMISSr26+h3j2WbfVYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217750; c=relaxed/simple;
	bh=2zaes7dlxzr8VPPiWIrdjQxXoXhnSxRDw7ZXoUBzE3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWr9ul486S20M4TNMPnZoR6P1DNQqmovzBmcVz94/Esaur425aY/Q1Xq+fqHno/CUKaYPYMLPJCGDHAKOMRHJRGfkcrqZbIfHyc29MoOiZ02Puuz5driJUp914aSeLLZdfnj+YEVTU7dIePUhb6mfPvaSSTCUyACu/oWUR6uGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DuQ5IuJH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01993090so2907277e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723217747; x=1723822547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXhBdpwBP8GmKyUdFL62uektdxESo1EGHQabF0x3TRU=;
        b=DuQ5IuJH2/t/rKksvjpv/zqOZ8NQkYK+RVK+ir99n0VVUug+qOfoiGzAl+uAcx3QYW
         Je2dyuzHeDs88junosrqVX7CI4mrR+jIES/DBvtMQ+FJS9JjS5lKY2A7YYhF3Ma9LoYW
         QDC7gCKPpmwvdPDp2mPlD3u6J4ne7QjPsYqQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217747; x=1723822547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXhBdpwBP8GmKyUdFL62uektdxESo1EGHQabF0x3TRU=;
        b=v49LUn+oc0d368yQ6AdbSTb19VvO/5x6IDH3r0jXW77/iQA/xIlcJNrPzGw/S2Lffj
         J1dxDg0CpZyofGcrnbqZ4Ehz1mTk6xGdL02aVY/Lk4dZInT43Mpw3Nd3TLt6VAXmOoJ/
         /cPtar4K/q0U/d2L2DgIAeLzYRdmFH+7Ia1YE5svgXbSIq2eIWkQfnXxItexETgvnkBJ
         YzCPRl+0H6Jx/pNkbMGwbtjvWgw210HkjdkxrlrXkbj2Tb8A3L8Ebvbp7FfZDrYZE8Lz
         dCENTIJlA22AW0g3OP2XtK6mp1+eCXFS3nBqbaaKgAPM3VtOd52OEtlMhwAHrWTqk+mZ
         hufQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuQ+oobxx5GH/JuywS14g7iE0meaC4dtlu/2Dkt5hGFmq+v0hdQHX3SdvxZi/zEn8rt6t6Y+lolF3mmuSSiE9JyNHo15ecQqMldYl8
X-Gm-Message-State: AOJu0YyakihqtfYXlUQ1quybky0u/b7MokisxMmy8GuRHcVMMkFVnIZV
	IQnQyYD105qoAJFEQZfqGOshbnTedJdaPCoIPU0sqZgj4b/3voxsJdtdSjQiVTckKOPxyCqQ97Y
	kx9PFM1AzltSlIv4j4rY2d2RYOM6WSAPC7+sj
X-Google-Smtp-Source: AGHT+IHXVFVjsZCHJpXcoZGG1494+V3zMv+IYTXYiftaTTTYA0Ky62ohy8iO+a2GzswEpBp6c1vS5ljZBlu/8Zduv4I=
X-Received: by 2002:a05:6512:2312:b0:52e:a60e:3a08 with SMTP id
 2adb3069b0e04-530ee981982mr1529347e87.11.1723217746903; Fri, 09 Aug 2024
 08:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
 <ZcKs589qYxviC1J4@google.com> <CALNJtpV0KsOusPQeGv8bQ3jKy2sUj+k=mPHc172f+vMaTDYPfg@mail.gmail.com>
 <ZcZ2oG1Rls-oR593@google.com> <CALNJtpWNbSZdpxky9hTiSRsaGgLDUnM66QGEy213d3Lhra0hsw@mail.gmail.com>
 <ZeDLq9gPs5InBmdK@google.com> <CALNJtpWwhen2H9OT1-rZ4bt+huwXPOPz6qVDJ5g+emE1wRSLsw@mail.gmail.com>
 <ZeoHcH59Qsiv90b-@google.com> <b9f08bfb-4c1c-4d1b-9061-8a4b1013497d@redhat.com>
 <ZrEDOnxYzbJpC-pH@google.com>
In-Reply-To: <ZrEDOnxYzbJpC-pH@google.com>
From: Jonathan Denose <jdenose@chromium.org>
Date: Fri, 9 Aug 2024 10:35:35 -0500
Message-ID: <CALNJtpUmb70zJnMfk4V6kTAhBEdzjZEch-CbRUojt26WmQFPvQ@mail.gmail.com>
Subject: Re: [PATCH] Input: psmouse - add resync_on_resume dmi check
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	jefferymiller@google.com, Jonathan Denose <jdenose@google.com>, 
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org, 
	Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Hans and Dmitry,

Yes, as Dmitry described that's the issue that I was seeing but it was
on a Lenovo N24 and not an Ideapad Z570.

On Mon, Aug 5, 2024 at 11:52=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Hans,
>
> On Mon, Aug 05, 2024 at 04:18:57PM +0200, Hans de Goede wrote:
> > Hi Dmitry,
> >
> > On 3/7/24 7:29 PM, Dmitry Torokhov wrote:
> > > On Mon, Mar 04, 2024 at 11:17:31AM -0600, Jonathan Denose wrote:
> > >> I disabled the ideapad driver by rebuilding the kernel without the
> > >> ideapad_laptop module. That does fix the suspend/resume issue!
> > >>
> > >> Attached are the logs. Is there a way to make this permanent?
> > >>
> > >> On Thu, Feb 29, 2024 at 12:23=E2=80=AFPM Dmitry Torokhov
> > >> <dmitry.torokhov@gmail.com> wrote:
> > >>>
> > >>> On Mon, Feb 12, 2024 at 02:57:08PM -0600, Jonathan Denose wrote:
> > >>> ...
> > >>>> [   50.241235] ideapad_acpi VPC2004:00: PM: calling acpi_subsys_re=
sume+0x0/0x5d @ 4492, parent: PNP0C09:00
> > >>>> [   50.242055] snd_hda_intel 0000:00:0e.0: PM: pci_pm_resume+0x0/0=
xed returned 0 after 13511 usecs
> > >>>> [   50.242120] snd_hda_codec_realtek hdaudioC0D0: PM: calling hda_=
codec_pm_resume+0x0/0x19 [snd_hda_codec] @ 4518, parent: 0000:00:0e.0
> > >>>> [   50.247406] i8042: [49434] a8 -> i8042 (command)
> > >>>> [   50.247468] ideapad_acpi VPC2004:00: PM: acpi_subsys_resume+0x0=
/0x5d returned 0 after 6220 usecs
> > >>> ...
> > >>>> [   50.247883] i8042 kbd 00:01: PM: calling pnp_bus_resume+0x0/0x9=
d @ 4492, parent: pnp0
> > >>>> [   50.247894] i8042 kbd 00:01: PM: pnp_bus_resume+0x0/0x9d return=
ed 0 after 0 usecs
> > >>>> [   50.247906] i8042 aux 00:02: PM: calling pnp_bus_resume+0x0/0x9=
d @ 4492, parent: pnp0
> > >>>> [   50.247916] i8042 aux 00:02: PM: pnp_bus_resume+0x0/0x9d return=
ed 0 after 0 usecs
> > >>> ...
> > >>>> [   50.248301] i8042 i8042: PM: calling platform_pm_resume+0x0/0x4=
1 @ 4492, parent: platform
> > >>>> [   50.248377] i8042: [49434] 55 <- i8042 (flush, kbd)
> > >>>> [   50.248407] i8042: [49435] aa -> i8042 (command)
> > >>>> [   50.248601] i8042: [49435] 00 <- i8042 (return)
> > >>>> [   50.248604] i8042: [49435] i8042 controller selftest: 0x0 !=3D =
0x55
> > >>>
> > >>> So here I see the ideapad-laptop driver trying to access i8042 befo=
re it
> > >>> even starts resuming. I wonder, does it help if you disable
> > >>> (temporarily) the ideapad driver?
> > >
> > > OK, so I tried to cook up a patch that would allow ideapad-laptop dri=
ver
> > > to establish device link with i8042 so that the resume will be proces=
sed
> > > after i8042 resumes, but the longer I think about it, the more I thin=
k
> > > that ideapad driver should not be messing with the touchpad state
> > > directly. The disable event may come up in a middle of the touchpad
> > > resume transition, or when we decide to change touchpad mode for one
> > > reason or another. It also does not respect inhibit/uninhibit control=
s
> > > for input devices. I think that the proper way for ideapad driver to
> > > handle this is to only send KEY_TOUCHPAD_OFF/KEY_TOUCHPAD_ON to
> > > userspace and let userspace deal with toggling touchpad input (via
> > > inhibit or by other means).
> > >
> > > CC-ing ideapad maintainers for their thoughts.
> >
> > Sorry for the very slow reply.
> >
> > The interesting thing is that sometime ago I already removed the i8042_=
command()
> > command being done on most models now the ideapad driver already only
> > sends KEY_TOUCHPAD_OFF/KEY_TOUCHPAD_ON except on the ideapad Z570 for
> > which the i8042_command() call was initially added.
> >
> > I agree that this should probably just be removed.
> >
> > Jonathan, I presume that you are seeing this on an Ideapad Z570 ?
> > (since that is the only model where this is still done by default).
> >
> > Since the i8042_command() call has already been disabled on all other
> > ideapad models I agree that it would be best to just remove it entirely
> > relying on userspace filtering out touchpad events after receiving
> > a KEY_TOUCHPAD_OFF.
> >
> > I have submitted a patch to do just that:
> >
> > https://lore.kernel.org/platform-driver-x86/20240805141608.170844-1-hde=
goede@redhat.com/
> >
> > Jonathan can you give this patch a try (with a kernel with
> > the ideapad-laptop module re-enabled) and then confirm that this
> > fixes things ?
>
> IIRC Jonathan observed the touchpad being stuck on resume even after
> disabling ideapad-laptop module. So we ended up with a69ce592cbe0
> ("Input: elantech - fix touchpad state on resume for Lenovo N24") that
> sends disable and then enable command to the mouse/touchpad on resume
> which makes touchpad work after resume.
>
> Thanks.
>
> --
> Dmitry


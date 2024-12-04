Return-Path: <linux-kernel+bounces-431288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7B89E3B91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4981F285DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE011BC9F0;
	Wed,  4 Dec 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bwpsAHJU"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E415E97
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319925; cv=none; b=QiOIHZo+6eFqHIJuOzeliwmqDQYlXERzvBBxKjzGYd5DWP/pGM61lqf6BEDzXhrxoy2KK7Cc4EVzz0LxdlO2SFA9TMtj25tJ/kh1nqDMC2LGB50oOcQKktBcpWofbdUZsidiJQTDC9DaLtLdPntfgv1sZbgdl5pIL29Sp6QGS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319925; c=relaxed/simple;
	bh=/PJEj992zLY8HV4Oqz0Uvz2ikHLT9zDCheARIl0JZ+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpoqyzR0JbKp4xaAfvnAJZIQsQUaAGbtAvBiTSQugeYBrPdr9EFSKe8YyExHYN6zCxVimNubQ6Xebt+uu5MT742a7Hm0xoTwF3QC2Hiajav/D2RK88N/ohCLqR5goPG4FF8EY/3Qy2K9mtv8PkcTGgceKMSWSzM+Vnep/iOIdjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bwpsAHJU; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71d502644e2so2876559a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733319922; x=1733924722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn/9vp7MH8YA5L/D2zUWLVkPbODMTTNnz9oxvh7Hdrw=;
        b=bwpsAHJUsT758GmvzEVrQCT8bIvDOTiqtxaw4aGM3u+wyvqM+s6V9hRaO9brJ61sTX
         vX89XlaWM3nKih3zwoKDcP9g2ixbs06vUqM+f2N3nlNP/5s3YPBg9O6ZQRmFUzA2nedE
         jBFuU83yPACi4jP96cZnosBPuux1X8oymcp5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319922; x=1733924722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn/9vp7MH8YA5L/D2zUWLVkPbODMTTNnz9oxvh7Hdrw=;
        b=H0IkprawyA4XpLqTru0kO0Mm2I7lJc5QHhJsZuMe/kaMw38LZF0tXeqeD9kh2iaJGu
         CzzrzUFUwo6u4dq+3WDF6KvPMeoGj5T3U1i6HOeYquAp6TF/4H59JAumLMnjjW07gob/
         OaDMB0YJkkTtv405Uj5+AhUMFzbvbEhtpQ7lhNcxfhLlmGobNO8moCyDsMxpclPP77kU
         LnbfCp4QUNe/kNN37jCZ4UwIDC6B/OMXwYIxOd7IXfNRgiLJGG8kpcfBPnfeZQPm4VFL
         vYC3b+tTDqrFKkz+7ufzX+7MqJNd/rRxsbsjI8rwozhc6tAJOhG/qO8DX7Httwh8hooQ
         Qazg==
X-Forwarded-Encrypted: i=1; AJvYcCV/5tPFUFI+1QwNbRq4gHLfZJqAHXuGkTY5ci0wZiOOVxeLa3e7hZQu6+K/AXicW/ceYXSAGStkCyGR4Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYm36kst4Lc7WLBWeTUfFNRWY+zS4UtpiOH0/Ch50pYN2Ndctm
	SZfUbDaVYANU9bCHVadxSP4IFJCLCpbIA+SYiaVIwjPblyyqJg3iDgGQZR9R0RSA/k24OriH7vd
	8hDt3gGY8CUelnZRkAwhsMUMO7aPhJdhsOe3t
X-Gm-Gg: ASbGncshYsyZC+kUAPwNbxLz59NO6P5Y8cz1DwC+7XjHQBQ9itM1qO1+1NkL1DtsV2u
	n+GsqkIS+MsCvBUJeJXcsREyQEmg0SWc4nDRvyOSdIGbvOifPUhlIpmiYYw==
X-Google-Smtp-Source: AGHT+IEn8iuuMWbMGPs3suY3+tsI5yVhVF4dE6d8RvFjvcoY00IpHpW1vwHb1Idr1Ykc3GYP2K6YLbxNc62/0ZtQQ4M=
X-Received: by 2002:a05:6830:2114:b0:71d:50d1:8fbd with SMTP id
 46e09a7af769-71dad6d2fc7mr4346410a34.20.1733319922387; Wed, 04 Dec 2024
 05:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
 <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
 <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com> <Z0-4umP9TnNAbJXO@google.com>
In-Reply-To: <Z0-4umP9TnNAbJXO@google.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 4 Dec 2024 21:45:11 +0800
Message-ID: <CAEXTbpeeZVwCYWR0wzX8QMYJ7okj=zmziwt9Nvtu2kzA4iMCmA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Brian Norris <briannorris@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Wed, Dec 4, 2024 at 10:04=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Hi Doug,
>
> On Tue, Dec 03, 2024 at 05:38:55PM -0800, Doug Anderson wrote:
> > On Tue, Dec 3, 2024 at 3:05=E2=80=AFPM Brian Norris <briannorris@chromi=
um.org> wrote:
> > > The Kconfig default is 120 seconds, and it's hidden under
> > > CONFIG_EXPERT. What makes you think 10 is a good value? (It sounds
> > > pretty small for triggering panics.) The smallest I can see outside o=
f
> > > ChromeOS is 12 seconds, although 60 seconds is much more common. I
> > > also happen to see other WiFi drivers have hit similar problems, but
> > > they settled on 20 seconds (assuming a 60s timeout on other distros):
> > > https://lore.kernel.org/linux-wireless/20230329162038.8637-1-kvalo@ke=
rnel.org/
> > > https://git.kernel.org/linus/cf5fa3ca0552f1b7ba8490de40700bbfb6979b17
> > >
> > > Technically, this Kconfig lets you set a value as small as 1 second. =
I
> > > don't think we should work at reducing all timeouts to fit that
> > > target.
> > >
> > > I could maybe approve lowering this one, but I'd also recommend
> > > reconsidering your timeout value. And more questions below.
> >
> > That's fair. I guess having a 10 second timeout for full system
> > suspend didn't seem totally crazy to me. If a system is taking more
> > than 10 seconds to do a full system suspend then that seems like
> > something is pretty broken. I guess it's somewhat like the same
> > argument that the WiFi driver had for picking 10 seconds but applied
> > to the whole system level, and I guess that's where we get into
> > trouble. That made me think that even 5 seconds seems a bit long for
> > any given driver to suspend. ...but yeah, it's squishy.
>
> 10 seconds is likely that *something* is wrong (or at least suboptimal),
> but IMO, it's not quite at unreasonable levels. But yes, my point was
> mainly that it's squishy, and I personally wouldn't want to be the one
> running with the lowest CONFIG_DPM_WATCHDOG_TIMEOUT out there, given the
> known behavior of multiple drivers and the timeout-means-panic behavior.
>
> > Maybe the ChromeOS should change to 15 seconds for the DPM Watchdog
> > timer and that's a better solution and leave the WiFi driver how it
> > is?
>
> That seems reasonable.
>
> To be clear, I'm OK with this patch, if we can get a little more
> confidence in it (like the timing data and HW info). I *think* 5 vs 10
> isn't a big deal here, but I don't have much other than my guess at the
> moment.
>
> > Another thought: I wonder if it's possible to be dynamic and somehow
> > set the timeout as "max(10, dpm_watchdog_timeout / 2)". Not that I've
>
> You probably meant min()?
>
> > checked to see if the mwifiex can actually query the DPM watchdog
> > timeout... ;-)
>
> Yeah, I wondered similarly -- or in reverse, if we could somehow "pat"
> the watchdog or prime it with an expected timeout. But AFAICT, neither
> such feature exists today.
>
> > ...also, it sure seems like if we're going to choose a value so low
> > that we shouldn't panic. All of our other watchdogs that panic aren't
> > so short, so probably this one shouldn't be either. Maybe we could
> > submit a patch to make the DPM watchdog just abort the suspend if
> > that's not too hard (and if the power people accept it).
>
> Yeah, if you made the watchdog just interrupt suspend and dump some
> warnings, then the effect would be pretty similar to this patch.
>
> > > I wonder what the distribution of (successful) timing is today. I'd
> > > assume this typically take on the order of milliseconds, but do we
> > > commonly see outliers? What if a system is fully loaded while
> > > suspending?
> >
> > I would hope this doesn't affect things from the DPM watchdog, but I
> > haven't researched. Hopefully the DPM watchdog starts after userspace
> > is frozen so the system being fully loaded shouldn't matter?
>
> I was just throwing out ideas, but I didn't specifically mean user
> space. You provided a few more ideas. Anyway, I was just fishing for
> *some* attempt at real-world (and, as-bad-as-you-can-simulate world)
> numbers, since that's the point of a timeout like this.
>
> > >  Can you try testing (and gather timing numbers) when
> > > suspending soon after initiating scans? It's hard to judge what the
> > > lower limit of this timeout should really be without any numbers, jus=
t
> > > like it's hard to judge whether your 10 second watchdog is reasonable=
.
> >
> > Pin-yen: is this something you could gather?

I tried entering suspend right after wifi scans, and the time spent in
mwifiex_enable_hs() is always around 100ms. It seems initiating
suspend does not increase the execution time for mwifiex_enable_hs(),
so I think the driver is capable of interrupting a scan.
> >
> >
> > > Also, for the record, since we might have to field regression reports
> > > for other systems: what hardware (chip variant, FW version) are you
> > > seeing problems on?
> >
> > Pin-yen: I'm assuming you'll provide this.

From the debugfs entry:

driver_name =3D "mwifiex"
driver_version =3D mwifiex 1.0 (15.68.19.p54)
verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54

The compatible string of the DT is "marvell,sd8897".
>
> I'll leave it up to y'all (Doug and Pin-Yen) whether you want to provide
> the above to provide a little more confidence, or if you want to
> reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.

It looks okay to me to decrease the timeout here given that scanning
doesn't seem to affect the suspend time. What's your thought, Doug?

>
> Brian

Regards,
Pin-yen


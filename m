Return-Path: <linux-kernel+bounces-435258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C118D9E752F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414F51699F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE04620E032;
	Fri,  6 Dec 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7c5bbwl"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6A20B81B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501410; cv=none; b=P5fHRK3O8/50vNRW1m7lfIiEWhjM2hyX/Z0cxYQ/KGj1jmfuqPAJCthdqaq9S1R523iJHrV0D57N0DDqGa7lNad9xYp3NTn5hiJ6BZHjbKfmgtFb5n/vf3vOMQTHSsc3EvdP8wmjqDYK19HPeWi8HafIvguH7NahSyXbS38gT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501410; c=relaxed/simple;
	bh=qP4Qp4bh1qTT1DSw+QNkGJJNNeSk5RrKVW7zhsAqXGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyYh4YyAAXsOzhpzqdOZeU4TavUMoKQ9kOWZEiVbTZpS7rT9qx85TlFlRT1qYkfjaKD1eKBlFov4FNnbn3AlvYDeXj06Pe8/CgFfPUda5PHLZkODsMvCJqbRkJL/1Xf1VMTRQTTtxahA9rysipr6N6UMuawl894R6aUMGlAP8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l7c5bbwl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30020d33d05so19069241fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733501404; x=1734106204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evhoGFFNxGHGM5vTtdZWp63JejZrYFIpqAu47USQhSs=;
        b=l7c5bbwl285agEgolx/u7Oq5UR6ZAArU0REQAJuCMaOxqYnKkeYVv+yEroaYsaPgNG
         JqcnoUL7fveYDLgbNaCUOdZgGfBjv5Zm+wsvIwmEy8Cu61HLIOcoNkQo8bLCrbrvIpCB
         a1CM2lXC2NZQGFE3kyITR2NP4F1Fk1g0Vo1Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501404; x=1734106204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evhoGFFNxGHGM5vTtdZWp63JejZrYFIpqAu47USQhSs=;
        b=nrB8lhdYJ/k+UPe9OC/AUMCgUVnGSfEeDuAPsjbBkhE8nbVlKCEnHepJ37Ha8/nD6c
         SZSmppW+p0aOTKxwW4xcgv7vOZGyhp/7DLc+OUn8At0fXdL2wDWj4OucPW8WYAlJchwk
         HTJoJVXR9YQBSB9msxF8hsuN+o7+pYvxc/sIE+FDsHBzIPdMZcygvsG+Y+f01ZhIGo7N
         LINNGlB5OKcaEP2/B5G6LLXbZT7a+4qG0F3hAtkLUl8W6tyPiMOQE62H9bQrtbYgADY0
         cUWmzLcLEZp2NTB2Jf6Xags/eHp+ypBaesYVEYFo97nKTJOLnX3LtXANLzQ6VzUfbR0O
         nGZw==
X-Forwarded-Encrypted: i=1; AJvYcCXeWNXxdenVSRN+v0vQ38oXulD49SnTEderPHy+B6+MFQii72y46PnGx98F6KvXF7ti3nDGpY9bevxdt1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2dU8OVMg1SUrecDyr0lZMj7EvHrImdkqQOCyX37PZI40fiQs
	CeaMs9M4p799rn1R+nr5CMFToWXEEnpi0DQSkwiO3nTJCQkjzOEQKDG6mwMbQ0ly8cgNXTXLdmS
	zmw==
X-Gm-Gg: ASbGncvhyh1R7B+ykkwPj2mGAjsb7xemMaojwYY+aynRgk2Ay6BgtMCVwQsMwigCzF8
	K/P1uzOH4vjcsyCp3HSg1jvVtFL2G9nQhMHIXc6UBhgkAhbQUb032KcOQ+2wh01zFOiPBrnnvFE
	wyUoYH5OJ2OuddJMhYAYTzqHhUMbB2v8w1tuGdf8e9rL+71fzeHWTeK82ilNPD9vDsSQqitZdqS
	ioG3rb3h/akB4c6WyLA8im6CxsnSwbaTSgE08NkyJni56hnF2sHxKDPaTNj+/dWqcJLfqqRKyHg
	dt+/40rtX16qtwobCQ==
X-Google-Smtp-Source: AGHT+IFe1+IzDlZScK8eBHAoVDVYB9OgdHkXB3DufReTMdVpcn7lSMwD+N6ByRr5MEYudmC0YKp19w==
X-Received: by 2002:a05:651c:1989:b0:2ff:de64:c44f with SMTP id 38308e7fff4ca-3001ea99114mr28308271fa.1.1733501403780;
        Fri, 06 Dec 2024 08:10:03 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d85534sm4899301fa.10.2024.12.06.08.10.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 08:10:02 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso32125631fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:10:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqU+qNpO7D6fIlCiPQ6zWjl0l6jqNZlEOL3Y56c70HdtHdtooh3WvRpD1kZ1cuGT+CbJU+RfvUUKcYjGI=@vger.kernel.org
X-Received: by 2002:a05:651c:1989:b0:2ff:de64:c44f with SMTP id
 38308e7fff4ca-3001ea99114mr28307711fa.1.1733501401123; Fri, 06 Dec 2024
 08:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
 <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
 <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
 <Z0-4umP9TnNAbJXO@google.com> <CAEXTbpeeZVwCYWR0wzX8QMYJ7okj=zmziwt9Nvtu2kzA4iMCmA@mail.gmail.com>
 <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com>
 <CAEXTbpeEPw66aJAfNBYDGCuQP=UsHvrqBTG7cdQJ3D+w6AiCcA@mail.gmail.com>
 <CAD=FV=XdPzA8jO+4xMpYJU_1k8dp1GNGt7fnmLA4WX1f=civ4g@mail.gmail.com> <CAEXTbpe6D_pwLP6+0Kv-n7KMRoOn-_CWdZygMz0yK1fFuC-2Bg@mail.gmail.com>
In-Reply-To: <CAEXTbpe6D_pwLP6+0Kv-n7KMRoOn-_CWdZygMz0yK1fFuC-2Bg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Dec 2024 08:09:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0TVVJxPL3sy=xBKc72UaH0iGy5+v+oyQ0b36BXnZXDg@mail.gmail.com>
X-Gm-Features: AZHOrDnI3cm66ZbE3sqwU13dD4W7vLG00hftJO3dJkhsNpY7o59HJ2o11-rUdJc
Message-ID: <CAD=FV=U0TVVJxPL3sy=xBKc72UaH0iGy5+v+oyQ0b36BXnZXDg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Pin-yen Lin <treapking@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 6, 2024 at 3:21=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> Hi Doug,
>
> On Fri, Dec 6, 2024 at 1:13=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Thu, Dec 5, 2024 at 5:46=E2=80=AFAM Pin-yen Lin <treapking@chromium.=
org> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Thu, Dec 5, 2024 at 2:11=E2=80=AFAM Doug Anderson <dianders@chromi=
um.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Dec 4, 2024 at 5:45=E2=80=AFAM Pin-yen Lin <treapking@chrom=
ium.org> wrote:
> > > > >
> > > > > > > >  Can you try testing (and gather timing numbers) when
> > > > > > > > suspending soon after initiating scans? It's hard to judge =
what the
> > > > > > > > lower limit of this timeout should really be without any nu=
mbers, just
> > > > > > > > like it's hard to judge whether your 10 second watchdog is =
reasonable.
> > > > > > >
> > > > > > > Pin-yen: is this something you could gather?
> > > > >
> > > > > I tried entering suspend right after wifi scans, and the time spe=
nt in
> > > > > mwifiex_enable_hs() is always around 100ms. It seems initiating
> > > > > suspend does not increase the execution time for mwifiex_enable_h=
s(),
> > > > > so I think the driver is capable of interrupting a scan.
> > > > > > >
> > > > > > >
> > > > > > > > Also, for the record, since we might have to field regressi=
on reports
> > > > > > > > for other systems: what hardware (chip variant, FW version)=
 are you
> > > > > > > > seeing problems on?
> > > > > > >
> > > > > > > Pin-yen: I'm assuming you'll provide this.
> > > > >
> > > > > From the debugfs entry:
> > > > >
> > > > > driver_name =3D "mwifiex"
> > > > > driver_version =3D mwifiex 1.0 (15.68.19.p54)
> > > > > verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54
> > > > >
> > > > > The compatible string of the DT is "marvell,sd8897".
> > > > > >
> > > > > > I'll leave it up to y'all (Doug and Pin-Yen) whether you want t=
o provide
> > > > > > the above to provide a little more confidence, or if you want t=
o
> > > > > > reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.
> > > > >
> > > > > It looks okay to me to decrease the timeout here given that scann=
ing
> > > > > doesn't seem to affect the suspend time. What's your thought, Dou=
g?
> > > >
> > > > I think Brian is right and that we should change how we're using th=
e
> > > > DPM watchdog, but IMO that doesn't mean that we couldn't also chang=
e
> > > > this timeout.
> > > >
> > > > If nothing else, you'd want to post a v2 of your patch containing a
> > > > summary of the info you've gathered so it's recorded with the patch=
.
> > > >
> > > > Maybe what makes the most sense, though, is to put our money where =
our
> > > > mouth is and land some sort of patch in the ChromeOS tree and then
> > > > report back to upstream in a month when we have data about it. If
> > > > things look good in the field then presumably that would give some
> > > > confidence for upstream to be willing to land the patch?
> > > >
> > > > Probably about the best data we could gather would be to break the
> > > > existing timeout into two halves. You could wait half the time, the=
n
> > > > print a warning, and then wait the other half the time. We could ev=
en
> > > > land that change _without_ changing the timeout to 5 seconds. Then =
if
> > > > we ever see the warning print but then the suspend succeeds we know
> > > > that there are cases where waiting longer would have helped. If we
> > > > made that a WARN_ON() our existing infrastructure would help us gat=
her
> > > > that info...
> > >
> > > I just realized that mwifiex_wait_queue_complete() has another 12s
> > > timeout[1], though they are not directly involved in suspend/resume.
> > >
> > > Should we also add a warning to that and see if we can make it half?
> > > This starts to make me think how many timeouts we want to consider.
> > > Does it make sense to only focus on the one in mwifiex_enable_hs()? O=
r
> > > should we check other timeouts in mwifiex or even other drivers?
> > >
> > > [1]: https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/wire=
less/marvell/mwifiex/sta_ioctl.c#L51
> >
> > IMO any of these "arbitrary and really long timeout to make sure we
> > don't hang forever" type things probably should have a warning so we
> > know if we're getting close to the timeout. It wouldn't be very hard
> > to make a wrapper around wait_event_interruptible_timeout() to handle
> > this. I suppose that wrapper could just be local to mwifiex, though if
> > other drivers found it useful it would make sense to put it somewhere
> > more common.
> >
> > That being said, if we aren't actually hitting these other timeouts I
> > don't know that we need to do an extensive audit right now to find
> > every one of them.
> >
> > Of course, Brian also said he'd be OK with just setting the timeout to
> > 5 seconds based on the research you've already done. In that case I
> > don't know if we'd want a WARNing after 2.5 seconds. Maybe? 2.5
> > seconds is still pretty long, but I don't know if it's WARN-worthy. It
> > could at least be dev_warn() worthy...
> >
>
> Sounds like we will start to binary search the timeout...

I wouldn't bother binary searching the timeout and in general I
wouldn't try to tune these timeouts unless we think there's a real
benefit to it. Mostly, though, I like the idea of having a warning
_before_ a failure occurs. Like if I have a retry loop that will retry
10 times, I like to warn after I need 5 retries so that it's obvious
we're getting close. If I expect a timeout to never be needed, I'd
also like some warning that says we got close to the maximum timeout.
All of this makes it much easier to debug problems if/when we actually
hit the failure case. It also has the benefit that if we need to tune
a timeout / number of retries then we have more confidence that we
were nowhere near the max, but IMO that wouldn't be the primary
benefit.


> Then, I would like to just send out a v2 for this with an updated
> commit message.

Sure, though maybe it's not urgent? We've changed the DPM watchdog in
ChromeOS to 15 seconds so at least we won't be hitting it there. While
I agree that the 10 second timeout is still likely overkill and that 5
should be fine, gathering more data wouldn't hurt.

I'd be really curious how the system behaves after the timeout hits,
too. Does the next suspend actually succeed? Does WiFi recover or is
it busted until the next reboot?


> It sounds like it will be endless binary searches on
> all those timeouts in the kernel if we really want to create a wrapper
> around wait_event_interruptible_timeout(), and all the efforts only
> make us a few more seconds faster on the system.

My goal in general isn't to optimize the system but to know when we're
close to failure so it's easier to debug when the timeout occurs.


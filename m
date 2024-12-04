Return-Path: <linux-kernel+bounces-431953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4CE9E4311
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC165161CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3132391A5;
	Wed,  4 Dec 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJ94HYKu"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E515239180
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335921; cv=none; b=SsdgAyqa/EdEo13BA4VeACnec2Lej+GwINJpjIq4XpTp9BDAHcSyZlmb6MEzinYQ8zXcYdtTRoP8Pa0JNDjmUeaL/4H1n+QWAnahGc1mD9laFXKJiutYfHbGJOH46lF4cOOxnnFnXoVZgbBkgV71T+e0JYr8UQL98QA7B5yfFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335921; c=relaxed/simple;
	bh=v+jzv8rPT2WHY9B4GsJV0qYrOODUfu3q72gGtG6Qe4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk4/1ieLP9HkEdTiF6SiWLiyZG65hMfJrJXSBu/6nvLGc7kfNgSQDylYt0uTZiz6gdErlG+eHpL0iEE+4D9+GNwlOwddvHxw5hunhcdU/RtFL8VoTL4LkqYLcakNYac84LHfXk71y6/NrD4LpfXSeFvVRcyxRLiV8sJhU/QsRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TJ94HYKu; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so107900e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733335917; x=1733940717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7xszK3WQnOZZ7Fj6nqT0zzAPzoP0+KMKEdCaulS0QI=;
        b=TJ94HYKuCMaRmsnWblYxt9ZxU/ujd0aLJXb/BPCNwj4Fleh7sk1QpYjHa1OA9lNSA1
         FmkNvG4xj5jUbVkAJYxCsZ53HDy0/7vR7VYI/p8ffy1A1qC06YW9f7VSMYMH2EwWiKKR
         jy/Xxj/CKBPM8/TKQJkDuTOcnEwt/4PAZsVtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335917; x=1733940717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7xszK3WQnOZZ7Fj6nqT0zzAPzoP0+KMKEdCaulS0QI=;
        b=rYjbIqw684dU4KxelwoP4jw/2EcQmnTa2B3z+R0D+hUm3pYxUCkVZh+97nDeTRy87S
         c29rNBlhFf32gXQNU9PfciBHsQfIjUD6ZmqiAVSFoPPJOTQdXfvn9uBymun4/bDewqPr
         khE1BZZQRaRG1E1sVeVGKUJ2z8OFtTQ5rji7YVgkMQXP6iAYxw/GrLHrz8UTDV/jE9Dg
         WdHKIfgc5zygVyXV81DUWE7ozCNohGwxd6d6XZx1gWnQS3VTGWyKoZH8XINHZ0oiiPuv
         fmuQqd3RCKxX4rEZk01w+5eP7zO57CeGW/TVg5GLF5cKLLPsCIYuMZ1vWpkDzilMPT4M
         dAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzVPU+hZgpZychZEKxLMjOSvYsW834DZQWIexs114NB92ibzotJTED6ZCiL0qx0mR0s75aVmWFG2wXqg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQendEwXOmFeuxofTbRrC3mYSBtodRzlYmAToe96ZJiOksDY4c
	QbA6nBK5B1M6ycbFYCEPf+ofp9UUVR9Ds0K0zlKZKVNN77cpsCfsBBBlqZr34W/stJ/G9PFzYoc
	ntUvy
X-Gm-Gg: ASbGncso11JTjEvj2HEjSmdCcbbNU8CpVgBYYkFF5kX8MA6r/EhTnzZ/4gkJ//xUp4s
	wp4XPokXM37bLBs4I/xGBoQMqJ7GbIHlHI5gCeXD1PtQTsSeSf8Ys2/js9V7q+2+UChWJ/RE+Hr
	OkNm+ckjuQrSBqvmWZbE0/VBZPC2eBBHVQyXVWLhFpCnG3WlIlFjyOSyVOVCaqOKIyqO7ZTJk/n
	QnP/JiEls15UNvfImIR96v3ce9VlmS/LxiX+p9AzAb5vBT/QjQw68fMucDRGvm9P4ITJ3Wh34Vt
	34pv8qIVUSIwVw==
X-Google-Smtp-Source: AGHT+IENvpTWOp/Np/CZRSlt5GLJmQXtt+4R0H+K9IVXFG38MgqDBubZOvfEcROkxBMmdG9bzN4bIA==
X-Received: by 2002:a05:6512:3989:b0:53d:ed45:45b3 with SMTP id 2adb3069b0e04-53e129fdc40mr4391453e87.16.1733335916668;
        Wed, 04 Dec 2024 10:11:56 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1fcfef52sm173840e87.277.2024.12.04.10.11.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 10:11:55 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so107846e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:11:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXW3hSprVDVIn0qWJ779qkvbBKkoIdC/XofkFc/sqldMcCWlUiH6Jzo/TJ8PiifK1s3DkY6pZ6J9iruPRU=@vger.kernel.org
X-Received: by 2002:a05:6512:2395:b0:53d:e6c3:368c with SMTP id
 2adb3069b0e04-53e12a0595emr4365550e87.32.1733335915171; Wed, 04 Dec 2024
 10:11:55 -0800 (PST)
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
In-Reply-To: <CAEXTbpeeZVwCYWR0wzX8QMYJ7okj=zmziwt9Nvtu2kzA4iMCmA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 10:11:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com>
Message-ID: <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Pin-yen Lin <treapking@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 4, 2024 at 5:45=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> > > >  Can you try testing (and gather timing numbers) when
> > > > suspending soon after initiating scans? It's hard to judge what the
> > > > lower limit of this timeout should really be without any numbers, j=
ust
> > > > like it's hard to judge whether your 10 second watchdog is reasonab=
le.
> > >
> > > Pin-yen: is this something you could gather?
>
> I tried entering suspend right after wifi scans, and the time spent in
> mwifiex_enable_hs() is always around 100ms. It seems initiating
> suspend does not increase the execution time for mwifiex_enable_hs(),
> so I think the driver is capable of interrupting a scan.
> > >
> > >
> > > > Also, for the record, since we might have to field regression repor=
ts
> > > > for other systems: what hardware (chip variant, FW version) are you
> > > > seeing problems on?
> > >
> > > Pin-yen: I'm assuming you'll provide this.
>
> From the debugfs entry:
>
> driver_name =3D "mwifiex"
> driver_version =3D mwifiex 1.0 (15.68.19.p54)
> verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54
>
> The compatible string of the DT is "marvell,sd8897".
> >
> > I'll leave it up to y'all (Doug and Pin-Yen) whether you want to provid=
e
> > the above to provide a little more confidence, or if you want to
> > reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.
>
> It looks okay to me to decrease the timeout here given that scanning
> doesn't seem to affect the suspend time. What's your thought, Doug?

I think Brian is right and that we should change how we're using the
DPM watchdog, but IMO that doesn't mean that we couldn't also change
this timeout.

If nothing else, you'd want to post a v2 of your patch containing a
summary of the info you've gathered so it's recorded with the patch.

Maybe what makes the most sense, though, is to put our money where our
mouth is and land some sort of patch in the ChromeOS tree and then
report back to upstream in a month when we have data about it. If
things look good in the field then presumably that would give some
confidence for upstream to be willing to land the patch?

Probably about the best data we could gather would be to break the
existing timeout into two halves. You could wait half the time, then
print a warning, and then wait the other half the time. We could even
land that change _without_ changing the timeout to 5 seconds. Then if
we ever see the warning print but then the suspend succeeds we know
that there are cases where waiting longer would have helped. If we
made that a WARN_ON() our existing infrastructure would help us gather
that info...

...so I guess summarizing my rambling, a good plan would be:

1. Change the ChromeOS DPM watchdog timeout to 15 seconds to avoid the
problem for now.

2. Land a patch to do a WARN_ON() in mwifiex if we take 5 seconds.
Actually, you could (probably) send this upstream and land it
FROMLIST?

3. Wait ~1-2 months and see if we ever see the WARN_ON() trigger but
then things succeed after 10 seconds. If this never happens then send
a v2 patch changing the timeout to 5 seconds with details in the
commit message.

4. In the background, see if we can convince folks to make the DPM
Watchdog less panicky.


-Doug


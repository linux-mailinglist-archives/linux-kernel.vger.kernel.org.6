Return-Path: <linux-kernel+bounces-315849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DBB96C7AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917BFB22E11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78291E6DC0;
	Wed,  4 Sep 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W9Ia+n8s"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CA84A27
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478739; cv=none; b=scTgX25TVivT3CGRnSL5YgzT6KIbyEItrufy83QEhMd/U8SzekiBnGNgDCT/GHG/opXmKFQR2idyMv5Q4tWrS9OZu9E+yjl2uSbhBDwe4M4GW5rvv0OIK/UoBbqf7VrgyFnqbEN0VamrCLJYNv81QW6JUWfBQjXwjgC0wndyMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478739; c=relaxed/simple;
	bh=X1rCL2l0VFuxkY0MqlkC1N3OKaRjCF4hye6rtF4lC2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwe4TtutKl1oV6/d7g+Vik/yUgVjIoEjdcLPhw70+E04JVXjOSshoOn7Ffr9Dg2K6zaOZ3N7AtrQSjdX8GwfOD6Q/Uq2H1dKAlMAfQ/1c0Zhpco09WtkV1TSyXftOOxqMTJOD85ClU6n5Qxv61rIHfKbZWryuFthj/ArLY2XFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W9Ia+n8s; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-846b934981aso1439399241.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725478736; x=1726083536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1rCL2l0VFuxkY0MqlkC1N3OKaRjCF4hye6rtF4lC2w=;
        b=W9Ia+n8sgloW4D0DZuKGfg8GVEiuA7NCUT4HYoAvZYLTQSlOdw2xQxOq1tRt0CBdXN
         uog3cW3TiYNmMe3VYfEPlB7tQBLoZFfDu6vGGwoVYLUNfnV2nnXLU2GF77TUEy01PO02
         3N4R2wBo9LSVMZk0w2Pejfr84WCRp2vNcDrs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478736; x=1726083536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1rCL2l0VFuxkY0MqlkC1N3OKaRjCF4hye6rtF4lC2w=;
        b=MqPOwRf1UCQ+fL9UAL8HM9no4r779mCtvkIN3G4kTlAkrb6FR3Ld4BJXKtwKDpVArP
         OGhxQCHHVmIIlrIGp6dzNwhJP6l535XSXxgwF9RRmeTYAFZHFO2jPGfcQtYD2Tm1MCx1
         0BKMfVU+GB9An8EFXpnLY+p9t4ThikRimD5rSzcFTDJFyxy9426Ol8knE0mUVPnMkrdG
         8y2H/lob1i0+nVfVQ3jCpDwQhpiXlWCvG4+YvjUfLeiIikw9VVG6CZWpEkaOpNVomGz7
         qwmLWjCKFME4nBxs43zqIMA1RR1hhShtf2udr204mHE7KesoyV9YCQ0LyEJiQVUakOtD
         U/9g==
X-Forwarded-Encrypted: i=1; AJvYcCXdPdavj84BPKu7ZKNAM02GENWbSEn2pCl2rKE1UiDWcltVXnQ0ieETuV9inM/22e0roZz8BiFMZUhZYXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QEgpyW/2mAhnYF2cQVUWq7IAME0bZkTOT73EAdKfx7ahRahu
	QPaRAzfSWeTul2ODq+0a/sRIBJKJqc937kqGt5DlHQEFcdolW/OcEjBUzMJocwowtOyv4SFjzo0
	=
X-Google-Smtp-Source: AGHT+IHyWUoTYhCMVC5K2yQbIsw81DZvm/Q7EwlQJFuY9bPXhwdeywAIa9+jpUUngWuf4StLkckUIQ==
X-Received: by 2002:a05:6102:370e:b0:493:c3b2:b5ba with SMTP id ada2fe7eead31-49a7773522cmr18337484137.6.1725478736362;
        Wed, 04 Sep 2024 12:38:56 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520317370sm1182296d6.80.2024.09.04.12.38.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:38:56 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c3561804b5so23203716d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:38:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoPJWcGoGVl8ERiomNukuVY5su73HhoYkeWApCB0K4pagc+zx/eV03eOACPWnDc4n3bggGGayNgc8SeIg=@vger.kernel.org
X-Received: by 2002:ad4:58b0:0:b0:6c3:55ed:1a35 with SMTP id
 6a1803df08f44-6c355ed1f7bmr150528806d6.2.1725478735284; Wed, 04 Sep 2024
 12:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822070944.GA13716@didi-ThinkCentre-M930t-N000> <720FE0AC-FFB4-4236-9A29-9BE8C5D27C07@didiglobal.com>
In-Reply-To: <720FE0AC-FFB4-4236-9A29-9BE8C5D27C07@didiglobal.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 12:38:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vw1fG9sUiG4R6LiKnR2fgnt5Wr4QKzRg+v8MC15pWUEg@mail.gmail.com>
Message-ID: <CAD=FV=Vw1fG9sUiG4R6LiKnR2fgnt5Wr4QKzRg+v8MC15pWUEg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: when watchdog_enabled is 0, let
 (soft,nmi)switch remain 1 after we read them in proc
To: =?UTF-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"zyhtheonly@gmail.com" <zyhtheonly@gmail.com>, "zyhtheonly@yeah.net" <zyhtheonly@yeah.net>, 
	"john.ogness@linutronix.de" <john.ogness@linutronix.de>, 
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, 
	"linux@weissschuh.net" <linux@weissschuh.net>, "kjlx@templeofstupid.com" <kjlx@templeofstupid.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"bristot@redhat.com" <bristot@redhat.com>, "vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 4, 2024 at 2:23=E2=80=AFAM =E5=BC=A0=E5=85=83=E7=80=9A Tio Zhan=
g <tiozhang@didiglobal.com> wrote:
>
> Hi,
>
> Ping :)
>
> // get_maintainer.pl does not tell who are the maintainers or reviewers o=
f kernel/watchdog.c
> Add commit signers and sched maintainers to the CC list.

FWIW, people in the Linux community usually don't like "top posting"...

In any case, I saw your original patch but I struggled to make sense
of the explanation and so I left it for later and then never got back
to it. I suspect that the explanation needs to be a little clearer.


> =EF=BB=BFOn 8/22/24 =E4=B8=8B=E5=8D=883:09, "=E5=BC=A0=E5=85=83=E7=80=9A =
Tio Zhang" <tiozhang@didiglobal.com <mailto:tiozhang@didiglobal.com>> wrote=
:
>
>
> For users set "watchdog_user_enabled=3D0" but remaining
> "(soft,nmi)watchdog_user_enabled=3D1". Watchdog threads(,nmi watchdog)
> rework only if users reset "watchdog_user_enabled=3D1" without printing
> those watchdog swicthes. Otherwise (soft,nmi)watchdog_user_enabled
> will turn to 0 because of printing their values (It makes sense to print =
0
> since they do not work any more, but it does not make sense to let user's
> swicthes change to 0 only by prints).
>
>
> And after that, watchdog only should work again by doing:
> (soft,nmi)watchdog_user_enabled=3D1
> *** can't print, or everything go back to 0 again ***
> watchdog_user_enabled=3D1
>
>
> So this patch fixes this situation:
>
>
> | name | value
> |----------------------------|--------------------------
> | watchdog_enabled | 0
> |----------------------------|--------------------------
> | nmi_watchdog_user_enabled | 1
> |----------------------------|--------------------------
> | soft_watchdog_user_enabled | 1
> |----------------------------|--------------------------
> | watchdog_user_enabled | 0
> |----------------------------|--------------------------
>
>
> cat /proc/sys/kernel/*watchdog
> |
> |
> V
> | name | value
> |----------------------------|--------------------------
> | watchdog_enabled | 0
> |----------------------------|--------------------------
> | nmi_watchdog_user_enabled | 0
> |----------------------------|--------------------------
> | soft_watchdog_user_enabled | 0
> |----------------------------|--------------------------
> | watchdog_user_enabled | 0
> |----------------------------|--------------------------
>
>
>
>
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com <mailto:tiozhang@didigl=
obal.com>>
> ---
> kernel/watchdog.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 51915b44ac73..42e69e83e76d 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -995,8 +995,18 @@ static int proc_watchdog_common(int which, struct ct=
l_table *table, int write,
> * On read synchronize the userspace interface. This is a
> * racy snapshot.
> */
> + old =3D READ_ONCE(*param);

Given that the first thing that both the "if" and "else" case do now
is to set "old" then it feels like it could move outside the "if"
statement.

Even though the existing code does it, I'm also a little doubtful that
a READ_ONCE() is really needed here. You're protected by a mutex so
you don't need to worry about other CPUs and it would be really
confusing to me if the compiler could optimize things in a way that
the READ_ONCE() was needed.


> *param =3D (watchdog_enabled & which) !=3D 0;
> err =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> + /*
> + * When "old" is 1 and watchdog_enabled is 0,
> + * it should not be change to 0 for printing
> + * nmi_watchdog_user_enabled or soft_watchdog_user_enabled.
> + * So after we print it as 0,
> + * we should recover it to 1.
> + */
> + if (old && !watchdog_enabled)
> + *param =3D old;

I'm confused. Why all this extra logic? This should just
_unconditionally_ restore "*param" to "old", right? The only reason
the code hacked "*param" in the first place was so that it could use
the common proc_dointvec_minmax() helper function. Aside from the
common helper function working there is never a reason to muck with
"*param" if "!write" so it should just always restore.

-Doug


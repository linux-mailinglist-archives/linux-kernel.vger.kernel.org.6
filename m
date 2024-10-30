Return-Path: <linux-kernel+bounces-389458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7899B6D59
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306081F21CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8161D1506;
	Wed, 30 Oct 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZAGhCtbK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530691D14FB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319144; cv=none; b=BlXFNMxM4qznWm6zBRzj6N3tXGKAQTTVoDD7l45SEU/oQnF+lOSylUpE8KLh3pYq8XGMMakBpW8YuMwXyu1evqSF7F8ivjpuxxxcw9K2xMAukefaWwmtFqkFgxxkekdghqE9Ox4aMPybd4dJxv7BH9ZWTlAYluu4pJ/uGngXLIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319144; c=relaxed/simple;
	bh=gVrwd6b20qM/KGJRtOBT5km8yh4S7D6l1yUttkg7kVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzkNep/VhK5bK4ouvq54DJhXgtUJpc26BC5T6RjC8uUiY5dMdTqBYDT+Xx6TgHTPM/3ODHvYprnJPDSO7Is1ogCxggX5lm25KuKhc7kEY7YD6QNWLaf9oky/QhMb0xC7lBMri/CMxE/QSe35trBaLjuXwff6DBjoWBKLvLM6CbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZAGhCtbK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so413390e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730319140; x=1730923940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yOu+cIxdXt/0LsD6zEL5lEadq9da0UuXDXVgDuNz3A=;
        b=ZAGhCtbKOIXaPe0CtHHLFUn4rzP+Y/EtWUFNjuxMEOOjAXJrZrin8/PDQsSISqbks7
         roNFu2IIqqfYhRdEFJu8Tr3RPN8U3c9Dj3FKLEN7Q6owG4nIS6HeeaaueOzMYeQHgKUH
         ae7VPRFSmW7ufdDAF4w7sKU1lcA0NnPlU5bSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319140; x=1730923940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yOu+cIxdXt/0LsD6zEL5lEadq9da0UuXDXVgDuNz3A=;
        b=K8kAISvbJ4JRT41rPF06bAtOnS3s8+VfNC6aBVrpGeSynCAAvYvwspORmaLdD9RXVY
         eHohW3mAON9n5TftydMnD/cVilJ4H1xM7So/9Xuy/GjpBkMT5G7IsEobAkj0/2qCB4Na
         Ut5P9VUKJXTg8cSc0BRoR5foZ0Y45XtyZ596DmkFA+SftU0swOnJkJVZWVgtHrcvbTAx
         24GUsGb69qj9ordUMtEIo/eu4jcGNLy6tnaYbl3/zUsfxSxUxCLZQ44KLQFG0PYDPyYI
         kjPJa+7BqolBn1WzNR0fvXQ682E9Wr0C3ZA+vYvtzy5fY86WKGLzjPAri6o/eryIDCGw
         ooPA==
X-Forwarded-Encrypted: i=1; AJvYcCVt2DnE7Zewi/jQFYS87zPaLDliQwBSWN4ciIslT/XMSIJbjU75rskcMOqlEwQ3m/l7vjj5hzSmoeyKYmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynpXWzNbzuwE0V+JWaTKE32a1Aikm7YhTZRiwc0LNWtUwTfRe8
	mc93kw4WNQdNJUv2SyOlLhBAtDVPXvEKXLqK091rWgR8LL5+tkxFOORZ8Qp78e65BHb0XCjf23d
	idA==
X-Google-Smtp-Source: AGHT+IHXaMmDoRcwFmguvDz7nmwuUaGxhJQmnXhuozlZHKXF7nqKT/BW7EVJ2WgI31aJy3souuObHg==
X-Received: by 2002:a05:6512:b8d:b0:539:89a8:600f with SMTP id 2adb3069b0e04-53b348cfdefmr12464558e87.23.1730319139736;
        Wed, 30 Oct 2024 13:12:19 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bc0d5353asm333022e87.149.2024.10.30.13.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:12:18 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f2b95775so256012e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:12:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzZMR+5oB3NGQCadP7jT/zpxAOdxjdb9p1Zn4VJDGWtGRHGGWSIUQvP3obr7scvTBojt3OXUci/qWAcq4=@vger.kernel.org
X-Received: by 2002:a05:6512:6605:b0:53c:74a7:43de with SMTP id
 2adb3069b0e04-53c74a744afmr2455669e87.29.1730319138384; Wed, 30 Oct 2024
 13:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org> <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop> <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
In-Reply-To: <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Oct 2024 13:12:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
Message-ID: <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
To: paulmck@kernel.org
Cc: =?UTF-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>, 
	"sumit.garg@linaro.org" <sumit.garg@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"frederic@kernel.org" <frederic@kernel.org>, wsd_upstream <wsd_upstream@mediatek.com>, 
	=?UTF-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel-team@meta.com" <kernel-team@meta.com>, 
	"joel@joelfernandes.org" <joel@joelfernandes.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 30, 2024 at 6:54=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> > > We do assume that nmi_trigger_cpumask_backtrace() uses true NMIs, so,
> > > yes, nmi_trigger_cpumask_backtrace() should use true NMIs, just like
> > > the name says.  ;-)
> >
> > In the comments of following patch, the arm64 maintainers have
> > differing views on the use of nmi_trigger_cpumask_backtrace(). I'm a
> > bit confused and unsure which perspective is more reasonable.
> >
> > https://lore.kernel.org/all/20230906090246.v13.4.Ie6c132b96ebbbcddbf695=
4b9469ed40a6960343c@changeid/
>
> I clearly need to have a chat with the arm64 maintainers, and thank
> you for checking.
>
> > > /*
> > >  * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the
> > name,
> > >  * nothing about it truly needs to be implemented using an NMI, it's
> > >  * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> > >  * returned false our backtrace attempt will just use a regular IPI.
> > >  */
> >
> > > Alternatively, arm64 could continue using nmi_trigger_cpumask_backtra=
ce()
> > > with normal interrupts (for example, on SoCs not implementing true NM=
Is),
> > > but have a short timeout (maybe a few jiffies?) after which its retur=
ns
> > > false (and presumably also cancels the backtrace request so that when
> > > the non-NMI interrupt eventually does happen, its handler simply retu=
rns
> > > without backtracing).  This should be implemented using atomics to av=
oid
> > > deadlock issues.  This alternative approach would provide accurate ar=
m64
> > > backtraces in the common case where interrupts are enabled, but allow
> > > a graceful fallback to remote tracing otherwise.
> > >
> > > Would you be interested in working this issue, whatever solution the
> > > arm64 maintainers end up preferring?
> >
> > The 10-second timeout is hard-coded in nmi_trigger_cpumask_backtrace().
> > It is shared code and not architecture-specific. Currently, I haven't
> > thought of a feasible solution. I have also CC'd the authors of the
> > aforementioned patch to see if they have any other ideas.
>
> It should be possible for arm64 to have an architecture-specific hook
> that enables them to use a much shorter timeout.  Or, to eventually
> switch to real NMIs.

Note that:

* Switching to real NMIs is impossible on many existing arm64 CPUs.
The hardware support simply isn't there. Pseudo-NMIs should work fine
and are (in nearly all cases) just as good as NMIs but they have a
small performance impact. There are also compatibility issues with
some pre-existing bootloaders. ...so code can't assume even Pseudo-NMI
will work and needs to be able to fall back. Prior to my recent
changes arm64 CPUs wouldn't even do stacktraces in some scenarios. Now
at least they fall back to regular IPIs.

* Even if we decided that we absolutely had to disable stacktrades on
arm64 CPUs without some type of NMI, that won't fix arm32. arm32 has
been using regular IPIs for backtraces like this for many, many years.
Maybe folks don't care as much about arm32 anymore but it feels bad if
we totally break it.

IMO waiting 10 seconds for a backtrace is pretty crazy to begin with.
What about just changing that globally to 1 second? If not, it doesn't
feel like it would be impossibly hard to make an arch-specific
callback to choose the time and that callback could even take into
account whether we managed to get an NMI. I'd be happy to review such
a patch.

-Doug


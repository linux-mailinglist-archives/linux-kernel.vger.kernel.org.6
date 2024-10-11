Return-Path: <linux-kernel+bounces-361881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66099AE51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D96E28777A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C51D173F;
	Fri, 11 Oct 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anPUP/G1"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0A1D0F7D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683970; cv=none; b=bAnE1iedD2haToQmVhBf7ainFzD4v3tMBAX5QSwCDecdrKER8P0B9yVLPNBaWsS6my0tYs/m/pet8HKLuTD8dxONqfppYE5Y5KG/yB+Zh7K7atgr1qa072fDLz9qkasljxQ8wjhZfJ5OK87+K+AgErYvyIWDmPxtqWIsi2unYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683970; c=relaxed/simple;
	bh=L3zF4Rcc2RuIq/gLEbQW4A7mBM+oakBixRF5GSvBQBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mm/ddaI9uCYuDPUePm2VNeLS5x/HSuICYiMW/RB5o/fHCgc54e7RAxxWec2INT+kFN9WJjv5oqTsvQfPeDxKL9AzPf1Og2risLFAuSWOE0wq4oLd9OvQXtX3m8MGkDGJQn+j+IFpLlWCl1DxlznFMfS2JWIFm2CcuEPTQkTuJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anPUP/G1; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a47177cf6bso227592137.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728683968; x=1729288768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k7VDDT1YUOyH2lMqiN1RCUHYbTDQjQw36x/4vj46K8=;
        b=anPUP/G1wfNi5G4oFSdiztYlYQjjYQhw5VLURh4DvweFzHa/7gP3ZHmOqdp4a1Yn6v
         59o3lhCSJFXkhd0m2jAUfdMgpblAZr9HC4RyIrwqMcshPjUpUS4icTWwo4H+fup2F55Y
         t/5GbCeU5p8Lr65vFeS2PYJKmOZtbuSE8XsSqtRWpHkpONGWTdytnmun+u20jNI6BhXC
         T21dNmC3CxUhQxgpFSGMg1WFWu2tEjK8HYkBaaSJMMK74/GteOApFmxZHNVAs7lDHMJr
         YjBttKK2DVPUQYzuU2o61lpmMneTA4ukiIZ6HfvV+nWue20Zh1h6M0ryJp6BoDnafSex
         ATqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728683968; x=1729288768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7k7VDDT1YUOyH2lMqiN1RCUHYbTDQjQw36x/4vj46K8=;
        b=cEa+Nwg4hLF9AwGtMoIz7mrqYsF19G4dQ/TuyMIJJW1YRY4VwRXCgJb5YsiMO4OQIl
         mtu4HXmuU/dwvRP3+LuWbeu+zEVT2D7KgxYxpPfNl8vf6G52ITmwfl4fp2csz0QvqSRk
         Pr8Mv+MY6MqeUtFGlJ0Tkad0fec6AD3clq26ORkSTq+9i7TiCt8ck0wTUIonUmJkbU/N
         TeWrG/U1qs/GvcPst5DuuDKKarARj412w+nPbV68rc2l6tIMhPj9Ku34EsiQgLHEof0y
         8bW+nJ3+0950+aaTd+pF/UHGUHUlEC0XuL7Y10MvT6RklEERt4ss9sRxeR6itbh6vgn6
         isGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoqadcbHRhpLPZRFj1Zeebjff1bzPNJ4Ld+i4rB/NsFqsRDcMPj96vzU79vh/4x46jVJM6vJlxcRYllLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxARAcHk3yslWiBLyCbpvnkUNfSR5EqvdrmwsI7oxJ25xaxiFRv
	IY23tY5C8wYh4S+tZ2rIr3bz3Gpc5eXVnnEMGoeqCrKrKdZTPG9tItS37IO9Zzws+NGQDw3muX3
	gzjpO6vG0hoAebPCNRoCyW96qyVH2kwZch823
X-Google-Smtp-Source: AGHT+IGtoLDRR+ZP2gKCjdPIyccQzAfSiQwzBOLIFIB8MF3Yp2GP8aKxafdurozbqAky4MiDKCwSpTVZPXNFO35cEsg=
X-Received: by 2002:a05:6102:1620:b0:49b:cfbc:63ac with SMTP id
 ada2fe7eead31-4a475f04481mr1020027137.6.1728683967980; Fri, 11 Oct 2024
 14:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-strncpy-kernel-trace-trace_events_filter-c-v1-1-feed30820b83@google.com>
 <20241008211257.6c9c9f88@rorschach.local.home>
In-Reply-To: <20241008211257.6c9c9f88@rorschach.local.home>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 11 Oct 2024 14:59:16 -0700
Message-ID: <CAFhGd8pGaMxXpsk5gMS98223FW5wq-vQPyt1srVCrP_Fg6Ex9g@mail.gmail.com>
Subject: Re: [PATCH] tracing: replace multiple deprecated strncpy with strscpy
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 6:13=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> So this breaks my tests. This is why I have trouble with taking changes
> like this :-(

Shoot.

I think deprecated API cleanups are important but creating more bugs
in the process is not helping anybody. I dropped the ball here... my
patch has an off-by-one.

>
> Before this patch, his worked:
>
>  # echo 'common_pid !=3D 0 && common_pid !=3D 120 && common_pid !=3D 1253=
 && common_pid !=3D 17 && common_pid !=3D 394 && common_pid !=3D 81 && comm=
on_pid !=3D 87' > /sys/kernel/tracing/events/sched/sched_switch/filter

Thanks for providing the test case, this made triaging dead simple.

>
> But now it gives an error of:
>
>  -bash: echo: write error: Invalid argument
>
> I have to drop this.

In many cases where folks are doing 1) strncpy and 2) manual NUL-byte
assignment, the clear replacement is strscpy. However most of those
cases look like this:

  strncpy(dst, src, len);
  dst[len-1] =3D '\0';

and this case was just

  strncpy(dst, src, len);
  dst[len] =3D '\0';

Since we have an explicit size check before the first copy, ensuring
@len doesn't overflow @dst, this code is fine but I missed the
off-by-one.

So, assuming I haven't lost your faith, I can send a v2 along the lines of:

1)
  strscpy(num_buf, str + s, len + 1);

  ... or
2)
  memcpy(num_buf, str + s, len);
  num_buf[len] =3D 0;

And if you're wondering about option 3: "Don't change anything because
the code works". I'd reiterate that I think it's important to replace
bad ambiguous APIs. There are many cases where folks use strncpy() as
a glorified memcpy because they want the padding behavior, or they use
it on non-null terminated destinations or tons of other "misuses".
Ambiguous code like that poses a real danger to the maintainability of
the codebase and opens threat vectors.

>
> -- Steve

Thanks
Justin


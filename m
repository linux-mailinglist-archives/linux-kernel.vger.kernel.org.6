Return-Path: <linux-kernel+bounces-262444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F5193C731
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AE01C2204D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C055E19D09A;
	Thu, 25 Jul 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KCNe3Pcq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBC11711
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925029; cv=none; b=TozkvUG8jJxjLtsVoaxMubteyi86i8Wylpn73EasSGXxgSSJCE0G/cnQcyiiWWct2rDIGOlCn6m+AUCMMWhUyazyFkBWhk7odikEJj61NeFLnedMWmMFz3exBv401TWwEsaflQoy8KzZrPN1PqthfkwMnympHxfFkkkxtLn5lz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925029; c=relaxed/simple;
	bh=DC4MeU6mXWpnwE6MVTXi3Gi3ifUFHTzefUczB8aOZvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFoOT38G+9/7Qvw77OqM9qCRCmQC2RRoeJXKW5ZQUNKPApDuHjkC1bMedeEk2rSb6zIhQKHakQoL6gIno6cGz6w8gvvpqkA7AfOpPVu4m7uHrsiZquPlqGd3gmM2Pqy/pRdSUAc/FmvfI0WHgq68yhFL7yTPgTCEBiJRzMeSNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KCNe3Pcq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so3550901fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721925026; x=1722529826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+cFsERdeEfJ84bl3qIsdTQUULvzJTMHCuk9a47Nbl0=;
        b=KCNe3Pcqg8XSp+r+tt51dQ+8v2cVn9rZ3ei/84iVed9DrBO/hDfZbeOnA2fQrRzkgB
         S2XVK8zgj103QvA390zpjwpRW3rHaEK7K3JvhtE8YxsZtK8Z7bhOgJjspnPCgnW2JTkm
         YIJp6jzIao1ieoNrOyAsflJDr0GPNO4vFpzX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721925026; x=1722529826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+cFsERdeEfJ84bl3qIsdTQUULvzJTMHCuk9a47Nbl0=;
        b=br/HjzPmb5DBM4UGw7/fQhNqc1TeifutItiRMwmlJJbyYyuRaUUkD/uKaeFK2eg62H
         rdfmq0is9ZCoyOauXY4VKY90vZEtI4UGMQTr9G/jik5yVFDb67ruqEZdF/qJiYBHukgY
         Ic2/+v95PzP3OAD3eTk+OLEG+DvnSsdcnMT2jBJQvbnL3PD8mUAwq55EXxcdrCYevWwi
         OpxFx9wlKp5YUjbGz/Z6ukZLq9GBiIt5K6mK1ZtQi9dKKy3SswXjG7eF8nq29aFZD7TH
         uqAUTphMa4qM1LQq2GeghvxniHOlFJThtq3MZu+Ri4gehWOPzb6Xx4/U7bBKoo6DlR/A
         oZTw==
X-Forwarded-Encrypted: i=1; AJvYcCXunlivXQ0pWAxMAubmhE3R4at2R9+juVCuhJ9SwDPvVmhinWwJn17t1/cHmG17q8Jf5CQFpLwSnxCrHsnow2N4wf2oohuPBzdeMOSE
X-Gm-Message-State: AOJu0Yx9Fdye+cWc+vOz5J/QIdIIUANsfFiuNTFeRBjYVCBQI5igM503
	G0CPMF/2hKviYyvgoqIwirt55x7IN1MgBkzQCZp1A1Mjt/gg95BVlSReoRgFyiXn7w3JC6X4uMI
	GdpJb74PxjL3ia+Li8j9CmJnKjWY6RFxK57Ax
X-Google-Smtp-Source: AGHT+IFQCtJX0lcVlfp4yKL1Wno5LB1yFuAtPhcNHLgidDxIoZG6eqHwka28Z10Pk8gtSAH91SX0KQBO09Nj5EiVJLA=
X-Received: by 2002:a2e:6a02:0:b0:2ef:2f48:4053 with SMTP id
 38308e7fff4ca-2f03ac589e0mr8445361fa.25.1721925026161; Thu, 25 Jul 2024
 09:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
 <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net> <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
 <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
In-Reply-To: <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Thu, 25 Jul 2024 22:00:14 +0530
Message-ID: <CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
Subject: Re: tracing: user events UAF crash report
To: Mathias Krause <minipli@grsecurity.net>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, =?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@leemhuis.info, Dan Carpenter <dan.carpenter@linaro.org>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:45=E2=80=AFPM Ajay Kaher <ajay.kaher@broadcom.com=
> wrote:
>
> On Mon, Jul 22, 2024 at 5:38=E2=80=AFPM Mathias Krause <minipli@grsecurit=
y.net> wrote:
> >
> > On 22.07.24 13:13, Ajay Kaher wrote:
> > > On Sat, Jul 20, 2024 at 2:17=E2=80=AFAM Mathias Krause <minipli@grsec=
urity.net> wrote:
> > >>
> > >> I noticed, the user events ftrace selftest is crashing every now and
> > >> then in our automated tests. Digging into, I found that the followin=
g
> > >> is triggering the issue very reliable:
> > >>
> > >> - in one shell, as root:
> > >>   # while true; do ./kselftest/user_events/ftrace_test; done
> > >>
> > >> - in a second shell, again as root:
> > >>   # cd /sys/kernel/tracing
> > >>   # while true; do cat events/user_events/__test_event/format; done =
2>/dev/null
> > >>
> > >
> > > Tried to reproduced on 6.10.0-rc7-100.ph5+, only getting repeated out=
put as:
>
> < sending again after correcting alignments >
>
> Mathias, thanks for reporting. I am able to reproduce the 'KASAN:
> slab-use-after-free'.
>
> Steve, let me know if anything wrong in my investigation:
>
> [ 6264.339882] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 6264.339970] BUG: KASAN: slab-use-after-free in f_start+0x2b5/0x370
>
> This belongs to  f_start() ->  f_next() -> trace_get_fields():
>
>     trace_get_fields(struct trace_event_call *event_call)
>     {
>         if (!event_call->class->get_fields)
>         return &event_call->class->fields;
>         return event_call->class->get_fields(event_call);
>     }
>
> This happens while reading 'events/user_events/__test_event/format'.
>
>
> Allocation:
> [ 6264.347212] Allocated by task 3287:
> [ 6264.348247]  kasan_save_stack+0x26/0x50
> [ 6264.348256]  kasan_save_track+0x14/0x40
> [ 6264.348260]  kasan_save_alloc_info+0x37/0x50
> [ 6264.348265]  __kasan_kmalloc+0xb3/0xc0
> [ 6264.348268]  kmalloc_trace_noprof+0x168/0x330
> [ 6264.348280]  user_event_parse_cmd+0x57b/0x26c0
> [ 6264.348286]  user_events_ioctl+0xa92/0x1850
> [ 6264.348290]  __x64_sys_ioctl+0x138/0x1b0
> [ 6264.348295]  x64_sys_call+0x9a4/0x1f20
> [ 6264.348299]  do_syscall_64+0x4b/0x110
>
> user_event_parse_cmd() -> user_event_parse() {
>     .
>     user =3D kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
>
> Link: https://elixir.bootlin.com/linux/v6.10/source/kernel/trace/trace_ev=
ents_user.c#L2118
>
>
> Freed:
> [ 6264.350333]  kfree+0xd1/0x2b0
> [ 6264.350337]  destroy_user_event.part.0+0x313/0x450
> [ 6264.350341]  destroy_user_event+0x129/0x1a0
> [ 6264.350344]  delayed_destroy_user_event+0x62/0xd0
> [ 6264.350347]  process_one_work+0x621/0xf60
> [ 6264.350359]  worker_thread+0x760/0x14f0
>
> static int destroy_user_event(struct user_event *user) {
>     .
>     kfree(user->call.print_fmt);
>     kfree(EVENT_NAME(user));
>     kfree(user);  <--
>
> Link: https://elixir.bootlin.com/linux/v6.10/source/kernel/trace/trace_ev=
ents_user.c#L1510
>
>
> Race condition:
>
> Thread A i.e. event reader able to reach the f_start() as the path is
> valid. Thread A waiting for lock. At the sametime, Thread B has
> acquired lock and removing events entry followed by free the
> user_event object. Later once Thread A got the lock it tried to read
> address which belongs to struct trace_event_call (struct
> trace_event_call is member of struct user_event)
>
> Thread A (read event)                      Thread B (remove event)
>
> .                                                        worker_thread()
> .
> delayed_destroy_user_event()
> .                                                               ->
> acquire event_mutex
> .                                                        destroy_user_eve=
nt()
> vfs_read()                                         .
> seq_read()                                        .
> f_start() -> acquire event_mutex      eventfs_remove_dir()
> . (waiting)                                          kfree(user)
> . (waiting)                                          -> released event_mu=
tex
> acquired event_mutex
> f_next()
> trace_get_fields():
>

Thread A (read event)                      Thread B (remove event)

.                                          worker_thread()
.                                          delayed_destroy_user_event()
.                                                   -> acquire event_mutex
.                                          destroy_user_event()
vfs_read()                                 .
seq_read()                                .
f_start() -> acquire event_mutex           eventfs_remove_dir()
. (waiting)                                kfree(user)
. (waiting)                                 -> released event_mutex
acquired event_mutex
f_next()
trace_get_fields():

- Ajay

> I think you have added the following check in f_start() to prevent
> this race condition, but somehow with eventfs still some gap to race cond=
ition.
>
> static void *f_start(struct seq_file *m, loff_t *pos) {
>     mutex_lock(&event_mutex);
>     if (!event_file_data(m->private))   <--
>         return ERR_PTR(-ENODEV);
>
> -Ajay


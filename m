Return-Path: <linux-kernel+bounces-262431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B6693C708
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5271C1F21A84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904519CCE6;
	Thu, 25 Jul 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="djpiN/rJ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A719AD56
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924119; cv=none; b=iYf1T6vMfyVRMrvwoANMKukEjS/6gNRdzZXAY8JM5xrqZlYZFI2ZzyARRBW80wRqiPtbOrodmleqLHWZabkmM38EhyOHoRhZG8Vn3+lM9UU0Q9a2LaEDAB1yrU0ycSMv8KsR7quM6Z4EZZjfgUwNKKXiAls7K7Bnb10qJ9tqF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924119; c=relaxed/simple;
	bh=KsmBR35IoKj6WvqHnz549u6Olcs9Ejy6LjgG5Ax/xtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKT7iId0VCPPlJWHombQcS3YCNCFoojhrD3N3W3V8AvqOTOdwyKVs/0GqqMCBc7KLlFoPywsDv9alSmA9ZjC1goiTzSpatzuG9iRlw/+7uHKdPuI37cGkFYjleI14qnlQq7E1p8M2Bh2V9mvyIDRkktwDthl1ECsZ5Rp8TSa7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=djpiN/rJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so531895e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721924116; x=1722528916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X24iqFPhN/veNI0jK8M8gvWQqF7euNhFWEULh50n+XY=;
        b=djpiN/rJk9LFTEl8k23V+99HWqjWLQCm3hTaeZFGElTyEXC2C9MauDf62FuZSTBr7U
         iNXvpPcWkWq8rTYzfe9ER/UJz71HOtr7aVtjdvfz/kcbLqAQ9XVjFrajKu/v+H1NzYUm
         ggpuNCZpjgJ8qz0R8qGO2DlkgRkk1BEh3EMGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721924116; x=1722528916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X24iqFPhN/veNI0jK8M8gvWQqF7euNhFWEULh50n+XY=;
        b=iL/HXbWq68d24a0yJ5OFehHQdrL9OpZfdz5aMQjNwGnukaJxc8msgqZ4J4h3jCRx3b
         EOsR7cDH+Ay7GCf9SurpnzDlUAzzLallbkm8aNBSioJVov8yEhnZHVQDZZASX0OTyooF
         zd69SzVYipt9I7GSOX2ChjxknnlpCFT8tk/cYasBNeyEKFsE+m8yooF6exOEaeGLtkbQ
         q4Brfd4l/kolCwrWD0jptqCK0+bTkeevRyDFYl/mnWOR5gxlnUPhAxv9BWNJfjv4Ck9a
         0frrYjnBSg2x0o/8tFvKkXYhLAuTnadPhlfrYpLRcmNTulxpi8F6bt1hyybQe20Lr47W
         WsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzAIKFDMvN78iJk67fk9iN7NHI82oOtml2jT3MzKaidOFukhhiGy/62oCfEkioFaiRibgIHsfsI0g8/C2NDixcQL5Y+dChaOaWLMrx
X-Gm-Message-State: AOJu0Yy94SPw43yAUaHvAWE5t2zgrMuFFfq4GwTcZbawHDO046nReGEf
	vwGVXB9q00DT19D64gua+i1w4iFrS0ODTCn8d7X2CCGmHy3DSvRHy34mUzy27eBk3jIB5n9Evco
	z+MEmBaUbI5amPQhdkHTmKYG9t9B3wwJfn7iY
X-Google-Smtp-Source: AGHT+IEvGFhGtBnhFb5TyZDINWtDnD2va7Q+SQc3dO9NShG/ck5Z+8UPrx/FmWmbr8+B+rBwVbff+k5CYp4Z1gziFQg=
X-Received: by 2002:a05:6512:2356:b0:52f:341:6e16 with SMTP id
 2adb3069b0e04-52fd3f6bcd3mr2516836e87.46.1721924116359; Thu, 25 Jul 2024
 09:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
 <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net> <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
In-Reply-To: <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Thu, 25 Jul 2024 21:45:03 +0530
Message-ID: <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
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

On Mon, Jul 22, 2024 at 5:38=E2=80=AFPM Mathias Krause <minipli@grsecurity.=
net> wrote:
>
> On 22.07.24 13:13, Ajay Kaher wrote:
> > On Sat, Jul 20, 2024 at 2:17=E2=80=AFAM Mathias Krause <minipli@grsecur=
ity.net> wrote:
> >>
> >> I noticed, the user events ftrace selftest is crashing every now and
> >> then in our automated tests. Digging into, I found that the following
> >> is triggering the issue very reliable:
> >>
> >> - in one shell, as root:
> >>   # while true; do ./kselftest/user_events/ftrace_test; done
> >>
> >> - in a second shell, again as root:
> >>   # cd /sys/kernel/tracing
> >>   # while true; do cat events/user_events/__test_event/format; done 2>=
/dev/null
> >>
> >
> > Tried to reproduced on 6.10.0-rc7-100.ph5+, only getting repeated outpu=
t as:

< sending again after correcting alignments >

Mathias, thanks for reporting. I am able to reproduce the 'KASAN:
slab-use-after-free'.

Steve, let me know if anything wrong in my investigation:

[ 6264.339882] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 6264.339970] BUG: KASAN: slab-use-after-free in f_start+0x2b5/0x370

This belongs to  f_start() ->  f_next() -> trace_get_fields():

    trace_get_fields(struct trace_event_call *event_call)
    {
        if (!event_call->class->get_fields)
        return &event_call->class->fields;
        return event_call->class->get_fields(event_call);
    }

This happens while reading 'events/user_events/__test_event/format'.


Allocation:
[ 6264.347212] Allocated by task 3287:
[ 6264.348247]  kasan_save_stack+0x26/0x50
[ 6264.348256]  kasan_save_track+0x14/0x40
[ 6264.348260]  kasan_save_alloc_info+0x37/0x50
[ 6264.348265]  __kasan_kmalloc+0xb3/0xc0
[ 6264.348268]  kmalloc_trace_noprof+0x168/0x330
[ 6264.348280]  user_event_parse_cmd+0x57b/0x26c0
[ 6264.348286]  user_events_ioctl+0xa92/0x1850
[ 6264.348290]  __x64_sys_ioctl+0x138/0x1b0
[ 6264.348295]  x64_sys_call+0x9a4/0x1f20
[ 6264.348299]  do_syscall_64+0x4b/0x110

user_event_parse_cmd() -> user_event_parse() {
    .
    user =3D kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);

Link: https://elixir.bootlin.com/linux/v6.10/source/kernel/trace/trace_even=
ts_user.c#L2118


Freed:
[ 6264.350333]  kfree+0xd1/0x2b0
[ 6264.350337]  destroy_user_event.part.0+0x313/0x450
[ 6264.350341]  destroy_user_event+0x129/0x1a0
[ 6264.350344]  delayed_destroy_user_event+0x62/0xd0
[ 6264.350347]  process_one_work+0x621/0xf60
[ 6264.350359]  worker_thread+0x760/0x14f0

static int destroy_user_event(struct user_event *user) {
    .
    kfree(user->call.print_fmt);
    kfree(EVENT_NAME(user));
    kfree(user);  <--

Link: https://elixir.bootlin.com/linux/v6.10/source/kernel/trace/trace_even=
ts_user.c#L1510


Race condition:

Thread A i.e. event reader able to reach the f_start() as the path is
valid. Thread A waiting for lock. At the sametime, Thread B has
acquired lock and removing events entry followed by free the
user_event object. Later once Thread A got the lock it tried to read
address which belongs to struct trace_event_call (struct
trace_event_call is member of struct user_event)

Thread A (read event)                      Thread B (remove event)

.                                                        worker_thread()
.
delayed_destroy_user_event()
.                                                               ->
acquire event_mutex
.                                                        destroy_user_event=
()
vfs_read()                                         .
seq_read()                                        .
f_start() -> acquire event_mutex      eventfs_remove_dir()
. (waiting)                                          kfree(user)
. (waiting)                                          -> released event_mute=
x
acquired event_mutex
f_next()
trace_get_fields():

I think you have added the following check in f_start() to prevent
this race condition, but somehow with eventfs still some gap to race condit=
ion.

static void *f_start(struct seq_file *m, loff_t *pos) {
    mutex_lock(&event_mutex);
    if (!event_file_data(m->private))   <--
        return ERR_PTR(-ENODEV);

-Ajay


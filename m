Return-Path: <linux-kernel+bounces-425183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382429DBE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC157164BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA814C5B0;
	Fri, 29 Nov 2024 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4lW5wrG"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195618E2A;
	Fri, 29 Nov 2024 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732846653; cv=none; b=eqlIIf7KNZCFLWZDaqoAD2t/tLXF/CHKc4K1t+5CqbWv/L6UMAWMZwWJAAijDL+bEk8zOyazRPWoSLu69bDUeIvh7X4VAjjvY3y93GSVcc9uMrdhoNnW0mnbMW9H2xTTSfKCPv2xYGnVIrJqSq5lRhWeS+YoXPvKlDuQxAUG/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732846653; c=relaxed/simple;
	bh=Rx8+0O8czRr7Qa/0tGBfEQME2qwGrUiSZZ0DZ2GyYJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh2ZNYhZX3gigXBJYJdWW1do+5TnCgbNMkalZdU21mzIpCxTVplS3bd5kqQsYmW2HzDuM+mugEz+WrW1o7c8KQHcej5TYNn+X6eIiXwQmF73WCQMnX0NSzkTHr1UIkJyeQ2uqRlBDIIK7vxjtvQz5s7YGtzaves1JFK0hRJXaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4lW5wrG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-466879f84ccso10411691cf.1;
        Thu, 28 Nov 2024 18:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732846651; x=1733451451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GTy5dtLJtakTFk4AV+rBlblmxA1jcm8qlFiwJK+utQ=;
        b=e4lW5wrG+5FJG2uu5OM+DI/tVXI4meRFuqBnr0Xos2uk99PqSTs8JOUQ/1wfAqYMtp
         Hi4pqOzpHeXzi8osQ6D9Als9TFJaw1c0ifkckSdaOW0ch6vQVhqz1AGa96JZJYzAOm7t
         w+MedrrGa8juEhNRWPUCzcz9S/Hq2yIPlw7YMF+0z2oTYH+VFiv7txa6EP2X4JQKfz4b
         VLY7WZz3yfEtXBQ1k2Xqsi3v2K/kPArKsj9yc94r7+qRxdh4ndWcyxF6wxdzH/KMqsQW
         GvvhzX0d/g1MrO1CAv0AvhJm2G2kIhVclP12jbq7qLyAOhz+ZN1noR/JbhQiSsH2qaut
         2I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732846651; x=1733451451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GTy5dtLJtakTFk4AV+rBlblmxA1jcm8qlFiwJK+utQ=;
        b=UftsoPVO2TpDq/rt4ch9rdRuPh6dAB9JR7TpasXuD0PX0X22FSYEl8spVjnKF85pcz
         jZ+PWMg5EXVZdviLJ/thtnJncwCBA65i/UETAOlrQ0jkiSY8jSEY+OL0orWWYiXbUw2D
         0OXPuc25hD0uWgm3PLs/8c6mma/d5DjBQhODSrbmLjb70g/w/+A4R4LEEOSjueUxhL+s
         8Lu0aLUT4m4y5DJAW2CcjtnhkdLzdokzzxuTo6eWzA0/MCSabYComZy5++ZqJW+MaPXW
         wf+mvK0wlisv7HVLZb1yeoT+3D4WUOfBc2ePAq3EfgTqkf88fgQqEG+3ulnmZq1ANKrR
         2Bmw==
X-Forwarded-Encrypted: i=1; AJvYcCUfdkU+Wad39X3yjUQQgZjNVL5iqwSctUf6uRPplFpu35b2Me6CdKpHurXGu2HJU0/5B/x//bjY0ZaBrWg=@vger.kernel.org, AJvYcCW5RGdz/GBx9F8nxgX1rzgXIJLoeudNjvMkeTtj+0y5IBf1/WWr2IVSkc6//Z6uM/6ndbCVVZWgC1As/Oyji/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdcqhk4wN3HXtBaZa8NtuhHd3Fer7FGUteex+dQKDCpHcg5XQl
	EAESAAh+6+503VO38h8Pcc2qHfai4dqwP94C7W7cFal7cHqKvxUDrBpfbvoawDh/loJyemqt5VS
	dVMk+/mNIs7WL+eJTm3iEzC9bvCg=
X-Gm-Gg: ASbGncvJSwd7NzX5/JF9KoubB5Klnni3uqUBKm5HBlrVlTjXlt/RIS7VjUqHQpZL8zQ
	jQikj425z7R7Elkyy88kUSbSa0lBAp/mEVw==
X-Google-Smtp-Source: AGHT+IHiZEdEHw5JuP343HuhAmEskT0RXNHgq7CJaOUriJQA0VxkX53ArI8GDBRLubyNAQ6a7yX7Y3N+1IUcJgCOHbU=
X-Received: by 2002:ad4:5766:0:b0:6cb:ce4c:1cc1 with SMTP id
 6a1803df08f44-6d864d1f41dmr138062366d6.20.1732846650636; Thu, 28 Nov 2024
 18:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127131941.3444fbd9@gandalf.local.home> <CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
 <20241128155120.6e6cd300@rorschach.local.home> <20241128182435.57a1ea6f@gandalf.local.home>
In-Reply-To: <20241128182435.57a1ea6f@gandalf.local.home>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 Nov 2024 10:16:54 +0800
Message-ID: <CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpWX3ZkVtvQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: More updates for 6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 7:23=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 28 Nov 2024 15:51:20 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > >
> > > I've pushed out my resolution, and hopefully rust people can actually
> > > test it. I might just be full of it.
> >
> > Looks better than what I had. I'll kick my tests on it just as a sanity
> > check.
>
> And my tests failed. But not for this change. The build failed. Config at=
tached:
>
>   CC      kernel/time/tick-broadcast.o
> In file included from /work/build/trace/nobackup/linux-test.git/include/l=
inux/string.h:390,
>                  from /work/build/trace/nobackup/linux-test.git/include/l=
inux/bitmap.h:13,
>                  from /work/build/trace/nobackup/linux-test.git/include/l=
inux/cpumask.h:12,
>                  from /work/build/trace/nobackup/linux-test.git/include/l=
inux/smp.h:13,
>                  from /work/build/trace/nobackup/linux-test.git/include/l=
inux/lockdep.h:14,
>                  from /work/build/trace/nobackup/linux-test.git/include/l=
inux/spinlock.h:63,
>                  from /work/build/trace/nobackup/linux-test.git/include/l=
inux/wait.h:9,
>                  from /work/build/trace/nobackup/linux-test.git/include/l=
inux/wait_bit.h:8,
>                  from /work/build/trace/nobackup/linux-test.git/include/l=
inux/fs.h:6,
>                  from /work/build/trace/nobackup/linux-test.git/kernel/au=
ditsc.c:37:
> In function =E2=80=98sized_strscpy=E2=80=99,
>     inlined from =E2=80=98__audit_ptrace=E2=80=99 at /work/build/trace/no=
backup/linux-test.git/kernel/auditsc.c:2732:2:
> /work/build/trace/nobackup/linux-test.git/include/linux/fortify-string.h:=
293:17: error: call to =E2=80=98__write_overflow=E2=80=99 declared with att=
ribute error: detected write beyond size of object (1st parameter)
>   293 |                 __write_overflow();
>       |                 ^~~~~~~~~~~~~~~~~~
>   CC      arch/x86/kernel/tracepoint.o
> In function =E2=80=98sized_strscpy=E2=80=99,
>     inlined from =E2=80=98audit_signal_info_syscall=E2=80=99 at /work/bui=
ld/trace/nobackup/linux-test.git/kernel/auditsc.c:2759:3:
> /work/build/trace/nobackup/linux-test.git/include/linux/fortify-string.h:=
293:17: error: call to =E2=80=98__write_overflow=E2=80=99 declared with att=
ribute error: detected write beyond size of object (1st parameter)
>   293 |                 __write_overflow();
>       |                 ^~~~~~~~~~~~~~~~~~
>   AR      drivers/nvmem/built-in.a
> make[4]: *** [/work/build/trace/nobackup/linux-test.git/scripts/Makefile.=
build:229: kernel/auditsc.o] Error 1
>
> I'm currently too busy eating turkey, so I'll let someone else figure thi=
s out.

The issue appears to be a known GCC bug, though the root cause remains
unclear at this time.

A potential workaround has been proposed, which you can find here:
https://lore.kernel.org/linux-hardening/202410171059.C2C395030@keescook/

However, it seems that the patch has not yet been accepted into the mainlin=
e.


--
Regards
Yafang


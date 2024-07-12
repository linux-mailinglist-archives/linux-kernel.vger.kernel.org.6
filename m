Return-Path: <linux-kernel+bounces-251174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A274930187
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDBD1F241BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B504DA0F;
	Fri, 12 Jul 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMmOY2H0"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD44965D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819213; cv=none; b=olJfQkGOU7nAxtUDoSyeSBtIcWQK5yBN3zY8243kjQD/ZZU5VWUwmOI86N5OmlupLvm6+utoqHgClSKgjtm3+cqElKjPRLLH+AmptiLWlSZkMYp3ZN10kMPym8VUeqG1PP1YKkZsRnj3yvu0INNTgT5q1dtV5ISxrkbVz7mcC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819213; c=relaxed/simple;
	bh=ieKkCfABzSmVpeaGxlvYCQ+TsKxuO/5Szv0cGhXWULA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdqmjvcEg/PljRHZA4zzNBgzwx0kvYnIv7YN2jeQtkUMgbRqYHF8Hkye0DOVGnFpqSDukSYolvfWtnmToBhISyGo//H48RZZ5tBTtbwVriUZCLq3cPR9Iq3nL8KDg901sbGNHSA2UkAw8VT8sW4EwePKEZEHWQKClDmiHESwsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMmOY2H0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44a8b140a1bso81011cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720819210; x=1721424010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTThe4McXMiwH5OOudIyzmGIb6Rw2NrtRU7kH3ILb2k=;
        b=JMmOY2H0swyYeThpsbYdUEJCijhgqiIS1tveTxiWnCivcQD+ESIQdoORDq6oOjgbw8
         B0Ahkkm/XZ41GDwWHYav/0TI6AiTtseksQiFi8BfIurfn1iqCXCc+N/B0r2cpHrQKxZR
         2wea8sZYkltJFHC0x0MBW744vvCOw07w94mrU0hwr2d17rhZB+KFD9w74rUP2wxfCljp
         iZQSh5QaMpmhZj3ZUDJ6yrYyDI+iJUssDNRmMCw1i6Pj4dl/6No9bn2TDiEvZ/OChUMT
         daCLH9quFNYY+lknki2lmxsoyMYF53QztENaVJMCtMnmGLgaDG+qyVpZIgp6Yc9m8d7n
         uUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720819210; x=1721424010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTThe4McXMiwH5OOudIyzmGIb6Rw2NrtRU7kH3ILb2k=;
        b=XVjqjDFm4j+vou6LuySfq87Uoj9rwRdOAexqRjyqW7H8EJNLrVQtYmFTj5hZPyX9W8
         KfFogdpCY58Fnl3V+4KtJScAi6nlVFWcYSNrbvmTd3vXZlI5Rpfp8qYzSIyDgzg5MqDH
         wb7ISLkoMu182/4SCInJoiMVLCpeOH7JnBB7hG3RF2m/lCG8VRnGg9lg2AXHQSjah3R+
         7ToklRkwe3hCUa9iJFXe8jPXPZZVTEfQwA6o1qzCSFmnkrrDTv8olK2/NFAFlznroPfr
         HV0m7btKQ6QN2hAm5yMhKb7cV2pnWp8bXQCqhrEuIaLGs7+R/UkEjEfYmIJJvL8fX5qs
         wn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOmLMi5Wpq+DEP7m82AHMaCR+ffjOHv20yywrSY7stWcnAMtKpOPNmpR080Wwa2/0mU+VpZBR3tV/nkO25bx/8kHCWpAa6ZN3+jbqa
X-Gm-Message-State: AOJu0YwQtEiiVPYfOVMnT253OxXa5xI8mRFt6oGSBpLOqADdhUHiNVql
	Bf9NcqOLWReyZqOn8LG9hcB7UvAjhi7KUb+d0gqcI9SLPRNQBrK4UnArVkIn3Tx0TefoDC2lgoZ
	2SqJFH1FkGmF9W/aoM9W4pAZ1lbQ6KguEX5fQ
X-Google-Smtp-Source: AGHT+IGgdzFjYuXvqO7N7p76ZBla1i0WOa+AlzlygZUDin7E+bNSQp1jf02ZvQzzQ+L0tswiRpCLX5jdOh/CbKR9A6o=
X-Received: by 2002:a05:622a:4d4a:b0:447:ec33:f488 with SMTP id
 d75a77b69052e-44f5a2abe18mr724761cf.4.1720819210219; Fri, 12 Jul 2024
 14:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701044236.475098-1-irogers@google.com> <20240701044236.475098-2-irogers@google.com>
 <ZoTETvgcPdl9EUJV@google.com> <CAP-5=fV4oPEjX2fh3aeBbmBGgYJGCdBnVjTZ2XnCCgnTSa0LTw@mail.gmail.com>
 <ZpGTHzfIeREt5VUO@google.com>
In-Reply-To: <ZpGTHzfIeREt5VUO@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 12 Jul 2024 14:19:58 -0700
Message-ID: <CAP-5=fXZGTbXZkyW7QLTYU6vZkiiTSvJrBigcN=QYiaP3C9n5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools subcmd: Add non-waitpid check_if_command_finished()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 1:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Jul 02, 2024 at 09:24:50PM -0700, Ian Rogers wrote:
> > On Tue, Jul 2, 2024 at 8:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Sun, Jun 30, 2024 at 09:42:35PM -0700, Ian Rogers wrote:
> > > > Using waitpid can cause stdout/stderr of the child process to be
> > > > lost. Use Linux's /prod/<pid>/status file to determine if the proce=
ss
> > > > has reached the zombie state. Use the 'status' file rather than 'st=
at'
> > > > to avoid issues around skipping the process name.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/lib/subcmd/run-command.c | 33 ++++++++++++++++++++++++++++++=
+++
> > > >  1 file changed, 33 insertions(+)
> > > >
> > > > diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-=
command.c
> > > > index 4e3a557a2f37..ec06683e77a0 100644
> > > > --- a/tools/lib/subcmd/run-command.c
> > > > +++ b/tools/lib/subcmd/run-command.c
> > > > @@ -2,6 +2,7 @@
> > > >  #include <unistd.h>
> > > >  #include <sys/types.h>
> > > >  #include <sys/stat.h>
> > > > +#include <ctype.h>
> > > >  #include <fcntl.h>
> > > >  #include <string.h>
> > > >  #include <linux/string.h>
> > > > @@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process =
*cmd, bool block)
> > > >
> > > >  int check_if_command_finished(struct child_process *cmd)
> > > >  {
> > > > +#ifdef __linux__
> > >
> > > Is this really necessary?  I don't think we plan to support other OS.=
.
> >
> > I don't think it'd be unreasonable to say run "perf report" on
> > Windows, or using wasm inside a web browser. Part of the reason for
> > doing things this way was to keep the WNOHANG logic although this
> > change no longer uses it for __linux__.
>
> I'm not sure we are ready to run it on other platforms.  So I think
> it's better simply remove it for now.

So in the office hours there was some discussion with a potential new
contributor whose development platform is OS/X. It's fairly obvious
this code can't work on anything but Linux and using #error feels
annoying. The waitpid code is tested and has a known issue, but I
think it is better than just breaking anyone not on Linux.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > > > +     char filename[FILENAME_MAX + 12];
> > > > +     char status_line[256];
> > > > +     FILE *status_file;
> > > > +
> > > > +     /*
> > > > +      * Check by reading /proc/<pid>/status as calling waitpid cau=
ses
> > > > +      * stdout/stderr to be closed and data lost.
> > > > +      */
> > > > +     sprintf(filename, "/proc/%d/status", cmd->pid);
> > > > +     status_file =3D fopen(filename, "r");
> > > > +     if (status_file =3D=3D NULL) {
> > > > +             /* Open failed assume finish_command was called. */
> > > > +             return true;
> > > > +     }
> > > > +     while (fgets(status_line, sizeof(status_line), status_file) !=
=3D NULL) {
> > > > +             char *p;
> > > > +
> > > > +             if (strncmp(status_line, "State:", 6))
> > > > +                     continue;
> > > > +
> > > > +             fclose(status_file);
> > > > +             p =3D status_line + 6;
> > > > +             while (isspace(*p))
> > > > +                     p++;
> > > > +             return *p =3D=3D 'Z';
> > > > +     }
> > > > +     /* Read failed assume finish_command was called. */
> > > > +     fclose(status_file);
> > > > +     return true;
> > > > +#else
> > > >       wait_or_whine(cmd, /*block=3D*/false);
> > > >       return cmd->finished;
> > > > +#endif
> > > >  }
> > > >
> > > >  int finish_command(struct child_process *cmd)
> > > > --
> > > > 2.45.2.803.g4e1b14247a-goog
> > > >


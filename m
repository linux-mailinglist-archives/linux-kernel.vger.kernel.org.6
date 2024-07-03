Return-Path: <linux-kernel+bounces-238860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74128925279
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F67B2BAAD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13113792A;
	Wed,  3 Jul 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpohvmnE"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D391369A5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980705; cv=none; b=pxh0j0Mqyp01FeZHJk8lE/Gzi12kQsCSYEIKM9z8nwijsSh+Mktpnz4v0+WtOnLOabpJdwcVyNUT2GhvQfMjdqwC6UT43GrisFr3iXKARpSL9/ILK7+md0hqFj0mcuACTBhf2skeKl7rz/ZaKPcLYymZ6JHrp7NBqOOWvFVcFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980705; c=relaxed/simple;
	bh=8VdMgVQNgRvTZnucNBOBAewo64rcQIjXEpqdBB8CK0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvYxgpFpwPf8scwMeyTHvfoGiM0HI8gu+kvuJ98BFGFtepkD+L/9VrGlefN7tWgZI8HlPxaEYQ7Qz9xzsPsS+ZyhwMzYN3nCkk0h07FoT8PlhkcOoiLJAY/qJdf9Btax2zdq+d16U5ouGEtQQkwU/OuXyWB2zmWhF1yZYM8nzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SpohvmnE; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3815ad8adc9so106055ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 21:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719980703; x=1720585503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qolYKceaQM3wxra3wJYAlWpnZhkqkPu7RyFCFJoiofo=;
        b=SpohvmnEYlUyaqcCBwWGi6vHlPnvwRyYVrC1OPIlko69D0VvBsIOpWDSsASoSryCue
         NP9i2/BC3Ip8TokQKrUOWkOoWdbtA2j+f1W2pzYRYcg6cmhVtSNNS6aGUphUFxU+Ye1V
         5IMtJRQLo5diFH5zWMQ2fNHVf6wXyGngcf2o15iKzrpl3Wwhrtu37AugFjYTn8rn/lIl
         berkrDgBALNTOq1l4aXWmflVXMKXVR3HmB2YRtkd6rc/+bBBKkvVp2A2TLOAss0rbPyE
         x2Gh9zXe4n9BAe+CPiEjkdwKdDYc6EwGQVY5XrlzKkqGydpEGnJCh/OHsOwU9OZyWrue
         pKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719980703; x=1720585503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qolYKceaQM3wxra3wJYAlWpnZhkqkPu7RyFCFJoiofo=;
        b=Xg7fkG5mtTaA0St5fA/7/p/TypW2h4uCbLEGdHHXhXa1/u40vhZi5wsSZkwvUJKWde
         RjKhFYHrgx+zMHgBwF2ByCjezPh+a9q8lDIx5V5MDloBqNjvIyl0I56xrZBEaP2RljLe
         uEUFm5Kp/EjDa9QQ1/x3ZQODSc69O2wbGKx/DlBAcQPZrchkLEEK+m8mr9XBVjMA2vmB
         8XkPd/9E/tCOm0xukabmTeoGnROGYm3ehxc8iukWNi2DI1BHtG+0gUWTpCrQ/24gMvy0
         FQObx1hV5CAfq8FKyswS3+YfzaxDjaKWSY5M76F01mkjyGYMaug1xupRRkAELMtI3QN+
         8HIA==
X-Forwarded-Encrypted: i=1; AJvYcCXOxCAeqYq0vJwiL7aYxtZetYpOKtZrPk495VnaPCc1jJ/1MYpL1j2PJ2XsCkFQpSb4/vv/B05UJEFxIupTFqmzfwgpCI5fJihWJj4Q
X-Gm-Message-State: AOJu0Yx3lPiOvetd+ksnP7F7NpXhwt45POjAd/1s2QcCS2CjSi/I+CdT
	qySap8X0oAshRX0g3tg25L5pTHZ2fTOBMVbConcoMfbGDlZswq1v6uUnNySecfqvZ1aK7TJocjl
	HCkrp4UVZO0RowECD4HCEpRYhfcJ2AixfeyyK
X-Google-Smtp-Source: AGHT+IEd4H0LXcO28ppdVYo7jm3V/vwaPWfhMWiyR4uZ05zuc8mm4R3swqQOD9B4CdTXT+7eJ4ir+/pgWJdPiiEvTOc=
X-Received: by 2002:a05:6e02:1d1e:b0:376:3998:9629 with SMTP id
 e9e14a558f8ab-3820cbf3e39mr1499795ab.13.1719980702601; Tue, 02 Jul 2024
 21:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701044236.475098-1-irogers@google.com> <20240701044236.475098-2-irogers@google.com>
 <ZoTETvgcPdl9EUJV@google.com>
In-Reply-To: <ZoTETvgcPdl9EUJV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jul 2024 21:24:50 -0700
Message-ID: <CAP-5=fV4oPEjX2fh3aeBbmBGgYJGCdBnVjTZ2XnCCgnTSa0LTw@mail.gmail.com>
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

On Tue, Jul 2, 2024 at 8:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Sun, Jun 30, 2024 at 09:42:35PM -0700, Ian Rogers wrote:
> > Using waitpid can cause stdout/stderr of the child process to be
> > lost. Use Linux's /prod/<pid>/status file to determine if the process
> > has reached the zombie state. Use the 'status' file rather than 'stat'
> > to avoid issues around skipping the process name.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-comm=
and.c
> > index 4e3a557a2f37..ec06683e77a0 100644
> > --- a/tools/lib/subcmd/run-command.c
> > +++ b/tools/lib/subcmd/run-command.c
> > @@ -2,6 +2,7 @@
> >  #include <unistd.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > +#include <ctype.h>
> >  #include <fcntl.h>
> >  #include <string.h>
> >  #include <linux/string.h>
> > @@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process *cmd=
, bool block)
> >
> >  int check_if_command_finished(struct child_process *cmd)
> >  {
> > +#ifdef __linux__
>
> Is this really necessary?  I don't think we plan to support other OS..

I don't think it'd be unreasonable to say run "perf report" on
Windows, or using wasm inside a web browser. Part of the reason for
doing things this way was to keep the WNOHANG logic although this
change no longer uses it for __linux__.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +     char filename[FILENAME_MAX + 12];
> > +     char status_line[256];
> > +     FILE *status_file;
> > +
> > +     /*
> > +      * Check by reading /proc/<pid>/status as calling waitpid causes
> > +      * stdout/stderr to be closed and data lost.
> > +      */
> > +     sprintf(filename, "/proc/%d/status", cmd->pid);
> > +     status_file =3D fopen(filename, "r");
> > +     if (status_file =3D=3D NULL) {
> > +             /* Open failed assume finish_command was called. */
> > +             return true;
> > +     }
> > +     while (fgets(status_line, sizeof(status_line), status_file) !=3D =
NULL) {
> > +             char *p;
> > +
> > +             if (strncmp(status_line, "State:", 6))
> > +                     continue;
> > +
> > +             fclose(status_file);
> > +             p =3D status_line + 6;
> > +             while (isspace(*p))
> > +                     p++;
> > +             return *p =3D=3D 'Z';
> > +     }
> > +     /* Read failed assume finish_command was called. */
> > +     fclose(status_file);
> > +     return true;
> > +#else
> >       wait_or_whine(cmd, /*block=3D*/false);
> >       return cmd->finished;
> > +#endif
> >  }
> >
> >  int finish_command(struct child_process *cmd)
> > --
> > 2.45.2.803.g4e1b14247a-goog
> >


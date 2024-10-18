Return-Path: <linux-kernel+bounces-372105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1A39A447E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379CFB21646
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7395204941;
	Fri, 18 Oct 2024 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fW4Jfc0u"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6B204008
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271898; cv=none; b=rCXDmnr3ST81jFo4Ql+QVjB9jxsM0I+sthw78kqtrSHPc0xmg1YNPcz+SJaRDoZU9vjROI36m9m8PhIcoFEMEawk1GMYrcp8M7o/YPd6M8sYl7HYFIbRPryp2QSza3LdHRmr03H8Ndfrb8+RsoMierDcSTSXWRsS3MdQyZXMD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271898; c=relaxed/simple;
	bh=EA+x5cl2Rxs/ilxVGkU8fQDbcazoSSqo8tCFHtz+SMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lot6J1T/SfEEuC8c+NUh+gWV0CNmLGqFNwf1rnnjZg4zvRMd5gKX5ltxxTKPt/C2QvwzvNKNC+CxsqArmp1EweAsfWAkDiBu4uyncj5DqrZZuHv6IDISQMKNsolFGOKNAAhsM1N+Xqe38g/RCAbYDBlnzy99BJbir5uWwaPe9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fW4Jfc0u; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso331322866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729271894; x=1729876694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d3KGHo0twHh3KK7tsU2WqukBG2HV/y2vfRLQQjxQEs=;
        b=fW4Jfc0unZkST23Y427c7g9eKlxZ76ZgZ8lhlnObnxrSHzWjDAkC3Dw2RicVqwx8fr
         jne3CzOhBETUg7l6PBv2HIHY6vrrwMXipt8Oo4xRMNHMsJVp9dcg/oJJ0ik2oDau1NIk
         qLLaNOcr8/AiML9cw6r/Co42x4K7PHksVAU71h4+PLQG9OtZ8oRml0YVUrrIj42amqp7
         m1H3O853B1hSab+Lhqeo8BiPeDVxVAY6b7LRkwRwSYT39vTuT3I5VxLn21WRNRqwxTuX
         8uKIBWEumvjqjA3/EPh6JAppNiSePkoBTDsaaJNy2a03Q3Yvb1V4M3S/RNvh0msaqrbg
         qvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271894; x=1729876694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d3KGHo0twHh3KK7tsU2WqukBG2HV/y2vfRLQQjxQEs=;
        b=loZUaEvBLO7oWCFVfKi+AhnF0oX6hN5BucUOeMjNHmWamRoXIi2doa+aSXUIuMzuUI
         3EWOiV/v2686pjGTRpd4ildt5QoveZQ1wnTC0OMykkRtquw21oKSE6gtQyEruo4//k8l
         cJduscsB5k1gojMwf4G9xy+VKaqFb64N05Bj20FheUUncroQrBeBmmLolI4/TAIEv5s1
         LOR7mgjqhax6P7/2feug4ToS8hN7sx+jzRdYOGPf2XK8hBCjTTTYL4nUzHqIw1t+vfnY
         O6f76WDnH4TQJBCpZc8qupc35N52ZDgqyj2hsdzd+WyIIhBzIMGbWw3aC6rAzewcDnYy
         d8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmFLHmxhcFQzWJ0vEXzAa0BrdTchjHW156PdHYpnbSnB/VCQQA3tOiOFa0ydbdwG5QIKx56CZF3WlBf3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+5KIVrS27q+xp1zv+nYRaq4J3I90pXlUzW5TlpntujKvGs/D
	yu1zAYuahGRTbXPjPn4yCsFLGOk1EHwvVHtWt02RfrTSSp6WYXb7D35snwm1+GTKqIR0UQZkr05
	Xl5ZdIDnirSP/u4wU2LwWhEoQ+/6ANWCXFjaS
X-Google-Smtp-Source: AGHT+IE8nMV54DuZxqiA4l4fUopX08q7zMqWhyjajbG7WRK1oV7qQeWn3am9rp4Ty4elaO+wHaDx9nCBfdnDv3AYfc8=
X-Received: by 2002:a17:907:97c1:b0:a9a:3dc0:8911 with SMTP id
 a640c23a62f3a-a9a69a7621amr276212566b.16.1729271893553; Fri, 18 Oct 2024
 10:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003211716.371786-1-edliaw@google.com> <20241003211716.371786-2-edliaw@google.com>
 <b17802cb-5dcd-4161-b192-89abd55c1228@arm.com>
In-Reply-To: <b17802cb-5dcd-4161-b192-89abd55c1228@arm.com>
From: Edward Liaw <edliaw@google.com>
Date: Fri, 18 Oct 2024 10:17:46 -0700
Message-ID: <CAG4es9X3r2kCY+Fp+CnpRyX8ChhdhaWMOjT=KePBcFCAQHEbeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/mm: replace atomic_bool with pthread_barrier_t
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Lokesh Gidra <lokeshgidra@google.com>, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 7:37=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 03/10/2024 22:17, Edward Liaw wrote:
> > Swaps synchronization primitive with pthread_barrier, so that
> > stdatomic.h does not need to be included.
> >
> > The synchronization is needed on Android ARM64; we see a deadlock with
> > pthread_create when the parent thread races forward before the child ha=
s
> > a chance to start doing work.
> >
> > Fixes: 8c864371b2a1 ("selftests/mm: fix ARM related issue with fork aft=
er
> > pthread_create")
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >  tools/testing/selftests/mm/uffd-common.c     |  5 +++--
> >  tools/testing/selftests/mm/uffd-common.h     |  3 +--
> >  tools/testing/selftests/mm/uffd-unit-tests.c | 14 ++++++++------
> >  3 files changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/s=
elftests/mm/uffd-common.c
> > index 717539eddf98..852e7281026e 100644
> > --- a/tools/testing/selftests/mm/uffd-common.c
> > +++ b/tools/testing/selftests/mm/uffd-common.c
> > @@ -18,7 +18,7 @@ bool test_uffdio_wp =3D true;
> >  unsigned long long *count_verify;
> >  uffd_test_ops_t *uffd_test_ops;
> >  uffd_test_case_ops_t *uffd_test_case_ops;
> > -atomic_bool ready_for_fork;
> > +pthread_barrier_t ready_for_fork;
> >
> >  static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
> >  {
> > @@ -519,7 +519,8 @@ void *uffd_poll_thread(void *arg)
> >       pollfd[1].fd =3D pipefd[cpu*2];
> >       pollfd[1].events =3D POLLIN;
> >
> > -     ready_for_fork =3D true;
> > +     /* Ready for parent thread to fork */
> > +     pthread_barrier_wait(&ready_for_fork);
>
> Hi Edward,
>
> This change is causing uffd-unit-tests to hang on arm64 when running the =
"move on anon" test. It's happening because this wait is never returning fo=
r this case. And that happens because ready_for_fork was never initialized =
for this test. It looks like there are other places where a thread is creat=
ed for uffd_poll_thread() where ready_for_fork is not initialized too.
>
> I added this change and it solves the problem, although it's pretty hacky=
.
>
> This is blocking our arm64 testing on linux-next so would appreciate eith=
er a quick fix or removing the change until a fix is ready.

Ah, I should not have changed it to a pthread_barrier, since that
depends on the parent creating the barrier; I'm sending a revert and
subsequent fix.

>
> Thanks,
> Ryan
>
> ----8<-----
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/sel=
ftests/mm/uffd-common.c
> index 852e7281026e..a05eb705be02 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -19,6 +19,7 @@ unsigned long long *count_verify;
>  uffd_test_ops_t *uffd_test_ops;
>  uffd_test_case_ops_t *uffd_test_case_ops;
>  pthread_barrier_t ready_for_fork;
> +bool wait_ready_for_fork;
>
>  static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
>  {
> @@ -520,7 +521,8 @@ void *uffd_poll_thread(void *arg)
>         pollfd[1].events =3D POLLIN;
>
>         /* Ready for parent thread to fork */
> -       pthread_barrier_wait(&ready_for_fork);
> +       if (wait_ready_for_fork)
> +               pthread_barrier_wait(&ready_for_fork);
>
>         for (;;) {
>                 ret =3D poll(pollfd, 2, -1);
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/sel=
ftests/mm/uffd-common.h
> index 3e6228d8e0dc..e94329a39b34 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -105,6 +105,7 @@ extern bool test_uffdio_wp;
>  extern unsigned long long *count_verify;
>  extern volatile bool test_uffdio_copy_eexist;
>  extern pthread_barrier_t ready_for_fork;
> +extern bool wait_ready_for_fork;
>
>  extern uffd_test_ops_t anon_uffd_test_ops;
>  extern uffd_test_ops_t shmem_uffd_test_ops;
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing=
/selftests/mm/uffd-unit-tests.c
> index 3db2296ac631..d1fc4cd6a948 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -775,6 +775,7 @@ static void uffd_sigbus_test_common(bool wp)
>         struct uffd_args args =3D { 0 };
>
>         pthread_barrier_init(&ready_for_fork, NULL, 2);
> +       wait_ready_for_fork =3D true;
>
>         fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
>
> @@ -794,6 +795,7 @@ static void uffd_sigbus_test_common(bool wp)
>         /* Wait for child thread to start before forking */
>         pthread_barrier_wait(&ready_for_fork);
>         pthread_barrier_destroy(&ready_for_fork);
> +       wait_ready_for_fork =3D false;
>
>         pid =3D fork();
>         if (pid < 0)
> @@ -835,6 +837,7 @@ static void uffd_events_test_common(bool wp)
>         struct uffd_args args =3D { 0 };
>
>         pthread_barrier_init(&ready_for_fork, NULL, 2);
> +       wait_ready_for_fork =3D true;
>
>         fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
>         if (uffd_register(uffd, area_dst, nr_pages * page_size,
> @@ -848,6 +851,7 @@ static void uffd_events_test_common(bool wp)
>         /* Wait for child thread to start before forking */
>         pthread_barrier_wait(&ready_for_fork);
>         pthread_barrier_destroy(&ready_for_fork);
> +       wait_ready_for_fork =3D false;
>
>         pid =3D fork();
>         if (pid < 0)
> ----8<-----
>
>
> >
> >       for (;;) {
> >               ret =3D poll(pollfd, 2, -1);
> > diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/s=
elftests/mm/uffd-common.h
> > index a70ae10b5f62..3e6228d8e0dc 100644
> > --- a/tools/testing/selftests/mm/uffd-common.h
> > +++ b/tools/testing/selftests/mm/uffd-common.h
> > @@ -33,7 +33,6 @@
> >  #include <inttypes.h>
> >  #include <stdint.h>
> >  #include <sys/random.h>
> > -#include <stdatomic.h>
> >
> >  #include "../kselftest.h"
> >  #include "vm_util.h"
> > @@ -105,7 +104,7 @@ extern bool map_shared;
> >  extern bool test_uffdio_wp;
> >  extern unsigned long long *count_verify;
> >  extern volatile bool test_uffdio_copy_eexist;
> > -extern atomic_bool ready_for_fork;
> > +extern pthread_barrier_t ready_for_fork;
> >
> >  extern uffd_test_ops_t anon_uffd_test_ops;
> >  extern uffd_test_ops_t shmem_uffd_test_ops;
> > diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testi=
ng/selftests/mm/uffd-unit-tests.c
> > index b3d21eed203d..3db2296ac631 100644
> > --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> > +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> > @@ -774,7 +774,7 @@ static void uffd_sigbus_test_common(bool wp)
> >       char c;
> >       struct uffd_args args =3D { 0 };
> >
> > -     ready_for_fork =3D false;
> > +     pthread_barrier_init(&ready_for_fork, NULL, 2);
> >
> >       fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> >
> > @@ -791,8 +791,9 @@ static void uffd_sigbus_test_common(bool wp)
> >       if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> >               err("uffd_poll_thread create");
> >
> > -     while (!ready_for_fork)
> > -             ; /* Wait for the poll_thread to start executing before f=
orking */
> > +     /* Wait for child thread to start before forking */
> > +     pthread_barrier_wait(&ready_for_fork);
> > +     pthread_barrier_destroy(&ready_for_fork);
> >
> >       pid =3D fork();
> >       if (pid < 0)
> > @@ -833,7 +834,7 @@ static void uffd_events_test_common(bool wp)
> >       char c;
> >       struct uffd_args args =3D { 0 };
> >
> > -     ready_for_fork =3D false;
> > +     pthread_barrier_init(&ready_for_fork, NULL, 2);
> >
> >       fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> >       if (uffd_register(uffd, area_dst, nr_pages * page_size,
> > @@ -844,8 +845,9 @@ static void uffd_events_test_common(bool wp)
> >       if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> >               err("uffd_poll_thread create");
> >
> > -     while (!ready_for_fork)
> > -             ; /* Wait for the poll_thread to start executing before f=
orking */
> > +     /* Wait for child thread to start before forking */
> > +     pthread_barrier_wait(&ready_for_fork);
> > +     pthread_barrier_destroy(&ready_for_fork);
> >
> >       pid =3D fork();
> >       if (pid < 0)
>


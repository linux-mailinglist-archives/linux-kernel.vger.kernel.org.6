Return-Path: <linux-kernel+bounces-301656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094495F3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF810B21E24
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E64189503;
	Mon, 26 Aug 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUkhnYIZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4161E864
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681908; cv=none; b=en090cH0EZKUfhcZ7Ec7mUxnYRNtbP9lKJq0JBVXaeNVAdFzU4qFKRauR6l6rkkEEP7Dro4Xe6tVDpDSa9yfvdcgLyeM+dbqlphwWDx6wLJauq7L5e3BByrZ+5+eIT34gIpgqTgfKcJ2BENXx5C2CQwSN1tCFr8vdYZ0DVlFkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681908; c=relaxed/simple;
	bh=53R3qtA2DB+9v4U+hc88fR8XKEtW2edB3+GQ9O1Vn6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxkQm/nO6SfFY1hP3eKsdOTR4sWzwRx9TR7z6w1cRdM8tk65w6bQzxWKnF7hFX1Gv98TMRVSzMQNVsAT+Ynqif27WfP+TDZidmYYCqrRwdcY4CLklX+xuRXU1soJIREekhrRgDEwBh+1Y3ar8znq5CjHy+HhGj1jLzZHGrTEjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUkhnYIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724681905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epejtgmZ6P+cnuAUKGDMtJ1Zom6Sbo3EnXXkkIT7RGo=;
	b=CUkhnYIZG97xzha8KOPp3QU5KpnPIDFdPFA6/kqpuBAFNyM2d96Ux9gSEVssg8RKA2U8/s
	Rf374vOPZ29XyMuxJ3MaBegbSwMpiEK6/JW+n0tdLQaIVn7JR0g39xBmHc7s48Khet71HT
	AKSz3j5kwbwFKJ/4KMGQqAO+bUTzcW0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-BtETrKljPca1hhJYu_jt8w-1; Mon, 26 Aug 2024 10:18:24 -0400
X-MC-Unique: BtETrKljPca1hhJYu_jt8w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f508065daeso12106151fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681903; x=1725286703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epejtgmZ6P+cnuAUKGDMtJ1Zom6Sbo3EnXXkkIT7RGo=;
        b=wob8lRTjicXPHXL5IFUxF1p7a/BaK1Wi0oEx7R33NqDydO/fvDegDVOaZJGS1UaR7U
         +lE4TdVuLe/MEVTahwk3qd7SSasNOA/GjGVIXF27ku4MHXud9jphsUjpO9gPE1f/NkeK
         lcu/fDJWIZCrAmX1HeyvH1StWWR0mzjlXLlOFHAli4QQnA1MC+1xUVQT+r8Ze3YColzw
         WHJ8yYHFTR3uu1k/h8dfah614wSIGL/fPv6S7D898MydxlDoPekbNmGZmTcb/OoWbaVL
         yQJ9qY4uhr1Gi67Z1eIinEI7glpIxK4D2EO9qQzy4L1T/eYVpXV6NJCn+oC/iKusP8w0
         BfOg==
X-Gm-Message-State: AOJu0Yws1zeKtX6wMoc8EsFZQa2T8IyYzQ2zbLS4NFk1h7qJQvxJhH5g
	AgU45kprfIAjPo5Inu3gyCRZUAdBpeSrhNSx8qAFwqRQMeHWRHwIIHImyjdcljFsXDa3scKYg7J
	FioCU/9FfFXn8OpIF4IwmRuutZqJD7/n8/ZtVzBRIzE7+AY3z17qyExTumioicVlpR/EW/xZHuu
	0c/xiY7+tVUF0tcEI6e5dV1faDrlXv07GF5RFP
X-Received: by 2002:a2e:a543:0:b0:2f1:6108:3f00 with SMTP id 38308e7fff4ca-2f4f4743664mr26815261fa.0.1724681903017;
        Mon, 26 Aug 2024 07:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAZYY5jdtpgdgXWZ7zNtGCuEM+zlPT/j+eVCg3rTngipWDx2Xz2dHTuB+p5Bj7qVhnNUS2aqr4ZKB7Tk3FRc4=
X-Received: by 2002:a2e:a543:0:b0:2f1:6108:3f00 with SMTP id
 38308e7fff4ca-2f4f4743664mr26815101fa.0.1724681902401; Mon, 26 Aug 2024
 07:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821123115.2068812-1-david@redhat.com> <CAMXpfWsoTooEEpgyUvNFNo0tMLmPNO9bfAu_A+rq2+Ri6YbV9Q@mail.gmail.com>
In-Reply-To: <CAMXpfWsoTooEEpgyUvNFNo0tMLmPNO9bfAu_A+rq2+Ri6YbV9Q@mail.gmail.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Mon, 26 Aug 2024 16:18:11 +0200
Message-ID: <CAMXpfWuMZJqDndoNX7no4vJm9d0RwkV=OQ3XqQHqkj1YfvsmVw@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/mm: fix charge_reserved_hugetlb.sh test
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Missing the hyphen :)
Tested-by: Mario Casquero <mcasquer@redhat.com>

On Mon, Aug 26, 2024 at 4:16=E2=80=AFPM Mario Casquero <mcasquer@redhat.com=
> wrote:
>
> This patch has been successfully tested. All hugetlb kernel selftests pas=
s now.
> # SUMMARY: PASS=3D12 SKIP=3D0 FAIL=3D0
>
> Tested by: Mario Casquero <mcasquer@redhat.com>
>
>
> On Wed, Aug 21, 2024 at 2:31=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > Currently, running the charge_reserved_hugetlb.sh selftest we can
> > sometimes observe something like:
> >
> >   $ ./charge_reserved_hugetlb.sh -cgroup-v2
> >   ...
> >   write_result is 0
> >   After write:
> >   hugetlb_usage=3D0
> >   reserved_usage=3D10485760
> >   killing write_to_hugetlbfs
> >   Received 2.
> >   Deleting the memory
> >   Detach failure: Invalid argument
> >   umount: /mnt/huge: target is busy.
> >
> > Both cases are issues in the test.
> >
> > While the unmount error seems to be racy, it will make the test fail:
> >         $ ./run_vmtests.sh -t hugetlb
> >         ...
> >         # [FAIL]
> >         not ok 10 charge_reserved_hugetlb.sh -cgroup-v2 # exit=3D32
> >
> > The issue is that we are not waiting for the write_to_hugetlbfs process
> > to quit. So it might still have a hugetlbfs file open, about which
> > umount is not happy. Fix that by making "killall" wait for the process
> > to quit.
> >
> > The other error ("Detach failure: Invalid argument") does not seem to
> > result in a test error, but is misleading. Turns out write_to_hugetlbfs=
.c
> > unconditionally tries to cleanup using shmdt(), even when we only
> > mmap()'ed a hugetlb file. Even worse, shmaddr is never even set for the
> > SHM case. Fix that as well.
> >
> > With this change it seems to work as expected.
> >
> > Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation te=
sts")
> > Reported-by: Mario Casquero <mcasquer@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  .../selftests/mm/charge_reserved_hugetlb.sh   |  2 +-
> >  .../testing/selftests/mm/write_to_hugetlbfs.c | 21 +++++++++++--------
> >  2 files changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/to=
ols/testing/selftests/mm/charge_reserved_hugetlb.sh
> > index d680c00d2853a..67df7b47087f0 100755
> > --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> > +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> > @@ -254,7 +254,7 @@ function cleanup_hugetlb_memory() {
> >    local cgroup=3D"$1"
> >    if [[ "$(pgrep -f write_to_hugetlbfs)" !=3D "" ]]; then
> >      echo killing write_to_hugetlbfs
> > -    killall -2 write_to_hugetlbfs
> > +    killall -2 --wait write_to_hugetlbfs
> >      wait_for_hugetlb_memory_to_get_depleted $cgroup
> >    fi
> >    set -e
> > diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/te=
sting/selftests/mm/write_to_hugetlbfs.c
> > index 6a2caba19ee1d..1289d311efd70 100644
> > --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > @@ -28,7 +28,7 @@ enum method {
> >
> >  /* Global variables. */
> >  static const char *self;
> > -static char *shmaddr;
> > +static int *shmaddr;
> >  static int shmid;
> >
> >  /*
> > @@ -47,15 +47,17 @@ void sig_handler(int signo)
> >  {
> >         printf("Received %d.\n", signo);
> >         if (signo =3D=3D SIGINT) {
> > -               printf("Deleting the memory\n");
> > -               if (shmdt((const void *)shmaddr) !=3D 0) {
> > -                       perror("Detach failure");
> > +               if (shmaddr) {
> > +                       printf("Deleting the memory\n");
> > +                       if (shmdt((const void *)shmaddr) !=3D 0) {
> > +                               perror("Detach failure");
> > +                               shmctl(shmid, IPC_RMID, NULL);
> > +                               exit(4);
> > +                       }
> > +
> >                         shmctl(shmid, IPC_RMID, NULL);
> > -                       exit(4);
> > +                       printf("Done deleting the memory\n");
> >                 }
> > -
> > -               shmctl(shmid, IPC_RMID, NULL);
> > -               printf("Done deleting the memory\n");
> >         }
> >         exit(2);
> >  }
> > @@ -211,7 +213,8 @@ int main(int argc, char **argv)
> >                         shmctl(shmid, IPC_RMID, NULL);
> >                         exit(2);
> >                 }
> > -               printf("shmaddr: %p\n", ptr);
> > +               shmaddr =3D ptr;
> > +               printf("shmaddr: %p\n", shmaddr);
> >
> >                 break;
> >         default:
> > --
> > 2.46.0
> >



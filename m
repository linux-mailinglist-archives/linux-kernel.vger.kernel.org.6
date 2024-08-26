Return-Path: <linux-kernel+bounces-301653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9995F3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE8BB20FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E81189503;
	Mon, 26 Aug 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/20XTXA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC517D35B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681785; cv=none; b=fHOkrbRYAV2m9VxsYa3dzXfbguYvXPSo8SKsCxff72mRX4550Ty8Jgj9rcY8X/3qjWwUAvUY8JmnHoXqinfzOcxijKxp0mQ+Kt4PpvtQBivtkrx1zEYs9SZHmh4nP1gxZw+5tfbFuVztEOs3LaD6H439ruV6ARqaxFi279HHT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681785; c=relaxed/simple;
	bh=bfh7hrY6hPrVjcxiAQV5eze22xQjzvzqfJ/7/fNvrw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvJG/dV/gYC5z6b4jWiQ72CnDxLk7s49UOkieDq1tJuhsfFTRADn3O9P7OqFuK5g2wxPgtR/W7/6Pdf+RuGpcykOhqBHT6OeH6TcU7FV9od+U9N2CIJ5fQ57mZN+tv/2YV9eI5NYpxlliKfpQ3slyl7Akz8qHR6LzLVjzqG6M10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/20XTXA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724681782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+nhWTyzd1EZSu9QxGO7u5TrkuVgATh5FsPGD0fQ+wc=;
	b=e/20XTXAvaZpA3THoTPr6DC7jYTE5qdUxfJXFn0Zi55v5Y7fD9vA/dRwWvghKCAlo1fInJ
	LWL9yWQm22yFSxx4Xkc07clhPVDFMlbdm7VDlPd/YTa4C9BfKIkPqJDhFOxvFq9GOoDctq
	sbGI9G+iZ8QfMi2Fq1sL5oSVeyigqho=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-hLvm44GYN5CN_zN6liZ9vw-1; Mon, 26 Aug 2024 10:16:20 -0400
X-MC-Unique: hLvm44GYN5CN_zN6liZ9vw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5334af2a84fso4619749e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681779; x=1725286579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+nhWTyzd1EZSu9QxGO7u5TrkuVgATh5FsPGD0fQ+wc=;
        b=dF2jawJqfhhbpSDv2MB5D4jWBJQ2q4WKBDIcQ9H0hzeEyXJ1TJEx01GeOMncjmJVOA
         fb43nl9xnSxVnFHnGksbneoL/uKSvJPzsUMQy5u5krjzz/hLXRVzddoAdMmb5Fvi7KM6
         7A8BdsRrhP5+CnVRr9Xk+eGnnIU8MGgUTQ+jsmDqY/S6JBoJ09lkKjELwmNF78N17d1g
         KdILN0FZtuGOQDuKbMRau4rflIk/D5vv5QkRthN8O+5eXaqMj3jucYSfS170E2GFtArE
         rGxiCLO5Mic1mx88AtLZGejdQG3tr0CyHvX/0kHZBigkH4rjWXbwGd7WsP8gEzC//tcj
         xiTg==
X-Gm-Message-State: AOJu0Yy7n3dfoyygDPmIy77tPxP49vEfdYbDrt8G8TxgkbPRXmi4ORi3
	J4zXhw/DSRUZtECEbl+AlQAXugJ6AxobRwhOs9JJmcNMy5Q+vlxJryeGfc93cy5Sf894rz7181n
	fyIoraROr82G77zrcZWsdp5rcd5wSTcZftIr5omnubjd4zGQ8KTuVY4erKCQRJ98P283qIPENsw
	NnBXP2e9NYewXXzw55q5cjKjN0hEhGeaOd1fye
X-Received: by 2002:a05:651c:1544:b0:2f3:d008:a54e with SMTP id 38308e7fff4ca-2f4f493a354mr82359941fa.36.1724681779192;
        Mon, 26 Aug 2024 07:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjsUTW2QGEs1pHXZ1pLASk+FK03mP2oVNdzWBn0IfbZdLgVs0FRFpTJwlH4BarayX187CLxqiwvqGZ4Zuf5wI=
X-Received: by 2002:a05:651c:1544:b0:2f3:d008:a54e with SMTP id
 38308e7fff4ca-2f4f493a354mr82359731fa.36.1724681778674; Mon, 26 Aug 2024
 07:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821123115.2068812-1-david@redhat.com>
In-Reply-To: <20240821123115.2068812-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Mon, 26 Aug 2024 16:16:07 +0200
Message-ID: <CAMXpfWsoTooEEpgyUvNFNo0tMLmPNO9bfAu_A+rq2+Ri6YbV9Q@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/mm: fix charge_reserved_hugetlb.sh test
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch has been successfully tested. All hugetlb kernel selftests pass =
now.
# SUMMARY: PASS=3D12 SKIP=3D0 FAIL=3D0

Tested by: Mario Casquero <mcasquer@redhat.com>


On Wed, Aug 21, 2024 at 2:31=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Currently, running the charge_reserved_hugetlb.sh selftest we can
> sometimes observe something like:
>
>   $ ./charge_reserved_hugetlb.sh -cgroup-v2
>   ...
>   write_result is 0
>   After write:
>   hugetlb_usage=3D0
>   reserved_usage=3D10485760
>   killing write_to_hugetlbfs
>   Received 2.
>   Deleting the memory
>   Detach failure: Invalid argument
>   umount: /mnt/huge: target is busy.
>
> Both cases are issues in the test.
>
> While the unmount error seems to be racy, it will make the test fail:
>         $ ./run_vmtests.sh -t hugetlb
>         ...
>         # [FAIL]
>         not ok 10 charge_reserved_hugetlb.sh -cgroup-v2 # exit=3D32
>
> The issue is that we are not waiting for the write_to_hugetlbfs process
> to quit. So it might still have a hugetlbfs file open, about which
> umount is not happy. Fix that by making "killall" wait for the process
> to quit.
>
> The other error ("Detach failure: Invalid argument") does not seem to
> result in a test error, but is misleading. Turns out write_to_hugetlbfs.c
> unconditionally tries to cleanup using shmdt(), even when we only
> mmap()'ed a hugetlb file. Even worse, shmaddr is never even set for the
> SHM case. Fix that as well.
>
> With this change it seems to work as expected.
>
> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation test=
s")
> Reported-by: Mario Casquero <mcasquer@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  .../selftests/mm/charge_reserved_hugetlb.sh   |  2 +-
>  .../testing/selftests/mm/write_to_hugetlbfs.c | 21 +++++++++++--------
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tool=
s/testing/selftests/mm/charge_reserved_hugetlb.sh
> index d680c00d2853a..67df7b47087f0 100755
> --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> @@ -254,7 +254,7 @@ function cleanup_hugetlb_memory() {
>    local cgroup=3D"$1"
>    if [[ "$(pgrep -f write_to_hugetlbfs)" !=3D "" ]]; then
>      echo killing write_to_hugetlbfs
> -    killall -2 write_to_hugetlbfs
> +    killall -2 --wait write_to_hugetlbfs
>      wait_for_hugetlb_memory_to_get_depleted $cgroup
>    fi
>    set -e
> diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/test=
ing/selftests/mm/write_to_hugetlbfs.c
> index 6a2caba19ee1d..1289d311efd70 100644
> --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> @@ -28,7 +28,7 @@ enum method {
>
>  /* Global variables. */
>  static const char *self;
> -static char *shmaddr;
> +static int *shmaddr;
>  static int shmid;
>
>  /*
> @@ -47,15 +47,17 @@ void sig_handler(int signo)
>  {
>         printf("Received %d.\n", signo);
>         if (signo =3D=3D SIGINT) {
> -               printf("Deleting the memory\n");
> -               if (shmdt((const void *)shmaddr) !=3D 0) {
> -                       perror("Detach failure");
> +               if (shmaddr) {
> +                       printf("Deleting the memory\n");
> +                       if (shmdt((const void *)shmaddr) !=3D 0) {
> +                               perror("Detach failure");
> +                               shmctl(shmid, IPC_RMID, NULL);
> +                               exit(4);
> +                       }
> +
>                         shmctl(shmid, IPC_RMID, NULL);
> -                       exit(4);
> +                       printf("Done deleting the memory\n");
>                 }
> -
> -               shmctl(shmid, IPC_RMID, NULL);
> -               printf("Done deleting the memory\n");
>         }
>         exit(2);
>  }
> @@ -211,7 +213,8 @@ int main(int argc, char **argv)
>                         shmctl(shmid, IPC_RMID, NULL);
>                         exit(2);
>                 }
> -               printf("shmaddr: %p\n", ptr);
> +               shmaddr =3D ptr;
> +               printf("shmaddr: %p\n", shmaddr);
>
>                 break;
>         default:
> --
> 2.46.0
>



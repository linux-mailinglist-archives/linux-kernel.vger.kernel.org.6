Return-Path: <linux-kernel+bounces-518380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA4A38E25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC593B2E79
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB511A9B5B;
	Mon, 17 Feb 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCL1bWDu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD01A8407
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828164; cv=none; b=n544lZnh7niVFRR9d/1J2rbCfvhY0LJVekurdU3B+sTIwtQZf7OvJEYPzmLpv0HSfduoUKof4DIDXfKOY/rmbqX9MTW0b7asKd1/HptCbi7+KYHijEEHDRvoDaG67NF3L6oK30fns7fFhv885GMEc4sH76W06e3hcHXUwEVvXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828164; c=relaxed/simple;
	bh=wIXjUJMzGJeooTQh1QS49+qv3PkkKMRvd1TsHlR7tXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qd45j+jxEZqqbjvAh04LjimkOhpsdZPfydRWLaHlEjBrPX7RqVpmU801wujnDc3k5MF30p4BobdoTnn+z24o8OqHyDcbrtm6WCnPyzJL/YKeTZ6DacCjPOZ4P8ofwLCc5JxMS1RZ5cssRVEV6wM/SSpcpCULYwOZZPQEvPPnKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCL1bWDu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739828161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLHdhnY7+gX4ZqJB5KOUOnoz2TGa7+5xua+4ro6XiqY=;
	b=iCL1bWDuKwrXmU6gvH0IQFnzR7MmVUsy22OUzZwSa4gFbZrKNAOr59a6n3+EV+uJxnFXXm
	2kWbMg73P6v8uZxj1MbEcdKm7lxtqLuNXkX9Yd4VE7J1FEavPedendvufuADMZn2unzohL
	bYP2VQuIgRhgRoNuBob7aO0w93DwNZk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-yPP3gAjIMeaHRtExOoAiyw-1; Mon, 17 Feb 2025 16:35:59 -0500
X-MC-Unique: yPP3gAjIMeaHRtExOoAiyw-1
X-Mimecast-MFC-AGG-ID: yPP3gAjIMeaHRtExOoAiyw_1739828159
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e5dc2822ae6so4083324276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739828158; x=1740432958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLHdhnY7+gX4ZqJB5KOUOnoz2TGa7+5xua+4ro6XiqY=;
        b=VDYhic/7nHH2isbMtxqP0E4HvDlG1u62KLmsiZu/lOcvHHyBpHSpbbs9zRslVtdbDS
         kdZZ9qUcRPSuxCK/z1bknaUzVZvphqsJoQcIemtE3JeE0xyVEVNThY1t/1RqSxpwrmbk
         WDr5CUXLa18oMwvz0kVGpG8DpcU7SJyujGdOF66UTOhIWBD7BzLurji/rB0qdWhnHIdu
         ZjgKeDsSidzJ+P+OAatAt7p3WAmxbMM2Aw5d3vaqAyFPKZD63CocAFKxMNj5QhXvsj+V
         3ggqV2nOeDhb4yLvSfpEYLzsYx6rpsoQDyiJUQZxuewUlb+49nET2kf/fHyZpezQjal5
         nx4A==
X-Forwarded-Encrypted: i=1; AJvYcCW7u8L1C+mY6ExuWShHZrGa/0Wu3dMnCZw5usc2c4VM/c2A5IGmgav6+cQHs3pS+WDnhmV7riLSftPSbJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Li9CpASo6vCrSZY0phSO7Zsam0MJYMxh33x6bcWN4Rl7pFec
	rcJ6cTtKhexG8rh3Q5LqW6ppQpG8H16SxTI8lyXAbwv8oDZKavBeBKgOarv4CXoNCBsvnJnzGL+
	prg90ztkdJLyKj/rFl+cOEV9CbIcoqMJdgaz4GYNVGhFUjD7H6XZP7f2VwOEX8bLzu57/XHzYhF
	/nIBtQkdhYgxEGvuTTszlk+2VGhBj+ZwEPy+yY
X-Gm-Gg: ASbGncu89vqK9p6VuqyINvdHe6CYxiul8NP4rQQpYuyRl47T7GzWhubmwJsEZe3rZMz
	6K/yw6mMiIHVBo4dv9ieRS08t4So7JJNHmDBsdPAfrrLi30qyxI8OUgoScCPim/KKK5ZE9wf/xw
	s=
X-Received: by 2002:a05:6902:cc7:b0:e4c:66ab:ed3f with SMTP id 3f1490d57ef6-e5dc9028264mr7287090276.1.1739828158246;
        Mon, 17 Feb 2025 13:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDFV2upzTRlJkc3O6vtoMT1z0d80pRRl+DUV2FYtYW6nmMCB4amrvS4FtP/cGAHHAMDn9PFpp4syNrHjDP8RU=
X-Received: by 2002:a05:6902:cc7:b0:e4c:66ab:ed3f with SMTP id
 3f1490d57ef6-e5dc9028264mr7287078276.1.1739828157898; Mon, 17 Feb 2025
 13:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-kselftest-mm-no-hugepages-v1-0-44702f538522@kernel.org> <20250212-kselftest-mm-no-hugepages-v1-2-44702f538522@kernel.org>
In-Reply-To: <20250212-kselftest-mm-no-hugepages-v1-2-44702f538522@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 14:35:32 -0700
X-Gm-Features: AWEUYZkNvuVXj0wF1G7X-hRizWA2jTyzV7BFOMO2QUiM5SkHBjQAqHFq2KgiKck
Message-ID: <CAA1CXcCYk3V1L4Pr_8TUyQs63OL3EErfYOEv-kHTdzgYatwV5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/mm: Allow tests to run with no huge pages support
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:52=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> Currently the mm selftests refuse to run if huge pages are not available =
in
> the current system but this is an optional feature and not all the tests
> actually require them. Change the test during startup to be non-fatal and
> skip or omit tests which actually rely on having huge pages, allowing the
> other tests to be run.
>
> The gup_test does support using madvise() to configure huge pages but it
> ignores the error code so we just let it run.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

We currently deal with the same issue when running selftests on
smaller machines or 64k kernels. This is a nice addition.

Reviewed-by: Nico Pache <npache@redhat.com>

> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 66 ++++++++++++++++++++-----=
------
>  1 file changed, 42 insertions(+), 24 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index da7e266681031d2772fb0c4139648904a18e0bf9..d3866b50a6e16a9ba08b6cf33=
d131edf2a9226be 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -187,9 +187,10 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
>                 printf "Not enough huge pages available (%d < %d)\n" \
>                        "$freepgs" "$needpgs"
>         fi
> +       HAVE_HUGEPAGES=3D1
>  else
>         echo "no hugetlbfs support in kernel?"
> -       exit 1
> +       HAVE_HUGEPAGES=3D0
>  fi
>
>  # filter 64bit architectures
> @@ -218,13 +219,20 @@ pretty_name() {
>  # Usage: run_test [test binary] [arbitrary test arguments...]
>  run_test() {
>         if test_selected ${CATEGORY}; then
> +               local skip=3D0
> +
>                 # On memory constrainted systems some tests can fail to a=
llocate hugepages.
>                 # perform some cleanup before the test for a higher succe=
ss rate.
>                 if [ ${CATEGORY} =3D=3D "thp" -o ${CATEGORY} =3D=3D "huge=
tlb" ]; then
> -                       echo 3 > /proc/sys/vm/drop_caches
> -                       sleep 2
> -                       echo 1 > /proc/sys/vm/compact_memory
> -                       sleep 2
> +                       if [ "${HAVE_HUGEPAGES}" =3D "1" ]; then
> +                               echo 3 > /proc/sys/vm/drop_caches
> +                               sleep 2
> +                               echo 1 > /proc/sys/vm/compact_memory
> +                               sleep 2
> +                       else
> +                               echo "hugepages not supported" | tap_pref=
ix
> +                               skip=3D1
> +                       fi
>                 fi
>
>                 local test=3D$(pretty_name "$*")
> @@ -232,8 +240,12 @@ run_test() {
>                 local sep=3D$(echo -n "$title" | tr "[:graph:][:space:]" =
-)
>                 printf "%s\n%s\n%s\n" "$sep" "$title" "$sep" | tap_prefix
>
> -               ("$@" 2>&1) | tap_prefix
> -               local ret=3D${PIPESTATUS[0]}
> +               if [ "${skip}" !=3D "1" ]; then
> +                       ("$@" 2>&1) | tap_prefix
> +                       local ret=3D${PIPESTATUS[0]}
> +               else
> +                       local ret=3D$ksft_skip
> +               fi
>                 count_total=3D$(( count_total + 1 ))
>                 if [ $ret -eq 0 ]; then
>                         count_pass=3D$(( count_pass + 1 ))
> @@ -271,13 +283,15 @@ CATEGORY=3D"hugetlb" run_test ./hugepage-vmemmap
>  CATEGORY=3D"hugetlb" run_test ./hugetlb-madvise
>  CATEGORY=3D"hugetlb" run_test ./hugetlb_dio
>
> -nr_hugepages_tmp=3D$(cat /proc/sys/vm/nr_hugepages)
> -# For this test, we need one and just one huge page
> -echo 1 > /proc/sys/vm/nr_hugepages
> -CATEGORY=3D"hugetlb" run_test ./hugetlb_fault_after_madv
> -CATEGORY=3D"hugetlb" run_test ./hugetlb_madv_vs_map
> -# Restore the previous number of huge pages, since further tests rely on=
 it
> -echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
> +if [ "${HAVE_HUGEPAGES}" =3D "1" ]; then
> +       nr_hugepages_tmp=3D$(cat /proc/sys/vm/nr_hugepages)
> +       # For this test, we need one and just one huge page
> +       echo 1 > /proc/sys/vm/nr_hugepages
> +       CATEGORY=3D"hugetlb" run_test ./hugetlb_fault_after_madv
> +       CATEGORY=3D"hugetlb" run_test ./hugetlb_madv_vs_map
> +       # Restore the previous number of huge pages, since further tests =
rely on it
> +       echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
> +fi
>
>  if test_selected "hugetlb"; then
>         echo "NOTE: These hugetlb tests provide minimal coverage.  Use"  =
 | tap_prefix
> @@ -391,7 +405,9 @@ CATEGORY=3D"memfd_secret" run_test ./memfd_secret
>  fi
>
>  # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
> -CATEGORY=3D"ksm" run_test ./ksm_tests -H -s 100
> +if [ "${HAVE_HUGEPAGES}" =3D "1" ]; then
> +       CATEGORY=3D"ksm" run_test ./ksm_tests -H -s 100
> +fi
>  # KSM KSM_MERGE_TIME test with size of 100
>  CATEGORY=3D"ksm" run_test ./ksm_tests -P -s 100
>  # KSM MADV_MERGEABLE test with 10 identical pages
> @@ -440,15 +456,17 @@ CATEGORY=3D"thp" run_test ./transhuge-stress -d 20
>
>  # Try to create XFS if not provided
>  if [ -z "${SPLIT_HUGE_PAGE_TEST_XFS_PATH}" ]; then
> -    if test_selected "thp"; then
> -        if grep xfs /proc/filesystems &>/dev/null; then
> -            XFS_IMG=3D$(mktemp /tmp/xfs_img_XXXXXX)
> -            SPLIT_HUGE_PAGE_TEST_XFS_PATH=3D$(mktemp -d /tmp/xfs_dir_XXX=
XXX)
> -            truncate -s 314572800 ${XFS_IMG}
> -            mkfs.xfs -q ${XFS_IMG}
> -            mount -o loop ${XFS_IMG} ${SPLIT_HUGE_PAGE_TEST_XFS_PATH}
> -            MOUNTED_XFS=3D1
> -        fi
> +    if [ "${HAVE_HUGEPAGES}" =3D "1" ]; then
> +       if test_selected "thp"; then
> +           if grep xfs /proc/filesystems &>/dev/null; then
> +               XFS_IMG=3D$(mktemp /tmp/xfs_img_XXXXXX)
> +               SPLIT_HUGE_PAGE_TEST_XFS_PATH=3D$(mktemp -d /tmp/xfs_dir_=
XXXXXX)
> +               truncate -s 314572800 ${XFS_IMG}
> +               mkfs.xfs -q ${XFS_IMG}
> +               mount -o loop ${XFS_IMG} ${SPLIT_HUGE_PAGE_TEST_XFS_PATH}
> +               MOUNTED_XFS=3D1
> +           fi
> +       fi
>      fi
>  fi
>
>
> --
> 2.39.5
>



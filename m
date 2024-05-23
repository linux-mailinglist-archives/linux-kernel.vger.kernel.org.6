Return-Path: <linux-kernel+bounces-186903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B48CCA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DF31F21F27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6EB4690;
	Thu, 23 May 2024 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWCjd5qB"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D294C8C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716430384; cv=none; b=JFY2X01SQxulr+iuZEm2bHyq0cAXJQsmf9QtHiAxyu2vk16ZUpNHGgL16MzJPyL1suGD9FGh1/HF9Bq+r4/hO06C5ZDdR2rRzX2OgSZaPWWfPqu0lYGAiQUlY0NmB+BdLe0pmAiy/Qlg5c+NhrdhDifc2ST8dU9+ZTEGKCK85ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716430384; c=relaxed/simple;
	bh=Ztd03uGOTEtX6qI8i5/IfRp+ZjhZu3fhnFwlMDr/pOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6mrjggL/VupURN8gNFW4J4QKWqwqEbvJnyG+fJdUvQMPmbBbwtu9Nx+TNLA7x/PyxjPiZ9V+UjRkaMpnXqR+3A3wj6q2SUsoPLOcJTuzdotSgfvwp0Tf2yjYgB8XTry/aVJER2VHRkQBtaOwTGeZgHmbrjwI4vneyaTaBT7BrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWCjd5qB; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-481e9c27378so553569137.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716430382; x=1717035182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1lMe0BW3zdhy3z9O2IXydLXD1KWR4YUlXDc/mEdmhI=;
        b=FWCjd5qB7yquVlCDkZa4zZ1kRBbvfqyzFlJc+oxiv35f3lzxdmUtD15uk+G+/CrD7m
         kXsDdxL8K6leRrQy7oaUA2aOZrhfG+Jv67W4U4vpn4IwTeb2rUsMfB9FRBrvym1/2dxk
         FRhMPOg901JHWaCNUoMfPVfCvloh8KBeYK9ZS1O6qN9tAtz7oMg0xw+aZ7Y/HQ4HmjyZ
         1/hKyy12571ws0rAyQfPPhDOlJbpfFvrwb7LbhvdjIOTdGhD2cJs31PDTcRi/gB/9fLN
         5b6OAG9tuRuw7hJg0HC4Puqi9noRAGMN9QbGzUcD59Dh8VRWnkBFVGBGNxbpBRyGROH5
         GfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716430382; x=1717035182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1lMe0BW3zdhy3z9O2IXydLXD1KWR4YUlXDc/mEdmhI=;
        b=ews3nmIW7uI2Q7KuMYRImvIbWDBeFsXdyCShhp0UM7ruU3WazdbjsmW2UJPHqCggp+
         TCgchKwEaTaW92/ncp/ECipQ4KGTc2fbdPcJGpVYQknjMpWSbkpCijiMrMFu7xk6g/SG
         qGZPKBgy99N/tyGk18SI91JXMDSBbdLIW3UPfwSltI0VcVbqS3odcBgtwPayMcs6NjyR
         WjDfZXYaOo/HNNRdUJbeQkjl+sLDKhbgpD/AxT3TCBvF86foCyA+A2bq4q24GPERI3+M
         Uh+ZMyygxJBeoQEpmagt3V1LPfG0CSNmiHQZh5Dnk7WH4t3f5ChereoZAqo9vyOQFnYs
         XFKg==
X-Forwarded-Encrypted: i=1; AJvYcCXV/khl+Y/j08OE8Z/xXsS+W6vUKjil4KNTDozsjjHWbx8k5vLHk1x6BDaqZDPy+11JuHKNcLGyTBX4CPVyotd9uidOkH2Ubsp019L7
X-Gm-Message-State: AOJu0YyvRBq5FkjOnRAByhDvCCBNBVhDKtdl/L6P+aMiYi+h/L3wORe+
	xBUfrRGpRxDc5MWKCgCitaO7AOgEHEbjcYXEjTKppsjL+tYHGD/KPliKBx/rKr+y2AIdHjlWY+u
	EQKzBMUBfXjKxn/v++gxOA6KoTzE=
X-Google-Smtp-Source: AGHT+IErkUXRES85a2bRgpqDt3Wexpr/W6CJgPc1CpxJihpy/ZFuGZkfSevk7hBeUKzryVCzkej6/WFM5RoE96X3i6o=
X-Received: by 2002:a05:6102:3f44:b0:47e:f2ea:f673 with SMTP id
 ada2fe7eead31-4890a275124mr4493024137.23.1716430381785; Wed, 22 May 2024
 19:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
 <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com> <51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
 <CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
 <875xv5ba8t.fsf@yhuang6-desk2.ccr.corp.intel.com> <18aa865a-6d4a-4dcf-99ce-bcfbc0c92f19@linux.alibaba.com>
In-Reply-To: <18aa865a-6d4a-4dcf-99ce-bcfbc0c92f19@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 23 May 2024 14:12:50 +1200
Message-ID: <CAGsJ_4xeuLS9L=ayUSor4kXs8B1c2bY01cGZYrR7QjdwQWu7Lg@mail.gmail.com>
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	willy@infradead.org, ryan.roberts@arm.com, ziy@nvidia.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 1:38=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/23 09:14, Huang, Ying wrote:
> > Barry Song <21cnbao@gmail.com> writes:
> >
> >> On Wed, May 22, 2024 at 9:38=E2=80=AFPM Baolin Wang
> >> <baolin.wang@linux.alibaba.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2024/5/22 16:58, David Hildenbrand wrote:
> >>>> On 22.05.24 10:51, Baolin Wang wrote:
> >>>>> The mTHP swap related counters: 'anon_swpout' and
> >>>>> 'anon_swpout_fallback' are
> >>>>> confusing with an 'anon_' prefix, since the shmem can swap out
> >>>>> non-anonymous
> >>>>> pages. So drop the 'anon_' prefix to keep consistent with the old s=
wap
> >>>>> counter
> >>>>> names.
> >>>>>
> >>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> >>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>>> ---
> >>>>
> >>>> Am I daydreaming or did we add the anon_ for a reason and discussed =
the
> >>>> interaction with shmem? At least I remember some discussion around t=
hat.
> >>>
> >>> Do you mean the shmem mTHP allocation counters in previous
> >>> discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I ca=
n
> >>> not find previous discussions that provided a reason for adding the
> >>> =E2=80=98anon_=E2=80=99 prefix. Barry, any comments? Thanks.
> >>
> >> HI Baolin,
> >> We had tons of emails discussing about namin and I found this email,
> >>
> >> https://lore.kernel.org/all/bca6d142-15fd-4af5-9f71-821f891e8305@redha=
t.com/
> >>
> >> David had this comment,
> >> "I'm wondering if these should be ANON specific for now. We might want=
 to
> >> add others (shmem, file) in the future."
> >>
> >> This is likely how the 'anon_' prefix started being added, although it
> >> wasn't specifically
> >> targeting swapout.
> >>
> >> I sense your patch slightly alters the behavior of thp_swpout_fallback
> >> in /proc/vmstat.
> >> Previously, we didn't classify them as THP_SWPOUT_FALLBACK, even thoug=
h we
> >> always split them.
> >
> > IIUC, "fallback" means you try to do something, but fail, so try
> > something else as fallback.  If so, then we don't need to count
> > splitting shmem large folio as fallback.
>
> Agree. In additon, IIUC we have never counted splitting shmem large
> folio as THP_SWPOUT_FALLBACK before or after this patch.

Hi Baolin,

My point is that THP_SWPOUT* has been dedicated to anonymous memory for yea=
rs
because we have not had the capability to perform THP_SWPOUT for shared mem=
ory
before. This is the historical context of thp_swpout* in /proc/vmstat,
even though it is
not ideal. Therefore, placing shmem sysfs entries in
/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats
allows us to monitor SWPOUT and SWPOUT FALLBACK for shmem without altering
the tradition of /proc/vmstat.

But I am not firm on this because I don't see the necessity to
differentiate shmem's
swpout from anon's swpout. They basically seem the same while anon mTHP
faults might be significantly different from file mTHP faults, in which cas=
e we
must distinguish them. So please send version 2 with the updated documentat=
ion.
I believe it should target v6.10-rc rather than v6.11 to avoid ABI
conflicts if it is
accepted.

>
> > For example, before commit 5ed890ce5147 ("mm: vmscan: avoid split durin=
g
> > shrink_folio_list()"), if folio_entire_mapcount() =3D=3D 0, we will spl=
it
> > the THP.  But we will not count it as "fallback" because we haven't
> > tried to swap it out as a whole.

Thanks
Barry


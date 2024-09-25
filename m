Return-Path: <linux-kernel+bounces-339229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD989861E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5010B2559D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F31619B3E4;
	Wed, 25 Sep 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdXTRvMF"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B0189BBD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274114; cv=none; b=oCKx+nL2Lt23hOgQIvvRngux/8WC/60eYsqaSXFBQ6robiLZydDWJUq01meWoO7zd7E9b6/vMQXN9iEyNWPubU3qEnNV94X0/CWsP7hOyPp8CHLo6rkmcUvjzfuyVXJ090tw/jN3XH/a8fS7DICXJ9PvFxbRW64k6pKo0Bmk2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274114; c=relaxed/simple;
	bh=egvz8ch9jwn0VCXxH73GXr25LZf/mWBCiZO4wbewMac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhfh3BfFH1gMoyi/4KcDmjMFrpI7F9reuQSOQIVMHVo8cHFwab4W7rhE+AwY8Y5pVo+AL7hP1f5xzFJCtYIInTfzIRbA2aF7G+GnbxTfm6VbmngCtqjQAdmBmbZHcReXPreHXfhkGKTerxGE7gLidbmN8DGNj7PCtrHAlHaOFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdXTRvMF; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-710dead5d2aso3953892a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727274112; x=1727878912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUX2R/4DKEm5BrQh684qt+Rp2UEcR8k7YIpN8oCAb7c=;
        b=XdXTRvMFri1npYR7IwnHubd+XKOjUbHjLb6+syqBb8yhR6OhTgSaDbPVu8cD2HjfqB
         VkVS+psKWCQFyx6+3v/sIcEkXVclawuFH220OSTTIUvfBg+OYJSubDZ3Y6MkuuZjX3YK
         kPcuqOLI4WEb06bEEziY9VqCuCRgQ/cxSoE9c1HgqMowWBWXKfM2C5mg4K3R8oe7sVbp
         KAAm2StAuKiLIBht/zWpEdGmcwcLjX8IvwYx5jma0xb2I6Fnx3nlGy5gmT95ojOzbV8K
         o1i4bBaMBoPOx7rPB85+j6GXRJWlMvNn+igAglfl/t7baKEFxD7uoPMe5KA7biFJxrm1
         SKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274112; x=1727878912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUX2R/4DKEm5BrQh684qt+Rp2UEcR8k7YIpN8oCAb7c=;
        b=On5T8JmzHjvrkSK9nBhwv6pg3LWXS0QQpg1tD9MbHUeXLK6zhmnYx6dMpDuhTkx+LI
         WH4Zec2GfZXmfqHc4YVocEeuQGFPU+Ds6CYkecheO0Z/Zgsw8o79wv5wM1sqSZt7FTqR
         tuREruf+5TAEIKxE/NTBRkRoNhk7x+27Xt+jUkJVF+en6OVTHpMaU+8ZWWcSj6GXqUfk
         nU2AuXpeV1KtIjwECR5T8oRvSqHTqdtNDJPbfAdfLlKgn+vlSe8Aob6bq0u4muHRYyHA
         T/M2oHFc1Dd0j/VdttkZvipsgBHjV4mgJDJuCOsGQDFp+DUEdjgMHo4FS1nySPG0PDoI
         8fUw==
X-Forwarded-Encrypted: i=1; AJvYcCXlhAMN+THvUA7msQ785x9Jnn1vaQ2ZI5FgXMWx2FTryKnqRCGVPfYcUrDIvJaAcxXKvxo2dSj65OZVB6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnpUn4QRPEj10NsNJyTWodkxRWmH6hwpCWkbv1IaK3h3b6SdH
	kfWNczxzgifJi71RufLLLfQ8sQ0G9CM2GUYS6Sd/x3NfN2wb7EJdWSoiIGYR7JNHggcqaQn3+QJ
	O4YoIw80hn79rfCokdldHfKngAZs=
X-Google-Smtp-Source: AGHT+IFCmjMMMSz3UuZaFArM30/mfTctnxogkKFwe79uHL6ltwW9DV/zsCz+yYFCuz/ixoc+NVYDIsOKsp+veHgdo5M=
X-Received: by 2002:a05:6359:4588:b0:1b8:4598:31e2 with SMTP id
 e5c5f4694b2df-1bea86739f8mr183914155d.23.1727274111662; Wed, 25 Sep 2024
 07:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com> <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
 <87o74cryhu.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yckKO29b-BtTHazJEcf58R4JaUkTYZbhNDByLecqJGGQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yckKO29b-BtTHazJEcf58R4JaUkTYZbhNDByLecqJGGQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 25 Sep 2024 07:21:40 -0700
Message-ID: <CAKEwX=NuRuu9qXA9mRMqb6Okcwa86mEkp2Ac8sQjwb0ACdS7YQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Barry Song <baohua@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 12:33=E2=80=AFAM Barry Song <baohua@kernel.org> wro=
te:
>
> On Wed, Sep 25, 2024 at 3:23=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
> >
> > Nhat Pham <nphamcs@gmail.com> writes:
> >
> > [snip]
> >
> > >
> > > My understanding now is that there are two for loops. One for loop
> > > that checks the entry's states, and one for loop that does the actual
> > > incrementing work (or state modification).
> > >
> > > We can check in the first for loop, if it is safe to proceed:
> > >
> > > if (!count && !has_cache) {
> > >     err =3D -ENOENT;
> > > } else if (usage =3D=3D SWAP_HAS_CACHE) {
> > > if (has_cache)
> > >     err =3D -EEXIST;
> > > } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
> > >     err =3D -EINVAL;
> > > } else if (usage =3D=3D 1 && nr > 1 && (count & ~COUNT_CONTINUED) >=
=3D
> > > SWAP_MAP_MAX)) {
> > >     /* the batched variants currently do not support rollback */
> > >     err =3D -ENOMEM;
> > > }
> > >
> > > At this point, IIUC, we have not done any incrementing, so no rollbac=
k
> > > needed? :)
> >
> > I think that it's better to add a VM_WARN_ONCE() here.  If someone
> > enabled 'nr > 1' for __swap_duplicate(), the issue will be more
> > explicit.
>
> ying, i guess you missed this is the exact case Nhat is enabling
>  'nr > 1' for __swap_duplicate(). and this warning is functioning.
> and he is trying to support the nr>1 case.
>
> https://lore.kernel.org/linux-mm/20240923231142.4155415-2-nphamcs@gmail.c=
om/

I'm only supporting the case nr > 1, when there is no need to add swap
continuations :) That's the only current use case right now (shmem) :)

1. Keep the non-batched variant:

int swap_duplicate(swp_entry_t entry)
{
    int err =3D 0;

    while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
        err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
    return err;
}

2. Implement the batched variant:

int swap_duplicate_nr(swp_entry_t entry, int nr)
{
    swp_entry_t cur_entry;
    int i, err;

    if (nr =3D=3D 1)
        return swap_duplicate(entry);

    err =3D __swap_duplicate(entry, 1, nr);
    if (err =3D=3D -ENOMEM) {
        /* fallback to non-batched version */
        for (i =3D 0; i < nr; i++) {
            cur_entry =3D (swp_entry_t){entry.val + i};
            if (swap_duplicate(cur_entry)) {
                /* rollback */
                while (--i >=3D 0) {
                     cur_entry =3D (swp_entry_t){entry.val + i};
                     swap_free(cur_entry);
                }
            }
        }
    }
   return err;
}

How does this look? My concern is that there is not really a use for
the fallback logic. Basically dead code.

I can keep it in if you guys have a use for it soon, but otherwise I
lean towards just adding a WARN etc. there, or return -ENOMEM, and
WARN at shmem's callsite (because it cannot get -ENOMEM).


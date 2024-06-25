Return-Path: <linux-kernel+bounces-229689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 619339172CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27A71F20ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D617F4EA;
	Tue, 25 Jun 2024 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoTEiLY+"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64217F4E5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348831; cv=none; b=tBwFtksCd7X3ASpiBGqzMipiShEV1a5gbJNJY+veHqGxI+dhKcdBzikwNV7EvwdEPdszTjIr5AW840+oElV0CfsJ1MNjxTiQnRSdBtxsse2CKTeuSGueALACfintgBu/ZEGat9x8fb/Lld4WRf2TP4sCA1wYLugo7NaloH33P8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348831; c=relaxed/simple;
	bh=z4ZGx+eUj/88bsn4q/UdsOuUZ9dGZXmFOAmGCk7pgPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KS9vHJen89z/UMXkuhvkaWaNrMbm3qXV6/dvcIgVaCH2oYgo1EEwVKtBQxCIxu4YbBB5EXnccItykUZg1CHqYie2Uti5gbVj3vBivDBl2yG7EYivmsMCwtGjQ1o9RUzIRGo40Ez/0XZG7MGaIPtYiOo2YrZaec9wbT4XCOUh068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoTEiLY+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso7249722a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719348828; x=1719953628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4ZGx+eUj/88bsn4q/UdsOuUZ9dGZXmFOAmGCk7pgPY=;
        b=GoTEiLY+8Pi0Bn5VfeA6MyuV3E7hzQAEqOhzmYN2lScllk8jk51DTtZD8qIgWiBxao
         RoSXv6q9xkV1RWjLc2oMQ7k7ugxuQpjAfQpmV+p8fTsHNhc71FPngX4bWj+FijckVvWj
         qC68H+iTp2owEttq4qVrnxsfZ80xlHUOi5rF1CenTM6UBcKFu7/sxbHFVAC6ulKZYMxj
         YZx6K6oyGeIOa5v/jnylPy730E+1yRxFHH074FkgOZLopFrc5TZFSNcpNCbpYQ2dXFlC
         eQeKhDbmqbbAG9SadzognfYqMZRJMvrilNiqWukBAQXqH7QjCzZT3oehZkA6vo2b9Znt
         FBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719348828; x=1719953628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4ZGx+eUj/88bsn4q/UdsOuUZ9dGZXmFOAmGCk7pgPY=;
        b=mIRMrdq/RgOgdZXP0fD1XPYrQuz32QDMH/ONeaqghGukpd+PV5ws7IsLh29qe9exS+
         HeCLP85yM6HzQjRCMiKj9o3/ZeoqxdeX1wx7cgRBwsy0SdZOadXXavOJP9LJyexO2Beu
         Hfq1jm4r7TsLgu00Jc1iEz6Ic1KrgjTUMMe67xrLWUS+72oZoyFcJpa0RSuIkt1PBtKu
         5/DzIsuELfzrhGXytahTH5ZgU+nsiqN55SuHiPX7c8jNeQd75fpc9OoOn77ZyumsVna5
         xiYHdBpTvSbgN/3X+7DNuKv6XWTh+44ZutA9/iFF3G3/vsmu6iluqzu+h3IeSAtZDwAL
         IX5A==
X-Forwarded-Encrypted: i=1; AJvYcCUTUUQTkRn1QEVIv+SXmsXCcssm/WDVRxKs189WslGRNDf0Qjhhx/ynPP2yLZlp3qy4sRMp9OfQKIUq3QjJ+Z9xyuJ/ODm5hQS0PLu0
X-Gm-Message-State: AOJu0YxIDUzKaiqBzWkHlN4z/O2RvHxGvIPGrDK/khHFo8cwZC2cn4A5
	VTmWUJ7VwkSe4L8rwcS9Whqs+YTQsY03msPbAXn4l0UPlUKeVDlSSu5EPcUohX3vLiOtq9DZSAB
	AsthX8LVj65ytKjvwrhc2qqIx20s=
X-Google-Smtp-Source: AGHT+IH5PQs9YzD9mfM0POb5kScQniP/tipBmiBdJrOxOGBmxDIsHGit04FrMCXY53ICfWyLw0tLbXeTFUVpmqdI2fE=
X-Received: by 2002:a50:c056:0:b0:57c:5eed:4ebf with SMTP id
 4fb4d7f45d1cf-57d4bd79d81mr8081097a12.19.1719348827856; Tue, 25 Jun 2024
 13:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com>
 <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
 <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com> <CAHbLzkpnDPYWq=HnaJcKhKnppdNikX4YG+1Ysu8Z+XJCoKK4SQ@mail.gmail.com>
 <CAHbLzkr5K=4Shiyb5KgPTQ20jE2Zo08wK=mT3Ez9ADEdJe0Z9A@mail.gmail.com>
 <Zl3M7iniPQaPFDrW@xsang-OptiPlex-9020> <CAHbLzkrOTAaYahG4JYMNrJDhQNZZxW9u+2n71J=v1XYJEVpUdw@mail.gmail.com>
 <CAHbLzkr16YZ80ES5U4BEWJ+ueL22nDJtgH=eOztdHfy080diPw@mail.gmail.com>
 <ZmEb2mdAbBQ/9PMP@xsang-OptiPlex-9020> <CAHbLzkqORuPjr3p7aZGPKSLfdptrg=z1624rcxjud_zs3+HnCA@mail.gmail.com>
 <Zmk5xAF+vHYLwzoG@xsang-OptiPlex-9020> <CAHbLzkp3bEE50n1DKfXUYHoGivOzdhwQsLF=s64QVJUEaWCG8Q@mail.gmail.com>
 <fc16f6d0-9605-43c6-8199-179029dac6d4@redhat.com>
In-Reply-To: <fc16f6d0-9605-43c6-8199-179029dac6d4@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 25 Jun 2024 13:53:35 -0700
Message-ID: <CAHbLzkqfwKg584RniHfxk_Pp+iVUvazQv082P0x=CVg+5inMRQ@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: David Hildenbrand <david@redhat.com>
Cc: Oliver Sang <oliver.sang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christopher Lameter <cl@linux.com>, Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lkp@intel.com, oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 1:41=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.06.24 22:34, Yang Shi wrote:
> > On Tue, Jun 11, 2024 at 11:01=E2=80=AFPM Oliver Sang <oliver.sang@intel=
.com> wrote:
> >>
> >> hi, Yang Shi,
> >>
> >> On Wed, Jun 05, 2024 at 08:44:37PM -0700, Yang Shi wrote:
> >>> Oliver Sang <oliver.sang@intel.com>=E4=BA=8E2024=E5=B9=B46=E6=9C=885=
=E6=97=A5 =E5=91=A8=E4=B8=8919:16=E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>>> hi, Yang Shi,
> >>>>
> >>>> On Tue, Jun 04, 2024 at 04:53:56PM -0700, Yang Shi wrote:
> >>>>> On Mon, Jun 3, 2024 at 9:54=E2=80=AFAM Yang Shi <shy828301@gmail.co=
m> wrote:
> >>>>>>
> >>>>>> On Mon, Jun 3, 2024 at 7:02=E2=80=AFAM Oliver Sang <oliver.sang@in=
tel.com>
> >>>> wrote:
> >>>>>>>
> >>>>>>> hi, Yang Shi,
> >>>>>>>
> >>>>>>> On Fri, May 31, 2024 at 01:57:06PM -0700, Yang Shi wrote:
> >>>>>>>> Hi Oliver,
> >>>>>>>>
> >>>>>>>> I just came up with a quick patch (just build test) per the
> >>>> discussion
> >>>>>>>> and attached, can you please to give it a try? Once it is
> >>>> verified, I
> >>>>>>>> will refine the patch and submit for review.
> >>>>>>>
> >>>>>>> what's the base of this patch? I tried to apply it upon efa7df3e3=
b or
> >>>>>>> v6.10-rc2. both failed.
> >>>>>>
> >>>>>> Its base is mm-unstable. The head commit is 8e06d6b9274d ("mm: add
> >>>>>> swappiness=3D arg to memory.reclaim"). Sorry for the confusion, I =
should
> >>>>>> have mentioned this.
> >>>>>
> >>>>> I just figured out a bug in the patch. Anyway, we are going to take=
 a
> >>>>> different approach to fix the issue per the discussion. I already s=
ent
> >>>>> the series to the mailing list. Please refer to
> >>>>>
> >>>> https://lore.kernel.org/linux-mm/20240604234858.948986-1-yang@os.amp=
erecomputing.com/
> >>>>
> >>>> got it. seems you will submit v2? should we wait v2 to do the tests?
> >>>
> >>>
> >>> The real fix is patch #1, that doesn=E2=80=99t need v2. So you just n=
eed to test
> >>> that.
> >>
> >> we've finished tests and confirmed patch #1 fixed the issue.
> >> we also tested upon patch #2, still clean.
> >
> > Thanks for testing. Sorry for the late reply, just came back from
> > vacation. It seems like Andrew didn't take the fix yet. I will resend
> > the patch with your tested-by tag. And I will drop the patch #2 since
> > it is just a clean up and I didn't receive any review comments. In
> > addition, the undergoing hugepd clean up may make this clean up
> > easier, so I will put the clean up on the back burner for now.
>
> Sorry, was expecting a v2 of the second patch. But agreed that posting
> the second patch separately is reasonable -- possibly after the hugepd
> stuff is gone for good.

I can revisit the cleanup once the hugepd stuff is done.

>
> --
> Cheers,
>
> David / dhildenb
>


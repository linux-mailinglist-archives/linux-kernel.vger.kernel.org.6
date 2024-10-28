Return-Path: <linux-kernel+bounces-386012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A189B3E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3871C223B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FC1EF92A;
	Mon, 28 Oct 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ee40SCiL"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5818E049
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156082; cv=none; b=G/CYXxK1en/dvthHAJbAyD71AlT8PrO6Ae/kQ6iHFD4zFFiL00WGlnyVjEvxs35/6knJbu93m9+MMBYhR6mtLe3ZyFGby+DtstHkMl+PYGxpjdx5GnmVnBZrBK54TenK3O6nRTGIFVhymd7rwSCfOcsvx8yE5FIDsZt/2k6asME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156082; c=relaxed/simple;
	bh=ZFYzTT9VCZTuKfkSmTat5ifTWKCFpRoKLJorE3qBJDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hj/4OfwD6RzJ3SDn6cOOauGWhP8V4afvSx/OPWHhSETNutNixErEzF7uU4iIfj4q+towoybD5h1iVturfuWImJNybVaHq0cRquKtfJVeWwF36s43lP2GsYKbCPIubtLHhW0lZAMfkjt4tWD+LS4Syau+RrQKF8jW17wYqmGyzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ee40SCiL; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbf340fccaso39682636d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730156079; x=1730760879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFYzTT9VCZTuKfkSmTat5ifTWKCFpRoKLJorE3qBJDg=;
        b=Ee40SCiLH5DcSErl3galcTUj3mFum2Eg8DRgiBcemv+zN0nFIHiT75zVHp41PP3MSN
         BRY9QnyMkyMopmzSZec03igLhJSxaibqqk+sG2uyId4RngvXZF2PNhCMmo5W4aiBVDAg
         pMFIr/regwtf2YC/1PUJCp6i1QcEjV1NECW6Ty96mGiQtew3kTWbsEstk92PF0BZVwx7
         L+i+OKyHyccMKMT5uR8+0X2bYVfFn2MrTcItzhjcATQNx/H4Eww33t0B7o4z/lD0f2J5
         Icl1ueFGP7uJtXVuAgdkggzaFbJpeY9goVmAfxk3nsSDSPsFW/rGP4hrAQpCZOTeF9tU
         CRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730156079; x=1730760879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFYzTT9VCZTuKfkSmTat5ifTWKCFpRoKLJorE3qBJDg=;
        b=mA0L1y0Vtfrs77w2TLq+m2i7y+xj3IlMgpQExde+KVgpRXrUAeDdzRm/7u/Ks208gy
         8IY27IUNGdLQ1eW43xtF6rH7/TgdDp0z+ucUXdz8ppW4nbdfbevSyAcVv5Mgx6SXdaho
         5WdVPISI5t7xd5DjCqC1YWNSolX0WlxCe/mU/xWmd42KEYkkLOzN8Sjo63ey0uq+4r86
         OcBEvzsCVe5A2vyzl3S16Fq3hZchn6xI2sQVUR7JupkSJYwXjWTX3WBwt//J3MmgofM1
         LXhPHhcDzfWJRdBjy059i54Nc822fsVSCibDAb7zvzkYjwSFGai4o18BsghTPI3O5Tyt
         9ndA==
X-Forwarded-Encrypted: i=1; AJvYcCUCjj1Edto9Sqvgb3ibMWVoRW6Nrm7svM2gsi65sFlvSqQB9C0rmCX1fBtpUNm5woJpeVbR6V/fES9nfC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrH2QlhypL5BU1sSCDPC6Aqi/xKOts9I4m8qnP1owzuO1A0L13
	131UNjH9HuwS8/HqCMeGlqPHjzWx8UVedHjbCGah0eWJ/CIVIukp7WicabSWjToBAqfDldOGH05
	Diw0sJKy3ZNkUGFNiYRx51YENGzQKto7BfSdMEahrLfNul+DW6A==
X-Google-Smtp-Source: AGHT+IE0q/boBG3+oyN/Yjh/S1/GXOOj7dtxpjIxWf6HrXjs/nceYWFpbhOmvRcanhF+bDLY1ZcGrR0EThL0DWqD0LA=
X-Received: by 2002:a05:6214:234f:b0:6cb:ee9c:7045 with SMTP id
 6a1803df08f44-6d2b486abb2mr2573386d6.2.1730156078801; Mon, 28 Oct 2024
 15:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com> <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com> <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com> <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
 <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com> <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
 <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com> <CAGsJ_4wXO2Hjs0HZBGsGegBAeE8YxJbCF6ZXQQ6ZnVxgR82AuQ@mail.gmail.com>
 <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com> <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
 <03d4c776-4b2e-4f3d-94f0-9b716bfd74d2@gmail.com> <CAGsJ_4zRZFpJ0rWQ3XzspfSXN6xXN4eftCdL3xHPTqqYLUhQcA@mail.gmail.com>
 <CAJD7tkYPB=2c23LMi1+=qrPO+rcr5zJB4+2TPrcjAZHhsm=Vsw@mail.gmail.com> <CAGsJ_4yxoBVEY-Zpp3YNbiCCwbKO+v3-9R984uGVRHAtMSLDLQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yxoBVEY-Zpp3YNbiCCwbKO+v3-9R984uGVRHAtMSLDLQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 28 Oct 2024 15:54:02 -0700
Message-ID: <CAJD7tkYmBgp5WK9pD=ap=WuqWiiHvEhG0N0J_TiYdGRNaxwLVA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 3:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Oct 29, 2024 at 6:33=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > [..]
> > > > > By the way, I recently had an idea: if we can conduct the zeromap=
 check
> > > > > earlier - for example - before allocating swap slots and pageout(=
), could
> > > > > we completely eliminate swap slot occupation and allocation/relea=
se
> > > > > for zeromap data? For example, we could use a special swap
> > > > > entry value in the PTE to indicate zero content and directly fill=
 it with
> > > > > zeros when swapping back. We've observed that swap slot allocatio=
n and
> > > > > freeing can consume a lot of CPU and slow down functions like
> > > > > zap_pte_range and swap-in. If we can entirely skip these steps, i=
t
> > > > > could improve performance. However, I'm uncertain about the benef=
its we
> > > > > would gain if we only have 1-2% zeromap data.
> > > >
> > > > If I remember correctly this was one of the ideas floated around in=
 the
> > > > initial version of the zeromap series, but it was evaluated as a lo=
t more
> > > > complicated to do than what the current zeromap code looks like. Bu=
t I
> > > > think its definitely worth looking into!
> >
> > Yup, I did suggest this on the first version:
> > https://lore.kernel.org/linux-mm/CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQj=
DnsdwM=3Dg9cpAw@mail.gmail.com/
> >
> > , and Usama took a stab at implementing it in the second version:
> > https://lore.kernel.org/linux-mm/20240604105950.1134192-1-usamaarif642@=
gmail.com/
> >
> > David and Shakeel pointed out a few problems. I think they are
> > fixable, but the complexity/benefit tradeoff was getting unclear at
> > that point.
> >
> > If we can make it work without too much complexity, that would be
> > great of course.
> >
> > >
> > > Sorry for the noise. I didn't review the initial discussion. But my f=
eeling
> > > is that it might be valuable considering the report from Zhiguo:
> > >
> > > https://lore.kernel.org/linux-mm/20240805153639.1057-1-justinjiang@vi=
vo.com/
> > >
> > > In fact, our recent benchmark also indicates that swap free could acc=
ount
> > > for a significant portion in do_swap_page().
> >
> > As Shakeel mentioned in a reply to Usama's patch mentioned above, we
> > would need to check the contents of the page after it's unmapped. So
> > likely we need to allocate a swap slot, walk the rmap and unmap, check
> > contents, walk the rmap again and update the PTEs, free the swap slot.
> >
>
> So the issue is that we can't check the content before allocating slots a=
nd
> unmapping during reclamation? If we find the content is zero, can we skip
> all slot operations and go directly to rmap/unmap by using a special PTE?

We need to unmap first before checking the content, otherwise the
content can change right after we check it.


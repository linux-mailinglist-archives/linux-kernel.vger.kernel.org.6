Return-Path: <linux-kernel+bounces-346925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984A098CB17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0C2821FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B82F34;
	Wed,  2 Oct 2024 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl3cEame"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD08710E9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835253; cv=none; b=ANcLxukn3J/lO05xPeR5vo8mahOtJggtQyXCVaM56PxzQ58sJhdaQ+14V2pEItPMd2wu0X9/j2ycyBMK1Q3WO3MjiziJjAxw0v1co2+CTxbZ9v1Y0P2W6BrmOXuSU4F4PXWLmfMJBx23zl0DjK1Bs9CiFo0+m0msfnqelxg1OL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835253; c=relaxed/simple;
	bh=LFZOZJG10pd69hbuLm2Ben3C/v5CexJ3Fb6zstX8Vak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FN+VHyjRjzgkWNZ64qSbCu+uGeZ7ujuF6y5EHV1AzbblNClnsm2QweM7pQq87ktIXpZ+kYYOLi/egB4TVciMoGHs1zfiLJdQLRHlxdUNZIdUpejGgXgdgQWANcuapd2gy6R44MiUyym/7fWRvM2nfD9OwpWhXzSvZdhwgrS2bxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sl3cEame; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so106406966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727835250; x=1728440050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFZOZJG10pd69hbuLm2Ben3C/v5CexJ3Fb6zstX8Vak=;
        b=sl3cEameOXoVOttR9lbjAMoPE5cOLVw/flLPQHo/8BEDtWZX6tg3vfDn3TAV00PsP6
         j41e/obFRLAe9MGLgbuFiWdZIK6LyFvm4uCqUJ/lasIsGgjmJnyn3mrS0SvJQoIFPCmz
         bBm9JjVcm5YEWuUy4jCtpXP9PToWdFD9oIRGogGOVnGMZzTRrj7hsCZoxiRCmXm+8rXN
         sv9VbqPu+ZIi1Hbvj4z+bsh3GStfRAUrpz+AnsvJ3pfh6xqcvPtMu4gzv8MFMemQluFl
         /G4X93IULBdGHfIsvToUdtutL2NJVxxXu12T4DH9bbtoHnM5AkPA/D5TKwsFRB+1CwBt
         rHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727835250; x=1728440050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFZOZJG10pd69hbuLm2Ben3C/v5CexJ3Fb6zstX8Vak=;
        b=ca2Cahd1ueQYEJRpW+FqZfr3uOXaDzte42kxBJgYGoPYzek98rYhyUYfFEIRqWhPPH
         DMPCtA8ydyhrXdgXTaecC3k6oHQs8lwgtC/7UVlqgkRS0/OZwcDplC+eYmOsXkGtzkuC
         bTwqFndhn28SQcCJHkU4VuhwNj3rUHHLnS58NoyAyPjYYJVf2MAlSgnVdMV1I8U3cMmM
         h92QQLrla5SD7o6/pP6S0ABqj8EVibegqFlPR9W7BmRcC6GxVG14p38EPip5P3/7BmUW
         TaNGcrlAA4Hi123YAtILrXZGfvQnhYSGT6+uiWayuWbfLk7BMfN5wvErTy6vvo36hchc
         P13g==
X-Forwarded-Encrypted: i=1; AJvYcCVfhNV2cXGjoM593ytsBXUVtBXk8wINv/t9+IhY2XYCSIJi/4mAj4tgExZJxPTGZ3s4ZiLq26voKXgfE2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoaQuJmnTN+xTG6WO7+6MdKzrDlHo4tNFpBDmvTE72QH+raU/2
	ygN6u+fZ8DVkTIXVx+okRnTEUyQEtuWXLb02Ht2ACXLinbxLx9K6qw+Igboo0ANNun9Q1j87Cmz
	WfDdjEPXL+i8IQW1OGIcBysXulhs/d4fQ2V+j
X-Google-Smtp-Source: AGHT+IEVqM19Wk6qPNOiyciF7UFwWfzW5gunfwWsysiS0/KPc2RiKcZFnuHkx4KIlQMM47m/x7cZl3B9Ya+7OwkOl0Y=
X-Received: by 2002:a17:907:3fa4:b0:a86:9fbd:5168 with SMTP id
 a640c23a62f3a-a98f8207a8cmr127805266b.10.1727835249798; Tue, 01 Oct 2024
 19:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
 <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com>
 <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com>
 <CAKEwX=OTq2HaEKGgM4n8M60xh217r=vKs4U-GGc83moS5pcZJA@mail.gmail.com> <CAJD7tkYOs0Abg4818uCosbGAj=zq0eb-QppcE+w-xzg=TbCWiw@mail.gmail.com>
In-Reply-To: <CAJD7tkYOs0Abg4818uCosbGAj=zq0eb-QppcE+w-xzg=TbCWiw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 1 Oct 2024 19:13:34 -0700
Message-ID: <CAJD7tkaPX_AnzMu8c0ezxXkeLi1V-GBEgj6AaerhEK35-dUuUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 7:06=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Oct 1, 2024 at 7:04=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Tue, Oct 1, 2024 at 6:58=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > > On Tue, Oct 1, 2024 at 6:33=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >
> > > I was debating between WARN-ing here, and returning -ENOMEM and
> > > WARN-ing at shmem's callsite.
> > >
> > > My thinking is that if we return -ENOMEM here, it will work in the
> > > current setup, for both shmem and other callsites. However, in the
> > > future, if we add another user of swap_duplicate_nr(), this time
> > > without guaranteeing that we won't need continuation, I think it won'=
t
> > > work unless we have the fallback logic in place as well:
> > >
> > > while (!err && __swap_duplicate(entry, 1, nr) =3D=3D -ENOMEM)
> > > err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
> >
> > Sorry, I accidentally sent out the email without completing my explanat=
ion :)
> >
> > Anyway, the point being, with the current implementation, any new user
> > would immediately hit a WARN and the implementer will know to check.
> >
> > Whereas if we return -ENOMEM in __swap_duplicate(), then I think we
> > would just hang, no? We only try to add swap count continuation to the
> > first entry only, which is not sufficient to fix the problem.
> >
> > I can probably whip up the fallback logic here, but it would be dead,
> > untestable code (as it has no users, and I cannot even conceive one to
> > test it). And the swap abstraction might render all of this moot
> > anyway.
>
> What I had in mind is not returning -ENOMEM at all, but something like
> -EOPNOTSUPP. The swap_duplicate_nr() will just return the error to the
> caller. All callers of swap_duplicate() and swap_duplicate_nr()
> currently check the error except shmem.

..and just to be extra clear, I meant WARN _and_ return -EOPNOTSUPP.


Return-Path: <linux-kernel+bounces-186131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C98CC027
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D900B20AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538E824B1;
	Wed, 22 May 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW3RMo/i"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A207BB17
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377016; cv=none; b=B/MNhsv0Rbc2psPUgEfC+/DsG0xuyl/tzZMvxEmTUeAS/owegD8Vgjve9xGW6xplQS/qzBZv8A3QtFYYUZa2xnekgdO6XP4SWYMVkEuIi/Yp1NdAwfSNXB/HjTjwR8KqFTtluC9jfPWEkWsp2QwKUYpf8BQcFGBN+29H9XMg8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377016; c=relaxed/simple;
	bh=xMqBa0qO7yxY+IoZTzgWjyfsHmyDhPeia1tKmU4o354=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ih85KzglI8Y9GFNKu+XEHoYIWrhY9AHGNxkABf+NpU+Vu8HtzbhUNcM9Ym7VeVvOAMsTgm1ueuyAGUtlnrEKUKhfzBJ/APGgcafxkdoOeIWWHvh+wTkeFMgFI9FY5JF4Cm7vPjfvOdVyF5oo3z+4dzpfsjoPYeHtuCLproyuVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW3RMo/i; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso10596908a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716377013; x=1716981813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKvW/e/4RnItdVLQb65PoHq6f+Hy9fq9cA+PAi3QsG8=;
        b=BW3RMo/irakj0tIKxB82tmQomMO3P2cB/NkOUiylsUe2tzengD8Qu2NBmur0La86cu
         J/dg6VL4Wj0L8HmnRQvP82h1WECBZtbq0lru5SC1hTWYYzOP6ZgqxDeEoVP2HgNuV6NT
         4Lr4U77RqAriUFSjV9ts5tiWTZ9lELSa53EExldfHsoQT0oxNMqfNYFwHO0mvpIHDf5G
         uGp8Gvk66ag7nqAICmVI/rtpkBAuxx8QIPivWQ0NkncLc6J8IbQkZeJvr3jlIxkplyhZ
         1nPSTiV4BA3q9oMT0Af0ZiWucgtq2GGkByKqpM8xP7OSwRxxwQ7253NKbXIndsTKn1rf
         VVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716377013; x=1716981813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKvW/e/4RnItdVLQb65PoHq6f+Hy9fq9cA+PAi3QsG8=;
        b=Rsdi2CmvByno6H3dICiOaN54U8kaZgmS2CywcViGIqPm7LXkdTjrHRhF0uXDshtEts
         c2wCoNNnMmCbCcqWKS3PXQNA/cQFd3rfQjnrmzLZNLSj/9O0QVmI68rg0yCMZCH3UREK
         O/BEjX1Xg3FxzHgs9OfhtTmdFPkPFYLqYwNrFwDyjvxIzA0pu5bU2Cyg3D/SEABg/e60
         KegLxHRNePw6FbleS5yCEtKaaHEIpTs6a4BaRpmMuHODK2w6wAbNZghUWw1RoknZjNU+
         8t42RZkzeb8vjA284Y5y6j96F/Btd7A8Swg0icUE2lL3yYbb+nbuLzl1CQgqXNVeKZU3
         /ktg==
X-Forwarded-Encrypted: i=1; AJvYcCVhctqcUaveHIPIqE2C/748379lDEoyt+GsYcZ8wnfnmefHqgRd5q6LqOzYL8wmAfytEKlKOzbL82UfYUbK1H0nlUdwwbe3R6hRXI20
X-Gm-Message-State: AOJu0Yy8J9XoOpEbWNrVdFrK9YN/vZmdXHHBmtPtA8WNrnlp9xKka5I8
	xCyD0MM5BmlA8weASKq/B4mWAwIHN+VKopXl+Us0ZIVFS10gfQhrXTlkkNSdyko4+Ass/crdHDF
	taqMs2gADn4zyhwv2vTmsCvqcmQg=
X-Google-Smtp-Source: AGHT+IGr7qe/8BHMcSxEWmeTPmWJu59chEoX9tRLp2zcpEeslci+7hANSI/7DUiWuVLayDwYem1YGsNP8+m9V8E6Ha0=
X-Received: by 2002:a50:c05a:0:b0:572:9d24:257a with SMTP id
 4fb4d7f45d1cf-57832a807e6mr1148057a12.23.1716377013349; Wed, 22 May 2024
 04:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com> <CABzRoyZXq3u4DYxO39Fcezo56HAbkNh6xLuK9jnuiNK5gVmV1w@mail.gmail.com>
 <Zk2vDeQ3feZ3hsf0@google.com> <CAK1f24=fNFPyGCh+sxsq-Gg6BkD5qH=z+Ur2UD8+4CRZYoZc6g@mail.gmail.com>
 <Zk3EoLOvRhSO9ScG@google.com>
In-Reply-To: <Zk3EoLOvRhSO9ScG@google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 22 May 2024 19:23:20 +0800
Message-ID: <CAK1f24mmL16BxKnzZ7mF2WwAfjTpM1CP+dYEQ_AHvH2Q-mwAog@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
To: Brendan Jackman <jackmanb@google.com>
Cc: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 6:10=E2=80=AFPM Brendan Jackman <jackmanb@google.co=
m> wrote:
>
> On Wed, May 22, 2024 at 05:20:08PM +0800, Lance Yang wrote:
> > On Wed, May 22, 2024 at 4:38=E2=80=AFPM Brendan Jackman <jackmanb@googl=
e.com> wrote:
> > >
> > > Hi Lance, thanks for taking a look.
> > >
> > > On Wed, May 22, 2024 at 12:25:30PM +0800, Lance Yang wrote:
> > > > Hi Brendan,
> > > >
> > > > On Tue, May 21, 2024 at 8:57=E2=80=AFPM Brendan Jackman <jackmanb@g=
oogle.com> wrote:
> > > > > @@ -1077,7 +1081,7 @@ void adjust_present_page_count(struct page =
*page, struct memory_group *group,
> > > > >          */
> > > > >         if (early_section(__pfn_to_section(page_to_pfn(page))))
> > > > >                 zone->present_early_pages +=3D nr_pages;
> > > > > -       zone->present_pages +=3D nr_pages;
> > > > > +       WRITE_ONCE(zone->present_pages, zone->present_pages + nr_=
pages);
> > > >
> > > > I'm not sure that using the WRITE_ONCE() wrapper would prevent load=
 tearing
> > > > on 'zone->present_pages', but it's probably just me overthinking it=
 :)
> > >
> > > Hmm.. this isn't for load-tearing, it's for store-tearing. I have a
> > > feeling I might be missing your pont here though, can you elaborate?
> >
> > Sorry, my explanation wasn't clear :(
> >
> > I'm a bit confused about whether 'WRITE_ONCE(zone->present_pages,
> > zone->present_pages + nr_pages);'
> > is equivalent to the following:
> >
> > 1 a =3D zone->present_pages + nr_pages;
> > 2 WRITE_ONCE(zone->present_pages, a);
> >
> > If so, is there any possibility of load tearing on
> > 'zone->present_pages' in line 1?
>
> Ah gotcha, thanks for clarifying. Loads are protected by
> mem_hotplug_lock here, so it's fine for them to get split up (because
> the value can't change between loads). This is what I was referring to
> in the bit of the commit message about not needing READ_ONCE.

I see, thanks again for clarifying!
Lance


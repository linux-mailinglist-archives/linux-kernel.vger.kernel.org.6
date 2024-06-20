Return-Path: <linux-kernel+bounces-222926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E21910A06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792A31F2252D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D421B141B;
	Thu, 20 Jun 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNoLuSR+"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7041B140F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897827; cv=none; b=BbpJ+iBsN3l3wLKShR7NY9JOeBQJzpICwlhGj4Fdhz7ZhVKCCuq7A24+1BuK28+VHNKXd2rSUNp/Og53zrQ1flMIL08S0TSmXTM9QrdAIDgBx1RdX22Kz6bARGwHtfwv6uxZI6Z1+KpaOG6ahrYS9Q+3/1ek7WMqZcz1IdNyTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897827; c=relaxed/simple;
	bh=dQq91PMv6Hkh8U29G1UUbSNmF8C3plGL3zWrnxSr1eM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=anTuqDQ86I6aXhvIy65na6pQYBW87xskaeNRRds/S8IVeBYSnNi2KBqhcEFFH0jrquArZfhskRnXrxZvTzRNegun+LZq8fvQVgN0Q2NoISDtBajpLPHCD/H5XPn8/YJWDYo863xQ5uPFAw4BqO635z7Sbpbdk/s7WDYXtI5ojPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNoLuSR+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so1097108a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718897825; x=1719502625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcvtK+onJiZBymHPHugY4FRoclgetOnfb6qMYuc/RYA=;
        b=yNoLuSR+bnSKkFDS2PNQ6Acibp41lJSgBOgUVCWGIxVcxcEwmysZxaADQqQyQPnOYF
         a1neb757Ngznv26AR4GB1FC/VfV2z6S4zWsJ8IDgdl0pdnGdgAdd44LSRx8Bwfdq2pRC
         anxA245nafljElRXEM43PtNkqa4J6j58cj7ICnP2hMwhPrz55PKvym1r3fFRslSYNJ7u
         GIGLgSvHhrVGWcbXwsoO7GOzAsYioFSgRoUZ+d3ZdzcZx2lYs0b8iH/zq8cHIYstLGBR
         Qq69jibbwsp8f2+cVw0d84wVLW5YVcjulFss/qnxhmpiR58R/bT7zoDRB7M2NOhe0QxA
         /wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897825; x=1719502625;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YcvtK+onJiZBymHPHugY4FRoclgetOnfb6qMYuc/RYA=;
        b=unLQySpVXqi8aSO+NQ0obYXrlEeNH6kTVlloxckgpQx0jovuDUWKRxPlR7PYIZTaf/
         3FW7zqj70tTY13tG9NBL/rHs+of7TFu6rvUh+zrMSPCsN56wTYR5UFST2ZCwjmgUirAc
         Zd8WOFehgcKsRCq7U446tJodutJM8maS61NFWtIZl9RqEyemnQvm4a92PqzkPRFUUDb4
         XddiJVifSWLGhNR9N4/OjDtF/K+QwTNN05EuNkwdrHl7iZgXmnvn0tU3rBlDYoTr2p4O
         bIGnxMtlVB+N5LNGDGob7h7xQbjdovkG3qFqN8SLLTkx96+Jr4vK0OZ+4oH+wHUfENlj
         kh8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXK11TkfcB2pxQaws55gJYir33EfV+U9xiW+z13yZPnZ4+sW5/Pi7ZODmVpQ4cs7U1znafBQHFqV/PWlIjfIoX/FEmobIkhkRUeikoU
X-Gm-Message-State: AOJu0YyiAY67jq36AKdTDHL0CUk3EBttBvkY/FOJek+/ihxZhd+wOAxC
	kb6mszhxTLEWQ8jFoA/shLUYeYkxNf9CYCc0HuZOYPTMlDKyjjQvabtu7BneTH/BO6OEDJcJdI/
	yrg==
X-Google-Smtp-Source: AGHT+IHXhor/kuVW03oouyq1tDyLAY6GkCcCTg8hiO3HTvemYmIW2WnCN2V89ElanisIBodVVNdjjBCJ40M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3703:b0:2c4:aafe:75ec with SMTP id
 98e67ed59e1d1-2c7b4e45665mr16589a91.0.1718897824912; Thu, 20 Jun 2024
 08:37:04 -0700 (PDT)
Date: Thu, 20 Jun 2024 08:37:03 -0700
In-Reply-To: <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com> <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
Message-ID: <ZnRMn1ObU8TFrms3@google.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, maz@kernel.org, 
	kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024, Fuad Tabba wrote:
> Hi Jason,
>=20
> On Wed, Jun 19, 2024 at 12:51=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com>=
 wrote:
> >
> > On Wed, Jun 19, 2024 at 10:11:35AM +0100, Fuad Tabba wrote:
> >
> > > To be honest, personally (speaking only for myself, not necessarily
> > > for Elliot and not for anyone else in the pKVM team), I still would
> > > prefer to use guest_memfd(). I think that having one solution for
> > > confidential computing that rules them all would be best. But we do
> > > need to be able to share memory in place, have a plan for supporting
> > > huge pages in the near future, and migration in the not-too-distant
> > > future.
> >
> > I think using a FD to control this special lifetime stuff is
> > dramatically better than trying to force the MM to do it with struct
> > page hacks.
> >
> > If you can't agree with the guest_memfd people on how to get there
> > then maybe you need a guest_memfd2 for this slightly different special
> > stuff instead of intruding on the core mm so much. (though that would
> > be sad)
> >
> > We really need to be thinking more about containing these special
> > things and not just sprinkling them everywhere.
>=20
> I agree that we need to agree :) This discussion has been going on
> since before LPC last year, and the consensus from the guest_memfd()
> folks (if I understood it correctly) is that guest_memfd() is what it
> is: designed for a specific type of confidential computing, in the
> style of TDX and CCA perhaps, and that it cannot (or will not) perform
> the role of being a general solution for all confidential computing.

That isn't remotely accurate.  I have stated multiple times that I want gue=
st_memfd
to be a vehicle for all VM types, i.e. not just CoCo VMs, and most definite=
ly not
just TDX/SNP/CCA VMs.

What I am staunchly against is piling features onto guest_memfd that will c=
ause
it to eventually become virtually indistinguishable from any other file-bas=
ed
backing store.  I.e. while I want to make guest_memfd usable for all VM *ty=
pes*,
making guest_memfd the preferred backing store for all *VMs* and use cases =
is
very much a non-goal.

From an earlier conversation[1]:

 : In other words, ditch the complexity for features that are well served b=
y existing
 : general purpose solutions, so that guest_memfd can take on a bit of comp=
lexity to
 : serve use cases that are unique to KVM guests, without becoming an unmai=
ntainble
 : mess due to cross-products.

> > > Also, since pin is already overloading the refcount, having the
> > > exclusive pin there helps in ensuring atomic accesses and avoiding
> > > races.
> >
> > Yeah, but every time someone does this and then links it to a uAPI it
> > becomes utterly baked in concrete for the MM forever.
>=20
> I agree. But if we can't modify guest_memfd() to fit our needs (pKVM,
> Gunyah), then we don't really have that many other options.

What _are_ your needs?  There are multiple unanswered questions from our la=
st
conversation[2].  And by "needs" I don't mean "what changes do you want to =
make
to guest_memfd?", I mean "what are the use cases, patterns, and scenarios t=
hat
you want to support?".

 : What's "hypervisor-assisted page migration"?  More specifically, what's =
the
 : mechanism that drives it?

 : Do you happen to have a list of exactly what you mean by "normal mm stuf=
f"?  I
 : am not at all opposed to supporting .mmap(), because long term I also wa=
nt to
 : use guest_memfd for non-CoCo VMs.  But I want to be very conservative wi=
th respect
 : to what is allowed for guest_memfd.   E.g. host userspace can map guest_=
memfd,
 : and do operations that are directly related to its mapping, but that's a=
bout it.

That distinction matters, because as I have stated in that thread, I am not
opposed to page migration itself:

 : I am not opposed to page migration itself, what I am opposed to is addin=
g deep
 : integration with core MM to do some of the fancy/complex things that lea=
d to page
 : migration.

I am generally aware of the core pKVM use cases, but I AFAIK I haven't seen=
 a
complete picture of everything you want to do, and _why_.

E.g. if one of your requirements is that guest memory is managed by core-mm=
 the
same as all other memory in the system, then yeah, guest_memfd isn't for yo=
u.
Integrating guest_memfd deeply into core-mm simply isn't realistic, at leas=
t not
without *massive* changes to core-mm, as the whole point of guest_memfd is =
that
it is guest-first memory, i.e. it is NOT memory that is managed by core-mm =
(primary
MMU) and optionally mapped into KVM (secondary MMU).

Again from that thread, one of most important aspects guest_memfd is that V=
MAs
are not required.  Stating the obvious, lack of VMAs makes it really hard t=
o drive
swap, reclaim, migration, etc. from code that fundamentally operates on VMA=
s.

 : More broadly, no VMAs are required.  The lack of stage-1 page tables are=
 nice to
 : have; the lack of VMAs means that guest_memfd isn't playing second fiddl=
e, e.g.
 : it's not subject to VMA protections, isn't restricted to host mapping si=
ze, etc.

[1] https://lore.kernel.org/all/Zfmpby6i3PfBEcCV@google.com
[2] https://lore.kernel.org/all/Zg3xF7dTtx6hbmZj@google.com


Return-Path: <linux-kernel+bounces-255701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3AE9343E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0C41C2195B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFDD1850A3;
	Wed, 17 Jul 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjEtpAaw"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FE18059
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251843; cv=none; b=dlEAPmdpNKjroSDeMZUe74NZrh8HckfGm+DVKjNwLuYjQyyX88xzauKVXcfvb/lZx596zgYB25Av/rAqeDSieXzWJqqfFLcIqtf2TPZWHi5ZVo4eBScm0fie8kYnM/MAUyOjgJiVUH/VEikYuKiK5ryIlBukLm//lp+IXYxvS7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251843; c=relaxed/simple;
	bh=gix4RZzWCeOfWIRc59SMvMQVuoN4P1VF432Sc3mutug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYe2eBfM5anaqODImElQUz5+0PVweUrmurg7d35n6SbY9HD1OjdPcVY1w2xMde0+98P29++yJVyfogeSNMuJoyydrPcJIMm/ptwXHta9TJyachMlQHKQSv0Lg6rbL5/1K5OH6PgvZi/wcEvQFuYuwTsEot34PUlUURM/nMzCMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjEtpAaw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64b0d45a7aaso1029127b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721251840; x=1721856640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gix4RZzWCeOfWIRc59SMvMQVuoN4P1VF432Sc3mutug=;
        b=GjEtpAawRdtKXm1yG1aKagF8zO0Zx04L7G95aFiddg8C5o60d8nlarYSmb1DilxeYq
         pg0XfNoBXkZnWA4d2ONOofbJkLpYG2M+qlxtjZrjXahKpxL+R9yHHYvyiexLrxXFIqrX
         K73QJWgghpI0gUmT+MffkVrsMim8O+nWL0lon4EaUbwJtjN3h1q+psfr2u6akN+rTIF0
         5Y5DMhUzINzWKTj/teAzv+5UyJIhj/dG7GMGFljouhg0qKzgQx94QfBCiLwMphX1e0/e
         eXFTFw4Um23sPoWh/OZL2e4Xb4SWDUKMNQQeJLu42gWs89nPCiTvvbrMgfU47y4uAs/y
         F5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251840; x=1721856640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gix4RZzWCeOfWIRc59SMvMQVuoN4P1VF432Sc3mutug=;
        b=rtSPiJl9Mq6CZ6mNjKFxbWBfNaUD3XIeK8OEdPT4YTWjcFtyWANsYZojPvlx/z5dKx
         pD7ZxNc5WptT+h7Xbx/s//IUcjTY7nxH2DeGodE5r9F2FUHVSChIv/WHHWFhbcmmEykc
         xuuHQHUXquw+lL2bXlXSa5aCzRnP7tqvAOQHK8MgZRrqeD9fYiTblpWxtMjCtOtvQkZi
         AFjRslJL/LpZT4MwTUPog+KR0jwxkfItIbwr/gqJwtVEOrYm1bpeJF7o1uwgVaDsgbKD
         RT6t/r8f08HYgouhImIzuoQhyYdvfb4TuUPh6o1NGO4XN9gnDh2ZN++t087fps3739Wk
         S9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxjI6QjvsVQu3KmhhKkXpGkeujHj4RgQPLrMuaiBdgY5NWK9fiFekFQ8/59dP/SEMOzBcDoi7jWioBeU3fRGHbXD12gI0NvUMDpclv
X-Gm-Message-State: AOJu0YxT1hY9uJY5jNshhJXFRv67E2qFr2IXJ7Nws1olHbN0x/jyPH1G
	4F3EJUv/2Pm9HzY+An1mAk3zaB3U2zd4TlKoNzHA2QfkyWssQbACokvdk7BFYa7oK7WL9XVJNjN
	447Kss1CPjqLmtv3OeH0jkJlU4pk6NcWVBb8t
X-Google-Smtp-Source: AGHT+IFSQBXEEFmY88tpxdB9yZZ2M8dx8Tc06bJmHiaqFmB+8K8WkvgdngYKietzjrhO7uyZ+9fZI51PUM/+P1vw3f8=
X-Received: by 2002:a05:690c:4502:b0:64b:9a00:240e with SMTP id
 00721157ae682-666038006e4mr8807447b3.31.1721251840163; Wed, 17 Jul 2024
 14:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717181239.2510054-1-surenb@google.com> <20240717181239.2510054-2-surenb@google.com>
 <16286915-1350-4e6b-a0f6-deec02b7fa92@suse.cz> <CAJuCfpG2uNicytRYhfqAKrfkxJoNLUUK_o066D=yKggsoc3wKQ@mail.gmail.com>
 <10865b0a-175e-4b90-9042-7b63b1ea19f8@suse.cz> <CAJuCfpEnLGi8754DQeumLz0t+d6aXmEPEV64BMC0oRRqr9UX1A@mail.gmail.com>
In-Reply-To: <CAJuCfpEnLGi8754DQeumLz0t+d6aXmEPEV64BMC0oRRqr9UX1A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jul 2024 14:30:29 -0700
Message-ID: <CAJuCfpG0W=65v9Z5zPg4R3cmeQSexhA5nJTJSAsEc4ogqbC8eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] alloc_tag: outline and export free_reserved_page()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hch@infradead.org, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:20=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jul 17, 2024 at 1:19=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 7/17/24 10:04 PM, Suren Baghdasaryan wrote:
> > > On Wed, Jul 17, 2024 at 12:36=E2=80=AFPM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> > >>
> > >> On 7/17/24 8:12 PM, Suren Baghdasaryan wrote:
> > >> > Outline and export free_reserved_page() because modules use it and=
 it
> > >> > in turn uses page_ext_{get|put} which should not be exported. The =
same
> > >> > result could be obtained by outlining {get|put}_page_tag_ref() but=
 that
> > >> > would have higher performance impact as these functions are used i=
n
> > >> > more performance critical paths.
> > >> >
> > >> > Fixes: dcfe378c81f7 ("lib: introduce support for page allocation t=
agging")
> > >> > Reported-by: kernel test robot <lkp@intel.com>
> > >> > Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9=
I-lkp@intel.com/
> > >> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > >> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>
> > >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > >>
> > >> Are these two patches now stable@ material as 6.10 build is broken o=
n ppc64
> > >> with alloc taging enabled?
> > >
> > > I tested them with that specific configuration mentioned in the bug
> > > report and with several usual ones I use.
> > > Yeah, I guess from now on all such fixes should have
> > >
> > > Cc: stable@vger.kernel.org # v6.10
> >
> > Right. BTW I have just realized that the way you did Patch 2/2 and outl=
ined
> > the whole free_reserved_page() (which is fair, it's an init-time functi=
on),
> > mem_alloc_profiling_enabled() didn't stay inlined so Patch 1/2 is in fa=
ct
> > not necessary anymore?
>
> Yeah, I think you are right, currently no module has reasons to use
> mem_alloc_profiling_enabled() directly. That might change in the
> future but we can add the export at the time it's needed.
> I checked and ppc64 build passes with just this patch. Let me post v3
> with just this patch and Cc stable@.

v3 posted at https://lore.kernel.org/all/20240717212844.2749975-1-surenb@go=
ogle.com/

>
>
> >
> >
> >


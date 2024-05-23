Return-Path: <linux-kernel+bounces-186961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF748CCB42
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DA31C20FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F74D50A62;
	Thu, 23 May 2024 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXSCWJ1+"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49344685
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716436282; cv=none; b=WwEtviR2MKOy6X3KGj7R8gHNB9sWLa0QYlZ6um5jZJq9ouiNVApsWQmSRi3Yiz+mTIiijRl6rW/RTTVWcEHo4civFqfqTasjL+ZJpHjm9oHpX5DYd1NI1sS+VEhnKwqE22ycolPBAQ2v1VkPBj/pXwTKE/sfcd8wiCFQ8ytfHLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716436282; c=relaxed/simple;
	bh=iMGgLAI0RnofLrCqsYJdrGkFEOjJ+L4/MwpJ02XpNdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LC9lKe/GP2xGiSM4kaFF7DKT0Df6VyIh792PR4AvEBGFfzzbtuIsGnU9dMThCprBPOqbX7LMWGJTN2Z6Zo33n6R8NUzNQd/hwzSElTMRmI3aPXireikCDo13qiu4BrVTMGjERxd+cEyikO+63xwsJ9lwYvW7ec4S8bAUhuNxHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXSCWJ1+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dfe020675so299521cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716436279; x=1717041079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/0+KdIOmws+ZrFm/pd5ZcN2+OOmnR4z08zZunaz/hw=;
        b=EXSCWJ1+jMbqZ5D5P0+BhX0rk6lftj6jUr6TspddCAEN+64nl2M8LlMEoxs9xID2M5
         BshFpeYv+1NjtI9xNX1HctpgAilxwr2dhwTRAQjHXUlyWFDbg7QH6lREz6Xr7+2nVxBu
         ZKH1qBju9ZKhFGsD3KL/C7rj0SBZILBKYlKhDSpi+ae3/QFT5u1Q9YS7elJoFLPsd33h
         /9ruyJJmYH49pAeOwuJFWv14fbM6Ks3B0SV4zjGV7iYgX6IAg46EC/3qFZrKDbit/Wqt
         IDVIIu78kE9jTtbWcgzq6DG8nowhf+jBMG8pXU1RmefMdvN0+fYrWr6aTiIF7GoA2yDz
         tADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716436279; x=1717041079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/0+KdIOmws+ZrFm/pd5ZcN2+OOmnR4z08zZunaz/hw=;
        b=Vq7uqI6Pmq2HD/yC+l71n656TNvrp3MVoyqYCiw4PALaabXdXgaMAcI3ijs40c++9h
         jkxbj2QuPGAJNDAiuNfHNLoOqXqKQapmJN3UpaAAU9VjjFjIxDjW+OhLaU0kBLX4BgUM
         TUNovKNnhM5yLbcKuXZS8078tj+9jAqRxgdJnZwLlaAuAn5FDY8QMQUXpVhm0r5qnpmh
         Xg9b2igP8+d/VqmICV6It8Va4ixU19lA3m1c9qB5JVWwLyOT+b40AKFIEJvEsngWN+Kb
         sVQh+qX6fDJ2wkr2Ko3QnmxbqGSf0f2Zb2yLLUKQCGRVC/21Z3AItPAQohywd4pIBpFI
         qNbw==
X-Forwarded-Encrypted: i=1; AJvYcCUagBb1IuPT1YJtgv7tIHRq70tIA3FRKFarCPJqAshbM1cB1NT7fBJGfN2oM4ZWfHBDU3pEr33pont+/BHcjG5QUfC2n59sLrHtX+qt
X-Gm-Message-State: AOJu0Yw97ovm0d3om2AfBN8eo5wNA1xS712t298SB38vyZKg+/QXJBmB
	67nj6WZcvgVShBQ7J/GMHPQ3B1j1yqI3saz5ODbTbqtZbqTD/zoKXcwCdAPDAN3Tzcf0VdEOX79
	h8SEgYLTrgyWbrB69FMZn4pgZM40w7R8HNV3b
X-Google-Smtp-Source: AGHT+IEF7U0eAjRtPE1F4LSZ58RNB/uzqr2Lsi+zESRmuUtZJz08s97jQaPWmV6NfwanHAB+CCDsqLwqgE/Vu0ZL9GY=
X-Received: by 2002:a05:622a:1b16:b0:43e:cb4:1d10 with SMTP id
 d75a77b69052e-43fa745b199mr1765661cf.14.1716436278572; Wed, 22 May 2024
 20:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514084724.557100-1-visitorckw@gmail.com> <20240514084724.557100-5-visitorckw@gmail.com>
 <20240522161048.8d8bbc7b153b4ecd92c50666@linux-foundation.org> <gch7c2merdegxvqwpbb5ean7uj35tnh62fyviggjglftlfjs3i@jhbnllco5kau>
In-Reply-To: <gch7c2merdegxvqwpbb5ean7uj35tnh62fyviggjglftlfjs3i@jhbnllco5kau>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 May 2024 20:51:06 -0700
Message-ID: <CAP-5=fWn8AmE=0Y15Y3fm71zK0jsdgvH3UdmKUq5Pe6SAAsKCQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 04/16] lib min_heap: Add type safe interface
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, colyli@suse.de, 
	msakai@redhat.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	bagasdotme@gmail.com, jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:33=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Wed, May 22, 2024 at 04:10:48PM -0700, Andrew Morton wrote:
> > On Tue, 14 May 2024 16:47:12 +0800 Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:
> >
> > > Implement a type-safe interface for min_heap using strong type
> > > pointers instead of void * in the data field. This change includes
> > > adding small macro wrappers around functions, enabling the use of
> > > __minheap_cast and __minheap_obj_size macros for type casting and
> > > obtaining element size. This implementation removes the necessity of
> > > passing element size in min_heap_callbacks. Additionally, introduce t=
he
> > > MIN_HEAP_PREALLOCATED macro for preallocating some elements.
> >
> > I guess it's a nice change, although it's unclear how valuable all this
> > is.  Being able to remove the local implementations in bcache and
> > bcachefs is good.
>
> Yes, and now the standard kernel version is type safe. I suggested it to
> Kuan as a good starting project, I find (well picked) refactorings and
> cleanups are a great place for people to start.
>
> >
> > > --- a/drivers/md/dm-vdo/repair.c
> > > +++ b/drivers/md/dm-vdo/repair.c
> > > @@ -51,6 +51,8 @@ struct recovery_point {
> > >     bool increment_applied;
> > >  };
> > >
> > > +MIN_HEAP(struct numbered_block_mapping, replay_heap);
> > >
> > > ...
> > >
> > > -struct min_heap {
> > > -   void *data;
> > > -   int nr;
> > > -   int size;
> > > -};
> > > +#define MIN_HEAP_PREALLOCATED(_type, _name, _nr)   \
> > > +struct _name {     \
> > > +   int nr; \
> > > +   int size;       \
> > > +   _type *data;    \
> > > +   _type preallocated[_nr];        \
> > > +}
> >
> > I think that the MIN_HEAP() macro would be better named
> > DEFINE_MIN_HEAP().  There's a lot of precedent for this and it's
> > unclear whether "MIN_HEAP" actually implements storage.  I looked at
> > the repair.c addition and thought "hm, shouldn't that be static"!
>
> Agreed
>
> > >  /* Sift the element at pos down the heap. */
> > >  static __always_inline
> > > -void min_heapify(struct min_heap *heap, int pos,
> > > +void __min_heapify(min_heap_char *heap, int pos, size_t elem_size,
> > >             const struct min_heap_callbacks *func)
> > >  {
> >
> > It's a separate project, but min_heap.h has some crazily huge inlined
> > functions.  I expect we'd have a smaller and faster kernel if those
> > were moved into a new lib/min_heap.c.
>
> good thought - Kuan, want to do that too? Since we missed the merge
> window, may as well :)

Just to mention that the perf events use of the min heap is during a
context switch, so it is somewhat performance sensitive for people
context switching with perf events opened/enabled.

Thanks,
Ian


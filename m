Return-Path: <linux-kernel+bounces-380617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191E9AF3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A04E1F21834
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285EF217313;
	Thu, 24 Oct 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWQguhp+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6815A868
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802013; cv=none; b=Ng0njnOdW9qL/BRlh4iDsuB5D2Tb1jVjvpIkDb0TnoPDooo9UKZYgXJ6zab9s/C8XpJnQ9P9ffwCeWp2JJBLxef00JqzXcjOGI9VR1yz5qj5i3eAffuc9hH1gOeHWXov569E9K4jB3TZceCYJ7GMCPCFDOJyxu6YWdh5g+jK6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802013; c=relaxed/simple;
	bh=fg6TiyFvbDY3F7rgtjpzzrWknbfNctLjVqZiyU7qibI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTyPSDD7fA6owO6gS2gUZzBIFxCf5rlHIsQ9OadKYJEJIKXKlNVnnoz0XKMZOmFLjcky7zPvCEdj7PQ+S8+zgNYic1slu2odV/0WfAARih7XzkhtYynTmfhQdxWC7UeYj1SxajXRU8kw1rWEFTz7bY10ZZfmLWgzeHljMvle9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hWQguhp+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso148958566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729802010; x=1730406810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg6TiyFvbDY3F7rgtjpzzrWknbfNctLjVqZiyU7qibI=;
        b=hWQguhp+CnbddhzmUsGG7rMNi+4y30dOGw59I4DeY4Uo6INaw/VbXaIb6kB63L8wzs
         b1LUD0ODxmE5RhIjPqjBNKnuDUlM/ELWpyX+t5l5fuQIHA4DA+vExwVUohyUKpWdGHhv
         19XvLkFRtWWgPtkSzEQ54Pedp1xTZaydzU8YcEm2yTzekk3K6egKyRdol78NS2wIbZvE
         qY+BuuMGMimOgBgZRVqZ5uxx2uXh+DKGvUNf8wAUSK3d9VRVQ5J3IrsgYC2C27IXqw3v
         By1376iItMEgftZH9EX7RruyuLe6XnU2HAQUOm4P3B23fyTtArX8WsDV6bKUukBEULuH
         mOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802010; x=1730406810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg6TiyFvbDY3F7rgtjpzzrWknbfNctLjVqZiyU7qibI=;
        b=kwXSptN03wRayaQmBjttfsIAjoMe+axqrW0dM4Ar5f5XJbRKQjmsja47gFs3jA4QrQ
         dn9Kvlr2ywN/jwI0kPa+Q+wEgHNtiJxk+oUOXR54iAcOkvCTmNkSLKKDYYNCkro+6fjb
         rSHAYVwT1hxF4Ict3jbOoKNgGoAd5Uyw6cBXDZZSiUsLMysBw1DaR9QhwL58QKoZqXHn
         qOtIzgMTDhamHKWzq/kE6EJKnRuYEM/d8kWcV5F+gw91q/kpyUATVvauTcG+q+ZqokSQ
         tYvsgtUhIc9iJPAYatyEIwAW/6DLlmb6UOe4Kx4dv09NPwD+FehzIeup/fNmAHoSNO5T
         uDJA==
X-Forwarded-Encrypted: i=1; AJvYcCWn3To9SQRqhk+HrqLmMH68VSouUAjbTXPpOWO3cGoL+N1bKxRkm01NFjvAWrFSX8RQEexrJ4L+h52uYh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHsiqkM2FlcCbk0z/nwzr1XgcKO1cAaVBd7uv7ji5ZTSuY7tJ
	+7b1VtWolqeJHxheTeR+SnXB5Gc4wfHTjPDLCncWm/J1gCSYxczE2x79QNJiYhKOURt0O1IWPqB
	sqzfDzCNu+IIRTGgfy7dOBRGWnSvFb/Ap8/s5
X-Google-Smtp-Source: AGHT+IFUTfSFqD0LJ8fBf/qBjK9gkH3Z9YIIz4iHZrS73DoGiaBlQz65rZWWLT2VwceQlhDcqTGP7QpWRdHLEYK/iBw=
X-Received: by 2002:a17:907:6d29:b0:a8a:58c5:78f1 with SMTP id
 a640c23a62f3a-a9ad2711791mr278966966b.11.1729802009584; Thu, 24 Oct 2024
 13:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev> <Zxp63b9WlI4sTwWk@google.com>
 <7w4xusjyyobyvacm6ogc3q2l26r2vema5rxlb5oqlhs4hpqiu3@dfbde5arh3rg> <Zxqj7hw6Q6ak8aJf@tiehlicka>
In-Reply-To: <Zxqj7hw6Q6ak8aJf@tiehlicka>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 24 Oct 2024 13:32:53 -0700
Message-ID: <CAJD7tkYsCev299G=h2r_e6i34+ccdXJYphv-bQbROqOd7Lr1Uw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
To: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:45=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 24-10-24 10:26:15, Shakeel Butt wrote:
> > On Thu, Oct 24, 2024 at 04:50:37PM GMT, Roman Gushchin wrote:
> > > On Wed, Oct 23, 2024 at 11:57:12PM -0700, Shakeel Butt wrote:
> > > > The memcg v1's charge move feature has been deprecated. There is no=
 need
> > > > to have any locking or protection against the moving charge. Let's
> > > > proceed to remove all the locking code related to charge moving.
> > > >
> > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >
> > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > Thanks Roman for the review. Based on Michal's question, I am planning
> > to keep the RCU locking in the next version of this patch and folowup
> > with clear understanding where we really need RCU and where we don't.
>
> I think it would be safer and easier to review if we drop each RCU
> separately or in smaller batches.

FWIW if we go with this route, I agree with Roman's idea about
replacing folio_memcg_lock()/unlock()
with an explicit rcu_read_lock()/rcu_read_unlock(), and then having
separate patches/series that remove the RCU annotations. If done in a
separate series, we should comment the explicit RCU calls
appropriately to reflect the fact that they should mostly be removed
(or at least re-evaluated).


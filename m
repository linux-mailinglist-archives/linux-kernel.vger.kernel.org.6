Return-Path: <linux-kernel+bounces-299761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E539F95D9C5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BAC286029
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91451CC142;
	Fri, 23 Aug 2024 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvteV+ib"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A21CB14E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456400; cv=none; b=sM2G6m3avcrko7Ld1o6DzEvMngG9koA1DcK3Mv5hOyBhpGqW0mgBRe7eXZ6RJQmEaRvtNg4kW4rTNpKGI5evLhM8IU6iiPhtRCUGqk93cPxEM51t0mxvU2tDw38w7eMS7mKt/yiicziWvp1tbB64swTiPf/LaNEAYsFo8CLOpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456400; c=relaxed/simple;
	bh=k/0uDT+MZl5NLA6HoCCwMzmbAbGFd8xGGeSQPmZdO84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6xHwMr7vCHE6ILRnngPp0M42xGPPq3TuXazo12EwVXt7dzaP5wWhZEmVBmP8m9vJKeO1aCP+8IK84q7Bhkg8VDB7JVl+ueo26RxeWOgjGgA4D7wIROZ3baSd8K1rXTdBJ63nJbxWEJFrcnPDk+9EU8c3kcdLRNW0Ek761C6vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvteV+ib; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45029af1408so57501cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724456397; x=1725061197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNJQW5kWoiyWIS1wEft5yKL6Uj+ZwBIolJSEzZeq2Uc=;
        b=wvteV+ib65JVSvVjjd+a4IJvh0U3ceBwV+ptO80WaiqIGaIt1EVVzPeLpd1f6TIu4B
         +ZISif/UkQLrGMvqSRjSUCrhodB5Nyj5W9+5I6ty8C3XE07YHNpcxlXWmyBj2qMHmph6
         iqLRdLADpxqAylq1avz97O0tiJ0GQ6z7L1Xy7X5a7eatxCfzIfiERNYbokdv5WJLC7HK
         8wLU5ySoVu6FdMsUx9osRYx09MnthzJIFn+upax6wf0OR2VWtGL+2ct0jz95JRFC3baa
         haTlb4DlrLnSSxE5u/Fc1H6IkdYNIM+haGnPsW/d6rTaT8k6C5vsYIrJE96MZPSGuwDB
         7zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724456397; x=1725061197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNJQW5kWoiyWIS1wEft5yKL6Uj+ZwBIolJSEzZeq2Uc=;
        b=cUtGDFSDWHfZ+sXZa6Fik4UxNpkTEsgEOOu3dbh06nDXYOr9r1uYrozd2bvWqlODO2
         ELY/XcD8NmfATx0LG84/YzwCNMpDYX3WJXZk9fV+E5AgEE/cUzXnxQ3NwqpsQr0iwXF0
         xKZ6kwLKaHeur4MHQb1FeY1jrSo+amlAZRedeTZuhLjbuzBQE9+3wXTiZA06wygo7Awk
         tOxi+TM8A22nW3ve/4DzP18iiZJ/9K25NRVcTUNUyH51ABTr9Ps0n8r9KRAHFRDBKMko
         De94FXkwqVwCdNONVQ+rR8iOsHEJAphy8tCIWI6CaYlTSFOPbx+dScmyBfjWqEJJ4iVo
         nDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfE0oRWjQwSWAsGbdFeIy3/7gIycr8J+c0cLc/m9wX2IVWogB3BwMAGNuGtrkYvHaWhUzTOMjulGvHQHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFifYeCaEvejyxONSVKoqzTIWHZmiZY3oHohIwegRi6qK3s2yn
	1KgeRn4I3U+VVt+e/YtTeEAI4r/tAHZu16K6TaDJ9YE/AZ2Pg5A0JVccTGyK/9Ya3HEDF+L/h6w
	kiuVHNTwGPvGDs8z4ODX7wU0svq8htYP4Ew4n
X-Google-Smtp-Source: AGHT+IH1hc8yYuEp7WVu5DgIPV+CZe8iSGviZ+TgZTzQmeBssZ8vt+JQIleeid6x86dKtzRWBWqsrOQrdpWs0XSsvzk=
X-Received: by 2002:ac8:5f07:0:b0:447:d97f:9765 with SMTP id
 d75a77b69052e-45642044d31mr1174401cf.16.1724456397170; Fri, 23 Aug 2024
 16:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Aug 2024 16:39:44 -0700
Message-ID: <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: Barry Song <21cnbao@gmail.com>, Lokesh Gidra <lokeshgidra@google.com>
Cc: Michal Hocko <mhocko@suse.com>, gaoxu <gaoxu2@honor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>, 
	yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:47=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Aug 21, 2024 at 8:46=E2=80=AFPM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Fri 16-08-24 07:48:01, gaoxu wrote:
> > > Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazyfr=
ee_fn:
> > > 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If it'=
s
> > >    moved to the LRU tail, it allows for faster release lazy-free foli=
o and
> > >    reduces the impact on file refault.
> >
> > This has been discussed when MADV_FREE was introduced. The question was
> > whether this memory has a lower priority than other inactive memory tha=
t
> > has been marked that way longer ago. Also consider several MADV_FREE
> > users should they be LIFO from the reclaim POV?
>
> The priority of this memory compared to other inactive memory that has be=
en
> marked for a longer time likely depends on the user's expectations - How =
soon
> do users expect MADV_FREE to be reclaimed compared with old file folios.
>
> art guys moved to MADV_FREE from MADV_DONTNEED without any
> useful performance data and reason in the changelog:
> https://android-review.googlesource.com/c/platform/art/+/2633132
>
> Since art is the Android Java heap, it can be quite large. This increases=
 the
> likelihood of packing the file LRU and reduces the chances of reclaiming
> anonymous memory, which could result in more file re-faults while helping
> anonymous folio persist longer in memory.
>
> I am really curious why art guys have moved to MADV_FREE if we have
> an approach to reach them.

Adding Lokesh.
Lokesh, could you please comment on the reasoning behind the above
mentioned change?

>
> >
> > --
> > Michal Hocko
> > SUSE Labs
> >
>
> Thanks
> Barry


Return-Path: <linux-kernel+bounces-249393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F892EB11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D28284B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBEE16A382;
	Thu, 11 Jul 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRbd7uAY"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26E12C549
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709720; cv=none; b=SBWFcgRAm7QqRUlPz98jpnsll/Q2M9g4aE7GepFJrDmUsjVGdbq1hG9OG+CEAPJvp6aTbkaKBqCz9uTnb0v8XKZpwrID6c7Q1W3Xs0v/AEF+pK44lMMK0Zvprn30/g7YkaHq9qYx7S482zU+wM0vte+1p8OZCOqoyCo4xIT3fjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709720; c=relaxed/simple;
	bh=z9uROl4HbHhQfuzBg0QIhgc5JJTYcWlU4daXCmPoMzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubIwZju1WLLYKzC+7seBOHjfHG9cM7AJpcBWPFPG4y+Hfno/Vl3jEr0+1jW0kmyEUlnPonrJ6P1VGwKQgb2MU5KdFyHpVK0FCDjB211j5pdk88thnUwPI7k6xXQCTrR8Jev5tFPq3BFxRdTOXK8E+BqI4tkbm9zzznontVDzpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRbd7uAY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b417e1511so9614947b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720709718; x=1721314518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4UBc7cQrKGMEZ5EX9PJdheM7gdFy4rwh8ao143uo3I=;
        b=vRbd7uAYivEDv/smbT7gxqBgnCDsq/5tWmHKGsNYfA3lNPnrQrf2jQU/ZgMwLlXQNC
         PngRPmpMBdaMFdq/DT0AmkMoq7vBD6wxZDQ/SRmVoDKkFwz1P5iXiw8IUXTbldz+KZKF
         z6NOPBMQR6Z3Zg1tiQ5UHWCha2Ypw2uvgpDJLNAT6111Nxyau6mXnmnEAyYhZkEbKjav
         28w2QBrtp9iVW2UO2v0L1sIucjAKDoevyx5iP6UN4cKdhN5xJgSWhdde4/ERmQB0bFVO
         KuyJspZfGNiMX0HqDmRAAJifxQZgWiAuk/SJxqPauYR8kr4FUoiDLgQnEKziRb6+Mnnx
         QLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720709718; x=1721314518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4UBc7cQrKGMEZ5EX9PJdheM7gdFy4rwh8ao143uo3I=;
        b=MFynT53BK/AMDHZFErmzpWj9IIUdPPmr1QKBuDU6cHK34ETt/IJxxHf/iZLJpnKMNy
         hmfHJsvX5Wq+2fcfsvlw8jZQGsX5qWEoMrI17lvo2G9CRubT90lipryQG9awoPnxd6vg
         zY/+lpQ5EiCErwrxnAOM/6O1Ci6licJbAV6sWxlT3YfqsezdFs30RcQQ+SZ5K6BxyEgo
         UyoJREPERDbLDa8T3HkTFt9vk5F3uR0leG/MHzyiXTSy4WHYrwefxWy0xyW2KXPat9xG
         kHwlsdGMKHR4QyQEH7xOFYbLoV0pg8hKXONF8nFTG9SN1mZ+EMS3MrHaKxuBA8/nIZby
         ZJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWcdkvhU5PBOH0Crw+w/Go7aVOsiSwdBP1dbOWwtUau+nevDjSP/H9OvS+cgrqwdRUOgBu8Fb+yd2XJOWPS0s/V13tWh7K+cudU/sBM
X-Gm-Message-State: AOJu0YzSIEI62zxg0yzq2Jb8AE8t3JkSaoy5GM6+HttwPnbBnx8Ahpwg
	vWxpw03liDiSVW5CPvE470p7JRI1RQW53Sszbdtd7O/LWBtLFPCkxvtagClFde4w1OkHgc2trze
	g7cOERiYCFjYGTkutkAx/BCrKPg2DulHthWFS
X-Google-Smtp-Source: AGHT+IHOZ97p6Fxs/TNwZed9HbaLGEz1VBSjOeoNgLDM9j7jU98gIWaZoq4aET1Gv+kkFrFw7jxV99m3/gBZHoGvSUM=
X-Received: by 2002:a25:d38e:0:b0:e02:4d55:1e6f with SMTP id
 3f1490d57ef6-e041b05c9c5mr9971274276.21.1720709717399; Thu, 11 Jul 2024
 07:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710054336.190410-1-alexs@kernel.org> <42afbce8-7746-438f-ba3a-c997a2c702e5@suse.cz>
 <a0990d1f-ef25-4eae-98e5-6e65c8643313@gmail.com>
In-Reply-To: <a0990d1f-ef25-4eae-98e5-6e65c8643313@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 07:55:04 -0700
Message-ID: <CAJuCfpEwY=_+=YTHfS7TUib6XtVSWzf1PLZiPK_5MQyOK0m5+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/memcg: alignment memcg_data define condition
To: Alex Shi <seakeel@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, alexs@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Randy Dunlap <rdunlap@infradead.org>, Yoann Congal <yoann.congal@smile.fr>, 
	Masahiro Yamada <masahiroy@kernel.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:51=E2=80=AFAM Alex Shi <seakeel@gmail.com> wrote:
>
>
>
> On 7/11/24 4:13 PM, Vlastimil Babka wrote:
> > On 7/10/24 7:43 AM, alexs@kernel.org wrote:
> >> From: "Alex Shi (Tencent)" <alexs@kernel.org>
> >>
> >> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
> >> extensions") changed the folio/page->memcg_data define condition from
> >> MEMCG to SLAB_OBJ_EXT. And selected SLAB_OBJ_EXT for MEMCG, just for
> >> SLAB_MATCH(memcg_data, obj_exts), even no other relationship between t=
hem.
> >>
> >> Above action make memcg_data exposed and include SLAB_OBJ_EXT for
> >> !MEMCG. That's incorrect in logcial and pay on code size.
> >>
> >> As Vlastimil Babka suggested, let's add _unused_slab_obj_ext for
> >> SLAB_MATCH for slab.obj_exts while !MEMCG. That could resolve the matc=
h
> >> issue, clean up the feature logical. And decouple the SLAB_OBJ_EXT fro=
m
> >> MEMCG in next patch.
> >>
> >> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
> >> Cc: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Yoann Congal <yoann.congal@smile.fr>
> >> Cc: Masahiro Yamada <masahiroy@kernel.org>
> >> Cc: Petr Mladek <pmladek@suse.com>
> >> Cc: Suren Baghdasaryan <surenb@google.com>
> >> Cc: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >> v1->v3: take Vlastimil's suggestion and move SLAB_OBJ_EXT/MEMCG decoup=
le
> >> to 2nd patch.
> >> ---
> >>  include/linux/mm_types.h | 8 ++++++--
> >>  mm/slab.h                | 4 ++++
> >>  2 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >> index ef09c4eef6d3..4ac3abc673d3 100644
> >> --- a/include/linux/mm_types.h
> >> +++ b/include/linux/mm_types.h
> >> @@ -180,8 +180,10 @@ struct page {
> >>      /* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
> >>      atomic_t _refcount;
> >>
> >> -#ifdef CONFIG_SLAB_OBJ_EXT
> >> +#ifdef CONFIG_MEMCG
> >>      unsigned long memcg_data;
> >> +#elif defined(CONFIG_SLAB_OBJ_EXT)
> >> +    unsigned long _unused_slab_obj_ext;
> >>  #endif
> >>
> >>      /*
> >> @@ -343,8 +345,10 @@ struct folio {
> >>                      };
> >>                      atomic_t _mapcount;
> >>                      atomic_t _refcount;
> >> -#ifdef CONFIG_SLAB_OBJ_EXT
> >> +#ifdef CONFIG_MEMCG
> >>                      unsigned long memcg_data;
> >> +#elif defined(CONFIG_SLAB_OBJ_EXT)
> >> +                    unsigned long _unused_slab_obj_ext;
> >>  #endif
> >>  #if defined(WANT_PAGE_VIRTUAL)
> >>                      void *virtual;
> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index 3586e6183224..8ffdd4f315f8 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -98,7 +98,11 @@ SLAB_MATCH(flags, __page_flags);
> >>  SLAB_MATCH(compound_head, slab_cache);      /* Ensure bit 0 is clear =
*/
> >>  SLAB_MATCH(_refcount, __page_refcount);
> >>  #ifdef CONFIG_SLAB_OBJ_EXT
> >> +#ifdef CONFIG_MEMCG
> >>  SLAB_MATCH(memcg_data, obj_exts);
> >> +#else
> >> +SLAB_MATCH(_unused_slab_obj_ext, obj_exts);
> >> +#endif
> >>  #endif
> >
> > Why not also #ifdef / #elif like above, instead of this nesting?
>
> Uh, it works too if MEMCG/SLAB_OBJ_EXT decoupled.
> but right, it could be written with #ifdef/#elif.

Yes, please keep the same condition, otherwise it gets confusing.

>
> Thanks
> Alex
> >
> >>  #undef SLAB_MATCH
> >>  static_assert(sizeof(struct slab) <=3D sizeof(struct page));
> >


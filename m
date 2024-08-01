Return-Path: <linux-kernel+bounces-270615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C894421F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E8B284201
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4719313D602;
	Thu,  1 Aug 2024 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IVWHEyG"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5415EC2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484888; cv=none; b=DJJB/FUcB9xldtZoOku3DS3DEXlnTB/5MiGyRCDov3x6Fg6Xb+Ms0+rUD1WoRnKHYq8lU+gWgK/s+D1uQ0FVnk5nlM99CqYc4IUdT5S5bDhR5TFS2+CQW67Sq8bxIQQaFU8AoIWewN8p20KmJrO3AEJDzhxRV4rGMRBUk744KMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484888; c=relaxed/simple;
	bh=F5nJtKJrLxUxIGvK1xcaaMf6f/RRrSbUA+M9Om6vegQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNFgJ/jNGov69clipZotqOotbe8OY677gQgZDCaZVgWDW71lvwseRGIastbhYINjgarvfIwBeaNVtR0U6lbR90BBrQhPM/lYFS69CXxNhoU0bFBh7CJbjXXNFBFhAjlEFehFre1TtJXp/23kAITfsOvyrOUZmCy0DslWyxx/mh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IVWHEyG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so27794a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722484885; x=1723089685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT9JA8dx+64cxrNGE7PfVbIZYCFMvXqZQ2Ueee7W7a4=;
        b=1IVWHEyGuMpPeJB8en+2aAXbmMRUO9xsYaweRkQ9moG7/NBog8oVBTAI47iAGQi8Rl
         0PU8D/eeR/Xm5VwtJDgF+o7fh+r/h8uOnT61iN+eJKVMaEPVT+c1gIHt46nOXsZAIIVJ
         3bnUJTcCqc9dulZUyiu+gansAERqJCCjettV7XAAV4ArsLdVMo3MC6a3MZoWOXoACrgD
         8pINB/fkcKvJhTB9lWPh7ycAohrMJgifIztYC395l5+YTphZLJ8FWMtlRak9VBVFGoeN
         +K0mKi13MGBfy86XGziAPl2mN4j1bwZhopMg3X8fQF1i8M4ujWp6vbZJFsGaMxo6JCwS
         lmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722484885; x=1723089685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT9JA8dx+64cxrNGE7PfVbIZYCFMvXqZQ2Ueee7W7a4=;
        b=fPGxx6FRrSsK4IT0SZ1IxNLO2vJ4LYeGehqwfZ0ErG6IF82ByicbIExJqSeTIt52Bv
         ZkbOlT58it/ilLTNFeYMj80UAEvMfv1mWNaT5eodny6cvqslLpuyhkUhZEkPt4V3sDDM
         ccbtfSNR9ckyvQZuTFnhyYwi0CfCYr2O66Lvff0B9yt1GghXigxrhR5xuH4DzNpU4p8w
         0XNz4A0icukqAr7sH9KGMUyC2x2/NNt7/a+3nYV56LkmVBXUTOdkg2+d6YFgMNWP2lcG
         qnl3jaJoWG1Z5R14+wRkclwlLOZTrPk+Te2Ho5VHfOMJkUJ6ZNhVJssYMCb6QL8Vdbny
         v1hw==
X-Forwarded-Encrypted: i=1; AJvYcCUPocCHbUH34EefyNoZpPYNckhN8Pf4JYz6lOCC+EXiFTzXXf7/zAlslrCFuMYCr5bdWvyPCh29M2xPkatqUMkRFIfHV/5E7lGFicTU
X-Gm-Message-State: AOJu0Yw+FC8qlQ0QYkd5pWAArN/xBsCTGCNEveFFsYbJuwvI621fBPvt
	z3GT27NTwxT1VZVsF7MMJqYSlqasXi554dAhamU03moVWAKjagZ8uxwEl2kG9KDVUa10PFek+hQ
	FkvWGCko3tgk1GgIVsn8EH09YRtSfs+FS7WqX
X-Google-Smtp-Source: AGHT+IHTwjSg9+MIXLuiJLBz0eSMeFs2h8fWwePQsUN7qDGET4IqBmqp79U1QYzfUCOS1JwtDSqCkax9U8EJWq1jF8o=
X-Received: by 2002:a05:6402:4301:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5b740990c57mr35420a12.5.1722484884423; Wed, 31 Jul 2024
 21:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-1-48d3cbdfccc5@google.com> <CA+fCnZfURBYNM+o6omuTJyCtL4GpeudpErEd26qde296ciVYuQ@mail.gmail.com>
In-Reply-To: <CA+fCnZfURBYNM+o6omuTJyCtL4GpeudpErEd26qde296ciVYuQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 1 Aug 2024 06:00:48 +0200
Message-ID: <CAG48ez12CMh2wM90EjF45+qvtRB41eq0Nms9ykRuf5-n7iBevg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(I'll address the other feedback later)

On Thu, Aug 1, 2024 at 2:23=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.c=
om> wrote:
>
> On Tue, Jul 30, 2024 at 1:06=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Currently, when KASAN is combined with init-on-free behavior, the
> > initialization happens before KASAN's "invalid free" checks.
> >
> > More importantly, a subsequent commit will want to RCU-delay the actual
> > SLUB freeing of an object, and we'd like KASAN to still validate
> > synchronously that freeing the object is permitted. (Otherwise this
> > change will make the existing testcase kmem_cache_invalid_free fail.)
> >
> > So add a new KASAN hook that allows KASAN to pre-validate a
> > kmem_cache_free() operation before SLUB actually starts modifying the
> > object or its metadata.
[...]
> > @@ -503,15 +509,22 @@ bool __kasan_mempool_poison_object(void *ptr, uns=
igned long ip)
> >                 kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, f=
alse);
> >                 return true;
> >         }
> >
> >         if (is_kfence_address(ptr))
> >                 return false;
> > +       if (!kasan_arch_is_ready())
> > +               return true;
>
> Hm, I think we had a bug here: the function should return true in both
> cases. This seems reasonable: if KASAN is not checking the object, the
> caller can do whatever they want with it.

But if the object is a kfence allocation, we maybe do want the caller
to free it quickly so that kfence can catch potential UAF access? So
"return false" in that case seems appropriate. Or maybe we don't
because that makes the probability of catching an OOB access much
lower if the mempool is going to always return non-kfence allocations
as long as the pool isn't empty? Also I guess whether kfence vetoes
reuse of kfence objects probably shouldn't depend on whether the
kernel is built with KASAN... so I guess it would be more consistent
to either put "return true" there or change the !KASAN stub of this to
check for kfence objects or something like that? Honestly I think the
latter would be most appropriate, though then maybe the hook shouldn't
have "kasan" in its name...

Either way, I agree that the current situation wrt mempools and kfence
is inconsistent, but I think I should probably leave that as-is in my
series for now, and the kfence mempool issue can be addressed
separately afterwards? I also would like to avoid changing kfence
behavior as part of this patch.

If you want, I can add a comment above the "if (is_kfence_address())"
that notes the inconsistency?


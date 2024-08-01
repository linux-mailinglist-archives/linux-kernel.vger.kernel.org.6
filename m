Return-Path: <linux-kernel+bounces-271264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6F944BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A6428405B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6E172BD5;
	Thu,  1 Aug 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVr1kRtK"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3B208D1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516858; cv=none; b=gooEcR7vJz4I55axM3x8F0ZV97rK2nVhtMbII7gdV9HfGnU44Ld++2kYJDR0+6KbE6hQUJOZqbSgWbagKeKeb9nKcep7WZQs1byLXH/fYuU+O4Z9Xw0a/SxadNYfuc/yqAti85+RYykcu1Eetm/ZzaMXXE1492nODAL7xs/NODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516858; c=relaxed/simple;
	bh=c3quo7FXD5Iq+Svv3f2Qp7ZuzsNepiBBsBlXQyvyaVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXaUgfEVqVDsbRyBhXRihYpIihZAgwVFiiOME5lYfb9kuwRexx0S2KvkU86Xrb5uPtU8dlmFPsEVnR3FxHkMvVDB4RtLeHD7qTZT5gNQruZlux7EygUXc1gvbaBCAgUyZ6V1jGFy92wKKysb0CJsZc8jbuhT9nfNp2Xj4qO0eGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVr1kRtK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36868fcb919so3454238f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722516856; x=1723121656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJM7ZW7Cx4ewZwlyf9TpDzuVdkBNUpK6wYJDwO0sS4w=;
        b=hVr1kRtKvH8C8ydAgmWVab8aVgdYgZDdZ+yLe5iisIDC0mZ+3MYhpfColOgNGV+WRa
         NfWWhBcTjd0IuAxCgYMapZ9aJgSDjlH5b9dlEF/9OVd6xLG/wY4f+ouOt3DcrMR8F4TQ
         ELCYcy4/u7zMQqnyGhAzDz/539fNms5e7NO8ePeIbUXOQX95Ysyx8VlNekg6WyqbZQ7v
         nQLldUHUpTwmizdyFotY0K/KTh4KpnfqfMinbQPc3zYJMciVZ5SLYy3ROgi0M4YtFfGC
         wiejT5l8RSrwI179UHJZzmGXUieceQpnpx8nuReSHAuQJ5CD3Qi1HKgA3cGJcqYdQhaW
         hYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722516856; x=1723121656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJM7ZW7Cx4ewZwlyf9TpDzuVdkBNUpK6wYJDwO0sS4w=;
        b=AchzXHW27ntoyyeRbj3GPg4uapYIH3MtNJ/5iF718Th7uPCUpA6mEz/u9rg2ptH+gR
         azkQnQHsQavs+Hy8NHsPLFapF68qDdPRwGDGSkctP0m9YCgry5GdcRuc3cKH2Lk2o2jZ
         upaoCDr/FYohimIcyKn5NUgjhiluRasFZNVi2L2ls5W8eNKizd2O6kNyGhW23C839WUX
         tyLcwB/yXnHZ8FCKhp6cmVZAmOdYnwYWAEmQS3MR28858VSi/NSHbJVkBwPaAFVjznim
         3Et201okY+HDqqgtwxrxdlz4+ACKHbf6iQfeZd6brE/xiB4CpEybzpncD/I8JyCwDrKJ
         Nntw==
X-Forwarded-Encrypted: i=1; AJvYcCW29VLZj44a+NggU5H6jubsPAMWkj65w9O6YJ8VDh4MR/3UbUUDOCcQ2VYN+P4sERXcap28EegtAcPOQ6YALwyykJvOeDHSIdAGJU1K
X-Gm-Message-State: AOJu0YwGZypAJniIu2zNXFBzBO4i56J0awZayz2o+wmCFvkbRhhg/evf
	LCLcOxAxwig+DrVqJn0khG4vGUvtmSuOJK9CTp2As1LD1hzlBCIiQBzOVQy/12XI5Url+ytaHoV
	aZ69PgahZ8C+9LGu7vNl396GjYvs=
X-Google-Smtp-Source: AGHT+IEn73WxbN6uH+EfdL648nkpBQ6mZ8M7TiPsUS0OMVpuMAMF7/HRxcKTxJ+JMMtr0tPw0IRNmeYPvvqi5MnJTs4=
X-Received: by 2002:a5d:62c5:0:b0:368:3b21:6643 with SMTP id
 ffacd0b85a97d-36baaf237a1mr1484941f8f.48.1722516855454; Thu, 01 Aug 2024
 05:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-1-48d3cbdfccc5@google.com> <CA+fCnZfURBYNM+o6omuTJyCtL4GpeudpErEd26qde296ciVYuQ@mail.gmail.com>
 <CAG48ez12CMh2wM90EjF45+qvtRB41eq0Nms9ykRuf5-n7iBevg@mail.gmail.com>
In-Reply-To: <CAG48ez12CMh2wM90EjF45+qvtRB41eq0Nms9ykRuf5-n7iBevg@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 1 Aug 2024 14:54:04 +0200
Message-ID: <CA+fCnZf++VKo-VKYTJsuiYeP9LJoxHdd3nk1DL+tZP1TOQ9xrw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Jann Horn <jannh@google.com>
Cc: Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:01=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> > > @@ -503,15 +509,22 @@ bool __kasan_mempool_poison_object(void *ptr, u=
nsigned long ip)
> > >                 kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE,=
 false);
> > >                 return true;
> > >         }
> > >
> > >         if (is_kfence_address(ptr))
> > >                 return false;
> > > +       if (!kasan_arch_is_ready())
> > > +               return true;
> >
> > Hm, I think we had a bug here: the function should return true in both
> > cases. This seems reasonable: if KASAN is not checking the object, the
> > caller can do whatever they want with it.
>
> But if the object is a kfence allocation, we maybe do want the caller
> to free it quickly so that kfence can catch potential UAF access? So
> "return false" in that case seems appropriate.

Return false would mean: allocation is buggy, do not use it and do not
free it (note that the return value meaning here is inverse compared
to the newly added check_slab_allocation()). And this doesn't seem
like something we want for KFENCE-managed objects. But regardless of
the return value here, the callers tend not to free these allocations
to the slab allocator, that's the point of mempools. So KFENCE won't
catch a UAF either way.

> Or maybe we don't
> because that makes the probability of catching an OOB access much
> lower if the mempool is going to always return non-kfence allocations
> as long as the pool isn't empty? Also I guess whether kfence vetoes
> reuse of kfence objects probably shouldn't depend on whether the
> kernel is built with KASAN... so I guess it would be more consistent
> to either put "return true" there or change the !KASAN stub of this to
> check for kfence objects or something like that? Honestly I think the
> latter would be most appropriate, though then maybe the hook shouldn't
> have "kasan" in its name...

Yeah, we could add some custom handling of mempool to KFENCE as well.
But that would be a separate effort.

> Either way, I agree that the current situation wrt mempools and kfence
> is inconsistent, but I think I should probably leave that as-is in my
> series for now, and the kfence mempool issue can be addressed
> separately afterwards? I also would like to avoid changing kfence
> behavior as part of this patch.

Sure, sounds good to me.

> If you want, I can add a comment above the "if (is_kfence_address())"
> that notes the inconsistency?

Up to you, I'll likely add a note to the bug tracker to fix this once
the patch lands anyway.

Thanks!


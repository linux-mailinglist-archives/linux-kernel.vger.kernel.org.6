Return-Path: <linux-kernel+bounces-408484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B604D9C7F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18FE2B226BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FEFB65C;
	Thu, 14 Nov 2024 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M27iUxl3"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13917C2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731544133; cv=none; b=dfF84T5MV8IFhIutwsNqPUlMOqE8yrkhBYIob9oAygaZqy7VyCRdKT4mHAtP/sToTbRlA57Lw7FuwG4c47qwDCPwhtUH1Ov0XQTiMPDh8GrHr6sKsY+cGpeT7VqpOHcbc7afS+708GXDqdun+6zM0M+0wP0Bp/dNBBeokbPXb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731544133; c=relaxed/simple;
	bh=4gwLaPx88IF3gPJUAXIfv+CnYnxLMSntRUnv37OXG7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbYXj0g7MCrUJnbY/YYp66qGKNoxU2/S+Ld18SDCn1P7vsCeO+VMMpqPW+EnZG+Yts5667fksteg6a+Feb2bvR/bl2nzKcME9jFRatDQev8OoVhZZi/o7rxf5FCHud4SCQ2hdC4/J168y9f5cuIffA9fPdShdISWn1R+5puEEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M27iUxl3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbcd49b833so23906d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731544131; x=1732148931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hr7YIzXk3s2XvS5AA4igZXJDd9w/u82R8OHVyJVy8Eg=;
        b=M27iUxl3rPCWkpqiI1K/67w+aApvflVvpJvH8GB8GOhXt2SZ/u1WvjYGJQpLanpqWS
         uhTvEn/kedahNeIuTYt7EPz9SjECns5gumFWVNDmZBvkzj9FU9x8ee1Hma9MTUYT8gBi
         16AZ1bmC4KowhwFLvY09YHA5+XeQHAU2omqewppvDROgWLy4+FV15kPiq9/bpVK3W5d5
         0z14CBuveW4JsghaEZilJl7Bnj549FLopl/NWWC4wZZ0P1DNHUgf/S3eyyQz8nc9yybj
         B6LLh2JsDFmoBD+BNAk1RNuvRfus1Ir3RI96FeejY5aCDHwxgyjDbcg6hoK857sFGA7n
         COVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731544131; x=1732148931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hr7YIzXk3s2XvS5AA4igZXJDd9w/u82R8OHVyJVy8Eg=;
        b=w1EoY81rcdOhb665ts7vQfMVGdxvuYVgflUsiXkVX36udwG90RuEcc+kxQafKHeDzb
         xkWtn5NMf6L9NI4wtG3RpTmiCl2Jj7lQzF8FpCIudnUnwfkz3TOyBEpg3QG01FYx6Fl4
         /2+/M8pFY97OQZjVhA3Vh4mdK00fVw99mZa2N7/Nctzmh0FXGP8jNe3DdQmrNzxx0Mtv
         mWYZreKDIOGWRdGo4rQtAsiWQHP1iaHU+6JB3Xlel0sFnEu5JMYNv3MGiZNf/S9gV38D
         LI8XSD1Di6TES/vWSFqrwMkmerauMYRntWAsrMzPyB+R91bxq1JYn6HQF7H4mAXcer+4
         KFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRimz58eXdy2UbaDg5VhAUNzg3ttOHOAr2DE1AxDU7TbdHFI9c/g7DqOigpjgPfp572/AfFu7jEcqxvH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA7VekA4YAHY9VPtG+SYd37PgC+ns5t6i523PVctV7Q3jx/n7a
	LYdsjqEqR58FWoAyuksSJ2vwgzWYRY55edBbwTCngW2tRaUvZg2Rl0z6pEnVy6sH00PjYzfVCSB
	YU+TKLe/hHUE0ffvc061NQ/IG9Gk=
X-Google-Smtp-Source: AGHT+IH37AfNakmSO904tMCOtS7/4FIplAgusUqyqlD0sbo5ehHehnPBigMlVtnNJ7SbzKJhydXCtoIhLEUsKY97LiI=
X-Received: by 2002:a05:6214:5c09:b0:6d3:a772:fe64 with SMTP id
 6a1803df08f44-6d3edb3bbf8mr1265396d6.0.1731544131174; Wed, 13 Nov 2024
 16:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org> <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 13 Nov 2024 16:28:40 -0800
Message-ID: <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in zswap_decompress().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:13=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
>
> Thanks Johannes, for these insights. I was thinking of the following
> in zswap_decompress() as creating a non-preemptible context because
> of the call to raw_cpu_ptr() at the start; with this context extending
> until the mutex_unlock():
>
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>         mutex_lock(&acomp_ctx->mutex);
>
>         [...]
>
>         mutex_unlock(&acomp_ctx->mutex);
>
>         if (src !=3D acomp_ctx->buffer)
>                 zpool_unmap_handle(zpool, entry->handle);
>
> Based on this understanding, I was a bit worried about the
> "acomp_ctx->buffer" in the conditional that gates the
> zpool_unmap_handle() not being the same acomp_ctx as the one
> at the beginning. I may have been confusing myself, since the acomp_ctx
> is not re-evaluated before the conditional, just reused from the
> start. My apologies to you and Yosry!
>
> >
> > That being said, I do think there is a UAF bug in CPU hotplugging.
> >
> > There is an acomp_ctx for each cpu, but note that this is best effort
> > parallelism, not a guarantee that we always have the context of the
> > local CPU. Look closely: we pick the "local" CPU with preemption
> > enabled, then contend for the mutex. This may well put us to sleep and
> > get us migrated, so we could be using the context of a CPU we are no
> > longer running on. This is fine because we hold the mutex - if that
> > other CPU tries to use the acomp_ctx, it'll wait for us.
> >
> > However, if we get migrated and vacate the CPU whose context we have
> > locked, the CPU might get offlined and zswap_cpu_comp_dead() can free
> > the context underneath us. I think we need to refcount the acomp_ctx.
>
> I see. Wouldn't it then seem to make the code more fail-safe to not allow
> the migration to happen until after the check for (src !=3D acomp_ctx->bu=
ffer), by
> moving the mutex_unlock() after this check? Or, use a boolean to determin=
e
> if the unmap_handle needs to be done as Yosry suggested?

Hmm does it make it safe? It is mutex_lock() that puts the task to
sleep, after which it can get migrated to a different CPU. Moving
mutex_unlock() to below or not doesn't really matter, no? Or am I
missing something here...

I think Johannes' proposal is the safest :)


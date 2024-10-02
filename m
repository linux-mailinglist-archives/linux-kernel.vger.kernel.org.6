Return-Path: <linux-kernel+bounces-346923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C598CB14
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A71C21A93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF09610C;
	Wed,  2 Oct 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dor1qI3z"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA02F2D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835150; cv=none; b=UvkPrcK19DDX5e7iXTzt+UwHqSyUui9qh0eUcfMJ2Vtg8enBmetFrLt5W+6rUZp9X5+EBGyqni/ESyrrUutEQz3EJJAPh8B0H2yJ1oUHp+KEZEmuq5FszEkNPAExP/D+csh5megqcfcEcdDzpjMjbA96xQ1jPLfVR5ktGEd1gK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835150; c=relaxed/simple;
	bh=5KnrKT/pIUWaSY2VzXJWUFp4G+T+0ZolLmh/deorjvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwYznN4RfkijDUxtwT96lSQMODeZkxxT+6HsMHjbAqTlEJC4WPwjyNKrjFrqn1J8k9DtxLQsZFyk711/Icp5Pp4x0Pg5H8VPj1ZY5Sw5Xo9nwlCTe/bqiMH8Bj6TnAEyELRk+/X3twzOSkYjD38qnTH+7Z1JxGb3jyp1TNY9bQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dor1qI3z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so840912666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727835147; x=1728439947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxEWRVvFrULwMAj6UTaxya7cjYZhyVIIEE0tCZOweP8=;
        b=Dor1qI3zTDL1icB/puoAWc29j8Fc+pcbmoTXePQ4zjAFyQq2IesV6tKNTTkf/yJUz6
         Dlxmr63SEgaix22woURHRLMrBSn6TYdAup/jgYUEGvQfqUK8TAJ6pmkc9P3z8eeRkJRI
         jLGH+J0XQ5zKGmdUxb4O7/5fQW/55Jod8Rqi8sukVH3pL/lXjdz5lR5dh3dmOqQww43N
         yoNT0xHibYbmyMY6hgRkWjTlPNGd5RQvZVfhBHoIl2IfbgPc0F/83QZh/wSKlG3qP7nV
         Y1e9afQJRxxHnknGXcgpyjwq3VG0D54/j3BR0KbuDV/zpM+2ZMH0T9ymXnkHeOU8mOkh
         eDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727835147; x=1728439947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxEWRVvFrULwMAj6UTaxya7cjYZhyVIIEE0tCZOweP8=;
        b=lqP8G3NsV/zd+Ly/5bT0ZHhtDn3GKOV8YUtmm1pDmv2m+aXkeJ/Flb7iNIysSATr+c
         iODFUpES2p4gY+JiIQ8P+ADg0AaqU9BSIz20Nz5F4e5SZn6rVmQZ4glGBYHuYWGiewrN
         DGx273Q22TIypkC2FEsKyy9pdoaAB55L43iMnAIRug0RPr9e9Awn0lWPBMjflGw+u92U
         hwYsUkg75quddkl4mLVnXEcUCKRWiI76U5qzgkrV9zFJOhQextIk27tsFOGP/FLLFy7M
         N4LmIdYkQ+2iYEaR+udoIRr1GUP+91gvRCo/v/WYHdhjz3bIqSDjnt/8u05TYl3V46tG
         tRUA==
X-Forwarded-Encrypted: i=1; AJvYcCWRLTO1Izrraxk2vV0AQ+QEMawsF+9U23lUAVPMmdSc1NVWVK8HH3qTWNiVlqLCkBUVFGdShCh/TLB/k5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6V8MYzm37DI2JwY6dLNQO+7yAvB6tmsV029xc0JzZVGFv8Q1
	mNM4i9G9fvAoNkZPlbcADo8+60lwhyfp0nh/2q2HTJpsJvglscUapX2hzTHDnDIFEYKKmccN9Py
	0UuZdkBMdzPd5SbmmxVO+lMbjbjonJWv5Cc3E
X-Google-Smtp-Source: AGHT+IFsjLUmgLUJ5nRpXv8GIsHOqdutSo3+mSVUgw/bvf9N9UL1ZHu0lhbd1c0ywGqsPo07EIYFwRxC5isSYUgKMlo=
X-Received: by 2002:a17:907:6e8b:b0:a8a:85af:7ae8 with SMTP id
 a640c23a62f3a-a98f81f6465mr118867566b.11.1727835146711; Tue, 01 Oct 2024
 19:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
 <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com> <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com>
In-Reply-To: <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 1 Oct 2024 19:11:49 -0700
Message-ID: <CAJD7tkag34Hov1N_dui+KP+cPTtenRQkR2ZHBxxK73FXeoffow@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > > + *
> > > + * @entry: first swap entry from which we want to increase the refcount.
> > > + * @nr: Number of entries in range.
> > > + *
> > >   * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
> > >   * but could not be atomically allocated.  Returns 0, just as if it succeeded,
> > >   * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
> > >   * might occur if a page table entry has got corrupted.
> > > + *
> > > + * Note that we are currently not handling the case where nr > 1 and we need to
> > > + * add swap count continuation. This is OK, because no such user exists - shmem
> > > + * is the only user that can pass nr > 1, and it never re-duplicates any swap
> > > + * entry it owns.
> >
> > Do we need this comment when we have the WARN + comment in __swap_duplicate()?
>
> Here I'm just being cautious and include the limitation of the
> function in the API documentation itself.
>
> No strong opinions though.

Maybe it would be more useful to add a warning in the loop if nr > 1,
with a comment that explains that the current -ENOMEM handling does
not properly handle nr > 1?

> >
> > >   */
> > > -int swap_duplicate(swp_entry_t entry)
> > > +int swap_duplicate_nr(swp_entry_t entry, int nr)
> > >  {
> > >         int err = 0;
> > >
> > > -       while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
> > > +       while (!err && __swap_duplicate(entry, 1, nr) == -ENOMEM)
> > >                 err = add_swap_count_continuation(entry, GFP_ATOMIC);
> > >         return err;
> > >  }
> > > --
> > > 2.43.5


Return-Path: <linux-kernel+bounces-205208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA168FF974
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE63B1C23EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66DC136;
	Fri,  7 Jun 2024 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK1UsKwh"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA31363
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717722055; cv=none; b=FgoeXpQI3ICecaZ/aI8AbnaVPaCTjX9lGLclRyZbkkgk7GV6fH2I+lWLK50lcD2uCgjD4QWc5JyrggJriygVT4I3GsvMhGT+h58y9SYoDpasA5yv8AFKBaGfTqdNpmi3RBtQ5CicSFWIhkrMCTi/6XBqzN31pJKFC7OJmzU9RfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717722055; c=relaxed/simple;
	bh=un8+5QVIEPNxvShksi0p604Me/V+qf9NbkP6MZJTA/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/yD2EeV9wPgDO8MnjFuuN0RQJQa1QkjnU5ATOsMZgETEhrB73Ce1LB39jYUuVft7n4R/WzulE7SJh2huPMDj2Il3D3ffyaHD78npF7bq6cUTPSOMRsDCyqU+fDdgqABJXrbTl6ug2A5IhuLd7T+nHHNr+rTLk7N5HMj3iYxs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK1UsKwh; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa48f505a3so1690191276.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 18:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717722053; x=1718326853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5QsSMEWckygigFI83mnJYXXGDc+ola7OKupBLG+pCc=;
        b=jK1UsKwh9Z61d6bO4U5gjj1G0Q5oz9jFybC7AccPYKUzkMx16kI8nC71tL2n4yadua
         61hUa55X69m9YB5Z+1wiH1rROJMnELYdhbiEVK8daUsfM/PZy0u7MKLquP0j5c3cCFnI
         kuYNxzbwUZJf7XG4ZSbWT27RINGuAbg0COC9vsL3biwjw72yG6uATim+/cx47Ps9k+DI
         zdrZV7Ku2kVHYKRmrsL24DnrqIr5wJcrTUGH1JdvOXVVpgZvOc2eC1kdc1KM1j1axy/y
         AdiFPo2KtfaWqU1VfvC8wse6XYtYB7D+lvI4Ym7dn9u1WFtPHT7WUtoP4GwVLpSDXmsU
         Rjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717722053; x=1718326853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5QsSMEWckygigFI83mnJYXXGDc+ola7OKupBLG+pCc=;
        b=hhB9hMFf2+50IHn7i1wPD6ORRu1AIYpK8Exb4jkm8V60g0+cshUITrvOYxrHwvfjwQ
         RFhTeoqlVRbZ8nxoSq9e0MoG6Ba2Dz8SlRMVwerWmk+3EA7xJdxM2Mt0Z5Joe0RiJwxI
         2coRL8Kd3ZN54+IhBO5TGNz/RNWu8jZQVy86jBWwKu8KXnK1CLQK/4SQ1hzG6pKlOQb/
         UCyCZ+BIOcXqeJRjue5C6SBbsd2rhjALHetDJ5TmvD5tJPOyX98naRonrHgGdsfCc/+P
         kcVUROrI4S1Oby26E5YnkTZbVOXuupyQnOvyrM74ZXFMi2/+lm0AInqn6yfu5EA4dHfG
         lBkA==
X-Forwarded-Encrypted: i=1; AJvYcCX5dr6iNx5/n/rE0KzFxMR/tziyWp8LPdUkdvaRC4J/gk4PwGsQg1KHJRmhpg4LwXc1pZK/3dpbKPbIzWI0/Ooxzcn39lKTYxsIOv13
X-Gm-Message-State: AOJu0Yw80ulJSbL6fHQROGld5mYAjCXeHLqLuess1oOsSVIzjVZTnL3o
	vq0uvRfmk/oqdGB8W6s9vmgYZAn7893T50Gdvw2m4pXcOOsMSJWiDxgxWGgHVCkMkp8c6Z88pp/
	kxcI4uJ0FOi00oqCCsxdFiLEHLRs=
X-Google-Smtp-Source: AGHT+IEbntKw0TZ+iqky2+3ROVE92PMozct8oAp70ngs5dFm+54BCSXy7L+xhXtRVUDDoWuOYT9ck2VsNIbmJgypQYY=
X-Received: by 2002:a25:d38c:0:b0:dfa:599e:8b74 with SMTP id
 3f1490d57ef6-dfaf659531fmr1169315276.10.1717722053424; Thu, 06 Jun 2024
 18:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606165303.431215-1-flintglass@gmail.com> <CAJD7tkZ=o3AN+4Cj5UBJv6zcrjPFW5T1_53iHB2qtShRRhKhbQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZ=o3AN+4Cj5UBJv6zcrjPFW5T1_53iHB2qtShRRhKhbQ@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Fri, 7 Jun 2024 10:00:43 +0900
Message-ID: <CAPpoddc5ge0myLfN8burL9fEUjc0oaB0C8Yc3_J923hd_O9u4A@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: limit number of zpools based on CPU and RAM
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=887=E6=97=A5(=E9=87=91) 2:46 Yosry Ahmed <yosryahmed@g=
oogle.com>:

>
> There are a lot of magic numbers in this patch, and it seems like it's
> all based on theory. I don't object to making the number of zpools
> dynamic in some way, but unless we do it in a data-driven way where we
> understand the implications, I think the added complexity and
> inconsistency is not justified.
>
> For example, 2*CPU zpools is an overkill and will cause a lot of
> fragmentation. We use 32 zpools right now for machines with 100s of
> CPUs. I know that you are keeping 32 as the limit, but why 2*CPUs if
> nr_cpus <=3D 16?
>
> Also, the limitation based on memory size assumes that zsmalloc is the
> only allocator used by zswap, which is unfortunately not the case.
>
> The current implementation using 32 zpools all the time is not
> perfect, and I did write a patch to make it at least be min(nr_cpus,
> 32), but it is simple and it works. Complexity should be justified.
>

Thanks for your comments.
I agree the 2*cpu is too much. it was conservatively chosen assuming
1/2 contention while all cores are accessing zswap. Much smaller
factor or non-linear scale as your comments in the main thread would
be better.

I found your patch from the main thread.
One point I'm afraid, this hashing will fail if nr_zswap_zpools is 1
or is not rounded to order of 2. hash_ptr crashes when bit is 0.

> +   return entry->pool->zpools[hash_ptr(entry, ilog2(nr_zswap_zpools))];


Return-Path: <linux-kernel+bounces-307847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908799653C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A15C284E16
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2920EB;
	Fri, 30 Aug 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSsLjTsB"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB22182
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724976416; cv=none; b=mAvL6YRq92LLvzCfs0PJeGVL+tXxSe/VY1B9qwILw1C82QK0WN0lGbOi0DJBDNMwk49ApAY8slJvzY5aEDotssxJsSBSuPU8gBgCCupqu5PvB5hj3n3yJt1YTraXwmiXrKbYzogFp9ZwfOfSqhr7fWUFfMl51zrKFQBpKIXENUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724976416; c=relaxed/simple;
	bh=gcJVeezHnc5M6loMY4BlhZa18ZunWNh/ljm0GLCV2KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1XGBBW6ElMuyUvWsw//Kk+jHuQHdejM/pNm9PfRi7t+FtGU5uUfPtwNS9uhE9hsL77cu3eEYTr8KxGyx4W4hx6EY9iXOQv4K/p0QdOU5BdnBwSTqsu1KyoqvsVUZbOU0Urm3Ahe+pVkA18TI9iGCv8GusoF/M2FlFrJaX+V7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSsLjTsB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so6615076d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724976414; x=1725581214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcJVeezHnc5M6loMY4BlhZa18ZunWNh/ljm0GLCV2KM=;
        b=iSsLjTsBN2cr9kDhq4RM4kBn/eim9Dytf5dlptSvamswRJ2c8bkGcRfNzU13dl8/S2
         nSqwDF/21Pz6Q12hP7CcA/Cl2x/jVr58lk7Dz0OxIGGEAibUgE3Ymq4s9Zkv5TvVlEZL
         9fkG6z4k8YRXHCLdm9I8eARfVUH62giShNe8i87hmtlKbqpgx5rPULbEaycgChjaueT2
         KEMM9S/L8cyvDd85yLLDoPZA6aBuI1+hQ8k1xH/IwDZrxA7ynogpHP5j5PhxjHVlK5WC
         40VW7idu9oRzq8s4+tvAoGDGYeaP7+mNUAEOBZ5pwkuQmUUKo1KwrvrRBr+HUoqXvARX
         6FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724976414; x=1725581214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcJVeezHnc5M6loMY4BlhZa18ZunWNh/ljm0GLCV2KM=;
        b=DIP73ULta68Cyi75TVy61erA8EMz0YjUads15DjS8PB+6hrLMugFqA9B1YGIVFfxhF
         KTkW7D94CP9y+zd2jdFgKYjWL7Jn+NwqHp+Y4HtuSEyklekBfP9QuW5Nx9Mzu+cle6Fy
         XGxI7QRQxtsPzZQq+XNHOF26Qztny1ScBEG3P9HiRQ9FguKvGcCmi7q/04FB1uhU3yPe
         EUfekSlz0gU6G52Q6HYjOMqb4oHqeDpvhYt/Vr6KY6inAaP6HfB+UtLV/HuYYs16719p
         XMerMm01dN4iIESEB2I2Umz9zRQhOdgGVlbzdD5rXaMlmTKIlLl6Q39J/Qvi67IRTX73
         IGOg==
X-Forwarded-Encrypted: i=1; AJvYcCXIvrWmh7yEUzWlmxTuPbfBn2vdCGdTQpqCo7Wn9tidpXH8FrtKtdzQ1SiwFBmz80zJIpdWpO0VYcgsLPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYI5jIL3zW9YOu4vadjvnKb59qB/668gUX2otG8LOk8hDVXlms
	P18uBw4MdJ++aI6sqrqO4+9N7lSHL78VMYgkpdZlJ0W3nbSHy0iLvsnJjWA2GQfXyQJeQ1e3VZ/
	/n8OnjfSwAnD4MPVuGLpTf4NzXFk=
X-Google-Smtp-Source: AGHT+IEjmZ4mOIsNpwbXnelgVtFPwFbdSfvNaOyVs7YVCJ9Z/9tHrXkOe+UTzsVo8hdONRJCJo7hLgL4xOX5kciRcSs=
X-Received: by 2002:a05:6214:5885:b0:6c1:6b40:113c with SMTP id
 6a1803df08f44-6c33e695e26mr52140626d6.51.1724976413891; Thu, 29 Aug 2024
 17:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
 <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com> <CAJD7tkbYufUeWWLh=WU1xgeVLMaoafPz+SHgtf+JtYWN+6PbHg@mail.gmail.com>
In-Reply-To: <CAJD7tkbYufUeWWLh=WU1xgeVLMaoafPz+SHgtf+JtYWN+6PbHg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 29 Aug 2024 17:06:43 -0700
Message-ID: <CAKEwX=Mz_tmU1Qjm8ExfnmCVvkNcd2cYpcLQLZBBx0QCXJvOpA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Aug 29, 2024 at 4:45=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> I think it's also the fact that the processes exit right after they
> are done allocating the memory. So I think in the case of SSD, when we
> stall waiting for IO some processes get to exit and free up memory, so
> we need to do less swapping out in general because the processes are
> more serialized. With zswap, all processes try to access memory at the
> same time so the required amount of memory at any given point is
> higher, leading to more thrashing.
>
> I suggested keeping the memory allocated for a long time to even the
> playing field, or we can make the processes keep looping and accessing
> the memory (or part of it) for a while.
>
> That being said, I think this may be a signal that the memory.high
> throttling is not performing as expected in the zswap case. Not sure
> tbh, but I don't think SSD swap should perform better than zswap in
> that case.

Yeah something is fishy there. That said, the benchmarking in v4 is wack:

1. We use lz4, which has a really poor compression factor.

2. The swapfile is really small, so we occasionally see problems with
swap allocation failure.

Both of these factors affect benchmarking validity and stability a
lot. I think in this version's benchmarks, with zstd as the software
compressor + a much larger swapfile (albeit on top of a ZRAM block
device), we no longer see memory.high violation, even at a lower
memory.high value...? The performance number is wack indeed - not a
lot of values in the case 2 section.


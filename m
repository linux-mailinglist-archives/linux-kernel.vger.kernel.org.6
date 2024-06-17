Return-Path: <linux-kernel+bounces-217982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE85A90B749
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B935283891
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CD16A926;
	Mon, 17 Jun 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUOvVutw"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F20168491
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643722; cv=none; b=oSTf2kq+MUVWNhJ1znqUmYEMXPmvgFhafV2ER4HpzI2MHeekFwzrnZuNd9BE/rpScRT/EM0JquWK1KzdrnwwbhI6nR2CvpfyABZMCUuv49CxMt/8ZAoJm0OEGbiAqXCuoVrjyUJnNdEnXsyAYxKi0zrciD5O8X9+6PcZX9IjTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643722; c=relaxed/simple;
	bh=fARW9+gZvhHbOSflmIMoqI0vm3SGvDePEwnH0DqiVYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EruWl4ypX53EevwbzpQMNOKvsAKAgr4PN/+75eSEUWMsIu4h3fQbmT4Tm5e2HD+UH9knlge1o0ttrl+zd/73pXxQiJZPCDwMPMxUP/kaOlxtyzMicPmu3FIclkiJ+9/hOIcxdfVZw0QCnTjiuWrVaGvccFO0nUuG73esoKpKYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUOvVutw; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b07e641535so24221986d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718643720; x=1719248520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM60rjRW/Yf93T5zvJfM1oEyl7EPf4eXUJV+KTU9l7o=;
        b=OUOvVutw+w9UD7rwpBzSM3NkQljYxBkDG/zX6TsLF0HYCPawe0pJw3fJepxIWkxtgp
         Ekkw44E1mYVdG1eNb8WceTwO+DtcAYVr9d1KdKo3+1nnkXeogkdtmv+vPRwciuYklLcE
         p4QQsQw4I+6r8hQiuJTpePSOyCCoHr03xh7xqSXXyg+RUILkw3CUOA6hHgLmNMRo5uZI
         uJGBBpuN5tAcj5ZvIc2TgI6HlWAspKubA1s/ngJDHoGGcldthcNOowQwBu2KOq1kSy7/
         Bbozux0mnKeONhVCLfJduNeB1966CduRL5ZKVyKklrTUeJ9f3HYASFsg5dsEg8FvPh+x
         cMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718643720; x=1719248520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM60rjRW/Yf93T5zvJfM1oEyl7EPf4eXUJV+KTU9l7o=;
        b=mN4VV8AC4OTOVoVCZLXy4bgzdu7Ku5S/Osb5WkZlYtYrWqUmWAnYHsDcFa9sFPwQAU
         DNncGE/uktIOzq+H+MCfFAIamAxXCZvVOouxkod3dbVL2XmNGhB5dJvjF4BHNnru5NXO
         8ZjZSH4TBNaR9Dj1iJRe5ZYdeJ9iW3JOJ1murjjrYbwmsDDK2Si7HJRqZCpeOKFj0Esd
         GE2g4gclhY4o7aBTkhYDZwzMr2fUUY0f6cfjrcXUtuKm7QFqacshSZWPwWQgTyVt5od2
         nqf3kvZNiR/sdKEo5rlvuNW34DqXgHgkGtljUIZL1mvQY6WuA/yVZlKmYIJ8d4uaW5S6
         yZeg==
X-Forwarded-Encrypted: i=1; AJvYcCUAf4XsDTzNsnY8W9SGTZr3X5BRBl81WkuD93NvjxGf+eN1A2cyyDPYLuMm/Nnvw2BnCq62KC8Zah0mrQpNXjsrvJCXJB0+XLb3i6hN
X-Gm-Message-State: AOJu0YwMpIZEczfOZ6sB4v8o+ybrMjAEfCDMPHXTkoFUvA1Eia0LscCt
	oPVbF4xFfNCaOk5ofT1uwaBYq7XfWTN39k/+0W/NNp62rpoWhD7sVhfvys2vfSm0h+/QdppUKv0
	9AnwOEYzKGf6wlq/tl4ffBkvTIjE=
X-Google-Smtp-Source: AGHT+IELEhhMcW+yBw90ppNpYuK8Vh/xr0rN1N/aU8BN1qcmAAFZWf/5fYOzODQNzFeZQk2YLU5HIaKqZY1vJn4o9S0=
X-Received: by 2002:a05:6214:4e:b0:6b2:cab4:4ccf with SMTP id
 6a1803df08f44-6b2cab45019mr59183126d6.26.1718643719979; Mon, 17 Jun 2024
 10:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev> <20240617-zsmalloc-lock-mm-everything-v1-2-5e5081ea11b3@linux.dev>
In-Reply-To: <20240617-zsmalloc-lock-mm-everything-v1-2-5e5081ea11b3@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 17 Jun 2024 10:01:48 -0700
Message-ID: <CAKEwX=Pfi7XYdZN0O=RPJFcwrXLcho5SWQ62tc3v4+RafsZTkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: use only one pool in zswap
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Takero Funaki <flintglass@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:58=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> Zswap uses 32 pools to workaround the locking scalability problem in
> zsmalloc, which brings its own problems like memory waste and more
> memory fragmentation.
>
> Testing results show that we can have near performance with only one
> pool in zswap after changing zsmalloc to use per-size_class lock instead
> of pool spinlock.
>
> Testing kernel build (make bzImage -j32) on tmpfs with memory.max=3D1GB,
> and zswap shrinker enabled with 10GB swapfile on ext4.
>
>                                 real    user    sys
> 6.10.0-rc3                      138.18  1241.38 1452.73
> 6.10.0-rc3-onepool              149.45  1240.45 1844.69
> 6.10.0-rc3-onepool-perclass     138.23  1242.37 1469.71
>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

Nice! I see minimal difference between one-pool-with-per-class lock
and current version, and the memory fragmentation should be reduced.

Anyway, I'll let the zsmalloc maintainers have the final say over
their side, but if this patch is picked up (and with the assumption
that the per-class lock is re-introduced), please feel free to
include:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>


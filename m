Return-Path: <linux-kernel+bounces-443701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F4A9EFAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CEB1891478
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93CB154444;
	Thu, 12 Dec 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTyhexcv"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDA1EEE6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027766; cv=none; b=DRjuwehF+bzEDmo7fchgZlblMAUbThVjQhVUq6L6WfBvuKDp9svDAFR6VqWF1O/thw1D+2pkJM2NFfaGV0ypW0jCpFrveFOsn0p+z53LWgwuqoGq4FCZzPL325NtFpzLvPjJiexZweDvbqhZMWDveFTSwu+AOsAObqXy2k7C7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027766; c=relaxed/simple;
	bh=dqZ8SXKlKzZLUodfsqtNq1uA8ELTjCYGzPfX4ym/MVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNLCOdE67QDJFdCB1dCje900mE/F/+u7yLVz10vyJ4VZ30JZrMeHx+KFcbLyEPhRUKITQeNbSL2V79liWhnix9ulIwTzVq1BbNZYAQwv7HRn9bBHf4BnCWPrlLwvixE/ovAo2xPJtdQLZyoxAJicT+H9iQ2/WHiNQqCKt6CzNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTyhexcv; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467896541e1so9261cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734027763; x=1734632563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgpxWCoOVU/gW70Z+lYHwlsqncaqnIOCOzFL+tvMffg=;
        b=oTyhexcvxbXRjo52hazsX2mIw1Gba5GCSocZ/lPlgoUCqDnZq5xY0y5JX2Aw+YyMz9
         0GbojH4LBtrcPXXUA2lvVpnN2qDvoPqosgUA9C700r9pwI5loS1A0Os1IJag9C08ZGe8
         dsEI3qIBMLx/pNJr/F0l5SHy9Jw8eqmD2zrBM3ttEwkXfxL5eDecWMrO3c0ze4Jp+HCm
         MfpguzVuZlJ5B4mVAzDhHGLx2T7i6pJTS4/KlyBHL9drZGrc3F4Kbm6rhJQReVxtn+Um
         2Z+ZEX6tRxO2IA3RWzvL/Kqo+V0P4MtG6ByBm/DX0ztUa/E2TkxuKVnV5OKw6zL9ey51
         cCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027763; x=1734632563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgpxWCoOVU/gW70Z+lYHwlsqncaqnIOCOzFL+tvMffg=;
        b=DMSW6k/bNLg41ewAsICheeGsfTvmckOVwWlwztXAxnHneAJYENBbj/ozBwSFqbqss1
         5BTP56re5LHGs2Z6EjFbnvcRsbAUppmgFhPhAHXaGYFAgYiq4U12S8EBFfDnY7UeTYk6
         vYwhSdTg6OJWJJPrU2bsRijk/MzrBknlQF/cS302E8AxDdKvRjVyBTpZHUBWZlLj2cuu
         LFHT5bgjVFKZx65ErHXqFLB2YBGXHrO34a0O4cL38UtJjLKT1+N+GywthIAms8ZIGqUO
         8jWXPy8k/uVvZxwCae+xljHB+iHYutwOZpvBEgcGa8RDg/dsTmZ9yyv1GGqbj1FPo2YT
         B+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW4NH4YX/JKAuy6wdhrM6nbT+2VIl+4t+wLdPI+mBkZDbAa8RPAXVyKAuWIPiv4ULV1LJIDZF40fttduug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwojytPBJVzRmLDZjEniHVAsZ20kC6MHNtSldoR4OL3D2G+g/Ud
	LslA/zFDGC79aS2ytLxjh986d6EdqZOhEkhwJquVny4idi68eqo9nGVg3C8K7riDtUTQYvgPTAe
	IP3rMuSKa5p04SWEi2bFmNbvTsQ66lpfLk+ci
X-Gm-Gg: ASbGncvoMYFoyBOEzltfnSztd3TIYuEUOgbhNaD35sFJMJXhQVVmJ6rmop8OmvZL2UO
	vDXesBET6ulMzlY7Kx9q3BcmuG6GOnyRZamSVfGey8dCHW3UDja3Ya8VmGzQbq9CjLZk+
X-Google-Smtp-Source: AGHT+IH0qP5OwhD72y09vsaUyO3exHwWBssauqOQb/ChLZW3ve/l0A4ZsONceLX91M4Ufoikf4cQYhO8vc2l1aRwPok=
X-Received: by 2002:a05:622a:17c3:b0:466:a3bf:41ab with SMTP id
 d75a77b69052e-467a103a566mr1686501cf.21.1734027763346; Thu, 12 Dec 2024
 10:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212095646.16164-1-hailong.liu@oppo.com>
In-Reply-To: <20241212095646.16164-1-hailong.liu@oppo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 12 Dec 2024 10:22:31 -0800
Message-ID: <CABdmKX2__wuSLH2x=5=SqQR0wo86R-Xknua-q9BC44XQDjwgug@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mglru: keep the root_memcg reclaim behavior the
 same as memcg reclaim
To: hailong <hailong.liu@oppo.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yuzhao@google.com, 21cnbao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:57=E2=80=AFAM hailong <hailong.liu@oppo.com> wrot=
e:
>
> From: Hailong Liu <hailong.liu@oppo.com>
>
> commit a579086c99ed ("mm: multi-gen LRU: remove eviction fairness safegua=
rd") said
> Note that memcg LRU only applies to global reclaim. For memcg reclaim,
> the eviction will continue, even if it is overshooting. This becomes
> unconditional due to code simplification.
>
> Howeven, if we reclaim a root memcg by sysfs (memory.reclaim), the behavi=
or acts
> as a kswapd or direct reclaim.

Hi Hailong,

Why do you think this is a problem?

> Fix this by remove the condition of mem_cgroup_is_root in
> root_reclaim().
> Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 76378bc257e3..1f74f3ba0999 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -216,7 +216,7 @@ static bool cgroup_reclaim(struct scan_control *sc)
>   */
>  static bool root_reclaim(struct scan_control *sc)
>  {
> -       return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_me=
m_cgroup);
> +       return !sc->target_mem_cgroup;
>  }
>
>  /**
> --
> Actually we switch to mglru on kernel-6.1 and see different behavior on
> root_mem_cgroup reclaim. so is there any background fot this?

Reclaim behavior differs with MGLRU.
https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/

On even more recent kernels, regular LRU reclaim has also changed.
https://lore.kernel.org/lkml/20240514202641.2821494-1-hannes@cmpxchg.org/

> Brs,
> Hailong.
>


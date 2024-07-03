Return-Path: <linux-kernel+bounces-240340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12555926C64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93CB4B2287A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E3191F9E;
	Wed,  3 Jul 2024 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/daE9kZ"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01171136643
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048964; cv=none; b=ER+tqvThqI7HvJxNy+c+F7nkWDO6MIltxMAHAB90aFSgGf0NSIbMzAljMOtt+dIcMphOEXt7vimTl0RQ9bFn2+njcvb0lMifeU19SuZQ/wmzbpfVKODCfzKpnWFgUYe5KbrCE8DwwkR29gEKpeVQkQLcmkWZciC5Zl51Zpr2jQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048964; c=relaxed/simple;
	bh=fINXLa/igBgcbkmLT7ezgnneFPgMUagJyKHvWRoh+xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+HnKOEvTR6OWEb6v0L7Lnke6VDMVg8gVFV4XraefAFAhHG197qrna49JouaYCGNR8sh4zb4mabgAyVAI2vpN2Nh0xR8xQLqE4UGhCBbhMAX5OB0jOctU4Ido/Pue9PqMmiUPNI5CrH/+utuMkmo27QQ6ckgN/ucY0tY8La6H40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/daE9kZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b5daf5ea91so456576d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720048962; x=1720653762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/Wm/ZqWSe9+vVjjHuOE+3B7vmuCMEHlN8ZTqW1NnMo=;
        b=G/daE9kZJagMzl98iulmVgqQ+8RVFVYF+fMBuiRRh9S80cwi8xBxuJvlIx/S2F3nvG
         5gRFwM5tTukvosPHM8pXBuENiBwT1qRlS7HhChZEIJfzq/IaRAPLdzzR6PFsjhh67c2E
         uKWaMYjZf/xu9n0yfskowUDSMwOcDVP4vdJPlc+CzWV9WEWUhaKhGla6ehdsi8/IpkeX
         UL5q1/NAJepoJH3Tisczuju2nySJJWttvx0QrdYd/GYaa+Uv57Hn2P23lXfNpugmrVAy
         1CvVO1xvn47c0Xe7Nu77g05y6n8WrLYg9K5evo23TWCDmr5a6912cAsnSkyXvXl/GiYZ
         HsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720048962; x=1720653762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/Wm/ZqWSe9+vVjjHuOE+3B7vmuCMEHlN8ZTqW1NnMo=;
        b=v2r5gfwiVKXYYPa0Im4xmZD9tdsXXrSZbITH9EdlSHgjLpvRQI0wWtz7DwoWzp/LuI
         P400EzZACY9Yu8zRue1HKyifnztNBb3e16Dc9ZFK+WRSgq0YzrBNUoPxaxHMNA8ZT/G1
         ra90Y2QXKRp8Wa4EUL2SeTNZk1Y7C8ndb+WK+LUBgd+9ighA7h+BdEy3wjWQKnVtwuIV
         7E6KIVswFm1TRBAcVdPb3YSKi0jGkeQek2o4lLADVS49hv8QflmGSm9yZjVYjUlmiBJN
         gOFZOdY7OgMm455qWOZ3K0jjMquJ7bvHp7tGnQb/e54Y9mdKg+rZ5srNyHj6sTMhaxtT
         JT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr5+8y39ZrppJc/pbbzD1DwcWNx9pgHlaRtERB/TsEggmIRVvRtOad8RSMEi8qi5T/JuLWFOEwyLZC0E92HUbayvAf9chSvzEfsKkv
X-Gm-Message-State: AOJu0YwN1AUgbkHSRRpaI89UGNCGpoLrMIt0g8stz4EYvXvWweX10fd8
	AckKy7begup0OzTEjuj236uAZtTVRqUbrzOW2vh267RtUqfmGvQqxTp87DCfPgXBGxvFV5zRkeq
	KM/rfVdwWK84nTZEJAYm6440hAMo=
X-Google-Smtp-Source: AGHT+IHpIyrGd39TptNfNvOFCTvHEAO0R0DdmzXwWGK3QjB9m5iJJWzkJBfbszzKGIo5FUXMzv6vx8+tBZY1/xVX6l4=
X-Received: by 2002:a05:6214:252c:b0:6b0:7864:90ac with SMTP id
 6a1803df08f44-6b5b704fa55mr178712816d6.11.1720048961729; Wed, 03 Jul 2024
 16:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629232231.42394-1-21cnbao@gmail.com>
In-Reply-To: <20240629232231.42394-1-21cnbao@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 3 Jul 2024 16:22:30 -0700
Message-ID: <CAKEwX=N8FTwR5h0ThOJG1-Uc+K_gxK6XGNeiWBSc+DZXhgATjw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix zswap_never_enabled() for CONFIG_ZSWAP==N
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 4:22=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> If CONFIG_ZSWAP is set to N, it means zswap cannot be enabled.
> zswap_never_enabled() should return true.
>
> Fixes: 0300e17d67c3 ("mm: zswap: add zswap_never_enabled()")
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/zswap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index bf83ae5e285d..6cecb4a4f68b 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
>
>  static inline bool zswap_never_enabled(void)
>  {
> -       return false;
> +       return true;
>  }
>
>  #endif
> --
> 2.34.1
>

That's some pretty yikesy bug :) Thankfully this seems unused thus far
(which is probably why it is not caught until now).
Thanks for fixing this, Barry!

Reviewed-by: Nhat Pham <nphamcs@gmail.com>


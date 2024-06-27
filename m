Return-Path: <linux-kernel+bounces-232348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9D191A72B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B601D1F27C13
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026DE17E900;
	Thu, 27 Jun 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Vp6mALM/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42C17839F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493181; cv=none; b=Jhec40thq8nPlFjdI5kZtoHLNc51KCxPkBZwVx6t1jaFXHZ5tGx9eDYojTkMC91rnVVOTZJ/EgshfW1DqnNThuK8ZsWHWram0qOh2l1XnzoTgLOmLATmVL+4+J2RlCyav39a73ziuB03CCCg9lgRAHwzcQ/q+Wu/uBRLkUu9mdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493181; c=relaxed/simple;
	bh=djf+zpDy0cGzml2gdulK4XsNMklzMkCpPiMsnT/SHHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=am8WzvS6V23K6B1NT/Bi+GRuceoIkG9sRLmkviz/jZX3GqksirWH2UmF23zAIoGMxS45IM7eMmtGetvkXi3apQ4fpl5N00Mfw8qm9+XTMNVagx0DDwaCsVhicq1XNPsVgknw+yahfUEPEP9yZLlhmZBACyoaly034yX4mekXiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Vp6mALM/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so1666376a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1719493178; x=1720097978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWHz2FIZmR9jlDrFPN04RMbtkT6hZhyxIzbXRjccwgc=;
        b=Vp6mALM/+CD/pkSwNNdeufo5f1Ixu0V7uJ85ijBHnYlOpPZTzn8MVMK55v37dBKx+h
         F4MWczubBW3GCaIurryg/tTgzwN/HedamRM17NkYByZWh1DeE02fZTJaXrBE+iiyLXGH
         RkjjqRT9Tn0EwnSmRzHtmQZe2efc9SNX6mc225d5Z0vKekScI1tnnASDtTAqY4WL1utg
         DqtkbATF+TrLoeUAzEPtYwHKqtzcN0EGtsVmOn24a44nor1IlRxM+M463v2F2V5GNqPG
         0qKxY/WYrebBeF0CB5kvFtB0PDlxlujfm+2qC0Tr+hEtn2KUHtTvGAQkapYfDze1wAuT
         Lijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493178; x=1720097978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWHz2FIZmR9jlDrFPN04RMbtkT6hZhyxIzbXRjccwgc=;
        b=kuKaulmcXvWJF7G6P7YZiC1kYiBGPX2Un77PTEFmiFbhT2/HYO/RGLCoPRLhrPK8eE
         Hp6jx5g5aNRwEIBQLZLu7rQ3NP8V3qP0NoM6ZZ4nF4HhmQYwQfFXSEMjZ8WfZwteBWAM
         ZPvBiuJSbhyTTEU3lEiI049q4OpvhuNZaZCQMWOjjCct2GC4GxP8ugJuiSvGtNeYJT00
         pVucP25Gihswy52qm3w2s5DG7x2kOPxHShR/uPYvqafbMtNb/8s5AjGJmYck9RDWqHFz
         x1Icdevt3H0VYqjMw2Eikfivkx94XeOsUv3Nje5sT+iSJwUL1TrQ8H1TOFRliFt18R92
         eHGg==
X-Gm-Message-State: AOJu0YwQTjvb4rsoQIWqQkjpyHLVUvvXQDnckfJCyQy0tT4O++uQxb4g
	czqZ+xEZj61gcBVjorjEHxS0rD7Sg5YwQwSJh0Ytd44maIcxmbzx39+9xZyVu0EtQ/YESw2/DUX
	ef1b5IIvDKMJ1L14gYGF+XyXAyjVSvoXZfpghWw==
X-Google-Smtp-Source: AGHT+IGb36nfDmQg3J0KfNIEsQLDUZQFaR8fiSp4DzS029pm7FdcwFqbfZ9gp9MN4M5+cIA/npuz/aHOpc7E8ST57AI=
X-Received: by 2002:a05:6402:3491:b0:585:59d1:52da with SMTP id
 4fb4d7f45d1cf-58559d1555cmr926476a12.1.1719493177672; Thu, 27 Jun 2024
 05:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com> <20240620175703.605111-25-yury.norov@gmail.com>
In-Reply-To: <20240620175703.605111-25-yury.norov@gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 27 Jun 2024 14:59:27 +0200
Message-ID: <CAMGffEnKZK_Du+f=v_PxsJEv4PE=L=vnkejXWW3Eu7gw9vpKSw@mail.gmail.com>
Subject: Re: [PATCH v4 24/40] RDMA/rtrs: optimize __rtrs_get_permit() by using find_and_set_bit_lock()
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 7:58=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> The function opencodes find_and_set_bit_lock() with a while-loop polling
> on test_and_set_bit_lock(). Use the dedicated function instead.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
lgtm, thx!
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.c
> index 88106cf5ce55..52b7728f6c63 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -10,6 +10,7 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
>
> +#include <linux/find_atomic.h>
>  #include <linux/module.h>
>  #include <linux/rculist.h>
>  #include <linux/random.h>
> @@ -72,18 +73,9 @@ __rtrs_get_permit(struct rtrs_clt_sess *clt, enum rtrs=
_clt_con_type con_type)
>         struct rtrs_permit *permit;
>         int bit;
>
> -       /*
> -        * Adapted from null_blk get_tag(). Callers from different cpus m=
ay
> -        * grab the same bit, since find_first_zero_bit is not atomic.
> -        * But then the test_and_set_bit_lock will fail for all the
> -        * callers but one, so that they will loop again.
> -        * This way an explicit spinlock is not required.
> -        */
> -       do {
> -               bit =3D find_first_zero_bit(clt->permits_map, max_depth);
> -               if (bit >=3D max_depth)
> -                       return NULL;
> -       } while (test_and_set_bit_lock(bit, clt->permits_map));
> +       bit =3D find_and_set_bit_lock(clt->permits_map, max_depth);
> +       if (bit >=3D max_depth)
> +               return NULL;
>
>         permit =3D get_permit(clt, bit);
>         WARN_ON(permit->mem_id !=3D bit);
> --
> 2.43.0
>


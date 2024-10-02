Return-Path: <linux-kernel+bounces-348078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935E98E236
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A37B1F23DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F6212F0A;
	Wed,  2 Oct 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0z1ZJVmK"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D812139BF
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893277; cv=none; b=mdniCoFmpFrdP2+0mV3+/JRv99TuR5c3j2DP6lE5CYOBIw1HPbg2mEcC0T5eFVVJerR4QblVUQX/6uYr1xDWP84H22ld6ylLAWlX8MgEIhO8hAjZpCN2Xb329yxlbdyXeojmfzK4wy/9iyKZcv7OSbv4K05DkH0ySP71g+ag0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893277; c=relaxed/simple;
	bh=xetDe2ovz551qcsL5azDjEtHFF3sjD8HZsMQYdGOXvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWfzK1WCoIuv3y7x0gjuRa/6vsUz0M1mWn/lWtL4b2N4zImOmIBo6cYRSyg0q2H3fHeU7BeglD9Xb2J6134rjSQhW+dKFznrOCSXAI97X7fLuzWeyfWVbe4itauybqiF/DzDouhSb6c7blXavyomgk+NJG8c4S04Tef2jGvZyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0z1ZJVmK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d56155f51so3352866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727893274; x=1728498074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G6IpRXnowLGAwneNrkRT1UaiEoFlojLs48gIVxGlxo=;
        b=0z1ZJVmKlJH/u1Ena8JfM8IE6/Pzd5/UTJKBdmeoC9ClZer7IoeEOy0MQ7KL836Ou9
         iBS6N7AZqS9478joUCGd1/Ub3e2rFBzIkThrgV3euHPOjGdTziTgNaprTLzhfIj5H7aW
         ma7VBrpPdMCO9TtvK2npih9/otTYbtqyRC7kffprKJ370WEp/k5jCyM9YQHJBI1zHT2O
         QddZRYuEPLzEfmkLdzOQOD4eYV9vSGff5fd1CvX4PbUN9bD6hc3a8kR+kaQ7PbYFir0h
         cy+To/CRVkDmjofVexO2J90FRb1DBeIzixKUb0WfDvqSgibU3NFHBlxZYiGM8HHAha6N
         kigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727893274; x=1728498074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G6IpRXnowLGAwneNrkRT1UaiEoFlojLs48gIVxGlxo=;
        b=XEZdQnL8QamLvm/EdkmOkd0G4S40tEHRb4K6jZ3DoqQ3o/AmBVcNwO2kzRzab9EuMc
         bPWU7P8RHFk7uV4mUK9M7psmDF3BROzvTxvVGagcM7w5MmCcJEvAlA3V9bxKyfH7Ot4E
         yoVdzJEHyX/IXiuOaPrZb6LP+QnnGCy4C3d27iTaQadCmiX09h4BWB/seGbNWu4/pL27
         pI9Wf5wth9v7yL5aeh/qZyNizMIqJPYEuu+3yJqfq+5FYUXLs+E/dmeQiy2zC/4w+r3/
         WwO1uHQQfsHVkyzKV8TB9yzpFZN182p62suDFn9QUMkkEooX7Hf0UlyBKhLtHH4FdKsx
         xRUQ==
X-Gm-Message-State: AOJu0YxsGFWyu7yFpl9X0UQ6oT6HfD8e3BzcBi/ceG674r+g7anLgVER
	J8bZE8GunpCcudhGuqxjMF0bdk75LonlBkc2eNVAUFY8gZOsDijwcZjzCX/ekZYdZZcJ5BQfLBU
	3j1lP9wrXFRx66C2d1OAxq6xnpXozQAmeO1wbMHTZj4+sHMQabNdo
X-Google-Smtp-Source: AGHT+IGECmD3qqIz3bFibtSH6L0BAbg6ja0nGX7UqeRLYZC/pIXHeENPqg7ZVxdrbfMMMwSNQyjOZ+RMSruHZ/pVoLE=
X-Received: by 2002:a17:907:9404:b0:a80:f6a9:c311 with SMTP id
 a640c23a62f3a-a98f7ffd71cmr331706266b.0.1727893273261; Wed, 02 Oct 2024
 11:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002173208.213631-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241002173208.213631-1-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 2 Oct 2024 11:20:35 -0700
Message-ID: <CAJD7tkYsyUSrg-QnEcntc9N6tS0KU1TAwdxJtH87JLFA2NLvLA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Delete comments for "value" member of
 'struct zswap_entry'.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:32=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Made a minor edit in the comments for 'struct zswap_entry' to delete
> the description of the 'value' member that was deleted in commit
> 20a5532ffa53d6ecf41ded920a7b0ff9c65a7dcf ("mm: remove code to handle
> same filled pages").

FYI, usually the first 12 characters of the SHA1 are enough when
referring to a commit according to [1].

[1]https://www.kernel.org/doc/html/latest/process/submitting-patches.html

>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 09aaf70f95c6..c3e257904b36 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -190,7 +190,6 @@ static struct shrinker *zswap_shrinker;
>   *              section for context.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> - * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
>   */
> --
> 2.27.0
>


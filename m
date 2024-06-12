Return-Path: <linux-kernel+bounces-211763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1E905686
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3218F28733D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BBC1822E6;
	Wed, 12 Jun 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD5NFSUX"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07417FADE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204955; cv=none; b=nc5wJ+uMVmbFxsWjR2Zlt+Mg5snBoasoZu6ODIG+HQh6PDNKIhtnrSVZUqvTO4FD20+DOTvyGKPTH2zUH4ZE1PAjJTZRwVVW30SHNAa6Lm/X24EHfSGfith29em8H6oCdkoOiVLMK1/gR5cCzbubXbH8s/I/sgzuDfKCt6E3gAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204955; c=relaxed/simple;
	bh=9vxzMMsiKlsHxS6wCrhX54/bINYp4thihdaS/ecmOVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msxZ2a7wfyKQQx3whONZNqKbNxbww7f7fA4Ao/lwZwe9Z+a+KVwQUy50JyVaUrRHphTRNqWFf04rKi15lsFj2nBis5lYP0IKGPB21AbZV1dZqUf3ghCFkFN+S7xsJcs28YBOaMiDm+YlnnAlO3UPLoTPPNlA1btuU3HbUmzZv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD5NFSUX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6aedd5167d1so12904166d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718204952; x=1718809752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIyFJZA41hTOfcR4RkgAGQA584hTqBRBqK+Eq7CovWA=;
        b=ZD5NFSUXLSbGMKy+BIXNBxNaLDmd/jirh9Z5ErOnhae0Ds4GmQ9pH/GU1DfUND4UJ/
         6rcMDO4QpQHVUig20PQsdxNbvNc704UtVUi+76TtX20ilHRkN8mePhkLRY8yTptpC3zB
         eZtZWyBFcu3SrZTZmfq28LQAIIHES/Mxf7PsvPqWfg0zlgEbY/dbvL1Y/svmnKT48wwa
         ElFcnK1vyjhSpeGHQwzhh+YbNcQec/E1yDptz2tqe5DDIfmOURy/U/CTezlbXcOJifop
         YiwvJOuNWvMOb6iG60UaURQW5plcUXooxngvBPfJ1bGnOeBcDYChA5WrDRsqhblIQ1jp
         ecwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204952; x=1718809752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIyFJZA41hTOfcR4RkgAGQA584hTqBRBqK+Eq7CovWA=;
        b=B6inwXowXrHNMkUyf6w3xl+v4Z0U75urUc/hM5xxAsfuE/qdMIvdSU4fSWug2DzAod
         0QNw3Rwny9/wbJPzRX1MSoMQlbWieWJf7BpuVuX62+SBiIMT4YTzLvPLmStgN/l0jA6A
         cCpLknSyIPxpDj4kbo2Gr5SI37VLAnHFBRKRQynd1axnTGWSzjtnD+3EAggyRIxYb+NK
         JtDdu7RyFiKs7pa1Rwjy8aDJ4+kk6K8AnERAWV9XwFaws+uXUauv+jKzJ2f4T0yJGDRR
         V4RShJ/T0AulCenBCnk3Nf5k57QYfcF6fpqDsgLAhklaXuAZfQyLzs4ojlgIALQdrXaB
         sVhA==
X-Forwarded-Encrypted: i=1; AJvYcCXGX5QXZeP1rEbppbW5fVsMl//Gl1JKANAcMtQfIKqRiSXBGAO+w+WxziCfIP1ChVCY82ixEEFSBD/5KW6qsBqIp+jcs5GeYXqg90eZ
X-Gm-Message-State: AOJu0YzuO6pNAu+TQ3ALrYtGj68ZXluaeKNIBTnldEDG/ecvpWfgQuKi
	pJiREQAvkqNlpXs1VdX6JVwetNr9gyqdgX7FMfq31vDikvif2SZAcha75jjKfDbJhMWrd7Iy2iI
	5GtWbvwmQ4y4QdnRgduoSXX+Bwxc=
X-Google-Smtp-Source: AGHT+IGbzRrnDX5kKP7qBeH4xqlcvLU/jDo/s/lK29Ef63ehaomxr9IhwDzedzhA2rct5ZxGbdOqdEr5x4CobdVgeYU=
X-Received: by 2002:a05:6214:5992:b0:6b0:7660:7955 with SMTP id
 6a1803df08f44-6b1a61ad884mr21991576d6.37.1718204952452; Wed, 12 Jun 2024
 08:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-1-usamaarif642@gmail.com> <20240612124750.2220726-3-usamaarif642@gmail.com>
In-Reply-To: <20240612124750.2220726-3-usamaarif642@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 12 Jun 2024 08:09:01 -0700
Message-ID: <CAKEwX=Nh4hudrcqj5-a4FhE7kZRTKWZs0aq64b0KPnu3Dm=QaQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm: remove code to handle same filled pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:47=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> With an earlier commit to handle zero-filled pages in swap directly,
> and with only 1% of the same-filled pages being non-zero, zswap no
> longer needs to handle same-filled pages and can just work on compressed
> pages.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  mm/zswap.c | 86 +++++-------------------------------------------------
>  1 file changed, 8 insertions(+), 78 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b9b35ef86d9b..ca8df9c99abf 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -44,8 +44,6 @@
>  **********************************/
>  /* The number of compressed pages currently stored in zswap */
>  atomic_t zswap_stored_pages =3D ATOMIC_INIT(0);
> -/* The number of same-value filled pages currently stored in zswap */
> -static atomic_t zswap_same_filled_pages =3D ATOMIC_INIT(0);

Can we re-introduce this counter somewhere? I have found this counter
to be valuable in the past, and would love to keep it. For instance,
in a system where a lot of zero-filled pages are reclaimed, we might
see an increase in swap usage. Having this counter at hands will allow
us to trace the source of the swap usage more easily. I *suppose* you
can do elimination work (check zswap usage, check disk swap usage
somehow - I'm not sure, etc., etc.), but this would be much more
direct and user-friendly.

Not *entirely* sure where to expose this though. Seems a bit specific
for vmstat. Maybe as a new debugfs directory?

This doesn't have to be done in this patch (or this series even) - but
please consider this for follow-up work at least :)


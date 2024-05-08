Return-Path: <linux-kernel+bounces-173880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE38C0726
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACCD28339C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31847132C1A;
	Wed,  8 May 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIwHpyNh"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5985D530
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206003; cv=none; b=QMW42sAo1qQDO3rziKfvUVRH0e4h13bHEqTuc3uMUlVBx24uSy1TeLS6I2QgYsq4+R2eq5AvLX/X5p/NH1P48smz2XW/zYbPkV8BTgvE58T30TFe+dBkOjqd7ZgdduP0Ql6Teoxx4YlAHyoRUz2b8daSL8tzHxUNTm8tv3ETaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206003; c=relaxed/simple;
	bh=qOFm3ZKV69A7H4pqw5T6HTz2Dm7/9XTvjCo9AdNg4zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJlW1vR2zyQ6RiBh75Prx2hnVsfiHdSbbYJq089Bhy6GN4zmw1toAa3yUDSqHcqCFPMBRvHaSSZZEbt2kGpC3eHuIZkyaBONY7E9fHaiLme4WaWxPQZmT6drG2AXyuvUs15EgOp3ATibuz1j24QQ1pXrHsYwfDm+vowmoj5F28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIwHpyNh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43ae23431fbso65041cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715206001; x=1715810801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aldqJPzGArxjZEpKLgm9s+1EdgolTnnhV+Hb3JyH5UE=;
        b=eIwHpyNhRTL5NTj3bT7NnoSy0UN08HsremfMJdvPQCKnbmWzcF9wZEkbV+64RpgzdH
         V7WTEuhEJdcJYj11KAV7zkcDBl7dTKESywKH30Dho98Y5wnyagQXgh1ZBfZU7ZFUVRmB
         voNyunxhwZHG7Ph5huuSgJqciQPCms8Qs6cb96L/3rfiHlAXkydy5midxUhg79NFOlDD
         WMLxiA+SKQXXH5Jwvyd6vGtT4R1cNsCDJhkF+n0W1hGqxYw9UTNuKtTKJL4/QnAMhhqL
         qJjajVE1uhdP3anXX/2CDX+CjRTUGKqh9n1sbIB/QbJYxu2SFB0AIvAq3pNEj4QuRSdH
         emTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715206001; x=1715810801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aldqJPzGArxjZEpKLgm9s+1EdgolTnnhV+Hb3JyH5UE=;
        b=GFoQ/vrzh6uN4Zb+HZMBexk8sd9JKnZwY3RSDFCb+X+DWsi+ic2B6ftDkX/nwSOAwG
         xUaHWGj9v1BoslrtUx08Yo5A+P6B10fLZybVqItayMYi3xZMXJWiMvAcVzVfGAh8zSHc
         Sa30RXAm6bsrsTX+hn7bsqxSlmkcbU3Ja6pvPjCdL6qAy1tU+aGpNw7fu5oXMBZ2f0IF
         RRDBKczlZTX7gqgHU2Qs3/8Ju2K9AuJQHe62H5WbCWlMpluXZA3fmSgVL6QNOhC9SdgI
         8n2Z1ETPzWz/9wcRw7HRNp8ItglYPXCK5GVaQddRGbuP3R9JaZDLIjWwleGxcCSIUxGy
         cmzA==
X-Forwarded-Encrypted: i=1; AJvYcCXhzbL2LShILrT2/1i+dfKJGaCR7XNZzaz92SpQ2IG5ID1A1GyjAkanTJxXpdauFdABWYpd8d5EQI+wGypHKu/lkLu2i1+gWNMTAX7m
X-Gm-Message-State: AOJu0Yw8MjTJNdl+g48bFH71aDkZBVot8tvZ9rb2xpExVRJ7UT4Xn3UX
	bIw3AD6mThuAi/2p4ZTz8L4VNO9Twau/XGRlaksUIm6ESOKtrg6rQDfwPshFopnAbpKKYt1aVbM
	aLh3yGICIGbRKmJyY4dJ2mGXYgJgnqzjV0gpSLm/b5YxssO/YClX7
X-Google-Smtp-Source: AGHT+IHslyE9ivhzwymqY1CNoCjqRPOBfG0hg1XUJ4EiUAR0wxVsaJBHAqH8bw3HTX1qf55o9V7mZbMPecatCwzAJQM=
X-Received: by 2002:a05:622a:98d:b0:43a:e258:8fed with SMTP id
 d75a77b69052e-43def9611ccmr1330191cf.18.1715206000605; Wed, 08 May 2024
 15:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507141210.195939-1-james.clark@arm.com> <20240507141210.195939-3-james.clark@arm.com>
In-Reply-To: <20240507141210.195939-3-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 15:06:29 -0700
Message-ID: <CAP-5=fUqaXWm0xFCoaFYzVkWVMD3Khtxu7au5natVvDVw+fvTQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf maps: Re-use __maps__free_maps_by_name()
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 7:13=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> maps__merge_in() hard codes the steps to free the maps_by_name list. It
> seems to not map__put() each element before freeing, and it sets
> maps_by_name_sorted to true after freeing, which may be harmless but
> is inconsistent with maps__init() and other functions.
>
> maps__maps_by_name_addr() is also quite hard to read because we already
> have maps__maps_by_name() and maps__maps_by_address(), but the function
> is only used in that place so delete it.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/maps.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 61eb742d91e3..16b39db594f4 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -124,11 +124,6 @@ static void maps__set_maps_by_address(struct maps *m=
aps, struct map **new)
>
>  }
>
> -static struct map ***maps__maps_by_name_addr(struct maps *maps)
> -{
> -       return &RC_CHK_ACCESS(maps)->maps_by_name;
> -}
> -
>  static void maps__set_nr_maps_allocated(struct maps *maps, unsigned int =
nr_maps_allocated)
>  {
>         RC_CHK_ACCESS(maps)->nr_maps_allocated =3D nr_maps_allocated;
> @@ -284,6 +279,9 @@ void maps__put(struct maps *maps)
>
>  static void __maps__free_maps_by_name(struct maps *maps)
>  {
> +       if (!maps__maps_by_name(maps))
> +               return;
> +
>         /*
>          * Free everything to try to do it from the rbtree in the next se=
arch

nit: this comment is stale, it should be maps_by_address rather than the rb=
tree.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>          */
> @@ -291,6 +289,9 @@ static void __maps__free_maps_by_name(struct maps *ma=
ps)
>                 map__put(maps__maps_by_name(maps)[i]);
>
>         zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
> +
> +       /* Consistent with maps__init(). When maps_by_name =3D=3D NULL, m=
aps_by_name_sorted =3D=3D false */
> +       maps__set_maps_by_name_sorted(maps, false);
>  }
>
>  static int map__start_cmp(const void *a, const void *b)
> @@ -1167,8 +1168,7 @@ int maps__merge_in(struct maps *kmaps, struct map *=
new_map)
>         }
>         maps__set_maps_by_address(kmaps, merged_maps_by_address);
>         maps__set_maps_by_address_sorted(kmaps, true);
> -       zfree(maps__maps_by_name_addr(kmaps));
> -       maps__set_maps_by_name_sorted(kmaps, true);
> +       __maps__free_maps_by_name(kmaps);
>         maps__set_nr_maps_allocated(kmaps, merged_nr_maps_allocated);
>
>         /* Copy entries before the new_map that can't overlap. */
> --
> 2.34.1
>


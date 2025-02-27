Return-Path: <linux-kernel+bounces-537509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91009A48CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705FC3B13AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F12276D13;
	Thu, 27 Feb 2025 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzDn2G5z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCF276D0B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698854; cv=none; b=Il21Ft/X8mIEMT+P+c+hdeGtYceZoQqSRoWosqrjQsJl6xtc7h97it8TYahfTwgNC3IHOq8KxFs+8FP4g6POS+nzPo2XDKspEW5mbceim8rh81264V8hUs0L+gtPBHCwx9pTPQFNgoAIgYyrFZDnKzl39Jyyq46kIxLmkP1xd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698854; c=relaxed/simple;
	bh=jr7u3BOZKKfDw+c3ldhUxg4rmX9o5zJRP/eIM1CU12o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9FiBi/ftuW4WlDrX0vVYyuT7ZHqOFz4EsJ1nh4MGivcURgUqUf2dDXZIlVHpEibnWEIGZ4iOkX7ymkkYb6myN1i/X1mHkHfWU7Z639M3USCkYlS0Ms8/TIz3YG9gQhuei7nW1a/pSovUq81ipXqpQySCLz9o6ZBImAfNmEdb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzDn2G5z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221ac1f849fso28375ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740698851; x=1741303651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o03gaGFVjRe6DTPlfJATQ6ihz81VY0PF2OQ9MM08hhc=;
        b=nzDn2G5zxoygIpuy+NU5Pe+VxjEaqhKg0Ei5e2MyuvY8uYQ1SesWlO4cvlZaBGwHMT
         UERJSigiJgxsDt+/1+aZOp62ci/q6ORMH31YP0qxPhxpGxk3pepWIYKTTdiJK4uytpku
         z3JNWYp+fm8V2SmzEcPugK+Ec3uMSLHtq26t4lTGsdA3d7AQgU/TH/ceiWp0mGeaZzYB
         2HGDM7eMXIxdyaXg0FAvuAjO/dIB0g9OJx/89eA0Ol54Be0ikPGpW3BXlPzUpWCf2o4U
         1KR8F/psp1/MsXrtyh9bm1NFuAfl6pIB2JgGq+kgRYkwNkA0dojuyUpx3+SDJ3kvElal
         h0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698851; x=1741303651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o03gaGFVjRe6DTPlfJATQ6ihz81VY0PF2OQ9MM08hhc=;
        b=UPacQnXWLqpm7Q0FfjLWKiHtNYqc92vwQjbMd0yoZdEEZYwiWh3iLkvJ76Y0XUAgu+
         /zCT/g97ERQSn63uM4hCU97ONiQeHf4DXgyB1AeVmHTgPGQd6y7lwLr19CX0vAtGWdPx
         I6pOiP6d5YUMgIx2sGgfAOJaf4xCRCakRkj74t//5ET1bNX2PRvQazLA6pnOmadnzRjj
         3YPDWsC/U62WvcsfIed5GcZHg/kzgeEQL8R2bv6T4RXxeSHscAD4wwGGJ9b5EgPow2eP
         XB/Em67vaPMUQRF75GRmSiENYBLCYQXcWZc58jcC4Xk97G5cJUVXvL+T0mKoSRsObq9C
         KIjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV25h6QEZ/O6OeM22xpvBHE7HIPtUeQRH/U+2pVBIJthrTlbghq/vivbQ/MoWNaSAIVy1DPb7cgrkfawK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUJTyw0DtcNhuwU9IfAscRuEfNZ3RbgFtPykWIRLOoH2QHnam
	HzGJYkXdDYEw8Xwu8wT0z4Kk2NtRXY6QfgljdZtdL+3YWB5DHt8nhAKQUBGKLgVQ1q9I5Lk/dfu
	k6+P+wtvBT0F92Jp56JznSzqMzLz2YbZS+K8L
X-Gm-Gg: ASbGncsWScX7q0k4GiF+pGWyDTYsLa87VBQk3m756JVTkrpQR389z5o7tXA/HlrIjXK
	JjPfzpDErpi35mZyxts5goxSQxVuLJzOfPkdtteY9ExLNJCw0LuckjwQTm67YmtMg2ND16rCb96
	3hTwm/5LHWKtlRXx5JgAzipCdn3sYcF6BE8hU=
X-Google-Smtp-Source: AGHT+IGZEKIqRJs0dHjZ0ac8WstQxsDWoFoO+KTsgHSkoiplmefENbkO/0Ml8B8SOtsWigjR7vAlSECbNe463I9aNzY=
X-Received: by 2002:a17:903:278e:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-2236cfcc6f3mr400065ad.27.1740698850828; Thu, 27 Feb 2025
 15:27:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227215455.30514-1-acme@kernel.org> <20250227215455.30514-2-acme@kernel.org>
In-Reply-To: <20250227215455.30514-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Feb 2025 15:27:19 -0800
X-Gm-Features: AQ5f1JpIi5vdH8MS85zSlahfNtAd87BvrmGzOP30gHtNTV0nBIMXx3_MS1ndY0Q
Message-ID: <CAP-5=fUqLyCt4=4XgoCjTkmeO4yrHTvEU1Hw48-+S3Szi20x5g@mail.gmail.com>
Subject: Re: [PATCH 1/6] perf maps: Introduce map__set_kmap() for kernel maps
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> We need to set it in other places than __maps__insert(), so that we can
> have access to the 'struct kmap' from a kernel 'struct map'.
>
> When building perf with 'DEBUG=3D1' we can notice it failing a consistenc=
y
> check done in the check_invariants() function:
>
>   root@number:~# perf record -- perf test -w offcpu
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
>   perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=3D =
map__end(map)' failed.
>   Aborted (core dumped)
>   root@number:~#
>
> The investigation on that was happening bisected to 876e80cf83d10585
> ("perf tools: Fixup end address of modules"), and the following patches
> will plug the problems found, this patch is just legwork on that
> direction.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Link: https://lore.kernel.org/lkml/Z74V0hZXrTLM6VIJ@x1
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/maps.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 09c9cc326c08d435..e21d29f5df01c6f7 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -428,11 +428,29 @@ static unsigned int maps__by_name_index(const struc=
t maps *maps, const struct ma
>         return -1;
>  }
>
> +static void map__set_kmap(struct map *map, struct maps *maps)

I'm not sure this is the right function name. The kmap is created when
the map is created, so perhaps `map__set_kmap_maps(..)` is more
accurate.

Fwiw, kmap is:
```
#define KMAP_NAME_LEN 256

struct kmap {
struct ref_reloc_sym *ref_reloc_sym;
struct maps      *kmaps;
char      name[KMAP_NAME_LEN];
};
```

The name is pretty chunky, perhaps it should be a strdup-ed pointer.
ref_reloc_sym is used in the context of a machine, so perhaps there
should be a hashmap from map to ref_reloc_sym.
The kmaps variable seems to largely be unnecessary, things like
addr_location and map_symbol carry around a map and the associated
maps, so when kmaps is needed it was probably already one of the
arguments to the calling function and could have just been passed
through.
So I think there is a cleanup to:
1) remove kmaps - just pass down an associated maps
2) make ref_reloc_sym and name things looked up from a hashmap
3) get rid of kmap altogether so that invariants don't need to be
maintained and issues like this shouldn't repeat.

Thanks,
Ian

> +{
> +       struct dso *dso;
> +
> +       if (map =3D=3D NULL)
> +               return;
> +
> +       dso =3D map__dso(map);
> +
> +       if (dso && dso__kernel(dso)) {
> +                struct kmap *kmap =3D map__kmap(map);
> +
> +                if (kmap)
> +                        kmap->kmaps =3D maps;
> +                else
> +                        pr_err("Internal error: kernel dso with non kern=
el map\n");
> +        }
> +}
> +
>  static int __maps__insert(struct maps *maps, struct map *new)
>  {
>         struct map **maps_by_address =3D maps__maps_by_address(maps);
>         struct map **maps_by_name =3D maps__maps_by_name(maps);
> -       const struct dso *dso =3D map__dso(new);
>         unsigned int nr_maps =3D maps__nr_maps(maps);
>         unsigned int nr_allocate =3D RC_CHK_ACCESS(maps)->nr_maps_allocat=
ed;
>
> @@ -483,14 +501,9 @@ static int __maps__insert(struct maps *maps, struct =
map *new)
>         }
>         if (map__end(new) < map__start(new))
>                 RC_CHK_ACCESS(maps)->ends_broken =3D true;
> -       if (dso && dso__kernel(dso)) {
> -               struct kmap *kmap =3D map__kmap(new);
>
> -               if (kmap)
> -                       kmap->kmaps =3D maps;
> -               else
> -                       pr_err("Internal error: kernel dso with non kerne=
l map\n");
> -       }
> +       map__set_kmap(new, maps);
> +
>         return 0;
>  }
>
> --
> 2.47.0
>


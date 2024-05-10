Return-Path: <linux-kernel+bounces-176236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B48C2BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF551281832
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868913B789;
	Fri, 10 May 2024 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNvAbBlx"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8013B5A4
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376471; cv=none; b=sVkc1tgkPvX++aqL7pxnUdz/f/dDXtmdM81VE/EbLnSrJ4g2vvLQFqvipIUu5uKA6illl1j6rUOh4AyvAN/HfLyQvzycz0JwsBX47YRyC7dWd51cp70Cq3ZtuYaGFMadEvmySOE+ZxF6FZ8EgcyjQC1i/Eqk/2/6BZiW5Lp//Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376471; c=relaxed/simple;
	bh=hb8r21bsZDeQ6IILpMa8J4jpgSC0HQY1iW+OfrfCDS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW/JekwNEsNsTNUipjZSLTNkGI1iVFC0o+zVeMRz7tfSufHF+/eVYB73YU3QGu4PDHJbdhw0IZm/M6v7jHumjXY6Lsrps4xZ6hD+7tkTTML3RzKafs+zYsY2QqAJjDCW5mSdwxtq/aUeaz4IU5/p6mwAoBwE6yk3qbN01UA5n2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNvAbBlx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43dfe020675so136911cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715376468; x=1715981268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mKJDhvKiTqgTK80eZzW3APk5Ua5WfNa0sYKeeiCXcs=;
        b=TNvAbBlxuTRKLa5wrg92RENelGxOmZ2QjrOZPDxhz3fc2lEQr1LwKnd9Ev3Ctwmike
         VOnXtJiOUZ0fjctYqB95Ie2lw7DPsDtvQ3/3CNpGP9e+0AcyobVGTo/y+aYciTOKHfR9
         jO+Cp2AeCcWMKllpLfQl1weSDsRK8aM3lKAMDl7rxTj+LpEuOAl6rjfyFJ1YnL0IN4iH
         vTr7vTDl9Sq9iEWB28C8qu5ltvMlKDIS6jOCluKnq0vrzofR6ecI/IHS5Gc1AoEyAQQx
         ayK7f5Z2E6xINU0b6sgMfWzfReDEkYkTBia6AqkFBW8GLWXX46EJJJwf9HULiQqOSKpl
         m1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376468; x=1715981268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mKJDhvKiTqgTK80eZzW3APk5Ua5WfNa0sYKeeiCXcs=;
        b=bZvOYeqTSnudfOtWVG/ijk+b3CVG57ccAh3tKp5mXP//A9LUW39K2lmDE6VplANtOn
         /TqoOlU3c5KTeavk+UwUhuy+OtFAVcXS09aeuXeNAYv9HeCFE5aG0Q4NiK+/XGs/k6hj
         mMYFYurwvI3fePwb4R5aYPODgXfTfqVwbt2gAG2grPttyR44ZKMMYlXOQMbnhWMK8uDg
         ILAz3+zS5EbQsu5zvAD1PYBhjGbavWmHEMNYxK67e+1UA7YoT9XH9Zwxfx4OPiIBnS8W
         /pFbgfQmSpbRJRrCZa5MdU+3vwcqerQsMwXYFw8DFaJcY3h6xbkpSu4L5Iu7vn/q3YMC
         P/5w==
X-Forwarded-Encrypted: i=1; AJvYcCV5daXBcKE73Dbxk7Dqxep/VkXJEUPxfGFZ+xAvWLm6V9/ncEQqIsyQeWbO02cYWoe5Cje4N/DGejgRyEn4FpSYfczNepNpM0aZ/MlR
X-Gm-Message-State: AOJu0Yx4jayPXvGsGMyz54cnMQyO2GeSscDExhDjH6uoiXISIa/9qxCR
	3+h4n+1XdQW0veTbmqdkzHE3w3GLx8oiSbhBdAgKf4bDGOF1fRjFwKnNqiCzxaqaBuRcWqVcWA3
	njdFBAYHoB3+sZKVDS2VMeOo5RP61DtHwNNX+
X-Google-Smtp-Source: AGHT+IE3CmyCzNILFPd5LbQ1jqo8ih0ankzGWd6poIZZlX7bANdM4aQvLdCinf2ho8htV4sOnWDnh8nTLSto4kIBGV0=
X-Received: by 2002:a05:622a:4286:b0:439:ef72:75fb with SMTP id
 d75a77b69052e-43e0a21e3c8mr133981cf.1.1715376467681; Fri, 10 May 2024
 14:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
 <20240510210452.2449944-1-namhyung@kernel.org> <20240510210452.2449944-2-namhyung@kernel.org>
In-Reply-To: <20240510210452.2449944-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 14:27:36 -0700
Message-ID: <CAP-5=fUBQ=GdeQdB25GNtS_ijRxu42W+uz4p6kuykG-8iC1DdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf annotate-data: Ensure the number of type histograms
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Arnaldo reported that there is a case where nr_histograms and histograms
> don't agree each other.  It ended up in a segfault trying to access NULL
> histograms array.  Let's make sure to update the nr_histograms when the
> histograms array is changed.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate-data.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 57e7d4b3550b..965da6c0b542 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1800,7 +1800,6 @@ static int alloc_data_type_histograms(struct annota=
ted_data_type *adt, int nr_en
>         sz +=3D sizeof(struct type_hist_entry) * adt->self.size;
>
>         /* Allocate a table of pointers for each event */
> -       adt->nr_histograms =3D nr_entries;
>         adt->histograms =3D calloc(nr_entries, sizeof(*adt->histograms));
>         if (adt->histograms =3D=3D NULL)
>                 return -ENOMEM;
> @@ -1814,6 +1813,8 @@ static int alloc_data_type_histograms(struct annota=
ted_data_type *adt, int nr_en
>                 if (adt->histograms[i] =3D=3D NULL)
>                         goto err;
>         }
> +
> +       adt->nr_histograms =3D nr_entries;
>         return 0;
>
>  err:
> @@ -1827,7 +1828,9 @@ static void delete_data_type_histograms(struct anno=
tated_data_type *adt)
>  {
>         for (int i =3D 0; i < adt->nr_histograms; i++)
>                 zfree(&(adt->histograms[i]));
> +
>         zfree(&adt->histograms);
> +       adt->nr_histograms =3D 0;
>  }
>
>  void annotated_data_type__tree_delete(struct rb_root *root)
> --
> 2.45.0.118.g7fe29c98d7-goog
>


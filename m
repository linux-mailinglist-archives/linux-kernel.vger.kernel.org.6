Return-Path: <linux-kernel+bounces-173934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D8C8C07CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0F7283BF1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E52132C16;
	Wed,  8 May 2024 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2C6oBAML"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0701E89A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211629; cv=none; b=ZRBQrNv3KgOQDWjKK3egR1RzVHAQUQ+O7JAfpjvnS1jFH0jZMtLRHAV/NRACG4fT4esrahw7Mh3Wl77BCR+Fu6+bssg6bYe624MoBKCc3nE6h9uP3C52BWIKrL73Z+bI2SV2qveY1fPKezJ4l9J0jQc4ZM5eiZmY7Q3Nn0VHAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211629; c=relaxed/simple;
	bh=+wtLczbdW/FxsW0T85EByS/LSghiVmxUEfbES7DYGDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chhJPm7/1jvwZe5u6XWq1waHHxdNsFrfL1YFmccnBxgPhQ3jO/oU8/+UzUm5FRhuc4uwTnmCkjeyAWFVBE/LumNBJiYrPmSgu2JHuPW31PtP/v5boFQYg7Iy4On115sjs+AcaR4TY2EUwo9sZ+fFro3z0WU8aZJsYMygdIQiNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2C6oBAML; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-439b1c72676so94221cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715211626; x=1715816426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jATuZPpZr2U9Ga/FPqShVFC6Jp9UCpaINafz+jyTdg=;
        b=2C6oBAMLKFLjDyWQu95xlozNq2SrmzrLrPvjXVphkNrSmf7R7gyNzz3OBO7EStBSsv
         MgrQ4aGqBiEgBhC45gdoos4kov3NzbcDv4Nq2clnIt6SqSlO+Ji676gyaGt7IuPkKIeX
         351c/G9xg1ArAOHjcHg9sTYk+ZYMiJjXA3VYHsnvspCw5HUjR6L+iOiW5voGNyVjyXTm
         moLBEAWn0NGGrmF4Z2nl9DPWZ3Lg69nMeO0BFid29L2RkToEX88wMxrB61Oq3C4LXMNM
         FbHOvgMjtYw7pXNDMweIFrD0/xJf8IUQqXwpQFNALJLR8pvlDE+xr5wvipF2G7EYIsdD
         Wu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715211626; x=1715816426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jATuZPpZr2U9Ga/FPqShVFC6Jp9UCpaINafz+jyTdg=;
        b=kzpwIY5u6QlJBFDlBZIsGW8hwNV+wHSes+L5XbCrglO4mnbsmeHxgJ4X+6WtwUx5EV
         naZjtv3t16nqUyaGtKcxigRdWR0lmXmib8fiJ3pwQoknb+WCan9CZx41NmrfuyWLqMVU
         KqkfhShBpyjp2Y9exUVSLGWRB2sjXAqIK9aUUp9IgYHs+5aGmB5CVDIXpni8nAOCj5ID
         Z6g6bmb9IA9gJjhrTsIBRjsybvfIyca52N7S7M2tQIl7joz80mCEg0oN8SRYGFDKwa4C
         FN1zLDoPO0a7K275wWUaNFZXKjScPAfLbJyf5+05YnS3/X2XiCocat0QCloGzvn3Q023
         lnfw==
X-Forwarded-Encrypted: i=1; AJvYcCV7vkFhfvAMOIOB3MoPumyOHMtlCDtyGyF6zQLqYhpGGr0u3mKG8C4R+eKk4KNV5PnkhrEpsslTsieIGoewJFLTeblXzrpnHMcqUH7u
X-Gm-Message-State: AOJu0Yxyy5f1nCtzPqRsPLN7hzLfp8fEQ749p+gR0vnp5aEq+yXkmqil
	OSYIphTxudhZs6vRHhLaw91qrj3z1HrBLlNwX3485DXHMufkrRl7RixCpM1altFlWnX9X5fpog9
	zjZeqnrem8FI+orIRN7Hsytp+dwiRr3+uOfg3
X-Google-Smtp-Source: AGHT+IEzM/v17pOrH2E0AcDlysaONbJ9WV32yZgY4IdcqsgZEc5Rc57AmhGuXksMDKk2ok6tUH0P85eZgXr+e2WgwZw=
X-Received: by 2002:a05:622a:2283:b0:43d:e9ce:63ad with SMTP id
 d75a77b69052e-43deec6a98dmr1246531cf.0.1715211626478; Wed, 08 May 2024
 16:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjmcGobQ8E52EyjJ@x1>
In-Reply-To: <ZjmcGobQ8E52EyjJ@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 16:40:15 -0700
Message-ID: <CAP-5=fVz8a29_k9-j4LnJdAoqiXAREwg9g+owx5WZ0LhgT7yTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf callchain: Use zfree() to avoid possibly
 accessing dangling pointers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:12=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> When freeing a->b it is good practice to set a->b to NULL using
> zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
> pointer is kept somewhere, we can more quickly cause a segfault if some
> code tries to use a->b.
>
> Convert one such case in the callchain code.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 68feed8718096f78..1730b852a947400f 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -606,7 +606,7 @@ fill_node(struct callchain_node *node, struct callcha=
in_cursor *cursor)
>                                         call->brtype_stat =3D zalloc(size=
of(*call->brtype_stat));
>                                         if (!call->brtype_stat) {
>                                                 perror("not enough memory=
 for the code path branch statistics");
> -                                               free(call->brtype_stat);
> +                                               zfree(&call->brtype_stat)=
;
>                                                 return -ENOMEM;
>                                         }
>                                 }
> --
> 2.44.0
>


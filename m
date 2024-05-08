Return-Path: <linux-kernel+bounces-173936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5D8C07D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6920A283EB7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA9133401;
	Wed,  8 May 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qi6LoIzC"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B753130E5A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211654; cv=none; b=lHBxKIURhFrcjJu7b9CJ+LT4isbQ6JnAwrm+Nwi6pPC/nqdXrAjlROq1JJsQHwWjm/7T7bDAlCnaYOseK6GCUfTCHr36KO+LzkYkyWxBFILsq7zrblCxr+NjjnIDzRXtxkhwpNne5H2YEvVzK7YPDXJDdIMo4yjUgpTB34nr810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211654; c=relaxed/simple;
	bh=KwT+okHPi+W6VidpPKXRKh3Wp+ViBEdA4IHjwz/sFCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+MHoTa7E7tm81mYhKxKADqFXJB6Iu12uqZwgTN60aU+7c3tqqpS2OeBuWvDRaavJ2Agv+36GzTDys+JW8s77OM7fCCiH9NnjkNf4z/Btqrl2UP93MHdDt5WR3bPHqYzgO5dQln62izLvH7I2zf3ZKU0ywlMJsHkeIordhbrn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qi6LoIzC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eed90a926fso62365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 16:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715211651; x=1715816451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtBaK54I/OmT+ZzA/0tf7fwuvPPu1s0eLKsDcEO5LUU=;
        b=qi6LoIzCLq4SeYGvdiLFo91UPUgRc8VAjgYHRryxc7qIKku1C2lali1ZIXsdD6qFZ3
         kORy//kvHgYzx3VxXGWEX4oL9R4q8HBjrdO1e24gX8/DFAr57pfv28tjhn3EEJdyCORs
         3W5Zsjp2phod1fw0TkFLV+nOgcDwySyRng+lA6w2q36HbFnZZIne3EHE/4yTccKCJ0a/
         DnBuQ6lAfOPMnC4IoTQKdy1v78B/CXQuGBUzvZZlJ9VS3+T2GAtPMeyyH6logM9s6avI
         FoiKlQp8f4mjFh84v3w1F7DtNZctwT148nf0QYCoPmWOOnVMPn8wShJEngoIyx0eHjHP
         5TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715211651; x=1715816451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtBaK54I/OmT+ZzA/0tf7fwuvPPu1s0eLKsDcEO5LUU=;
        b=Z8JkFVfM1msqWm4vcE1Jm3Wj9JuTkW3V3HbDGrvoviwG57ODE4lf95RiGc+SkT/awg
         iGj9QppwdWlZdtICxDh3xW94Yfhy/sg1vLmdt1sLFYXdcoreNfGcBEoKA9giQeL18RJr
         vqOESoysx7X2VSACv+6bK+jTP6amcOWD83NHj4wQuOXFHmVyxCkm2JJ+ZCAY1tTDV3Rk
         Pa1Uq7fiLEK7VnfxKRJ/2Nmn5GPMwa/lGEwGPkC98pU/LKDso73hYbVLWyTFvw+B6uYz
         hTDL3lQ2CkySXfdV6MLA3nVNHalTZdQBI9ECO1J/81gdC+hCKXlt54q6cwzgoeY3wKA6
         xs/w==
X-Forwarded-Encrypted: i=1; AJvYcCXRoFNhKQYJcR+HSOIvNuEhNR06NTyIFDn4Z/20hrBA8uusJr84aLJZleAlzv+XWhP47UqHucGWW4eiYQ5tO14N8hLrAU4FqfXMX8Yn
X-Gm-Message-State: AOJu0YzsoMnlZq0sTSU5Pei5nc0NiqvJ1JyMpgtOlrOBWl6Wg3WtyioH
	e6f3+32Jjou5Kmin+fF0aVXU6/84trl38SXHDBEQQvPZBn4REPGC8s3MzJ/xld6E1CGBZ397ZR3
	4wQzJLEGL3nckc+RxvlWPqKLW3B8yV7PnATXd
X-Google-Smtp-Source: AGHT+IE9rtUIKw/slmUwrF8lW9b8vFSRydp6eE79h5ko9MZ8atWirNMl5J/gF4jU3omSX5ix5Yu8yH27Id/RF3iiyMM=
X-Received: by 2002:a17:902:f605:b0:1e8:88b2:17cd with SMTP id
 d9443c01a7336-1ef005fa6fbmr1062665ad.12.1715211651249; Wed, 08 May 2024
 16:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zjmc5EiN6zmWZj4r@x1>
In-Reply-To: <Zjmc5EiN6zmWZj4r@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 16:40:40 -0700
Message-ID: <CAP-5=fV3T6G29Hrg3fGRnenjxUMjVfPK-zFGQgp9UgJn1JBA9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf kwork: Use zfree() to avoid possibly accessing
 dangling pointers
To: arnaldo.melo@gmail.com
Cc: Yang Jihong <yangjihong1@huawei.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:15=E2=80=AFPM <arnaldo.melo@gmail.com> wrote:
>
> When freeing a->b it is good practice to set a->b to NULL using
> zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
> pointer is kept somewhere, we can more quickly cause a segfault if some
> code tries to use a->b.
>
> Convert one such case in the 'perf kwork' codebase.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Yang Jihong <yangjihong1@huawei.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-kwork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 0092b9b39611d7e9..56e3f3a5e03a2d66 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -2230,7 +2230,7 @@ static int perf_kwork__top(struct perf_kwork *kwork=
)
>         perf_kwork__top_report(kwork);
>
>  out:
> -       free(kwork->top_stat.cpus_runtime);
> +       zfree(&kwork->top_stat.cpus_runtime);
>         return ret;
>  }
>
> --
> 2.44.0
>


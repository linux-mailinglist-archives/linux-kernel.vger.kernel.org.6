Return-Path: <linux-kernel+bounces-346463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF6A98C4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EF0282C6D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091581CBE9D;
	Tue,  1 Oct 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="370FzfYg"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7261CC15B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805662; cv=none; b=LRxYiVbWmW7oDoooriIu3Doc0y3YdXoIVb/pIAAKhpIbtgXSoLgMEL+Im2Kq4mwDA6JPtO/PiPYbEm1PtgD884kn+w7W4RlXiZJtklSX4h/M9oNvBFjsCKLMCGPjMtTB3I80AsM+u27BX5+AN6Tu/K7E3JOPHyia+5dsj/Rg2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805662; c=relaxed/simple;
	bh=3dKh4rYpTPR0eObJ8nP2w/6rINF7r1NuQvusAAAfsno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGVlzoIneJZRibvVktEuHUIQYD8mLvzS1X/1TH39RPW73CrgCExShEet54LZwpoBePEjKSAs54MXXSSiEbSL698NAgn0G43momviH/5UYibSIEE3rIEOQ0MrmkuKOIEU9x2KlSj0vp7GoVW20zCcK+czF0B2Ug9d3mZZPV0DEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=370FzfYg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b40c7fd8eso20625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727805660; x=1728410460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjfzTjPgLCnOCOJF0AMdN0inZLS6zO/4QzB2WyLqC4M=;
        b=370FzfYgmqheUDX9kjEwys6imKcIfMr2d5mH5PimgFKa8f5Kn0Z2Sm/WJTOQv9Zker
         jw6b8AiXC0PMLNpcuEXWbt/Bwp6qF20URj0c9x2qcPfv8OuZdoKL+ZmmszhHXIXFJboE
         5hoQI75Nhw4HbDqJsuCTYGUEd1T2Yt4PH04YeKH22QtmaiCXVxvzkwfibC7BQ+65L5Yu
         HYiLVEm4KGxQq43B1xlnz+q8v+D26jcHmWfL/Jn3CFbrylQ7h1jiN0W+qMD9KzaodpkC
         2sC68qF/md+jOPDyHK+mUh3849WXICqt6MWyW0OXEku0RyQXWDU6qlW/KMOf2U8fKFy/
         n4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805660; x=1728410460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjfzTjPgLCnOCOJF0AMdN0inZLS6zO/4QzB2WyLqC4M=;
        b=QNxWl+XCob4u0vuY7oGHoiVz6M8izVz+bZSZPNGcjlJfiQ3HveBiYuvoaAS4shVS1v
         n7hld0AUw3hYN0+ex42+tkj2R0EfXrbiKF8JtXVp25fBHeTLnzue4AHhrSfRoWk9n/Jf
         xgX2d6S+csFv6NtvCf4RabL/YvhxBqzk1qgixRS40Ol/eqKriH1GClinrlwLGuw0bNhP
         wrsNaFMd9eBV+El7mvsp6bTPiZfN3pMuu8sDguTyS3qr591MX8r2DYuLCbpywjV+vsSi
         RUyDCn4tENO4cwmvisXjZs47Mx8msF1DxwOvXN4loxDS7CO/FYk68q5Hm307hQA6IRRw
         HPkA==
X-Forwarded-Encrypted: i=1; AJvYcCXyflRYJT+e42mliWIvcv8d7T3+DXTgTu1+AzK2TgcfF0+3XeZKF3Q/+xNNMGcp8Zrd2MnEWRB6/Zc/WBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaR0ZZRw56vwmOtDNmch0n5o5oG0rbOPtkUTF4/AjQN6MSKt2/
	DOR/R6WGifogCV4/dW/uAHBu6IqIXFk2ZIrkGpJg4eFDbgqvxnz74qAm2+doPIswbNnRDyZuu1K
	QSb0l+cyj7rsl4j+mqAxRj01lnc1xOpyB8b16
X-Google-Smtp-Source: AGHT+IFKX3B6h9UbMQsqjcSWNwq7OQStd0wsM4uq7rXlnXsOuOq/jKl73nPFIxrgnlbxtDx2zeQK6n65eWVYdWnpv28=
X-Received: by 2002:a17:902:f94b:b0:209:dc6d:76a7 with SMTP id
 d9443c01a7336-20bc6aae1a8mr162825ad.14.1727805659835; Tue, 01 Oct 2024
 11:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-9-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-9-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 11:00:48 -0700
Message-ID: <CAP-5=fXEd+m7WMi3JxTF8kA+jB7h97NT2Z3P87YOLGuvebi9qA@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf record: Just use "cycles:P" as the default event
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The fallback logic can add ":u" modifier if needed.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index adbaf80b398c1f4c..f8325247292112d7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4157,9 +4157,7 @@ int cmd_record(int argc, const char **argv)
>                 record.opts.tail_synthesize =3D true;
>
>         if (rec->evlist->core.nr_entries =3D=3D 0) {
> -               bool can_profile_kernel =3D perf_event_paranoid_check(1);
> -
> -               err =3D parse_event(rec->evlist, can_profile_kernel ? "cy=
cles:P" : "cycles:Pu");
> +               err =3D parse_event(rec->evlist, "cycles:P");
>                 if (err)
>                         goto out;
>         }
> --
> 2.46.1.824.gd892dcdcdd-goog
>


Return-Path: <linux-kernel+bounces-532055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20472A4481C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D2D3ADEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DC195B1A;
	Tue, 25 Feb 2025 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzT4O4LQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC61922E0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504189; cv=none; b=lDGU5cNBl7O8wYnqtxkZ41wDNA+aacB4/a+gdi82Y+hGEvdp0OnvPEXz8p7bSDZzVUsJ5W9E1LWpT9i38tRCyf8nj8ST452WR1zUoNQaUJS2xZNkMKhh59XV/e15ZLgzh0eJXfXFoMU6vVg1tX3NQn0Oaxs4UyDKpe+JcOdJxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504189; c=relaxed/simple;
	bh=v3AVXPBqyn/VEB9q398QPkPemqU6//8ktrFh466Eb/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/3zqcpOPYZOIRUmD/nfGhquWamITfr4qt0HFooLGRDM0TTJOfk/7x1W4qZikrLw6j57Cs6MC5zKmO3VyIDee81vFEr2NxwAYH2zIQu9+w5f617hLCj40KQao7zHmgpniIXMQmZzHStgCqu1mH6CV+mbsYGcJ4FGH7277d4hWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KzT4O4LQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e0575f5bso224735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740504186; x=1741108986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRS7zRNsUBaTX8e7za4k3/mNtUpQo7uf5jo12sCbNZA=;
        b=KzT4O4LQEy5fJt3mL2+Ty8w968WcvvQXtIVbGdoFQzQQbOb9IrteXum7PrX0jYcp+m
         eYhmWtCqaKYwsgqY5oUCznjTIvyeCG1W1lWBaqnNTu5ZMTiHVg823tW7EtI7uPbBfZMc
         LeSz9WWOr0WvpmRVwrNsB0gg4/cJVUPokIhxt+VBX8UdzvZh+NyLQqIIDLGqAQhBeGoZ
         fGAxu/kFHGDaaH2NpcKlqpp2cIPjU4y503vbTvjSGeG+Onr/lTrlHSj8PrPpJZXtwfF7
         PPHzUZ975+xRDxZJVY6gY8Ik3VtNsx/ZP3cx46Z70X2Hgvf2OrLqV8UV1ikc/+LzpcNn
         Z8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504186; x=1741108986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRS7zRNsUBaTX8e7za4k3/mNtUpQo7uf5jo12sCbNZA=;
        b=BiVcirRG/BTgEhYiyhVUZHQgBlg5jvj5skX6yRJ5JTWKN829a92Kr0a2ySlrMKip36
         BrA9oHXQaDZjW8fVR74YN6SsdjUGlHSF8VqhvBHKW57R+Ay+xW/qmIvwjwonmzd95f6q
         iqWnxgEe0kZa3rrhwptfQGmUJc7i69LheBLye22qJH8g6I71R6ZV2d+iniQ82Oq/jQnH
         rQ/xDsS+weu9pnX01pC6xQKL3xYGlhxAFXRu9SUHfx3Y+hMJ5JYnpT72PZKN7Gei/46t
         N2Q05LrUp3H8G13pyDEYGEv+3Q+zX0BTyR+LTqiXWuXfY8WRd6MpNvUlmI0qSAH7x/0K
         a+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1whLNlne9v+8XLb+rNxH3S1gz8nnzE5HHtjya5j8XpM/IrrSkXuAZGu4dzLUMKn5KClYu/eUdxr4qeIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwubBJOMlx+DkOjbP1ym13G7h03zvnFJdBKu+/S5pZB1GLrAMSO
	GXZsRD3nKAqMsx4LW1ZYUDRndXwmbqscUfd1e7H0xVP8FxOQIm2MS5UIuMFepZpRwdZaatY0sS5
	nHdN/9Oefci0nYB1gi7nYGRpRFUVKhIHdwYtO
X-Gm-Gg: ASbGnctSKn4TWJTmridPyYABhZE6gBi/NcpP40svMkjY1qZFV4wvtQUWV99CHH6iZTm
	y3Bjihbfsbm26ZWo4krewgdpqTh6RVG+fXNjTZhjWE/szJm2+WYKiO2kaAYt3HJhIBqrVVyF/as
	808jaFYUyio0FVjForgu8cLmjLe2BHIuotxJ8=
X-Google-Smtp-Source: AGHT+IGC8PbZnAX1dM7vF/eknw+nIFz4/wdvAqDFmpDDAoGSei+HpX67HLH8P4ooCjMrPXiK2pEFl5M7Fgr02/I0jU0=
X-Received: by 2002:a17:902:d2cc:b0:215:9327:5aed with SMTP id
 d9443c01a7336-22307a98a40mr3749615ad.20.1740504185776; Tue, 25 Feb 2025
 09:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225164639.522741-1-james.clark@linaro.org> <20250225164639.522741-4-james.clark@linaro.org>
In-Reply-To: <20250225164639.522741-4-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Feb 2025 09:22:54 -0800
X-Gm-Features: AWEUYZkkYjNpwQEAg6yCL_UkAsz9MOXgB0BQHPDdqu5Op5Bsw52KT0TKFYbCsoE
Message-ID: <CAP-5=fVEQvP7viecoGzLyUv1_Dsx6FhvmrYakWgi_TrBXPGSiw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf list: Document -v option deduplication feature
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, cyy@cyyself.name, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Weilin Wang <weilin.wang@intel.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:47=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> -v disables deduplication of similarly suffixed PMUs so add it to the
> help and doc strings.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


> ---
>  tools/perf/Documentation/perf-list.txt | 2 +-
>  tools/perf/builtin-list.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Document=
ation/perf-list.txt
> index c3ffd93f94d7..8914f12d2b85 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -27,7 +27,7 @@ Don't print descriptions.
>
>  -v::
>  --long-desc::
> -Print longer event descriptions.
> +Print longer event descriptions and all similar PMUs with alphanumeric s=
uffixes.
>
>  --debug::
>  Enable debugging output.
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index c19826f218a0..fed482adb039 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -527,7 +527,7 @@ int cmd_list(int argc, const char **argv)
>                 OPT_BOOLEAN('d', "desc", &default_ps.desc,
>                             "Print extra event descriptions. --no-desc to=
 not print."),
>                 OPT_BOOLEAN('v', "long-desc", &default_ps.long_desc,
> -                           "Print longer event descriptions."),
> +                           "Print longer event descriptions and all simi=
lar PMUs with alphanumeric suffixes."),
>                 OPT_BOOLEAN(0, "details", &default_ps.detailed,
>                             "Print information on the perf event names an=
d expressions used internally by events."),
>                 OPT_STRING('o', "output", &output_path, "file", "output f=
ile name"),
> --
> 2.34.1
>


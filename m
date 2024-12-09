Return-Path: <linux-kernel+bounces-438197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752429E9E18
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CDE1659AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A927080B;
	Mon,  9 Dec 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cy9TP8Ym"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71A14A4DF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769347; cv=none; b=CFrKFt3p9Bf+2hzTZVnpcjHmssFI+/4qESjTNDEEWqYkEOScgC8ySPgtHqwl6yBPQ5EhDlOcId4lNUbOs0NVkosmtd2xhBXN/DdNFltf97KR3SbEr+h1iwJi/DBI8qq7HVgCphM8OFL5cyq0VkLPAch6sU0aFBJITErfF1brmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769347; c=relaxed/simple;
	bh=s2crCVGsbkNLHyjtyH5LlpZb9Vc4P1rWIzxahEbDWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CQWF5fw2B0NTqA5JrmLT1pmhwwQIENbSxbMOWC13O1b7Cv3EgHM0I9EQuxV7Lh/emcsJgnQUuWbf1mBMYWJ8L9VgVWFTtumScQqRzjqEhqkQChGgW2c8NMXgwP8S0ikCrSc3uEMwuUqcUvzkn1Jfvq/DknV1k10ARkvw8l1R5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cy9TP8Ym; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a814c54742so472755ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733769345; x=1734374145; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clkswUKcnpDHGUyR9SCPANT3dNpNox/exTTbCbmsicA=;
        b=cy9TP8YmWzckPD2+EOiKp0zRhA1vhd4FAsQ24bBWkVdVMbn03OculG1FFLF3ULZ/M0
         xL/sREoshx73f0UUam6qWDzRFU94qMxN8ybN4+LoOmxH1mnjLScHn0k/Hz30V/tloXZ/
         YPLG8M5KS0IUaXhrJrLq5/FyKBXs8aQSic4wF7N3+eL/tTpJtGUZ0/IljYwS3BPZCSLq
         jxN3YZvxiL9IhXwTP/48bjLrGUL7HNBWRebisyCt0Z2mW5zbMOrmvW7nxX+ooSH0ubsk
         bUYfiQKGr4J7AhxfA6VQOAA2jZiUAwsCxiHLtauD/H8efVTzpjRkIRJgbhRrYD/e3wgU
         nl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733769345; x=1734374145;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clkswUKcnpDHGUyR9SCPANT3dNpNox/exTTbCbmsicA=;
        b=eFPUBVMmJZwOfzco6DoXDmumsngsBhsxyP8TTubHjuGugYv0pe8q8dVy2yOqJTSf+x
         z8inPxmi7bX/vw88PUucBipPix102Y8RXZNDsKmnxc6Mfg3jy4dpY4yW17qXJAJqFB4J
         XHdPCiI3Owd7ApXp/FPF4ZnueID+bHV6VsqPl+EKoUw0bPByZQmG6IY+nsrICQlu5YA/
         AY3II72nYhKLQeHNuPe2rCPRgwxvPGWHvQ5k+NUB5Yo9VMUHE8n+MzXKjGoziGC81w3q
         AXT+5RAnZT1tOvWnzgIh3IuuKlyyAGWSn3rzFDwGwsVAfj1oN1XCowk+lfAr46je0LQi
         s07g==
X-Forwarded-Encrypted: i=1; AJvYcCUr8v/xIWNBBqPOm54K/GNW0PhiGSz7SIG1q7VCaDhHcpY+Ju1DyzY7cHCq674bDx4KMMqaNmZT9dJtPpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpV16/VlRVAqqfOTDBCYuDXqZ+FFyy43gx5fX0pZrANRCR2+i
	GskJ+Ff6x944tVSOwDbTMIM0mFIX1dTjuVX8B764enkgfvZ3yph5Wxln/3tLbI8ksBx39pyy+Yq
	0/xWupJ9YdPGSmMLbHFg5BoaRZRIqBmfE3A1l
X-Gm-Gg: ASbGnctQV7aGFnBN2CMhXyiIajKgWzLby8PQLsQWmTs7s2MZxUVl/DwUU/l5kNyJHTn
	G4171xZ6u8iWFD+jKA3Ur1hwt7lrlSf3Y
X-Google-Smtp-Source: AGHT+IH0nETxj3bC6CXrnWVkUCIleHf1QkS1NBVx0YiEYo/SjprKNunQQ2biLtQTgwxMTa06DCdU6zc0mKjwiwuYiwM=
X-Received: by 2002:a05:6e02:3f8b:b0:3a0:a34e:9ab1 with SMTP id
 e9e14a558f8ab-3a9dda2e467mr44285ab.8.1733769345035; Mon, 09 Dec 2024 10:35:45
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113165558.628856-1-irogers@google.com>
In-Reply-To: <20241113165558.628856-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Dec 2024 10:35:34 -0800
Message-ID: <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event descriptions
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:56=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> For big string offsets we output comments for what string the offset
> is for. If the string contains a '*/' as seen in Intel Arrowlake event
> descriptions, then this causes C parsing issues for the generated
> pmu-events.c. Catch such '*/' values and escape to avoid this.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 6e71b09dbc2a..028cf3c43881 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -430,8 +430,11 @@ class JsonEvent:
>    def to_c_string(self, metric: bool) -> str:
>      """Representation of the event as a C struct initializer."""
>
> +    def fix_comment(s: str) -> str:
> +        return s.replace('*/', '\*\/')
> +
>      s =3D self.build_c_string(metric)
> -    return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
> +    return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
>
>
>  @lru_cache(maxsize=3DNone)
> --
> 2.47.0.277.g8800431eea-goog
>


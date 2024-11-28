Return-Path: <linux-kernel+bounces-424077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612DA9DB067
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1317E165830
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26CAEEDD;
	Thu, 28 Nov 2024 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jn9ob28B"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5443DDAB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755089; cv=none; b=PSkx6LkxH1m91OVifGOTdtNvVl6J4Sj9DLhS9O6zth8qEst5U5qzdSl4yfS9Zl0FxY+9ghz6qRPCNA0P3IRJuiI+LT5NWkey6Ordva3gRPgCjMrlvIYWXLSWKzjr5egmxmNbTZw3mLbSOhWFAsymWbADz0njF9JYJAhi6gvg1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755089; c=relaxed/simple;
	bh=ECzqOYYQAwVhTqlgToe4cHCya7AUIwCJKbeWDaNywYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us+zjEFOEUGORKG0wHYRXA1rgM6YRQ+N3omqi3nXuYxtr+lrvocJHr10OXVFm2grWdx8Cz8+luH/Cb3/431ZVPUU7C/fFLV7SvihycNI5/surU1KEluWVSIfgoQ03AS+z2A4bmDqKqNJONkXTyjv6aeaT/+QACBLaudiTIWMhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jn9ob28B; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a762686909so17745ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755087; x=1733359887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLiTfyzcVcR229K1ikE+nUNAVjEsCa37tEiZKYXv2lw=;
        b=jn9ob28B/xGdJmPVMpOPUoi2kBZyYoGvIVz1EU+IIxivCqeOATfkSyeKHAM0fhvFI9
         7rwSMlifur9ymumtKTgxz8tUHDga86zXT9CWPvwgOYPs5OH2+B9CIhR/688Eaf+K02Je
         KsG4lTmnxGyH0U/SKKBnznmxb9zG5OGzzxZ4Y2VXRSu5uboSFwTv0mhNBzU9Z8X7gfBO
         yQtFd3SA1WKtJVMpju7cDB1If/nwE9JhDI7iAe3JTOU3QRpLQCERKMwqXfBMBN/IwsYr
         qBdiZuXeodRiLkAhV7UlVs3FtqwjYZ2dR895DSFLy5Iul93SEUof5edIjM0aIV/bn+rv
         YXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755087; x=1733359887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLiTfyzcVcR229K1ikE+nUNAVjEsCa37tEiZKYXv2lw=;
        b=VVtFK+Em9ytark2HN0rdp2CnMi06RmTlO+3htJA2Umrd6qsbZ1Oe+NaS0Epcf5uXq5
         G1KEPHBLTmPJRgg85cPBH6YDgXvIF9D8b98goYXjxNLykyHPUZw6TWnjQgdbWrPvndKg
         EWSWE000Zh/JMbnXZhuN+5vMC/OtPo7M825cS0BKOEsmGWSyHXIN8YiBhdpjp9/MpBkK
         ylq2BJvAMt5OrBMR+lkLykW06jwcF5Nwva3ubNuaKHaez6EixKqvNwaHhAE6rElvReiZ
         6QD2NOorkhQwjapm1sPUIxtqwF2mOgkTgHyFRVmxGI51G6LuxSkyu+YkIgQDU2RBp1vy
         gDQA==
X-Forwarded-Encrypted: i=1; AJvYcCUBI3re/D/IW9Za5CXO3IDpdjlaF81xhq9pAF1js+PDIO3v/OuK5HluN1WAJASR8QmGgLk2iWWOh7E2hmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDOGplhs/+w4iSlKgZChhDs1Tg2at1Dgr3YalXJN8fG98jJKT
	kSdWQ0JnXFY69/UFmA7icJ8uo67AxTLz+ezugvhyHZGz3Jq+iiCIcigpaSGo2zRAf5E3OxmZ8Zy
	dEhfUZd21MYz1buwxsdGRWNo5fsJxdvGYyTQF5Ymph7nmW7aUBkz1
X-Gm-Gg: ASbGncuxafMq6ZnGaGurHl8sR9CIyK6cJ10yBJ+E7vRgAelZIFoQTv96mzyePx4O4qq
	fWAMNlDqfyUMwYYxu3CqGqYn9be2b53oY
X-Google-Smtp-Source: AGHT+IFYYY/jzwMxbpREcw7kv5681JgWs2h1AcFGILJLSJy6Q8v7Vw6m81BiA57DXL5QIpwW2vXmFB1stsbHdmUFXMU=
X-Received: by 2002:a05:6e02:3f88:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3a7ccfc4ae4mr454235ab.3.1732755086493; Wed, 27 Nov 2024
 16:51:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212655.922196-1-namhyung@kernel.org>
In-Reply-To: <20241127212655.922196-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 27 Nov 2024 16:51:15 -0800
Message-ID: <CAP-5=fXtL-MFW5YW=5WsYNftCAj7MaXVwN8R3veuiODiC85bdg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Avoid unaligned pointer operations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The sample data is 64-bit aligned basically but raw data starts with
> 32-bit length field and data follows.  In perf_event__synthesize_sample
> it treats the sample data as a 64-bit array.  And it needs some trick
> to update the raw data properly.
>
> But it seems some compilers are not happy with this and the program dies
> siliently.  I found the sample parsing test failed without any messages
> on affected systems.
>
> Let's update the code to use a 32-bit pointer directly and make sure the
> result is 64-bit aligned again.  No functional changes intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index a58444c4aed1f1ea..385383ef6cf1edaf 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1686,12 +1686,16 @@ int perf_event__synthesize_sample(union perf_even=
t *event, u64 type, u64 read_fo
>         }
>
>         if (type & PERF_SAMPLE_RAW) {
> -               u.val32[0] =3D sample->raw_size;
> -               *array =3D u.val64;
> -               array =3D (void *)array + sizeof(u32);
> +               u32 *array32 =3D (void *)array;
> +
> +               *array32 =3D sample->raw_size;
> +               array32++;
> +
> +               memcpy(array32, sample->raw_data, sample->raw_size);
> +               array =3D (void *)(array32 + (sample->raw_size / sizeof(u=
32)));
>
> -               memcpy(array, sample->raw_data, sample->raw_size);
> -               array =3D (void *)array + sample->raw_size;
> +               /* make sure the array is 64-bit aligned */
> +               BUG_ON(((long)array) / sizeof(u64));
>         }
>
>         if (type & PERF_SAMPLE_BRANCH_STACK) {
> --
> 2.47.0.338.g60cca15819-goog
>


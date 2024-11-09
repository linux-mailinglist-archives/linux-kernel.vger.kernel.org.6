Return-Path: <linux-kernel+bounces-402595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F59C297E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE33282A56
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DECE2E628;
	Sat,  9 Nov 2024 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5YBpNbN"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB592BB09
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119273; cv=none; b=h1pi4SlvPqssyXRpkbGNPfl4v8YxLM8a2KIb5bhUoJMJ52ZsWS7/5+NMb8slY3CytFqPvxx1AIteqOrsGFt0tE6bXn7fHd7IRga1cnaPdlbslIfJsZ3NFa2T8dM80ZQ4LJXtxiDC+wKgjlg5f7S1ZeE1c1aTMxP5AGEuXD5M42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119273; c=relaxed/simple;
	bh=r4II/EOANpjkik7gih8wrK4svfpWdxsNcpftzmVUHSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFA0gshBRSBWhHu1AgB9YYFV1+EUlOhfvzkas9Wx0gEEk4yrHgyQR73yivdSp9sOYBmwNxnlW3qVfsuu1Kq5PRMaHM0TH9RHsVb00AKQjzTaPgxwHsLBUXnaiObMn/OqifHLJVWGQYgdEcu9wsIdJOqKb0jRE9JedqW/+bG8gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5YBpNbN; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so51135ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 18:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731119271; x=1731724071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbrhjKf7R7Vkeazhqp6cKcRj3efB5Nxd6q1xKyiiDUU=;
        b=b5YBpNbN23yFRwSPoh5HO3ArXLO0YZrKH6GJj+bF61MFJIfCZSi/LRhRQ/ZEGlJUsZ
         p4BDOLj548gS3SEmCkOGhkqm958gjCD5AapodY22mKDHpd15kwPzxU5Uly2RonDUMcek
         SeyNv2KEzhsQHc5d5hukWZCKMLTlokFYZFfCHi0MjKOHKohzpijrewff3pZr6/99F1Su
         yxpiWl8ZZiOmUF8Fniqz4MaBOybk/AEKA8ZsG8gOk+2WamMloWjB02FSLN9Hlsa+LHeX
         fr4JGnK26z9GKtlURPfnsl+mdaa8xwM+jIHzNQKtKheI74S/euDopGQCeXNujON1dRiJ
         IEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731119271; x=1731724071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbrhjKf7R7Vkeazhqp6cKcRj3efB5Nxd6q1xKyiiDUU=;
        b=uSgxDW21BjFsYPLvbPCUzUX06dTcmPpbVDrzADCnrkr0sEr3LhMvJ9umfEJZzEt4cZ
         XhjRvikfsG/DfdbPrHxytowA25rvBRqqTsKhIZTzBS8dUZtBtBnnPUJPUmmOO3RBMcyb
         jL93ASDOFiBn0n3XkeyqYtrWFSIKofdShan3/lPoOur9u1/4zXRt3mmjoXuzgXT+nvUo
         SrG1JbAiLd4iwh8Hu9gM4Wqtdar2tvm73WgrzbvavUZ8Bcw+CloPdK5Tj3omaKScw6xh
         mGKDwnQ6KgBkovqUDDFO8cLLwZsd3awlTCfruIG/EOyjWLq8RNlCpAhr1dkE4MZretEj
         fl9A==
X-Forwarded-Encrypted: i=1; AJvYcCXyKlt1zH/D2Xo03lAEtnliqd9GXJxcFQCRnrtLK1nm3zKfKtH03pvHsHAxX3vio3Z/jqVU8PpJQy5FMto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSMwt4NAO9q39tSpDe1k0B/a9CllwRfv0bzlo19q3R/kIcHqpF
	29rXJ09w0qKsCkQcDm67O05ZvJKzSAZCCoQvZNcc8M+sbbFHsb0BJbuZl0cI6HIP4Bi47B7cT5G
	+iPxFr3nMbIwRr10mmhh8EgwoBvrdJoogfvwf
X-Gm-Gg: ASbGncs7LLZuFGAwIuzfiFtEbSV0fX7Mhiq1ejBuxS8nWcbquCxbOhkrLAsOoA+AEOw
	CpNDoGg1mFreDuRW0RjqOwxLlZFISikzs
X-Google-Smtp-Source: AGHT+IE4bPofVUDUJBBK0UGhNtwd4D19IvoNAsJlrxj640cp/4ut4uqLD0BeAyhWjUdYgVRiqXg0l2Ob2aHkx9Zi4wQ=
X-Received: by 2002:a05:6e02:1605:b0:3a6:b0a3:540b with SMTP id
 e9e14a558f8ab-3a6f8a97e8fmr1188605ab.20.1731119271162; Fri, 08 Nov 2024
 18:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108082959.10319-1-jean-philippe.romain@foss.st.com>
In-Reply-To: <20241108082959.10319-1-jean-philippe.romain@foss.st.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 18:27:39 -0800
Message-ID: <CAP-5=fXd_J29XZchia52Bxch3h0Tz0k37DOemLLYdK7u8LBADw@mail.gmail.com>
Subject: Re: [PATCH] perf list: fix arguments order issue for events printing
To: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fabrice.gasnier@foss.st.com, alexandre.torgue@foss.st.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:31=E2=80=AFAM Jean-Philippe Romain
<jean-philippe.romain@foss.st.com> wrote:
>
> Misalignment of callbacks with print_event:
> - pmu_name and topic arguments to reverse
>
> Signed-off-by: Jean-Philippe ROMAIN <jean-philippe.romain@foss.st.com>
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 65b8cba324be..c5331721dfee 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -112,7 +112,7 @@ static void wordwrap(FILE *fp, const char *s, int sta=
rt, int max, int corr)
>         }
>  }
>
> -static void default_print_event(void *ps, const char *pmu_name, const ch=
ar *topic,
> +static void default_print_event(void *ps, const char *topic, const char =
*pmu_name,

So it looks like the call sites are doing this wrong too:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n504
```
...
print_cb->print_event(print_state,
aliases[j].pmu_name,
aliases[j].topic,
...
```
I'll review the call-sites and send a bigger change.

Thanks,
Ian


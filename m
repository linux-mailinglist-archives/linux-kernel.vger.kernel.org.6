Return-Path: <linux-kernel+bounces-376688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D519AB4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6811D1C22897
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDEB1BD4E2;
	Tue, 22 Oct 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxjpZ8VZ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934B1BE245
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617682; cv=none; b=dsIgPP/cO2tPAceuN9xxgJ6hjdnK/2HOXTWpo6atvh+62G5KfxDoKH3HIpmdIP2vAMHFRuwMS4RqwqXTyZJQ9xUtwRsAXKWVpN9E4UfACVHHuYVFlRD9EJQChkXQsttsmzL0dRXNbVvCc8Wy2B9rRDCIOfgPPuJUrRJxbSU+GoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617682; c=relaxed/simple;
	bh=b1CGs5gpBNBkiTDp2Q1qyoLrLUaK244tosMToWA6kRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H//kRxKFoucgZpEDSH1SNiF9XX3HD9BvIK/FHNPw4cEJhaLykS88MxP5LmPMfjdYn2ZoV6YerNqEgPG0YER9oVPn7TWy85ppnlIGWM8XyV8pVWnj2Z98v9/W48934pGC73H8lknFpYO19ONjOvhBhFQvQExspzTMQr9HQ6DQau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxjpZ8VZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca4877690so9295ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729617679; x=1730222479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZM6LcuJUHveMyLMVTScG2H/Hgd1xFmDZWDJH7F3T90=;
        b=QxjpZ8VZ8zuOOfzNt3XlufbVHbyarZLMVnUOehiazHgWmW/kjQ9w7PaKKKxlhIVuHb
         kpyttd/mI2wHl4DZMXW/yED3XXB1OsWST5BsQMjaslzuE54rmoztmw5Nux0xQK7ox5pN
         gzvYydYF3Le32Fq4N/Rk0QA9n3TKBT8Ugp148vJ2kpDZgCIkCuRSO+blBUKt2g69SiM7
         XlEU5bY6+grCpJOLYKpFp4nt7Qp6eJGKR2MXLb/T+DlGInrToEQ4hIm3KNy56YLy8YkN
         Hb6ANq+1HRJoWf85riS/Fx6E9S4E6qTIqG8mwRnTg8YD7HLvK6CtGcOVXfUOb20+E5Tb
         1LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617679; x=1730222479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZM6LcuJUHveMyLMVTScG2H/Hgd1xFmDZWDJH7F3T90=;
        b=r6y9XaVD74sC+uj3PbsPN4ntc9qu7uqkNYTModr8wCkcaGyaWjUE4bTf+/ihZlq3Aj
         xUruLFup77BjKNXB0mNxNOAUNFwzPd3mLESxxLlHpUTxGqCPc47hP1jgg22rSFAq1vzm
         ul39rPDQS8UsmRrcIDeEdAzino7WCNehbD6KvUkHgIvJci7lZsRQJtMGY3TXYGgbISnd
         OVTVj1DI1feKLLizCGGq6Ns4Y2LlQzlxgJZxBe7Dk9h9FrlWN7W6ZAumWs8K5g5+JZ89
         x0mLYZQlSp+c0JL/zzCrb62URqkeOtJcmItjSqrJUoKDdQvo6mAPQEvacBWNWp0+ZnAj
         9YYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoPwkEo6tERqPAycUfXV8nMV8w5oyAA4LR4ZOHfOiYW6DWck/zAGfbulGsQMJAO95uEEcwggfXGtZLaXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfoyj2Q+ggZhlul1i7V0Vi53yUVf64LEd7s64RSbfLOVZEv+iX
	IiahbOrhB8x5yVWf5kLu41r/KUlW2h4YlmhXlrkr4l2ye3BJrJD4vbBl8ZZmwgI3O7yAj7jOsNU
	2MQqxLKZ4Qu36jZC2rSw6a4y5CqWl0PtfKmaX
X-Google-Smtp-Source: AGHT+IHS9uM8Xo1yuRSba82XgJ86Gi1EmrgIM4rxPyqQKJRmoDr44vwEofb9Y65MfBbw6NLyhZffbqJpvx8ZTBHl3x4=
X-Received: by 2002:a17:902:ea0e:b0:20c:bb35:dafe with SMTP id
 d9443c01a7336-20f80c9f411mr31535ad.0.1729617678531; Tue, 22 Oct 2024 10:21:18
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com> <20241016042415.7552-8-irogers@google.com>
 <Zxc-bFLNAh7nrVQC@google.com>
In-Reply-To: <Zxc-bFLNAh7nrVQC@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Oct 2024 10:21:06 -0700
Message-ID: <CAP-5=fVNwx7D4N42hDeBQMopCuoW-Q4BUch6am8X_jJDeFDy7w@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] perf stat: Move stat_config into config.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Oct 15, 2024 at 09:24:06PM -0700, Ian Rogers wrote:
> > stat_config is accessed by config.c via helper functions, but declared
> > in builtin-stat. Move to util/config.c so that stub functions aren't
> > needed in python.c which doesn't link against the builtin files.
> >
> > To avoid name conflicts change builtin-script to use the same
> > stat_config as builtin-stat. Rename local variables in tests to avoid
> > shadow declaration warnings.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
[snip]
> > diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> > index 00adf872bf00..9712466c51e2 100644
> > --- a/tools/perf/util/path.c
> > +++ b/tools/perf/util/path.c
> > @@ -68,6 +68,16 @@ bool is_directory(const char *base_path, const struc=
t dirent *dent)
> >       return S_ISDIR(st.st_mode);
> >  }
> >
> > +bool is_directory_at(int dir_fd, const char *path)
> > +{
> > +     struct stat st;
> > +
> > +     if (fstatat(dir_fd, path, &st, /*flags=3D*/0))
> > +             return false;
> > +
> > +     return S_ISDIR(st.st_mode);
> > +}
> > +
>
> It looks like an unrelated change.

Yep. Should have been part of the previous (patch 6) change.

Thanks,
Ian


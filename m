Return-Path: <linux-kernel+bounces-565102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC91A660E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B82189D479
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CB201278;
	Mon, 17 Mar 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJeiuTHK"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CD8C1F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247954; cv=none; b=Rs/yAabcot6zZEOwlCK2BDnsBA9TIVeCs4dlq3V8O2weNHS9aIZOfBob3U57T4QjYemMjTzY2PysIb93gGYiLYeRCF1uzFcS3AxuyavrlhL1tXB0uEEGhADhl3DicrGODEwI4O1rCjANC178FXyf94Un6FfD/KxxMR7+8Z/v7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247954; c=relaxed/simple;
	bh=zeNC7bWh0psVEoJto4+K4TDFocNWgBAus0XwkQq7PtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm4T/QLEQLB8WuvA78Jnhmd9y2B6YttSeXmbis3YoszRIdUo4T/1Wv6uBjVW22OEp9ms1bIGReUAnJP92H6E9K365i5BuNx/SIDs1RRMbZ7OIIVYbUqD0x4DgOwr2DIKfIhJ7nJ1UMNuUIWhmhl/KI3QJznGK8doh7KVrtGzqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJeiuTHK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abf3d64849dso808555266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742247951; x=1742852751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ML1DoU4xjPV/CAXxytjqLcAmMi1DuWz/qisu6b0oJ0=;
        b=lJeiuTHKNMPDw2fZDehjnxQvodfr2zh3UrLUEXD7U9MFat0OqbYh31UzbmK5zyhZPt
         BecG3ojFeqeBK66E6lPRYZfD5bmWZAgopHeqhLljdes8vWYGpcOHbscUfiREYSQxcV4F
         Ar3kW7J3tzWdKRaztgEuJkW4afWNtC1y5dNeYpOqCUKcj1CFiMT0GRhuRErJASKlxKs8
         Fov7R/HtWuksOge61gbfhPFhphenUY+md1VJUuAi7WxumJPPsUCkAfm7Sn1G9Ynj4uqp
         hzz4eaZvTDbIaSPLAwDOtUAST/q3GyoMZ0snRh7OYXLe58tzGQwoRXc0f7QaJu1EOGoI
         +fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247951; x=1742852751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ML1DoU4xjPV/CAXxytjqLcAmMi1DuWz/qisu6b0oJ0=;
        b=sNM7/XnECZXTNPC8LQznl9tQst0AfWSKDu81VI3HtTh9igsNkUvdkL871Be29DGwbS
         bD7Y077gUb3NBc0ltMiD/66bQOZ+EWWGjWCxnvZKHUhefZxo9FP3veU3KO3Smo2RSPQA
         erDrpuWwX0Xp82cNm6WmEP3nXaFVYHVlXTzVUnm+gX5rUo4uTYJSpSvqug4lKBjkKrVq
         xpO+Z6shQ+PBOjmIMorQP2g1QNSs6ncYwocvUladY75taxLHsLWYUFGFLHFk/4dfv9Qv
         f1V5CJDohbbBhvW9Xwpi/TOR1VsE/8lfdmtitwWPiMNmiQatK87nrrsgzS2+ou3JI2rE
         FBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe59pKgjRQPfehVRNyzCzB/CYdRJ4bZTfZ7Ma7sB6uGwBHhbMPdbSohhz+o7RsOpQdJel4Kjt5hkzXvFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiRMncskrR53X14tUFG8R4JMHY+BkD3hXs2p4r9rjgyDLUZpO
	/RB2dWbCidkO4ZGNju/CAsFF8/AyiFALwZbuey/h59CO6WxSZqwxNtYF0AEwS63pbmaL3ev0Sge
	r9gqh8Hdv8/FezIl1tWbZQSIyPBRvFFblhuVB
X-Gm-Gg: ASbGncuErBoVFp4dTbkhGr6T4Q5ib7raQlyQPQCnt0giNUYNMKhCOC2d/bgTghb06a7
	vhaZzeFfz2jQaVZr4R052Sg2GVOJZX/DgDHQvo99jZ/NzxRwAASmIfSblzDmLewTdhYOZ4+6KXn
	g6adRIVX9h9uBotYr7q8uO6L4uiuxQ5aNsulcU+/zPqZE7RxecDTkE5UyDDQ==
X-Google-Smtp-Source: AGHT+IGoTQYSTsn1rW+dXX8gjG0kqDLCsgJMqqwLrfNO+PwBAz+FZdEAPfikbKqLQZ/bH+yKN6q47iCEmvAIDfgUt7c=
X-Received: by 2002:a17:906:4541:b0:ac3:45c0:6d08 with SMTP id
 a640c23a62f3a-ac345c074b8mr1024706666b.0.1742247950838; Mon, 17 Mar 2025
 14:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303183646.327510-1-ctshao@google.com> <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1> <Z9hLKsZOfouM3K7H@x1> <Z9hR8M-SQ5TD2qMX@google.com> <Z9iHiTv_ud6GEhJh@x1>
In-Reply-To: <Z9iHiTv_ud6GEhJh@x1>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 17 Mar 2025 14:45:39 -0700
X-Gm-Features: AQ5f1Jp1Z0tscdVE63VW8QSDVwa8l2BYdhLMyytFhnJz39Xwk9sGkFUrMFXGgYo
Message-ID: <CAJpZYjXwUz7x1XUF7AzgYR6PZo_igrwK9BkxGx_3N0pCs1YRvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	james.clark@linaro.org, christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:35=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 17, 2025 at 09:46:40AM -0700, Namhyung Kim wrote:
> > On Mon, Mar 17, 2025 at 01:17:46PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > Checking the discussion and the patch.
> > >
> > > My first impression yesterday when I saw this on the smartphone was: =
how
> > > will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will =
it
> > > ignore it while emitting a warning, since it can be skipped and then
> > > what we will get a partial view?
> > >
> > > Having some session output showing how an older perf binary handles
> > > PERF_RECORD_COMPRESS2 would be informative.
> >
> > I think it'll show the below warning:
> >
> >   <offset> [<size>]: failed to process type: 83
>
> Right that is what I got:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ perf.old script -i /tmp/perf.da=
ta.ck8
> 0xbf0 [0x250]: failed to process type: 83 [Invalid argument]
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> I think we should change that to something more informative, like:
>
> 0xbf0 [0x250]: failed to process unknown type 83, please update perf.
>
> And then does it stop at that record it doesn't grok?
>
>         if ((skip =3D perf_session__process_event(session, event, head, "=
pipe")) < 0) {
>                 pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n"=
,
>                        head, event->header.size, event->header.type);
>                 err =3D -EINVAL;
>                 goto out_err;
>         }
>
>         head +=3D size;
>
> So we're stopping there.
>
> Maybe we can just warn and skip?

Thank you Arnaldo, it is a good suggestion and I will work on this later.

-CT

>
> Anyway, the series as is seems ok.
>
> I'll test a bit more and send my Tested-by
>
> - Arnaldo


Return-Path: <linux-kernel+bounces-340983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC09879CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4D2286CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B8C17BEB8;
	Thu, 26 Sep 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gn7valET"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135AE175B1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380532; cv=none; b=lrL7XNT0adGZ6t9akMDiaPERxfe50cbEufz37i0U+FouEzNe2Ax61la7dO95r7exvMddW6I6tURV9XFSa6KyeqrDiGs+FmaHdgJ4qNND/4iHeK5T94GV0jGhE7tahCryEVbQhEXYyYdjgtgJs9hJld4sdm/2RP66BG5BYnZAlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380532; c=relaxed/simple;
	bh=lBd5mJe6k/VAIV3m39ptxOGSOCwzSN+UkymqdQWr5e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNtOALdXJXpMGXykNLP4X6LRTfsPOev1vPCwCJh8RDIo13XVTOx9Cv6XVTvAbOieXziKMNYUGCYVGpbFd/4+hKHU2Z5Tq1qG6UrpKV3L6fpYXHEatvyAA/bG2vO952EFUieheowLYWgMUZjDzBZmeXK2oZG2DYazTC9tTcmip6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gn7valET; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a2769d774cso47415ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727380530; x=1727985330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiDFvKDJ5+dCBHfNJ1K7SK22sj7fM9aEUAoUFxxe8R4=;
        b=gn7valET/Ji24T6t9dNqjaF3mqJ4ldwAk8PoPU4i1maD2iYJ3DCYFAmx7/ZpESaMPv
         YrS0TMSChF69dupOdzk78Fi/QSviodcEn4m5cNu/m2ajo3ztYnp/Fdh9NZ6Liy2M4sdJ
         nQ1yng/RkvVQDkV91XCNT7TVnQcesuIZATJICJnInkGUdWUjMHXhQZidLdlhaTkm5ytM
         snEfF1LXaIAP4ScDoykCckPlL7PAP5HFh6pEJfQKVcJda6ZVR0fnpOdwMJMlspwBDRot
         WYRp1Ju/qZOaQrjoFLZlIIM8oki+inPVop4jSeoyUt82YlI9SPOcYbZwJz28GXIiblmH
         LbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727380530; x=1727985330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiDFvKDJ5+dCBHfNJ1K7SK22sj7fM9aEUAoUFxxe8R4=;
        b=jouHIHfXfUyTNeb3wXJhfJ3c/5gWvOMMDnTsyMQQSDT0DEK2961Y9jp4szHAK1TLH6
         e22r9KBfBUch7RferSJA0iLjyWBt2GWncmfUlyI0wE03aNjL4aTIlco2H2wd/VeU74Gr
         YrnVOoQYoIaNTeT1h+8y12JYFUpS8V9P17/XIpyUyi+K8NZvbHa+ts10t5o0ipFE/zYs
         LVGOUpW2cJQ1625kpC+M4Rjldv9UTJjlYo0GDEd0zlVUXBqmfFs1UJ30cZt+LkT6DxpP
         ioxckmldquYQ9BZmF180msvwE90FoBARbbXmcW6JV0VYCMHLM9MWnTsPnyo3iR7VbQmz
         j1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXZKfEcGKZFlRP0Ff0JSQB49TfeTQVhZA+wgpyXwZ1o+RRbO4DI9jjaF+kfARDdcMDciW7JXZ17JeQWzGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxS3QNGv9x80wLPkCSCwHlJpzKtd+7llBXqqirIKlUYvLZCYy
	G3QEwWfsz3ytt6WtYr9Pqa5B80Or+7/PbutPwPMWRBe0SnLoLCejTsRN4S8U1ehPhpNflf/CB7E
	I4F3+CIzBzouAYM83OOr62W4MaEZRIDYI7BOf
X-Google-Smtp-Source: AGHT+IEgvN2hF1hcHycMVhWDzye/+BvTmaUsr8C8ylFCp0KWa9jQUiCY1PjtJKyXKGx+KA80/c+6igdUKeLYVyP5RMA=
X-Received: by 2002:a92:c26a:0:b0:3a0:a9a3:8a74 with SMTP id
 e9e14a558f8ab-3a3459f71d2mr631385ab.15.1727380529874; Thu, 26 Sep 2024
 12:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com> <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
 <ZvW4iZpTinJKWIFD@google.com>
In-Reply-To: <ZvW4iZpTinJKWIFD@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 12:55:18 -0700
Message-ID: <CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 12:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > > The name dwarf can imply libunwind support, whereas
> > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > > > make it clearer there is a libdw connection.
> > >
> > > While it only covers libdw, I think the idea of this macro is whether
> > > the arch has register mappings defined in DWARF standard.  So I think
> > > it's better to keep the name for this case.
> >
> > How can the dwarf standard exist for an arch but not define registers?
>
> I meant it's about the arch code in the perf tools to have the mapping,
> not the DWARF standard itself.

But we guard those definitions behind having libdw:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/Makefile?h=3Dperf-tools-next#n3
So we only have the regs if libdw is present, not if dwarf is in use
for libunwind/libdw. Hence wanting to be specific that they are just a
libdw and not a dwarf thing. Trying to use the regs in libunwind code
would be broken. That could change but I wanted to make the code clear
for the way things are at the moment.

Thanks,
Ian


Return-Path: <linux-kernel+bounces-342039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAC9889F4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D04A281D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB5175D20;
	Fri, 27 Sep 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojVEYjxg"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C46EEA6
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460935; cv=none; b=bWOAoPGnFBXoaNLKXNlZsa2lxR6djx/kmaxsJuBv56Ecr76Mu8rrTFVImijBQ3z1njmQGDaCS1WtPcKeAOJ5Xr3rNah7h0v1jpZ+46yGP2iIisOlrZ7QH7MMl+cZ7+MTTn92pqJAHxSBWeV71RIW0dJLtncy+5oQ6GFUXaw6KQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460935; c=relaxed/simple;
	bh=Ed2AIMaX3f7BGc8MB2jzvog+jOEdaeMd9lnvnD1l0Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iw8/kjuV7VK+y6zx/gNlq5zS3ghokol38tF5ivgbu5LGpXUP8vOy81nWjnnEUPFV6KNGm60PRKio19g71+MV9p349ntIKjGPC6Rpdfhk2ekt7JRdriSXFFAQo/hgxZdYUJQOqpBZk12TqIinbufCD6lB3Ic+Tu4miCYdvJQsF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojVEYjxg; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso28815ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727460933; x=1728065733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msEXp9GhhjtLPFvzPtf34SEgy53Qncsp9L24YHMBUCg=;
        b=ojVEYjxgRYm9+4PS22M72/fPAtXikKA7v0eSF0rgUwMC/1VX3bH9UFvtPMs9IKfMbj
         j6rL57Gzf5csAqX2FQkQyaGDj5U2tAXQybrAK+HbYs+p9pGTZHmba89yXTopnZABUtYx
         SG0ilbeAsqOTHoHDNP4Fog+gj2DXZ9mZVFhs6lYMwDzM/TP2+6ZetlWR2JD5hNZWYB1+
         ZUgwY49OaHcyTEGjNZ7VS8kLjhGwju78O/2d2Dzow3UutoLigkkLEKM0Ug1FRWs3T1eF
         7H4y2UcXkn5TvlQh/5MGRC7xARucZhaOQWFgPjfJSjmU33l7EbtTQWLbCBCJc3c9pwx0
         6jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727460933; x=1728065733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msEXp9GhhjtLPFvzPtf34SEgy53Qncsp9L24YHMBUCg=;
        b=l22iljVxvBDs3N92Xt5dv9ikSC4CXfrX79h7ICxDwSe/nY5p3dyRFrt+eWN/mssp/t
         33CpES3ilaDRCt6i+blPSJz2wWCf3XP8bQ9z/Vox5yGQmaEmLM8Q6Bai+yl/VfpZjdSV
         pW96GZAzHjNfbVWhipdSx6GxAeDtQPKvL0kelJHmGtNmuCI/64GRB8e8G/5+NOr+z8Qx
         69QGNQCl0TAGr5l7bOdjBDqqXUWTmQ+EV8E1qTqkco7qam4cG62j+DX5AcwNGrSVbx9H
         X99KBOIJ6joGn6xFfq7IuzrAFhHzWdRBS65UYHSV8Y8st2ZQjqucSNBaYD549oh1jAP4
         5Y5A==
X-Forwarded-Encrypted: i=1; AJvYcCUtiJ/ARRLuMhqYCFlcYPBfmzJquWl+5zakISi2iQIQ+6PRhes6pwG9sUfIqekqwgIUIndBjgk1EV5i/4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4NfB7RBIKR+ijC1a2dP1394AIPoj+byvkucOTif/5fqiN9Z+
	rRLKkNlw0H07vLa1BiNnKRYY0stjRP1dwQdZPrqJQgX8gjQFTc8rMb+91FkWBnrtGYPOCYIPr2a
	tNsfvn/69/1djeeTTiG7DLBIN/4HUcvndukxV
X-Google-Smtp-Source: AGHT+IEYFhx2BEU0uXcjKj+UYSEA6hnpclc5LwV5KDdflfmvVe10tOmbv/cHHZsqgdwOA2Mjphu49j9diypFlUrqKuQ=
X-Received: by 2002:a05:6e02:6cb:b0:3a0:80a6:ae9f with SMTP id
 e9e14a558f8ab-3a34c1181ddmr121825ab.9.1727460933249; Fri, 27 Sep 2024
 11:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com> <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
 <ZvW4iZpTinJKWIFD@google.com> <CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>
 <ZvbocHwtPkwJwDOA@google.com>
In-Reply-To: <ZvbocHwtPkwJwDOA@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Sep 2024 11:15:21 -0700
Message-ID: <CAP-5=fWn6ejdozTt8GHvDkv-QW_GF5+b4C3kTO_544H-fXZ+0w@mail.gmail.com>
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

On Fri, Sep 27, 2024 at 10:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrote:
> > On Thu, Sep 26, 2024 at 12:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > > > On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > > > > The name dwarf can imply libunwind support, whereas
> > > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename=
 to
> > > > > > make it clearer there is a libdw connection.
> > > > >
> > > > > While it only covers libdw, I think the idea of this macro is whe=
ther
> > > > > the arch has register mappings defined in DWARF standard.  So I t=
hink
> > > > > it's better to keep the name for this case.
> > > >
> > > > How can the dwarf standard exist for an arch but not define registe=
rs?
> > >
> > > I meant it's about the arch code in the perf tools to have the mappin=
g,
> > > not the DWARF standard itself.
> >
> > But we guard those definitions behind having libdw:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/Makefile?h=3Dperf-tools-next#n3
> > So we only have the regs if libdw is present, not if dwarf is in use
> > for libunwind/libdw. Hence wanting to be specific that they are just a
> > libdw and not a dwarf thing. Trying to use the regs in libunwind code
> > would be broken. That could change but I wanted to make the code clear
> > for the way things are at the moment.
>
> I understand your point but calling it LIBDW_REGS looks unnatural to me.

I don't follow. Wouldn't it be unnatural to see PERF_HAVE_DWARF_REGS
in libunwind code but you are to some how know that the code only had
meaning if libdw was present? I don't like the implication that DWARF
means LIBDW as throughout the code it doesn't. I think the name
PERF_HAVE_LIBDW_REGS better captures how the code is, makes the code
more intention revealing and so readable, etc.

Thanks,
Ian


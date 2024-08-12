Return-Path: <linux-kernel+bounces-283729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAF894F842
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0881F22B65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16B1194152;
	Mon, 12 Aug 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNO7994i"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678961922CF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495071; cv=none; b=nifP4xGiUvprt7E8vJ9iSLeYlmb2lpPDjkgPjBI7KJs00iDebW/6pUjY/Srdso/ImBPJG9NIqtf4Ib4Q4r9u0fI/XWYGEeRmjjC15Ltk1Z/5vOB8QHc+IP3ZLyQ07K+SsEqQHoY6HUBcPiTmfmzGvJkFIYOx5jZFXEidpDAlyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495071; c=relaxed/simple;
	bh=o3pPC6oxhFHhBHNUVWgNOSTBHybiNc6Bsno294B961k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACWRJGysi8D9P0/ZIVfd2MMO6z0XpUM7i1flOXSBbdisSMrH21rVFkPBk6kUmFOGG+CrUj20erG84kwphaxaXsp120GKbCohD4lOenZGqRIFewvTZaqdibSaF4we8mNxBg9mZEpNMKXsHVdjDAysM/PUxOK8iXK2FqJIARGXzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNO7994i; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fee2bfd28so15321cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495068; x=1724099868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhQLFGtPpa4fkDkFPqrRhGxerNFpGi2RBLTu5Q1d7Ug=;
        b=rNO7994iZxNI+hyHdPBccN9XEf/aebT7qNQcDWl4REuld3vTzSIpE3+gB59+NDdswe
         eYKqCFu/g1NPlCVQFyGGZwywRTjkJpt8ecqWqtCfewbuhFlwkNNViE10Yv57haWNHbc4
         NtDNtfW0jPPg/8+jNnmYwCEsW+2Y7E1YqoyrkCyhBUcE5NSqNS3pGIavO0oDGHnvHOv7
         KIjldYzaQ87qe73jz7A36KuOuuJBxOK/clJfKCr4HUpfVGFhBMcU8pIsrvzJHjycC7N2
         oKkkYgldStJDCO1JN5m1NU/dWOUdSHIg7ANByYojbxU3jsbrQMCwEB8/d2KJ9qWzAIbv
         u0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495068; x=1724099868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhQLFGtPpa4fkDkFPqrRhGxerNFpGi2RBLTu5Q1d7Ug=;
        b=kDUQA4h1Cgf5nDR5xUKVryXtw1Pwt174DeJzfZdZHpXHGVkQnlVB1XMnHY1YFZs1Z0
         iF0b57E6HcbRfv68yb7hrZW7Ck4+diW2MRaYxSR7QSa8HjFGW6jQBsWPLnobmUQTgOk+
         GSctSILyNWtlDczZ1cZ/uTOqzHncGSfWhkJTj+PvVioqQhdR9t1wQa/hb3mhb+/FlyHC
         LEtJuEH44euyymz7WaoXVU5wttreNfsvgo4wO1nW2lxenbZyCjYuHQJVSCjTMOYGVAnK
         X3D16XEBT6DfSH+MQWX31ycn8ERTbL+2pqsUlo/ESKx1Vbp88nTmg6I1+fupc1medfum
         lyQw==
X-Forwarded-Encrypted: i=1; AJvYcCVpd/G6ZGvm9l8Y931QDJ6o1ONzpSL8CbFhh1+cWgA6hhfUB30nVTdEdbOJ4uK6ptBMAVEMlwMXHbdRKjIhDOKMWQvybYhADw/3EGzb
X-Gm-Message-State: AOJu0Yxb8LkyCvsy7Onjgk/TSWbkqqNQyZ7AvvmlHwdPDyjBBb7kQPgQ
	HrzDm1otsvz7lv7rLMmU2MFYKRgCvNfWKkbhALLb4Ke+IoquS/KYhIOyBYlpmd7MgQUrS9a/OsZ
	haq7q+F6O+jWWwZEb+C2nq/ajX1teDSek74ry
X-Google-Smtp-Source: AGHT+IE/oLvVW+JfCZbUbvDSDLApx8BS80z+MWxLz1J9Qqcs9fvtsckCTdwJpoTBuiOIwbUNk8Fqo4E9Ng20fSrH3Ak=
X-Received: by 2002:ac8:5a86:0:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-4534fa1ccf6mr7081cf.29.1723495068095; Mon, 12 Aug 2024 13:37:48
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729220620.2957754-1-irogers@google.com> <ZqqAkcz4xOto_sK5@google.com>
In-Reply-To: <ZqqAkcz4xOto_sK5@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Aug 2024 13:37:36 -0700
Message-ID: <CAP-5=fXN4y++hD-TzVToobrmH73V_h1fbGq+DuZxmgi=jF5NWQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf inject: Fix leader sampling inserting additional samples
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Mon, Jul 29, 2024 at 03:06:20PM -0700, Ian Rogers wrote:
> > The processing of leader samples would turn an individual sample with
> > a group of read values into multiple samples. Perf inject would pass
> > through the additional samples increasing the output data file size:
> >
> > ```
> > $ perf record -g -e "{instructions,cycles}:S" -o perf.orig.data true
> > $ perf script -D -i perf.orig.data | sed -e 's/perf.orig.data/perf.data=
/g' > orig.txt
> > $ perf inject -i perf.orig.data -o perf.new.data
> > $ perf script -D -i perf.new.data | sed -e 's/perf.new.data/perf.data/g=
' > new.txt
> > $ diff -u orig.txt new.txt
> > --- orig.txt    2024-07-29 14:29:40.606576769 -0700
> > +++ new.txt     2024-07-29 14:30:04.142737434 -0700
> > ...
> > -0xc550@perf.data [0x30]: event: 3
> > +0xc550@perf.data [0xd0]: event: 9
> > +.
> > +. ... raw event: size 208 bytes
> > +.  0000:  09 00 00 00 01 00 d0 00 fc 72 01 86 ff ff ff ff  .........r.=
.....
> > +.  0010:  74 7d 2c 00 74 7d 2c 00 fb c3 79 f9 ba d5 05 00  t},.t},...y=
.....
> > +.  0020:  e6 cb 1a 00 00 00 00 00 01 00 00 00 00 00 00 00  ...........=
.....
> > +.  0030:  02 00 00 00 00 00 00 00 76 01 00 00 00 00 00 00  ........v..=
.....
> > +.  0040:  e6 cb 1a 00 00 00 00 00 00 00 00 00 00 00 00 00  ...........=
.....
> > +.  0050:  62 18 00 00 00 00 00 00 f6 cb 1a 00 00 00 00 00  b..........=
.....
> > +.  0060:  00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00  ...........=
.....
> > +.  0070:  80 ff ff ff ff ff ff ff fc 72 01 86 ff ff ff ff  .........r.=
.....
> > +.  0080:  f3 0e 6e 85 ff ff ff ff 0c cb 7f 85 ff ff ff ff  ..n........=
.....
> > +.  0090:  bc f2 87 85 ff ff ff ff 44 af 7f 85 ff ff ff ff  ........D..=
.....
> > +.  00a0:  bd be 7f 85 ff ff ff ff 26 d0 7f 85 ff ff ff ff  ........&..=
.....
> > +.  00b0:  6d a4 ff 85 ff ff ff ff ea 00 20 86 ff ff ff ff  m......... =
.....
> > +.  00c0:  00 fe ff ff ff ff ff ff 57 14 4f 43 fc 7e 00 00  ........W.O=
C.~..
> > +
> > +1642373909693435 0xc550 [0xd0]: PERF_RECORD_SAMPLE(IP, 0x1): 2915700/2=
915700: 0xffffffff860172fc period: 1 addr: 0
> > +... FP chain: nr:12
> > +.....  0: ffffffffffffff80
> > +.....  1: ffffffff860172fc
> > +.....  2: ffffffff856e0ef3
> > +.....  3: ffffffff857fcb0c
> > +.....  4: ffffffff8587f2bc
> > +.....  5: ffffffff857faf44
> > +.....  6: ffffffff857fbebd
> > +.....  7: ffffffff857fd026
> > +.....  8: ffffffff85ffa46d
> > +.....  9: ffffffff862000ea
> > +..... 10: fffffffffffffe00
> > +..... 11: 00007efc434f1457
> > +... sample_read:
> > +.... group nr 2
> > +..... id 00000000001acbe6, value 0000000000000176, lost 0
> > +..... id 00000000001acbf6, value 0000000000001862, lost 0
> > +
> > +0xc620@perf.data [0x30]: event: 3
> > ...
> > ```
> >
> > This behavior is incorrect as in the case above perf inject should
> > have done nothing. Fix this behavior by disabling separating samples
> > for a tool that requests it. Only request this for `perf inject` so as
> > to not affect other perf tools. With the patch and the test above
> > there are no differences between the orig.txt and new.txt.
> >
> > Fixes: e4caec0d1af3 ("perf evsel: Add PERF_SAMPLE_READ sample related p=
rocessing")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Ping.

Thanks,
Ian


Return-Path: <linux-kernel+bounces-283556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC794F64E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140881F229E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D956F1898F8;
	Mon, 12 Aug 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wk8F+83l"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F6136327
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486217; cv=none; b=nhWhsFXhyJLVVPwN9YfxW1EzjaT/yTLqILGyOysCtqHrIjgHBN7LwbZJ0a0GKmZtfBwO/K6TJBOMEEqQgzcESB9IFknKkR3doEVD8zRVC/G2cQsLRqI2TlxhZl4iBybNBnyYmLPCvfcQAmqqCc1YShR3gKVJ754jHH1nzsuxbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486217; c=relaxed/simple;
	bh=e5zIyxIrDjlnfGb53pONco0/BZToTmfTinFeg12plds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHc/t1zqED2gAUdv7b8g63ltIv2g3E54pLqGtjWSuJjDOF/cN5LdmQY/y6lMYNdvZTPkFn6J8IAABQ+KEvtqWRkQQKsSwKqCrTW68pm/ho8hqJGhHhSRE1h0sLFRxUqoKTiN6NDvB5eGILBq/Fd+8vhAPXI5s3LZKXHv1FsO3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wk8F+83l; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39b6493b7dfso9425ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723486215; x=1724091015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5zIyxIrDjlnfGb53pONco0/BZToTmfTinFeg12plds=;
        b=wk8F+83lFYSrRFo9G3p22NCcQwJksWFZb5PzJV6P1oavBxwMwRJy+KnyVgSCG8jHPp
         u6Q5DF2oIXOeF6VoMaf1Cno4omI233hJfLjdO5uhMjy/GtKTOan1UjcD1K8jzTieGKCV
         /Td9tjqIUMBRhcuDgbZIcvQH53VWHCzbWPtmqDbqISwpJJ70LI2dWOMRY4YaQon5y2yo
         E+dSptqJrt4dCgqpUDjpWCwdkYCCUgTkuFGR4JbZAsQg+05UFsDELRuG+hGFiUvvtopq
         I71IoiKp95oxT+h19APijlH5IM2irR28fiaZdqM8slKTZMG9+lzx/sUz6OZ/DWVLsMG0
         sc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486215; x=1724091015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5zIyxIrDjlnfGb53pONco0/BZToTmfTinFeg12plds=;
        b=m8iZvfvaIr31Nve2PF85gdoPthcUNYn9qBaTa773D2Sv82+xJ0Pzn449JmOj9USINe
         1M9EmpzYssi37PUiMtwmOID3txjEVC3KuR/KTL/VdxqCOA3fcoDvPlgv9n2EMchlIjJo
         wr2ERWQIaac7h1rgEzr5sHHs61ugP9wJeHrQS6E12YN7BILHGX88zD1jNvsapg0NvCnT
         I7ZpT8C/u/vXeRKYNgUUovBTUo5Y7Dpyxgk6MgbSqvOZf+cmdMdpaRGmgsO3fMyhvbN6
         KGjMqkaLUspNNr12iqQb4hLeLA4Dmgq2XS0wXA0fUjz7bOkKKEh4G/5pO/7Ro/EqLg7M
         OcKw==
X-Forwarded-Encrypted: i=1; AJvYcCU5max5BAIkibJVD4IxYieJ/3ohgFFci5O4qC9xLUhDSVJ0LClzqkkJ5V+x9wFDecn2Qz+itntAaCNpSi9w2+blzo0RpQcMlDuRVJeC
X-Gm-Message-State: AOJu0Yyyfqgi9IAWiTH7aJaq2IQZEmokB/BqLkAB4X3fL9euzgymMWxh
	mvP/83f+zuW15Gtizsq2LXIU/nCk794WmQm3bdQ6Hr6lvxXXF6AtOSrPYcvfDJ38Hgeq7E4GjIe
	HxYwc2CEwgzABI+YeBNJY00lIXg+GQfQg3B8X
X-Google-Smtp-Source: AGHT+IGpNuhX2zqj3reQmzL50R1acs8rnYKxRU8rM5gMQeTjOMAcLtkuLA3l5tjMqboxzrcHuixoT/nrDbFq+TiC5vc=
X-Received: by 2002:a05:6e02:198e:b0:398:ce8f:5d39 with SMTP id
 e9e14a558f8ab-39c49e5823dmr132585ab.14.1723486214478; Mon, 12 Aug 2024
 11:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com> <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com> <ZroT3Xut5omFg7ud@x1>
In-Reply-To: <ZroT3Xut5omFg7ud@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Aug 2024 11:10:02 -0700
Message-ID: <CAP-5=fWyEX6+HX5tJNzhzNp81GLjZCDdHZu1vAMN15SVz1Qfiw@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 6:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Jul 19, 2024 at 09:26:57AM -0700, Ian Rogers wrote:
> > On Fri, Jul 19, 2024 at 1:51=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> > >
> > > On 18/07/24 03:59, Ian Rogers wrote:
> > > > struct perf_tool provides a set of function pointers that are calle=
d
> > > > through when processing perf data. To make filling the pointers les=
s
> > > > cumbersome, if they are NULL perf_tools__fill_defaults will add
> > > > default do nothing implementations.
> > > >
> > > > This change refactors struct perf_tool to have an init function tha=
t
> > > > provides the default implementation. The special use of NULL and
> > > > perf_tools__fill_defaults are removed. As a consequence the tool
> > > > pointers can then all be made const, which better reflects the
> > > > behavior a particular perf command would expect of the tool and to
> > > > some extent can reduce the cognitive load on someone working on a
> > > > command.
> > > >
> > > > v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-b=
y.
> > >
> > > The tags were really meant only for patch 1, the email that was repli=
ed to.
> > >
> > > But now for patches 2 and 3:
> > >
> > > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Applied 1-3, 4 is not applying, I'll look at it later.

I have a rebase and can resend. I haven't addressed Adrian's feedback
as I prefer callers of the tool function pointers not to have to do
NULL tests, I'm trying to minimize spaghetti. Not sure if you're
applying the whole series here or just the beginning.

Thanks,
Ian


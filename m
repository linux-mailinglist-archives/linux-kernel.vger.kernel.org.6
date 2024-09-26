Return-Path: <linux-kernel+bounces-340467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA59873CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F47B2550B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A9134B6;
	Thu, 26 Sep 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hforSMyS"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A612B73
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354853; cv=none; b=jbM53ZgIGCbQJzDaazD9xdSKv6WopokISHZvXuAvAN1rY7QV+jmxG4wxa6AM2bSTaIuE13JjjCZ1CjqBRg1+DQv9wHhhUld8+WO0w+D/mdWa4/xw/TLxcImp5nUGniJ7z60ajUMkaLLGl2kLHN3vMO/21E2mbvzEbxSIB8fXUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354853; c=relaxed/simple;
	bh=fyJKuZVK0pU5Fqrwlw0rK18hA89S7OCk8Zi/KbuJDu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trmjqBrWRoaVHfo0c8Mm3hxJzLB5YceZ1ePTlM5PtluXlN55xh7eyj3GP1seDeRO5WtixcBDNzy8BNPoWKkcLOvky3oKCMVe8tfbKTorunTirTC/RW0OR+MeBoN/k4d8nFOGCO+xn5PH+eB35kZUXaliKHsLMZzi4RPh74yDWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hforSMyS; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so179595ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727354851; x=1727959651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0YaFbmNZZQ27EGzEPqm3xDYI+YQcc7orYNQOKUIa6A=;
        b=hforSMySCYG+QYOm7PwSRP7tpcLKiHTDPQS4QvpSBLtvy3dmWm2vRp4rXCuohYTRNV
         HKM8/ANPvUmRtIPw/5oInl2oK2vejyu9uuwjaQKxXuibx3pWb5LUCpmCTEZ/ivl3eFmk
         YptOESiXEEJPqmj3TrMExRZTPLKcGWb8CpFCKLU9FhhOY7zZIAhpdJkhsVgwFtFl4Lhr
         cuyi07JAxRd4iqYYlWxoFw1qqPmdpM9MnPA+4EatwsFJmhRuEsYhNT6tLSozwZSpWsUG
         lNO5lqzXRW9dBzP023pUWu4k19ECB9+d/Y8K0+uXWCe2ODnLfSY6nx9r1W7yiEYl6Wjk
         VcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354851; x=1727959651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0YaFbmNZZQ27EGzEPqm3xDYI+YQcc7orYNQOKUIa6A=;
        b=JWVz/2fykcxcfiI21+ayXHvrn9lF7gK8tsQOZh/Tvza6Lgmky0Kr50lMIZ2JRQCgah
         ctYtQfK/AUUqg0kTIztA0dTUKDvrXiUHhuLfaa64ySdFSzTnezD5mYnne20zdQJOg+XJ
         Jb12CXZ8NlvZTwGwmYakZyFWFTvAEm3l2+n0ZFpTP7PQ4U7Cj3xAhPm54eO3tC91MJLD
         d7ICuq0ruNVAO4/c1OrC2jdJOU2FncS0YLjh+j6VgvAmgwIQk11b0A/GjeHW5Zqh7wtQ
         TjQ73QOX4nWepL9kNUaRNFA2AqzJo2ELiaXzsJiLq4oHVI48lUeEIrX6lzPGiePfwiQF
         Lyvg==
X-Forwarded-Encrypted: i=1; AJvYcCVu+hH7nNbgIITQ4vvuB/9/Bh69Oz+N8W1/3ZIYa/jh2/14R4aYrs/854nio2wFFOSL0oVY8UFD/TYaeIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUHF3TVGHawnvw5FJrPA/fVxO6ETE1DAW9qFGVOzBfgSkBfU6
	6puRY0NSDf7VvHnnJV04ojDM0OPejaQoknfBqfl6Zo9mF16IonAj0B3pX0qpGn6tyXO8cxcY1g4
	oq91hhDPlEkNdiQ6mtqXTuSv7ay9ZxcoSqepY
X-Google-Smtp-Source: AGHT+IFMqRnqwjKxa87XgLmW7djRVdBS3k0K+n7Ne06XPBn+bzv5sGNN+Zof85NBIEtS+boDmLekH2h0LRsTzu1U784=
X-Received: by 2002:a05:6e02:1c08:b0:3a0:b597:3e30 with SMTP id
 e9e14a558f8ab-3a295eb02ebmr4428815ab.8.1727354851210; Thu, 26 Sep 2024
 05:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com>
In-Reply-To: <ZvTUo_nbr_gKaJrs@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 05:47:16 -0700
Message-ID: <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
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

On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > The name dwarf can imply libunwind support, whereas
> > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > make it clearer there is a libdw connection.
>
> While it only covers libdw, I think the idea of this macro is whether
> the arch has register mappings defined in DWARF standard.  So I think
> it's better to keep the name for this case.

How can the dwarf standard exist for an arch but not define registers?

Thanks,
Ian


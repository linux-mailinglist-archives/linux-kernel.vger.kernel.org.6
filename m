Return-Path: <linux-kernel+bounces-203420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB878FDADD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFCD1F24D8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88768168C1E;
	Wed,  5 Jun 2024 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAW8G04f"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75F167D8D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631492; cv=none; b=jD87bqZ6xPFhP6V0GSGSXMiR5Igp9b4z6zv7PvzWW6IB2n26quYIDNBPDMm+a0pH7ZfsM7ovy9IxLX3K+GxJC54U0jJIqFELbYrvXn4jJgg//JQKGyRVB2JwjGQ8x2UV7mshbUE/OmfBGeob7WyK+hirNXE09qRpLFWxwRVEQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631492; c=relaxed/simple;
	bh=U7InVmmSrK25YNhLJNh+yqPRqcrfe70EpSFFDHgH6LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Prcz09bKBRhQ4EAvQGHM+2m07VdsJnbLmMYuos4GwNcWuwQBaBcZe6yzgghm1EFPy6GadX7KlHi1psC+jBu2Z8OTjUTTI7pkhMGkl1M8O6hoI/v/pGAN0IoBK/ue29CtK1Ztou1kDLCqnxBk2z/KFXxOQp1DEphGS+2Qzd3ccYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAW8G04f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6a270d1b8so63875ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717631491; x=1718236291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79M0nO+KIcgbUto8NrR4+Y4jdk/93YVdZriJZH/jQN4=;
        b=IAW8G04ftjJc30nt4pxYlhyYSpARPANh2YuyLI+rDtfxY01Lp1+tODrDUcDjJGxt24
         h+mHzLniuhaBdBEnBFhvGuT6ncdzzgxuXaNy5ALCpSpwnYF6d330YxT3N6nC4UMjgvRj
         LAfyPy5y6Liemmgiore2z78ptc93iB2CyKn03uXXlvznPaHhXPopVhw9/rEyzn6eALWi
         ZQEDzoZ/Y0c4hUQcKkrQ/nkv/5Rctc8erCkcy77hNu8L5L2MIoCVwVVfm+PArFlKBBDN
         cJettcqIA5VvOroKjd97grw5F1AenqHdxFKMD/x3liiPdfrDaGPlBJLJLZO/gFm/GwOR
         pR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717631491; x=1718236291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79M0nO+KIcgbUto8NrR4+Y4jdk/93YVdZriJZH/jQN4=;
        b=JtEXLUnDxV4/hL658nNLRwKDuhERn+M7iXbmvpzaKOBteyPCFSDv7f/WrgiZT51Rxt
         GS9tTBGXDN2Iup1udQMuOTbuR6oDf+SVyo9agXhBDIYZH26xU2t4vSY1ClKaoR/0kDeU
         EEMJ18a/8dsFIl5gg4tB3OLdxnHshr7gAQVWWH5XeV9uOJYIUdwGMWBnTz4HcKLoPG2c
         K70OxpewUl3lA/gfCey71MSVrz2lp1+EE+kyRmi26I+GQzESpyqNA2Wf9/jCstGXTlpi
         EYJVm+Vh14EOHXsrN+LN8Wa2PJtc477D02wBvjPDPHD+jGd6FaCGCqiIH11cA7l0748j
         Bl0w==
X-Forwarded-Encrypted: i=1; AJvYcCUVhILB/4ldyjOoDzafJbwNoEqCvyMo7NqgdDoEgsUp7iWfqXuy+HKdUAEhr+39Jv1AEoSupk8i6/rA+ihz/UjmUAoGpFew1zClLSM6
X-Gm-Message-State: AOJu0YzyrlDA5lPIwZyx6LA/zE36XTrBnc2uTwibncnwg5jXkwGSEgKc
	7EKbkq1XD4Zt8h56aaZgZc2eKmvRvf4NQ4xlO/9j1KVGCGCQHnQzkF9bMuPQEq+2KodCsh39obu
	+52eRs9oXzZI/HB6CoY+nBB7RZ8g5snzzFMD+
X-Google-Smtp-Source: AGHT+IH3Qywl45jnbOG5HG1JqeRU2wWUBItqqeJXUS2GCpxt7nsAPbyI4+OOzH1xONrf51Gi7h0M5xyHPdEOiMolD48=
X-Received: by 2002:a17:902:b587:b0:1f6:8836:e43f with SMTP id
 d9443c01a7336-1f6bd3b4960mr593435ad.17.1717631490266; Wed, 05 Jun 2024
 16:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516222159.3710131-1-irogers@google.com> <CAM9d7chsZ3EDRYW=YEJBd7wCYRLWNqMOFt33C=ghaY_UqZvGKA@mail.gmail.com>
 <Zkz585EIxBwoP4OZ@x1>
In-Reply-To: <Zkz585EIxBwoP4OZ@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Jun 2024 16:51:17 -0700
Message-ID: <CAP-5=fUzbaBCKEVxYTyzv1K3s+BcGCAjJcv-g9SrZFO+EBX3oA@mail.gmail.com>
Subject: Re: [PATCH v1] perf top: Make zeroing histogram on refresh the default
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 12:46=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, May 17, 2024 at 06:25:16PM -0700, Namhyung Kim wrote:
> > On Thu, May 16, 2024 at 3:22=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > > Instead of decaying histograms over time change it so that they are
> > > zero-ed on each perf top refresh. Previously the option '-z', or
> > > pressing 'z' in tui mode, would enable this behavior. Decaying sample=
s
> > > is non-intuitive as it isn't how "top" works. Make zeroing on refresh
> > > the default and rename the command line options from 'z' to 'Z' and
> > > 'zero' to 'decay'.
>
> > While it may make more sense, I'm afraid of changing the default
> > behavior.  I think we can add a config option for this.
>
> > Also instead of adding a new option, it should be able to use the
> > existing --no-zero option.
>
> Hi Ingo,
>
>         What do you think? -z and the default to decaying is in 'perf
> top' since the very beginning, when it was called kerneltop:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3De0143bad9dbf2a8fad4c5430562bceba196b66ea

Ping, thanks,
Ian


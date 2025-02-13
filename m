Return-Path: <linux-kernel+bounces-513695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADADA34D84
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1580A16E379
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B385C245AFC;
	Thu, 13 Feb 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF3dlGVd"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346D245011
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470837; cv=none; b=tnzUhcPy8JlTJH9z87sTJ0VI0slc8VY1Z7Q5kk9EoMP1MzRI30ug5gjXlMVfU6sXfXUzPoMDbpxyTnXbcLXum5sxo9pfZ6kuGIRrRzZBk58KWG0InvMOGasGc5/LjyZp+M0oIrvabsX34YFvR0W/HMRF3Ds7QH5JrG+pXQEXV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470837; c=relaxed/simple;
	bh=/LyGFbPE1BAmB++z38OZpHSq6dQ7FxIc5VWLCNL1wxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5x8revCP92YfiDqZNvdGisga2Ndv1jEIHZxSH02CSS+S3W4oLXNueerfd/1O3I0M1ybENyHOwfq/54IJn2ndQVpVv6mAiiI+8QgfBqIs7CR6LE6koEaHV3mc1Lobp48kzhnL8yJQ/4Csbkv3zsD+igm5MXpQimqZM28HfjMMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BF3dlGVd; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so8005ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739470834; x=1740075634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5Yi8A4+6Jiha2cMKDJFdE3ONJ7D37Fd1pQ+hUL3DkA=;
        b=BF3dlGVdcRl9DT7czH2XHbCT00Wo5+vx2GcQrf0auN2HyHFmLi+VPGCFQRIdaC51pC
         joCYbwSTGm+AXpKwRXlofMG3gd4iwbytrS+vKPAYIdAcH71dqPMPCsQMDyTo/uIO/Ink
         8cTsFmI9DSfRJys6gf0isMbNrhapMbWc95YwRfHHPoMfMk8DpbwAM4fy8EQc3pdoCj+a
         8XDKN7OfBFZs0JSAMdQY+bac7tNz9UvY7N6l2Vag5XKA/IeWtfn1mTm7lpxzvVjWg5OE
         3FWoY42IcivGalcb7Sq0s4rLic2ZJjMS0crdoF5GJKFn/Wxslg2z+mfBY6wESAkkyX9D
         o7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470834; x=1740075634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5Yi8A4+6Jiha2cMKDJFdE3ONJ7D37Fd1pQ+hUL3DkA=;
        b=SzuuW4pMTkBs6Zbkmq3V872JM8aKzq1NT25QjRcsbBhf5brIShGltToiQga+RpvJzj
         Uj5ZgJhmrSfLU5aWqOIJS6Y2O2h1eiJ2nLWnqIekuSUfb7mh7lD/kemeDQCTqgBBG71m
         WG2JtImMrwQ4vlxcKb9Js5cfff+1FlukMZbw7JdEnS2H8FGdq+ngLQcI1wQ+0Gk/Cqoc
         VeeJigFcvXQiIbBDZst+GWA2+NgVtFXEY/ze5KnlCrw3KU1pALeku9aG5Dj/PgCM3VmG
         l6hZWjTJB0CeRb6iVMjm3E7N8QH5UnsIDljun/1fin05KlSoQ/kX2q/mr9sFbRzrJ3wN
         d6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF8tR+nKcNpyObBw+o1nfsUvP6rM0v5wWbrMxfAh1/RcC3LoIGR3xH/K9iQmQ+xp34q1Rj874YXph+au4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVRqMFFaD3ifjlQiMRCQWqTEm6mDH3KM1+gK/5PPaYWRPus5v
	1ZTyjm0+wKXMyy8bZ6aW0a50Rl+nR01OXKYZdztfo8q6IfRYbPgIj0oZAcSu0127QGaR8XB3oQ1
	5X+uW2wHmt5oZ15bhlcfuKp6S4edu/x1xynjv4cH/ect3xRe1gEW0
X-Gm-Gg: ASbGnctmeFV6+XZGYM6NbuMT9RBvEslZ322vtGDX54TvOWeGjxXTCM3T7mb4QDgG85K
	5SFSJzhC+Mi/dhTlbFmNSNxOnacwr7YnR1Wh+GKVgAf99Ha8N2OKeOgV5muJbE7fj9RNTpU0Hse
	uA7GLtRvC0fDAvJ7GizvlNS2W3
X-Google-Smtp-Source: AGHT+IE/SiI13+b7bF+C4AfY+GjkVCmV2TCoGjBbfEPBrkZXoZpHcK6Pj2DJbKttS1cXo3XAtbnSEyYT2uGv8O9+aIY=
X-Received: by 2002:a05:6e02:308d:b0:3ce:46e2:42c7 with SMTP id
 e9e14a558f8ab-3d18e265567mr4170575ab.13.1739470834440; Thu, 13 Feb 2025
 10:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com>
 <CAP-5=fW94Q2i4EHGoM7kczTZUsfmD4nK4sAjVtcLzqZy29Quxg@mail.gmail.com> <CAOQCU67xtf4ndP2fo6fFxgsb7q_6uUooHQK4mb+Xi4fZR_ir0g@mail.gmail.com>
In-Reply-To: <CAOQCU67xtf4ndP2fo6fFxgsb7q_6uUooHQK4mb+Xi4fZR_ir0g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Feb 2025 10:20:23 -0800
X-Gm-Features: AWEUYZl_wnASXQm9eB-3X2u_vxgEDQP_7aR4Fco6U72vV9FWxU9cBPy7bFLQors
Message-ID: <CAP-5=fVqCUYrMDac520c1AvwGXmBRstGTZEeY8VeC=0hoCBrEg@mail.gmail.com>
Subject: Re: perf: Question about machine__create_extra_kernel_maps and
 trampoline symbols
To: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:17=E2=80=AFAM Krzysztof =C5=81opatowski
<krzysztof.m.lopatowski@gmail.com> wrote:
>
> Hi Ian,
>
> > We do have a kallsyms parsing benchmark:
>
> Yes, I've looked at `perf bench internals kallsyms-parse`. It returns for=
 me
>     Average kallsyms__parse took: 99,994 ms (+- 0,199 ms)
> However, this benchmark only measures the raw parsing speed of the kallsy=
ms
> file, without any of the symbol processing that happens in real usage.
>
> > I was curious to know if the regression is also visible there?
>
> You can call it a regression if you mean from 2018 ;-)
> I gave measurements at the top to give a sense of scale and show it's not
> an already solved problem.
>
> The core issue is that we're calling 'kallsyms__parse' multiple times, wh=
en
> we could likely consolidate these calls since most of the overhead comes
> from reading and parsing, not from processing the symbols.
>
> Notably, the third call I mentioned (in machine__create_extra_kernel_maps=
)
> accounts for about half of the total kallsyms parsing time, yet appears t=
o
> have no effect on my test system. This is why I'm questioning whether we
> need to keep this functionality.
>
> Ultimately, I believe we should explore ways to avoid reading /proc/kalls=
yms
> altogether, given how expensive this operation is.

Agreed. We had similar expensive operations in event parsing and that
has now largely been made lazy - so you can craft your command line to
not require all the costs. I can't answer your question but it seems
adding the symbol processing to the benchmark would have value.

Thanks,
Ian


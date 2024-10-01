Return-Path: <linux-kernel+bounces-346749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3662A98C848
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0E31F24CE2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8C1BDAAA;
	Tue,  1 Oct 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ns9Uc6RV"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACB19CC39
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821938; cv=none; b=NqO4xSm++QaBPN4Oe1Bin27Dv66k7Mpba+ercqyb3aDFDUeImMohaRQjL530pRz+PxXqYA0YJzU5H6FCXEYcaeRhQGzzSyY4Gr6TLZyPkaPJmJlhGD8lhiZSkB5g3kOpsg1lU07dODi8fEskQKaX5UYk6GVM/DMMOP/NVrlvv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821938; c=relaxed/simple;
	bh=lXLPPvcaC531aZaS1yfZf+lCtcWytgonSWc9XS7zbd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+d4uB7CUV5FusJzJa9TU4HfIX8vuKHmfgO4jlZm2sCBRPyTb+e2Y9xJRjgWgG10wYRzZJ2vHsl/Rt9ukS70ZD4vFwIKZMc+xDH9gu47RrcpetZOaeTHmQKy4godfSSplC4BXlZPysYiFrrP4lt2rO6FguMMxMmto2SzXZowqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ns9Uc6RV; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso96885ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727821936; x=1728426736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/WmEnb9j6uzSOoeBPcQQTHlHX9n1d3QXM/aVEUVcsI=;
        b=Ns9Uc6RVCWjRdOX6Lnan3Kn9qU8GuevibDwe6RhVGn6XaS+lnxkrhAyarMU+FeVc2h
         A/VyA/DP3knIfrMdnuMn4pmwBpooKMkh1kd0P7yFBg8l1+ogjpgEJ2+C3eZpeOfn1vf9
         zWPbl3Lw/g8kZKFLe6HUPgSEWcYN5pR6S43BF3OH/6j/2vNVRIPerbEGbH25zpC+lH0v
         3px77JQEplgChPeLw9hAsq3x8zGov+nG2i0GvE90NQiIKEbOYJDYziVFmSimpOm1Cy8f
         M+RXRilyH7AtDaKGMh79ZkbqecemfqsrIfmGpAi634twacwteVTbHvWGUlApf+Y+Zov/
         2AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821936; x=1728426736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/WmEnb9j6uzSOoeBPcQQTHlHX9n1d3QXM/aVEUVcsI=;
        b=ZA0vV4qIPoEMhNTKdm1BKcsM39XEdMfjnQZBzDoH8lrKHqN6C8AI2Qj5ZdRnUpaQ0A
         FICn6BvuwzpLYQrwBOOv92FMhuEXnnBRSNhAXjrnu3IxrgVPmKholB5mKrllnmNoHt4o
         Oer5BIdsOJOCdS6gcqIjxy5PyNNd+L9hIoBO8hhboPVpxWvG72Q/OYkpzjR09F7GKxVb
         mZwfspN0M54j+cNcj0UvMUgQ7Va1aIoZeTAkFpzMSUhXHhT3jTHgKKjyfDcdRV/AEQJT
         qXEz/jCc39Uil+R9bfdbaabCgVNzjVL2E9XX4kCqppoPcl4Nrqb0bQ5qfTIv7QZ4lI4L
         voEw==
X-Forwarded-Encrypted: i=1; AJvYcCUj5q9aFmnPPAMhuQjL7Tq7FC4le63I5uNbxuoNiBV0A6wLxoNRZPnndlyeTuC/6tvlL2dVWFft5ZSHtuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykdKRSDW6U5NmJzogwKIS3kYqP0ECic4nbEOskj+iwcrrSt7x9
	33pMTw4sV4xdhplaG69pIUkSJr0yxy72c4rjbrQYrEfhHZHu4qoaTq1Wn3MduGyimdz7kaYRVLX
	UDSF9ywUti+Z07b2A29GKT256rNPUsCZ2Zczu
X-Google-Smtp-Source: AGHT+IHP7jVqfzgHpF7iOYK3BNtuvEp4ZZSe1Skt6kFebwR5FWd6uli4ySfWrzWaFaPAGujsH9j/xL5j1k5Dfpcl4Kk=
X-Received: by 2002:a05:6e02:12c3:b0:3a0:b597:3e30 with SMTP id
 e9e14a558f8ab-3a365f72b05mr1641715ab.8.1727821935730; Tue, 01 Oct 2024
 15:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com> <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
In-Reply-To: <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 15:32:04 -0700
Message-ID: <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
>
> > Changes:
> > v5 -> v6:
> >   * no function change.
> >   * rebase patchset to latest code of perf-tool-next tree.
> >   * Add Kan's reviewed-by tag.
> >
> > History:
> >   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi@lin=
ux.intel.com/
> >   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@li=
nux.intel.com/
> >   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@li=
nux.intel.com/
> >   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@li=
nux.intel.com/
> >
> > [...]
>
> Applied to perf-tools-next, thanks!

I disagreed with an early patch set and the issue wasn't resolved. Specific=
ally:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/?h=3Dperf-tools-next&id=3D3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
```
  /* Followed by topdown events. */
  if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
  return -1;
- if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
+ /*
+ * Move topdown events forward only when topdown events
+ * are not in same group with previous event.
+ */
+ if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
+     lhs->core.leader !=3D rhs->core.leader)
  return 1;
```
Is a broken comparator as the lhs then rhs behavior varies from the
rhs then lhs behavior. The qsort implementation can randomly order the
events.
Please drop/revert.

Thanks,
Ian

> Best regards,
> Namhyung


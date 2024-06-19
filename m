Return-Path: <linux-kernel+bounces-220503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482690E29E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9391F2421D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E456452;
	Wed, 19 Jun 2024 05:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbizCot0"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66B46433
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774471; cv=none; b=pltNtr1EnaMSnw/ulIMEFboCyc0JzqcMeWEFlGfV21TrzdTkJWvhH+GzbUkn+2+uugjJtxW1EUuxfIZcnwRj7yHX7FEVHuhzK0/E+s67xWzCj8vpS3ZIhfJAhu/ZaIT69UCYJYVOQJDixxTU/d2pmipKWV0IaFTh16Ma0+zbNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774471; c=relaxed/simple;
	bh=HPwAkIjCMCtyaHAN9mZhtVAFPxZ7yV3F8HsoSGgFVuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbpcQIE1GUqeXrXp0iiiwc+FRZw279B93nJWNVATFZ71r0PLns344ClJ9IuFMCt8eYpiNuKxl/zaqI/J2iOVtUZ4p98l/NFTiosZQU93+vlh0Uvxh2A6wFmI5NT7VojDznAX2A3xkvMx+pDkFi7WZV0pzGi3+QeAPLWcPCC5U5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbizCot0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso8820a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 22:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718774468; x=1719379268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3k194h42+AL5905GXUgisOm1fqGa03CLUfEe2tpgoV8=;
        b=bbizCot0dX6if40Wgqm1xHHXReL8A1sDoUT1dXHdMHyStWyYGvPTD7NV3Q4zoGEGqE
         QR0DsAv8fiifuVLSo9C7E4BXVFj40LQm2XS5h4ekjJ4RGEnet0Dy7dfab/0JQTl4Ayo4
         hFDEdu29KoDsdBALjXWZ5N6D+J1fEkHbCIsNBk6SxLPOH7ROQVQsThKuhmhNGtBdxTUG
         dfhiaVT/R21QFM4LVbTBoE5osXeIkAKtvBr4Ezq4zb7uvKj7Om2e0GsY6OF5XsE1Qug0
         hga6hPXpVVdPjWXZr2ibZfxABPndCPwR30jAMkM1N4tF2oC5V8Q3HlbHcsVfahT3PsFY
         xCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718774468; x=1719379268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3k194h42+AL5905GXUgisOm1fqGa03CLUfEe2tpgoV8=;
        b=rxc4GqFpiZxLn3qJAHua5RnZtfYCf/eWm578o8L1lqWBIwZcAvF4WoAvdfl5kvg7VI
         OA1pU7AGKMzr4pBmWC5uFnm87XpzKHohzN8PBQjyPPadElEQotxnyIIWwPd8mG83gW8H
         TM6fIX4I6GzrqzcFStMsMxWWTC4w8lXJZ0K6YWKj1r5S04Z3s81boVX+wwNr7/acl/xV
         UB5MS0cnuHxqvLCbYtC4BYq2xG5iPgBdsuFlMxgO9MS63AhvTS+NPoEAV9w/0fp9t6iU
         YJSLdRjXWNjx5oN0OzYqyPuqTC9Q34DCYiXEr6qDlZxDYMvQmg4aHNBN6C5730sqqbTk
         fvew==
X-Gm-Message-State: AOJu0Yxh1PNbWPllmHgJzVJ2jBuL9ikO/VjJpbKvPZAmyyTW0mwaIQXa
	H8kHEBTby0eQCq3+MtUPLFWbU71UdTfTG4j0C7171DUNr4mohEjI3C4CQ2Z7N5KVhJUAIpUL0kE
	tGnG4L3jspp0XcXgehJxj0yEsqUg5UV1EgTVr
X-Google-Smtp-Source: AGHT+IG8dQ4X7CFXHfXruoTw56f5zrnQJknmdxZt/3Pyr9uPyZ3b7NIAPGRrH0vwwAo/9kibsCTfCTppzIYy4o2RpDE=
X-Received: by 2002:a05:6402:278f:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-57d0d3428admr141190a12.2.1718774467850; Tue, 18 Jun 2024
 22:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <CACT4Y+Z=U+Y8gKBgaU76=zg=rAdq=AQ=epAq+RxDfdXsaqO_0w@mail.gmail.com>
In-Reply-To: <CACT4Y+Z=U+Y8gKBgaU76=zg=rAdq=AQ=epAq+RxDfdXsaqO_0w@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 19 Jun 2024 07:20:56 +0200
Message-ID: <CACT4Y+Zq3t2JXEbGDzYU61Rs5KH3mhCDiZ4GP9OacKuyocnYHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] KCOV fixes
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 11:31, Dmitry Vyukov <dvyukov@google.com> wrote:
> > Fix spurious KCOV coverage from interrupts and add a test.
> > Ignore some additional files that lead to large amounts
> > of uninteresting coverage.
> > As a reference point, tracing a simple open system call
> > produces ~10K PCs with these changes instead of ~45K PCs.
> >
> > Dmitry Vyukov (4):
> >   x86/entry: Remove unwanted instrumentation in common_interrupt()
> >   kcov: add interrupt handling self test
> >   module: Fix KCOV-ignored file name
> >   x86: Ignore stack unwinding in KCOV
> >
> >  arch/x86/include/asm/hardirq.h  |  8 ++++++--
> >  arch/x86/include/asm/idtentry.h |  6 +++---
> >  arch/x86/kernel/Makefile        |  8 ++++++++
> >  kernel/kcov.c                   | 31 +++++++++++++++++++++++++++++++
> >  kernel/module/Makefile          |  2 +-
> >  lib/Kconfig.debug               |  8 ++++++++
> >  6 files changed, 57 insertions(+), 6 deletions(-)
> >
> >
> > base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> > --
> > 2.45.2.505.gda0bf45e8d-goog
>
> Thomas, Ingo, Borislav, Dave,
>
> Can you take this via x86 tree please?

Or is it OK to take this via mm tree (where KCOV changes usually go)?


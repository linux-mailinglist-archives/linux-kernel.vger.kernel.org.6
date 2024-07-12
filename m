Return-Path: <linux-kernel+bounces-250514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BDF92F8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222722823A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2515251C;
	Fri, 12 Jul 2024 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mkcvu8GQ"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE214E2E1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779166; cv=none; b=RusS0SZZ0CE/yfvHw2O9SFbrxSwbuLHeYPbwpR9HUfxcd0l5Gpq0O1R7JnjLiaW/7IpNb4Okdz8WAm6QMCnCwNzQo8tR1dwfnwZtXscAQ+17h+4hMLcjlKjTdg5snZl43CZy0imcZiOdNeDrDkK94vBij7TnqI7e/g1OetIMveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779166; c=relaxed/simple;
	bh=nlytpuyFujRrlPzWhcq758GdHU5aL4sOwIbzsLOmK5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC070zEFDsMHBT7hVgnv4I/Z5Xg29p3rDDCQ1j9aSjmPVz1ilsnuJ6ael09Q4NAAUMhsu42sWtWPVTAW1dHVx7C8BYUDyxb1GpQuJnNmFwRKhK/VTkeGoUqktwe2bkfxO2jqYTD0Qei9aZKn6xoX63AtRVWwvRhYahOUShigcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mkcvu8GQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso1408697a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779164; x=1721383964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BuABMp8rgyV/MnavMDRd0C+518rND6T64IHr1gy1Lk=;
        b=Mkcvu8GQhTepoxiM49fWHAr1Z3mBTx+MLaUQuwFK8oaeFHgY8n6weOxLAyfZWK5U+j
         rDdFi0aVOu9pIxXtfxA6vsp3Lz9fOKDHcW4IzRve7NKoPRpPA3FaSJ2pdk3pIlNZV668
         rZAvu44ay/lTlj5kg9KstjUe1wYdg7vfnq4OpfN7xqb9byBYO+N5fgCQv9seAxKN8GLG
         w+Yrsr+ddYaUSdjv4YuVWPjNIqaSZW5OYIMKQNVg00iUnaMGj2IqoHLwJGHeSachmS0x
         xJO3+0C4c4fcZJRgO3g/AcLhFUUa5kmGDXsRXq0q8oRW8SA47n3HYRMs4n3v7gLAD4Yw
         vQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779164; x=1721383964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BuABMp8rgyV/MnavMDRd0C+518rND6T64IHr1gy1Lk=;
        b=d1HpKMQ3knbOkng9Aw5vS7Q9hD3RKTAf8dW/gftLhJF+q/NwLG3cnyaYi35B8OMSfS
         1ShXGJeGCT36kpGbSRqEI5OJdAiivjeMRCmwrVQM44510JtP5nELeuvt6yLiiN/h64ZC
         MmxcbljlhUhKSctRZAtVeWbgo93GzBqkbR3jEpZ5ditCbJp8kgxeAgCmToVVi1VzL+35
         i6n7MS4WlhH/PAm2c3pVUAsWGo/anZYPNoScUG3BQ+Ou3PO28ST47cpafYWyYJvju9xQ
         tvF9UbPErAx3c6lYswXQFuzZHOggoGzcrDrluKZi7G6IYWqjLRuJc+0qU9aYtO6DHYp2
         llww==
X-Forwarded-Encrypted: i=1; AJvYcCUMxEeqb/+3cspVxiCFwXoh7/kvhN9Zuz+G8ALprbNsp06BIVb/wrjaInq5nOTjcFUsiZ5jMgRed9LSRbPqXJzDpYB+0HI9rmHrTf2K
X-Gm-Message-State: AOJu0YxJ5Fwducfa/3gbW1f44K0LcPq9wW72axI0XRFuDPsN5MVYVy5B
	jV/0ZLrYP5pxxS6YiCK3On/51j70YR1CDaC4IjLJMEkeWV1Ed9B2UYRi//ZtOCnj6SiXMMPD9gI
	S2jzZkd1ebVie3uWDkoj3aDV1vyXqdi7YP0fwEWQtBUO0fx3L6NY=
X-Google-Smtp-Source: AGHT+IFgDc9ogZl8gPcqfqq/XMvRZvC4Osj8EbOZu7v2aFyhr2ojG6QYOLzLn+WXFU/cHReW3gP+CxtkCi4z3sCKmn8=
X-Received: by 2002:a17:90a:c916:b0:2c8:e1f8:b02 with SMTP id
 98e67ed59e1d1-2ca35bf1409mr9670486a91.9.1720779164425; Fri, 12 Jul 2024
 03:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnM2ywDVRZbrN6OC@slm.duckdns.org> <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org> <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org> <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
 <Zowt7pVWFB-Of-me@slm.duckdns.org> <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>
 <ZoxVZPCrWokjfmFY@slm.duckdns.org> <CAKfTPtAjFvOPByPyeAURN3gw0yp8ByVmpa99_dGEZiTGw_Fawg@mail.gmail.com>
 <Zo1omq73-ESGsVVg@slm.duckdns.org>
In-Reply-To: <Zo1omq73-ESGsVVg@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 12 Jul 2024 12:12:32 +0200
Message-ID: <CAKfTPtDdG+fhZjG0JEtXm+rq3w_v3iSrYxDLe0XXurOLEcOuNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 18:43, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 09, 2024 at 03:36:34PM +0200, Vincent Guittot wrote:
> > > I tried this and it's a bit problematic. Migrating out all the tasks do
> > > bring the numbers pretty close to zero but the math doesn't work out exactly
> > > and it often leaves 1 in the averages. While the fair class is in use, they
> >
> > hmm interesting, such remaining small value could be expected for
> > load_avg but not with util_avg which is normally a direct propagation.
> > Do you have a sequence in particular ?
>
> Oh, I thought it was a byproduct of decay calculations not exactly matching
> up between the sum and the components but I haven't really checked. It's
> really easy to reproduce. Just boot a kernel with sched_ext enabled (with
> some instrumentations added to monitor the util calculation), run some
> stress workload to be sure and run a sched_ext scheduler (make -C
> tools/sched_ext && tools/sched_ext/build/bin/scx_simple).

II failed to setup my dev system for reproducing your use case in time
and I'm going to be away for the coming weeks so I suppose that you
should move forward and I will look at that when back to my dev system

It seems that "make -C tools/sched_ext ARCH=arm64 LLVM=-16" doesn't
use clang-16 everywhere like the rest of the kernel which triggers
error on my system:

make -C <path-to-linux>/linux/tools/sched_ext ARCH=arm64
LOCALVERSION=+ LLVM=-16
O=<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext
...
clang-16 -g -O0 -fPIC -std=gnu89 -Wbad-function-cast
-Wdeclaration-after-statement -Wformat-security -Wformat-y2k
-Winit-self -Wmissing-declarations -Wmissing-prototypes
-Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked
-Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum
-Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wshadow
-Wno-switch-enum -Werror -Wall
-I<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/
-I<path-to-linux>/linux/tools/include
-I<path-to-linux>/linux/tools/include/uapi -fvisibility=hidden
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  \
--shared -Wl,-soname,libbpf.so.1 \
-Wl,--version-script=libbpf.map
<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/sharedobjs/libbpf-in.o
-lelf -lz -o <path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/libbpf.so.1.5.0
...
clang -g -D__TARGET_ARCH_arm64 -mlittle-endian
-I<path-to-linux>/linux/tools/sched_ext/include
-I<path-to-linux>/linux/tools/sched_ext/include/bpf-compat
-I<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/include
-I<path-to-linux>/linux/tools/include/uapi -I../../include -idirafter
/usr/lib/llvm-14/lib/clang/14.0.0/include -idirafter
/usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idirafter
/usr/include  -Wall -Wno-compare-distinct-pointer-types -O2 -mcpu=v3
-target bpf -c scx_simple.bpf.c -o
<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/sched_ext/scx_simple.bpf.o
In file included from scx_simple.bpf.c:23:
<path-to-linux>/linux/tools/sched_ext/include/scx/common.bpf.h:27:17:
error: use of undeclared identifier 'SCX_DSQ_FLAG_BUILTIN'
        _Static_assert(SCX_DSQ_FLAG_BUILTIN,
                       ^
...
fatal error: too many errors emitted, stopping now [-ferror-limit=]
5 warnings and 20 errors generated.

Vincent

>
> Thanks.
>
> --
> tejun


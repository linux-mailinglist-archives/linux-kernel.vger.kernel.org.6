Return-Path: <linux-kernel+bounces-361080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F299A31F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90398282594
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4675921730E;
	Fri, 11 Oct 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="L0xMS7Hu"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0911CB311
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648078; cv=none; b=Sgz0kkbUkdsdFGViaPCX5sLbu6WNMfncxO3gg0tdZHJztUCqa2N5LJEGX1nwY8x2wZq0OqO2ziOjrzomgkjBeSANxN6v9FBqfSNlr5EAA9MOynQzGxnpceqEJZT/kUiT/2r5Unp9d4Z545PVqwj28yTsE3B56tBXrOrR4PWny+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648078; c=relaxed/simple;
	bh=LT1IaCp5+fhZVHfVV7IJ+78xYx8h/eAPb/ijFeWEWc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPsz2FcQ49ktRpcK2AyAkIYmPTftcqntVmRcorUt/PqSjhAy2SiJYjWjrPyqF7nkRA7JCgaYMHn/UMaTSWenvh4YQmEglHiZ/24tZuaV7454zBFVS2+26AZ0T/WCQkslkAsEOQSUUIvrlU4NxjmuSvi+njiyAFgTntpZ0Qj8hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=L0xMS7Hu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c924667851so2336700a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1728648075; x=1729252875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpKEy9eKEr828a+5Sj4OEUU4agb/G4dm93dgL6VdZuw=;
        b=L0xMS7Hu8NwMr0kCjaWaygXhxozm9B59UBplkQd0duhe+1STGNetE5VXigNs9GM2hk
         FPvBByYHhure9xA0JxyUad4SM6QYElzA23+UzF2wlfra9sFmYvidS55q8lHwhNuu4QZl
         r39o6A9vGjq3YTiM054nZi19F83P8jNWA78/hYusQLLSXkfWnYJjJSKHrzqmx2pu+ySk
         kK//8XxBPA20zmLCxJ9v9mnMu2t6b3W9UprZfvBQa+FRrAIVi5t8Q4WxPF6DvXiB4W2P
         rv+lrbZLG/ZMqa+FHXD1eBH9VJqWEIOQq0G8RAWRhsKmkFySIYEXCI+r8g6BDnI8DbgH
         IlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648075; x=1729252875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpKEy9eKEr828a+5Sj4OEUU4agb/G4dm93dgL6VdZuw=;
        b=Dg/OclPJrjjiM+hL9GPRVe8y4BXtN0fDUrm7vDLqzveBYkWZeRRe6P/5jw1a6M4SXF
         NMuDwK2YcW8Ty0r36XtSdgWdaUYmWRGzdlFwDk/hjdgJrr4Jy0W4OUarTixr/QKWduOm
         Ue+RVpONyBDno2x6ScUuB3pIiPI02Y2FMPT/a2PEbUkVdlDoIz5/eosXb2gaaOjZ0mg6
         G/r1hOIHJ2vBHtTKg2sqT6ylQaSGG4sdCMW5rI6BqcQFqw5+0nqtTv21gmdf54kvwpIX
         APYqYUeFCEl/x9F8EwPXx2Lnv2VOtv1IUApCy8NfUPbdYEXQDXA+ED7tBlq6RbsGSE50
         BFkg==
X-Forwarded-Encrypted: i=1; AJvYcCWeaJOPG+i2wQcByyMYL7MJzKdSlXclRvmkkX3QgiGIxKjHO2jZf9ss7fu1Ve2hK/HM1SwlIGRfXRkfGi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysT9meLJQ0QSFVznlBJ3+5wbevfuYQDld4d1ff3UGJvpgTcqie
	mjBBUeLotskmltLj2ksuQHR3zhD/eSnmIOGn0ZuVYUoNJM+Zg/VSOGLdp47FlJDDmfFkyAAdm6r
	g4FzZ+Stik+2xVIKiqMrI8z/l3LYthRpPUntxCg==
X-Google-Smtp-Source: AGHT+IFIfxq9+xDx7PZBV2IwVM3jqEqcPFmqwd/ztphHxEMC9D5lQLpx2XzRzy5zRcisVSixrYav/q4IK5ZlN2o4DbQ=
X-Received: by 2002:a05:6402:84c:b0:5c9:4664:e699 with SMTP id
 4fb4d7f45d1cf-5c948d5117fmr1490793a12.23.1728648074858; Fri, 11 Oct 2024
 05:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011055700.4142694-1-howardchu95@gmail.com>
In-Reply-To: <20241011055700.4142694-1-howardchu95@gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 11 Oct 2024 13:01:03 +0100
Message-ID: <CAENh_STz6DxQ483c4pwX=Gwfwy_iKSQno+zHmXXQ3N0pOpxcqw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Delete unused Intel CQM test
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 6:57=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> As Ian Rogers <irogers@google.com> pointed out, intel-cqm.c is neither
> used nor built. It was deleted in the following commit:
>
> commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifie=
r to files with no license")
>
> However, it resurfaced soon after in the following commit:
>
> commit 5c9295bfe6f5 ("perf tests: Remove Intel CQM perf test")
>
> It should be deleted once and for all.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/arch/x86/tests/intel-cqm.c | 128 --------------------------
>  1 file changed, 128 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/tests/intel-cqm.c

Reviewed-by: Matt Fleming <mfleming@cloudflare.com>


Return-Path: <linux-kernel+bounces-279817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB794C230
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A515E28956A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE0A18F2FE;
	Thu,  8 Aug 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTXm0nYR"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D506F31E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132863; cv=none; b=rRElIIf4XpjWb7N73X0zVEvpVFJZUQ2rUr/bnyBkLMMzOCW9j6Aw4q8TF+0N8hXaqslgiMa+0phTENc0fQpQtq+Leavn5q6Aex1tCXXMDWnbgatykZMN+7T4gTtu9EvhIl+Qxz62bRWwFrlSUUbh2RtPPQnsQGKPiSSPf8QRhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132863; c=relaxed/simple;
	bh=VBqbzIbROQvyEHT5bw53ddnDLfUpvA9+eMFijb3vQRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xqn9/wB4sJjqlwUAwwHMbtCMh9XtbqUC1rYj6nnYVbOfTsaeVvEJ9EEeIONcw6betcEN4KI8aFSVaeVvuArJtM4lv5gbMccCSIbW0unlQGXAJ/Mdul9JiRbEKDvXhv+tvgWgEHwL9WvRfB51Et+d2XJClsVCdE86rhYGp8Lg5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTXm0nYR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc4aff530dso241395ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723132862; x=1723737662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBqbzIbROQvyEHT5bw53ddnDLfUpvA9+eMFijb3vQRM=;
        b=XTXm0nYRJ/gsnxFuKDFajhPgnHq6iAWoQNxR9NIhpQUjVbspruSEp3Mp8ZoEPrQRmi
         05k5mlgPzClVihHD3TSO1LpFaU6SvbmwXVeDawYyObl0EEY4+5Ba65Q7bQTYaNdKOcuz
         tKkw1ct+GJY7E5wmJ9eyo2Q/zsVffNUFwmx3Q6DHii9xNpBrv+EQby15sxUcFKfXAuiu
         mpxyFEZW6I8rlqsMuVcb09heoi3lmWfZNNRpb2Yi1ftGqestZmkBkZ5xoHFe4Weq8TcO
         Pcuh/io6MMUECVnP90QCgj9iqmjo4kqjVttLz6c1jRys8YZb8PlOR+gBJSpGf3vRQXQb
         7Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132862; x=1723737662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBqbzIbROQvyEHT5bw53ddnDLfUpvA9+eMFijb3vQRM=;
        b=nCfOgn8/53CWNAMWCMfQ9NQCvOZqHHyTGlrQ2r+C/TKAG9cIwyAusuC8jKRWmZyBsh
         6A0eddI1VUK6LlLGGbKAbcE7XFNSV3+IGJS0IpsUvuvJ6zrAnMs+S33zt19QG7DUMbgk
         Cms+48iSN8SkPKxtKEmd38AdERPGSf6pk/NJFq5JnGnY9bs60PkkpNRQsWgPToh1/4Tp
         6kGpIQ5DLQUwZYrufG/985sdo4tzcTaGvevgasDsiiXYS589JNpK9zg0mdAPe01AUrkq
         JH1nDAtMWQeDCSIxXCIXgVmhdozizMNPBH7XAT0viaACR7cdkcdi/8v4Y1/H8n6rMwzj
         b3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXn+ozsges/t146wibxECNgQlHrUECjIYf3yPkevQBYlDOcKSCoko2B2gN3pYPeIEqobnfPri9meOCisQOu1jiFi4aKQ0pA13DCq11U
X-Gm-Message-State: AOJu0YxC2vN6LKgFiR2ApMgPEuNW5Pr8ZXTZEo5TEmG1xdGSPrm/P49E
	VatMiZBa27cNfR5+9EJcpGtpnhvCdhtrctK8lZf8iwQg6p4CLJnn+htUfa8OrEYwdUzu1le6Adj
	gq6F4FylkayL6ozFPPGO6zLIBoBW8Pv+EskNw
X-Google-Smtp-Source: AGHT+IFDrJ4UOWHw7eb6E44AFhKuYAr1VjOccg30ydUAzQ770g93E+SKdMbs/I0NNZ8zJmUujgBHwL2YqpUlyOixnag=
X-Received: by 2002:a17:903:2346:b0:1fc:548f:6533 with SMTP id
 d9443c01a7336-200947f57bamr2996385ad.3.1723132861330; Thu, 08 Aug 2024
 09:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808054644.1286065-1-irogers@google.com> <20240808054644.1286065-2-irogers@google.com>
 <ZrTXftup0H46R8WK@x1>
In-Reply-To: <ZrTXftup0H46R8WK@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Aug 2024 09:00:49 -0700
Message-ID: <CAP-5=fUq+yNNyg4Xn6aOoEBiXwJfO6CNCz8JhaA2jAxQg+MKKQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Add set of perf record LBR tests
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Anne Macedo <retpolanne@posteo.net>, Changbin Du <changbin.du@huawei.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:34=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
[snip]
> -if [ ! -f /sys/devices/cpu/caps/branches ]
> +if [ ! -f /sys/devices/cpu/caps/branches -a ! -f /sys/devices/cpu_core/c=
aps/branches ]

Adding this lgtm, thanks for testing.

Ian


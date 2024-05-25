Return-Path: <linux-kernel+bounces-189541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A738CF169
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06302815F1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FBF128807;
	Sat, 25 May 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dq4AIZiD"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEF056B7A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716671686; cv=none; b=u1/FQQIJ1trKoFCjJrE0ayZ1UhIkIQABmalNKzvEKy//oovzas1oXKJuJnn27XwWq/hXOt6VmGM+LdmhajrDFYGtT7oMCyOjcH6587Qunvd7nnaDD419GmfEc0eWAUw5ejHK4WwOc/WaMMa5qRj6bFTZbriIzViztvHa4LHucC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716671686; c=relaxed/simple;
	bh=JMizNw8LZD+J4U0EfhBVCA61BX3XTunM8FLpavjz9OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXsdDDNKAJ3sv0fF95e0RQu+uUHUo6oM5olzBqetxPJzyRtRabxTM87XsyR7x6P9MV1zpehTEuJhPfVLPynzQHtRKx0KY7/D32+19R0pZcvXhKcLWSZN/sxgCIgH4+2D2WXZix2eBMLFsyKiAlN6bnQpGJvqLv7h/zzKsVfMizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dq4AIZiD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cc765c29so495609566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716671683; x=1717276483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NdDqgCoGhD8QyzBd5Ssu/diBB7ZMRx12p10jgxF/V2w=;
        b=Dq4AIZiDyfOj604GTnfUN+2DEzz0vU2Fn1gNHR0kMCFtjppEmbU2wMiHjKLJ+UftfK
         IJoHva3HEo0aokkm/y0RTLaXxXqalMYmcg1oHGPNz2Eo4AkYF6k8VcqSnkRmU2wxYF6y
         gVKsISUf8gKvaKFWBWROK3LsMOK1Obh7GejMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716671683; x=1717276483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdDqgCoGhD8QyzBd5Ssu/diBB7ZMRx12p10jgxF/V2w=;
        b=lJ8/7etUKDmlumeTgguHIiKt1fB7KtokHSqHtetxos1FUgB4u+X0LvsKsm3YOU4ZcA
         t6KRrayOX67EzTCtCBIXeTQBhM2CZa0NQgBDFgj9M1H5xzABQtpmenkZGmLTPmIax9M8
         e2M5bvIerFerwiv9HpnVplwLNzzsoPlrSpUBtWhIK/hbifVmF8otZySuYMNs647R2dS9
         mdKg3f6LcTcvgyUd41+PHVmVufY3NSouZZXRSVye2wpWKcZQzwspIT2t2tDnuDVBAjK3
         NQWMJBeFXGbqfQACLlqUc/ZKtN9txgEwOTEBW7z+gyweduWxVdICWGj+FLsa1mw5/eUu
         k0ww==
X-Forwarded-Encrypted: i=1; AJvYcCXjo/ZnRSZZPhOfJ6ab0sNPijZNyDDlyU7BAHU0l5EJF4uSj3M0Q8gFy2UzCmEQn6fB7tnhOV8Fw3OSlyWf5psH4eT46TM1D1m3pRkc
X-Gm-Message-State: AOJu0YxXh0bWyBd1Q7BU3j1VrBhEEpIhG7U5gGwGZuP6glTIYh9hMMP1
	5u+f+XPst0w8CYNv6DuFpbvoYCo3wCInF6427jLULh2Zz6AUBOt8tHFHVSuTr9IqgAaAEeyODwa
	dVi5JEg==
X-Google-Smtp-Source: AGHT+IFGdNMHrIWCQDXv4ybc4ZHRAVwP3cAj5pLzvsklWVX8VRVuCsdvhv97+WQpADBNuXh6VtLqZA==
X-Received: by 2002:a17:906:888:b0:a59:bc75:5000 with SMTP id a640c23a62f3a-a62642da520mr377912266b.12.1716671683228;
        Sat, 25 May 2024 14:14:43 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f7bcsm286927466b.129.2024.05.25.14.14.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 14:14:43 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so1416176866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:14:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5yUu+N6cwZecTlMoUc4FFh/DyeLOKCSAFJo5P1Z1Z3dyhEpPvV7ibwhJWkhGF8ZNWxAg8SW19jTZpb1qaAZ5UqvSZkcYhDteckCLs
X-Received: by 2002:a17:906:3b0e:b0:a59:be21:3577 with SMTP id
 a640c23a62f3a-a62649be4d3mr325715366b.43.1716671682411; Sat, 25 May 2024
 14:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 14:14:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
Message-ID: <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 09:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This makes 'perf record' work for me again.

Oh, wait, no it doesn't.

It makes just the plain "perf record" without any arguments work,
which was what I was testing because I was lazy.

So now

    $ perf record sleep 1

works fine. But

    $ perf record -e cycles:pp sleep 1

is still completely broken (with or without ":p" and ":pp").

So no. That still needs to be fixed, or the whole "prefer sysfs/JSON
by default" needs to be reverted.

               Linus


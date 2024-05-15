Return-Path: <linux-kernel+bounces-180228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C78C6BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E401C221DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9CB15884F;
	Wed, 15 May 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYahn0dK"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66534158855
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795247; cv=none; b=pwpQEM7SLWZUHkZL6i3KCgJqY35mc8q8Z5ILpfaCvr3cbmj5ETlj1bimTHmqAt6EvxDx0iKr28271ZE9WV9p/caQbnPYFm6gHeocEl1CjAir9TgPosjOGG5rKK28oBLPzZ3c0TQLf3N2Fb7UUHG0O1nw/ljdZXaAeKFZfS7Kz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795247; c=relaxed/simple;
	bh=/zCcP1X1di1bJ8igzkeKa8QLS6+W1fjEL6lp+hEgy6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATjOHXwtBsyY17zhbJH6AiZbG+orfqas6Wf0A+hmCgvbICoUfQl4hhfWBmSqHfidUec1f3JGd6DiyfVKLMtgpT7hW8JZlmRuN+59ivBJCkY1Pi2uufG31yWCdsGUnyndm/S/7NEROJLl2nU0F9AgIjd7b6RoI7EsjVBKXRjBtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYahn0dK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso28706a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715795244; x=1716400044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zCcP1X1di1bJ8igzkeKa8QLS6+W1fjEL6lp+hEgy6k=;
        b=xYahn0dKtXhY820/F6CDXFoP2gqTb3Hyfibp5IhGBY3fywmEfVxRVozqL6hItqnjnO
         73RLzB7KCmKM0I3TXcX/6+7KP/ldHnAKgdM57sUa2XOpDyDsCQGCBT/QAhjBWCgfm/V9
         u27KFFgy07GkEfUxR4YN+0E6bH0YfVYZKH4RG1WXz4bVxJAUJGSGaxXNh5IVF/r5F0Lr
         7DyJouQ+vssBpPZW2Qlx/9mMMOVzgCu4C4UpFSti3OYZkOL/j5JYtOSOt6b6GhsTF1/t
         jeuqic9Jwm+9EhQbl9/vwBfrxgxlRkOecOmKXKHIpZ6UHf4OnFBlF6olubIFhO5fAmzo
         qTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795244; x=1716400044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zCcP1X1di1bJ8igzkeKa8QLS6+W1fjEL6lp+hEgy6k=;
        b=gSXLfHIgUiEBma9z2l5tZTrQ3qImBjQ8rQEL7YA8xkG99Af8RJ8H1TscvQsfHWn/sB
         ndpA0XGmMvwrnJSrTkLeZbdVTlTYnX+fYIV0a8DEXisgbRLxfj7/UExh5Fjcxcbk+6o1
         vYQsBKW6h+vfQU8iripIERY8UyVuVztZjAWwU/OBMe1imKXaQSNHT9ubDkcVAWeWyFUC
         lxFLwIfPJANB65YUaH3mkbHWVBBggZQpFBD6nMkFfGETnPL+3zQlQ83SGEHqy7UcpbkQ
         GVIFIhhnNlq9KPpQZjSaABTut24W6aap7sjxo/pGp9t8Dbno4/CO+mqCV9Pzp5AryO7H
         ONTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1ScKodaqc1hs0JzilP1Ur52Q9Ik6qDhL7fSJXwcFDlQI9ymjw74i9vEu1NCo0O9IU7kPLXQNLOtGCVEYq3FEPizTey3qQzzSrRi+j
X-Gm-Message-State: AOJu0YwBE8vp4a0HicKrVNe/u5Yr9eUZf7eP/VA+GM8EftZCFfq26ile
	SBedPFpBiBx3hJhwbenL0TI0sHlCOORxQqt2yi8YQexQJgXvGeLfqDeFbAEDgSOw1S8xADMihB+
	hEpXrORB7zZWfF5nwTpcxChodAPSN45hegdU=
X-Google-Smtp-Source: AGHT+IGAXYIvp/5ckzCX34ddHzC1hiYy+B64kYba2ozl+yuCpUfE1UDiQpoL6EmGIVsWJBofAQCpERhDXWItJwqAXeM=
X-Received: by 2002:a50:cb8c:0:b0:573:438c:778d with SMTP id
 4fb4d7f45d1cf-574ae3c1280mr810495a12.1.1715795243503; Wed, 15 May 2024
 10:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com> <20240510191423.2297538-4-yabinc@google.com>
 <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com> <20240515085840.GD40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240515085840.GD40213@noisy.programming.kicks-ass.net>
From: Yabin Cui <yabinc@google.com>
Date: Wed, 15 May 2024 10:47:11 -0700
Message-ID: <CALJ9ZPOr7Jg8Vic9Ap5+jYqJVaLeV3DEJm3dAGBCLB9DL5EusQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] perf/core: Check sample_type in perf_sample_save_brstack
To: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 1:58=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, May 10, 2024 at 02:29:58PM -0700, Namhyung Kim wrote:
> > On Fri, May 10, 2024 at 12:14=E2=80=AFPM Yabin Cui <yabinc@google.com> =
wrote:
> > >
> > > Check sample_type in perf_sample_save_brstack() to prevent
> > > saving branch stack data when it isn't required.
> > >
> > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Yabin Cui <yabinc@google.com>
> >
> > It seems powerpc has the similar bug, then you need this:
> >
> > Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper"=
)
>
> Is this really a bug? AFAICT it just does unneeded work, no?

It's not a bug. As I replied to Namhyuang, the powerpc code checks
sample_type before calling perf_sample_save_brstack().


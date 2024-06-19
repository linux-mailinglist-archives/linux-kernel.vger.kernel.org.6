Return-Path: <linux-kernel+bounces-221568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7690F591
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE056282C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312815696E;
	Wed, 19 Jun 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1uIjQxm"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289E20DCB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819843; cv=none; b=grAQ4+qONancJPdAkMI7yZjVPRvF5yeV69WCgAUyAIZhjdJgQ4XZf3OLnxANIUw6us6rCVF/yHwcmaq7fUWZsp3ACesFBNDTvZUqRZtUC6laDQB+xkNWhxldwyv2s7Zimt1+KppST9ZdtNHON4+fFoZnjoKzSIAm2IdKlRm43RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819843; c=relaxed/simple;
	bh=cOST1LD2L/IX7IsCCJXvuJQMIXuM5uZcCpA50xbBDuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzZ2kb9bRLigfPXyXwu8jsg0Maq3woiEJEVq9d9NKL0gECWQQ939EsqeEEO0qpN32uFhEcEjLWXB7ktMkvtIR6Ld8mGj07eWBUNRdtDZNNBtCZP8mBiP4UIw+3pUkPtfxgGsBbTFTa8mphIrT2jlox8SwEp9glI5AKw9SuMvoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1uIjQxm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso74691e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718819840; x=1719424640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8Kayv4g6koIn38mbeG+B2azD4AgtkWZC+a18KeR3Ss=;
        b=W1uIjQxmaOD/MhrLCRSRm0fbIco7Hp0GIDfsFINT93DZoJTi1bdrr+r8ywfP+RAbmX
         /3N9YFSTNOHmbhtkiq9bbGR0Q/54Yo2vX5nWVtvbdocxMUVS5tw4J+zjJZaKu57LW42L
         fOr4f6xGI8C4hwZMSlZ4F5T7MvvSJUu2DwCYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819840; x=1719424640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8Kayv4g6koIn38mbeG+B2azD4AgtkWZC+a18KeR3Ss=;
        b=snqHGf2Qmi8xOmE51DmK6qhjmH7w41hSWHGy3iqv6FXRMik+bACJQ6SE3wnydpFt9Y
         WLXZzcH9fuV3paK1C71GKCCrnlb0MKMvyjtvskWLW/GBDIfLh+nuZuseeO0vanRN8xEX
         XkmLSt1jPEp7QCU71QhWk6W79Y+xTlyLyJhLfTGShkj9QzIZdhOn8pBVhSkXeUznLByI
         XhOaQEZSnC9YlQGEQMRFPgYEwnaoIAmU0Vhy88SwF4ti4MPvtFluVOfxA/EEQ/uGbpFQ
         W4wb3KFQIW05scIF+7L+impk69JVWIoDXd8VMbhBC6vF7y5ulR8SEX+gIlH61+Sw5s16
         Z6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJBGkntz6Ef7KpTmYwIKANMFMRTJhcBDhnXtgHkIh4kmg95ZO1GOHIxRzPhuccHNLtkjXQaB2NtDpnZeEA1iMTCCJ7yfDqLJr8VJqh
X-Gm-Message-State: AOJu0YwuNZnR97nBfmsvILEv1hhG7/WwUzyYXClHJ3fKK9dp/9k3QbAG
	NXumH3oEYlGcxwJJvpc7bdM7Bc64Jelh0UXQ2d1l1UABaYVVfx/UcBj3Hvg6hwa7QzruseVQlPP
	HLNCsmOxEryk/CFXWruzrniGmuKeYaV8eYJY=
X-Google-Smtp-Source: AGHT+IEgCS86JnQXRyN0nE0BGQEBVqiPjOVoriIOkC3n4X0reg2XiAoY/sbyO3Xu8SPKVUrmNpIW/ln1WidijI4MmP4=
X-Received: by 2002:a05:6512:3f0d:b0:52c:818c:13b8 with SMTP id
 2adb3069b0e04-52ccaa587c8mr2438161e87.4.1718819839758; Wed, 19 Jun 2024
 10:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618093656.1944210-1-takayas@chromium.org> <20240618155320.75807db5@rorschach.local.home>
In-Reply-To: <20240618155320.75807db5@rorschach.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Thu, 20 Jun 2024 02:57:08 +0900
Message-ID: <CAH9xa6cNT6VwQoQwcop3uLOHLF8xqX=D8HQ7x4C1Aw3qNr=2_A@mail.gmail.com>
Subject: Re: [PATCH] filemap: add trace events for get_pages, map_pages, and fault
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Junichi Uekawa <uekawa@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Thanks Steven for trying it out.

> I can see it bringing down the number of pages needed to be saved dramatically.

Yes, I agree.
However, note that wc does not count the size of the page caches
correctly since 'get_map_pages' gives you a range. In your example of
the less command, actually the total sizes of page_cache_size and
get_map_pages look the same.

Instead of less, running a large binary such as Chrome (232MB) gives
us a better example. '# trace-cmd record -e filemap chrome --version'
showed 58% reduction from 42MB to 17MB in my environment.
- Total size of mm_filemap_add_to_page_cache: 42,958,848 bytes
- With mm_filemap_map_pages and mm_filemap_get_pages: 17,993,728 bytes

By the way,  'mm_filemap_map_pages' traces a range requested to
populate, which includes pages that are not in caches yet and thus are
skipped. So, you need to calculate the intersection with
mm_filemap_add_to_page_cache to see page caches that are actually
mapped.
I'm wondering if we should put a trace event per each successful page
mapping event as mm_filemap_add_to_page_cache does, by putting an
event inside the page map loop.


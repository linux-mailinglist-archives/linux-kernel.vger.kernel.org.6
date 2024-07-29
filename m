Return-Path: <linux-kernel+bounces-266327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63493FE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5621C21A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1BB18732C;
	Mon, 29 Jul 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HFuyMU+q"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423A84D34
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281003; cv=none; b=b594W9wyBs43v21/EOuJngnU/sOXX3vIdfP0lhsvmc9D8DaZQ8UO9ChmCWiNnUBKFaf+cFNyCqqMd8kKjS35ti6ELHgAfXL0TdVd0W7Wf/uJyvuilCrffrKxffFjvQZ4KRTscbzgnROjL91ez9G6O2aim20uV6yHb+aotAQtNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281003; c=relaxed/simple;
	bh=0ZPF5XxBhawJJNAaEBKLMVKkJVqhDkldF1Ekpj1VPtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdOafFCugnHTZUiLWohbWD4J+N08qr+AdBwb2M816ADbF0JmiG1JNAqSSxaYr3zgZc3NI0pUJLUKQG2QhusFOMOpGLCzS2StBPbGH+r0tTBLoOL/FZFNS7GxY5jC4LddMzQs4C2flUiNg813Ve7s+fu4EvXxd95/D0WWD2iYlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HFuyMU+q; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2d582e31so46711621fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722281000; x=1722885800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tC6PsIAv+68m4G2a/kjNmJD110y3Ys7wVFjTKwuf8hs=;
        b=HFuyMU+qE0odeV048ldWW01nhEONsc23PtmiPWLi6cdoTigqdNqCN8yg60QH+jqbeS
         VL2wjqwaKMAMqcUkyKi0jiOsL/BxO3EjSi5g7X85J0OVLcVmyk+ueCgEjJfDkLqBUE0Z
         nTtQQ2jrLlJa2QSxOWZqENDaORk1TuG0VxexY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281000; x=1722885800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tC6PsIAv+68m4G2a/kjNmJD110y3Ys7wVFjTKwuf8hs=;
        b=oQK1Y9THhX7jYGXtInCgku/Trv1fiRogkdIESy47cnJ1+/8FxXACnvZGtno8E2749r
         Hq3IT3DhzCtlDY3EZ2ot84inuNVVgX40pTKPejdinTdWydY9A7MnyyESlRVpBDwGMBEV
         f5OHWMbHy6wV1Qb9XLZj/hi/2o5E4UuX+hkSdLSIjgDIT4GTy7Qs/OPcoYeuxVzfqnvj
         3H4cDT1/hkIGCY4ZMYXXdPwhIv0QyGAXcgALOSFY+U1D1b1jEdjcDSi4eZY0J5h7FshT
         egjpRpNmhrQDBdQOTPMUo99WfJw13qbo9UpjeJATyHZzVDo4WGf+ENqDybc5QK1aVSii
         Nwgw==
X-Gm-Message-State: AOJu0YwV0etJoTOC5X9dgIszMVH9onmMZZ9DU7wAkLTIwhGmKlsKhHqf
	1m0djYHPjGSX36BgVUNdTiLlMnq2u47DNdAvXKbRMV54D6Fky0NNH7zQUu5mQqChdsBSB8+BwQE
	KH2MVog==
X-Google-Smtp-Source: AGHT+IFkqaaOYgL1gVCjtsczbfAq4n9BNgX2efGtLLJFbBOCiLMrXcTnI34zrnp3HB13BaoNuAmSEw==
X-Received: by 2002:a2e:8053:0:b0:2ef:564c:9b66 with SMTP id 38308e7fff4ca-2f12ee579a3mr58987171fa.30.1722280999702;
        Mon, 29 Jul 2024 12:23:19 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f146676721sm112531fa.106.2024.07.29.12.23.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:23:18 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so6092568e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:23:18 -0700 (PDT)
X-Received: by 2002:ac2:5226:0:b0:52e:9b9f:9377 with SMTP id
 2adb3069b0e04-5309b272c4fmr4975408e87.21.1722280998454; Mon, 29 Jul 2024
 12:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
In-Reply-To: <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 12:23:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
Message-ID: <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 08:29, Guenter Roeck <linux@roeck-us.net> wrote:
>
> In summary, quite impressive in a negative sense.

Grr. I think a lot of the build failures end up being due to commit
466e4d801cd4 ("task_work: Add TWA_NMI_CURRENT as an additional notify
mode") depending on IRQ_WORK, and that not existing everywhere.

I pushed out a tentative fix as commit cec6937dd1aa ("task_work: make
TWA_NMI_CURRENT handling conditional on IRQ_WORK"). I haven't set up a
build environment for those tiny targets, but it looked fairly
straightforward.

I think that explains at least most of the 'tinyconfig' build failures.

Not super-happy about how people apparently were discussing the build
failures for a long time, and didn't even bother mentioning them in
the pull requests. That broken commit came in through the perf-core
pull from Ingo.

And that fix (if it fixes it - I think it will) still leaves the alpha
allmodconfig build and all the failed tests.

I'll take a look.

              Linus


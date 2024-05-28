Return-Path: <linux-kernel+bounces-193040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C568D25F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEAB1C231A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8C178CF1;
	Tue, 28 May 2024 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GwcNXMnX"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040875809
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928423; cv=none; b=nwPQs7lSxDPISPHWzOdypB7W/Xc7uFSvUyg9ayy8Ko59kh4D1pEHhZMFW5cU0WsWnjnHOlRe5JfDh4ALO+NTGrOvEZQfahn4zeHFPBqqBhf5cNnccqetbGFDGY95edNTbecLc5i1vnIRncSZQENFAaclUGixAPsiiEkG/9QGbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928423; c=relaxed/simple;
	bh=aEL25iZmgeF0VL7mEOr0A6fyqaqdxr20iS+3Q0nmp5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8mGpsOqIwPRp/9YUvRb/pg19H9uSX5CfcVBPTvrt03RyrYWpYghhuMW9NatReiZO/GxNeaZJEuJhhYZ4soIT6Z8uTKVGPB4JB6kosSYcwoG62IV41yZHkrGzmFVBE7c8J1BeAaVDJ+glYVHWGCwypGY6/SeuRSg1x/J62NUz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GwcNXMnX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a626919d19dso36614966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716928420; x=1717533220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0cw2VGZNkMpKSutYrXYjUYeHF/K9pi3s6qLlxaYukgM=;
        b=GwcNXMnX3DghfIPcrFNbFYCm7AAC1Kea2l3anl1n82SgOZjD67B0D+yUhc7T4D+jEw
         e3hmmRC1XvzHq7ED5oz2SLQElvHWM5zuuOscJDgudPz/oQ1u5iLnRqidm2Df1i3QzuG5
         QtmJ7llw8IVJAprvT+XLeuAXtWZaeznUx3CPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928420; x=1717533220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cw2VGZNkMpKSutYrXYjUYeHF/K9pi3s6qLlxaYukgM=;
        b=Bx1Wz1MvukuN/jOnW8FvfbnwuAiXdBp81k0chyBPpKF8gATNZVkxdM66A00shp+IUg
         VqM8FE2iqxlCsILqMRSRMZeGaLuprtBu8f/rCo8c6P12kTUJDEx/vS5De3vv+zq+CSmW
         smWAEzu88cdgHNvmQNTcoV3GuJ/WCvoiM/kFBLltm56MSoEWMaS0/gSDws8BAoJ7u9x6
         kRBW60UylVKi18yssR3AK3VUEadIVwDmRVJd4yx/Uhw/rMEetErtjZHt5FpVQRWnLShH
         Vs2pEx5NUD/pDx2D3dBs/cRbepjtoVdryyujQfl2zb4rxiqs7UdPwP7CWVg1wEWe2XGI
         Y1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA9cdxJ+6hEiP2O30W2/Atp7tIm2ArzocLm5X8/lsu/VzioZ72Whs9HeATrB+2GBzvYrgEEZxMv8JyOh6D7BUR7T9foO1F7D2SOVvd
X-Gm-Message-State: AOJu0YwGd4lKqFG8X7zZHXm+qU+/slaRdlwoM6boDflamQ48d7Ke4HLT
	YyD687tvbKOTzxgUt0x5XlrkdFUpmq5BG6oAtAW2xiNtQ4UCDJ/khM5BYogtDAT/FMNetKa3l7J
	IqPP7aA==
X-Google-Smtp-Source: AGHT+IELKCzJDebiTSyJS1iJNL+6pVh/JyE3TQml66Oc5r/hLkvoeAAinn2v7+xf5nS7+IfnN1E0CQ==
X-Received: by 2002:a17:906:417:b0:a55:5520:f43f with SMTP id a640c23a62f3a-a642d37e3famr12101266b.10.1716928420391;
        Tue, 28 May 2024 13:33:40 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a634e48481esm82566766b.224.2024.05.28.13.33.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 13:33:39 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5789733769dso332199a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:33:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWo8wFjQHprD6IDHK1WF9+WbHlueBVfZbbJcWMlpCoqDP5TS1APXcw/5jTsR5DhOXAyCpRL6xtxEzZRCK2+MGAyktSoOhJqZvZ2l+LG
X-Received: by 2002:a17:907:174a:b0:a59:c807:72d3 with SMTP id
 a640c23a62f3a-a642d6af823mr14314466b.17.1716928419187; Tue, 28 May 2024
 13:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
 <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
 <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
 <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
 <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com> <CAP-5=fUwcgsB-AruAmGhw6WVNViMaiJ_iHWuZ8=ksrN7Y3V9QQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUwcgsB-AruAmGhw6WVNViMaiJ_iHWuZ8=ksrN7Y3V9QQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 13:33:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtb7y-bEh7tPDvDWru7ZKQ8-KMjZ53Tsk37zsPPdwXbA@mail.gmail.com>
Message-ID: <CAHk-=wgtb7y-bEh7tPDvDWru7ZKQ8-KMjZ53Tsk37zsPPdwXbA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 13:03, Ian Rogers <irogers@google.com> wrote:
>
> But you've traded a fix for one set of users with a fix for another.

No.

You don't seem to understand what "regression" means.

The "no regressions" rule is that we do not introduce NEW bugs.

It *literally* came about because we had an endless dance of "fix two
bugs, introduce one new one", and that then resulted in a system that
you cannot TRUST.

We had years of this with suspend/resume in particular, where the
argument was always exactly "this fixed many more systems" when
something else broke.

But because random other things kept breaking, it meant that people
couldn't upgrade the kernel and feel safe about it.

Your old laptop might no longer work, because somebody had deemed that
all those *new* laptops were more important.

So I introduced that "no regressions" rule something like two decades
ago, because people need to be able to update their kernel without
fear of something they relied on suddenly stopping to work.

The fact that the "suddenly stopped working" may be a minority DOES
NOT MATTER ONE WHIT.

Stability matters.

It's MUCH MUCH better to have legacy bad behavior that you never dealt
with correctly, than to introduce *new* bugs that hit something that
used to work.

So something that "perf" has never done correctly is simply not an issue.

You deal with that by saying "that has never worked properly before either".

You might even document it along with (hopefully) possible workarounds.

The whole "one step forward, two steps back" is absolutely fine if you
are line dancing.

But we're not line dancing.

We take it slow and steady, and if you can't fix something without
breaking something else, then that thing simply does not get fixed.

And there are always exceptions. Sometimes something may need to be
broken because it's an acute security issue.

And if it takes a year for somebody to find a regression, and in the
meantime others have started relying on the new behavior, then at some
point it's a "yes, that's a regression, but it wasn't reported in a
timely enough manner".

And sometimes the use-case is basically a museum machine and we retire
support for it because such a machine should use museum software too.

So it's not like it's some long-term absolute guarantee. But it
absolutely *is* the #1 rule in the kernel.

A fix that breaks something else is not a fix at all.

And in this case, when the regression was noted within days, and
within the merge window, there's simply no discussion about it.

              Linus


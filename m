Return-Path: <linux-kernel+bounces-192969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0418D250E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1461C26AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC5178CE8;
	Tue, 28 May 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uago/qVD"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C092628C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925362; cv=none; b=gZKcyJUJbz58JMjeqNQu6m3DoE0KX4zgcLLdM1d+2XG/zvjhzR38spVDOzap++nMIGUwPYz53XWSIxkDN99xoGnu9P2kP/1wIwItvfUHtb/SuOtU8ryqBSaZ5MCCJ6lfM3ehoBDw7OwTOcm0nIMkFhCs0q+AlwWER2TOsIl1IoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925362; c=relaxed/simple;
	bh=k581Cx2OkQB8gaY0y6bcYlk/ITECUZ+zQX57Yhe7gKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X67W250l6DcMlZjMCvPVu3tDVmbx+H/lZq+NmJoY0kjOT7AifP2MN1sxi5pwdx1+fYJLgvXa4LvoE8tq9gDoC356SzahtfBWVShQpaEioiyJt9fQje0e2md7UO9rUmyRP4rKXhPm+oD5PbK4DgEtlGB/N3SLhk1cuOnYD+cO9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uago/qVD; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso17747891fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716925359; x=1717530159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tnSiUD2gH9HDmHjSHl2kkucSe6ethci8IQ5VxoD7g98=;
        b=Uago/qVDhLLbip5iwuAtOJURVQ4cy0bw9HoD1LMgTqyebge23HKKr+erqaFZQKIsAe
         M5U+mEbmvIenoELGmT63+SQuCtojBbqUrBoK8FQSsSwmhxKvKtM3g2+sy0FsJ+l2o1Tg
         PnFKwvnRzPXaz47+BWqVLLbWuGzLHPqi3Ll+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925359; x=1717530159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnSiUD2gH9HDmHjSHl2kkucSe6ethci8IQ5VxoD7g98=;
        b=ZqIv9M2J4Rz4IHi267AFq0QHiExn8fwXTAm6mlE63MsGyaOWjpjDc0Vv/T5Bp/2jJ9
         KeLLqRyLWveXOGzBTkIfoNlxL9u8G/kWooesSRlVWKfiO7js5Ivit6BZ7LNK4E2bwnf7
         igGWfxt9QochiqGa06jD85TwPEpfJ2uf4h0yGw/s11SeiVHd2UvsuAkab0oli1Jp1jw2
         2Grevdj7FW0TNeBAi4r2vA+2pnAMSfaGm18VC5AyduBzAzNZ6u3L5hqVIRzzYZyJ6qoy
         AmQpgyFa4A1MfzrR5vDUbFqoJGnMiXixmcyE9EiLcnuiNuGeN0YuigSekE4a40OxG1v/
         ATvw==
X-Forwarded-Encrypted: i=1; AJvYcCWAc6FZL4Dvmk5UPS3HMBm+EWYEV41d4/3/F20RusBschEHEH2MLo6s6BP/iINVOfGQCZ8dAbxzdfXvAU8bo5pPlqORli9gVARQLgDg
X-Gm-Message-State: AOJu0YxBTOrBLkvedJa3sM/mg7NEL5nuqICx6PAFyM7JrQrZloEdTmRz
	U4+xLLfazps7qfNNs2xYC5uDvY/hCwUuFbq3Os2aM1wrZMfk952d+ydn5VJ93LG3mskKc2QoMoA
	/628PdA==
X-Google-Smtp-Source: AGHT+IGFztiQl3TD74fqd5GnB8ZCmjpDXC+GjULtmPxcqCQvyPLY0CwgVpe1ZjrEQDL5AwJrNhBzgQ==
X-Received: by 2002:a2e:901a:0:b0:2e9:8b34:1163 with SMTP id 38308e7fff4ca-2e98b34121fmr17963901fa.37.1716925358625;
        Tue, 28 May 2024 12:42:38 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcd8e21sm23471571fa.43.2024.05.28.12.42.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 12:42:38 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e9819a630fso19559651fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:42:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9Vc+gI7+Gk/I1D1HH3bQ5TGpCtR9BJXDkW9Y00sxC+LXUcCkZNbGfk1MKga8d4wd11NkkF6a5i4quu+2442GjRqtFs2ONojekjUaC
X-Received: by 2002:a19:6a05:0:b0:52a:7d01:84cd with SMTP id
 2adb3069b0e04-52a7d0185c6mr39607e87.30.1716925357626; Tue, 28 May 2024
 12:42:37 -0700 (PDT)
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
 <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com> <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
In-Reply-To: <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 12:42:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
Message-ID: <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
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

On Tue, 28 May 2024 at 11:59, Ian Rogers <irogers@google.com> wrote:
>
> But nobody else ever reported the issue, even ARM who maintain the PMU
> driver whose event name conflicts. This hasn't been a problem for
> anybody else.

I'm not blaming you for having had a bug.

I'm blaming you for NOT DEALING WITH THE BUG APPROPRIATELY.

I reported the bug and bisected it four days ago.

Taking some time to fix the bug is fine.

But that's not what you've been doing.

Since then, pretty much ALL you have done is argue about irrelevant
thingas that weren't about the regression in question.

The fact that you still don't agree, having broken documented
behavior, and still argue against just having it fixed, I can't do
anything about.

> So I think the revert is a real regression for a larger user base.

I didn't have much choice, did I? You refuse to even acknowledge the
bug I hit. I'd have been happy if you had just fixed the bug. You
didn't.  You just argued.

> There is a testing issue here, not least I don't possess an Apple ARM
> machine.

This is not an Apple ARM machine. I have one of those too, but this
isn't it. It's an Ampere Computing system, based on an ARM Neoverse N1
(and the ARM PMU's both for the core and for the interconnect).

But that is pretty much irrelevant by now.

The issue is that you don't fix bugs you leave behind, forcing the revert.

I'm happy to test any patches. But I'm done arguing. The "cycles"
thing needs to work. This is not a "pretty please".

This is a "if you can't understand that and acknowledge that without
arguing, just work on something else, ok?"

                  Linus


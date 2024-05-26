Return-Path: <linux-kernel+bounces-189781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC18CF4D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258F3281275
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1E1863C;
	Sun, 26 May 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C6A6dTaJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB1417730
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716739923; cv=none; b=gXdliCGY1JBEToaQi5CbHjluaE3YnWGu5Db/AzIyoN30SFZRkw6pdOpg5iBGxwgaUNKyQNOUm15vUD2DxKB4zeWbD8I5XCD2/nh42CEzTHTWxTkO9ZZA0cN+0ztsES/cEiKqBevPK5rY2aXPpWJQZiKnRDOmYfajPC8ZR2sOx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716739923; c=relaxed/simple;
	bh=1qTOg0i4AJav707D3NLC+pqPicBkYgVxlo3Ac7E7+Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+wyCfWFsQ3i7ARkHEojMlalzAE2zY6cqYSNvohvu9a4FgM1y4UHC2UphcJoxUNVzCK5yU6ekJm29JZ2QEBlQhBytyWJ7ANDj9cD9n6+IjsoIN37ieHHg/f9htLJRPepH1PdfqGOLRbZ5xO56GBZ21CY4vnGulzv4BA0vvS6mjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C6A6dTaJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6269885572so400726166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716739920; x=1717344720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o3spg7Ji2j77u3EczWS+0jELUOh8+Gf0gXFP+GN0JHI=;
        b=C6A6dTaJyPsMUHQNltHZZYhNgdxdnzWxDI26t6iOhV9AxTcGLUxYI0jFiUj8U9R7eA
         mbHkqkTux+2JxzgSN88BGd2yg3HFtepr4/EfvBJ4PEhA9p08uMzJStaaOlxR+2mfYpFc
         ITsSBxh8qUZDCIV5qic7M9VBSzaZS0ZaAMvW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716739920; x=1717344720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3spg7Ji2j77u3EczWS+0jELUOh8+Gf0gXFP+GN0JHI=;
        b=eCpRKVintG6pbLPd+AU3iaxPNPUMbbJxBo6kRBX1m/sv5Dq13evtbF18Nrou0EhFbf
         9lOGBFIS+xS2wohveElwZgcloYQF7JmR1LB9KpPLohFJIeABHn/GbTYHHQmV/ecgDQ2O
         JX3w2r57F0KVS4QBhHNDMg6ywPAe2TDMmTUXtQA3fwhCovp5Ip6dpI07sdDaX09okxKc
         d8tYWjy84qOkAgKwr+x/T3kGWNtDt4KZrQPJPhM1WIoXCBtpEcDSwo/5XMXzy36aPFET
         rS1btuzEBHo3eRbceSQeyD054tDYYG6zr427mG1rpJVRgYshQKC6P9NYpUi8zE8QOV4n
         7FaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQZzI+qXynVLuDWtnnuSxrcntaNA/Wwefm8eSzXsEOOUg1cYmMQ4m90RzMt7jr+5bL+bks9S/k23qs/quRKJCnCyQ12RX+axB3VqqO
X-Gm-Message-State: AOJu0YzQysHQU167yRSs7PXb2zluj37L0ZqkosERrr7ZmyX8bUR+67lN
	yuWK0OCXSgGcA+pcUqWJTkwnQKjo5pyaP10GAOGmRiQ6KmA/8+cm5LzrSKMeY1+B3sOGP/lt0a9
	+LF/lgw==
X-Google-Smtp-Source: AGHT+IHOKpNRljrpIZropIi/3Uz7h1Kln3TBLeeEZznbu55MgTAK+6+CUDfTOuuWyVa1O8AMXIs9Ew==
X-Received: by 2002:a17:906:4a50:b0:a59:c807:72d3 with SMTP id a640c23a62f3a-a62620a72fbmr641711966b.17.1716739919942;
        Sun, 26 May 2024 09:11:59 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c938828sm397006666b.81.2024.05.26.09.11.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 09:11:59 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a626919d19dso378463866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 09:11:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9qWScBZlnlCwBkhtaK2TC+iPjUrryVh/8LC/455zkLzbWE7ZHYgc6T3aL0G4sRGuBC5GDPqvyfDme4yLB0J4aPaHwxDWHOcQi/hRG
X-Received: by 2002:a17:906:275a:b0:a5a:3e00:6317 with SMTP id
 a640c23a62f3a-a623ea0380bmr807493566b.31.1716739918672; Sun, 26 May 2024
 09:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
 <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
 <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com> <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
In-Reply-To: <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 09:11:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ2JoyBNFnR-TUc7P8sBL2ZvR0W1fCjcK2R2w7137wfQ@mail.gmail.com>
Message-ID: <CAHk-=wjZ2JoyBNFnR-TUc7P8sBL2ZvR0W1fCjcK2R2w7137wfQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 23:22, Ian Rogers <irogers@google.com> wrote:
>
> What to do with events with no PMU like data_read?

Are they actually ambiguous?

> The rule for looking up an event with no PMU specified is to try it on
> every PMU - the rule is about as old as perf itself.

Well, clearly you then violated that rule with your change. Or you
ended up changing the rule to look them up in the wrong order.

I'm not interested in theoretical breakages. I'm interested in actual
_real_ and _clear_ breakages, and that commit of yours introduced
them.

Maybe the fix is to make sure the events are always looked up in the
right order, with core events always getting priority.

That said, in the *particular* case that I hit, it's even worse than
that. It's not just that the wrong event was looked up - it looked up
an event that DIDN'T EVEN WORK for the workload.

So it's doubly broken.

I don't understand why you then bring up a "what about" issue that is
entirely irrelevant and would presumably never have shown the issue in
the first place because it wasn't probably wasn't ambiguous, and that
actually did work as an event source.

Reality matters. What-about-isms don't.

              Linus


Return-Path: <linux-kernel+bounces-174156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D398C0AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF73284F09
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69D71494B2;
	Thu,  9 May 2024 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uh3qtcnc"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9E13BC3C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232758; cv=none; b=EqNyiiRvc26BO2hdbho7s1yfElWWIXs354lE9OaXROLO7d/JaiqqMBF05aN30KJFZR23MdsSBt1DqBYVaZ+9aI/CXFWrpQzOg3XuEg1DVifZukFo22FBJiSY2xRCzzbOnqhCInlDT/ULuOOa5XLhQwMcEPd6jheCg7QSnox/zlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232758; c=relaxed/simple;
	bh=KcZG6XeUtJ75DhXoFdTyBzpZVMCrL/nG/0AHYcu8Aew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHBl0YGIIfyrNi35ddkM2r5MkS/UvRtEtdLLpQ6l5ze3orJS4tl1e2j4CbYgaMuroc1BwEEi1gPrHlBFeS9A8+g79levzp9C7Xk0nMYbOMfOBaq7PqYB/A8O9sbHFfVP22sk1gV7Zxe6AMtut65q9dV67oPGz/AtdDcMJTiQoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uh3qtcnc; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439b1c72676so206041cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715232755; x=1715837555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnmxyCNyaJ5gJCBe5Vw+QSGnorZnRYFPb0h8ujnL3RE=;
        b=uh3qtcnc/E0ATnzs44vH3DaBvZSFQLiAwiojzZNiXSREc6jW2lBb8cLCLtSHhuTgIv
         L8oBXGwbj0ut/r+6QOFG8ukVh3iyLHQEyx32ef04PVNMjf+V/xW0IH8wppKuMv5eE/Wg
         sMOSR94xJwoahoGv/p82OX27ce7eudSs+cwcmFt781F34X9QYMW2X+8Wf/SCP8a4TcTr
         yKfFZafW9ZGAyIls5+Uct/wep9viA5ZCsSxht0/VhyU5UVWXnZP8RrWt/Jw41GGNXKDS
         cc55gAJeZhm7EY77Em4G66/eO9h2tW5oKM8T9GJsEqHvHQE9PlKCciewwbdyeQgB14HN
         Oz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232755; x=1715837555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnmxyCNyaJ5gJCBe5Vw+QSGnorZnRYFPb0h8ujnL3RE=;
        b=ZP4+W0bGig7TYOFJVCg135fImjXL54ULw1op1r8l5T7wqIPBHqhAz0IID8DBR8Nz8L
         MVvWMZokKbGoPQfhdF4OAESPqt+pWfsxkqirKjuEAcGmXRzvpiuTnteSlw3Htnp2F6J0
         Z2uk3/NBiB4YU7Q6+ZzPpuVWYwZP+uUT6F7Xdwl+SPca2YddJ/WG5WSYjWIXmOCmd31d
         7dXZH02qNMNnCCyULnCmCwgbrEyoHRiMT7+Pzx012gZkq+9DNR1E1E5Jp4yRAHl7lZZ0
         ZxZvy595lxaQlLfWRJqxjztppDeSL1mAAXs7t9yMxrbVnqr/LI09TfsSn1MLPD+V4XRT
         r7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHsNCRtBaDj2ItkaCmrZgqyQVzP0FXzwJam7U8YQUW0hkAi0UgWgDtWA+qkUq62IqZIjOxEkPfN7po6LeEHkg1YUmc/XuYvHqtwZdW
X-Gm-Message-State: AOJu0Yz+231lvTQ0pr1xpH59Tq7QXWDJr9hXqdWmIpXCIIBBprTAwFCx
	icilWE9LLgZcbvQtYmc6L/p7W5QEkYa0tcnUTf/uWm81ye2+1E2nZzeUIbXOL4kZC40WY4pK5gA
	cY2+vMI8SPa1Nusyf51CfD6/M1ttRs5sS9xwj
X-Google-Smtp-Source: AGHT+IG5HL1fWYphq5Kr6YvO0dFE4yJT9cnAoMviM/whh8Ln3jYn3yP9/oAzo1dkWv1geG2gtv6xOVF1tRmKf4mbdH8=
X-Received: by 2002:a05:622a:5914:b0:437:b572:6d with SMTP id
 d75a77b69052e-43df48267e7mr985441cf.21.1715232755452; Wed, 08 May 2024
 22:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com> <20240508035301.1554434-2-irogers@google.com>
 <CAM9d7cgw45sv2fLm8Yea_RgrOLswSPErwMORCBaeYVb=OXjnZQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgw45sv2fLm8Yea_RgrOLswSPErwMORCBaeYVb=OXjnZQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 22:32:24 -0700
Message-ID: <CAP-5=fVKuCb_nCmHyJ2+GZwdv8yUVFBJjpt+Wjy_GcwzrCHN+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf ui browser: Avoid segv on title
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, May 7, 2024 at 8:53=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > If the title is NULL then it can lead to a segv.
>
> Just out of curiosity, do you know where it sets to NULL?

Yes, the fixes patch added strdup and zfree, the NULL is coming from the zf=
ree.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Fixes: 769e6a1e15bd ("perf ui browser: Don't save pointer to stack memo=
ry")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/ui/browser.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> > index c4cdf2ea69b7..19503e838738 100644
> > --- a/tools/perf/ui/browser.c
> > +++ b/tools/perf/ui/browser.c
> > @@ -203,7 +203,7 @@ void ui_browser__refresh_dimensions(struct ui_brows=
er *browser)
> >  void ui_browser__handle_resize(struct ui_browser *browser)
> >  {
> >         ui__refresh_dimensions(false);
> > -       ui_browser__show(browser, browser->title, ui_helpline__current)=
;
> > +       ui_browser__show(browser, browser->title ?: "", ui_helpline__cu=
rrent);
> >         ui_browser__refresh(browser);
> >  }
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >


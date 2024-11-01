Return-Path: <linux-kernel+bounces-392976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610089B9A55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182EA1F2322F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0311E5027;
	Fri,  1 Nov 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="fgMaCcHT"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E832487BE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497321; cv=none; b=GJ7nI1kv4ILuB65N9vcX08OQ4HrYLMPiGIhWCEccJkDKofamCFHrku9klBXvSGZ3pe3TBZRyz20xjGHuF1sSIx/t4bSyD6iRtRhBE9a0SZ0rCo1on5bWoDx0teubbrj4jw7e4w8bE9doR62L6A1FPiVC5U/LYKuswOF7frExAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497321; c=relaxed/simple;
	bh=DbfqY7IFcAPB09OyKpR93DM2ZjDMYjW04ydu1Tn6UTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYrSMLXbRv/R/8onJddtuTpXdmTcnT5rmGIA4LNx1oY9Sc4zAUe0Dnu+yJPqJs1DEzKUAvniHSvFHz39y5+iiv9cBnajqMM3Xb4Hlz/tkM9BXxtGvzRqGppAhWxBk0XL5zTrZVrjKD6auI2SycGnvoEKnqod9Y9ZuLbHfI5yYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=fgMaCcHT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so3978987e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730497318; x=1731102118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo90b8Yd71LhW+/ErXRjU0g+lG1e6qGL15CJicn+PDI=;
        b=fgMaCcHTsMt7X51dL8HaT5rEY+mU0JMciTpvRAlgWAYq34eclsHs1mbj4uiRPDEKvJ
         pE1CDg242KhWOW77wVOw/dBA1dUGxEI7oEEkKUJOjA8Eoy9chQz2OylPq10Fk3tJiaSq
         OJq3OJrsTSsBaadj4snN0AtAj9eZkh5s+qyEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497318; x=1731102118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jo90b8Yd71LhW+/ErXRjU0g+lG1e6qGL15CJicn+PDI=;
        b=FJ2KtWXy+UbKy4JSTS6/wWgpnfr5IBLY3QIWiwlePdxpjFCQRJEMSjwcF4/H7Az6W1
         bd1Njaco+Gemfau+KE5l7k9UDA0iw1VSrEN3gJDJn2HXH7oeuORiJ+giYGGhIVGsDYQY
         ZID5PxRO4xSUbfXl6uNHCS+rkc9lSACqjtEm8hmtHOmPMqPVM49hU0GiWyY3S32Ws4Aa
         euuYVIdsa90DdAbX4GBnswdMZRxBfsO+NlO+UyfoHZS1o09Zq7Iz5htapC5R7eCp6Xy1
         uSdlAB1MwkRAxFfdxt5CfyawmR12rjV8Rb3ETlpTZHhMEAkd4kpSOvJbsesM7fyUpob+
         z3zw==
X-Forwarded-Encrypted: i=1; AJvYcCVnTq1v/hDXl1SQ6rH7XfMh739n1AGLZ6gceJbnuhH9JeM000s2p40xLR3q8Hos2NELFiQwlIuu1oQqpfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wSszNJbiDFwZvYp4HkxwcDne6JxG21ofUufzKCrmQ31cRsSP
	bU03/UUQM3j+Op4rNNCpNL7NWJ8bJhIHg7k2KEYOTBnjnCrsjX99Y+tlHJxXpYSrTBFoJ3IDTAP
	QxPQJeFU9BiScl1OUuauzpiW7Z3RveFB2ZR0isA==
X-Google-Smtp-Source: AGHT+IGcJSS7owX3TBRF8ZsKYn+5S4Q3Hg1EpCxbdq1KPte+oQuDZLnbzKisdC+ggu1lDkdDgpVrbty8dyMekv9XJ2k=
X-Received: by 2002:a05:6512:3d10:b0:539:94f5:bf with SMTP id
 2adb3069b0e04-53d65e16d9dmr4558411e87.59.1730497317409; Fri, 01 Nov 2024
 14:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101005338.5846-1-benjamin@engflow.com> <20241101172714.84386-1-benjamin@engflow.com>
 <CAH0uvohNO517GAD7XH-VvUvU+dPdeZBKDw0Teij50sAPSe9sCQ@mail.gmail.com> <ZyVIgKcAuqZSYYB1@x1>
In-Reply-To: <ZyVIgKcAuqZSYYB1@x1>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Fri, 1 Nov 2024 14:41:46 -0700
Message-ID: <CAEmfU+ufKWoJLvhksPzADMKkbinV37Tv1KODU6RdJfBM9Juy7w@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: avoid garbage when not printing a trace
 event's arguments
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 2:30=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Nov 01, 2024 at 02:00:46PM -0700, Howard Chu wrote:
> > Hello Benjamin,

Thanks for testing & reviewing.

> >
> > Before your patch:
> >
> > perf $ ./perf trace -e net:netif_rx_exit
> >      0.000 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> >     28.153 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> >     36.429 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> >     36.461 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> >
> > After:
> >
> > perf $ ./perf trace -e net:netif_rx_exit
> >      0.000 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> >      7.352 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> >     30.232 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> >     37.529 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> >
> > It works beautifully, but I'm thinking can we simplify it by just doing=
:
> >
> > +       char bf[2048] =3D { 0 };
> >         size_t size =3D sizeof(bf);
> >

I believe this is slightly suboptimal because it obliges the compiler
to zero out 2kib of the stack every time the function is called.

> >
> > Tested-by: Howard Chu <howardchu95@gmail.com>
>
> I haven't tested it yet, just in my mind :-)
>
> The patch looks ok and seems to fix a real problem, my only concern, a
> pet peeve, was that it, in addition to fixing a real problem, did an
> unrelated change, the "Remove the return value...", that part looks like
> a distraction, something that shouldn't be there.

In my mind, it was related because both the bug and the odd return
value arise from incorrect counting of the number of written bytes.
Obviously, the fix is what I care about, so feel free to strip out the
return value change on import, or I can resend.


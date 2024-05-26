Return-Path: <linux-kernel+bounces-189590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B88CF293
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 07:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680E82813A6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 05:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3CA79DF;
	Sun, 26 May 2024 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BsoKf/P9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156456FD3
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 05:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716700948; cv=none; b=Iw2clPHt9b+Zt8GpeEeObetcJDkmGweTNDD05Y2aqWT00FETGbwVWbWfb3BcAQZxbVCKFYPcLz0zgwxeQDUuFnmBeill4A1vIzWJ4JijjmGDtuA9D+titPwE+Ybbe2kjLG6dvomt0pJAySsoWdP429yQDCwzQgOv90NxDdtIFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716700948; c=relaxed/simple;
	bh=2onGx/xeIrSjTBLOBGWgptieSEtXuzDCtJLlVc4b0wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXIPiPCVqZgGEOkkxiEXCU842J3berkl41rAwfzVz0FF6plZ90HQ4XoZBb6XYfLRhUUNybi9bXAXyh5QY8p3Ogm+vGfoGznlu5KEiuzSCo9ukz7iFyn9kisD0fIKZnkIOGaKgwSThlZIFh851V8oP6TmEkxVnHUhm17ruGbFF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BsoKf/P9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57857e0f464so2312714a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716700945; x=1717305745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gPJVRsED66SFuo9QB46LJPJvy8CLRk0JilNUt31CkN0=;
        b=BsoKf/P95RQba8zhxdwUMBfUXqPHTbtfzLt5Rw5N5zW7op3RhJ+f2GDuK6PIGgdBY9
         xQWwYTw4+2Ab/X5s2Jo1aMsNqnvWTyZY7al8kTeDVPeab7UjzASFj0fwhWjsG8R0NZIs
         o4x78B5W/HP+QClXjYeo6PaTYOlzXX5yGWEoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716700945; x=1717305745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPJVRsED66SFuo9QB46LJPJvy8CLRk0JilNUt31CkN0=;
        b=HS+wEnlz5EBQYH1RCFDkMfug8tT3s8ymAn22WO4o48xA0EHJSoCb89j6Avrf50QAR3
         EWpOvTkL3UrRN02CxJn4XtloOKV+VHB2yJwmvlPrmweImdgfpmm3jbGaBF3TOiy1js2D
         Lz0iqOpSYcrWb4o++s0tqwGA1Fp43aTM/+ipAKfZ4U5hOCQOpfTzJDadGiBK2tOvTIsV
         Xn6TQ5DtRMEHUxNfyKyuwkBj501aYbHnPj1pyShrPUpZ7xmSF5UoV4ydAv+ZDLAG855N
         2qgGOL+gtLIHz7w9bVxbvTp2UvuBlTsy+47PyDz0SN3gAVQbxhOkHOpM+F+7vzV2jT1+
         tOAA==
X-Forwarded-Encrypted: i=1; AJvYcCUSpUj7GU/fprH7FX8+CCDBg+FYef2Ecv8dltAOX8bFWwt8JTpsGOmOd4mrXDvE9B4+rQ/P3iFGz4IgkUvQZFOIb3/E4CSxTgSnb4gq
X-Gm-Message-State: AOJu0YznCtYcj0Q0Akpm5/pjrHROOjeqOdK46IWMUxPr324rOe31Rvy1
	uSdmWUTUOCfESV5GGgT4wRbakIHAfKJJXIbkiZRpRKX2Iq8bAi72UH7WLH/Cc4CviJRVc6BuY/l
	drlg/2g==
X-Google-Smtp-Source: AGHT+IF/0D2xl17SGYPmGFr0/aHZFHjtswoIO43QYh1mo2qfz8C/Xp2sVqQapcqWV8fvHVpjQ0+O0Q==
X-Received: by 2002:a50:8a9b:0:b0:578:59a8:f36c with SMTP id 4fb4d7f45d1cf-57859a8f421mr2955871a12.42.1716700945272;
        Sat, 25 May 2024 22:22:25 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785240d1f9sm4021310a12.51.2024.05.25.22.22.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 22:22:24 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-578626375ffso1774964a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 22:22:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLN8r9z1n2Mi431IXnn7gC1vy0vVsf4vpJYqaLuDKLgQtaF7B/yZBpnpsTRKTno6tgMw1MRUoRc/D2SiqeL4iFgLh/B0MTphOdjb6u
X-Received: by 2002:a17:906:3014:b0:a59:9ef3:f6df with SMTP id
 a640c23a62f3a-a62642e9af5mr371152966b.22.1716700944352; Sat, 25 May 2024
 22:22:24 -0700 (PDT)
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
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com> <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 22:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
Message-ID: <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
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

On Sat, 25 May 2024 at 16:34, Ian Rogers <irogers@google.com> wrote:
>
> So I think we still need to figure out what:
>
> $ perf <command> -e <event> ...
>
> where <event> doesn't specify a PMU means. I'll try to enumerate the options:

[ snip snip ]

How about make the rule be that if the event doesn't have a specified
PMU, then that just means "legacy rules first".

IOW, if you have a fully qualified event name (maybe define that as
"event name contains a slash), then you use the sysfs lookup.

But a simple event name that doesn't contain a slash shall mean "use
legacy lookup rules".

Maybe in practice that ends up being the same as your option #4 ("if
the PMU isn't specified with <event> then we only search core PMUs")?
I don't know the perf code well enough to be able to say.

But basically, the #1 rule in the kernel is that we do not break user
workflows. I happen to think that that is a really important rule, and
I'm disgusted at how many other open source projects ignore that rule
and think that "in the name of improvement, we will break the world".

And as long as "perf" is maintained in the kernel sources, that kernel
rule will guide perf too. Because the rule is not so much "kernels are
special" as a "Linus wants people to be able to feel confident in
updating".

           Linus


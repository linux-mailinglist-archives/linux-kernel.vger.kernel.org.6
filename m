Return-Path: <linux-kernel+bounces-189770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519678CF4B7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61EA1F213AF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5017756;
	Sun, 26 May 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+GSksZ1"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49268F77
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716736843; cv=none; b=dDZV4zZB6Obl8Xm2sgTJ9/TusFC9KTaWE8o9jLdwntbKKsHiMU0QzRwHgrd0p+SdlxauBI7jIbPexi5fB2LW4Yg/XmhBZShFEY/gl2c3TIJ3rrpkCNQyyYEXlcUreD3vcMD8MILHTPPeCx2LEgTqJ3sDn/fLQRqPJngY+xRmTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716736843; c=relaxed/simple;
	bh=ndDTKi0BuiM4YEc0vTuUivGd6+HmdGMrevsaAPbOoP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPxQVsSfzXIvgQ6KrOHTJnXUb46luh6CewtosoH1bhc0QDPbkBawbrDFa6ZzlWyjpSAPTXOt4BKRZ7iwj3Pdi0KSbHSlt4pkdtau4dnN8EtAUSjTXcfBx/FE9ZdIOlKXzAG6uBTG/A5M5OoiVph0w4GHqJi2IFJHhOoLAc/+8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+GSksZ1; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36db863679bso206025ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716736841; x=1717341641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndDTKi0BuiM4YEc0vTuUivGd6+HmdGMrevsaAPbOoP0=;
        b=O+GSksZ1hV9NjmD0XhyNaFK98+c+sFjVYm18YL2kOz5x0zZ/WkOOiaZR1jTOU5VdqD
         /F0mVNgkGFSWPvuU781mEmM62gm75pq9zZIQaI6oNzOtTQeJPVh3kZToVPzzHoaBOfCS
         6mQGJxuaITzOi2SHSf327A+oa4ConGP/kKFyMRaPQQRvem0Bv3aAYY5DB+zW8IMYaUqS
         uIZUNk93t/Dp+8yX1JYa69HB/M9p5PuoDL3TRpka+sMoFvLZeT6akoF34p+myBHO7gDU
         olQr2EuPDfRB/8iFrC0mEAuuI1IT7pdHHMJXnWGyVJnkGyKZYiTI824gVkOAKyWextX2
         THLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716736841; x=1717341641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndDTKi0BuiM4YEc0vTuUivGd6+HmdGMrevsaAPbOoP0=;
        b=YNBxFzoZTBN2RDAJ1SAj88IrmgeFtVaBg8vSeNC8J7YNUU1FAhftDwOqzWZevnuaEm
         WDUt0+gD8AfhESK3xtOo9MIOMDo8n5/C/QJxUKqiZm0HNY1B0DwjiyvjVP7H1u8oB/nE
         3E6i4Y+p7J8VrSqm4nxekp5yyfThoK9gg4wEAfHGQ2dvj0lzmR52Exnb6NRV6shD9sxu
         PpyOX/bfYV4Vmk3MUrq9vFl1c72ooNv+TblSEQhIftOlcxUQB56CKoZaKNor4bJomYtr
         gFzFzAJqxLUX/PZyQnTEIGQp8jG7DSx0jRn5k7CmcYNQiYTl84pkehkr7czyYcukb6W+
         9ybQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWtcuuG9hSG0tqzaVAC8nL7SZJg2bGrJbdMkviEiomqZoi3azlAvIfXU2PQmSiSBxksN2FXrN8oXOgX3mSCCz9FXjsl6vO8vdLYSeY
X-Gm-Message-State: AOJu0Yxmwh7idaccJXIqRMBtJ4rcqbftQM5ZVAIvCeOX3uQQeoIinKB5
	QDnrXVqMi7KIV/h47Kgg+Pb1zUWSVPxC6xsF/mTL921QeA9Gyxk6igFcKyQifzy7vwSwplgTmEY
	llAkS8UbVHT3euD52QNwl5eGZF1zz5d23e0PN
X-Google-Smtp-Source: AGHT+IECpFQ/Hw5GvOmZu3NUBRlQ9iJ9jwo5vv/Y+KQH+JX7LqHU8RzhnWWoyc79Uf5ulrDAGR6uKTFBcOANuju6+EA=
X-Received: by 2002:a92:da81:0:b0:36c:1276:69e1 with SMTP id
 e9e14a558f8ab-3738b306f28mr2429135ab.13.1716736840685; Sun, 26 May 2024
 08:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
 <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
 <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
 <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
 <20240526095838.GA33806@debian-dev> <ZlMYjHdX-d0ODqyj@x1>
In-Reply-To: <ZlMYjHdX-d0ODqyj@x1>
From: Ian Rogers <irogers@google.com>
Date: Sun, 26 May 2024 08:20:28 -0700
Message-ID: <CAP-5=fX1XwUrnzrxGgQLK2J46jjsCUq8egbV_9p0eNiVD7-EbQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Leo Yan <leo.yan@linux.dev>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 4:10=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Ian's has been working on this for long time, testing all this takes a
> lot of time and requires access to lots of hardware not easily available
> for all of us, so its bound to break here and there, what we do when
> this happens depends on when the problem is detected, and today Linus is
> expected to close the merge window, so a revert is the technical, if not
> pleasant thing to do now.

Agreed. I think the only other option is:
https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
and then when specifying the CPU cycles event on these Ampere systems
you have to do:

$ perf record -e 'armv8_pmuv3_0/cycles/P' ...

but Linus isn't happy with having to specify a PMU like that. As that
is an ARM/Ampere only problem I'm not sure it is so bad.

Thanks,
Ian

> - Arnaldo


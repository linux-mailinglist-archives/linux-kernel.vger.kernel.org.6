Return-Path: <linux-kernel+bounces-397151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 946279BD762
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0817E1F23574
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544C212176;
	Tue,  5 Nov 2024 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsjnPvdT"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC01D9A48
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840673; cv=none; b=BEy0+N03HJ/QYXNe+1U+PQahbTxuuAsivbFOGUrVxg8Rby41JJrAJemuZZqfgRQTSNjXWUYDfjKXy8R5XSp/W09wW70Qmk8GeOBRTB4wvUkPRk+REi1VxBmGIW2P1VpWuVWLAx+xCZTMsMitWqUFpGUyImglfav9Y6jZ90EFPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840673; c=relaxed/simple;
	bh=wrj3/qazOSL4ZxdUB86WJNvmN/E0InLO7z8jdaftYp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRCwGA6X3rnA4kewpn3N1jPdw24le1wG9/xy4bGGlKdGaniIo9rI7Xf6Vr0kjP6b13Dc+bZFWGrl+6ARiYE+y9wUT9+f7Y5br3kVLnq4qjS/7Hn4BgyMk66Op8MXPNjozQVBmb1U7bStitu6UpN9F2Jj35mKrUvtmz60hhcBy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsjnPvdT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c8ac50b79so38245ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730840671; x=1731445471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1RcGRYjbH9Yzq2bfmv8M77Kn2OpXZRTF+Qu3sQqfSY=;
        b=MsjnPvdTIdb/wqYVg1K21b2Byp84ls3a1HIroB682A/yjM7iLerJfVbBMzH4EF1yDL
         qr/CeJ12/4FiBm2sTdWDXtIlLvHb28COw1F1QBI3fHH718rX4s6Vr44Ya3nzNEDoM8J4
         FQxl1Do8mLuIQnIDys1IeEFbEJHIv/6j/LoxPBBYxvepYWxt9/qv/t57kFz39RDcktkF
         2mpQG+QcN/NZVOx2cGZNMwVWtc6b8O9g3+J3djQprqH85bVbWY6RzB5pwmAQT6u+aDMe
         5JCvvD1ISm59oRoNUH/DBxiS8JPYvMi2PhXT0leWjRLTUJq0s8pmml//5YtW0RXKF6hI
         26Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840671; x=1731445471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1RcGRYjbH9Yzq2bfmv8M77Kn2OpXZRTF+Qu3sQqfSY=;
        b=goLqCW1zkzos1OBaD0xoX20KZx37MDLZXD0IR6Ue65JfvHc79Rg4KAwojHnr6qnwyv
         GPUGKIpgvHz8yY2P1pcg5CD2hgaxIaTdFHkZIvb9YIoSYaMmj/fGoNhovQ/COAwYfyD/
         +81EBgh/GqFfTczIkpKoXikeQ4MQ/sgVCSNFQQfM9Xs93lMYZ+o6HSNhklUA+wl83Yhh
         2yPfHRImF6RGJDaWcvkMMJPVo6g+lSChLAvqbdrcAof53CQXRvsToVYzHyqt+sSjTLCG
         Ww312HG5sb5uqe1HOCvkwwZIy/pDzxcNf4cm9TYwpAaoXiTFDEO1Z/YEHwvvaEyE9TWa
         PH8A==
X-Forwarded-Encrypted: i=1; AJvYcCWS/QgFhM9AQH/TZYy7vl4SAdUJoADsbBXsas/2kx2ikqniIdkawHU+NydtoniMn4sIR8iXIv6a14gLpxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7pKdT46tWeTv65rTG6YOAu4AApIefet3FC35WYC9+9MitSW2n
	2WxD5ZsQW2Op5yrfWP2RiJcjU1gjdsxFV/81ch1eDny4oCCy/6OzUS/GLvi88KcMgGygM8tmJSe
	Kdo2VhJ6k09hR0g5zAWPIbVf/YUg1eOcHa059
X-Gm-Gg: ASbGncurVo4thDvCDbxSXIxWaQpGahDyjM0cFDoLXinVX8VCBWyQotqrdaMndIV+ZAu
	rfqI8epyMs5AR9RqssMkeIy6E/Vq1bg1i
X-Google-Smtp-Source: AGHT+IE855ArudYnCrY4QSJqhQp74GNCQ29IcUWQTYuwgMe+uqg3o440Yjtg+mxKDAr0dAZfFQQQpaZi2gIEZFuP2ek=
X-Received: by 2002:a17:902:e804:b0:201:e2db:7be3 with SMTP id
 d9443c01a7336-2116b973e24mr456135ad.21.1730840671232; Tue, 05 Nov 2024
 13:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102165400.75785-1-irogers@google.com> <20241102165400.75785-5-irogers@google.com>
 <ZypXmtlqQUxABhMI@x1> <CAP-5=fUNR_t8R33enM1WHzR1-ZzZMUDM1hTLohPdefbKfhMSXA@mail.gmail.com>
 <Zyp3jeLz4ympxfHv@x1>
In-Reply-To: <Zyp3jeLz4ympxfHv@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Nov 2024 13:04:20 -0800
Message-ID: <CAP-5=fVGr5bq5MAnWvfyOKT0ggC0pjZ3uNHKtW2HP3pHHVYEVA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] perf evsel: Add/use accessor for tp_format
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Yang Jihong <yangjihong@bytedance.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Zixian Cai <fzczx123@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Nov 05, 2024 at 11:33:09AM -0800, Ian Rogers wrote:
> > On Tue, Nov 5, 2024 at 9:36=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > > On Sat, Nov 02, 2024 at 09:53:58AM -0700, Ian Rogers wrote:
> > > > Add an accessor function for tp_format. Rather than search+replace
> > > > uses try to use a variable and reuse it. Add additional NULL checks
> > > > when accessing/using the value. Make sure the PTR_ERR is nulled out=
 on
> > > > error path in evsel__newtp_idx.
>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > > > +++ b/tools/perf/builtin-kmem.c
> > > > @@ -772,8 +773,9 @@ static int parse_gfp_flags(struct evsel *evsel,=
 struct perf_sample *sample,
> > > >       }
> > > >
> > > >       trace_seq_init(&seq);
> > > > -     tep_print_event(evsel->tp_format->tep,
> > > > -                     &seq, &record, "%s", TEP_PRINT_INFO);
> > > > +     tp_format =3D evsel__tp_format(evsel);
> > > > +     if (tp_format)
> > > > +             tep_print_event(tp_format->tep, &seq, &record, "%s", =
TEP_PRINT_INFO);
> > > >
> > > >       str =3D strtok_r(seq.buffer, " ", &pos);
> > > >       while (str) {
> > > > @@ -2011,14 +2013,15 @@ int cmd_kmem(int argc, const char **argv)
> > > >       }
> > > >
> > > >       if (kmem_page) {
> > > > -             struct evsel *evsel =3D evlist__find_tracepoint_by_na=
me(session->evlist, "kmem:mm_page_alloc");
> > > > +             struct evsel *evsel =3D evlist__find_tracepoint_by_na=
me(session->evlist,
> > > > +                                                                  =
 "kmem:mm_page_alloc");
> > >
> > > Try to avoid these reflows to reduce patch size, please.
> >
> > Agreed, in this case check `checkpatch.pl` is complaining that the
> > line length is 109 columns.
>
> Ok, but it was like that before, your patch is not touching that line
> for some other reason, so it is unrelated to what you're doing, causing
> a distraction.
>
> Besides, even the documentation for checkpatch mentions that that is:
>
>   **LONG_LINE**
>     The line has exceeded the specified maximum length.
>     To use a different maximum line length, the --max-line-length=3Dn opt=
ion
>     may be added while invoking checkpatch.
>
>     Earlier, the default line length was 80 columns.  Commit bdc48fa11e46
>     ("checkpatch/coding-style: deprecate 80-column warning") increased th=
e
>     limit to 100 columns.  This is not a hard limit either and it's
>     preferable to stay within 80 columns whenever possible.
>
>     See: https://www.kernel.org/doc/html/latest/process/coding-style.html=
#breaking-long-lines-and-strings
>
> ----------------
>
> So if it was there already, meaning the original author preferred it
> that way, its not touched by the feature that is being worked on in this
> patch, ends up being an extra hunk, just reflowing, a distraction.

Wow, respecting the author's preferences, sounds like a good thing to
be doing :-) Like I say it came up from checkpatch.pl as I changed the
next line and it was over by quite a way so I felt it was innocuous to
fix it. The variable on this line is used on the next line (the one I
changed) so it isn't as if they are entirely unrelated. I agreed to
put it back. Often reviews like this feel like you are saying
arbitrary changes were made for no reason, which I have a long
experience of avoiding doing. I also try to make sure I don't send
patches upstream that checkpath.pl warns about, its a shame whoever
authored the line didn't think similarly.

Thanks,
Ian


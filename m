Return-Path: <linux-kernel+bounces-348150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D637F98E357
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8137F1F23D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0F2433A9;
	Wed,  2 Oct 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuqd5Xrf"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA412E1E9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896126; cv=none; b=NN5emOMNEe3tibVHEqLEOCO7hUtxqVcZAoblAiyPf/6Wc7OOg+7uRexE69nlv3GBmcMg6aN8wpsNR3y50J3J845IwpldcAog6JZi6Zp5oQFTOVaVbzLR7DJrs4uOqtHfo8hIjRlGpJ6HFCnvdL48XJsJDRIshfICvzHCmPkpNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896126; c=relaxed/simple;
	bh=SHFh9QfE3vgBGpp/tJnVYiBlZT4O0u5vSCYlWOFgh0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djqATXtBHn2QU8VbBO0qtNkOTLofBEWnSidUGYHQt6sU44K6QI0sRFvAXHLMC8o6O73aMVAzJDXLNjCIcwsn4+IW5KGVtCiKZc68Rfa55oVv7uEXxuyq63Sc/kfLrkbCMcWuyLH0JtFfmQsCXdrYvz2jG0N9b6RJRsOGw7d3yXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuqd5Xrf; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so23935ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727896124; x=1728500924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UoGbZ+09ZCt3tvdSvaR+iY1YkvoCfJxElQ2jgIBo00=;
        b=wuqd5XrfpXezcZdxSn4fE5d10S4b4VKCVRxJ4swcqusJDRUCeWQgco/AB44RzvxVx6
         +N4cwcEourXFmBdROLx7z4b+kFWmTQxCnma7pkTpA6nJ/V1QoEpWtgToegeB+aUG2hgD
         GgP0dM+6Gx4yeoamHN6lEoH4tNOwAob0AoxDGDTJtJ5vslOcfMmsIysnFGv3hdzgtz5U
         9+YTNXVh1s17VEIK7MRKk2bR8D6jhtmyFWGCcoD6CimeOD2DQOFC/SUFxCsn/CU00quG
         U24AAWt81PrpIm9CKqdFe6uXfGwJn3BPF4hA3WvFENR4+GHaqC4D5Duxe3Wg/5pzY4RM
         fuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727896124; x=1728500924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UoGbZ+09ZCt3tvdSvaR+iY1YkvoCfJxElQ2jgIBo00=;
        b=AYgq1LlZX+uMC6cjFVKxYLi17gCNMTY5sBR6F5Lwwc0aW/6TsUEMfd9KerNr1DE/Ph
         PP11bOrGL6IKADdfQn2SiPx9Bv+8+7QxqSCKy6HqKk0sb0Hk8NAQrB2BvxbYhYMgggo4
         CWF2Zm4XcNXqrOX1qweLOvMqe0AQshMEbcc7t80lG2V8g4Y65RNOpqHSVioXNi0NSdKK
         GzFt/UeDSBklObpDOVrpL1Rwar+brWgI7CqrOY3ZkeBE2utTxbG+hysgTaujpI1yYKv+
         /ia17nzWCKWZaqYoT9Di9AANOzm/EmuAlzJpmEh3IUybrTYUhaESo2iyYRqF/tOQxsIC
         KVFA==
X-Forwarded-Encrypted: i=1; AJvYcCWdgTn8Q2I8g2LtUxzd08Iw9OR9TcQ3AqB3Ynw9vVbWFLYUys4XKG3pnq1ZgQFeJRpMY2oDJkZ4xXJH25Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7hB0ueUXjv+5bK5lrG9NIfb0mjeOZTEQuOydaIoy9w30r7+k
	aJVfommBZnD4Z2q7wVXp9W2+ATWrTlcFNWlWg1mP7X640fO3YiOnjy7etlO2YIWF/jT/HtmB/XS
	LwIPlNVG4o1rIAtYPKVUt73pAVR51TT7sXeX0
X-Google-Smtp-Source: AGHT+IFU9NblRdEX0BaXE3U4WZrlmCXDu888JX3jzETGPENFixK9suXbfcxGpqOQeO0J/TJ9TmY1+LgjhIDYZ0IcLLE=
X-Received: by 2002:a05:6e02:1a6d:b0:3a0:9e83:21ea with SMTP id
 e9e14a558f8ab-3a36ee882cfmr397195ab.17.1727896124326; Wed, 02 Oct 2024
 12:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com> <20240924003720.617258-3-irogers@google.com>
 <CAM9d7cjDeGF6rO8+DJQdG+tELO2ueqqvkFU-rCFETQm9KJ4JmA@mail.gmail.com>
In-Reply-To: <CAM9d7cjDeGF6rO8+DJQdG+tELO2ueqqvkFU-rCFETQm9KJ4JmA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Oct 2024 12:08:30 -0700
Message-ID: <CAP-5=fWgounnfvSQtOiqZQdpkg00yvT3E-rGNFUKKb8ZksPhjg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf probe: Fix libdw memory leak
To: Namhyung Kim <namhyung@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:44=E2=80=AFAM Namhyung Kim <namhyung@gmail.com> w=
rote:
>
> On Mon, Sep 23, 2024 at 5:37=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Add missing dwarf_cfi_end to free memory associated with probe_finder
> > cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
> > tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> >
> > Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_fram=
e sections for probe location")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/probe-finder.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-fin=
der.c
> > index 630e16c54ed5..78f34fa0c391 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debuginf=
o *dbg,
> >         if (ret >=3D 0 && tf.pf.skip_empty_arg)
> >                 ret =3D fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> >
> > +#if _ELFUTILS_PREREQ(0, 142)
> > +       dwarf_cfi_end(tf.pf.cfi_eh);
> > +       dwarf_cfi_end(tf.pf.cfi_dbg);
> > +#endif
>
> This is causing another problem.  Now vfs_getname tests are
> failing because perf probe aborts.

I wasn't able to reproduce but largely as the test skips. The variable
is out of scope after the function so I'm struggling to see what the
issue is.

Thanks,
Ian


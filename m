Return-Path: <linux-kernel+bounces-177786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F28C449C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB31C2326F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E4D15444D;
	Mon, 13 May 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="F+MamYn0"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD67154427
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615548; cv=none; b=AYdnLC9g8JhKRX0K4TrE3bC72IgKuaD6fDy/8mTrgDOWYLQoDpXOftSOOKd+MJ8rBdKc3G+x5MYn7Vn9AsS5SAifSPMdu+80MyuRFfqqu0U8lpyPRzEe8qKYl6H95OZ+Ju+ScTimhNk4So2Zixew9HLkEcUg2tYwuc3oAZh1SdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615548; c=relaxed/simple;
	bh=vkLE3ThAcRnXVsMhuA6mAajRU1E+VMOLAEmdSVnfxH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhzOaDZqUaVLhLuQOZQcr0gae6TPQccYDvtRGi9oPD3LLT5o1LoL5eLw0l+MULDY8WqYK4qhyFdTyag2sgHSjmXwiAtbFSR1VSKEuXtTeVtkoeacIMI9E2rRPJS9cHJL/ccriHPI4m9LI3ahXIw213gWqEfYMr/keQ+rif03l6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+MamYn0; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43dfe020675so808791cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715615546; x=1716220346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab6Pb1Zn+PdwPKJ9a5mXYGSOH8gBv7qhSD/WUjQgp8s=;
        b=F+MamYn0MdnBJXObBkqQnXQ4RCnjFunhfr06c/0pUakX23/zt2o6zMXFOXgfAai8/G
         7tkbfOsxfSlqOM8ssZscPPwqneKRuOJysSibWyAHqRn2jZt6fBjqYxrUpLTY0rNGXnjE
         oNLQZrjUByafq+mHyvF66ceGWEMGaOOzGsWJiIZMhsUULSY+q2o2gymM/BCbvDajVjLT
         GsoctfbaIZwGeYr5nItl9D1g4S/zz4bZLGWFCx1i6/uX0t98sA0UZd2/0u0rHoEmNv7h
         96biPQ2zyShMr0Y8R9H3Tsm5HxKOL3ud+1KyMzeY/S9bpNj9JiNwK38kVVsOP9Xt+Ggg
         UJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615546; x=1716220346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab6Pb1Zn+PdwPKJ9a5mXYGSOH8gBv7qhSD/WUjQgp8s=;
        b=E1HinI73o07CXUIvSQnfwhTrbn+QAiZNe2w9uw2vN2F1RxSTCvzw9qjPSoIgZI0STX
         zlGa5C1eZN6/TwTbCd3ZqXGXbPhYrCD8yEKlvjUGUmFrB6JtNkDDxxLZJPd3SJ2r7GFg
         w4sm9PMr+yTcfRbt5BIqEju8JBEnkw8AbIoMwoasv/mjx8i2XBjc5QHKhx1OjkbtunEO
         uqywhUAR9GwHT5KuXDGbSROoFm0xuS9Ld64/knPHN7YS+LHvo72EvGntDJjVjMvkaxAn
         O+LCftr9k7lb8w7pgQq38vnJDDBsHnZGiWshwZVQptzlAJuMzpeAKxUzZ7rTt/m7RSGf
         P1gg==
X-Forwarded-Encrypted: i=1; AJvYcCU/tNMLFFe9mLcqhb4Q4/O5A9JTlQeY0xoWF3mvmNEQiZxNhR+lxY9LThwjAFGVt7f4gWhl/b3/mmdpO1s0w77nr9qDo/PSngTIvtDO
X-Gm-Message-State: AOJu0Ywp72O/FoayqIZ6uNrPAB/9lvhnSVfydRrIJw7Yj1vWp9QB5Tyu
	olfrycdC2o+kLVTQAu8iyBA7EtQdN/3uM24aZcjvZj0/Whmk2QPIWxwVQvV8MlOUOLCsSV0Dxa0
	o3A2GVCklzXTapGEAgJHGWfkY3GbP3y4gPnPd9KieLKl1uDSnGqix
X-Google-Smtp-Source: AGHT+IFfwR81J/neIzXou87W+GV66GTPQOziuMfR6JAYbFA1015p3P3pBkkVmrfr+CcMuqrdlZNaiXRao+YFaGuMwyw=
X-Received: by 2002:a05:622a:a490:b0:43e:e09:d346 with SMTP id
 d75a77b69052e-43e0e09d358mr2510511cf.5.1715615545425; Mon, 13 May 2024
 08:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjssGrj+abyC6mYP@gmail.com> <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com>
In-Reply-To: <ZkG4LWr7w11wQ/PR@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 08:52:13 -0700
Message-ID: <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 11:50=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Ian Rogers <irogers@google.com> wrote:
>
> > On Wed, May 8, 2024 at 12:39=E2=80=AFAM Ingo Molnar <mingo@kernel.org> =
wrote:
> > >
> > >
> > > So I've been getting this perf build failure for some time:
> > >
> > >   kepler:~/tip/tools/perf> make clean
> > >   Makefile.perf:1149: *** Missing bpftool input for generating vmlinu=
x.h.  Stop.
> > >   make: *** [Makefile:90: clean] Error 2
> > >
> > > ... but if I clone a new repository, it works fine, until a point.
> > >
> > > 'make clean' doesn't work - and 'make mrproper' in the main kernel
> > > directory doesn't clean up properly.
> > >
> > > Only if I do a brute-force:
> > >
> > >         rm -rf tools/
> > >         git checkout HEAD -f
> > >
> > > does it get resolved.
> > >
> > > The failure condition triggers if I Ctrl-C the following build a coup=
le of
> > > times, without it being finished:
> > >
> > >
> > >    cd tools/perf; make clean install
> > >    ...
> > >
> > >    LD      util/perf-in.o
> > >    LD      perf-in.o
> > >    CC      pmu-events/pmu-events.o
> > >  ^Cmake[3]: *** [pmu-events/Build:43: pmu-events/pmu-events.o] Interr=
upt
> > >  make[2]: *** [Makefile.perf:709: pmu-events/pmu-events-in.o] Interru=
pt
> > >  make[1]: *** [Makefile.perf:264: sub-make] Interrupt
> > >  make: *** [Makefile:113: install] Interrupt
> > >  kepler:~/tip> perfi
> > >  Makefile.perf:1149: *** Missing bpftool input for generating vmlinux=
h.  Stop.
> > >  make: *** [Makefile:90: clean] Error 2
> >
> > We have a checked-in vmlinux.h:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/bpf_skel/vmlinux/vmlinux.h?h=3Dperf-tools-next
> > so this shouldn't have been a problem for a while. bpftool is no
> > longer on that line:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n1149
> > so I suspect if you use a newer tree then things will work.
>
> Was this regression fix propagated to v6.9 in time?

We switched to using the handwritten file in v6.4:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/t=
ools/perf/util/bpf_skel/vmlinux.h?id=3Da887466562b425bd6183bf75b523c1477c9f=
d22d

Thanks,
Ian

> Thanks,
>
>         Ingo


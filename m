Return-Path: <linux-kernel+bounces-440253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0509EBABF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172781670FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17C21422F;
	Tue, 10 Dec 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zwwlmy8c"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549123ED5E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862124; cv=none; b=TCuE4JFN957csUfYG5IG4gEtvJvh9DWHpqDGBRuxSK4PPOUQtKmA4XD7FW19Hn4SomNw8jBVGPNR8v6DsGtZwSv6gF0TgwDsNhAKeMecZiHxEN8n5tSks/fYes8CZPeiPQ5PTepXzCBS3WjiGQtF4eyuHxpUxSLMPJGdk5R4Loo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862124; c=relaxed/simple;
	bh=VdZ9tWWMXQdXRmLsSkUQnr1nqd2BXz3EBB0bhDeyBoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G15EcVqiX1UrJ+2PE4apZxigHfgyugy1bDgPsnfcdqmBlE8lH+WOFZgIp0cp8rf9jhkc8DA/qfWrS00AHL3Zpi7OJFfiG4IeVqpAnJC6AQUJJvcWBeWPI2AZgdcu6UA2P0Mnf4VNudaGTYx6LHJp6EglVnsCrQBXAS4HyA7yEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zwwlmy8c; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a814c54742so26665ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733862122; x=1734466922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvmfWDO1Af0S26U6cj7VCliJRz5OXCapvu0BjHLNBvs=;
        b=Zwwlmy8cHu+t68oq1s5UeE8xUZ2bhgM07sIg1ZM58FG9Ks1NaXtcFz1djbIPbBDKkM
         z07NoRb90E0N4SQCZ0Sb2EBkqEF1AqtA2hayxfFmSs7Ce/KhjyDi/JI60l4w8CJvbgsw
         8xjq1iH9BcdgNu8jhEqVB3ZjnJp8fdl52v+AD+vQdXGsEVQi2b0BIVppAt1+hRWAksAl
         5CF3TLIPneYwBdE/7RZHzNUKpzvsvbfq6sclTpJtzu3chlZmZ33zj+c395TAoTNmZa51
         ahZtJ8o9KKKUHzUBrn0xdNkCi1j0ZaQNGntcwag7K65a0BrFfFrILqNwCJ/W9rEYzLgJ
         QGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733862122; x=1734466922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvmfWDO1Af0S26U6cj7VCliJRz5OXCapvu0BjHLNBvs=;
        b=jEtTUi3/P+aIdHSx2CGRYwCUUiem0u+aeFJQUSVowrWD5O7IrPc/H5RjEhSR4M4BwT
         8puxV8uiXEN51pERZKPae50Ey3kmovL+0cqGRItLB1HZ61lKMMH6OwHd7fdIuPv8xGWQ
         0UYmKzWDyyaqNkSjDu2MV1c8SAzri0kh/d8iz/LSO68czk07cpH9WxMVkd99lTKP9Gxy
         vMD45r0I9RN9kz0zdpz3q9kycz6v8AZ+Z0WocazTsMC5Ew8VYfGgv9S9jSLxYPBxvpXT
         SdS2tcdwckVVpcQcw02swQeqhZU4TPi3YCI8dQdURyBP9U4VeLbXIax/5qRnI/paMY0V
         KeuA==
X-Forwarded-Encrypted: i=1; AJvYcCWUgYc4eOi/SELvtkrjABvgpI8SFkBGkhDgCbUoEJ8MCsliy7MoyH6LhC6zmz40ACBfT89VfpdqZoGACwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq28PdoQqwP5VpiHm5SXaGnSSayb4LsKGFxvPKyCbSVmM+MPWD
	3skixrJmKZY2q0aPNzfZl01uRrgP+HC3n21GXGbbUP1HhwK4bZibg5cy9uDyMr90k2N5+3oE7Y6
	OWW0aKRMyM3ik4I5DXsY7yvG/ayxXO1L2ulCD
X-Gm-Gg: ASbGnctudpZ4q9VFrnH4ySyv+5oVDjhOVI8iFh+oTabsstK08Ih5tzwuKreOPUn5nLT
	B52817bIKHSSgnITEJt/q/E41LJq5SlAr1FcZ
X-Google-Smtp-Source: AGHT+IHLGIQXkLZux6LSbCvDW6FPEK24Ir2c4mFDudpsdRPS9Pn+YMo+EzV5uv05eEfk+eFqJY9OyH/BHVAMKmUT1R4=
X-Received: by 2002:a05:6e02:368e:b0:3a7:aa54:ce07 with SMTP id
 e9e14a558f8ab-3a9f9d277d3mr502585ab.22.1733862121707; Tue, 10 Dec 2024
 12:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113165558.628856-1-irogers@google.com> <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1> <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
 <Z1g-8ggHQ8MoVNhx@x1> <Z1iTtJcMMsuwI0JX@x1> <CAP-5=fXN-KaVnyciw-YBauS=QSWfi36Aan9eGu1xFV57MDcnNA@mail.gmail.com>
 <Z1idV3K4RxLdMhT_@x1> <Z1ieEX22EyS-v36o@x1>
In-Reply-To: <Z1ieEX22EyS-v36o@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Dec 2024 12:21:49 -0800
Message-ID: <CAP-5=fX5U3rWnSd6BhPq31b48tJb62i4kEYJrf+jeMnNZrL2OQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event descriptions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 12:01=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Dec 10, 2024 at 04:58:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Dec 10, 2024 at 11:24:28AM -0800, Ian Rogers wrote:
> > > On Tue, Dec 10, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > On Tue, Dec 10, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > Probably best to have big patches via perf-tools-next at this poi=
nt in
> > > > > time.
> > > >
> > > > I'm seeing this after applying:
> > > >
> > > > /home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py:434=
: SyntaxWarning: invalid escape sequence '\*'
> > > >   return s.replace('*/', '\*\/')
> > >
> > > It likely needs to be:
> > > ```
> > > return s.replace('*/', r'\*\/')
> > > ```
> > > note the r. Could you test for me?
> >
> > Sure.
>
> Yeah, no more warning, thanks, fixed it up.

Thanks for your help!
Ian


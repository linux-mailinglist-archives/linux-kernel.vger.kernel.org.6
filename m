Return-Path: <linux-kernel+bounces-440200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9A9EBA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80901887589
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2432224AEB;
	Tue, 10 Dec 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twXyuEm9"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE61214227
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858683; cv=none; b=Du852l8FzlhurGtFxwN3km8S5uH4uM5c5tnwz164ZW68BI7eczGjocHe6V/pf4wnK8VGcYtm3zCLQtjDEiykkuaFegc20N1vkgqDyePBAyc//GHTKhj1PVBHLI+SVQo87TbI+eyNBfuUesmwVaDIteXaYQb3GJYU317vPtfyXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858683; c=relaxed/simple;
	bh=wHazKxpJJ9Mpp4ZGU/vlkDthk9ec62y08omFW08QEB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2CYKKFrmxIIoT45JF8XmmcICqn3BBAk2n3mzeA2557tgRS5aG1T/gJyZ9F5RNG4i566eQW0VKqv1bwtj1KT0T6rwrXLTjCzm59mPEFi+nhUr5F9X31IUFgIRzHRc6ypO+E7NCqSovojGbrUMHthGGj32gVAnbTyBX4/jLX9xbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twXyuEm9; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so16155ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733858679; x=1734463479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA6uiztyFHUbzaCAlvb0H4MHj6VifXu4SlKDCoeA/xM=;
        b=twXyuEm9CcSSACg0MgdDEsx3Rk8oYtwgdrXdIt7AvSfSvT0YPSgDOzlOx3xKl4B1Ir
         B4e8UPUZl2Q010TevaB3NeIrb+YnVWx7eOZvEkcEN3N0ZHZ7SamU4fLJqMekzzk3hakh
         RBj8maqRcFXfsjmNNP/b4l4XKtrbB2Ox4UEJ1I7J+g8USZFDjVay5zL/AaBKM4r/B32k
         Z1IA//Qss0r1sXphrDRFdfzNN2QoJh6tKGrodh4ML7AQ/XBBRP0MNpwad1IrJAgvq9HJ
         wi5QDKJat+aIfpBWTZ048J1JzvxB3WH30qFxrmkXt0VH0gNds1e5wJjfnw0dASp/QjeY
         KZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858679; x=1734463479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA6uiztyFHUbzaCAlvb0H4MHj6VifXu4SlKDCoeA/xM=;
        b=NGzNMvI5n1LV5VnWzOazNKaSTIdn3vwAIjs2AFFawZcUT302mdP9aJcRIOOxUk+o2i
         3EKzSeCwUhi0+jmtoJ5c8lnTI/Ttd1USAPVa5K87i+h4rrMX3djiStAysp/QqsE9N0R+
         S7A5cJWmtPs1V8sqp7f/ikHOdkU2Hvnt9IhliL9g+d05+IuM2mbZnsEHjwzXmmEtegFn
         gP8AWFkoMBZyOnNqIlJSiRqWdXMHnPcPMYmL4QjBPYJqIMcieS37ZfR6svfxNoiH6Wtm
         VixqGpLp9RGQDDRyUsAepW6/3IK0nYwLJz88F5j6grQWuRoOqeNqu+oQvDB/4NFJGAWR
         AaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVarIKx3m/6lBIbz7cJN1lQjZy4w2XoLZxORzV/ZJEKXzFp83jYDK7AXTEtn6+PlRchcEYr9oSyDCuvQsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNclDXGog3MEoJd6ik71x/eu8ufnwyMzYaa44KZse8Pw9sRLJT
	Ji2IWR4u3shYhhYtgza+8QRv3UGWDbhBeo8qUn62f6ruKkGiPoQZ2wE+EZmyxy1lD6p2exi6Du8
	/5u4uQiWAIwexGlvSKyWglRiaPWcLdi2EkZRd
X-Gm-Gg: ASbGncvTmJRLrIPPGJ/ZrZKoueFnl8B813vLLhiZ1kU8Nd5WqcirrRkaTsPpQa0CXme
	2OsIrQ0gFXN6AzphbqSBoFNefrrM1NbPKW0Cy
X-Google-Smtp-Source: AGHT+IFQdl6+o4/jDzSSu2u0KI/uMp73hkzZCGcfuo63dzkrt0UMs+yfVU8rjikFl8vCZUnCEA+64glRRIgoPy44Ze0=
X-Received: by 2002:a05:6e02:3003:b0:3a7:dfa4:9a4f with SMTP id
 e9e14a558f8ab-3a9ef4370bbmr368235ab.0.1733858679301; Tue, 10 Dec 2024
 11:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113165558.628856-1-irogers@google.com> <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1> <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
 <Z1g-8ggHQ8MoVNhx@x1> <Z1iTtJcMMsuwI0JX@x1>
In-Reply-To: <Z1iTtJcMMsuwI0JX@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Dec 2024 11:24:28 -0800
Message-ID: <CAP-5=fXN-KaVnyciw-YBauS=QSWfi36Aan9eGu1xFV57MDcnNA@mail.gmail.com>
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

On Tue, Dec 10, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Dec 10, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Dec 09, 2024 at 01:29:15PM -0800, Ian Rogers wrote:
> > > On Mon, Dec 9, 2024 at 12:28=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Mon, Dec 09, 2024 at 10:35:34AM -0800, Ian Rogers wrote:
> > > > > On Wed, Nov 13, 2024 at 8:56=E2=80=AFAM Ian Rogers <irogers@googl=
e.com> wrote:
> > > > > >
> > > > > > For big string offsets we output comments for what string the o=
ffset
> > > > > > is for. If the string contains a '*/' as seen in Intel Arrowlak=
e event
> > > > > > descriptions, then this causes C parsing issues for the generat=
ed
> > > > > > pmu-events.c. Catch such '*/' values and escape to avoid this.
> > > > > >
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > Ping.
> > > >
> > > > A fixes: is missing, probably this should go via perf-tools, i.e. f=
or
> > > > this merge window?
> > >
> > > We don't yet have arrowlake events/metrics, should there be a fixes?
> >
> > Ok, thanks for the clarification.
> >
> > > I'm just preparing the patches for the latest vendor json from Intel,
> > > but they will depend on this. I suspect given the size of the vendor
> > > json it will miss the current merge window.
> >
> > Probably best to have big patches via perf-tools-next at this point in
> > time.
>
> I'm seeing this after applying:
>
> /home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py:434: Synt=
axWarning: invalid escape sequence '\*'
>   return s.replace('*/', '\*\/')

It likely needs to be:
```
return s.replace('*/', r'\*\/')
```
note the r. Could you test for me?

Thanks,
Ian

>
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ head /etc/os-release
> NAME=3D"Fedora Linux"
> VERSION=3D"40 (Toolbx Container Image)"
> ID=3Dfedora
> VERSION_ID=3D40
> VERSION_CODENAME=3D""
> PLATFORM_ID=3D"platform:f40"
> PRETTY_NAME=3D"Fedora Linux 40 (Toolbx Container Image)"
> ANSI_COLOR=3D"0;38;2;60;110;180"
> LOGO=3Dfedora-logo-icon
> CPE_NAME=3D"cpe:/o:fedoraproject:fedora:40"
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ python --version
> Python 3.12.7
> =E2=AC=A2 [acme@toolbox perf-tools-next]$


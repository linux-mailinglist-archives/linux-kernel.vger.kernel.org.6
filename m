Return-Path: <linux-kernel+bounces-522591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB5A3CC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BAE7A7C76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AD6255E46;
	Wed, 19 Feb 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nv/4T04U"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1071B4F21
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003118; cv=none; b=fVZFJ4A9rB1+N+YO8QxtSbFENAWiPQZ+2/KLsfOzFwGucquXzUQnzUpY3w2uzJRN8sc7f47MHcsmNzMowORgoFQH2ttSpll9kMmUikFUW4nyKAVvxhzEvAoVnGdHLJTGst6OXZAG071ugkLm2jyimEQs1exOYm1B/0gXaNfGnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003118; c=relaxed/simple;
	bh=ZSV2XFFcj0GPI8zUDnU8tdH44VjKfteko0rzddXUI0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9tLdw8Ue0t8IKf9faQ7NDkmM1+qdrsVFBHPdqqecfLyqVE4vApj5AVUaDJ3GzDYefJ0FBgB2cRA2u7Q9MSivu2cYanSwjlDtsN4sqmLLcuVBVYyKGIIaC3oKgkAjKdu/2WlxD/+d19+GV+1MlJ34ntFv3TTVFV2UTJCVylv/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nv/4T04U; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so19475ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740003116; x=1740607916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6ArLCB4R8roBsda9VKkvi/MZSJCY2OE3VLm6uu/stU=;
        b=Nv/4T04UZLA6R3cezr+UfAK/yqfNNb9qzjnv33RH3cGuPvkwBeVLCUGuKI1GN4t0Cu
         kN4f3VenvuWmCxyAcTa9nRUVHXC4ZkSvUU2frJZqUbVF+lUbGnkP1bTgLbYrnW8hfAqi
         oMBcATpFjam5Ah216oitlR9/HqNMg+TB7EbrbIVbRtjEi38uJyW9FoZYRitgf/2b++hD
         +GVL8J4/388A4BjNIRDtDvP2UrmiKrVnQx4K8WujwvQEmQv3pPh68URjVf8ULTdvgYP7
         thIx/PqL/YSCDShv5iiWErI1FItFpKLGFzxzOENXCNisTb3OY56t0Y06ENTlvhqt7EZi
         Iecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003116; x=1740607916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6ArLCB4R8roBsda9VKkvi/MZSJCY2OE3VLm6uu/stU=;
        b=JXiYlXnyUboPGyqOzk+sJThLbHJBups6N1gR/YDAK4eUMkxklDXgm5q5a/gBbGw+Lx
         HdYWaNVubphkUiU/umBNjre5XQkf0HqwWM0cWEqVYPlus6Ge2fb6ccYcbH4pYzvyrTRl
         sRoj4lXo6YNUDXVT4s1yixDcFvEd/ZdxYt5p3ot2+VAEBXJZelfI3V6W0vv7Ios4mhW5
         TWbnzhjpwF6bML/I1IECc9169hG/lek4Lr8W707RCU2Xm+fVuEhqIfK9YMwNB5H3EBDf
         aNLnVc6d2SdBZvC+uq926HOlKbmG2P7zqHqA7blSIKI/t3K3uYfOhYIkez+FUfN9GP+7
         6okA==
X-Forwarded-Encrypted: i=1; AJvYcCXN3xte9O6Cy3Nz0vGYKfrLtVhu0wV2DljBS1S8pJP9JKd7iEbOZEqkzKQjjvYSqt1zkHDm9xxZ1INWKso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAk6Yt8THdOZfs0sDGSM1oXFx8V7ngOtA4BLCK9Sbyqbj/7pK
	VQ9lh7klQi/B0hFD8jpW9J98QIQP5jjFbopaCHGfY11/hQyNQ9qcSFZCumxS+zHRdeceCimEcBY
	mdX707SNg/2n1VlEnFJzNGZPNHHj7ZHEpp4XG
X-Gm-Gg: ASbGncuSeIt6e339ibW2N71xYTLyyRto5NksG+5/AAl5LSq538wq1M9FxDB8NFVT6Cn
	pUTSCS3RcpYY4tVz0YGyq6h7lYscMDP1SnzcyVOnLWpbQvtGaDfZiAEaeMXw0r53Yh3Bu4B91R6
	ClSd0A11/w+LmxDJNOK6NFjGFSFQ==
X-Google-Smtp-Source: AGHT+IGhcAVq+WRuRQVnOuGGJtUQeqPrN7aOEOZtJgaXAh4ql05WNUT5TuGe/Y3K+XW3iNQqSaY3slehVT3VVATri5c=
X-Received: by 2002:a05:6e02:1564:b0:3a7:e3b3:2e3 with SMTP id
 e9e14a558f8ab-3d2c24e2cabmr249395ab.17.1740003115887; Wed, 19 Feb 2025
 14:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109175401.161340-1-irogers@google.com> <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
 <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com> <Z7ZD5phOOCbKggrn@google.com>
In-Reply-To: <Z7ZD5phOOCbKggrn@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 14:11:43 -0800
X-Gm-Features: AWEUYZk6j6515T41cTNxcsJrjdJ1p2AxDpZySNgLbQrIYaG_Rg_DMAueizS4zec
Message-ID: <CAP-5=fXeZM7iWNQq0ar1HmAwWrH4HAHqD3F=ueB=jaw-2UMn_w@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, Feb 19, 2025 at 11:02:40AM -0800, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 11:23=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Thu, Jan 9, 2025 at 9:54=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PM=
Us
> > > > before parsing") names (generally event names) excluded hyphen (min=
us)
> > > > symbols as the formation of legacy names with hyphens was handled i=
n
> > > > the yacc code. That commit allowed hyphens supposedly making
> > > > name_minus unnecessary. However, changing name_minus to name has
> > > > issues in the term config tokens as then name ends up having priori=
ty
> > > > over numbers and name allows matching numbers since commit
> > > > 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with dig=
its
> > > > "). It is also permissable for a name to match with a colon (':') i=
n
> > > > it when its in a config term list. To address this rename name_minu=
s
> > > > to term_name, make the pattern match name's except for the colon, a=
dd
> > > > number matching into the config term region with a higher priority
> > > > than name matching. This addresses an inconsistency and allows grea=
ter
> > > > matching for names inside of term lists, for example, they may star=
t
> > > > with a number.
> > > >
> > > > Rename name_tag to quoted_name and update comments and helper
> > > > functions to avoid str detecting quoted strings which was already d=
one
> > > > by the lexer.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Ping. This patch addresses name parsing inconsistencies, in particula=
r
> > > events may start with a number without a PMU, but not with. It also
> > > aims to give better names to patterns than name_minus and name_tag
> > > (with term_name and quoted_name respectively) that have drifted from
> > > their original meaning and become to me less than intention revealing=
.
> >
> > Ping.
>
> Sorry for the delay.  Can you please give an example for better
> understanding if there's a change in the behavior?

The example in:
https://lore.kernel.org/r/20240510-perf_digit-v4-3-db1553f3233b@codewreck.o=
rg
is `perf trace -e '9p:*'` which allows the number to start a
tracepoint name, but what is true for tracepoint names is also true
for event names. I lack the tracepoint but the patch here is making
that work if the event/tracepoint is specified with a PMU, so:

Before the input is just seen as broken:
```
$ perf stat -e 'tracepoint/9p:9p/' true
event syntax error: 'tracepoint/9p:9p/'
                               \___ Unrecognized input
Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```

After the input fails because the event wasn't found:
```
$ perf stat -e 'tracepoint/9p:9p/' true
event syntax error: 'tracepoint/9p:9p/'
                    \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'tracepoint'

event syntax error: 'tracepoint/9p:9p/'
                               \___ unknown term '9p:9p' for pmu 'tracepoin=
t'

valid terms: config,config1,config2,config3,name,period,percore,metric-id

event syntax error: 'tracepoint/9p:9p/'
                               \___ unknown term '9p:9p' for pmu 'tracepoin=
t'

valid terms: config,config1,config2,config3,name,period,percore,metric-id
Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```

But the patch is just about making the name term more consistent and
cleaner, the weirdness above wasn't its main point, I want the code to
be easy to read and understand.

Thanks,
Ian


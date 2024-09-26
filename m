Return-Path: <linux-kernel+bounces-341043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC2987AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C67283F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0039188719;
	Thu, 26 Sep 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvnfKl52"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5F18870F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386500; cv=none; b=Hyc+F7dRPN5nAZsO3n4ZDGVuGthkmhP+zgjSRQRlD65ZabW5211ZjiZUTfVd/9B1sELMoWgtnXX+njwtgjzuigG3URNK/c4DeWexHb6QkxCsO1+23QHDNNglY67YjIBnOl07j384ADCPr4wFoP0N0boEVWginPdnekP971nAjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386500; c=relaxed/simple;
	bh=sXuVaKEonPIKosH2orXhpZe2Ha1PuBdnIKyXUyo1xxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFyraTs/g01ACrrVx3ripAtvSEnJANQ57H0UTYmPO09XazaEwVUAGVuqeWXWwJ7D5HQO7i+LtMhlBsVA4B3Ck2+8H2d+yN/+mcxdJ+cOUroZdmoc8qGm07Z+bDDDsfr5Y/5g4+grsEkFM91Y6l2TtGf/uOifiLObgAPyUQgNLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvnfKl52; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a2769d774cso66865ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727386497; x=1727991297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3ys5pi3iJKdCNJc+dP6UG9C7uKed6bzhlzubnhFXj0=;
        b=gvnfKl52SFo7RFvRzhZ9l36UJ1ABym2VriSGG6sX22RDBBDEBVUv9dRvMzURqeGOnh
         cxBNagmMB+xHEywlCoUDDAR0awrkS2HKY+2ahVh5HK1Hniqcq7Ahq43kq1F2EoPbK6Vl
         DFlQPxeSja7N1zeJBd82ANxzhtqA9EJOp28n2ueeZ/RgECY6Mjufh+tI6NqB2w4QOljV
         oMrrYpMNb4xEjczUahwdeNBaWhhm90TKgKnVqEllUZRToPLzpyP1cBJfIa79fc4PQvEX
         xphcXwk1FrfZ5+FXd4EyqQ4ASmC/6eW3NXtzYHAAElW0zUut8gtczylRQTlvnl9dvb7X
         Tv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727386497; x=1727991297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3ys5pi3iJKdCNJc+dP6UG9C7uKed6bzhlzubnhFXj0=;
        b=PPrK6GFokF8c69o9QdEiVN7UlN41WWiVh5zCHHqrC7VSCH0CVe0m1fizMkaVEoA0AN
         R5znrUGvsJUZcJ69ZRbpBOTXybUlNcsJBr1jbjRdhHyXWzWLSOGuDdhV/6YT2ymjoSj+
         5L8k3ASNdUMqxXeohEVAe0h+bUBO0PsRbhVzXgAoJ+i/3prJWYOuXeN/qmCvoO4MwWXm
         rxb6kOGLupzbQMdBNx+YsRPr37Fu0ChuEVfE5qb2J3/4vv7XYjk07/htKTDdUJsjqTJ6
         QL5UY1ce79y3vpZJKmUhFoP9ywACt3pZzZfjyvWazad3EswcLZWmKsVp7tG0AAqwhYUM
         nt7w==
X-Forwarded-Encrypted: i=1; AJvYcCWvbCazqttyd7WAW9OXjwlv1LstwG+ADuhNMqal8Iij4JwvQH8FO7NxPCRJi09wiHCd+SCLlhl3HVdLCKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyubdj4AwlJaaavesRkjHXAnR7CK+4h1uCzE6DpLqBWaxAxI9F
	4XC6yZsQ7yjzWaECWConLuj6VQYi6XPdh6s8/+DEAQBfTCMyhG7Nl+gP3QR4Q0tvCDm79cN1N4+
	Xf2IXz1iiiQZ2hYlDyLTs7JK00U12lrYcfSyN
X-Google-Smtp-Source: AGHT+IHKYt5N4DuFIgfp9EMxSz5/JuHxq92sIthoPP6ktmct3B7k9c3RHD41qO3fS+kr7PHhzEB5jCnfi3lNPUFvpWU=
X-Received: by 2002:a05:6e02:1a6e:b0:3a0:926a:8d35 with SMTP id
 e9e14a558f8ab-3a346b6faf0mr279735ab.17.1727386497334; Thu, 26 Sep 2024
 14:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716132951.1748662-1-kan.liang@linux.intel.com>
 <CAP-5=fVZVU7kMOHz7CC7O1+2dX844dHqhqMebzEKWMA=59am-g@mail.gmail.com> <Zqo8kVXkN_UaTp6f@x1>
In-Reply-To: <Zqo8kVXkN_UaTp6f@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 14:34:43 -0700
Message-ID: <CAP-5=fX=QR66nQ6VKRMFfiFdueiC1EUGmxSbT9RCkW8dz67e6w@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Don't stop at the first matched pmu when
 searching a events table
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kan.liang@linux.intel.com, namhyung@kernel.org, adrian.hunter@intel.com, 
	peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Jul 16, 2024 at 09:30:01AM -0700, Ian Rogers wrote:
> > On Tue, Jul 16, 2024 at 6:29=E2=80=AFAM <kan.liang@linux.intel.com> wro=
te:
> > >
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > >
> > > The "perf all PMU test" fails on a Coffee Lake machine.
> > >
> > > The failure is caused by the below change in the commit e2641db83f18
> > > ("perf vendor events: Add/update skylake events/metrics").
> > >
> > > +    {
> > > +        "BriefDescription": "This 48-bit fixed counter counts the UC=
LK cycles",
> > > +        "Counter": "FIXED",
> > > +        "EventCode": "0xff",
> > > +        "EventName": "UNC_CLOCK.SOCKET",
> > > +        "PerPkg": "1",
> > > +        "PublicDescription": "This 48-bit fixed counter counts the U=
CLK cycles.",
> > > +        "Unit": "cbox_0"
> > >      }
> > >
> > > The other cbox events have the unit name "CBOX", while the fixed coun=
ter
> > > has a unit name "cbox_0". So the events_table will maintain separate
> > > entries for cbox and cbox_0.
> > >
> > > The perf_pmus__print_pmu_events() calculates the total number of even=
ts,
> > > allocate an aliases buffer, store all the events into the buffer, sor=
t,
> > > and print all the aliases one by one.
> > >
> > > The problem is that the calculated total number of events doesn't mat=
ch
> > > the stored events in the aliases buffer.
> > >
> > > The perf_pmu__num_events() is used to calculate the number of events.=
 It
> > > invokes the pmu_events_table__num_events() to go through the entire
> > > events_table to find all events. Because of the
> > > pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. S=
o
> > > the events for cbox and cbox_0 are all counted.
> > >
> > > When storing events into the aliases buffer, the
> > > perf_pmu__for_each_event() only process the events for cbox.
> > >
> > > Since a bigger buffer was allocated, the last entry are all 0.
> > > When printing all the aliases, null will be outputted, and trigger th=
e
> > > failure.
> > >
> > > The mismatch was introduced from the commit e3edd6cf6399 ("perf
> > > pmu-events: Reduce processed events by passing PMU"). The
> > > pmu_events_table__for_each_event() stops immediately once a pmu is se=
t.
> > > But for uncore, especially this case, the method is wrong and mismatc=
h
> > > what perf does in the perf_pmu__num_events().
> > >
> > > With the patch,
> > > $ perf list pmu | grep -A 1 clock.socket
> > >    unc_clock.socket
> > >         [This 48-bit fixed counter counts the UCLK cycles. Unit: unco=
re_cbox_0
> > > $ perf test "perf all PMU test"
> > >   107: perf all PMU test                                             =
  : Ok
> > >
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/all/202407101021.2c8baddb-oliver.sang=
@intel.com/
> > > Fixes: e3edd6cf6399 ("perf pmu-events: Reduce processed events by pas=
sing PMU")
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >
> > Awesome sauce, thanks!
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks, applied to tmp.perf-tools-next,

Did this get applied? I'm not seeing it in perf-tools-next:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/lo=
g/tools/perf/pmu-events/jevents.py?h=3Dperf-tools-next

Thanks,
Ian


Return-Path: <linux-kernel+bounces-512564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F705A33ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894643AA18C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564592153EF;
	Thu, 13 Feb 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W48VlXAC"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74D2153E6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437804; cv=none; b=OEh/5XOfSV+KDLS51XCoNjB2Q35wdNMHc6fCXdF5iIgdmPK8dVDQ0XTMH5MD3n6VgdcTmFa5LLWkGaVusbERTuCiMqoXuw81pGrlNDzw8vEKywMzgQ5s2s6hcgWMHxlH3tCAOnONOs7dqhK6i0twkAAIskLKAGrZZoUcAIQN9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437804; c=relaxed/simple;
	bh=QdskmGKWM/qnUzxfNQMHJRQJUkPpsk2HO2GVHL9SJQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=up2cdHKyrUbOPwwqH1E400z5T6aiCa/9WViYqMqBoaZodZPXaR/jYSAn5lpr3La0FRwel5xPqX+pcVG7CqTUJAWNjtiQrLacdJeuSTfu0vxxbWOEPgRcMXKfhhatHNe/PPorHdqYb7jHKg/k5MnWcoREv5Ru4KrBJLOn+UI/DgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W48VlXAC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-308e9ff235bso5752641fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437801; x=1740042601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1j8KVu3ImMqXcK5kW58H7/M7+afJxS0MhcpLzIGID4=;
        b=W48VlXACyl0X/4TNxIqNDD/Z4saO4DH47GmhdGejKrQ1Dpgk04oifXtXiksfKabm+u
         E+x3/giOIZCWZ4cQQXZ7b+2OW8/Bzz8LfSAIi3zDVf+PYpjg/wEHa8s8RoPf6lJIkqtJ
         2VbuzPt+JL575w5wgQLnJMi4pUtQRGUPJLj9J6yOCnUfh2VhTTB4guxfFyH0kDRL84sp
         zRWErPBkSHmeU9yqNsOxV9CiBKQunebUGzTEW9ZxibCr+Gc7q/T2szjhUmQ/HQ1KhdHB
         j/SNEs2mWe/2WYOuntteBGgsiOI1iL6r6/D40hOq3IqGArM8tjS0LVgOIWWKHu8cz0cl
         K4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437801; x=1740042601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1j8KVu3ImMqXcK5kW58H7/M7+afJxS0MhcpLzIGID4=;
        b=vWG4ZBjFs4gw/KIvhhWDtcli4ks9CUhdsYTFlGESEfB2/4O2UkFdlw7NbvM4zKKRxk
         sQaEdkwBpxK6HIZX64SB327LWka0rINF/hCuwT4hzKXQTKE8+tZ3RhX9/uHGu2VEZjM/
         sPor4Qm6MzIAR03vWDewwuVihZKs4OCaaMxmoFYwv3Db1FEgJuki5OzaMjIJFiIhsETX
         Txe327gcLhjqGa9yReIQkp+k1B5Zcdn7dimJiXE/qcZfQdlTRu3r/uyX8yy+ZENinzZv
         W+WseEK/PK0f4RBdr3gWK31D+l2ITMAam+JdCH8sgieVTOHtk7Thxgzxev2LO9DWpxOE
         OmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmcdZq4DTBSKDZqB/sKqPjYP7QxT+GyJgxyLlxRditN3AwQ6F8iENN5kgJvJJm8FUYsFPDxGtk2NffgnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5buJorhlQKSCFKjmgn/sG74+iVAQLrWEa9vI8fFuGhy3/d7C
	7EP0IyrjwPGj7D1S1DbyfnSGhAJ/YVI0+75QFlOSBIajkSXcPbNMtLPub3eZpYdbuj/JtZOtqfZ
	vG9V9OCy+a6cyMJmiaYOwo7AWkb/BRnXC2qbI
X-Gm-Gg: ASbGncvqUg2e/4ih+JYTTAE/s6m61r+F3l/AWwaNt7prJCP9w+Vm3T9bMuVgTTg2bAx
	unVJpP6Xw5LWYnmi/0RBP32cJrIFeM1ni6mZ01FOHEep3a9RkAGm1B/p46cwCjzLOMdlgbvCL47
	4Owz+TNCA2wtHOZBJnsMo2FT58TONSFg==
X-Google-Smtp-Source: AGHT+IFYpwSWkrafXJGJ14Mo/8vLQLp/RyE3eNWDbRrJPVQM2vkOvkkb7ydWSD9NvFUOlx+ZYPnS+CiO3fsVJ8DczIU=
X-Received: by 2002:a2e:a80e:0:b0:308:ec6f:7022 with SMTP id
 38308e7fff4ca-3090366a994mr27722751fa.17.1739437800625; Thu, 13 Feb 2025
 01:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <87ldujkjsi.fsf@linux.intel.com>
 <CACT4Y+awFXT2j+HMeAy2RKnoBzb--+heFzJUoBZWp9iJevy1Dw@mail.gmail.com>
 <Z6ZRVeoFxT0NV9yb@tassilo> <CACT4Y+bOVd4hw2fkE4ahJnbyAuc_=wMu_HMkAUbAhL--dTxBiA@mail.gmail.com>
In-Reply-To: <CACT4Y+bOVd4hw2fkE4ahJnbyAuc_=wMu_HMkAUbAhL--dTxBiA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 13 Feb 2025 10:09:48 +0100
X-Gm-Features: AWEUYZlilTS_96i68RXq9EjwpscAiKpQsRAW_XlXKSTWt6TPYXuwX5hnwnWXLS4
Message-ID: <CACT4Y+Z4ea9VBLFamA4K+Eqj0Pimvf7yYdrtDMAxh9TAc7BBOA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
To: Andi Kleen <ak@linux.intel.com>
Cc: namhyung@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 08:17, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, 7 Feb 2025 at 19:30, Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > > I assume it just works, but might be worth checking.
> > >
> > > Yes, it seems to just work as one would assume. Things just combine as intended.
> >
> > Great.
> >
> > >
> > > > It was intended to address some of these issues too.
> > >
> > > What issue? Latency profiling? I wonder what approach you had in mind?
> >
> > The problem with gaps in parallelism is usually how things change
> > over time. If you have e.g. idle periods they tend to look different
> > in the profile. with the full aggregation you don't see it, but with
> > a time series it tends to stand out.
> >
> > But yes that approach usually only works for large gaps. I guess
> > yours is better for more fine grained issues.
> >
> > And I guess it might not be the most intutive for less experienced
> > users.
> >
> > This is BTW actually a case for using a perf data GUI like hotspot or
> > vtune which can visualize this better and you can zoom arbitrarily.
> > Standard perf has only timechart for it, but it's a bit clunky to use
> > and only shows the reschedules.
> >
> > > Also (1) user still needs to understand the default profile is wrong,
> > > (2) be proficient with perf features, (3) manually aggregate lots of
> > > data (time slicing increases amount of data in the profile X times),
> > > (4) deal with inaccuracy caused by edge effects (e.g. slice is 1s, but
> > > program phase changed mid-second).
> >
> > If you're lucky and the problem is not long tail you can use a high
> > percentage cut off (--percent-limit) to eliminate most of the data.
> >
> > Then you just have "topN functions over time" which tends to be quite
> > readable. One drawback of that approach is that it doesn't show
> > the "other", but perhaps we'll fix that one day.
> >
> > But yes that perf has too many options and is not intuitive and most
> > people miss most of the features is an inherent problem. I don't have
> > a good solution for that unfortunately, other than perhaps better
> > documentation.
>
> I don't think this is a solution :(
>
> I provided lots of rationale for making this latency profiling enabled
> by default in this patch series for this reason. If we just capture
> context switches, then we can show both overhead and latency, even if
> we sort by overhead by default, people would still see the latency
> column and may start thinking/asking questions.
> But this is not happening, so mostly people on this thread will know about it :)
>
>
> > > But it does open some interesting capabilities in combination with a
> > > latency profile, e.g. the following shows how parallelism was changing
> > > over time.
> > >
> > > for perf make profile:
> >
> > Very nice! Looks useful.
> >
> > Perhaps add that variant to tips.txt too.

Now done in v7

> That's a good idea.
> I am waiting for other feedback to not resend the series just because of this.
>
>
> > > perf report -F time,latency,parallelism --time-quantum=1s
> > >
> > > # Time           Latency  Parallelism
> > > # ............  ........  ...........
> > > #
> > >   1795957.0000     1.42%            1
> > >   1795957.0000     0.07%            2
> > >   1795957.0000     0.01%            3
> > >   1795957.0000     0.00%            4
> > >
> > >   1795958.0000     4.82%            1
> > >   1795958.0000     0.11%            2
> > >   1795958.0000     0.00%            3
> > > ...
> > >   1795964.0000     1.76%            2
> > >   1795964.0000     0.58%            4
> > >   1795964.0000     0.45%            1
> > >   1795964.0000     0.23%           10
> > >   1795964.0000     0.21%            6
> > >
> > > /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
> > >
> > > Here it finally started running on more than 1 CPU.
> >
> >
> > -Andi


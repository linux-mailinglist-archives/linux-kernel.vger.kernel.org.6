Return-Path: <linux-kernel+bounces-403095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C339C30FF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 06:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7871C20AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 05:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E6B149011;
	Sun, 10 Nov 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXtD2Gtg"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365DE22615
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731217824; cv=none; b=iXl/D0y1NcjpqmRsDTMNxLSl/E3m6eRE8aSaETGIRZVEkXG/V0/P8nJC3e7LpKwU2ixXb1KhCLxca2KP5bdBr2k4RPDvtDOO5Kp0069PFdd+BCkJ8E+1+HaFFUe3IYGrd4sNSagzRh8eeqQat7BCcpXOY4wYK+sDhsGh+tYd3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731217824; c=relaxed/simple;
	bh=pVtLTrl7mXN5A86OwhFYkC2wUBFQ9aXKK5yt9yWH6LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB7318/WheSNX10V1A5MqDua9+utBMrSXkgU4ejvB1LgbUf86JpImjzCwtAziO9P2XjQP6UKLFcZrAdgUUUxnUhZKnFMR6uD/FboaTqjXwrE3VMiXX0vGZLEbeAltpPttbJ4qdp1btpVekApGorIewoS4OSZr3PU0VikiM8vV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXtD2Gtg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so2701018a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 21:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731217822; x=1731822622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6vEDwi+LaT9/oZYsrt6AmK5JrrrMR6Ri+Cy33ar0sI=;
        b=KXtD2GtgZXgU2e47T+rhXpE+/0InXSOKGg13gSBeoIjNfHgkDjl+VdG1p1I2EXsMvI
         YuAGKQQymUKWtLXAfW/cGlXfOoCXhnnPaSy7MyGlizRfp1U3OTWimTyRs9xF+erfq+OJ
         pSm9sK5NQYbPJuz9mO3URPh+nIbU6mM6aQmcDLBZ+OxIBlwRVnOJHWiTT6qHzhpu0yuy
         2zCMocGn4kbozw1HA8Mx0olGg16KdnohrH+exDpKicG9ifO/d2YRGDfoN6Vl6SEgpifM
         tDoYFBu9Osuq69gzmfl+zAphc2KWnBuAU/Q/VyfsUjQa8Mm3f+BRm3OLBajZfJwAub7I
         MROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731217822; x=1731822622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6vEDwi+LaT9/oZYsrt6AmK5JrrrMR6Ri+Cy33ar0sI=;
        b=OUZGQZF8uAj12/WhtEGkBii1y9ftPK43YMfOGv7F2Wn0Q2lYZcJ0APHweWnCEncQB5
         S2rUGL8Ksou05ICas8ONmm8j7daNfj3vhv9Dvevy5ralBp0h6iiaQSC5Bq99AQJ638Sv
         c9vWTPgFxKE1wFOo63Sor/zQ7PbQfjU6LRaEV4uKHh06d3OoGwALFUHD5ggiZikk3mkE
         hxNljLics8eIjuwznwqHP/ATTnsTPIvblHqcTSUNgDCsD/4jCDKI1jX6UDKMwzJqT4mt
         PLrdCJu/x5W3xQ6F6CoJqVjDLGClcdCcruviAtMKoQ82FdnBbFbb539yG6hJjgEPwYyw
         0bhA==
X-Forwarded-Encrypted: i=1; AJvYcCWaZR+634IZ84Ncqv7vmo2lT0nuHqSSYHNbswJe23o+p7dT0kPsUSFb97BcYwEAfHE7SfHEBPwdMEVccUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUL97TIrCBEROPJKrpphiEEm7fkKaBj4U5EP/ndZjKdHfELZo
	H45nDYNWLEvx3rFwBLO8pGxlxRd6CMXnA0WT2q6vI2P6o48kNbRINaggnZkujO0sc+tw61hdaHS
	5cwH+LW/+w2ir18unbZAFyS/wUKlmiIQVzE8R
X-Google-Smtp-Source: AGHT+IHwxGzFXILLFsSKbRzbFwzlpOUcEQvqjIJmeY81BxQnBgwLCyrAcBJ9VN7R6fNRC+Eygn2Z9R0KLI/GCbxjOYw=
X-Received: by 2002:a17:90b:38c4:b0:2e2:bb17:a322 with SMTP id
 98e67ed59e1d1-2e9b1796331mr10496767a91.35.1731217822233; Sat, 09 Nov 2024
 21:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net>
In-Reply-To: <20241108083133.GD38786@noisy.programming.kicks-ass.net>
From: Saravana Kannan <saravanak@google.com>
Date: Sat, 9 Nov 2024 21:49:42 -0800
Message-ID: <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, 
	K Prateek Nayak <kprateek.nayak@amd.com>, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:31=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 07, 2024 at 11:28:07PM -0800, Saravana Kannan wrote:
> > Hi scheduler folks,
> >
> > I'm running into some weird scheduling issues when testing non-sched
> > changes on a Pixel 6 that's running close to 6.12-rc5. I'm not sure if
> > this is an issue in earlier kernel versions or not.
> >
>
> It's a bit unfortunate you don't have a known good kernel there. Anyway,
> one thing that recently came up is that DELAY_DEQUEUE can cause some
> delays, specifically it can inhibit wakeup migration.

I disabled DELAY_DEQUEUE and I'm still seeing preemptions or
scheduling latency (after wakeup) when there are plenty of CPUs even
within the same cluster/frequency domain.

Can we tell the scheduler to just spread out all the tasks during
suspend/resume? Doesn't make a lot of sense to try and save power
during a suspend/resume. It's almost always cheaper/better to do those
quickly.

-Saravana


-Saravana

>
> You can either test with that feature turned off, or apply something
> like the following patch:
>
>   https://lkml.kernel.org/r/20241106135346.GL24862@noisy.programming.kick=
s-ass.net


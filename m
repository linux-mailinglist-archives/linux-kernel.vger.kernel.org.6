Return-Path: <linux-kernel+bounces-263567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689393D7C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A87C1F245CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B62917D347;
	Fri, 26 Jul 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scVi4lO1"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD073812
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015851; cv=none; b=BgJabSBbEVWrGzUCTzo+zP0fcEkMFW3yLyt15zkZRPLvpxY43E8WgzdRhFlj4mpncm+RInllPNLsrXqZSWyC/+EyD6hVswAQJeIQbCsWX440K3voO/+vdFHfOo0TvTOIchKZLmGjQZ/qR0dxbiBPWAMLoqWqkKN7TfFqz0bkezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015851; c=relaxed/simple;
	bh=6wkRT8xYEb3zK1bE83f4Y39EZuG09QMTkBMl0VIjcUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqCSBQtm9HwoFHnrXk4BcHkyHdCzUt+QBtV4zUENsTzlED7RG8ND5JyPq0BtnCTFcPn+PAvxXvWyoAmWM0SgZJPqFdSFnHFlXkfyPbxPgkG8kij9wAx1rg5IQ3gZb8+K2x7LjMbBfz/c7cr+gDv23h6PSjxSh6MEweKtSi/ql/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=scVi4lO1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efbc57456so1869910e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722015848; x=1722620648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wkRT8xYEb3zK1bE83f4Y39EZuG09QMTkBMl0VIjcUQ=;
        b=scVi4lO1tdaf6233B5VNagA2Buw22lfpINWkEWbQM+OGP65AQ1hjZO4McHbjVkOS4n
         2zf+DjGx3CsPHWF4PkW1KCj4vHi3LeFcm7ZYfAJybOMJXyXGvxIq9pI/fWqXP2qZX3Y8
         v+Qh0fb7vJ2MsDTtbj1ny9tsu+AUfb9cVf+eVf+34yhuT9G5BEDS0GIeWxPxDq5mmb4X
         my+wP4kAz/o4yWDJsIkJzZnjC2U+v43BZ/whE7sEnE95f5crKoA/JN2VjF5cj0IzIxAq
         G3gkskTH7gh5ODbMIQirI48voHAEtIETZ2Z1T6GhMUu1g62j8vKG9qJpB5tM9ONYGH66
         +XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015848; x=1722620648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wkRT8xYEb3zK1bE83f4Y39EZuG09QMTkBMl0VIjcUQ=;
        b=hjR+ITczmIXIckj6WIC7N3sb5WI+NaNeScwUjAjcst0YVSGEQvQY5WmP+QznIHPcYd
         KABC9HO5ILsNSVabCpxLQGo3pQMkVwzWHOtDx68adtZ6z3Un8IWq2hC+ei70GFs5Jbin
         pBSyg3c3LPb0YMjuz3THEcK4mvN8KRCvHF9+Yjeuqdqykdey5mRMDKr/OWWJm49rOg9L
         5Xkff6y1npQvzNRcQhKIXGdt7sVqb5+thrK/dOm1fD19T5U1yei2U/cSUmfJRT7u1HcW
         ypVAQwQmJbC+n1TRizqYqr3os+0JuPEzroUmSosQc/egaFQhuuJ4dC25rM2npB/XRas1
         7OaA==
X-Forwarded-Encrypted: i=1; AJvYcCV8SMBFxMEW5R8ZUJcPvQh9A4bSXNNmbzTwwzU3jufh3qVI11a6nAfDnmmG5XPOX+NHOP+I0JSxs8u4TH+M8qkQKrfo+Q4L3Ouvk+82
X-Gm-Message-State: AOJu0Yyzm1/voqFfTzETm9MTOx1K7cXBy8syqng+p/WRU1Umcisjlece
	euKdb3uKpKZdU7sl+Eveh1t7x2ebOYa8dpQCi2lc065behJ97HddbsRUXdWjw8s3KNxR032nt4Q
	vTQwO4+wSUZbh/v8Aj17l7VID0UlduJZtrthhqgrUXFXj9R4G8w==
X-Google-Smtp-Source: AGHT+IH0zH4RcaRMCSfEP7q8GVobM5XEVw2We27FrdbthB0wxkDIc2oCYDy428qbvB/pOG0btoGmmUUYPqKMsEkEb0E=
X-Received: by 2002:a19:2d04:0:b0:52e:9382:a36 with SMTP id
 2adb3069b0e04-5309b27b2a9mr355143e87.30.1722015847438; Fri, 26 Jul 2024
 10:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com>
 <lhlfj2keag2ciurt7v76d4nhyk5k5czrkvuocbgxkeep6zgwgo@ifjthvn5osvr>
 <CAJD7tkaW8bkwpUChJPc-Bw1epfrLySVhgr8528yZg5eCg3d=JA@mail.gmail.com> <z2chqotbjp27rtq4c5mrmz3llsn3o523goq4ycy5jt7s4atcdp@xyb34euw2s45>
In-Reply-To: <z2chqotbjp27rtq4c5mrmz3llsn3o523goq4ycy5jt7s4atcdp@xyb34euw2s45>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Jul 2024 10:43:31 -0700
Message-ID: <CAJD7tkYCERG5pUTcdmw8UGks8wtK9W9jzZGZODE6sZ-9-WEv-g@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Greg Thelen <gthelen@google.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 10:30=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Fri, Jul 26, 2024 at 09:25:27AM GMT, Yosry Ahmed wrote:
> > On Fri, Jul 26, 2024 at 8:48=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> [...]
> > >
> > > No, the workloads running in non-root memcgs will not see any
> > > difference. Only the workloads running in root will see charging
> > > overhead.
> >
> > Oh yeah we already charge the root's page counters hierarchically in
> > the upstream kernel, we just do not charge them if the origin of the
> > charge is the root itself.
> >
> > We also have workloads that iterate top-level memcgs to calculate the
> > total charged memory, so memory.children_usage for the root memcg
> > would help.
> >
> > As for memory.current, do you have any data about how much memory is
> > charged to the root itself? We think of the memory charged to the root
> > as system overhead, while the memory charged to top-level memcgs
> > isn't.
> >
> > So basically total_memory - root::memory.children_usage would be a
> > fast way to get a rough estimation of system overhead. The same would
> > not apply for total_memory - root::memory.current if I understand
> > correctly.
>
> Please note that root::memory.children_usage will have top level zombies
> included as well (at least until lru reparenting is not done). So, for
> your example it would provide good estimation of top level zombie memory
> through root::memory.children_usage - top_level(alive)::memory.current.

Good point. The fact that it includes the top-level zombies makes it
less valuable for this use case, as zombie memory is considered system
overhead as well. So we need to iterate the top level memcgs anyway.


Return-Path: <linux-kernel+bounces-288657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942A4953D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCA91F214D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9B15532E;
	Thu, 15 Aug 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dqq4S1TX"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDC154BFB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759845; cv=none; b=o2Tbj8C/d3LboLwtHw4qJrMJKdc+MfzyABZj8k7NsQYpg3I8BsICRH6sZ+a4njvcLIJgooOwWsyMzvmlrj65IbxXnsGWbkd+CMLp2sOp4ZcTk9Lc4m+Kda1Mo6NKUIiMH8Ol1uekUW5XqdcGNp1/5AP/zMI0p4XMUkpeJ3vocMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759845; c=relaxed/simple;
	bh=WbC5d4M1KKpH56P3a+lNKOT6nVYNXfHRA4vpXTBhih8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMkCb7atrK0crLKshP+wOQZclS1ILC3ql/gE0V00muZFz2QnsM2Ql/fTZlKuo+IzefMNq1vjEVA5xXnAxr5bXvXsXA/7lt8um1s1wr2dnoeAOrJLn9r67AiCI4f7GebZtrzRH3vO9/LNrE2aA2t+hcm03muerqTdHafegTWSC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dqq4S1TX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so1980820a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723759842; x=1724364642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbC5d4M1KKpH56P3a+lNKOT6nVYNXfHRA4vpXTBhih8=;
        b=Dqq4S1TXDgFuofU+xhw5Bw38sJ0yJNqcC2R//lHlTbhNUJAbmP2TDh/W4+LmhcSZ+X
         vEzs6QaolhXCsGZ3v/qSI/9ysK/c9QVIk9jxy/s+tMcfosX62dqGDlaUatycvFee/ZvJ
         oJGMYpY0Ma5gWXZfZDoGItUlTJB1U6PSYvnhFbkNaH7ObWnllr4MKYTuJxDiEUcUhCVv
         kKo79GCfxaOOzi6Rq+eNmGigFMC840hbkjLFxkwKFepJ7ll9W9yuvOF2UfJHg6hxjysC
         dSACqv7LvRbx6tw+C4NJ4OnOzUZfjM9r7H3hJnRVhRW/YTEBB4olf+gDu50wun0xxj4b
         IeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759842; x=1724364642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbC5d4M1KKpH56P3a+lNKOT6nVYNXfHRA4vpXTBhih8=;
        b=IPHjKvVB57JRuAO62OhaXKNNv5iD/Bm3ayDXxu3aGCKpJim7iwVfu19iaTEUmGGuQW
         jRYVnuSeOSk2Xfk7IfsNKbQJNN7o1ODU2+TaMNlZIncdtC0MWgPUbnx3tNG02GHloMMu
         e/NwLLlZ4NYhP4td2plR48PYtUwTvxtfqPnc3CHAtekdEBalEXuQ+UtonITGb9r57r0K
         lVu5prUm7LT8ncl8JOR2A3iI5Ki2GO1MyEAXjJmHsavopdFUV1nDjyhybxjTeVHI55sH
         EWSI15SJkorK9MjHqRgJFgCbRrY6dAm15CJ/IYIzvvIY6Wj9VZqmKWzlHAW1fuuZFBIq
         IVXw==
X-Forwarded-Encrypted: i=1; AJvYcCUVDyrhQEWu2m5DThnz+UNm0SAic7ZmZ+yBFTf8XhrMJjNtVCxk9jeSvpAnqBgTT0VS8y64t9cs2FlpG2NSzuGWeoMzHU3LQF3EsYdD
X-Gm-Message-State: AOJu0YxuhHdfytnZp5cdxfsjsQF6a4cUm1LewSOrvl2hv9a1oSx02iEy
	AxLHUpTf5Y5pmH7fyVHuMw0jW/Rd2CrtwmAuVrFeu4Qio+AMik+PPMoo9BTCs2aX5NK+hzhZf4g
	m8Bf6GA+6TytV9DtKDOV8UZHW5zXryMAuDvlZ
X-Google-Smtp-Source: AGHT+IHDPmf6+ClOONhZk9Nso0W2EhtmarkGmfQfspzadJOIG/HidFZptnUBVVUkiTtl79ePE2onlXdj3/v0NAL6Wxc=
X-Received: by 2002:a17:907:97c3:b0:a7a:bae8:f2a1 with SMTP id
 a640c23a62f3a-a8392a03c21mr69498266b.42.1723759841582; Thu, 15 Aug 2024
 15:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
 <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
 <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com> <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
In-Reply-To: <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 15 Aug 2024 15:10:05 -0700
Message-ID: <CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 3:08=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 15 Aug 2024 12:12:26 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > > Yeah, I thought about the other way around and reached the same
> > > conclusion.
> > > And there's permission boundary in the mix too - if root disables zsw=
ap
> > > writeback for its cgroup, the subcgroups, which could possibly be own=
ed
> > > by other users, should not be able to reenable this.
> >
> > Hmm yeah, I think I agree with your and Yosry's reasonings :) It
> > doesn't affect our use case AFAICS, and the code looks solid to me,
> > so:
> >
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>
> But you'd still like an update to Documentation/admin-guide/cgroup-v2.rst=
?


Yeah I'd rather see a v2 with updated docs, and hopefully a selftest
if the existing tests problem is resolved.

Also, do we want a Fixes tag and to backport this so that current
users get the new behavior ASAP?


Return-Path: <linux-kernel+bounces-229377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE73916F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34FA6B22026
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84104176AC5;
	Tue, 25 Jun 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxoBkrMs"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915917554D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336151; cv=none; b=fbakXC60gmyC8EzFf3qO6Rjea42n1xv4astHsPXbXf+FQvc/PQt8ePyMdoLkQMig5zYxi8Pejwa0rG9Ewi3ySDppKWcRFdsxEw+ew5GjJzE+vxPxR/kl/nZkbcDFleqmnfnc/cEs9DklbUFCeGoMqbgPrrf+98u9FMEfLKeqmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336151; c=relaxed/simple;
	bh=iR9SeV4pxy+WU0xDeL//qKWcrGtBQcHjBOf0EE9S0DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zry2HXdcwAPiEwtZq1yDrDPA0pFzbD2XcFZ4/D7UuZT0mRfBimWBgCFNqQPDxV/QsDrc1g3g2mRJuiK1M1LR0R0UcPSidOOLaLPPwSU09dwOJyfmoszUqoOyYKT7mhvnO4sNtAm8xTyu2PacAIHW4M9eJE0sAlpg5rkLc85TkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxoBkrMs; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6fb840d8ffdso3092287a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336149; x=1719940949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR9SeV4pxy+WU0xDeL//qKWcrGtBQcHjBOf0EE9S0DY=;
        b=LxoBkrMsn227BhYB9EtuOWRQ8nBcIDoLDbz7fccs6SfGdflBFQ/Pq6b1uES+2x1OZs
         xoYSsOMpwzXCZ3blIFor8uQTeCVwrMaRGZnC5OLKwwKsBsEjatZhJ9cK1W+OW8sG9DlP
         wh73OqaZAzcP+n7DclxM6Z5YgMoGOFmFqzOz3hIl/KXB1dQSEvaeYsDqoDMQzxf1S7Oi
         ox52JiMjk1cAfL7cp9fg5qAvfLohN5UdgYO/pGwNaRLkRitn9XRotCbR3wsiHfiUMviz
         5gHffZnwxk8PCcMZ4++el8IiF6g52TpCM433zWkXt9fA7D2aGJr5umYrqojpJSIFRzRJ
         nLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336149; x=1719940949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR9SeV4pxy+WU0xDeL//qKWcrGtBQcHjBOf0EE9S0DY=;
        b=A9BBy5aRIIBWn3miYRo4csadA2SY1RkBVprRzKcJwHXKep8TF41yHPYeLg010+VfQc
         n6FJUhgyglUKTiOB6/hjL1IRn07aVzFq6leZlCa0JlrjdSkJyvzheEbit+jvaJTPI4eO
         EdH/JhrUX4otJLFnooULAUzQxZzO5RQBkXvTeVRsbscTOMtprAtB1MaQJqKkvkpxbfHA
         4X7Qi1uGB4tLcokp5WoHFmN1qv6V8wo30hJZRPz3p1RvHeERwblgncO7VPUwmyNMYUjx
         MqMzf+6QkaDOg9CRodR6lQ0ykq/lCl4u9z7zgkNTDxj6DnVsPNegNnzd3ZXVZfAyodXZ
         j8kg==
X-Forwarded-Encrypted: i=1; AJvYcCU3lnerx2Zkn4drDeffp+GyzDtlzf/u9apixkEIQxZKuyI2NI/8Fa8ZwkIBtPoM4Yqg5N0zEc7XmojFe1TVGzVTlODcwiu6u0zHp4iK
X-Gm-Message-State: AOJu0YwkzJloTKsRjvLZ+vYe0T4bggqlfuUNxrk96lnVUT8IXKprpYoP
	GMwkBh5K027OTDXSIDPPzpVXfOMAJ4JQv2iPbMlCT47A2FJaHxlQzYWPnrn1VCASvzMtH78hB/R
	Rg2Rwotz/FkUIi2T4TNlBKoSZgYc=
X-Google-Smtp-Source: AGHT+IGIX/OWWQ3YYXQRyGoc37njyeD/BNo5C5vYns2lrJ0wN7DO8N9M9ykspRsi7Y/SeC9w7j3kUtqSDrGCWEK1sac=
X-Received: by 2002:a05:6830:310f:b0:6f9:710e:65a1 with SMTP id
 46e09a7af769-700af9b9389mr11300226a34.28.1719336149343; Tue, 25 Jun 2024
 10:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621054658.1220796-1-alexs@kernel.org> <CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com>
 <2e9ce344-e25f-41e0-8ca4-b6d80e095735@gmail.com> <CAJD7tkb=VNa6PLi_3gTvLbTFEnspmvQdScFf-CQ_KofdzXRKJQ@mail.gmail.com>
In-Reply-To: <CAJD7tkb=VNa6PLi_3gTvLbTFEnspmvQdScFf-CQ_KofdzXRKJQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 25 Jun 2024 10:22:18 -0700
Message-ID: <CAKEwX=Mo+EaaxBYcLMTHYADB4WhqC3QmWV3WQ0h2KM491FRuQA@mail.gmail.com>
Subject: Re: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Alex Shi <seakeel@gmail.com>, alexs@kernel.org, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org, 
	senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:32=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 1:11=E2=80=AFAM Alex Shi <seakeel@gmail.com> wrot=
e:
> >
> > Thanks a lot for the info and comments! It's my stupid w/o checking the=
 email list before work on it.
> > Anyway don't know if z3fold would be removed, jut left this tested patc=
hset here if someone need it.
>
> It's partially our fault for leaving z3fold knowing that it is headed
> toward deprecation/removal. FWIW, I tried to remove it or mark it as
> deprecated, but there was some resistance :/
>
Our apologies, Alex. Thank you for your contribution regardless!

Regarding zbud and z3fold, this is the second time this conversation
has come up within a week or so. Chengming was trying to revert the
multiple zpool changes. zsmalloc (after we re-introduce the class
locks) does not seem to regress (at least based on benchmarking), but
z3fold and zbud suffer. I think we are starting to pay the price of
maintaining z3fold and zbud:

1. Future improvement to related subsystems now hurts z3fold.
Developers/maintainers have to spend extra mental capacity to consider
this, and users could potentially see worse performance if they select
z3fold/zbud unknowingly.

2. Contributors are confused on where they should spend their effort
on improving.

Can we at least have a roadmap for deprecating these 2? Something
along the line of:

1. Deprecate either zbud or z3fold. We do not really need both of them.

2. Make zsmalloc independent of MMU, somehow (IIRC, compaction was one
reason right? maybe making zsmalloc compaction dependent on MMU
availability?).

3. Deprecate the remaining one - zsmalloc can be used in all deployments no=
w.

4. (Optional) Maybe adding another allocator for the edge cases that
zsmalloc does not handle well? I'd need to see numbers to be convinced
that this is the case. I think I saw somewhere that Vitaly was working
on zblock - look forward to seeing this :)


Return-Path: <linux-kernel+bounces-229698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC39172E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3C42841C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08717C7D8;
	Tue, 25 Jun 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjS/sLG0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887FD149C69
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349404; cv=none; b=D80unFB5/9YYG+K0pIu8zwUx5fXvu8hH3TPPPlYkqv/PT7l2UastzT0KKl0pLgaBQx9To9uNOWYP7YvICulk3d3lGxDy07a5MkgAPrC9UalHQvUbYJ82YuwGKdj4R1Q3B/uOPZ/jBMIY+EZbbKcExReNkvEx7fdmx9vSFmxyh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349404; c=relaxed/simple;
	bh=Pwf4UeWq+3fn9h9C9zas2MvSo4QTuCZbHtBL1S3Cgew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jopitjYxUeIr71ZWTEfSXfteKZEM+U7KSYPAmrvjHWDOKsisiXdisP1afiB3oOQ2qMWVmHVFbTxAPUOzWhr4crc/QuDtbcHpmfP9FU/6ugmyEgSjX3f8KXPBobh8/iHi2r1VsFMW3J7wAIVd7H1V310uPDIWTtqrbWasID8xFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjS/sLG0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a724598cfe3so442725466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719349401; x=1719954201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwf4UeWq+3fn9h9C9zas2MvSo4QTuCZbHtBL1S3Cgew=;
        b=UjS/sLG0VCwfWAiMlf6nRCVhtuv5F2TDuvlfw/rpmldMrUIfXoxiEYDLzRLldTN3A9
         RdwQyry3iI1mIAMAcjf05MHKErVXb0TFBiVd2MIEkFsp6AAWzZ6sR0KttUuTpsFrDVNt
         2/5voNvmItKyCv8AgI+1ZSqJ8zvYCf/XgFkUpzv7ad0NpGCPa3NTOOVBoI30IdGfFlKJ
         OFG+7TWwgqnlSI1iELfkavxTaiSkZvfLQ9rp1yonrDpE/zJj//oGXNVbBs8ToTUf7w8I
         b+LhGPHvED92uJ7bVQoxyKCm9ryenSTmBHnnx2PetZOaflAOiA7Y3ABjlMcUpMVIulzB
         w5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349401; x=1719954201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pwf4UeWq+3fn9h9C9zas2MvSo4QTuCZbHtBL1S3Cgew=;
        b=kJcxw6t6aY9u2/yWmZ55U2Gr5FKF+3QhUcCdILjVj8JmoKVfsoEojU34q8L+ZhHPDf
         YhtZ+2ICnDWiACu+27c1AogRhRmqwtoUY9IqFrp9SKzWVNK7K25nvHGOEBsSdsY/6hc9
         2BuA5jHj82DQnSguzbOq0+xZpg3lVA/Innhl6Lmj8807YZqxnDO595nN30XVXVA1ISiX
         365HROd3KYPTwBM+PVH9BjkJbLU3o4FHzPBKrwFKV58kqKGCm2b9sTOEY6+EKkNm0B0T
         LayiEAT6LjOUe/PJPzx6CvOVr2vmP+NhNoiGRYDEaYLmw4Ft7V3MvcG8M8cWdu6tZa8m
         rc8A==
X-Forwarded-Encrypted: i=1; AJvYcCX2VNhGlgLrkGrmISbCvsBc1oFsViAIMy5hsufaLx05tqdZwTNGCVjVkUtw8kZCgBDwuvkLIFKLTPGILbDjwlrgI524J4T1oUrjaPE0
X-Gm-Message-State: AOJu0Yw1ope/Gg5s4i2fZNHpFyBZfqRSiMw7De2BCvMz+H8O8psm/dj/
	9nOVZMT6MNbH0xJQnwFq4HhQuvvYdQ+dK9LwqrPNFk85VHv8X+5Bxc2WcLrrWUGJbDg7uIrbWM6
	n3YORxHgUexpPJxOp5BVQ95y+xLjyE4XRjea2
X-Google-Smtp-Source: AGHT+IGTeKrC8ZgIiwIpncDibkiaWHy08xx0tDRL6GNa6yMSkKSw8t8NL+D8QQzEgDAZVmFTH3ne656C61DFArijKME=
X-Received: by 2002:a17:906:3e53:b0:a6f:4b2a:2877 with SMTP id
 a640c23a62f3a-a7245ba3b83mr738828166b.22.1719349400245; Tue, 25 Jun 2024
 14:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621054658.1220796-1-alexs@kernel.org> <CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com>
 <2e9ce344-e25f-41e0-8ca4-b6d80e095735@gmail.com> <CAJD7tkb=VNa6PLi_3gTvLbTFEnspmvQdScFf-CQ_KofdzXRKJQ@mail.gmail.com>
 <CAKEwX=Mo+EaaxBYcLMTHYADB4WhqC3QmWV3WQ0h2KM491FRuQA@mail.gmail.com>
In-Reply-To: <CAKEwX=Mo+EaaxBYcLMTHYADB4WhqC3QmWV3WQ0h2KM491FRuQA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 14:02:44 -0700
Message-ID: <CAJD7tkbfN7hBQKEAUem2W5t9eMamO11DKTvR+DyuhPTJjs=9sg@mail.gmail.com>
Subject: Re: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool
To: Nhat Pham <nphamcs@gmail.com>
Cc: Alex Shi <seakeel@gmail.com>, alexs@kernel.org, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org, 
	senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Jun 25, 2024 at 3:32=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jun 25, 2024 at 1:11=E2=80=AFAM Alex Shi <seakeel@gmail.com> wr=
ote:
> > >
> > > Thanks a lot for the info and comments! It's my stupid w/o checking t=
he email list before work on it.
> > > Anyway don't know if z3fold would be removed, jut left this tested pa=
tchset here if someone need it.
> >
> > It's partially our fault for leaving z3fold knowing that it is headed
> > toward deprecation/removal. FWIW, I tried to remove it or mark it as
> > deprecated, but there was some resistance :/
> >
> Our apologies, Alex. Thank you for your contribution regardless!
>
> Regarding zbud and z3fold, this is the second time this conversation
> has come up within a week or so. Chengming was trying to revert the
> multiple zpool changes. zsmalloc (after we re-introduce the class
> locks) does not seem to regress (at least based on benchmarking), but
> z3fold and zbud suffer. I think we are starting to pay the price of
> maintaining z3fold and zbud:
>
> 1. Future improvement to related subsystems now hurts z3fold.
> Developers/maintainers have to spend extra mental capacity to consider
> this, and users could potentially see worse performance if they select
> z3fold/zbud unknowingly.
>
> 2. Contributors are confused on where they should spend their effort
> on improving.
>
> Can we at least have a roadmap for deprecating these 2? Something
> along the line of:

100% agreed. I think we can start with z3fold given that it doesn't
offer significant advantages over zbud in my testing, and zbud is
probably more popular since it was the default zpool for a while.

Then we should be able to remove zbud as well after we take care of
the MMU dependency in zsmalloc. After that, if no new allocators show
up in a while, we can drop the zpool abstraction entirely.

Just my 2c.


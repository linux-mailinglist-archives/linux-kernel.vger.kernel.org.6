Return-Path: <linux-kernel+bounces-430637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE89E33EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602F6284FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F6018BC20;
	Wed,  4 Dec 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/SM1mTQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9B1E522
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296428; cv=none; b=VVqt3xhvrtUd9ffNh1r2uwwtSXmwLgBz3K8p0xGVII9qahCCDuU585MnMU740xmMauWYhjonlyix5mNXMfcle2mhbZeBGq+jdK3gcScVD/o1EOZtNI17e9W6atO/JXCODehqFm5vQrfHGtMb0NFkoSU4CrffbWu3XwqB/5A9/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296428; c=relaxed/simple;
	bh=RxK6ig1QG+U8Gkee48Ihs9mYUQ0cpt0lc9NWykqma0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4xGZ26oNWTh45Qa9IA7EFdWhpOmiBqI9ugEvHdwX2/CaX/lmglbW3sobkz4m8EI/VashvSRQuP+HNv7Ds/JpHLihC1wloN7HURxEWhmGRgldP0ejDVcUW0bgNDptHPr+y890RGdeML7Zo9+UccSzUQSY8AG0sGoDobah9IDUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/SM1mTQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa549d9dffdso1019898066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 23:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733296425; x=1733901225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxK6ig1QG+U8Gkee48Ihs9mYUQ0cpt0lc9NWykqma0c=;
        b=c/SM1mTQCNi1BRG5gr2jnjn9LWceB37b/kEgyDeLgewUmNY7hcNwVsqZhQkkl1ef39
         J02QB9IIlldGV8UD0Pya8Z1MQOuQtHtch8TlT++2Fl5yHHpMNrWwuorJmFgEGNgaAwMn
         1AU+zyvAG88sRz8icTg2PFU8t7GEueHSag6j+zcQvQeKk+7yayjY3W67u1755qyGytzn
         LLPQ1+S7J8acIeUHPHsbcJyub/jO5M6h3vtcRCF12Q7nBk/1RrTbdwt5uQbl+lzZCiWu
         M3ak1vhv00ePCG2t5ln/A5nLI3KW67RC7Qt1I8Dv8wHnHCswTn0n1484HfUg0YNCTU+q
         0vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733296425; x=1733901225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxK6ig1QG+U8Gkee48Ihs9mYUQ0cpt0lc9NWykqma0c=;
        b=Y1h1I9alAS7QA4rHvoNjE6WMpWfPfNb6qpL1SoxE1OTmpy/mxD8ML7mLBPSScBIL/r
         K8RdzK6RLXg6gIonwCqG1JxCdU7Lc6HgY15iXuOrjTnf7Y0GbhlawmU2R9y0/27tz5d4
         mYKyMk1YvvtrUjGfZl8P2hrs/bqZUEP4oPyuvqZdjS+jH50laXfRPagwGQGnRM7NbFqI
         Ri9HCez9mRGwZit8Do6d9ZSNiQXKZU+hBFVqGCbDZV0o9ps1U4NV/LIV1fE+U+EOgV56
         d8uPHDsJrN7eV2Jw8ppv9fwvcWNr4yBs6+15Nx+lxwtgegNMw4vFrSNrU4fSleyEpvGd
         U2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU5iPXysI+j/E6lh+1smqVIvklMr5VVhAU3kfaD7eU9slaCRgAjGqTV7sxxtVEbWnmTazFQFJiK1ad+pew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnBzOhxIpT26QfUk5zrpni+W+fCLUeq+Pi6qsC2RTtQBqAkob
	fffAYcbnpseUgtRA1WrAqg+pXxovJiAHdNP8vlYqvG9CmcVdzmZbzEBEtgT5ewe4mHgf1aVQJd7
	mBacCfbul/vNK1haaiT3rfj2q3wMlmWIg98I9
X-Gm-Gg: ASbGncuBzR7Yp5zNCMRRS4YmKGhjzK3rRiRtTNXAgkNtzaYUemyJKNSC5HVcwKU6lxa
	+kRx+ffrwmF5lHnQAitzUuiYJgRajaj/W
X-Google-Smtp-Source: AGHT+IFATKxKfipZD99t365IMpaLI/oEJaHPn7WUhe0I6xggt9vUtHK+D1UfTTWoa0bMN20yK7uOATQvS1VqNPkyQTw=
X-Received: by 2002:a17:906:319a:b0:aa5:f288:e7e3 with SMTP id
 a640c23a62f3a-aa5f7d15684mr462806366b.15.1733296424653; Tue, 03 Dec 2024
 23:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
In-Reply-To: <Z0/O1ivIwiVVNRf0@perf>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 08:13:33 +0100
Message-ID: <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dujeong.lee@samsung.com, guo88.liu@samsung.com, yiwang.cai@samsung.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joonki.min@samsung.com, 
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:35=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.c=
om> wrote:
>
> On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > I have not seen these warnings firing. Neal, have you seen this in =
the past ?
> > >
> > > I can't recall seeing these warnings over the past 5 years or so, and
> > > (from checking our monitoring) they don't seem to be firing in our
> > > fleet recently.
> >
> > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > Could be that one of our workloads is pinned to 5.12.
> > Youngmin, what's the newest kernel you can repro this on?
> >
> Hi Jakub.
> Thank you for taking an interest in this issue.
>
> We've seen this issue since 5.15 kernel.
> Now, we can see this on 6.6 kernel which is the newest kernel we are runn=
ing.

The fact that we are processing ACK packets after the write queue has
been purged would be a serious bug.

Thus the WARN() makes sense to us.

It would be easy to build a packetdrill test. Please do so, then we
can fix the root cause.

Thank you !


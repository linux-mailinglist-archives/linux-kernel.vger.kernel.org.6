Return-Path: <linux-kernel+bounces-307817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CA965337
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA661C21F54
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E121BA891;
	Thu, 29 Aug 2024 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQfssIQ9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C51B5824
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972052; cv=none; b=FGU0rLH3jo95POADHjfp8xuhsEKqiWR6OGQtgJ1g/ISxbKsyw9bH00/bVJsG4OfdoOB9g4u/6VjTsz19ocJPd9MzM9V8e6hBNV5XAJtqy5lcSDLAiJP6d/4G8a9bkwwV7I1CJt9cCFpwlGhx3GgSAKltkrGVczKUox2zmacTPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972052; c=relaxed/simple;
	bh=nVnhVzWYQHtGHoruFFT/Mwn1FzMrGxJJQ7+rGWuMUoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jV6Pe3uT19Zor1zTSTFzHn4NDG6A4Dz5n6QRxlMMxJJvYTm2oXQQV+vFVvwSYcHXpsT/3fDjPD+RrUUqJU5gXgzE/jf/MNkwAoCRe6Se9ahnumQfIyDX9XA7dJMLfWbkyPzUD84LfLI7dU0bLYR891cMaINRAhi9xH0ObDHlS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQfssIQ9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so3908735e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724972049; x=1725576849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT/N7885nHKfty/eDWE+p2zE6nTWtJgYs5jLN0H8wTs=;
        b=dQfssIQ9MBewrlFYWcVcJcqqLpiKH7h5eKoI6J/jQgicb8Xe6bvzOSutkQKLbVAyIb
         QbAH0+4biBrItCmWfEnGbKwhCpQ2J9x1EHp+M4fit9i7chThqllImFpn8Z9c3RSeIXnl
         H6UMGiHbfyEe9pL6ZviuMNQMuVJFvbqXvU3j7P7vbzVsf9depsji3YSPlY4XozjqOfS6
         2Etv4t6U4ZjflUGAe3lVqAAC3Z9+01rS/eBGWI87ealrVn3CnAo5/CF3s8Z0MdubuL91
         IiDimgEUEsryE6tPmabzDh9OdRvV9jUYr1jfaCS/JmXUkqj5YNhddlhKg0MvHz9VDy1e
         cRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724972049; x=1725576849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT/N7885nHKfty/eDWE+p2zE6nTWtJgYs5jLN0H8wTs=;
        b=pYSTSZHya359ZQAj03FZElonbNmt+zQ25V5I1T++lmUQPRkiHyyiSNGxex3Er9oIdn
         swfudkDzKe8ByPHGabHoKwduD/9QuP5ZP1wTBvyTS3w6tlNkMdc5WyG4JaqnPH75KvMd
         fbcpR/zZh3DaVgNMzKHg+iVdk1JySL0Ay9B60Awh9DDKLTEWcyKKPO63PnaBO3wO21eR
         vGIetIhrzNxZlK+FYnU1O4h67rRg0CvNPKAdZVEeMsAKCWwDklROgpdabUrwhw33gVQI
         T3PXPiesfvHYBdBT7NLZv/bqn6RR0Wx77TRwDLMtkbMjohBd7Aiiz1koWp2ermlCX+n+
         /kTA==
X-Forwarded-Encrypted: i=1; AJvYcCWuXu80blyG/G4HDDr6wno8gAkHl5YjCBO3MnxAnww5g8VzxdfwH1QnJ7COY6ECJwP7JOZrZS+Y9nfnmS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUl1qK48ZeL69GdvnlLAdVyCHIJuvKUePimaU0DXv33jfZxypO
	VMzqdg+STIj5VIZbvyTMhe7Y6fACQNte1fSCuLzpHlBQ2aSvR9DkDHumZivYlN34saOspQbq1/6
	PKHezAH8BcUlklgGGJCOBMNRbzMqPHCw1SIbj
X-Google-Smtp-Source: AGHT+IGhqfbnmkqeuTCD7bZKUdym4y9AL8tm7CgZ4nVvzkL1/icn0ir93wqM4ghcuzeFcJOcDO9xHxShdQCRi0L0i5k=
X-Received: by 2002:adf:f58e:0:b0:371:a844:d32c with SMTP id
 ffacd0b85a97d-3749b57c4f1mr2996255f8f.39.1724972048738; Thu, 29 Aug 2024
 15:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org> <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com> <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com> <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
 <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com> <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
 <ZtD2McWko3uobU-B@casper.infradead.org>
In-Reply-To: <ZtD2McWko3uobU-B@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 15:53:32 -0700
Message-ID: <CAJD7tkYJ9KNQkpPxWQpGj0SnofSq5-mLzDnChCqTtJPGrhzY-A@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Matthew Wilcox <willy@infradead.org>
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:29=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Aug 29, 2024 at 02:54:25PM -0700, Yosry Ahmed wrote:
> > Looking at the zswap commits between 6.8 and 6.9, ignoring cleanups
> > and seemingly irrelevant patches (e.g. swapoff fixups), I think the
> > some likely candidates could be the following, but this is not really
> > based on any scientific methodology:
> >
> > 44c7c734a5132 mm/zswap: split zswap rb-tree
> > c2e2ba770200b mm/zswap: only support zswap_exclusive_loads_enabled
> > a230c20e63efe mm/zswap: zswap entry doesn't need refcount anymore
> > 8409a385a6b41 mm/zswap: improve with alloc_workqueue() call
> > 0827a1fb143fa mm/zswap: invalidate zswap entry when swap entry free
> >
> > I also noticed that you are using z3fold as the zpool. Is the problem
> > reproducible with zsmalloc? I wouldn't be surprised if there's a
> > z3fold bug somewhere.
>
> You're assuming that it's a zswap/zsmalloc/... bug.  If it's a random
> scribble, as suggested by Takero Funaki:
>
> https://lore.kernel.org/linux-mm/CAPpoddere2g=3DkkMzrxuJ1KCG=3D0Hg1-1v=3D=
ppg4dON9wK=3DpKq2uQ@mail.gmail.com/
>
> then focusing on zswap will not be fruitful.

IIUC that was for the initial bug report. Piotr reported a different
problem for v6.9 in the same thread, a soft lockup. They look
unrelated to me. Also the patch that Takero found through bisection
landed in v6.10, so it cannot be the cause of the soft lockups.

Piotr never confirmed if reverting patch Takero found fixes the
initial problem on v6.10 though, that would be useful.


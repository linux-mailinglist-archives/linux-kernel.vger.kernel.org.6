Return-Path: <linux-kernel+bounces-287734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B046952C07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087391F2477C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54D1C0DF8;
	Thu, 15 Aug 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AhsnWQx"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A181C0DD7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713647; cv=none; b=hbDt5+h3tcTgdWO2nUCPdySQtNRZLHeKSak4+GTdoXV4Ak5NPmYSMZlyYC9Zi4Ohc9D9vniCpWozmLdjjHez//oNTaqJYX6f3rk7b2210OD2TB4GxhaXUZvARI2alc/25LGnaXMwt5oV8fEM2728HY7qhTh4G2Zy6hbzpWRzjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713647; c=relaxed/simple;
	bh=2V+ccwDmx8bCw7FigTZcAqa0RATuPqPVxRdszXcI/Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOFwECAk/Cid2wHtfq0dNTpmPN3ys0vfsRdm+e90Xv+1+KSqe0XO+Bsq452S0IK/pU7/gd+CF9HUPHAjzsIGebPA2Ji1VhoYxrLWCJLsHIb00wDfDKKWkqpRCC567MuuxPoGnQMGJRWF+XO4mBsO9x+XMmiGeW57ndVp9Z5yCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AhsnWQx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281c164408so4217215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723713644; x=1724318444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80zm8jzgImQ04ZpZHXIv+bJT/2HKQyCzED5vbg8c5F4=;
        b=3AhsnWQxUjbNIK1m03YHYyOgTFJ/YtRuFKq2G1YYJW6UtadLvG2sp4spFInvSJZx1x
         yLwHUUhMjtk3gk3jFplkzTiSlYajcdEetVZGCNqV+MSDr5kYI1DT63P/m5oSJks3PIYK
         dBo/U/GhG6YtWWvnQbqVOljUudmS50Jgm2zu5CZPyRIzXlNSCgrRGDbTz1rw1qbW8nL7
         BqI4zp7uBxnz/0EEcs6PD5LbXfiFLfAuPGRkNR1sT1vMsrIZA4bmHOMek4Evy4DOA1DR
         09o5qLvTYht/rMiSKLRhOjCohoaY/ITenagu/OQX72yzACqFRvVjyUZYXG0/bxXecXw6
         eoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713644; x=1724318444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80zm8jzgImQ04ZpZHXIv+bJT/2HKQyCzED5vbg8c5F4=;
        b=Asf63Gh1XsqrnaaatfQNyZgE7KYEDpBGM/rXNpMAjUgxshjPU38a3NC/GX/912rGTi
         9ABCwBng3Znyd9VC53U01OsLCMoTDuRZpDufWHm0MmNvyhVV/tPFyUAxP5kIQd/nIJ29
         ktUDJdM2DeSrwM/HJ7Gq/5pACritfKwoNO1nB9IVCB7UtNMXjznPwCQrObplpFLaAWCa
         VkbHcmYDjRRx0DoEJ6iuvwnndAGS40XJfg3wY6/FReoCxd5/5dU7jroPkDdkwXvxsCSo
         eY++R3RG6BuoIslQuDVbANmzW72eQE+cD1YuAbCL1WcaNSgY/aotsapkgO2mhRGad8ki
         109Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJl7f2ajAeN8gFcBFdrYbqDCdZcJ+0qUS8AIVkSWHWvKdIlfs7NOrF3ToM5B98NXLSTQXNt56jvZ43JH3ofp59cSn2AJxYAJylKzK9
X-Gm-Message-State: AOJu0YyjkbfP1XBd5Pkjvm9hMTM4YxvfaWzxbLKqMniCROnxcshjfWEt
	HovKCf2myFoRKx/UNuoAtQ+3p/B72Pq7VZO/RRUL1QP/AQM/Csp3cr4nVPNMk5HRFhCoUapq/5s
	htUECExYCSYG40cYwEt6znXeQCP2JaOChy5O/
X-Google-Smtp-Source: AGHT+IH7lkn/aRzWqScZW92BYvziPxjfQGa2Ww0aXoS67wvigoKomhvmcMOLmj0n1Ikrp2fMRD48McZ45QoGO5RKsGU=
X-Received: by 2002:a05:600c:3542:b0:426:5269:1a50 with SMTP id
 5b1f17b1804b1-429dd2364bamr32348045e9.11.1723713643657; Thu, 15 Aug 2024
 02:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <Zr0GP0OXliPRqx4C@boqun-archlinux>
 <Zr1teqjuOHeeFO4Z@cassiopeiae>
In-Reply-To: <Zr1teqjuOHeeFO4Z@cassiopeiae>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 15 Aug 2024 11:20:32 +0200
Message-ID: <CAH5fLgjvuE5uU00u4y+HyHTkQU_OBYvHe6NS5ohAhrLntTX1zQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
To: Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:52=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
> > Hi Danilo,
> >
> > I'm trying to put your series on rust-dev, but I hit a few conflicts du=
e
> > to the conflict with `Box::drop_contents`, which has been in rust-dev
> > for a while. And the conflict is not that trivial for me to resolve.
> > So just a head-up, that's a requirement for me to put it on rust-dev fo=
r
> > more tests from my end ;-)
>
> I rebased everything and you can fetch them from [1].
>
> I resolved the following conflicts:
>
>   - for `Box`, implement
>     - `drop_contents`
>     - `manually_drop_contents` [2]

Not sure I like this name. It sounds like something that runs the
destructor, but it does the exact opposite.

>     - ``move_out` [2]
>     - `BorrowedMut` for `ForeignOwnable` for `Box<T, A>` and `Pin<Box<T, =
A>>`
>     - `InPlaceWrite` and updated `InPlaceInit`
>   - for `RBTreeNode`, make use of `Box::move_out` to replace the original
>     implementation partially moving out of `Box`
>
> @Alice: Please have a look at the changes for `RBTreeNode`. Maybe it's al=
so
> worth having them in a separate patch.

RBTree changes LGTM.

Alice


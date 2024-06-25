Return-Path: <linux-kernel+bounces-228233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127EB915D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5562832DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0048781;
	Tue, 25 Jun 2024 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSn1R8Jf"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981943AB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284476; cv=none; b=ObYq6q2ZsHfLFjKPdrX1doJ1Cjx0FnVqV+XqYBRgRZvRaWQoEcR2gbu7O1ATqbo9FAjEXUda5rKC35khdInZ1qwG+hJC3g5L2k+c+1d3duq2PLULE17R0auj69eCD5Z+tbLEnU8mUJ/qZU/9frNtL6Fx0fsHTS+/MJoVaC6cjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284476; c=relaxed/simple;
	bh=bnnC/dqrjS4foui7kpRH2jpknYshPmEp6/ETawt0H+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVUseI+1hgdqrKNpWuMhRJnirRiMs7+gOcf3fhfarmGfok1iMge7VrucF6tRyb+EAy9mc0JneVb68HU7ORoUCWjPTH8Rqe/e6ivdPsYpMLo6Ts2gEzhiBdcsTUVfPUxVC/YzdhzGIpIQ5heuhG+BmNs2J73W++mT7h4Jqx5sT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSn1R8Jf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa4b332645so61845ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719284474; x=1719889274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTjGlVJ1RY73P+Mt+ZETqoUU/1f9b8tlU+jZHRFte7U=;
        b=rSn1R8JfEYRy8OF18qFxAw/9BdC3wJv6crU7u/eNj2GhhrWHS4NFHfWBz3p+IKguoJ
         yMk/FfPNmPYoryaMJVWEcmnsLhTTRKmkQj4dUN/mskCg4/ZaNuBZB7gHgrjQE7AdLM60
         R2TLHodM/1xhDC8H5xmSZiRlwCcuWYj7Cr6+gcxV5eCVHLBBLZxtgi1cvm8DYDMWDmpE
         ys1deGFvNW5i1Fmqn1w2aZ/q2pM5hAzNzZRqsAhHGV+Nc1+ZtqhcZj9hyz1RfGzaao0+
         kuWdy5fEAl57H8XJvAmfPAjDmIf9uiFlQUR7TaAjEwNEu88JHtfmYcbqW5dcQe1O662f
         o1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719284474; x=1719889274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTjGlVJ1RY73P+Mt+ZETqoUU/1f9b8tlU+jZHRFte7U=;
        b=qdYXu9sVhmsWjEm5SSfJ7bYZao1jFuzH+OFmweQb+11eeAYn0RdE+0dxIPJeaMRLB+
         Jase3qTvvfMkIJr7gyBOl1cCemlxNZ1VZSdf1TMlqN6PVUBVFZ05t3/l1DO53cKUMdjK
         zMW1dCEIW3D22YBt7JaBrck7DKf1NDTfw/VLWBD5WEMEYAXWNU3aIs0LNnN7zGoemcC4
         ox7Lb0V7DtmYt7Xh0OfFaMzMZQSIDN/oGXVR+NvnAI4pykcTj399zACD/e/2qvvHKtsi
         U9RRDIHuXS65EyPOKmmCQssFxmv6ORmuG/2YGjjN8nL7NUb6XXQzYjbwV+bfS0BBrfzc
         t45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWXVFrzUAjDF46GeLUlfPFuVVlsojTZQbvI3ypNq1xmO1CPSrxqaJ5caH+wK276VN3wmNTGis+Aq8pJXQ5iazBzF6QOaCuq+xr3DvA
X-Gm-Message-State: AOJu0Yz8z2+GfWGuGIsSBDHvYtZERbODmqowNRJtRmWYcUEynuG0F568
	ap4hjt/AkM3yz46RSs9UfKeG0n9nnHDwtrw8ea9LHfz533O5edLDccuw1i5/YhLl1nKvH/SQjl8
	UFqCAFc+HQvXt1xymASBlMZqQywJ26HpZ2DgA
X-Google-Smtp-Source: AGHT+IG9m9BVMYcaMNGS7ztr/o3XHCakZCxiZueHNFuAs779MmAohr1PJ1QYoaUOEda25/VUT+0mAhvoVK0sF9xn49Y=
X-Received: by 2002:a17:902:8bc8:b0:1f3:2b46:47ce with SMTP id
 d9443c01a7336-1fa6ca7467dmr1134555ad.15.1719284473733; Mon, 24 Jun 2024
 20:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
 <20240624172031.407921-3-yutingtseng@google.com>
In-Reply-To: <20240624172031.407921-3-yutingtseng@google.com>
From: Yu-Ting Tseng <yutingtseng@google.com>
Date: Mon, 24 Jun 2024 20:01:02 -0700
Message-ID: <CAN5Drs0i7KZHXnrhHRT-KrLs5ZAYGOpixHk-CU=Ah+ycqxkwOQ@mail.gmail.com>
Subject: Re: [PATCH v3] binder: frozen notification
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:22=E2=80=AFAM Yu-Ting Tseng <yutingtseng@google.=
com> wrote:
>
> Yu-Ting Tseng (1):
>   binder: frozen notification
>
>  drivers/android/binder.c            | 300 +++++++++++++++++++++++++++-
>  drivers/android/binder_internal.h   |  23 ++-
>  include/uapi/linux/android/binder.h |  35 ++++
>  3 files changed, 354 insertions(+), 4 deletions(-)
>
> > freeze was allocated with kzalloc(), you could drop the "=3D false".
> Done.
>
> > If !node->proc then process is dead. Do we really need to continue?
> Update the code to return an error early if the process is already dead.
>
> > This access to node->proc->* doesn't seem safe
> Added locking.
>
> > Why do we queue this notification?
> Yes, this is to get the current state back to userspace. The userspace AP=
I delivers an initial event for the current state upon a listener registrat=
ion, which makes it easier to track what the latest state is.
>
> > I'm looking at the death notification code and it seems it only queues =
a
> BR_ERROR after failing to allocate a "death" and that other errors are
> silently ignored?
> Sure. Please let me know if you think we need a change here.
>
> > these could be just bitfields.
> Done
>
> > freeze->work.type =3D BINDER_WORK_CLEAR_DEATH_NOTIFICATION
> Fixed. Working on a userspace test. Will post a link when it's ready.
New test now included in the aosp patch:
https://android-review.googlesource.com/c/platform/frameworks/native/+/3070=
045/6/libs/binder/tests/binderDriverInterfaceTest.cpp
>
> base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
> --
> 2.45.2.741.gdbec12cfda-goog
>


Return-Path: <linux-kernel+bounces-337648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF55984CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952941F2475D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13F13BAE7;
	Tue, 24 Sep 2024 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5KEoaDo"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D684037
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213462; cv=none; b=iGEh/EhOZcHgYd6cAwYAr8nGF2zzAH9sm4UxtEpa4CQVOnb7g3Oeyerq8m1ogpjH3u+j+9TUxXQjP6Fq/JHcxOs/yRHhd5dUI9aRytGFo5xCL2KkquJgeYbtrDZwq3q/9+VGsdwzDtRlwk4nAVbZVqrqRwqAYaw/tLa8UGY2oOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213462; c=relaxed/simple;
	bh=ZQKNKb0iBXLGH+nveuSjQZZsi1vfHACJKY7mCEc7wsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFtd/CoF4F5nKuB+5T9bVQPxtvZ4cfYNIfxOk3qJhRUcGmp5yuihMFoHuSib3FUF6rPB2FjBWpuAX2xj1nJfKYYX9/4SWrTDBTws2wW2SONu4hUQaSitKlO4UQXv6VMiXhAsOYvxv2Mh/CJWOLz/IpLYAjcIB7MQLXPwo/yaur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5KEoaDo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d56155f51so722892766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727213458; x=1727818258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK3FQYwyep1LbEvPzyg9rqOUpH5U4QQ1vXKngoT9gv0=;
        b=d5KEoaDoFTleA/LC7t7Ciu5DJDSYwbtnOwBoIs6Ai4Z5lrWjxRAM3AfiRNKoK5fv9+
         bozSmmlZOm/NLeMT0Mz7YQJ0sxE9TcD5In6unzxbvPkOsL32xk+Ivx6XGy9mkWJe3UKE
         C0ybRdsN2NW0embS6cIBjzISb1NCzmxdSzJ/04URqBeE1quU54EovcjqxilgEf78Wn1t
         X1JlqJAEn09sPmlTGFkZjy9j3MjvaLGxhGtSlIDt8iAfES0bub2dJj5TJ5i6AJtFY0Lo
         hxMrmFPFpShjCqSkKaTOuGK4RvJTQjQYrWxYMbAV4LJyTCkTl03vLqcwDj1wlQM7RM4I
         wUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727213458; x=1727818258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK3FQYwyep1LbEvPzyg9rqOUpH5U4QQ1vXKngoT9gv0=;
        b=U4s+DMCo0W5wXgVoVf5uXyzDykLO58t46Dd4yIeRonfHJJxIFq9gphROzfPNhMCn0X
         49HpG+5KHgDkoVETf6TINgHXqsMjmhpKzkWDWSpMPd7f6SwHxCmcZ8bxkwHg/s46mPOr
         15DM4Ny9SKiSKNvm6u0IuRNbRzoKdIRDLXUd34tUKLajnPNXdnSIpxljXXWKjA2uOfFs
         e07fgmPUlxbLu0ZXmikeNbJTAHaWqAnT/VMRrmnmj4ISvJSQLJFWqv6tdsHcsFF23Wmw
         /2pjF9Xx1PrxIsVrG7pX+hjQygiywHkKtRcjCg7olcAbwC5EWysOJ8pxhx9mg5QWys9k
         DgFA==
X-Forwarded-Encrypted: i=1; AJvYcCX/UE8PHbtY438dHg7FmLbAfBAnZ69IWT+hCvyYTQc+HXUUIiumdR2xTBMsnuSp011ph3w4RXMnFDcLRrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7dLLeNXxzKwnEUCQaGT/KpX5NJ7fXzjJap27JQVbQ7RGG/otC
	U2w3ciSFRxKlgbkAqncQYoGxcDfqNnwluKrwr/1YRk0+Vyb1zM1AZo8PYt0LRl8UZiDZtrm+WuZ
	2T3+Qp32Ru9zVI2tvwO4zv7RP0UVBL5TxeqVZ
X-Google-Smtp-Source: AGHT+IGkAGFefNv9T8DJPD71R6ZGJ7RNDS6uicSXaTq/T0ESxfN682KR98fwDB1GyCr24aT82UTh1lnu3J4nP/TE11o=
X-Received: by 2002:a17:907:948f:b0:a8d:75ab:17ca with SMTP id
 a640c23a62f3a-a93a03f49femr46462966b.31.1727213458244; Tue, 24 Sep 2024
 14:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <CACePvbV+iaqKGGy46xa3CJQvKsay_aw3w4nqs6rESW6Cu8T-Lg@mail.gmail.com>
In-Reply-To: <CACePvbV+iaqKGGy46xa3CJQvKsay_aw3w4nqs6rESW6Cu8T-Lg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 14:30:20 -0700
Message-ID: <CAJD7tkYntg_9qzWK3D84WU0ErEvDZDnsZ6wmg+je6VbX5EwNEw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Chris Li <chrisl@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 1:16=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Nhat,
>
> On Mon, Sep 23, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > The SWAP_MAP_SHMEM state was originally introduced in the commit
> > aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine i=
f a
> > swap entry belongs to shmem during swapoff.
> >
> > However, swapoff has since been rewritten drastically in the commit
> > b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
> > having swap count =3D=3D SWAP_MAP_SHMEM value is basically the same as =
having
> > swap count =3D=3D 1, and swap_shmem_alloc() behaves analogously to
> > swap_duplicate()
> >
> > This RFC proposes the removal of this state and the associated helper t=
o
> > simplify the state machine (both mentally and code-wise). We will also
> > have an extra state/special value that can be repurposed (for swap entr=
ies
> > that never gets re-duplicated).
>
> Please help me understand. After having this patch, the shmem swap
> entry will also use the swap continue as the only way to count shmem
> swap entries, am I missing something?
>
> That seems to have some performance hit for the shmem. Because unlike
> anonymous memory, The shmem can easily have a very high swap count.
> I would expect there to be some performance hit for the high share
> swap count usage case.
> Do you have any test number on high shared swap count usage that says
> it is negligible to remove it?

Shmem only calls swap_duplicate() once in shmem_writepage() when we
add the swap entry to the page cache. We do not increment the swap
count once for each user like anon memory. IOW, the page cache is the
only user of the shmem swap entry, so when we remove SWAP_MAP_SHMEM
the swap count of shmem pages will either be 0 or 1 (disregarding
SWAP_HAS_CACHE). So the swap continuation code is not used here.

>
> Also if you remove the  in the SWAP_MAP_SHMEM, wouldn't you need
> remove the counter in the shmem as well. Because the shmem counter is
> no longer connected to the swap count any more.

Not sure what you mean here.

>
> Huge, do you have any feedback on this change?

Hugh*

>
> Chris


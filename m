Return-Path: <linux-kernel+bounces-403412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865189C355D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F06A281F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC5C23CB;
	Mon, 11 Nov 2024 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcxrxXVu"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CF191;
	Mon, 11 Nov 2024 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731284080; cv=none; b=H4dV47rBJ1W83hCvAqJ7UMH4Xp/g0NtiiTF42IAI/1rv/noTmSPLZDy12RIeUP9xJwuBvrqfGTAqchMUw8ELEoLHCL2+36GcEXlmI8fNDKmCV2XXPoJ/o/9xpFUV4GE2dtTEKNDqVDo49dTTvyLNvBUAqmtrzGQl8jcdqyDTCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731284080; c=relaxed/simple;
	bh=FA0pHzI3a8QeIv6vuBQBF1Hk+P9sd8MLIZx2+Wu0gxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2VbWyaPHMJe2iPeM88A51zqBzSDop9yJikIPd4I+e++SrFacqMlpmRJ6HPd7xlxI96fo3BDl5OxlnfIKScZpAOMP749Cw3N4RO0mnYe4scn1J/AqXRYZK6CcSiU7WaNDqVqmWq2FRv1QhzThn3kAwYG0pP0Hzoxz+9SNbxA9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcxrxXVu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea535890e0so480189a12.2;
        Sun, 10 Nov 2024 16:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731284079; x=1731888879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVPcuA1Lb3NU3EYzVk9FmDWDAJC/EXe09zYXMxVhIgI=;
        b=HcxrxXVuibtJZ/BojzAZsH2W0Pc8XmEZditQpXfwp7ty2USwcVIRiqQ+thtXXrtSwG
         pr3+hhGiJNj2QbISBO241xNC1O5ssSo3sQozXabpJO/Evnxq/ZUILM5vj8dQcF/iltR6
         18qi8rWJMFOIpdQexS/RJXB5+9Q1VG4jv+rv7cvJBtu4ZjCDwZyQuHV/DapbCI9fwish
         8AobOHiFZDwGe/4f5IUpB3RVD7zGomoOgmJaNCVZV1zX96T0Q1cUdtrUf4UPhz2anlJf
         n1QTt+iFVeE7muz9X0EYQIcRBu/cJ5ufdIjrR4MZ5J+XvfdrYH6c32OvRsRuKJc0fAio
         CGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731284079; x=1731888879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVPcuA1Lb3NU3EYzVk9FmDWDAJC/EXe09zYXMxVhIgI=;
        b=V2jXjTXP0zUbBx4nQPqzvODIFgCZEQzyVowGj1dkGTg7pcRx9awBxV6Z8t06ukvWDP
         /3dN0ORGwXPF6oD1MVWcsQfW0JuJazGnGRN8jdzP1rRVPgpjm1bwIUszo32VeQE7OsGN
         vOlWChfuKMq0FSp6mh6Q/16884SbH56v80FEHNBYLsSwYHn5ShjrYPdX4D/bLWQOs1iW
         kmO9DUNJXUl1/iRMlaoyJarMK652+KdcfNRd1fy6uwpHhtrlUo6orzcPxfm3aUPO+ZCF
         +AAzKMNz6eNhV8+anu23VeKdro0lf4kWv3pmM5fjOScS3WtjaCT6+COEYiGh9d+tZxli
         ejmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoQy/3qVyZOPJVJ38D/zYnTYE4McvHeyp21j3VHuxVRiDUsPfUqoJlh6dkbsD5/+YqU6qlTz+isOOM2BL38+w=@vger.kernel.org, AJvYcCW594DcRmKdHEFaBRw6Ry6CqLlphDf/p8K91HlTaILXpUy3PxgIGX9/bW2N0Pz04F34+T8aDXj589P6ZNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzddZ+rA42OwK6c0bkEeeDk/B4l9BBcYmhdsVNCrO0JfO2SrFxd
	6yX+UTdtQH0vHvuEkzRMDCnYzLB+wcYgz4Tvafq6E/nighQFyjmHKObIoS0ndozo25yeUkvQ5r7
	I09XJ4hczZeL6qrevCfwywal9z/2vyB2W
X-Google-Smtp-Source: AGHT+IHePB739lHbLv8UjuySPc+C2rUJcPYwQtwi8rXMEfOhNfQzrkMc8XqAneH+3Sft+Vr02k4yMCzRZICT191OOR0=
X-Received: by 2002:a17:902:da8f:b0:20c:f281:fbf0 with SMTP id
 d9443c01a7336-2118352b5b5mr60427945ad.8.1731284078657; Sun, 10 Nov 2024
 16:14:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-static-mutex-v6-1-d7efdadcc84f@google.com>
In-Reply-To: <20241023-static-mutex-v6-1-d7efdadcc84f@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 11 Nov 2024 01:14:25 +0100
Message-ID: <CANiq72mYmowikom+AwdhSABKnx9iGDTpcE9Tizvq65QVXj7_Hw@mail.gmail.com>
Subject: Re: [PATCH v6] rust: add global lock support
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 3:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Add support for creating global variables that are wrapped in a mutex or
> spinlock.
>
> The implementation here is intended to replace the global mutex
> workaround found in the Rust Binder RFC [1]. In both cases, the global
> lock must be initialized before first use. The macro is unsafe to use
> for the same reason.
>
> The separate initialization step is required because it is tricky to
> access the value of __ARCH_SPIN_LOCK_UNLOCKED from Rust. Doing so will
> require changes to the C side. That change will happen as a follow-up to
> this patch.
>
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08=
ba9197f637@google.com/#Z31drivers:android:context.rs [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

    [ Simplified a few intra-doc links. Formatted a few comments. Reworded
      title. - Miguel ]

Cheers,
Miguel

